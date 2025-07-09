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
				gamemode.Call("SavePlayer", ply)
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
		ply:InvStripWeapon(str)
	end
	ply.Inventory[str] = ply.Inventory[str] - amt
	if ply.Inventory[str] < 1 then ply.Inventory[str] = nil end
	gamemode.Call("RecalcPlayerSpeed", ply)
end



net.Receive("UseItem", function(length, ply) -- this function also handles item dropping
	GAMEMODE:UseItem(ply, net.ReadString(), net.ReadBool(), net.ReadEntity())
end)


function GM:UseItem(ply, item, use, targetply)
	local ref = GAMEMODE.ItemsList[item]
	local ftoggle
	if use then ftoggle = "UseFunc" else ftoggle = "DropFunc" end
	if !targetply or !targetply:IsValid() then targetply = ply end

	if ply.LastItemAction and ply.LastItemAction + 0.2 > CurTime() then return false end -- cancel the function if they are spamming net messages
	if !ply:Alive() then return false end
	if !ref then ply:SendChat(translate.ClientGet(ply, "itemnonexistant")) return false end -- if the item doenst exist
	if ply:IsSleeping() then ply:SendChat(translate.ClientGet(ply, "itemnousesleeping")) return false end
	if ply:IsUsingItem() then ply:SendChat(translate.ClientGet(ply, "itemnousecooldown")) return false end

	if ply.Inventory[item] and ply.Inventory[item] > 0 then
		if ftoggle == "UseFunc" then
			if ref.UseFunc then
				local func = ref.UseFunc(ply, targetply, item)
				if func then
					GAMEMODE:SystemRemoveItem(ply, item, false) -- leave this as false otherwise grenades are unusable
				end
			else
				local itemtype = ref.ItemType
				local shouldremove
				if ref.WeaponType then
					local gun = ref.WeaponType
					if ref.IsGrenade then
						local wep = ply:GetWeapon(gun)
						if not wep:IsValid() then
							wep = ply:Give(gun, true)
						end
						ply:GiveAmmo(1, wep:GetPrimaryAmmoType())

						if ply:GetActiveWeapon() != gun then
							ply:SelectWeapon(gun)
						end

						shouldremove = true
					else
						local wep = ply:GetWeapon(gun)
						if not wep:IsValid() then
							wep = ply:Give(gun, true)
						end
						ply:SelectWeapon(gun)
					end
				elseif ref.ArmorStats then
					if ply.EquippedArmor == item then
						ply:SendUseDelay(3, "Unequipping Armor...")
						ply:EmitSound("npc/combine_soldier/zipline_hitground2.wav")
						timer.Simple(3, function()
							if !ply:IsValid() or !ply:Alive() then return false end
							ply:ArmorUnequip()
						end)
					else
						ply:SendUseDelay(3, "Equipping Armor...")
						ply:EmitSound("npc/combine_soldier/zipline_hitground1.wav")

						timer.Create("Isplyequippingarmor"..ply:EntIndex().."_"..item, 3, 1, function()
							if !ply:IsValid() or !ply:Alive() then return false end
							ply:ArmorEquip(item)
						end)
					end
				end

				local consum = ref.ConsumableStats
				if consum then
					shouldremove = true

					if consum.UseTime then
						local str = {
							[ITEMTYPE_MED] = "Healing "..(targetply and targetply:Nick() or "").."...",
							[ITEMTYPE_MEDANTIDOTE] = "Healing Infection...",
							[ITEMTYPE_ARMOR] = "Reinforcing armor...",
							[ITEMTYPE_FOOD] = "Eating food...",
							[ITEMTYPE_DRINK] = "Drinking...",
						}

						ply:SendUseDelay(consum.UseTime, str[itemtype] or "Using an item")
					end

					if consum.Health then
						ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + consum.Health*(1 + ply.StatMedSkill*0.025)))
					end

					if consum.Armor then
						ply:SetArmor(math.min(ply:GetMaxArmor(), ply:Armor() + consum.Armor*(1 + ply.StatEngineer*0.02)))
					end

					if consum.Infection then
						ply.Infection = ply.Infection + consum.Infection*100
					end

					if consum.Stamina then
						ply.Stamina = ply.Stamina + consum.Stamina
					end

					if consum.Thirst then
						ply.Thirst = ply.Thirst + consum.Thirst*100
					end

					if consum.Hunger then
						ply.Hunger = ply.Hunger + consum.Hunger*100
					end

					if consum.Fatigue then
						ply.Fatigue = ply.Fatigue + consum.Fatigue*100
					end
				end

				if ref.UseSound then
					ply:EmitSound(ref.UseSound, 100, 100)
				end

				if shouldremove and not ref.Reusable then
					GAMEMODE:SystemRemoveItem(ply, item, false)
				end
			end

			ply.LastItemAction = CurTime()
		elseif ftoggle == "DropFunc" and not (isfunction(ref.CantDropItem) and ref.CantDropItem(ply, item) or not isfunction(ref.CantDropItem) and ref.CantDropItem) then -- Most items use the same exact function, so why not it here instead of putting the same thing everywhere?
			if ref.DropFunc then
				local func = ref.DropFunc(ply, item)
				if func then
					GAMEMODE:SystemRemoveItem(ply, item, true)
				end
			else
				local armor = ref.Category == ITEMCATEGORY_ARMOR
				if armor and !timer.Exists("Plywantstodropequippedarmor"..ply:EntIndex()) and ply:GetNWString("ArmorType") == item then
					ply:SendChat(translate.ClientFormat(ply, "warning_about_to_drop_equipped_armor", 10))
					timer.Create("Plywantstodropequippedarmor"..ply:EntIndex(), 10, 1, function() end)
					return false
				end

				GAMEMODE:SystemRemoveItem(ply, item, false)

				local vStart, vForward = ply:GetShootPos(), ply:GetAimVector()
				local tr = util.TraceLine({
					start = vStart,
					endpos = vStart + vForward * 70,
					filter = ply
				})
				local ent = ents.Create("ate_droppeditem")
				ent:SetPos(tr.HitPos)
				ent:SetAngles(Angle(0, ply:EyeAngles().yaw, 0))
				ent:SetModel(armor and "models/props/cs_office/cardboard_box01.mdl" or GAMEMODE.ItemsList[item].Model)
				ent:SetNWString("ItemClass", item)
				ent:Spawn()
				ent:Activate()

				if armor and ply.EquippedArmor == tostring(item) then
					ply:ArmorUnequip()
				end

				ply:InvStripWeapon(item)
			end

			if ref.OnItemDropped then
				ref.OnItemDropped(ply, item)
			end
			
			ply.LastItemAction = CurTime()
		end
		self:SendInventory(ply)
	else
		ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
	end
end


net.Receive("DestroyItem", function(length, ply)
	GAMEMODE:DestroyItem(ply, net.ReadString())
end)

function GM:DestroyItem(ply, str)
	local item = GAMEMODE.ItemsList[str]
	if !ply:IsValid() or !ply:IsPlayer() then return end

	self:SystemRemoveItem(ply, str, not item.IsGrenade, 1)
	self:SendInventory(ply)
end

-------------------------------- buy stuff --------------------------------


net.Receive("BuyItem", function(length, ply)
	local str = net.ReadString()
	if ply:IsValid() and ply:Alive() and ply:IsPvPGuarded() then -- if they aren't pvp guarded then they aren't near a trader and are therefore trying to hack
		ply:BuyItem(str)
	elseif !ply:IsPvPGuarded() then
		ply:SystemMessage(translate.ClientGet(ply, "antihack_roast_hack_buy_nonpvpguarded"), Color(255,205,205,255), true)
	end
end)


function meta:BuyItem(str)
	--if !ply.CanBuy then self:SendChat("Hey calm down there bud, don't rush the system") return false end -- cancel the function if they are spamming net messages
	if !GAMEMODE.ItemsList[str] then self:SendChat(translate.ClientGet(self, "itemnonexistant")) return end -- if the item doenst exist

	local item = GAMEMODE.ItemsList[str]
	local stockcheck = GAMEMODE.ItemsList[str]["Supply"]
	local buyprice = item["Cost"] * (1 - (self.StatBarter * 0.015))

	if stockcheck <= -1 then
		self:SendChat(translate.ClientGet(self, "antihack_roast_hack_buy"))
		print(self:Nick().." ("..self:SteamID()..") attempted to buy an item that trader doesn't sell!")
		return
	end

	local cash = tonumber(self.Money)

	if (cash < buyprice) then self:SendChat(translate.ClientGet(self, "cannot_afford_that")) return false end
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
	if timer.Exists("Isplyequippingarmor"..ply:EntIndex().."_"..str) then
		ply:SystemMessage(translate.ClientGet(ply, "antihack_roast_hack_sell_equipping_armor"), Color(255,155,155,255), true)
		return false
	end
	if amt < 1 or !ply.Inventory[str] or ply.Inventory[str] < amt then return end

	local item = GAMEMODE.ItemsList[str]
	local cash = tonumber(ply.Money)
	local sellprice = item["Cost"] * (0.2 + (ply.StatBarter * 0.005)) * amt

	if ply.Inventory[str] then
		if item.IsGrenade then
			GAMEMODE:SystemRemoveItem(ply, str, false, amt)
		else
			GAMEMODE:SystemRemoveItem(ply, str, true, amt)
		end
	else 
		ply:SendChat(translate.ClientGet(ply, "hasnoitem"))
		return false
	end

	if ply.EquippedArmor == str and !ply.Inventory[str] then
		ply:ArmorUnequip()
	end

	ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "tr_itemsold", GAMEMODE:GetItemName(str, ply), amt, sellprice, GAMEMODE.Config["Currency"])
	ply.Money = math.floor(cash + sellprice) -- base sell price 20% of the original buy price plus 0.5% per barter level to max of 25%
	ply:EmitSound("physics/cardboard/cardboard_box_break3.wav", 100, 100)
	if item.OnSell then
		item.OnSell(ply, amt)
	end
	GAMEMODE:SendInventory(ply)
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

function meta:InvStripWeapon(item)
	local wep = self:GetWeapon(item)
	local itemtbl = GAMEMODE.ItemsList[item]
	if wep and wep:IsValid() and (not self.Inventory[item] or self.Inventory[item] < 2) and not itemtbl.IsGrenade then
		if IsValid(wep) and wep:IsWeapon() then
			local clip1 = tonumber(wep:Clip1()) or 0
			local clip2 = tonumber(wep:Clip2()) or 0
			if clip1 > 0 then self:GiveAmmo(clip1, wep:GetPrimaryAmmoType()) end
			if clip2 > 0 then self:GiveAmmo(clip2, wep:GetSecondaryAmmoType()) end
		end
		self:StripWeapon(item)
	end
end
