local meta = FindMetaTable("Player")

function CalculateWeight(ply)
local totalweight = 0
	for k, v in pairs(ply.Inventory) do
		if !ItemsList[k] then ErrorNoHalt( "CalculateWeight error on "..ply:Nick().."! They must have a corrupt inventory file or something\n" ) continue end	
		local ref = ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
return totalweight
end

function CalculateMaxWeight(ply)
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = ItemsList[armorstr]
	local maxweight = 0
	local defaultcarryweight = Config["MaxCarryWeight"]
	if ply.StatsPaused then return 1e300 end
	if tonumber(ply.Prestige) >= 6 then
		if ply:GetNWString("ArmorType") == "none" then
			maxweight = defaultcarryweight + 5 + ((ply.StatStrength or 0) * 1.53)
		else
			maxweight = defaultcarryweight + 5 + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
		end
	elseif tonumber(ply.Prestige) >= 3 then
		if ply:GetNWString("ArmorType") == "none" then
			maxweight = defaultcarryweight + 2 + ((ply.StatStrength or 0) * 1.53)
		else
			maxweight = defaultcarryweight + 2 + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
		end
	else
		if ply:GetNWString("ArmorType") == "none" then
			maxweight = defaultcarryweight + ((ply.StatStrength or 0) * 1.53)
		else
			maxweight = defaultcarryweight + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
		end
	end
	return maxweight
end

function SendInventory(ply)
	if !ply:IsValid() then return end
	FullyUpdatePlayer(ply)
	SendVault(ply)
end
concommand.Add("refresh_inventory", SendInventory)



function LoadPlayerInventory(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player inventory file that doesn't exist!") return end
	ply.Inventory = {}

	local LoadedData
	if Config["FileSystem"] == "Legacy" then

	if (file.Exists("theeternalapocalypse/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", "DATA")) then
		LoadedData = file.Read("theeternalapocalypse/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/inventory.txt"), "DATA")
	end
	elseif Config[ "FileSystem" ] == "PData" then
		LoadedData = ply:GetPData("ate_playerinventory")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)
		ply.Inventory = formatted
	else
		ply.Inventory = table.Copy(Config["RookieGear"])
	end

	timer.Simple(1, function() SendInventory(ply) end)


end


function SavePlayerInventory(ply)
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
	if AllowSave != 1 and !tobool(tea_server_dbsaving:GetString()) then return end
	if !ply:IsValid() then return end

	if Config[ "FileSystem" ] == "Legacy" then
		local data = util.TableToJSON(ply.Inventory)
		file.Write("theeternalapocalypse/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", data)
		print("✓ ".. ply:Nick() .." inventory saved into database")
	elseif Config[ "FileSystem" ] == "PData" then
		local formatted = util.TableToJSON( ply.Inventory )
		ply:SetPData( "ate_playerinventory", formatted )
		print("✓ ".. ply:Nick() .." inventory saved into database")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end

function SaveTimer()
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
	local i = 0
	if !tobool(tea_server_dbsaving:GetString()) then print("------=== WARNING ===------\n\nDatabase saving is disabled! Players will not have their progress saved during this time.\nSet ConVar 'tea_server_dbsaving' to 1 in order to enable database saving.\n\n------======------") return end
	for k, ply in pairs(player.GetAll()) do
		if ply:IsValid() then
			i = i + 1
			if !tobool(tea_server_dbsaving:GetString()) then return end
			timer.Simple(i * 0.5, function()
				if !ply:IsValid() then return end
				SavePlayer(ply)
				SavePlayerInventory(ply)
				SavePlayerVault(ply)
			end)
		end
	end
end
timer.Create("SaveTimer", 180, 0, SaveTimer)

function SystemGiveItem(ply, str, qty)

if !ply:IsValid() or !ply:IsPlayer() then return end
if !ItemsList[str] or !ply.Inventory then return end
qty = tonumber(qty) or 1

local item = ItemsList[str]
if ((CalculateWeight(ply) + (qty * item["Weight"])) > (CalculateMaxWeight(ply))) then SendChat(ply, "You don't have any inventory space left for this item! (Need "..-CalculateMaxWeight(ply) + CalculateWeight(ply) + (qty * item["Weight"]).."kg more space)") return false end -- dont need to pester them with notifications from a system function, just return false

	if ply.Inventory[str] then
		ply.Inventory[str] = ply.Inventory[str] + qty
	else 
		ply.Inventory[str] = qty
	end

end

function SystemRemoveItem(ply, str, strip)
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



net.Receive("UseItem", function(length, client) -- this function also handles item dropping
	local item = net.ReadString()
	local action = net.ReadBool()
	local ftoggle
	if !action then ftoggle = "DropFunc" else ftoggle = "UseFunc" end

	if !client.CanUseItem then return false end -- cancel the function if they are spamming net messages
	if !ItemsList[item] then SendChat(client, translate.ClientGet(client, "ItemNonExistant")) return false end -- if the item doenst exist

	local ref = ItemsList[item]

	if client.Inventory[item] then
		if client.Inventory[item] > 0 then
			local func = ref[ftoggle](client)
			if func == true then
				SystemRemoveItem(client, item, false) -- leave this as false otherwise grenades are unusable
				client.CanUseItem = false
				timer.Simple(0.7, function() if client:IsValid() then client.CanUseItem = true end end)
			end
			SendInventory(client)
		else
			SendChat(client, translate.ClientGet(client, "HasNotGotItem"))
		end
	else
		SendChat(client, translate.ClientGet(client, "HasNotGotItem"))
	end
end)


----------------------------------------------------------buy shit----------------------------------------------------------------------------


net.Receive("BuyItem", function(length, client)
	local str = net.ReadString()
	if client:IsValid() and client:Alive() and client:IsPvPGuarded() then -- if they aren't pvp guarded then they aren't near a trader and are therefore trying to hack
		client:BuyItem(str)
	elseif !client:IsPvPGuarded() then
		SystemMessage(client, "STOP TRYING TO HACK!!!!", Color(255,205,205,255), true)
	end
end)


function meta:BuyItem(str)
	--if !client.CanBuy then SendChat(client, "Hey calm down there bud, don't rush the system") return false end -- cancel the function if they are spamming net messages
	if !ItemsList[str] then SendChat(self, translate.ClientGet(self, "ItemNonExistant")) return end -- if the item doenst exist

	local item = ItemsList[str]
	local stockcheck = ItemsList[str]["Supply"]
	local buyprice = item["Cost"] * (1 - (self.StatBarter * 0.015))

	if stockcheck <= -1 then SendChat(self, "Bruh, did you just try to buy stuff that trader doesn't even sell? You should play the gamemode like it was meant to be played.") return end -- people may try to hack and send faked netmessages to buy stuff the trader isnt meant to sell

	local cash = tonumber(self.Money)

	if (cash < buyprice) then SendChat(self, "You cannot afford that!") return false end
	if ((CalculateWeight(self) + item["Weight"]) > CalculateMaxWeight(self)) then SendChat(self, translate.ClientFormat(self, "NotEnoughSpace", -CalculateMaxWeight(self) + CalculateWeight(self) + item["Weight"], translate.ClientGet(self, "kg"))) return false end

	SystemGiveItem(self, str)
	self:PrintTranslatedMessage(HUD_PRINTCONSOLE, "TraderBoughtItem", translate.ClientGet(self, item["Name"]), buyprice, Config["Currency"])
	self.Money = math.floor(self.Money - (item["Cost"] * (1 - (self.StatBarter * 0.015)))) -- reduce buy cost by 1.5% per barter level
	SendInventory(self)
	self:EmitSound("items/ammopickup.wav", 100, 100)
	TEANetUpdatePeriodicStats(self)
end


----------------------------------------------------------sell stuff----------------------------------------------------------------------------


net.Receive("SellItem", function(length, client)
	local str = net.ReadString()

	if !ItemsList[str] then SendChat(client, translate.ClientGet(client, "ItemNonExistant")) return false end -- if the item doenst exist
	if timer.Exists("Isplyequippingarmor"..client:UniqueID().."_"..str) then SystemMessage(client, "Bruh, did you try to sell armor that you were equipping it? You lil' bitch, there will be consequences. Play the gamemode like it was meant to be played.", Color(255,155,155,255), true) return false end

	local item = ItemsList[str]
	local cash = tonumber(client.Money)
	local sellprice = item["Cost"] * (0.2 + (client.StatBarter * 0.005))

	if client.Inventory[str] then
		if ItemsList[str]["IsGrenade"] then
			SystemRemoveItem(client, str, false)
		else
			SystemRemoveItem(client, str, true)
		end
	else 
		SendChat(client, translate.ClientGet(client, "HasNotGotItem"))
	return false
	end

	if client.EquippedArmor == str then
		UseFunc_RemoveArmor(client, str)
	end

	client:PrintTranslatedMessage(HUD_PRINTCONSOLE, "TraderSoldItem", translate.ClientGet(client, item["Name"]), sellprice, Config["Currency"])
	client.Money = math.floor(client.Money + sellprice) -- base sell price 20% of the original buy price plus 0.5% per barter level to max of 25%
	SendInventory(client)
	client:EmitSound("physics/cardboard/cardboard_box_break3.wav", 100, 100)
	TEANetUpdatePeriodicStats(client)

end)


----------------------------------------------------------equip guns----------------------------------------------------------------------------


net.Receive("UseGun", function( length, client )
	local item = net.ReadString()
	if client.Inventory[item] then
		client:Give(item)
		client:SelectWeapon(item)
	else
		SendChat(client, translate.ClientGet(client, "HasNotGotItem"))
	end
end)
