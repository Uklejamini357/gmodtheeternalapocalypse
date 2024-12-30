--sorry i haven't finished m9k item list yet
/*
Item template:

["item_healthkit"] = {							-- what the item will be called within the games code, can be anything as long as you don't use the same name twice
	Cost = 200,								-- how much money will it cost if you buy it from the trader?
	Model = "models/Items/HealthKit.mdl",	-- the items model
	Weight = 1,								-- weight in kilograms (if your american and want to use imperial then your shit out of luck m8)
	Supply = 0,								-- how many of these items does each trader have in stock? stock refills every 24 hours. (Stock limits don't work, will try to fix/add one) Putting 0 means unlimited stock, Putting -1 as stock will make it so the item isn't sold by traders
	Rarity = 1,								-- 0 = trash, 1 = junk, 2 = common, 3 = uncommon, 4 = rare, 5 = super rare, 6 = epic, 7 = mythic, 8 = legendary, 9 = godly, 10 = event, 11 = unobtainable, any other = uncategorized
	Category = 1,							-- 1 = supplies, 2 = ammunition, 3 = weapons, 4 = armor, any other = ignored by trader
	UseFunc = function(ply) end,			-- the function to call when the player uses the item from their inventory, you will need lua skillz here
	DropFunc = function(ply) end,			-- the function to call when the player drops the item, just like usefunc, you need to know lua here
	IsGrenade = false						-- if the item is grenade then it will confirm that it's grenade (this is used when selling items, not to remove grenade from inventory when selling). Not needed when an item is not a grenade.
	IsSecret = false,						-- Item cannot be spawned with from spawn menu nor from giving item command (Can still be spawned if player is dev)
}


// IMPORTANT NOTE: Use and drop functions must always return true or false here.  Returning true will subtract one of that item type from the player, returning false will make it so nothing is subtracted.
see server/player_inventory.lua for more info


*/

GM.ItemsList = {}
function GM:CreateItem(itemid, name, desc, cost, model, weight, supply, rarity, category, usefunc, dropfunc)
	self.ItemsList[itemid] = {
		Name = name,
		Description = desc,
		Cost = cost,
		Model = model,
		Weight = weight,
		Supply = supply,
		Rarity = rarity,
		Category = category,
		UseFunc = usefunc,
		DropFunc = dropfunc,
	}

	return self.ItemsList[itemid]
end

-- apparently no idea why i removed item.Name and item.Decription because for translate but yea (then it would use item.Name and item.Description if it's valid)

local trans_get = translate.Get
local trans_format = translate.Format


GM.ItemsList = {



-- sellables





	["item_radio"] = {
		Cost = 300,
		Model = "models/wick/wrbstalker/anomaly/items/dez_radio.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_radio") return drop end
	},

	["item_scrap"] = {
		Cost = 350,
		Model = "models/Gibs/helicopter_brokenpiece_02.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local armor = UseFunc_Armor(ply, 3, 0, 10, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_scrap") return drop end
	},

	["item_chems"] = {
		Cost = 600,
		Model = "models/props_junk/plasticbucket001a.mdl",
		Weight = 1.5,
		Supply = -1,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_chems") return drop end
	},

	["item_tv"] = {
		Cost = 800,
		Model = "models/props_c17/tv_monitor01.mdl",
		Weight = 2,
		Supply = -1,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_tv") return drop end
	},

	["item_beer"] = {
		Cost = 1200,
		Model = "models/props/CS_militia/caseofbeer01.mdl",
		Weight = 5,
		Supply = -1,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_beer") return drop end
	},

	["item_hamradio"] = {
		Cost = 1500,
		Model = "models/props_lab/citizenradio.mdl",
		Weight = 2.5,
		Supply = -1,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_hamradio") return drop end
	},

	["item_computer"] = {
		Cost = 2000,
		Model = "models/props_lab/harddrive02.mdl",
		Weight = 4,
		Supply = -1,
		Rarity = 4,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_computer") return drop end
	},


	["item_blueprint_sawbow"] = {
		Cost = 5000,
		Model = "models/props_lab/clipboard.mdl",
		Weight = 0.25,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouseweapon")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_sawbow") return drop end
	},

	["item_blueprint_railgun"] = {
		Cost = 5000,
		Model = "models/props_lab/clipboard.mdl",
		Weight = 0.25,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouseweapon")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_railgun") return drop end
	},








-- junk




	["item_junk_tin"] = {
		Cost = 0,
		Model = "models/props_junk/garbage_metalcan002a.mdl",
		Weight = 0.1,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_tin") return drop end
	},

	["item_junk_boot"] = {
		Cost = 0,
		Model = "models/props_junk/Shoe001a.mdl",
		Weight = 0.17,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_boot") return drop end
	},


	["item_junk_paper"] = {
		Cost = 0,
		Model = "models/props_junk/garbage_newspaper001a.mdl",
		Weight = 0.12,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paper") return drop end
	},

	["item_junk_keyboard"] = {
		Cost = 0,
		Model = "models/props_c17/computer01_keyboard.mdl",
		Weight = 0.23,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_keyboard") return drop end
	},

	["item_junk_gardenpot"] = {
		Cost = 0,
		Model = "models/props_junk/terracotta01.mdl",
		Weight = 0.25,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_gardenpot") return drop end
	},

	["item_junk_paint"] = {
		Cost = 0,
		Model = "models/props_junk/metal_paintcan001a.mdl",
		Weight = 0.25,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paint") return drop end
	},

	["item_junk_doll"] = {
		Cost = 0,
		Model = "models/props_c17/doll01.mdl",
		Weight = 0.15,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_doll") return drop end
	},

	["item_junk_pot"] = {
		Cost = 0,
		Model = "models/props_interiors/pot02a.mdl",
		Weight = 0.2,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end
	},

	["item_junk_hula"] = {
		Cost = 0,
		Model = "models/props_lab/huladoll.mdl",
		Weight = 0.1,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_hula") return drop end
	},

	["item_junk_nailbox"] = {
		Cost = 0,
		Model = "models/props_lab/box01a.mdl",
		Weight = 0.06,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_nailbox") return drop end
	},

	["item_junk_twig"] = {
		Cost = 0,
		Model = "models/props/cs_office/Snowman_arm.mdl",
		Weight = 0.1,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end
	},

-- GOODBYE UPGRADE IMMUNITY SKILL ITEM!!


-- crafting related


	["item_craft_fueltank"] = {
		Cost = 500,
		Model = "models/props_junk/metalgascan.mdl",
		Weight = 0.25,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_fueltank") return drop end
	},

	["item_craft_wheel"] = {
		Cost = 300,
		Model = "models/props_vehicles/carparts_wheel01a.mdl",
		Weight = 1.5,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_wheel") return drop end
	},

	["item_craft_oil"] = {
		Cost = 500,
		Model = "models/props_junk/garbage_plasticbottle001a.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_oil") return drop end
	},

	["item_craft_battery"] = {
		Cost = 500,
		Model = "models/Items/car_battery01.mdl",
		Weight = 0.6,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousecraftable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_battery") return drop end
	},

	["item_craft_ecb"] = {
		Cost = 250,
		Model = "models/props_lab/reciever01b.mdl",
		Weight = 0.35,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousecraftable")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_ecb") return drop end
	},

	["item_craft_engine_small"] = {
		Cost = 1000,
		Model = "models/gibs/airboat_broken_engine.mdl",
		Weight = 3,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_small") return drop end
	},

	["item_craft_engine_large"] = {
		Cost = 3000,
		Model = "models/props_c17/TrapPropeller_Engine.mdl",
		Weight = 5,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_large") return drop end
	},


	-- Misc


	["item_boss_shard"] = {
		Cost = 45000,
		Model = "models/props_junk/rock001a.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = RARITY_EVENT,
		Category = 1,
		UseFunc = function(ply)
			local random = table.Random({
				"This is going to be a terrible time...",
				"Calm before the storm...",
				"A boss is being created by the unknown powers...",
				"There is no going back now...",
			})
			GAMEMODE:SystemBroadcast(random, Color(115,205,205), false)
			GAMEMODE:SpawnBoss(#player.GetAll() + 8, true)
		return true end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_boss_shard") return drop end
	},

	["item_difficulty_shard"] = {
		Cost = 35000,
		Model = "models/props_junk/rock001a.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = RARITY_EVENT,
		Category = 1,
		UseFunc = function(ply)
			if GAMEMODE.InfectionLevelIncreaseType ~= 1 then PrintMessage(3, "Item is unusable currently at the moment due to config setting (GAMEMODE.InfectionLevelIncreaseType need to be 1)") return false end
			local random = table.Random({
				"You feel like zombies suddenly become stronger...",
				"Zombies become stronger. This isn't good...",
				"You are not going to survive this...",
			})

			local set = math.max(0, GAMEMODE:GetInfectionLevel() + 50)
			GAMEMODE:SystemBroadcast(random.." ("..GAMEMODE:GetInfectionLevel().."% -> "..set.."%)", Color(115,205,205), false)
			GAMEMODE:SetInfectionLevel(set)
		return true end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_difficulty_shard") return drop end
	},

	["item_money"] = {
		Cost = 0,
		Model = "models/props/cs_assault/Money.mdl",
		Weight = 0,
		Supply = -1,
		Rarity = RARITY_COMMON,
		Category = 1,
		UseFunc = function(ply) ply:SendChat("Added "..ply.Inventory["item_money"].."$ to account") ply.Money = ply.Money + ply.Inventory["item_money"] ply.Inventory["item_money"] = nil return false end,
		DropFunc = function(ply) ply:SendChat("You may not drop this item.") --[[local drop = UseFunc_DropItem(ply, "item_money") return drop]] return false end
	},

	["item_moneyprinter"] = {
		Cost = 0,
		Model = "models/props_c17/consolebox01a.mdl",
		Weight = 5,
		Supply = -1,
		Rarity = 6,
		Category = 1,
		UseFunc = function(ply) ply:SendChat("Added "..ply.Inventory["item_money"].."$ to account") ply.Money = ply.Money + ply.Inventory["item_money"] ply.Inventory["item_money"] = nil return false end,
		DropFunc = function(ply) ply:SendChat("You may not drop this item.") --[[local drop = UseFunc_DropItem(ply, "item_money") return drop]] return false end
	},



-- guns





	["weapon_tea_noobcannon"] = {
		Cost = 0,
		Model = "models/weapons/w_pist_glock18.mdl",
		Weight = 1.1,
		Supply = -1, -- -1 stock means the traders will never sell this item (Comment: yea we get it)
		Rarity = 1,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_noobcannon") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_noobcannon") UseFunc_StripWeapon(ply, "weapon_tea_noobcannon", drop) return drop end
	},

	["weapon_tea_pigsticker"] = {
		Cost = 350,
		Model = "models/weapons/w_knife_ct.mdl",
		Weight = 0.38,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_pigsticker") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_pigsticker") UseFunc_StripWeapon(ply, "weapon_tea_pigsticker", drop) return drop end
	},

	["weapon_tea_axe"] = {
		Cost = 800,
		Model = "models/props/CS_militia/axe.mdl",
		Weight = 1.73,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_axe") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_axe") UseFunc_StripWeapon(ply, "weapon_tea_axe", drop) return drop end
	},

	["weapon_tea_wrench"] = {
		Cost = 800,
		Model = "models/props_c17/tools_wrench01a.mdl",
		Weight = 0.47,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_wrench") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_wrench") UseFunc_StripWeapon(ply, "weapon_tea_wrench", drop) return drop end
	},

	["weapon_tea_repair"] = {
		Cost = 5500,
		Model = "models/props_c17/tools_wrench01a.mdl",
		Weight = 0.58,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_repair") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_repair") UseFunc_StripWeapon(ply, "weapon_tea_repair", drop) return drop end
	},

	["weapon_tea_scrapsword"] = {
		Cost = 2000,
		Model = "models/props_c17/TrapPropeller_Blade.mdl",
		Weight = 5.3,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scrapsword") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scrapsword") UseFunc_StripWeapon(ply, "weapon_tea_scrapsword", drop) return drop end
	},

	["weapon_tea_g20"] = {
		Cost = 450,
		Model = "models/weapons/w_pist_glock18.mdl",
		Weight = 1.18,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_g20") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_g20") UseFunc_StripWeapon(ply, "weapon_tea_g20", drop) return drop end
	},

	["weapon_tea_57"] = {
		Cost = 600,
		Model = "models/weapons/w_pist_fiveseven.mdl",
		Weight = 0.82,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_57") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_57") UseFunc_StripWeapon(ply, "weapon_tea_57", drop) return drop end
	},

	["weapon_tea_u45"] = {
		Cost = 700,
		Model = "models/weapons/w_pist_usp.mdl",
		Weight = 1.1,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_u45") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_u45") UseFunc_StripWeapon(ply, "weapon_tea_u45", drop) return drop end
	},


	["weapon_tea_warren50"] = {
		Cost = 850,
		Model = "models/weapons/w_pist_deagle.mdl",
		Weight = 1.73,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_warren50") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_warren50") UseFunc_StripWeapon(ply, "weapon_tea_warren50", drop) return drop end
	},

	["weapon_tea_python"] = {
		Cost = 1200,
		Model = "models/weapons/w_357.mdl",
		Weight = 1.18,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_python") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_python") UseFunc_StripWeapon(ply, "weapon_tea_python", drop) return drop end
	},

	["weapon_tea_dual"] = {
		Cost = 2000,
		Model = "models/weapons/w_pist_elite.mdl",
		Weight = 2.72,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dual") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dual") UseFunc_StripWeapon(ply, "weapon_tea_dual", drop) return drop end
	},

	["weapon_tea_satan"] = {
		Cost = 2250,
		Model = "models/weapons/w_m29_satan.mdl",
		Weight = 3.14,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_satan") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_satan") UseFunc_StripWeapon(ply, "weapon_tea_satan", drop) return drop end
	},

	["weapon_tea_mp11"] = {
		Cost = 2250,
		Model = "models/weapons/w_smg_mac10.mdl",
		Weight = 2.85,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_mp11") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_mp11") UseFunc_StripWeapon(ply, "weapon_tea_mp11", drop) return drop end
	},

	["weapon_tea_rg900"] = {
		Cost = 2500,
		Model = "models/weapons/w_smg_tmp.mdl",
		Weight = 2.9,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_rg900") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_rg900") UseFunc_StripWeapon(ply, "weapon_tea_rg900", drop) return drop end
	},

	["weapon_tea_k5a"] = {
		Cost = 3250,
		Model = "models/weapons/w_smg_mp5.mdl",
		Weight = 3,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k5a") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k5a") UseFunc_StripWeapon(ply, "weapon_tea_k5a", drop) return drop end
	},

	["weapon_tea_stinger"] = {
		Cost = 2800,
		Model = "models/weapons/w_smg1.mdl",
		Weight = 3.85,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_stinger") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_stinger") UseFunc_StripWeapon(ply, "weapon_tea_stinger", drop) return drop end
	},

	["weapon_tea_bosch"] = {
		Cost = 3750,
		Model = "models/weapons/w_sten.mdl",
		Weight = 3.45,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_bosch") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_bosch") UseFunc_StripWeapon(ply, "weapon_tea_bosch", drop) return drop end
	},

	["weapon_tea_k8"] = {
		Cost = 5000,
		Model = "models/weapons/w_smg_ump45.mdl",
		Weight = 3.12,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k8") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k8") UseFunc_StripWeapon(ply, "weapon_tea_k8", drop) return drop end
	},

	["weapon_tea_k8c"] = {
		Cost = 5500,
		Model = "models/weapons/w_hk_usc.mdl",
		Weight = 3.15,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k8c") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k8c") UseFunc_StripWeapon(ply, "weapon_tea_k8c", drop) return drop end
	},

	["weapon_tea_shredder"] = {
		Cost = 7750,
		Model = "models/weapons/w_smg_p90.mdl",
		Weight = 3,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_shredder") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_shredder") UseFunc_StripWeapon(ply, "weapon_tea_shredder", drop) return drop end
	},

	["weapon_tea_enforcer"] = {
		Cost = 5000,
		Model = "models/weapons/w_shot_m3super90.mdl",
		Weight = 3.6,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_enforcer") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_enforcer") UseFunc_StripWeapon(ply, "weapon_tea_enforcer", drop) return drop end
	},

	["weapon_tea_sweeper"] = {
		Cost = 7750,
		Model = "models/weapons/w_shot_xm1014.mdl",
		Weight = 3.8,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_sweeper") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_sweeper") UseFunc_StripWeapon(ply, "weapon_tea_sweeper", drop) return drop end
	},

	["weapon_tea_ranger"] = {
		Cost = 7250,
		Model = "models/weapons/w_rif_m4a1.mdl",
		Weight = 4.2,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_ranger") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_ranger") UseFunc_StripWeapon(ply, "weapon_tea_ranger", drop) return drop end
	},

	["weapon_tea_fusil"] = {
		Cost = 7150,
		Model = "models/weapons/w_rif_famas.mdl",
		Weight = 4,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_fusil") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_fusil") UseFunc_StripWeapon(ply, "weapon_tea_fusil", drop) return drop end
	},

	["weapon_tea_stugcommando"] = {
		Cost = 9750, 
		Model = "models/weapons/w_rif_sg552.mdl",
		Weight = 4.45,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_stugcommando") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_stugcommando") UseFunc_StripWeapon(ply, "weapon_tea_stugcommando", drop) return drop end
	},


	["weapon_tea_krukov"] = {
		Cost = 11000,
		Model = "models/weapons/w_rif_ak47.mdl",
		Weight = 3.76,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_krukov") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_krukov") UseFunc_StripWeapon(ply, "weapon_tea_krukov", drop) return drop end
	},

	["weapon_tea_l303"] = {
		Cost = 13500,
		Model = "models/weapons/w_rif_galil.mdl",
		Weight = 5.35,
		Supply = -1,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_l303") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_l303") UseFunc_StripWeapon(ply, "weapon_tea_l303", drop) return drop end
	},

	["weapon_tea_scar"] = {
		Cost = 22000,
		Model = "models/weapons/w_fn_scar_h.mdl",
		Weight = 4.6,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scar") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scar") UseFunc_StripWeapon(ply, "weapon_tea_scar", drop) return drop end
	},

	["weapon_tea_lmg"] = {
		Cost = 17250,
		Model = "models/weapons/w_mach_m249para.mdl",
		Weight = 7.5,
		Supply = 0,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_lmg") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_lmg") UseFunc_StripWeapon(ply, "weapon_tea_lmg", drop) return drop end
	},


	["weapon_tea_antelope"] = {
		Cost = 9200,
		Model = "models/weapons/w_snip_scout.mdl",
		Weight = 5.25,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_antelope") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_antelope") UseFunc_StripWeapon(ply, "weapon_tea_antelope", drop) return drop end
	},

	["weapon_tea_scimitar"] = {
		Cost = 12250,
		Model = "models/weapons/w_snip_g3sg1.mdl",
		Weight = 5.4,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scimitar") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scimitar") UseFunc_StripWeapon(ply, "weapon_tea_scimitar", drop) return drop end
	},

	["weapon_tea_blackhawk"] = {
		Cost = 15000,
		Model = "models/weapons/w_snip_sg550.mdl",
		Weight = 6.35,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_blackhawk") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_blackhawk") UseFunc_StripWeapon(ply, "weapon_tea_blackhawk", drop) return drop end
	},

	["weapon_tea_punisher"] = {
		Cost = 35000,
		Model = "models/weapons/w_acc_int_aw50.mdl",
		Weight = 7.95,
		Supply = 5,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_punisher") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_punisher") UseFunc_StripWeapon(ply, "weapon_tea_punisher", drop) return drop end
	},

	["weapon_tea_scrapcrossbow"] = {
		Cost = 15000,
		Model = "models/weapons/w_crossbow.mdl",
		Weight = 8,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scrapcrossbow") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scrapcrossbow") UseFunc_StripWeapon(ply, "weapon_tea_scrapcrossbow", drop) return drop end
	},

	["weapon_tea_winchester"] = {
		Cost = 6500,
		Model = "models/weapons/w_winchester_1873.mdl",
		Weight = 5.32,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_winchester") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_winchester") UseFunc_StripWeapon(ply, "weapon_tea_winchester", drop) return drop end
	},

	["weapon_tea_perrin"] = {
		Cost = 8500,
		Model = "models/weapons/w_pp19_bizon.mdl",
		Weight = 3.72,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_perrin") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_perrin") UseFunc_StripWeapon(ply, "weapon_tea_perrin", drop) return drop end
	},

	["weapon_tea_dammerung"] = {
		Cost = 12200,
		Model = "models/weapons/w_usas_12.mdl",
		Weight = 6.72,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dammerung") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dammerung") UseFunc_StripWeapon(ply, "weapon_tea_dammerung", drop) return drop end
	},

	["weapon_tea_rpg"] = {
		Cost = 55000,
		Model = "models/weapons/w_rocket_launcher.mdl",
		Weight = 7.2,
		Supply = 0,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_rpg") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_rpg") UseFunc_StripWeapon(ply, "weapon_tea_rpg", drop) return drop end
	},


	["weapon_tea_fuckinator"] = {
		Cost = 28750,
		Model = "models/weapons/w_pist_p228.mdl",
		Weight = 8.74,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_fuckinator") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_fuckinator") UseFunc_StripWeapon(ply, "weapon_tea_fuckinator", drop) return drop end
	},

	["weapon_tea_germanator"] = {
		Cost = 6800,
		Model = "models/weapons/w_mp40smg.mdl",
		Weight = 3.34,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_germanator") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_germanator") UseFunc_StripWeapon(ply, "weapon_tea_germanator", drop) return drop end
	},

	["weapon_tea_807"] = {
		Cost = 5800,
		Model = "models/weapons/w_remington_870_tact.mdl",
		Weight = 3.82,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_807") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_807") UseFunc_StripWeapon(ply, "weapon_tea_807", drop) return drop end
	},

	["weapon_tea_crowbar"] = {
		Cost = 50000,
		Model = "models/weapons/w_crowbar.mdl",
		Weight = 6.17,
		Supply = -1,
		Rarity = 9,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_crowbar") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_crowbar") UseFunc_StripWeapon(ply, "weapon_tea_crowbar", drop) return drop end
	},


-- some ammunition


	["item_pistolammo"] = {
		Cost = 45,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 1,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end
	},

	["item_m9k_smgammo"] = {
		Cost = 70,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "SMG1") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_smgammo") return drop end
	},

	["item_m9k_assaultammo"] = {
		Cost = 95,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "AR2") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_assaultammo") return drop end
	},

	["item_m9k_sniperammo"] = {
		Cost = 150,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "SniperPenetratedRound") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_sniperammo") return drop end
	},

	["item_magammo"] = {
		Cost = 60,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_357_jhp.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_magammo") return drop end
	},

	["item_buckshotammo"] = {
		Cost = 65,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_buckshotammo") return drop end
	},

	["item_rifleammo"] = {
		Cost = 90,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_rifleammo") return drop end
	},

	["item_sniperammo"] = {
		Cost = 130,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end
	},

	["item_ar2pulseammo"] = {
		Cost = 150,
		Model = "models/Items/combine_rifle_cartridge01.mdl",
		Weight = 1,
		Supply = 10,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_ar2_pulseammo") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_ar2pulseammo") return drop end
	},

	["item_crossbowbolt"] = {
		Cost = 40,
		Model = "models/Items/CrossbowRounds.mdl",
		Weight = 0.3,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 6, "XBowBolt") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt") return drop end
	},

	["item_crossbowbolt_crate"] = {
		Cost = 150,
		Model = "models/Items/item_item_crate.mdl",
		Weight = 1.5,
		Supply = 0,
		Rarity = 3,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "XBowBolt") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt_crate") return drop end
	},

	["item_rocketammo"] = {
		Cost = 180,
		Model = "models/weapons/w_missile_closed.mdl",
		Weight = 1.74,
		Supply = 0,
		Rarity = 3,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_rocketammo") return drop end
	},


-- Following weapons not included in AtE, so they are included in this release


	["weapon_tea_falcon"] = {
		Cost = 1500,
		Model = "models/weapons/s_dmgf_co1911.mdl",
		Weight = 1.4,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_falcon") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_falcon") UseFunc_StripWeapon(ply, "weapon_tea_falcon", drop) return drop end
	},

	["weapon_tea_spas"] = {
		Cost = 7000,
		Model = "models/weapons/w_shotgun.mdl",
		Weight = 3.6,
		Supply = 0,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_spas") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_spas") UseFunc_StripWeapon(ply, "weapon_tea_spas", drop) return drop end
	},

	["weapon_tea_lbr"] = {
		Cost = 15500,
		Model = "models/weapons/w_snip_m14sp.mdl",
		Weight = 3.8,
		Supply = 0,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_lbr") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_lbr") UseFunc_StripWeapon(ply, "weapon_tea_lbr", drop) return drop end
	},
	
	["weapon_tea_aug"] = {
		Cost = 16000,
		Model = "models/weapons/w_rif_aug.mdl",
		Weight = 5.15,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_aug") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_aug") UseFunc_StripWeapon(ply, "weapon_tea_aug", drop) return drop end,
	},

	["weapon_tea_awm"] = {
		Cost = 22500,
		Model = "models/weapons/w_snip_awp.mdl",
		Weight = 7.65,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_awm") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_awm") UseFunc_StripWeapon(ply, "weapon_tea_awm", drop) return drop end,
	},


-- Other special weapons

	["weapon_tea_plasmalauncher"] = {
		Cost = 0,
		Model = "models/weapons/w_physics.mdl",
		Weight = 20,
		Supply = -1,
		Rarity = 11,
		Category = 3,
		UseFunc = function(ply) ply:SendChat("You could gladly use that weapon, but the ENTITY CLASS FOR THIS DOESN'T EXIST!!!\n(at least for now)") /*UseFunc_EquipGun(ply, "weapon_tea_plasmalauncher")*/ return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_plasmalauncher") UseFunc_StripWeapon(ply, "weapon_tea_plasmalauncher", drop) return drop end,
		["IsSecret"] = true
	},

	["weapon_tea_minigun"] = {
		Cost = 47000,
		Model = "models/weapons/w_m134_minigun.mdl",
		Weight = 16.96,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_minigun") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_minigun") UseFunc_StripWeapon(ply, "weapon_tea_minigun", drop) return drop end
	},

	["weapon_tea_ar2"] = {
		Cost = 18000,
		Model = "models/weapons/w_irifle.mdl",
		Weight = 5.28,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_ar2") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_ar2") UseFunc_StripWeapon(ply, "weapon_tea_ar2", drop) return drop end
	},

	["weapon_tea_combinepistol"] = {
		Cost = 10000,
		Model = "models/weapons/w_cmbhgp.mdl",
		Weight = 2.28,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_combinepistol") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_combinepistol") UseFunc_StripWeapon(ply, "weapon_tea_combinepistol", drop) return drop end
	},

	["weapon_tea_grenade_pipe"] = {
		Cost = 120,
		Model = "models/props_lab/pipesystem03a.mdl",
		Weight = 0.34,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_pipe", "nade_pipebombs") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_pipe") UseFunc_StripWeapon(ply, "weapon_tea_grenade_pipe", drop) return drop end,
		["IsGrenade"] = true
	},

	["weapon_tea_grenade_flare"] = {
		Cost = 65,
		Model = "models/props_lab/pipesystem03a.mdl",
		Weight = 0.4,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_flare", "nade_flares") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_flare") UseFunc_StripWeapon(ply, "weapon_tea_grenade_flare", drop) return drop end,
		["IsGrenade"] = true
	},

	["weapon_tea_grenade_frag"] = {
		Cost = 375,
		Model = "models/weapons/w_eq_fraggrenade.mdl",
		Weight = 0.63,
		Supply = -1,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_frag", "Grenade") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_frag") UseFunc_StripWeapon(ply, "weapon_tea_grenade_frag", drop) return drop end,
		["IsGrenade"] = true
	},

/* -- ugh this thing can just fcking crash the server, there is currently no fix available so include this item at your own risk
	["weapon_tea_grenade_molotov"] = {
		Cost = 400,
		Model = "models/props_junk/garbage_glassbottle003a.mdl",
		Weight = 0.35,
		Supply = 0,
		Rarity = 2,
		Category = 3,
		UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_molotov", "nade_molotov") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_molotov") UseFunc_StripWeapon(ply, "weapon_tea_grenade_molotov", drop) return drop end,
		["IsGrenade"] = true
	},
*/

-- Weapons that were earlier cut in T.E.A., but was added back anyway

	["weapon_tea_amex"] = {
		Cost = 8500,
		Model = "models/weapons/w_rif_xamas.mdl",
		Weight = 5.75,
		Supply = 0,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_amex") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_amex") UseFunc_StripWeapon(ply, "weapon_tea_amex", drop) return drop end,
	},

	["weapon_tea_mars"] = {
		Cost = 17500,
		Model = "models/weapons/w_rif_tavor.mdl",
		Weight = 7.92,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_mars") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_mars") UseFunc_StripWeapon(ply, "weapon_tea_mars", drop) return drop end,
	},

	["weapon_tea_dragunov"] = {
		Cost = 14000,
		Model = "models/weapons/w_svd_dragunov.mdl",
		Weight = 6.3,
		Supply = 0,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dragunov") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dragunov") UseFunc_StripWeapon(ply, "weapon_tea_dragunov", drop) return drop end,
	},

	["weapon_tea_boomstick"] = {
		Cost = 3200,
		Model = "models/weapons/w_double_barrel_shotgun.mdl",
		Weight = 3.2,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_boomstick") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_boomstick") UseFunc_StripWeapon(ply, "weapon_tea_boomstick", drop) return drop end,
	},


-- More Special weapons



	["weapon_tea_deadly_axe"] = {
		Cost = 30000,
		Model = "models/props/CS_militia/axe.mdl",
		Weight = 3.26,
		Supply = 1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_axe") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_axe") UseFunc_StripWeapon(ply, "weapon_tea_deadly_axe", drop) return drop end,
		ModelColor = Color(255, 127, 127) -- not working bruh
	},

	["weapon_tea_deadly_scrapcrossbow"] = {
		Cost = 265000,
		Model = "models/weapons/w_crossbow.mdl",
		Weight = 13.65,
		Supply = 1,
		Rarity = 8,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_scrapcrossbow") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_scrapcrossbow") UseFunc_StripWeapon(ply, "weapon_tea_deadly_scrapcrossbow", drop) return drop end
	},

	["weapon_tea_deadly_minigun"] = {
		Cost = 845000,
		Model = "models/weapons/w_m134_minigun.mdl",
		Weight = 28.52,
		Supply = 1,
		Rarity = 9,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_minigun") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_minigun") UseFunc_StripWeapon(ply, "weapon_tea_deadly_minigun", drop) return drop end
	},



-- M9k guns


	["m9k_coltpython"] = {
		Cost = 2800,
		Model = "models/weapons/w_colt_python.mdl",
		Weight = 1.36,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_coltpython") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_coltpython") UseFunc_StripWeapon(ply, "m9k_coltpython", drop) return drop end
	},

	["m9k_glock"] = {
		Cost = 5600,
		Model = "models/weapons/w_dmg_glock.mdl",
		Weight = 1.56,
		Supply = 0,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_glock") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_glock") UseFunc_StripWeapon(ply, "m9k_glock", drop) return drop end
	},

	["m9k_hk45"] = {
		Cost = 2650,
		Model = "models/weapons/w_hk45c.mdl",
		Weight = 0.96,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_hk45") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_hk45") UseFunc_StripWeapon(ply, "m9k_hk45", drop) return drop end
	},

	["m9k_m92beretta"] = {
		Cost = 2700,
		Model = "models/weapons/w_beretta_m92.mdl",
		Weight = 1.16,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m92beretta") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m92beretta") UseFunc_StripWeapon(ply, "m9k_m92beretta", drop) return drop end
	},

	["m9k_luger"] = {
		Cost = 2750,
		Model = "models/weapons/w_luger_p08.mdl",
		Weight = 1.09,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_luger") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_luger") UseFunc_StripWeapon(ply, "m9k_luger", drop) return drop end
	},

	["m9k_ragingbull"] = {
		Cost = 4225,
		Model = "models/weapons/w_taurus_raging_bull.mdl",
		Weight = 2.16,
		Supply = 0,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ragingbull") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ragingbull") UseFunc_StripWeapon(ply, "m9k_ragingbull", drop) return drop end
	},

	["m9k_scoped_taurus"] = {
		Cost = 5500,
		Model = "models/weapons/w_raging_bull_scoped.mdl",
		Weight = 2.56,
		Supply = 0,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_scoped_taurus") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_scoped_taurus") UseFunc_StripWeapon(ply, "m9k_scoped_taurus", drop) return drop end
	},

	["m9k_remington1858"] = {
		Cost = 3675,
		Model = "models/weapons/w_remington_1858.mdl",
		Weight = 1.46,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_remington1858") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington1858") UseFunc_StripWeapon(ply, "m9k_remington1858", drop) return drop end
	},

	["m9k_model3russian"] = {
		Cost = 3700,
		Model = "models/weapons/w_model_3_rus.mdl",
		Weight = 1.38,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model3russian") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model3russian") UseFunc_StripWeapon(ply, "m9k_model3russian", drop) return drop end
	},

	["m9k_model500"] = {
		Cost = 4550,
		Model = "models/weapons/w_sw_model_500.mdl",
		Weight = 1.86,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model500") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model500") UseFunc_StripWeapon(ply, "m9k_model500", drop) return drop end
	},

	["m9k_model627"] = {
		Cost = 4675,
		Model = "models/weapons/w_sw_model_627.mdl",
		Weight = 1.46,
		Supply = 1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model627") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model627") UseFunc_StripWeapon(ply, "m9k_model627", drop) return drop end
	},

	["m9k_sig_p229r"] = {
		Cost = 3850,
		Model = "models/weapons/w_sig_229r.mdl",
		Weight = 1.31,
		Supply = 0,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_sig_p229r") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sig_p229r") UseFunc_StripWeapon(ply, "m9k_sig_p229r", drop) return drop end
	},
	
	["m9k_acr"] = {
		Cost = 29500,
		Model = "models/weapons/w_masada_acr.mdl",
		Weight = 4.2,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_acr") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_acr") UseFunc_StripWeapon(ply, "m9k_acr", drop) return drop end
	},
	
	["m9k_ak47"] = {
		Cost = 22250,
		Model = "models/weapons/w_ak47_m9k.mdl",
		Weight = 3.8,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ak47") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak47") UseFunc_StripWeapon(ply, "m9k_ak47", drop) return drop end
	},
	
	["m9k_ak74"] = {
		Cost = 22750,
		Model = "models/weapons/w_tct_ak47.mdl",
		Weight = 3.66,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ak74") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak74") UseFunc_StripWeapon(ply, "m9k_ak74", drop) return drop end
	},

	["m9k_amd65"] = {
		Cost = 26500,
		Model = "models/weapons/w_amd_65.mdl",
		Weight = 3.9,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_amd65") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_amd65") UseFunc_StripWeapon(ply, "m9k_amd65", drop) return drop end
	},
	
	["m9k_an94"] = {
		Cost = 31250,
		Model = "models/weapons/w_rif_an_94.mdl",
		Weight = 4.4,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_an94") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_an94") UseFunc_StripWeapon(ply, "m9k_an94", drop) return drop end
	},

	["m9k_val"] = {
		Cost = 33000,
		Model = "models/weapons/w_dmg_vally.mdl",
		Weight = 2.8,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_val") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_val") UseFunc_StripWeapon(ply, "m9k_val", drop) return drop end
	},

	["m9k_f2000"] = {
		Cost = 35750,
		Model = "models/weapons/w_fn_f2000.mdl",
		Weight = 5.24,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_f2000") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_f2000") UseFunc_StripWeapon(ply, "m9k_f2000", drop) return drop end
	},

	["m9k_fal"] = {
		Cost = 28750,
		Model = "models/weapons/w_fn_fal.mdl",
		Weight = 5.9,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_fal") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fal") UseFunc_StripWeapon(ply, "m9k_fal", drop) return drop end
	},

	["m9k_g36"] = {
		Cost = 33250,
		Model = "models/weapons/w_hk_g36c.mdl",
		Weight = 3.6,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_g36") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g36") UseFunc_StripWeapon(ply, "m9k_g36", drop) return drop end
	},

	["m9k_m416"] = {
		Cost = 31000,
		Model = "models/weapons/w_hk_416.mdl",
		Weight = 4.2,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m416") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m416") UseFunc_StripWeapon(ply, "m9k_m416", drop) return drop end
	},

	["m9k_g3a3"] = {
		Cost = 35250,
		Model = "models/weapons/w_hk_g3.mdl",
		Weight = 5.8,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_g3a3") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g3a3") UseFunc_StripWeapon(ply, "m9k_g3a3", drop) return drop end
	},

	["m9k_l85"] = {
		Cost = 36500,
		Model = "models/weapons/w_l85a2.mdl",
		Weight = 5,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_l85") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_l85") UseFunc_StripWeapon(ply, "m9k_l85", drop) return drop end
	},

	["m9k_m16a4_acog"] = {
		Cost = 35000,
		Model = "models/weapons/w_dmg_m16ag.mdl",
		Weight = 4.2,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m16a4_acog") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m16a4_acog") UseFunc_StripWeapon(ply, "m9k_m16a4_acog", drop) return drop end
	},

	["m9k_vikhr"] = {
		Cost = 23500,
		Model = "models/weapons/w_dmg_vikhr.mdl",
		Weight = 3.68,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_vikhr") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vikhr") UseFunc_StripWeapon(ply, "m9k_vikhr", drop) return drop end
	},

	["m9k_auga3"] = {
		Cost = 29500,
		Model = "models/weapons/w_auga3.mdl",
		Weight = 4.18,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_auga3") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_auga3") UseFunc_StripWeapon(ply, "m9k_auga3", drop) return drop end
	},

	["m9k_tar21"] = {
		Cost = 29500,
		Model = "models/weapons/w_imi_tar21.mdl",
		Weight = 3.35,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_tar21") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tar21") UseFunc_StripWeapon(ply, "m9k_tar21", drop) return drop end
	},

	["m9k_ares_shrike"] = {
		Cost = 80750,
		Model = "models/weapons/w_ares_shrike.mdl",
		Weight = 9.85,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ares_shrike") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ares_shrike") UseFunc_StripWeapon(ply, "m9k_ares_shrike", drop) return drop end
	},

	["m9k_fg42"] = {
		Cost = 49000,
		Model = "models/weapons/w_fg42.mdl",
		Weight = 5.2,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_fg42") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fg42") UseFunc_StripWeapon(ply, "m9k_fg42", drop) return drop end
	},

	["m9k_m1918bar"] = {
		Cost = 52500,
		Model = "models/weapons/w_m1918_bar.mdl",
		Weight = 5.6,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m1918bar") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m1918bar") UseFunc_StripWeapon(ply, "m9k_m1918bar", drop) return drop end
	},

	["m9k_m60"] = {
		Cost = 93000,
		Model = "models/weapons/w_m60_machine_gun.mdl",
		Weight = 9.8,
		Supply = 1,
		Rarity = 8,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m60") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m60") UseFunc_StripWeapon(ply, "m9k_m60", drop) return drop end
	},

	["m9k_pkm"] = {
		Cost = 81500,
		Model = "models/weapons/w_mach_russ_pkm.mdl",
		Weight = 8.5,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_pkm") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_pkm") UseFunc_StripWeapon(ply, "m9k_pkm", drop) return drop end
	},

	["m9k_m3"] = {
		Cost = 31500,
		Model = "models/weapons/w_benelli_m3.mdl",
		Weight = 3.62,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m3") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m3") UseFunc_StripWeapon(ply, "m9k_m3", drop) return drop end
	},

	["m9k_browningauto5"] = {
		Cost = 37250,
		Model = "models/weapons/w_browning_auto.mdl",
		Weight = 4.4,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_browningauto5") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_browningauto5") UseFunc_StripWeapon(ply, "m9k_browningauto5", drop) return drop end
	},

	["m9k_ithacam37"] = {
		Cost = 34250,
		Model = "models/weapons/w_ithaca_m37.mdl",
		Weight = 3.45,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ithacam37") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ithacam37") UseFunc_StripWeapon(ply, "m9k_ithacam37", drop) return drop end
	},

	["m9k_mossberg590"] = {
		Cost = 34150,
		Model = "models/weapons/w_mossberg_590.mdl",
		Weight = 3.69,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mossberg590") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mossberg590") UseFunc_StripWeapon(ply, "m9k_mossberg590", drop) return drop end
	},

	["m9k_jackhammer"] = {
		Cost = 40000,
		Model = "models/weapons/w_pancor_jackhammer.mdl",
		Weight = 4.6,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_jackhammer") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_jackhammer") UseFunc_StripWeapon(ply, "m9k_jackhammer", drop) return drop end
	},

	["m9k_spas12"] = {
		Cost = 44500,
		Model = "models/weapons/w_spas_12.mdl",
		Weight = 4.2,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_spas12") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_spas12") UseFunc_StripWeapon(ply, "m9k_spas12", drop) return drop end
	},

	["m9k_striker12"] = {
		Cost = 42250,
		Model = "models/weapons/w_striker_12g.mdl",
		Weight = 3.66,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_striker12") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_striker12") UseFunc_StripWeapon(ply, "m9k_striker12", drop) return drop end
	},

	["m9k_1897winchester"] = {
		Cost = 34500,
		Model = "models/weapons/w_winchester_1897_trench.mdl",
		Weight = 3.2,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_1897winchester") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1897winchester") UseFunc_StripWeapon(ply, "m9k_1897winchester", drop) return drop end
	},

	["m9k_1887winchester"] = {
		Cost = 33750,
		Model = "models/weapons/w_winchester_1887.mdl",
		Weight = 3.12,
		Supply = 1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_1887winchester") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1887winchester") UseFunc_StripWeapon(ply, "m9k_1887winchester", drop) return drop end
	},

	["m9k_barret_m82"] = {
		Cost = 84000,
		Model = "models/weapons/w_barret_m82.mdl",
		Weight = 11.85,
		Supply = -1,
		Rarity = 8,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_barret_m82") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_barret_m82") UseFunc_StripWeapon(ply, "m9k_barret_m82", drop) return drop end
	},

	["m9k_m98b"] = {
		Cost = 66000,
		Model = "models/weapons/w_barrett_m98b.mdl",
		Weight = 10.95,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m98b") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m98b") UseFunc_StripWeapon(ply, "m9k_m98b", drop) return drop end
	},

	["m9k_svu"] = {
		Cost = 68500,
		Model = "models/weapons/w_dragunov_svu.mdl",
		Weight = 5.44,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_svu") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svu") UseFunc_StripWeapon(ply, "m9k_svu", drop) return drop end
	},

	["m9k_sl8"] = {
		Cost = 49500,
		Model = "models/weapons/w_snip_int.mdl",
		Weight = 4.92,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_sl8") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sl8") UseFunc_StripWeapon(ply, "m9k_sl8", drop) return drop end
	},

	["m9k_intervention"] = {
		Cost = 47250,
		Model = "models/weapons/w_snip_int.mdl",
		Weight = 8.46,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_intervention") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_intervention") UseFunc_StripWeapon(ply, "m9k_intervention", drop) return drop end
	},

	["m9k_m24"] = {
		Cost = 58750,
		Model = "models/weapons/w_snip_m24_6.mdl",
		Weight = 7.98,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m24") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m24") UseFunc_StripWeapon(ply, "m9k_m24", drop) return drop end
	},

	["m9k_psg1"] = {
		Cost = 61250,
		Model = "models/weapons/w_hk_psg1.mdl",
		Weight = 8.28,
		Supply = -1,
		Rarity = 7,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_psg1") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_psg1") UseFunc_StripWeapon(ply, "m9k_psg1", drop) return drop end
	},

	["m9k_remington7615p"] = {
		Cost = 11000,
		Model = "models/weapons/w_remington_7615p.mdl",
		Weight = 5.65,
		Supply = -1,
		Rarity = 3,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_remington7615p") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington7615p") UseFunc_StripWeapon(ply, "m9k_remington7615p", drop) return drop end
	},

	["m9k_svt40"] = {
		Cost = 57500,
		Model = "models/weapons/w_svt_40.mdl",
		Weight = 5.48,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_svt40") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svt40") UseFunc_StripWeapon(ply, "m9k_svt40", drop) return drop end
	},

	["m9k_contender"] = {
		Cost = 41000,
		Model = "models/weapons/w_g2_contender.mdl",
		Weight = 4.18,
		Supply = -1,
		Rarity = 4,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_contender") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_contender") UseFunc_StripWeapon(ply, "m9k_contender", drop) return drop end
	},

	["m9k_honeybadger"] = {
		Cost = 46750,
		Model = "models/weapons/w_aac_honeybadger.mdl",
		Weight = 4.44,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_honeybadger") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_honeybadger") UseFunc_StripWeapon(ply, "m9k_honeybadger", drop) return drop end
	},

	["m9k_mp5"] = {
		Cost = 21500,
		Model = "models/weapons/w_hk_mp5.mdl",
		Weight = 3.15,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp5") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5") UseFunc_StripWeapon(ply, "m9k_mp5", drop) return drop end
	},

	["m9k_mp7"] = {
		Cost = 22250,
		Model = "models/weapons/w_mp7_silenced.mdl",
		Weight = 3.2,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp7") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp7") UseFunc_StripWeapon(ply, "m9k_mp7", drop) return drop end
	},

	["m9k_ump45"] = {
		Cost = 19200,
		Model = "models/weapons/w_hk_ump45.mdl",
		Weight = 2.95,
		Supply = 1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ump45") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ump45") UseFunc_StripWeapon(ply, "m9k_ump45", drop) return drop end
	},

	["m9k_kac_pdw"] = {
		Cost = 21350,
		Model = "models/weapons/w_kac_pdw.mdl",
		Weight = 3.12,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_kac_pdw") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_kac_pdw") UseFunc_StripWeapon(ply, "m9k_kac_pdw", drop) return drop end
	},

	["m9k_vector"] = {
		Cost = 27150,
		Model = "models/weapons/w_kriss_vector.mdl",
		Weight = 3.1,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_vector") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vector") UseFunc_StripWeapon(ply, "m9k_vector", drop) return drop end
	},

	["m9k_magpulpdr"] = {
		Cost = 24150,
		Model = "models/weapons/w_magpul_pdr.mdl",
		Weight = 3.16,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_magpulpdr") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_magpulpdr") UseFunc_StripWeapon(ply, "m9k_magpulpdr", drop) return drop end
	},

	["m9k_mp5sd"] = {
		Cost = 23400,
		Model = "models/weapons/w_hk_mp5sd.mdl",
		Weight = 2.85,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp5sd") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5sd") UseFunc_StripWeapon(ply, "m9k_mp5sd", drop) return drop end
	},

	["m9k_mp9"] = {
		Cost = 24600,
		Model = "models/weapons/w_brugger_thomet_mp9.mdl",
		Weight = 2.68,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp9") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp9") UseFunc_StripWeapon(ply, "m9k_mp9", drop) return drop end
	},

	["m9k_tec9"] = {
		Cost = 16800,
		Model = "models/weapons/w_intratec_tec9.mdl",
		Weight = 2.38,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_tec9") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tec9") UseFunc_StripWeapon(ply, "m9k_tec9", drop) return drop end
	},

	["m9k_thompson"] = {
		Cost = 24250,
		Model = "models/weapons/w_tommy_gun.mdl",
		Weight = 3.84,
		Supply = -1,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_thompson") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_thompson") UseFunc_StripWeapon(ply, "m9k_thompson", drop) return drop end
	},

	["m9k_uzi"] = {
		Cost = 19000,
		Model = "models/weapons/w_uzi_imi.mdl",
		Weight = 2.95,
		Supply = -1,
		Rarity = 5,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_uzi") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_uzi") UseFunc_StripWeapon(ply, "m9k_uzi", drop) return drop end
	},



	["item_armor_jacket_leather"] = {
		Cost = 4000,
		Model = "models/player/group03/male_07.mdl",
		Weight = 1.1,
		Supply = 0,
		Rarity = 2,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_leather") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_leather") return drop end,

		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 5,			-- damage reduction in percentage
			["env_reduction"] = 2.5,	-- damage reduction from environment in percentage (protection from entity classes "trigger_hurt", "point_hurt", "entityflame", "env_fire" and nothing else)
			["speedloss"] = 0,			-- speed loss in source units (default player sprint speed: 260 (330 with maxed speed stat))
			["slots"] = 1,				-- attachment slots (to be removed)
			["battery"] = 0,			-- battery capacity, suits with 0 battery will only be able to use passive attachments (may be reworked, with flashlight)
			["carryweight"] = 0,		-- additional max carryweight when user wears the armor
			["allowmodels"] = nil		-- force the player to be one of these models, nil to let them choose from the default citizen models
		}
	},

	["item_armor_chainmail"] = {
		Cost = 6500,
		Model = "models/player/group03/male_05.mdl",
		Weight = 1.6,
		Supply = 0,
		Rarity = 2,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_chainmail") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chainmail") return drop end,

		["ArmorStats"] = {
			["reduction"] = 7.5,
			["env_reduction"] = 2.5,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_jacket_bandit"] = {
		Cost = 8000,
		Model = "models/player/stalker/bandit_backpack.mdl",
		Weight = 1.4,
		Supply = 0,
		Rarity = 3,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_bandit") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_bandit") return drop end,
		["ArmorStats"] = {
			["reduction"] = 8,
			["env_reduction"] = 3.5,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_backpack.mdl"}
		}
	},

	["item_armor_scrap"] = {
		Cost = 10000,
		Model = "models/player/group03/male_05.mdl",
		Weight = 3.8,
		Supply = 0,
		Rarity = 3,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
		["ArmorStats"] = {
			["reduction"] = 12.5,
			["env_reduction"] = 2.5,
			["speedloss"] = 35,
			["slots"] = 2,
			["battery"] = 20,
			["carryweight"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_trenchcoat_brown"] = {
		Cost = 11750,
		Model = "models/player/stalker/bandit_brown.mdl",
		Weight = 2.28,
		Supply = 0,
		Rarity = 3,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_brown") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_brown") return drop end,
		["ArmorStats"] = {
			["reduction"] = 10,
			["env_reduction"] = 5,
			["speedloss"] = 10,
			["slots"] = 2,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_brown.mdl"}
		}
	},

	["item_armor_trenchcoat_black"] = {
		Cost = 15500,
		Model = "models/player/stalker/bandit_black.mdl",
		Weight = 2.9,
		Supply = 0,
		Rarity = 4,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_black") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_black") return drop end,
		["ArmorStats"] = {
			["reduction"] = 15,
			["env_reduction"] = 6.25,
			["speedloss"] = 17.5,
			["slots"] = 2,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_black.mdl"}
		}
	},

	["item_armor_mercenary_guerilla"] = {
		Cost = 19000,
		Model = "models/player/guerilla.mdl",
		Weight = 3.2,
		Supply = 0,
		Rarity = 4,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_guerilla") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_guerilla") return drop end,
		["ArmorStats"] = {
			["reduction"] = 16.25,
			["env_reduction"] = 7.5,
			["speedloss"] = 25,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/guerilla.mdl"}
		}
	},

	["item_armor_mercenary_arctic"] = {
		Cost = 21500,
		Model = "models/player/arctic.mdl",
		Weight = 3.35,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_arctic") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_arctic") return drop end,
		["ArmorStats"] = {
			["reduction"] = 16.25,
			["env_reduction"] = 8.75,
			["speedloss"] = 27.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/arctic.mdl"}
		}
	},

	["item_armor_mercenary_leet"] = {
		Cost = 20000,
		Model = "models/player/leet.mdl",
		Weight = 3,
		Supply = 0,
		Rarity = 4,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_leet") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_leet") return drop end,
		["ArmorStats"] = {
			["reduction"] = 15,
			["env_reduction"] = 5,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/leet.mdl"}
		}
	},

	["item_armor_mercenary_phoenix"] = {
		Cost = 23500,
		Model = "models/player/phoenix.mdl",
		Weight = 4.15,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_phoenix") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_phoenix") return drop end,
		["ArmorStats"] = {
			["reduction"] = 20,
			["env_reduction"] = 10,
			["speedloss"] = 30,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/phoenix.mdl"}
		}
	},

	["item_armor_police_gasmask"] = {
		Cost = 27500,
		Model = "models/player/gasmask.mdl",
		Weight = 5.5,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_gasmask") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_gasmask") return drop end,
		["ArmorStats"] = {
			["reduction"] = 22.5,
			["env_reduction"] = 15,
			["speedloss"] = 47.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/gasmask.mdl"}
		}
	},

	["item_armor_police_riot"] = {
		Cost = 29000,
		Model = "models/player/riot.mdl",
		Weight = 5.8,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_riot") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_riot") return drop end,
		["ArmorStats"] = {
			["reduction"] = 25,
			["env_reduction"] = 10,
			["speedloss"] = 55,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/riot.mdl"}
		}
	},

	["item_armor_police_swat"] = {
		Cost = 28000,
		Model = "models/player/swat.mdl",
		Weight = 5.8,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_swat") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_swat") return drop end,
		["ArmorStats"] = {
			["reduction"] = 23.75,
			["env_reduction"] = 12.5,
			["speedloss"] = 53.75,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/swat.mdl"}
		}
	},

	["item_armor_police_urban"] = {
		Cost = 31000,
		Model = "models/player/urban.mdl",
		Weight = 6.5,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_urban") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_urban") return drop end,
		["ArmorStats"] = {
			["reduction"] = 27.5,
			["env_reduction"] = 12.5,
			["speedloss"] = 57.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/urban.mdl"}
		}
	},

	["item_armor_sunrise"] = {
		Cost = 42500,
		Model = "models/player/stalker/loner_vet.mdl",
		Weight = 5.5,
		Supply = 0,
		Rarity = 5,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise") return drop end,
		["ArmorStats"] = {
			["reduction"] = 30,
			["env_reduction"] = 20,
			["speedloss"] = 33.75,
			["slots"] = 3,
			["battery"] = 75,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/loner_vet.mdl"}
		}
	},

	["item_armor_sunrise_dolg"] = {
		Cost = 61000,
		Model = "models/player/stalker/duty_vet.mdl",
		Weight = 7.1,
		Supply = 0,
		Rarity = 6,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_dolg") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_dolg") return drop end,
		["ArmorStats"] = {
			["reduction"] = 37.5,
			["env_reduction"] = 20,
			["speedloss"] = 42.5,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/duty_vet.mdl"}
		}
	},

	["item_armor_sunrise_svoboda"] = {
		Cost = 46000,
		Model = "models/player/stalker/freedom_vet.mdl",
		Weight = 5,
		Supply = 0,
		Rarity = 6,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_svoboda") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_svoboda") return drop end,
		["ArmorStats"] = {
			["reduction"] = 30,
			["env_reduction"] = 20,
			["speedloss"] = 27.5,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/freedom_vet.mdl"}
		}
	},

	["item_armor_sunrise_monolith"] = {
		Cost = 58750,
		Model = "models/player/stalker/monolith_vet.mdl",
		Weight = 6,
		Supply = 3,
		Rarity = 6,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_monolith") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_monolith") return drop end,
		["ArmorStats"] = {
			["reduction"] = 35,
			["env_reduction"] = 20,
			["speedloss"] = 35,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/monolith_vet.mdl"}
		}
	},

	["item_armor_military_green"] = {
		Cost = 95000,
		Model = "models/player/stalker/military_spetsnaz_green.mdl",
		Weight = 12,
		Supply = 0,
		Rarity = 6,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_green") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_green") return drop end,
		["ArmorStats"] = {
			["reduction"] = 42.5,
			["env_reduction"] = 25,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_green.mdl"}
		}
	},

	["item_armor_military_black"] = {
		Cost = 115000,
		Model = "models/player/stalker/military_spetsnaz_black.mdl",
		Weight = 15,
		Supply = 0,
		Rarity = 7,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_black") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_black") return drop end,
		["ArmorStats"] = {
			["reduction"] = 47.5,
			["env_reduction"] = 27.5,
			["speedloss"] = 70,
			["slots"] = 2,
			["battery"] = 125,
			["carryweight"] = 5,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_black.mdl"}
		}
	},

	["item_armor_exo"] = {
		Cost = 190000,
		Model = "models/player/stalker/loner_exo.mdl",
		Weight = 25,
		Supply = 0,
		Rarity = 7,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
		["ArmorStats"] = {
			["reduction"] = 60,
			["env_reduction"] = 25,
			["speedloss"] = 125,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/loner_exo.mdl"}
		}
	},

	["item_armor_exo_merc"] = {
		Cost = 172500,
		Model = "models/player/stalker/merc_exo.mdl",
		Weight = 23.75,
		Supply = 0,
		Rarity = 8,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_merc") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_merc") return drop end,
		["ArmorStats"] = {
			["reduction"] = 57.5,
			["env_reduction"] = 25,
			["speedloss"] = 115,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/merc_exo.mdl"}
		}
	},

	["item_armor_exo_dolg"] = {
		Cost = 212500,
		Model = "models/player/stalker/duty_exo.mdl",
		Weight = 27.5,
		Supply = 0,
		Rarity = 8,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg") return drop end,
		["ArmorStats"] = {
			["reduction"] = 65,
			["env_reduction"] = 25,
			["speedloss"] = 130,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/duty_exo.mdl"}
		}
	},

	["item_armor_exo_svoboda"] = {
		Cost = 185000,
		Model = "models/player/stalker/freedom_exo.mdl",
		Weight = 22.5,
		Supply = 0,
		Rarity = 7,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_svoboda") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_svoboda") return drop end,
		["ArmorStats"] = {
			["reduction"] = 55,
			["env_reduction"] = 25,
			["speedloss"] = 110,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 25,
			["allowmodels"] = {"models/player/stalker/freedom_exo.mdl"}
		}
	},

	["item_armor_exo_monolith"] = {
		Cost = 207500,
		Model = "models/player/stalker/monolith_exo.mdl",
		Weight = 25,
		Supply = 0,
		Rarity = 8,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_monolith") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_monolith") return drop end,
		["ArmorStats"] = {
			["reduction"] = 62.5,
			["env_reduction"] = 30,
			["speedloss"] = 125,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/monolith_exo.mdl"}
		}
	},

	["item_armor_cs2_goggles"] = {
		Cost = 450000,
		Model = "models/stalkertnb/cs2_goggles.mdl",
		Weight = 13.5,
		Supply = 0,
		Rarity = 9,
		Category = 4,
		UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_cs2_goggles") end,
		DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_cs2_goggles") return drop end,
		["ArmorStats"] = {
			["reduction"] = 40,
			["env_reduction"] = 35,
			["speedloss"] = -12.5,
			["slots"] = 3,
			["battery"] = 200,
			["carryweight"] = 10,
			["allowmodels"] = {"models/stalkertnb/cs2_goggles.mdl"}
		}
	},

}



-- Consumables

local i = GM:CreateItem("item_bandage", nil, nil, 55, "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl", 0.06, 0, 2, 1,
function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 11, 0, "comrade_vodka/inv_bandages.ogg") return healing end,
function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end)
i.CanUseOnOthers = true
i = GM:CreateItem("item_medkit", nil, nil, 175, "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl", 0.5, 30, 3, 1,
function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 45, 5, "comrade_vodka/inv_aptecka.ogg") return healing end,
function(ply) local drop = UseFunc_DropItem(ply, "item_medkit") return drop end)
i.CanUseOnOthers = true
i = GM:CreateItem("item_armymedkit", nil, nil, 300, "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl", 0.6, 10, 4, 1,
function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 70, 20, "comrade_vodka/inv_aptecka.ogg") return healing end,
function(ply) local drop = UseFunc_DropItem(ply, "item_armymedkit") return drop end)
i.CanUseOnOthers = true
i = GM:CreateItem("item_scientificmedkit", nil, nil, 500, "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl", 0.5, 30, 3, 1,
function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 100, 60, "comrade_vodka/inv_aptecka.ogg") return healing end,
function(ply) local drop = UseFunc_DropItem(ply, "item_scientificmedkit") return drop end)
i.CanUseOnOthers = true
GM:CreateItem("item_antidote", nil, nil, 100, "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl", 0.08, 12, 3, 1,
function(ply) local healing = UseFunc_HealInfection(ply, 3, 40, "items/medshot4.wav") return healing end,
function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end)
GM:CreateItem("item_egg", nil, nil, 10, "models/props_phx/misc/egg.mdl", 0.08, 0, 0, 1,
function(ply) local food = UseFunc_Eat(ply, 1, 0, 4, -1, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_egg") return drop end)
GM:CreateItem("item_milk", nil, nil, 35, "models/props_junk/garbage_milkcarton002a.mdl", 1.05, 20, 1, 1,
function(ply) local food = UseFunc_Drink(ply, 4, 0, 3, 20, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_milk") return drop end)
GM:CreateItem("item_soda", nil, nil, 50, "models/props_junk/PopCan01a.mdl", 0.33, 0, 1, 1,
function(ply) local food = UseFunc_Drink(ply, 3, 1, 8, 35, 5, -1, "comrade_vodka/inv_drink_can2.ogg") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end)
GM:CreateItem("item_energydrink", nil, nil, 100, "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl", 0.36, 0, 2, 1,
function(ply) local food = UseFunc_Drink(ply, 4, 1, 5, 30, 55, -8, "comrade_vodka/inv_drink_can.ogg") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink") return drop end)
GM:CreateItem("item_energydrink_nonstop", nil, nil, 145, "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl", 0.38, 0, 2, 1,
function(ply) local food = UseFunc_Drink(ply, 4, 2, 6, 32, 85, -11, "comrade_vodka/inv_drink_can.ogg") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink_nonstop") return drop end)
GM:CreateItem("item_beerbottle", nil, nil, 35, "models/props_junk/garbage_glassbottle003a.mdl", 0.8, 10, 3, 1,
function(ply) local food = UseFunc_Drink(ply, 5, 1, 9, 5, -15, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end)
GM:CreateItem("item_tinnedfood", nil, nil, 45, "models/props_junk/garbage_metalcan001a.mdl", 0.4, 30, 2, 1,
function(ply) local food = UseFunc_Eat(ply, 2, 3, 20, -10, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end)
GM:CreateItem("item_potato", nil, nil, 60, "models/props_phx/misc/potato.mdl", 0.2, 20, 1, 1,
function(ply) local food = UseFunc_Eat(ply, 2, 2, 22, -8, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end)
GM:CreateItem("item_traderfood", nil, nil, 75, "models/props_junk/garbage_takeoutcarton001a.mdl", 0.6, 5, 2, 1,
function(ply) local food = UseFunc_Eat(ply, 5, 4, 47, -15, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end)
GM:CreateItem("item_trout", nil, nil, 95, "models/props/CS_militia/fishriver01.mdl", 0.75, 2, 3, 1,
function(ply) local food = UseFunc_Eat(ply, 6, 5, 65, -4, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end)
GM:CreateItem("item_melon", nil, nil, 150, "models/props_junk/watermelon01.mdl", 2, 3, 3, 1,
function(ply) local food = UseFunc_Eat(ply, 7, 7, 85, 20, 3, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end)
GM:CreateItem("item_burger", nil, nil, 750, "models/food/burger.mdl", 0.4, -1, 7, 1,
function(ply) local food = UseFunc_Eat(ply, 5, 30, 100, 15, 90, -15, "vo/npc/male01/yeah02.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end)
GM:CreateItem("item_hotdog", nil, nil, 400, "models/food/hotdog.mdl", 0.35, -1, 6, 1,
function(ply) local food = UseFunc_Eat(ply, 5, 20, 80, 10, 40, -15, "vo/npc/male01/nice.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_hotdog") return drop end)
GM:CreateItem("item_donut", nil, nil, 65, "models/noesis/donut.mdl", 0.2, 5, 2, 1,
function(ply) local food = UseFunc_Eat(ply, 3, 2, 25, -7, 5, -1, "npc/barnacle/barnacle_gulp2.wav") return food end,
function(ply) local drop = UseFunc_DropItem(ply, "item_donut") return drop end)
GM:CreateItem("item_bed", nil, nil, 80, "models/props/de_inferno/bed.mdl", 4.5, 0, 2, 1,
function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end)
GM:CreateItem("item_sleepingbag", nil, nil, 1130, "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl", 2.2, 0, 5, 1,
function(ply) UseFunc_Sleep(ply, false) return false end,
function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end)
GM:CreateItem("item_amnesiapills", nil, nil, 1250, "models/props_lab/jar01b.mdl", 0.1, 0, 2, 1,
function(ply) local bool = UseFunc_Respec(ply) return bool end,
function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end)
GM:CreateItem("item_armorbattery", nil, nil, 600, "models/Items/battery.mdl", 0.35, 6, 4, 1,
function(ply) local armor = UseFunc_Armor(ply, 2, 50, 15, "items/battery_pickup.wav") return armor end,
function(ply) local drop = UseFunc_DropItem(ply, "item_armorbattery") return drop end)
GM:CreateItem("item_armorkevlar", nil, nil, 1500, "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl", 1.13, 3, 5, 1,
function(ply) local armor = UseFunc_Armor(ply, 4, 0, 35, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
function(ply) local drop = UseFunc_DropItem(ply, "item_armorkevlar") return drop end)

--[[ Sellables

GM:CreateItem("item_radio", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_scrap", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_chems", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_tv", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_beer", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_hamradio", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_computer", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_blueprint_sawbow", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
GM:CreateItem("item_blueprint_railgun", nil, nil, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
]]
/*
GM:CreateItem(thisitemid, thisname, thisdescription, thiscost, thismodel, thisweight, thissupply, thisrarity, thiscategory,
this_usefunc,
this_dropfunc)
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
