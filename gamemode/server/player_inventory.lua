local playa = FindMetaTable("Player")

function CalculateWeight(ply)
local totalweight = 0
	for k, v in pairs(ply.Inventory) do
		if !ItemsList[k] then ErrorNoHalt( "CalculateWeight error on "..ply:Nick()..", they must have a corrupt inventory file or something" ) continue end	
		local ref = ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
return totalweight
end

function CalculateMaxWeight(ply)
local armorstr = ply:GetNWString("ArmorType") or "none"
local armortype = ItemsList[armorstr]
local maxweight = 0
if ply:GetNWString("ArmorType") == "none" then
	if tonumber(ply.Prestige) >= 10 then
		maxweight = 42.4 + ((ply.StatStrength or 0) * 1.53)
	elseif tonumber(ply.Prestige) >= 3 then
		maxweight = 39.4 + ((ply.StatStrength or 0) * 1.53)
	else
		maxweight = 37.4 + ((ply.StatStrength or 0) * 1.53)
	end
else
	local additionalcarryweight = armortype["ArmorStats"]["carryweight"]
	if tonumber(ply.Prestige) >= 10 then
		maxweight = 42.4 + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
	elseif tonumber(ply.Prestige) >= 3 then
		maxweight = 39.4 + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
	else
		maxweight = 37.4 + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
	end
end
return maxweight
end

function SendInventory( ply )
FullyUpdatePlayer( ply )
timer.Simple( 1, function() if !ply:IsValid() then return end SendVault( ply ) end)
end
concommand.Add("refresh_inventory", SendInventory)



function LoadPlayerInventory( ply )
if !ply:IsValid() or !ply:IsPlayer() then Error( "After the end: tried to load a player inventory file that doesn't exist!" ) return end

ply.Inventory = {}

local LoadedData
if Config[ "FileSystem" ] == "Legacy" then

	if (file.Exists( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" )) .. "/inventory.txt", "DATA" )) then
		LoadedData = file.Read( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/inventory.txt"), "DATA" )
	end
elseif Config[ "FileSystem" ] == "PData" then
		LoadedData = ply:GetPData( "ate_playerinventory" )
else
	print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
end

	if LoadedData then 
		local formatted = util.JSONToTable( LoadedData )
		ply.Inventory = formatted
	else
		ply.Inventory = table.Copy( Config[ "RookieGear" ] )
	end

	timer.Simple( 1, function() SendInventory(ply) end )


end


function SavePlayerInventory( ply )
local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
if AllowSave != 1 and tea_server_dbsaving:GetInt() < 1 then return end
if !ply:IsValid() then return end

if Config[ "FileSystem" ] == "Legacy" then
	local data = util.TableToJSON(ply.Inventory)
	file.Write( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" )) .. "/inventory.txt", data )
elseif Config[ "FileSystem" ] == "PData" then
	local formatted = util.TableToJSON( ply.Inventory )
	ply:SetPData( "ate_playerinventory", formatted )
else
	print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
end
	print("✓ ".. ply:Nick() .." inventory saved into database")
end

function SaveTimer()
	local i = 0
	for k, ply in pairs( player.GetAll() ) do
		if ply:IsValid() then
		i = i + 1
		timer.Simple( i * 0.5, function()
			if !ply:IsValid() then return end
			SavePlayer( ply )
			SavePlayerInventory( ply )
			SavePlayerVault( ply )
		end)

		end
	end
end
timer.Create( "SaveTimer", 120, 0, SaveTimer )


function SystemGiveItem( ply, str, qty )

if !ply:IsValid() or !ply:IsPlayer() then return end
if !ItemsList[str] or !ply.Inventory then return end
qty = tonumber(qty) or 1

local item = ItemsList[str]
if ((CalculateWeight(ply) + item["Weight"]) > (CalculateMaxWeight(ply))) then SendChat(ply, "You don't have any inventory space left for this item!") return false end -- dont need to pester them with notifications from a system function, just return false

	if ply.Inventory[str] then
		ply.Inventory[str] = ply.Inventory[str] + qty
	else 
		ply.Inventory[str] = qty
	end

end

function SystemRemoveItem( ply, str, strip )
if !ply:IsValid() or !ply:IsPlayer() then return end
if !ItemsList[str] or !ply.Inventory then return end

strip = tobool(strip) or false
if !ply:IsValid() then return end
if !ItemsList[str] then return end
if !ply.Inventory[str] then return end

if strip then
ply:StripWeapon(str)
end
ply.Inventory[str] = ply.Inventory[str] - 1
if ply.Inventory[str] < 1 then ply.Inventory[str] = nil end

end



net.Receive( "UseItem", function( length, client ) -- this function also handles item dropping
local item = net.ReadString()
local action = net.ReadBool()
local ftoggle
if !action then ftoggle = "DropFunc" else ftoggle = "UseFunc" end


if !client.CanUseItem then return false end -- cancel the function if they are spamming net messages
if !ItemsList[item] then SendChat(client, "ERROR: You tried to use an item that doesn't exist!") return false end -- if the item doenst exist

local ref = ItemsList[item]

if client.Inventory[item] then
	if client.Inventory[item] > 0 then

		local func = ref[ftoggle](client)

		if func == true then
			SystemRemoveItem( client, item, false ) -- leave this as false otherwise grenades are unusable
			client.CanUseItem = false
			timer.Simple(0., function() if client:IsValid() then client.CanUseItem = true end end)
		end
	SendInventory(client)
	else
	SendChat(client, "You don't have one of those!")
	end
else
SendChat(client, "You don't have one of those!")
end

end)


----------------------------------------------------------buy shit----------------------------------------------------------------------------


net.Receive( "BuyItem", function( length, client )
local str = net.ReadString()
if client:IsValid() and client:Alive() and client:IsPvPGuarded() then -- if they aren't pvp guarded then they aren't near a trader and are therefore trying to hack
client:BuyItem( str )
end
end)


function playa:BuyItem( str )
--if !client.CanBuy then SendChat(client, "Hey calm down there bud, don't rush the system") return false end -- cancel the function if they are spamming net messages
if !ItemsList[str] then SendChat(self, "ERROR: this item does not exist on the server!") return end -- if the item doenst exist

local item = ItemsList[str]

local stockcheck = ItemsList[str]["Supply"]
if stockcheck == -1 then SendChat(self, "Bruh, did you just try to buy stuff that trader doesn't even sell? You should play the gamemode like it was meant to be played.") return end -- people may try to hack and send faked netmessages to buy stuff the trader isnt meant to sell

local cash = tonumber(self.Money)

if (cash < (item["Cost"] * (1 - (self.StatBarter * 0.015)))) then SendChat(self, "You cannot afford that!") return false end
if ((CalculateWeight(self) + item["Weight"]) > CalculateMaxWeight(self)) then SendChat(self, "You do not have enough space for that!") return false end


SystemGiveItem( self, str )


self.Money = math.floor(self.Money - (item["Cost"] * (1 - (self.StatBarter * 0.015)))) -- reduce buy cost by 1.5% per barter level
SendInventory(self)
self:EmitSound("items/ammopickup.wav", 100, 100)

net.Start("UpdatePeriodicStats")
net.WriteFloat( self.Level )
net.WriteFloat( self.Prestige )
net.WriteFloat( self.Money )
net.WriteFloat( self.XP )
net.WriteFloat( self.StatPoints )
net.WriteFloat( self.Bounty )
net.Send( self )

end


----------------------------------------------------------sell shit----------------------------------------------------------------------------


net.Receive( "SellItem", function( length, client )
local str = net.ReadString()

if !ItemsList[str] then SendChat(client, "ERROR: this item does not exist on the server!") return false end -- if the item doenst exist
if timer.Exists("Isplyequippingarmor"..client:UniqueID().."_"..str) then SystemMessage(client, "Bruh, did you try to sell armor that you were equipping it? You lil' bitch, don't even try that. Play the gamemode like it was meant to be played.", Color(255,155,155,255), true) return false end

local item = ItemsList[str]
local cash = tonumber(client.Money)

	if client.Inventory[str] then
		SystemRemoveItem( client, str, true )
	else 
	SendChat(client, "You don't have one of those!")
	return false
	end

	if client.EquippedArmor == str then
		UseFunc_RemoveArmor(client, str)
	end

	client.Money = math.floor(client.Money + (item["Cost"] * (0.2 + (client.StatBarter * 0.005)))) -- base sell price 20% of the original buy price plus 0.5% per barter level to max of 25%
	SendInventory(client)
	client:EmitSound("physics/cardboard/cardboard_box_break3.wav", 100, 100)

	net.Start("UpdatePeriodicStats")
	net.WriteFloat( client.Level )
	net.WriteFloat( client.Prestige )
	net.WriteFloat( client.Money )
	net.WriteFloat( client.XP )
	net.WriteFloat( client.StatPoints )
	net.WriteFloat( client.Bounty )
	net.Send( client )

end)


----------------------------------------------------------equip guns----------------------------------------------------------------------------


net.Receive( "UseGun", function( length, client )
local item = net.ReadString()
if client.Inventory[item] then
	client:Give( item )
	client:SelectWeapon( item )
else
SendChat(client, "You don't have one of those!")
end

end)
