-- Armor --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, {
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, itemid) end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, itemid) return drop end,

	-- armor only values
	ArmorStats = {
		reduction = number,			-- damage reduction in percentage
		env_reduction = number,		-- damage reduction from environment in percentage (protection from entity classes "trigger_hurt", "point_hurt", "entityflame", "env_fire" and nothing else)
		speedloss_percent = number,	-- speed loss in percentage
		oxygen_capacity = 1,		-- oxygen capacity (how long can the user stay underwater when wearing this armor)
		slots = number,				-- attachment slots (to be removed)
		battery = number,			-- battery capacity, suits with 0 battery will only be able to use passive attachments. Works for INCREASING FLASHLIGHTS CAPACITY currently.
		carryweight = number,		-- additional max carryweight when the player is wearing the armor
		allowmodels = table			-- force the player to be one of these models, nil to let them choose from the default models
	}

-- Additional variables if needed
    IsSecret = false,
})

]]

-- Armor
GM:CreateItem("item_armor_jacket_leather", {
	Cost = 4000,
	Model = "models/player/group03/male_07.mdl",
	Weight = 1.1,
	Supply = 0,
	Rarity = 2,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_leather") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_leather") return drop end,

	ArmorStats = {
		reduction = 5,
		env_reduction = 2.5,
		speedloss_percent = 0,
		slots = 1,
		battery = 0,
		carryweight = 0,
		allowmodels = nil
	}
})

GM:CreateItem("item_armor_chainmail", {
	Cost = 6500,
	Model = "models/player/group03/male_05.mdl",
	Weight = 1.6,
	Supply = 0,
	Rarity = 2,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_chainmail") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chainmail") return drop end,

	ArmorStats = {
		reduction = 7.5,
		env_reduction = 2.5,
		speedloss_percent = 1,
		slots = 1,
		battery = 0,
		carryweight = 0,
		allowmodels = nil
	}
})

GM:CreateItem("item_armor_jacket_bandit", {
	Cost = 8000,
	Model = "models/player/stalker/bandit_backpack.mdl",
	Weight = 1.4,
	Supply = 0,
	Rarity = 3,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_bandit") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_bandit") return drop end,
	ArmorStats = {
		reduction = 8,
		env_reduction = 3.5,
		speedloss_percent = 1,
		slots = 1,
		battery = 0,
		carryweight = 0,
		allowmodels = {"models/player/stalker/bandit_backpack.mdl", "models/stalkertnb/bandit1.mdl", "models/stalkertnb/bandit2.mdl", "models/stalkertnb/bandit3.mdl", "models/stalkertnb/bandit4.mdl"}
	}
})

GM:CreateItem("item_armor_scrap", {
	Cost = 10000,
	Model = "models/player/group03/male_05.mdl",
	Weight = 3.8,
	Supply = 0,
	Rarity = 3,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
	ArmorStats = {
		reduction = 12.5,
		env_reduction = 2.5,
		speedloss_percent = 2,
		slots = 2,
		battery = 20,
		carryweight = 0,
		allowmodels = nil
	}
})

GM:CreateItem("item_armor_trenchcoat_brown", {
	Cost = 11750,
	Model = "models/player/stalker/bandit_brown.mdl",
	Weight = 2.28,
	Supply = 0,
	Rarity = 3,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_brown") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_brown") return drop end,
	ArmorStats = {
		reduction = 10,
		env_reduction = 5,
		speedloss_percent = 1,
		slots = 2,
		battery = 0,
		carryweight = 0,
		allowmodels = {"models/player/stalker/bandit_brown.mdl"}
	}
})

GM:CreateItem("item_armor_trenchcoat_black", {
	Cost = 15500,
	Model = "models/player/stalker/bandit_black.mdl",
	Weight = 2.9,
	Supply = 0,
	Rarity = 4,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_black") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_black") return drop end,
	ArmorStats = {
		reduction = 15,
		env_reduction = 6.25,
		speedloss_percent = 1,
		slots = 2,
		battery = 0,
		carryweight = 0,
		allowmodels = {"models/player/stalker/bandit_black.mdl"}
	}
})

GM:CreateItem("item_armor_mercenary_guerilla", {
	Cost = 19000,
	Model = "models/player/guerilla.mdl",
	Weight = 3.2,
	Supply = 0,
	Rarity = 4,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_guerilla") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_guerilla") return drop end,
	ArmorStats = {
		reduction = 16.25,
		env_reduction = 7.5,
		speedloss_percent = 2,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/guerilla.mdl"}
	}
})

GM:CreateItem("item_armor_mercenary_arctic", {
	Cost = 21500,
	Model = "models/player/arctic.mdl",
	Weight = 3.35,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_arctic") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_arctic") return drop end,
	ArmorStats = {
		reduction = 16.25,
		env_reduction = 8.75,
		speedloss_percent = 2,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/arctic.mdl"}
	}
})

GM:CreateItem("item_armor_mercenary_leet", {
	Cost = 20000,
	Model = "models/player/leet.mdl",
	Weight = 3,
	Supply = 0,
	Rarity = 4,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_leet") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_leet") return drop end,
	ArmorStats = {
		reduction = 15,
		env_reduction = 5,
		speedloss_percent = 2,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/leet.mdl"}
	}
})

GM:CreateItem("item_armor_mercenary_phoenix", {
	Cost = 23500,
	Model = "models/player/phoenix.mdl",
	Weight = 4.15,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_phoenix") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_phoenix") return drop end,
	ArmorStats = {
		reduction = 20,
		env_reduction = 10,
		speedloss_percent = 2,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/phoenix.mdl"}
	}
})

GM:CreateItem("item_armor_police_gasmask", {
	Cost = 27500,
	Model = "models/player/gasmask.mdl",
	Weight = 5.5,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_gasmask") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_gasmask") return drop end,
	ArmorStats = {
		reduction = 22.5,
		env_reduction = 15,
		speedloss_percent = 3,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/gasmask.mdl"}
	}
})

GM:CreateItem("item_armor_police_riot", {
	Cost = 29000,
	Model = "models/player/riot.mdl",
	Weight = 5.8,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_riot") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_riot") return drop end,
	ArmorStats = {
		reduction = 25,
		env_reduction = 10,
		speedloss_percent = 3,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/riot.mdl"}
	}
})

GM:CreateItem("item_armor_police_swat", {
	Cost = 28000,
	Model = "models/player/swat.mdl",
	Weight = 5.8,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_swat") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_swat") return drop end,
	ArmorStats = {
		reduction = 23.75,
		env_reduction = 12.5,
		speedloss_percent = 3,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/swat.mdl"}
	}
})

GM:CreateItem("item_armor_police_urban", {
	Cost = 31000,
	Model = "models/player/urban.mdl",
	Weight = 6.5,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_urban") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_urban") return drop end,
	ArmorStats = {
		reduction = 27.5,
		env_reduction = 12.5,
		speedloss_percent = 3,
		slots = 2,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/player/urban.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise", {
	Cost = 42500,
	Model = "models/player/stalker/loner_vet.mdl",
	Weight = 5.5,
	Supply = 0,
	Rarity = 5,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise") return drop end,
	ArmorStats = {
		reduction = 30,
		env_reduction = 20,
		speedloss_percent = 3,
		slots = 3,
		battery = 75,
		carryweight = 0,
		allowmodels = {"models/player/stalker/loner_vet.mdl", "models/stalkertnb/sunrise_lone.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_dolg", {
	Cost = 61000,
	Model = "models/player/stalker/duty_vet.mdl",
	Weight = 7.1,
	Supply = 0,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_dolg") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_dolg") return drop end,
	ArmorStats = {
		reduction = 37.5,
		env_reduction = 20,
		speedloss_percent = 5,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/duty_vet.mdl", "models/stalkertnb/psz9d_duty2.mdl", "models/stalkertnb/psz9d_duty4.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_svoboda", {
	Cost = 46000,
	Model = "models/player/stalker/freedom_vet.mdl",
	Weight = 5,
	Supply = 0,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_svoboda") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_svoboda") return drop end,
	ArmorStats = {
		reduction = 30,
		env_reduction = 20,
		speedloss_percent = 3,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/freedom_vet.mdl", "models/stalkertnb/exo_freedompracs.mdl", "models/stalkertnb/psz9d_free3.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_monolith", {
	Cost = 58750,
	Model = "models/player/stalker/monolith_vet.mdl",
	Weight = 6,
	Supply = 3,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_monolith") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_monolith") return drop end,
	ArmorStats = {
		reduction = 35,
		env_reduction = 20,
		speedloss_percent = 5,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/monolith_vet.mdl", "models/stalkertnb/psz9d_mono2.mdl", "models/stalkertnb/psz9d_mono4.mdl"}
	}
})

GM:CreateItem("item_armor_military_green", {
	Cost = 100000,
	Model = "models/player/stalker/military_spetsnaz_green.mdl",
	Weight = 12,
	Supply = 0,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_green") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_green") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 25,
		speedloss_percent = 11,
		slots = 2,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/military_spetsnaz_green.mdl"}
	}
})

GM:CreateItem("item_armor_military_black", {
	Cost = 140000,
	Model = "models/player/stalker/military_spetsnaz_black.mdl",
	Weight = 15,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_black") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_black") return drop end,
	ArmorStats = {
		reduction = 50,
		env_reduction = 27.5,
		speedloss_percent = 13,
		slots = 2,
		battery = 125,
		carryweight = 5,
		allowmodels = {"models/player/stalker/military_spetsnaz_black.mdl"}
	}
})

GM:CreateItem("item_armor_exo", {
	Cost = 190000,
	Model = "models/player/stalker/loner_exo.mdl",
	Weight = 25,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
	ArmorStats = {
		reduction = 60,
		env_reduction = 25,
		speedloss_percent = 28,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/loner_exo.mdl"}
	}
})

GM:CreateItem("item_armor_exo_merc", {
	Cost = 172500,
	Model = "models/player/stalker/merc_exo.mdl",
	Weight = 23.75,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_merc") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_merc") return drop end,
	ArmorStats = {
		reduction = 57.5,
		env_reduction = 25,
		speedloss_percent = 28,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/merc_exo.mdl", "models/stalkertnb/exo_skat_merc.mdl"}
	}
})

GM:CreateItem("item_armor_exo_dolg", {
	Cost = 212500,
	Model = "models/player/stalker/duty_exo.mdl",
	Weight = 27.5,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg") return drop end,
	ArmorStats = {
		reduction = 65,
		env_reduction = 25,
		speedloss_percent = 29,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/duty_exo.mdl", "models/stalkertnb/exo_skat_duty.mdl"}
	}
})

GM:CreateItem("item_armor_exo_svoboda", {
	Cost = 185000,
	Model = "models/player/stalker/freedom_exo.mdl",
	Weight = 22.5,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_svoboda") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_svoboda") return drop end,
	ArmorStats = {
		reduction = 55,
		env_reduction = 25,
		speedloss_percent = 28,
		slots = 3,
		battery = 100,
		carryweight = 25,
		allowmodels = {"models/player/stalker/freedom_exo.mdl"}
	}
})

GM:CreateItem("item_armor_exo_monolith", {
	Cost = 207500,
	Model = "models/player/stalker/monolith_exo.mdl",
	Weight = 25,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_monolith") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_monolith") return drop end,
	ArmorStats = {
		reduction = 62.5,
		env_reduction = 30,
		speedloss_percent = 28,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/monolith_exo.mdl", "models/stalkertnb/exo_mono.mdl"}
	}
})

GM:CreateItem("item_armor_cs2_goggles", {
	Cost = 400000,
	Model = "models/stalkertnb/cs2_goggles.mdl",
	Weight = 13.5,
	Supply = 0,
	Rarity = 9,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_cs2_goggles") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_cs2_goggles") return drop end,
	ArmorStats = {
		reduction = 40,
		env_reduction = 35,
		speedloss_percent = -2.5,
		slots = 3,
		battery = 200,
		carryweight = 8,
		allowmodels = {"models/stalkertnb/cs2_goggles.mdl"}
	}
})

-- More Armors


GM:CreateItem("item_armor_beril5m", {
	Name = "Beril-5M Military Armor",
	Description = "A Berill-5M special forces suit modified for the Zone environment. It includes a PSZ-9a military bulletproof vest with beryllium coating and a Sphere-08 helmet.\nIt is designed for assault operations in areas with high background radiation. Its level of environmental protection is low.",
	Cost = 70000,
	Model = "models/stalkertnb/beri_mili.mdl",
	Weight = 9,
	Supply = 0,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_beril5m") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_beril5m") return drop end,
	ArmorStats = {
		reduction = 40,
		env_reduction = 15,
		speedloss_percent = 7,
		slots = 3,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/stalkertnb/beri_mili.mdl", "models/stalkertnb/Beri_rogue.mdl", "models/stalkertnb/beri_rogue_cs2.mdl", "models/stalkertnb/beri_rogue_helmet.mdl"}
	}
})


GM:CreateItem("item_armor_merc_sunrise", {
	Name = "Mercenary Sunrise Armor",
	Description = "",
	Cost = 65000,
	Model = "models/stalkertnb/sunrise_merc.mdl",
	Weight = 6.7,
	Supply = 0,
	Rarity = 6,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_merc_sunrise") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_merc_sunrise") return drop end,
	ArmorStats = {
		reduction = 35,
		env_reduction = 25,
		speedloss_percent = 6,
		slots = 3,
		battery = 50,
		carryweight = 0,
		allowmodels = {"models/stalkertnb/sunrise_merc.mdl"}
	}
})

GM:CreateItem("item_armor_army_seva", {
	Name = "Military SEVA Protection Suit",
	Description = "",
	Cost = 140000,
	Model = "models/stalkertnb/beri_seva.mdl",
	Weight = 13,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_army_seva") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_army_seva") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 60,
		speedloss_percent = 11,
		oxygen_capacity = 4.25,
		slots = 3,
		battery = 100,
		carryweight = 5,
		allowmodels = {"models/stalkertnb/beri_seva.mdl"}
	}
})

GM:CreateItem("item_armor_stalker_seva", {
	Name = "SEVA Protection Suit",
	Description = "",
	Cost = 125000,
	Model = "models/stalkertnb/seva_lone.mdl",
	Weight = 10,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_stalker_seva") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_stalker_seva") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 60,
		speedloss_percent = 10,
		oxygen_capacity = 4,
		slots = 3,
		battery = 150,
		carryweight = 5,
		allowmodels = {"models/stalkertnb/seva_lone.mdl"}
	}
})

GM:CreateItem("item_armor_svoboda_seva", {
	Name = "Freedom SEVA Protection Suit",
	Description = "",
	Cost = 125000,
	Model = "models/stalkertnb/seva_free.mdl",
	Weight = 10,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_svoboda_seva") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_svoboda_seva") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 60,
		speedloss_percent = 10,
		oxygen_capacity = 4,
		slots = 3,
		battery = 150,
		carryweight = 5,
		allowmodels = {"models/stalkertnb/seva_free.mdl"}
	}
})

GM:CreateItem("item_armor_dolg_seva", {
	Name = "Duty SEVA Protection Suit",
	Description = "",
	Cost = 130000,
	Model = "models/stalkertnb/seva_duty.mdl",
	Weight = 10,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_dolg_seva") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_dolg_seva") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 60,
		speedloss_percent = 10,
		oxygen_capacity = 4,
		slots = 3,
		battery = 150,
		carryweight = 5,
		allowmodels = {"models/stalkertnb/seva_duty.mdl"}
	}
})

GM:CreateItem("item_armor_monolith_seva_heavy", {
	Name = "Monolith Heavy SEVA Protection Suit",
	Description = "",
	Cost = 195000,
	Model = "models/stalkertnb/seva_monolith_heavy.mdl",
	Weight = 16.5,
	Supply = 0,
	Rarity = 7,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_monolith_seva_heavy") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_monolith_seva_heavy") return drop end,
	ArmorStats = {
		reduction = 45,
		env_reduction = 60,
		speedloss_percent = 16,
		oxygen_capacity = 4.5,
		slots = 3,
		battery = 150,
		carryweight = 5,
		allowmodels = {"models/stalkertnb/seva_monolith_heavy.mdl"}
	}
})

GM:CreateItem("item_armor_exo_dolg_heavy", {
	Name = "Duty Heavy SKAT Exoskeleton",
	Description = "This armor used by Duty Legends is not only very expensive but also incredibly bulky! Designed for top level military operations.",
	Cost = 475000,
	Model = "models/stalkertnb/exo_skat_duty_heavy.mdl",
	Weight = 35,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg_heavy") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg_heavy") return drop end,
	ArmorStats = {
		reduction = 70,
		env_reduction = 40,
		speedloss_percent = 44,
		slots = 4,
		battery = 150,
		carryweight = 30,
		allowmodels = {"models/stalkertnb/exo_skat_duty_heavy.mdl"}
	}
})

GM:CreateItem("item_armor_rad_svoboda", {
	Name = "Freedom Radiation Suit",
	Description = "",
	Cost = 130000,
	Model = "models/stalkertnb/rad_free.mdl",
	Weight = 18,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_rad_svoboda") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_rad_svoboda") return drop end,
	ArmorStats = {
		reduction = 50,
		env_reduction = 35,
		speedloss_percent = 12,
		slots = 3,
		battery = 150,
		carryweight = 10,
		allowmodels = {"models/stalkertnb/rad_free.mdl"}
	}
})

GM:CreateItem("item_armor_rad_monolith_boss", {
	Name = "Heavy Monolith Radiation Suit",
	Description = "",
	Cost = 250000,
	Model = "models/stalkertnb/rad_monoboss.mdl",
	Weight = 23,
	Supply = 0,
	Rarity = 8,
	Category = ITEMCATEGORY_ARMOR,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_rad_monolith_boss") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_rad_monolith_boss") return drop end,
	ArmorStats = {
		reduction = 60,
		env_reduction = 45,
		speedloss_percent = 16,
		slots = 3,
		battery = 150,
		carryweight = 10,
		allowmodels = {"models/stalkertnb/rad_monoboss.mdl"}
	}
})
