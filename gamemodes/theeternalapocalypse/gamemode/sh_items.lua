--sorry i haven't finished m9k item list yet
/*

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, { -- what the item will be called within the games code as a string, can be anything as long as you don't use the same name twice
    	Name = name,            -- Name for the item. Unused.
		Description = desc,		-- Description for the item. Unused.
		Cost = cost,            -- how much money will it cost if you buy it from the trader?
		Model = model,          -- the items model
		Weight = weight,        -- weight in kilograms (if your american and want to use imperial then your shit out of luck m8)
		Supply = supply,        -- how many of these items does each trader have in stock? stock refills every 24 hours.
-- (Stock limits don't work, will try to fix/add one) Putting 0 means unlimited stock, Putting -1 as stock will make it so the item isn't sold by traders
		Rarity = rarity,        -- 0 = trash, 1 = junk, 2 = common, 3 = uncommon, 4 = rare, 5 = super rare, 6 = epic, 7 = mythic, 8 = legendary, 9 = godly, 10 = event, 11 = unobtainable, any other = uncategorized
		Category = category,    -- 1 = supplies, 2 = ammunition, 3 = weapons, 4 = armor, any other = ignored by trader
		UseFunc = function(ply, targetply) return UseFunc_Heal(ply, targetply, usetime, health, infection, playsound) end,  -- the function to call when the player uses the item from their inventory, you will need lua skillz here
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,                        -- the function to call when the player drops the item, just like usefunc, you need to know lua here

-- Additional variables, they are not required however still can be useful
    	IsGrenade = false,						-- if the item is grenade then it will confirm that it's grenade (this is used when selling items, not to remove grenade from inventory when selling). Not needed when an item is not a grenade.
	    IsSecret = false,						-- Item cannot be spawned with from spawn menu nor from giving item command (Can still be spawned if player is dev)

}

]]
// IMPORTANT NOTE: Use and drop functions must always return true or false here.  Returning true will subtract one of that item type from the player, returning false will make it so nothing is subtracted.
see server/player_inventory.lua for more info


*/

GM.ItemsList = {}
function GM:CreateItem(itemid, table)	--name, desc, cost, model, weight, supply, rarity, category, usefunc, dropfunc
	self.ItemsList[itemid] = table

	return self.ItemsList[itemid]
end

-- apparently no idea why i removed item.Name and item.Decription because for translate but yea (then it would use item.Name and item.Description if it's valid)

local trans_get = translate.Get
local trans_format = translate.Format

-- This is something that I might be using in the future
/*
local ammocostmul = 1
local consumcostmul = 1
local wepcostmul = 1
local meleecostmul = 1
local armorcostmul = 1
local misccostmul = 1
*/



function UseFunc_Sleep(ply, bheal)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	if ply.Fatigue <= 2000 then ply:SendChat("You are not tired") return false end
	if ply.Hunger <= 3000 then ply:SendChat("You are hungry, you should eat something.") return false end
	if ply.Thirst <= 3000 then ply:SendChat("You are thirsty, you should drink something.") return false end
	if ply.Infection >= 8000 then ply:SendChat("You are infected, find a cure.") return false end
	ply:SendChat("You are now asleep")
	umsg.Start("DrawSleepOverlay", ply)
	umsg.End()
	ply.Fatigue = 0
	ply:Freeze(true)
	timer.Create("IsSleeping_"..ply:EntIndex(), 25, 1, function() ply:Freeze(false) end)
	if bheal then
		ply:SetHealth(ply:GetMaxHealth())
	end
end


function UseFunc_DropItem(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() or !GAMEMODE.ItemsList[item] or !ply:Alive() then return false end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local ent = ents.Create("ate_droppeditem")
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0, 0, 0))
	ent:SetModel(GAMEMODE.ItemsList[item].Model)
	ent:SetNWString("ItemClass", item)
	ent:Spawn()
	ent:Activate()

	return true
end

-- same as drop item but we don't want to set the dropped item to a playermodel do we? (absolutely yes.)
function UseFunc_DropArmor(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() or !GAMEMODE.ItemsList[item] or !ply:Alive() then return false end
	if !timer.Exists("Plywantstodropequippedarmor"..ply:EntIndex()) and ply:GetNWString("ArmorType") == item then
		ply:SendChat("WARNING! You are about to drop an armor that you have it equipped, drop the same armor again within 10 seconds to confirm.")
		timer.Create("Plywantstodropequippedarmor"..ply:EntIndex(), 10, 1, function() end)
		return false
	end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local ent = ents.Create("ate_droppeditem")
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0, 0, 0))
	ent:SetModel("models/props/cs_office/cardboard_box01.mdl")
	ent:SetNWString("ItemClass", item)
	ent:Spawn()
	ent:Activate()

	if ply.EquippedArmor == tostring(item) then
		UseFunc_RemoveArmor(ply, item)
	end

	return true
end


function UseFunc_EquipArmor(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() or !GAMEMODE.ItemsList[item] or !ply:Alive() then return false end

	if !timer.Exists("plywantstoremovearmor"..ply:EntIndex().."_"..item) and ply.EquippedArmor == item then
		timer.Create("plywantstoremovearmor"..ply:EntIndex().."_"..item, 10, 1, function() end)
		ply:SendChat("Unequip "..translate.ClientGet(ply, item.."_n").."? Use the same armor again to confirm.")
		return false
	elseif timer.Exists("plywantstoremovearmor"..ply:EntIndex().."_"..item) and ply.EquippedArmor == item then
		ply:SendUseDelay(3)
		ply:EmitSound("npc/combine_soldier/zipline_hitground2.wav")
		timer.Simple(3, function()
			if !ply:IsValid() or !ply:Alive() then return false end
			ply:SystemMessage(Format("You unequipped %s.", translate.ClientGet(ply, item.."_n")), Color(205,255,205,255), false)
			UseFunc_RemoveArmor(ply, item)
		end)
		return false
	end

	ply:SendUseDelay(3)
	ply:EmitSound("npc/combine_soldier/zipline_hitground1.wav")

	timer.Create("Isplyequippingarmor"..ply:EntIndex(), 3, 1, function() end)
	timer.Create("Isplyequippingarmor"..ply:EntIndex().."_"..item, 3, 1, function()
		if !ply:IsValid() or !ply:Alive() then return false end
		ply:SystemMessage("You equipped "..translate.ClientGet(ply, item.."_n")..". Use the same armor again to unequip.", Color(205,255,205,255), false)
		ply.EquippedArmor = tostring(item)
		ply:SetNWString("ArmorType", tostring(item))
		gamemode.Call("RecalcPlayerModel", ply)
		gamemode.Call("RecalcPlayerSpeed", ply)
	end)

	return false
end

function ForceEquipArmor(ply, item) --Same as Equip armor, but we don't want to have cooldown from moving nor make noise of equipping armor when spawning right?
	if !SERVER then return false end
	if !ply:IsValid() or !GAMEMODE.ItemsList[item] then return false end
	
	local used = GAMEMODE.ItemsList[item]
	
	ply.EquippedArmor = tostring(item)
	ply:SetNWString("ArmorType", tostring(item))
	gamemode.Call("RecalcPlayerModel", ply)
	gamemode.Call("RecalcPlayerSpeed", ply)

	return false	
end

function UseFunc_RemoveArmor(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	local used = GAMEMODE.ItemsList[item]

	ply.EquippedArmor = "none"
	ply:SetNWString("ArmorType", "none")
	gamemode.Call("RecalcPlayerModel", ply)
	gamemode.Call("RecalcPlayerSpeed", ply)
	return false
end

function UseFunc_DeployBed(ply, type)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local ent = ents.Create("bed")
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0, 0, 0))
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply

	for k, v in pairs(ents.FindByClass("bed")) do
		if v == ent then continue end
		if !v.Owner:IsValid() or v.Owner == ply then v:Remove() end
	end
	return true
end


function UseFunc_EquipGun(ply, gun)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	if ply:GetActiveWeapon() != gun then
		ply:Give(gun)
		ply:SelectWeapon(gun)
	end
	return false
end

function UseFunc_EquipNade(ply, gun, nadetype)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	ply:GiveAmmo(1, nadetype)
	ply:Give(gun)

	if ply:GetActiveWeapon() != gun then
		ply:SelectWeapon(gun)
	end
	return true
end

function UseFunc_GiveAmmo(ply, amount, type)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	ply:GiveAmmo(amount, type)
	return true
end


function UseFunc_Heal(ply, targetply, usetime, hp, infection, snd)
	if !SERVER then return false end
	if !ply:IsValid() or !targetply:IsValid() then return false end
	if ply:Alive() then
		if ply ~= targetply then
			if targetply:Health() >= targetply:GetMaxHealth() and targetply.Infection < 1 then
				ply:SendChat(translate.ClientGet(ply, "this_player_has_no_injuries"))
				return false
			end
		else
			if ply:Health() >= ply:GetMaxHealth() and ply.Infection < 1 then
				ply:SendChat(translate.ClientGet(ply, "you_are_perfectly_fine"))
				return false
			end
		end

		local healedhp = math.min(targetply:GetMaxHealth() - targetply:Health(), hp * (1 + (ply.StatMedSkill * 0.025)))
		targetply:SetHealth(math.Clamp(targetply:Health() + healedhp, 0, targetply:GetMaxHealth()))
		targetply.Infection = math.Clamp(targetply.Infection - (infection * 100), 0, 10000)
		targetply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime)
		if ply ~= targetply then
			ply.XP = ply.XP + math.floor(healedhp)
			ply:SendChat(translate.ClientFormat(ply, "healed_x_for_y", targetply:Nick(), healedhp, math.floor(healedhp*1.5)))
			gamemode.Call("GiveTaskProgress", ply, "medical_attention", 1)
		end
		timer.Create("Isplyusingitem"..ply:EntIndex(), usetime, 1, function()
			timer.Destroy("Isplyusingitem"..ply:EntIndex())
		end)
		return true
	else
		return false -- return false. do not use the item.
	end
end

function UseFunc_HealInfection(ply, usetime, infection, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:Alive() then
		if ply.Infection < 1 then ply:SendChat("You are feeling well, why would you use antidote now?") return false end
		ply.Infection = math.Clamp(ply.Infection - (infection * 100), 0, 10000)
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime)
		timer.Create("Isplyusingitem"..ply:EntIndex(), usetime, 1, function() end)
		return true
	else
		ply:SendChat(translate.ClientGet(ply, "you_could_have_healed_before_died"))
		return false
	end
end

function UseFunc_Armor(ply, usetime, battery, armor, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:Alive() then
		if ply:Armor() >= ply:GetMaxArmor() then
			ply:SendChat(translate.ClientGet(ply, "your_armor_is_at_full_condition"))
			return false
		end
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = GAMEMODE.ItemsList[armorstr]
		ply.Battery = math.Clamp(ply.Battery + battery, 0, 100 + (armortype and armorstr and armortype["ArmorStats"]["battery"] or 0))
		ply:SetArmor(math.Clamp(ply:Armor() + (armor * (1 + (ply.StatEngineer * 0.02))), 0, ply:GetMaxArmor()))
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime)
		timer.Create("Isplyusingitem"..ply:EntIndex(), usetime, 1, function() end)
		return true
	else
		ply:SendChat(translate.ClientGet(ply, "could_have_used_armor_before_died"))
		return false
	end
end

function UseFunc_Eat(ply, usetime, health, hunger, thirst, stamina, fatigue, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:Alive() then
		ply:SetHealth(math.Clamp(ply:Health() + health, 0, ply:GetMaxHealth()))
		ply.Hunger = math.Clamp(ply.Hunger + (hunger * 100), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst + (thirst * 100), 0, 10000)
		ply.Stamina = math.Clamp(ply.Stamina + stamina, 0, 100)
		ply.Fatigue = math.Clamp(ply.Fatigue + (fatigue * 100), 0, 10000)
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime)
		timer.Create("Isplyusingitem"..ply:EntIndex(), usetime, 1, function() end)
		return true
	else
		ply:SendChat("You can't eat when you're dead") -- if they try to call this function when they are dead
		return false
	end
end

function UseFunc_Drink(ply, usetime, health, hunger, thirst, stamina, fatigue, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:WaterLevel() == 3 then ply:SendChat("It is impossible to drink when you are underwater. Get out of the water if you want to drink.") return false end
	if ply:Alive() then
		ply:SetHealth(math.Clamp(ply:Health() + health, 0, ply:GetMaxHealth()))
		ply.Hunger = math.Clamp(ply.Hunger + (hunger * 100), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst + (thirst * 100), 0, 10000)
		ply.Stamina = math.Clamp(ply.Stamina + stamina, 0, 100)
		ply.Fatigue = math.Clamp(ply.Fatigue + (fatigue * 100), 0, 10000)
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime)
		timer.Create("Isplyusingitem"..ply:EntIndex(), usetime, 1, function() end)
		return true
	else
		return false
	end
end

function UseFunc_Respec(ply)
	if !ply:IsValid() or !ply:Alive() then return false end
	if ply.StatsReset and tonumber(ply.StatsReset) > os.time() then
		ply:SendChat(Format("Can't use this item! Wait for %d more seconds!", ply.StatsReset - os.time()))
		return false
	end

	local reset, callback = ply:SkillsReset()
	if not reset then
		if callback then
			callback(ply)
		end
		return false
	end

	ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")

	ply.StatsReset = os.time() + 86400
	ply:SystemMessage(translate.ClientGet(ply, "itemusedskillsreset"), Color(255,255,205,255), true)

	return reset
end

function UseFunc_StripWeapon(ply, class, drop) -- use false to strip weapon but not to give ammo unless gamemode function is ok
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	if ply.Inventory[class] < 2 and drop then -- i have no idea if this should be true or false, but i think it should be
		local wep = ply:GetWeapon(class)
		if IsValid(wep) and wep:IsWeapon() then
			local clip1 = tonumber(wep:Clip1()) or 0
			local clip2 = tonumber(wep:Clip2()) or 0
			if clip1 > 0 then ply:GiveAmmo(clip1, wep:GetPrimaryAmmoType()) end
			if clip2 > 0 then ply:GiveAmmo(clip2, wep:GetSecondaryAmmoType()) end
		end
		ply:StripWeapon(class)
	end
	return true
end


-- Add every file in items folder.
-- Note: Adds support for custom made items via steam workshop!
for k,v in pairs(file.Find("gamemodes/"..engine.ActiveGamemode().."/gamemode/items/*.lua", "GAME")) do
	if SERVER then
		AddCSLuaFile("items/"..v)
	end

	include("items/"..v)
end
