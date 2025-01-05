local meta = FindMetaTable("Player")
--[[
function GM:CalculateWeight(ply)
	local totalweight = 0
	for k, v in pairs(ply.Inventory) do
		if !self.ItemsList[k] then ErrorNoHalt("CalculateWeight error on "..ply:Nick().."! They must have a corrupt inventory (file) or something\n") continue end
		local ref = self.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
	return totalweight
end

-- make sure on client are the same!!
function GM:CalculateMaxWeight(ply)
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = self.ItemsList[armorstr]
	if ply.StatsPaused then return 1e300 end

	return self.Config["MaxCarryWeight"] + (ply.UnlockedPerks["weightboost"] and 1.5 or 0) + (ply.UnlockedPerks["weightboost2"] and 2.5 or 0) + (ply.UnlockedPerks["weightboost3"] and 3.5 or 0)
		+ ((ply.StatStrength or 0) * 1.53) + (ply:GetNWString("ArmorType") ~= "none" and armortype["ArmorStats"]["carryweight"] or 0)
end

function GM:CalculateRemainingInventoryWeight(ply, weight)
	return math.Round((-ply:CalculateMaxWeight() + ply:CalculateWeight() + weight), 2)
end
]]
function GM:SendInventory(ply)
	if !ply:IsValid() then return end
	timer.Create("tea_sendinventory_"..ply:EntIndex(), (ply.m_LastTimeInventorySent or 0) + 0.5 - CurTime(), 1, function()
		net.Start("UpdateInventory")
		net.WriteTable(ply.Inventory)
		net.Send(ply)
--		self:FullyUpdatePlayer(ply)
		self:SendVault(ply)
		ply:SendNetworkEvent("tea_plyevent_vaultupdate")
	end)
	ply.m_LastTimeInventorySent = CurTime()
end
concommand.Add("refresh_inventory", function(ply)
	GAMEMODE:SendInventory(ply)
end)


function GM:LoadPlayerInventory(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player inventory file that doesn't exist!") return end
	ply.Inventory = {}

	local LoadedData
	local InvalidData
	if self.Config["FileSystem"] == "Legacy" then
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", "DATA")) then
			LoadedData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/inventory.txt"), "DATA")
		end
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", "DATA")) then
			InvalidData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/invalid_inventory.txt"), "DATA")
		end
	elseif self.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("tea_playerinventory")
		InvalidData = ply:GetPData("tea_invalidinventory")
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
			if !self.ItemsList[k] then
				invaliditems[k] = formatted[k]
				formatted[k] = nil
			end
		end
		for k,v in pairs(invaliditems) do
			if self.ItemsList[k] then
				formatted[k] = invaliditems[k]
				invaliditems[k] = nil
			end
		end
		if self:GetDebug() >= DEBUGGING_ADVANCED then
			print("Loading Inventory\n\n")
			PrintTable(formatted)
			print("\nInvalid Items:")
			PrintTable(invaliditems)
		end
		ply.Inventory = formatted
		ply.InvalidInventory = invaliditems
	else
		ply.Inventory = table.Copy(self.Config["NewbieGear"])
	end

	timer.Simple(1, function()
		GAMEMODE:SendInventory(ply)
	end)
end


function GM:SavePlayerInventory(ply)
	if !ply:IsValid() then return end
	if !ply.AllowSave and not self.DatabaseSaving then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", data)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", invaliddata)
		if self:GetDebug() >= DEBUGGING_NORMAL then
			print(Format("✓ %s inventory saved", ply:Nick()))
		end
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		ply:SetPData("tea_playerinventory", formatted)
		ply:SetPData("tea_invalidinventory", invaliddata)
		if self:GetDebug() >= DEBUGGING_NORMAL then
			print(Format("✓ %s inventory saved", ply:Nick()))
		end
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end

function GM:SaveTimer()
	local i = 0
	if not self.DatabaseSaving then
		print([[------=== WARNING ===------

Database saving is disabled! Players will not have their progress saved during this time.
Set ConVar 'tea_server_dbsaving' to 1 in order to enable database saving.

------=== ===------]]) return end
	for k, ply in pairs(player.GetAll()) do
		if ply:IsValid() then
			timer.Simple(i, function()
				if !self.DatabaseSaving then return end
				if !ply:IsValid() then return end
				self:SavePlayer(ply)
				self:SavePlayerInventory(ply)
				self:SavePlayerVault(ply)
				self:SavePlayerPerks(ply)
			end)
			i = i + 0.5
		end
	end
end

function GM:SystemGiveItem(ply, str, qty)
	if !ply:IsValid() or !ply:IsPlayer() then return false end
	if !self.ItemsList[str] or !ply.Inventory then return false end
	qty = tonumber(qty) or 1

	local item = self.ItemsList[str]
	-- dont need to pester them with notifications from a system function, just return false
	-- if ((ply:CalculateWeight() + (qty * item["Weight"])) > (ply:CalculateMaxWeight())) then ply:SendChat(Format("You don't have any inventory space left for this item! (Need %skg more space)", GAMEMODE:CalculateRemainingInventoryWeight(ply, qty * item["Weight"]))) return false end

	if ply.Inventory[str] then
		ply.Inventory[str] = ply.Inventory[str] + qty
	else 
		ply.Inventory[str] = qty
	end
	gamemode.Call("RecalcPlayerSpeed", ply)
	return true
end

function GM:SystemRemoveItem(ply, str, strip, amt)
	if !ply:IsValid() or !ply:IsPlayer() then return end
	local item = self.ItemsList[str]
	amt = math.floor(amt or 1)
	if !item or !ply.Inventory then return end

	strip = tobool(strip) or false
	if !ply:IsValid() then return end
	if !item then return end
	if !ply.Inventory[str] then return end

	if strip then
		UseFunc_StripWeapon(ply, str, strip)
	end
	ply.Inventory[str] = ply.Inventory[str] - amt
	if ply.Inventory[str] < 1 then ply.Inventory[str] = nil end
	gamemode.Call("RecalcPlayerSpeed", ply)
end



net.Receive("UseItem", function(length, ply) -- this function also handles item dropping
	GAMEMODE:UseItem(ply, net.ReadString(), net.ReadBool(), net.ReadEntity())
end)


function GM:UseItem(ply, item, use, targetply)
	local str = GAMEMODE.ItemsList[item]
	local ftoggle
	if use then ftoggle = "UseFunc" else ftoggle = "DropFunc" end
	if !targetply or !targetply:IsValid() then targetply = ply end

	if !ply.CanUseItem then return false end -- cancel the function if they are spamming net messages
	if !str then ply:SendChat(translate.ClientGet(ply, "itemnonexistant")) return false end -- if the item doenst exist
	if timer.Exists("IsSleeping_"..ply:EntIndex()) then ply:SendChat(translate.ClientGet(ply, "itemnousesleeping")) return false end
	if timer.Exists("Isplyusingitem"..ply:EntIndex()) then ply:SendChat(translate.ClientGet(ply, "itemnousecooldown")) return false end
	if timer.Exists("Isplyequippingarmor"..ply:EntIndex()) then ply:SendChat(translate.ClientGet(ply, "itemnousearmor")) return false end
	if timer.Exists("ItemCrafting_"..ply:EntIndex()) then ply:SystemMessage(translate.ClientGet(ply, "itemnousecrafting"), Color(255,205,205), false) return false end

	local ref = str

	if ply.Inventory[item] then
		if ply.Inventory[item] > 0 then
			local func = ref[ftoggle](ply, targetply)
			if func == true then
				GAMEMODE:SystemRemoveItem(ply, item, false) -- leave this as false otherwise grenades are unusable
				timer.Simple(0.25, function() if ply:IsValid() then ply.CanUseItem = true end end)
				ply.CanUseItem = false
			end
			self:SendInventory(ply)
		else
			ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
		end
	else
		ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
	end
end

-------------------------------- buy stuff --------------------------------


net.Receive("BuyItem", function(length, ply)
	local str = net.ReadString()
	if ply:IsValid() and ply:Alive() and ply:IsPvPGuarded() then -- if they aren't pvp guarded then they aren't near a trader and are therefore trying to hack
		ply:BuyItem(str)
	elseif !ply:IsPvPGuarded() then
		ply:SystemMessage("no.", Color(255,205,205,255), true)
	end
end)


function meta:BuyItem(str)
	--if !ply.CanBuy then self:SendChat("Hey calm down there bud, don't rush the system") return false end -- cancel the function if they are spamming net messages
	if !GAMEMODE.ItemsList[str] then self:SendChat(translate.ClientGet(self, "itemnonexistant")) return end -- if the item doenst exist

	local item = GAMEMODE.ItemsList[str]
	local stockcheck = GAMEMODE.ItemsList[str]["Supply"]
	local buyprice = item["Cost"] * (1 - (self.StatBarter * 0.015))

	if stockcheck <= -1 then self:SendChat("Bruh, did you just try to buy stuff that trader doesn't even sell? You should play the gamemode like it was meant to be played.") return end -- people may try to hack and send faked netmessages to buy stuff the trader isnt meant to sell

	local cash = tonumber(self.Money)

	if (cash < buyprice) then self:SendChat("You cannot afford that!") return false end
	-- if ((self:CalculateWeight() + item["Weight"]) > self:CalculateMaxWeight()) then self:SendChat(translate.ClientFormat(self, "notenoughspace", GAMEMODE:CalculateRemainingInventoryWeight(self, item["Weight"]))) return false end

	GAMEMODE:SystemGiveItem(self, str)
	self:PrintTranslatedMessage(HUD_PRINTCONSOLE, "tr_itembought", GAMEMODE:GetItemName(str, self), buyprice, GAMEMODE.Config["Currency"])
	self.Money = math.floor(self.Money - (item["Cost"] * (1 - (self.StatBarter * 0.015)))) -- reduce buy cost by 1.5% per barter level
	GAMEMODE:SendInventory(self)
	self:EmitSound("items/ammopickup.wav", 100, 100)
	GAMEMODE:NetUpdatePeriodicStats(self)
end


----------------------------------------------------------sell stuff----------------------------------------------------------------------------


net.Receive("SellItem", function(len, ply)
	local str = net.ReadString()
	local amt = net.ReadUInt(32)

	if !GAMEMODE.ItemsList[str] then ply:SendChat(translate.ClientGet(ply, "itemnonexistant")) return false end -- if the item doenst exist
	if timer.Exists("Isplyequippingarmor"..ply:EntIndex().."_"..str) then ply:SystemMessage("Bruh, did you try to sell armor that you were equipping it? You lil' bitch, there will be consequences. Play the gamemode like it was meant to be played.", Color(255,155,155,255), true) return false end
	if amt < 1 or !ply.Inventory[str] or ply.Inventory[str] < amt then return end

	local item = GAMEMODE.ItemsList[str]
	local cash = tonumber(ply.Money)
	local sellprice = item["Cost"] * (0.2 + (ply.StatBarter * 0.005)) * amt

	if ply.Inventory[str] then
		if item["IsGrenade"] then
			GAMEMODE:SystemRemoveItem(ply, str, false, amt)
		else
			GAMEMODE:SystemRemoveItem(ply, str, true, amt)
		end
	else 
		ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
		return false
	end

	if ply.EquippedArmor == str and !ply.Inventory[str] then
		UseFunc_RemoveArmor(ply, str)
	end

	ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "tr_itemsold", GAMEMODE:GetItemName(name, ply), amt, sellprice, GAMEMODE.Config["Currency"])
	ply.Money = math.floor(cash + sellprice) -- base sell price 20% of the original buy price plus 0.5% per barter level to max of 25%
	GAMEMODE:SendInventory(ply)
	ply:EmitSound("physics/cardboard/cardboard_box_break3.wav", 100, 100)
	GAMEMODE:NetUpdatePeriodicStats(ply)
end)


----------------------------------------------------------equip guns----------------------------------------------------------------------------


net.Receive("UseGun", function(length, ply)
	local item = net.ReadString()
	if ply.Inventory[item] then
		ply:Give(item)
		ply:SelectWeapon(item)
	else
		ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
	end
end)
