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
-- DO NOT USE ARCCW! ArcCW will give players ammuntion when they select an ARCCW weapon for the first time.
-- Regardless if it should give ammo or not on PLAYER:Give function! (And no, there are no other ways to prevent this.)


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
	if not ply:CheckCanSleep() then return end
	
	ply:GoSleep()

	if bheal then
		ply:SetHealth(ply:GetMaxHealth())
	end
end

function UseFunc_DeployBed(ply)
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

function UseFunc_DropEntity(ply, ent)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local ent = ents.Create(ent)
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0, 0, 0))
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply

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
		ply:SendUseDelay(usetime, "Healing...")
		if ply ~= targetply then
			ply.XP = ply.XP + math.floor(healedhp)
			ply:SendChat(translate.ClientFormat(ply, "healed_x_for_y", targetply:Nick(), healedhp, math.floor(healedhp*1.5)))
			gamemode.Call("GiveTaskProgress", ply, "medical_attention", 1)
		end
		return true
	else
		return false -- return false. do not use the item.
	end
end

function UseFunc_HealInfection(ply, usetime, infection, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:Alive() then
		if ply.Infection < 1 then ply:SendChat(translate.ClientGet(ply, "antidote_usage_not_infected")) return false end
		ply.Infection = math.Clamp(ply.Infection - (infection * 100), 0, 10000)
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime, "Healing infection...")
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
		ply:SendUseDelay(usetime, "Reinforcing armor...")
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
		ply:SendUseDelay(usetime, "Eating food...")
		return true
	else
		-- if they try to call this function when they are dead
		ply:SendChat(translate.ClientGet(ply, table.Random({"cant_eat_if_dead1", "cant_eat_if_dead2", "cant_eat_if_dead3", "cant_eat_if_dead4"})))
		return false
	end
end

function UseFunc_Drink(ply, usetime, health, hunger, thirst, stamina, fatigue, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if ply:WaterLevel() == 3 then
		ply:SendChat(translate.ClientGet(ply, "cant_drink_underwater"))
		return false
	end
	if ply:Alive() then
		ply:SetHealth(math.Clamp(ply:Health() + health, 0, ply:GetMaxHealth()))
		ply.Hunger = math.Clamp(ply.Hunger + (hunger * 100), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst + (thirst * 100), 0, 10000)
		ply.Stamina = math.Clamp(ply.Stamina + stamina, 0, 100)
		ply.Fatigue = math.Clamp(ply.Fatigue + (fatigue * 100), 0, 10000)
		ply:EmitSound(snd, 100, 100)
		ply:SendUseDelay(usetime, "Drinking...")
		return true
	else
		return false
	end
end

function UseFunc_Respec(ply)
	if !ply:IsValid() or !ply:Alive() then return false end

	local reset, callback = ply:SkillsReset()
	if not reset then
		if callback then
			callback(ply)
		end
		return false
	end

	ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")
	ply:SystemMessage(translate.ClientGet(ply, "itemusedskillsreset"), Color(255,255,205,255), true)

	return reset
end


-- Add every file in items folder.
-- Note: Adds support for custom made items via steam workshop!
for k,v in pairs(file.Find(GM.FolderName.."/gamemode/items/*.lua", "LUA")) do
	if SERVER then
		AddCSLuaFile("items/"..v)
	end

	include("items/"..v)
end
