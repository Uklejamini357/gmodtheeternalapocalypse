local meta = FindMetaTable("Player")

function tea_CalculateWeight(ply)
local totalweight = 0
	for k, v in pairs(ply.Inventory) do
		if !GAMEMODE.ItemsList[k] then ErrorNoHalt( "CalculateWeight error on "..ply:Nick().."! They must have a corrupt inventory file or something\n" ) continue end	
		local ref = GAMEMODE.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
return totalweight
end

function tea_CalculateMaxWeight(ply)
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]
	local maxweight = 0
	local defaultcarryweight = GAMEMODE.Config["MaxCarryWeight"]
	if ply.StatsPaused then return 1e300 end
	if ply:GetNWString("ArmorType") == "none" then
		maxweight = defaultcarryweight + (tonumber(ply.Prestige) >= 6 and 5 or tonumber(ply.Prestige) >= 3 and 2 or 0) + ((ply.StatStrength or 0) * 1.53)
	else
		maxweight = defaultcarryweight + (tonumber(ply.Prestige) >= 6 and 5 or tonumber(ply.Prestige) >= 3 and 2 or 0) + ((ply.StatStrength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
	end
	return maxweight
end

function tea_SendInventory(ply)
	if !ply:IsValid() then return end
	tea_FullyUpdatePlayer(ply)
	tea_SendVault(ply)
end
concommand.Add("refresh_inventory", tea_SendInventory)


function tea_LoadPlayerInventory(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player inventory file that doesn't exist!") return end
	ply.Inventory = {}

	local LoadedData
	local InvalidData
	if GAMEMODE.Config["FileSystem"] == "Legacy" then
		if (file.Exists(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", "DATA")) then
			LoadedData = file.Read(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/inventory.txt"), "DATA")
		end
		if (file.Exists(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", "DATA")) then
			InvalidData = file.Read(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/invalid_inventory.txt"), "DATA")
		end
	elseif GAMEMODE.Config[ "FileSystem" ] == "PData" then
		LoadedData = ply:GetPData("ate_playerinventory")
		InvalidData = ply:GetPData("ate_invalidinventory")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)
		local invaliditems = {}
		if InvalidData then
			invaliditems = util.JSONToTable(InvalidData) --save invalid items just in case
		end
		for k,v in pairs(formatted) do
			if !GAMEMODE.ItemsList[k] then
				invaliditems[k] = formatted[k]
				formatted[k] = nil
			end
		end
		for k,v in pairs(invaliditems) do
			if GAMEMODE.ItemsList[k] then
				formatted[k] = invaliditems[k]
				invaliditems[k] = nil
			end
		end
		if GetConVar("tea_server_debugging"):GetInt() >= 1 then
			print("Loading Inventory\n\n")
			PrintTable(formatted)
			print("\nInvalid Items:")
			PrintTable(invaliditems)
		end
		ply.Inventory = formatted
		ply.InvalidInventory = invaliditems
	else
		ply.Inventory = table.Copy(GAMEMODE.Config["RookieGear"])
	end

	timer.Simple(1, function() tea_SendInventory(ply) end)
end


function tea_SavePlayerInventory(ply)
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving"):GetInt() >= 1
	if !ply:IsValid() then return end
	if !ply.AllowSave and !tea_server_dbsaving then return end

	if GAMEMODE.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		file.Write(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", data)
		file.Write(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", invaliddata)
		print(Format("✓ %s inventory saved into inventory", ply:Nick()))
	elseif GAMEMODE.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		ply:SetPData("ate_playerinventory", formatted)
		ply:SetPData("ate_invalidinventory", invaliddata)
		print(Format("✓ %s inventory saved to PData", ply:Nick()))
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end

function tea_SaveTimer()
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
	local i = 0
	if !tobool(tea_server_dbsaving:GetString()) then print("------=== WARNING ===------\n\nDatabase saving is disabled! Players will not have their progress saved during this time.\nSet ConVar 'tea_server_dbsaving' to 1 in order to enable database saving.\n\n------======------") return end
	for k, ply in pairs(player.GetAll()) do
		if ply:IsValid() then
			i = i + 1
			if !tobool(tea_server_dbsaving:GetString()) then return end
			timer.Simple(i * 0.5, function()
				if !ply:IsValid() then return end
				tea_SavePlayer(ply)
				tea_SavePlayerInventory(ply)
				tea_SavePlayerVault(ply)
			end)
		end
	end
end
timer.Create("SaveTimer", 180, 0, tea_SaveTimer)

function tea_SystemGiveItem(ply, str, qty)
	if !ply:IsValid() or !ply:IsPlayer() then return end
	if !GAMEMODE.ItemsList[str] or !ply.Inventory then return end
	qty = tonumber(qty) or 1

	local item = GAMEMODE.ItemsList[str]
	-- dont need to pester them with notifications from a system function, just return false
	if ((tea_CalculateWeight(ply) + (qty * item["Weight"])) > (tea_CalculateMaxWeight(ply))) then SendChat(ply, "You don't have any inventory space left for this item! (Need "..-tea_CalculateMaxWeight(ply) + tea_CalculateWeight(ply) + (qty * item["Weight"]).."kg more space)") return false end

	if ply.Inventory[str] then
		ply.Inventory[str] = ply.Inventory[str] + qty
	else 
		ply.Inventory[str] = qty
	end
end

function tea_SystemRemoveItem(ply, str, strip)
	if !ply:IsValid() or !ply:IsPlayer() then return end
	local item = GAMEMODE.ItemsList[str]
	if !item or !ply.Inventory then return end

	strip = tobool(strip) or false
	if !ply:IsValid() then return end
	if !item then return end
	if !ply.Inventory[str] then return end

	if strip then
		UseFunc_StripWeapon(ply, str, strip)
	end
	ply.Inventory[str] = ply.Inventory[str] - 1
	if ply.Inventory[str] < 1 then ply.Inventory[str] = nil end
end



net.Receive("UseItem", function(length, client) -- this function also handles item dropping
	local item = net.ReadString()
	local action = net.ReadBool()
	local str = GAMEMODE.ItemsList[item]
	local ftoggle
	if !action then ftoggle = "DropFunc" else ftoggle = "UseFunc" end

	if !client.CanUseItem then return false end -- cancel the function if they are spamming net messages
	if !str then SendChat(client, translate.ClientGet(client, "itemnonexistant")) return false end -- if the item doenst exist

	local ref = str

	if client.Inventory[item] then
		if client.Inventory[item] > 0 then
			local func = ref[ftoggle](client)
			if func == true then
				tea_SystemRemoveItem(client, item, false) -- leave this as false otherwise grenades are unusable
				client.CanUseItem = false
				timer.Simple(0.6, function() if client:IsValid() then client.CanUseItem = true end end)
			end
			tea_SendInventory(client)
		else
			SendChat(client, translate.ClientGet(client, "hasnoitem"))
		end
	else
		SendChat(client, translate.ClientGet(client, "hasnoitem"))
	end
end)


----------------------------------------------------------buy shit----------------------------------------------------------------------------


net.Receive("BuyItem", function(length, client)
	local str = net.ReadString()
	if client:IsValid() and client:Alive() and client:IsPvPGuarded() then -- if they aren't pvp guarded then they aren't near a trader and are therefore trying to hack
		client:BuyItem(str)
	elseif !client:IsPvPGuarded() then
		SystemMessage(client, "no.", Color(255,205,205,255), true)
	end
end)


function meta:BuyItem(str)
	--if !client.CanBuy then SendChat(client, "Hey calm down there bud, don't rush the system") return false end -- cancel the function if they are spamming net messages
	if !GAMEMODE.ItemsList[str] then SendChat(self, translate.ClientGet(self, "itemnonexistant")) return end -- if the item doenst exist

	local item = GAMEMODE.ItemsList[str]
	local stockcheck = GAMEMODE.ItemsList[str]["Supply"]
	local buyprice = item["Cost"] * (1 - (self.StatBarter * 0.015))

	if stockcheck <= -1 then SendChat(self, "Bruh, did you just try to buy stuff that trader doesn't even sell? You should play the gamemode like it was meant to be played.") return end -- people may try to hack and send faked netmessages to buy stuff the trader isnt meant to sell

	local cash = tonumber(self.Money)

	if (cash < buyprice) then SendChat(self, "You cannot afford that!") return false end
	if ((tea_CalculateWeight(self) + item["Weight"]) > tea_CalculateMaxWeight(self)) then SendChat(self, translate.ClientFormat(self, "notenoughspace", -tea_CalculateMaxWeight(self) + tea_CalculateWeight(self) + item["Weight"])) return false end

	tea_SystemGiveItem(self, str)
	self:PrintTranslatedMessage(HUD_PRINTCONSOLE, "tr_itembought", translate.ClientGet(self, str.."_n"), buyprice, GAMEMODE.Config["Currency"])
	self.Money = math.floor(self.Money - (item["Cost"] * (1 - (self.StatBarter * 0.015)))) -- reduce buy cost by 1.5% per barter level
	tea_SendInventory(self)
	self:EmitSound("items/ammopickup.wav", 100, 100)
	tea_NetUpdatePeriodicStats(self)
end


----------------------------------------------------------sell stuff----------------------------------------------------------------------------


net.Receive("SellItem", function(length, client)
	local str = net.ReadString()

	if !GAMEMODE.ItemsList[str] then SendChat(client, translate.ClientGet(client, "itemnonexistant")) return false end -- if the item doenst exist
	if timer.Exists("Isplyequippingarmor"..client:UniqueID().."_"..str) then SystemMessage(client, "Bruh, did you try to sell armor that you were equipping it? You lil' bitch, there will be consequences. Play the gamemode like it was meant to be played.", Color(255,155,155,255), true) return false end

	local item = GAMEMODE.ItemsList[str]
	local cash = tonumber(client.Money)
	local sellprice = item["Cost"] * (0.2 + (client.StatBarter * 0.005))

	if client.Inventory[str] then
		if item["IsGrenade"] then
			tea_SystemRemoveItem(client, str, false)
		else
			tea_SystemRemoveItem(client, str, true)
		end
	else 
		SendChat(client, translate.ClientGet(client, "hasnoitem"))
	return false
	end

	if client.EquippedArmor == str then
		UseFunc_RemoveArmor(client, str)
	end

	client:PrintTranslatedMessage(HUD_PRINTCONSOLE, "tr_itemsold", translate.ClientGet(client, str.."_n"), sellprice, GAMEMODE.Config["Currency"])
	client.Money = math.floor(client.Money + sellprice) -- base sell price 20% of the original buy price plus 0.5% per barter level to max of 25%
	tea_SendInventory(client)
	client:EmitSound("physics/cardboard/cardboard_box_break3.wav", 100, 100)
	tea_NetUpdatePeriodicStats(client)
end)


----------------------------------------------------------equip guns----------------------------------------------------------------------------


net.Receive("UseGun", function( length, client )
	local item = net.ReadString()
	if client.Inventory[item] then
		client:Give(item)
		client:SelectWeapon(item)
	else
		SendChat(client, translate.ClientGet(client, "hasnoitem"))
	end
end)
