-- M9k Weapons --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, { -- It's necessary to use the Entity Classname here for the weapon.
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, itemid) end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, itemid) return drop end,

	-- armor only values
	ArmorStats = {
		reduction = number,			-- damage reduction in percentage
		env_reduction = number,		-- damage reduction from environment in percentage (protection from entity classes "trigger_hurt", "point_hurt", "entityflame", "env_fire" and nothing else)
		speedloss = number,			-- speed loss in source units (default player sprint speed: 260 (330 with maxed speed stat))
		slots = number,				-- attachment slots (to be removed)
		battery = number,			-- battery capacity, suits with 0 battery will only be able to use passive attachments (may be reworked, with flashlight)
		carryweight = number,		-- additional max carryweight when user wears the armor
		allowmodels = table			-- force the player to be one of these models, nil to let them choose from the default citizen models
	}

-- Additional variables if needed
    IsSecret = false,
})

]]

-- Pistols and Revolvers
GM:CreateItem("item_armor_jacket_leather", {
	Cost = 4000,
	Model = "models/player/group03/male_07.mdl",
	Weight = 1.1,
	Supply = 0,
	Rarity = 2,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_leather") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_leather") return drop end,

	ArmorStats = {
		reduction = 5,
		env_reduction = 2.5,
		speedloss = 0,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_chainmail") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chainmail") return drop end,

	ArmorStats = {
		reduction = 7.5,
		env_reduction = 2.5,
		speedloss = 10,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_bandit") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_bandit") return drop end,
	ArmorStats = {
		reduction = 8,
		env_reduction = 3.5,
		speedloss = 10,
		slots = 1,
		battery = 0,
		carryweight = 0,
		allowmodels = {"models/player/stalker/bandit_backpack.mdl"}
	}
})

GM:CreateItem("item_armor_scrap", {
	Cost = 10000,
	Model = "models/player/group03/male_05.mdl",
	Weight = 3.8,
	Supply = 0,
	Rarity = 3,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
	ArmorStats = {
		reduction = 12.5,
		env_reduction = 2.5,
		speedloss = 35,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_brown") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_brown") return drop end,
	ArmorStats = {
		reduction = 10,
		env_reduction = 5,
		speedloss = 10,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_black") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_black") return drop end,
	ArmorStats = {
		reduction = 15,
		env_reduction = 6.25,
		speedloss = 17.5,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_guerilla") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_guerilla") return drop end,
	ArmorStats = {
		reduction = 16.25,
		env_reduction = 7.5,
		speedloss = 25,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_arctic") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_arctic") return drop end,
	ArmorStats = {
		reduction = 16.25,
		env_reduction = 8.75,
		speedloss = 27.5,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_leet") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_leet") return drop end,
	ArmorStats = {
		reduction = 15,
		env_reduction = 5,
		speedloss = 20,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_phoenix") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_phoenix") return drop end,
	ArmorStats = {
		reduction = 20,
		env_reduction = 10,
		speedloss = 30,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_gasmask") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_gasmask") return drop end,
	ArmorStats = {
		reduction = 22.5,
		env_reduction = 15,
		speedloss = 47.5,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_riot") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_riot") return drop end,
	ArmorStats = {
		reduction = 25,
		env_reduction = 10,
		speedloss = 55,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_swat") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_swat") return drop end,
	ArmorStats = {
		reduction = 23.75,
		env_reduction = 12.5,
		speedloss = 53.75,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_urban") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_urban") return drop end,
	ArmorStats = {
		reduction = 27.5,
		env_reduction = 12.5,
		speedloss = 57.5,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise") return drop end,
	ArmorStats = {
		reduction = 30,
		env_reduction = 20,
		speedloss = 33.75,
		slots = 3,
		battery = 75,
		carryweight = 0,
		allowmodels = {"models/player/stalker/loner_vet.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_dolg", {
	Cost = 61000,
	Model = "models/player/stalker/duty_vet.mdl",
	Weight = 7.1,
	Supply = 0,
	Rarity = 6,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_dolg") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_dolg") return drop end,
	ArmorStats = {
		reduction = 37.5,
		env_reduction = 20,
		speedloss = 42.5,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/duty_vet.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_svoboda", {
	Cost = 46000,
	Model = "models/player/stalker/freedom_vet.mdl",
	Weight = 5,
	Supply = 0,
	Rarity = 6,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_svoboda") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_svoboda") return drop end,
	ArmorStats = {
		reduction = 30,
		env_reduction = 20,
		speedloss = 27.5,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/freedom_vet.mdl"}
	}
})

GM:CreateItem("item_armor_sunrise_monolith", {
	Cost = 58750,
	Model = "models/player/stalker/monolith_vet.mdl",
	Weight = 6,
	Supply = 3,
	Rarity = 6,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_monolith") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_monolith") return drop end,
	ArmorStats = {
		reduction = 35,
		env_reduction = 20,
		speedloss = 35,
		slots = 3,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/monolith_vet.mdl"}
	}
})

GM:CreateItem("item_armor_military_green", {
	Cost = 95000,
	Model = "models/player/stalker/military_spetsnaz_green.mdl",
	Weight = 12,
	Supply = 0,
	Rarity = 6,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_green") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_green") return drop end,
	ArmorStats = {
		reduction = 42.5,
		env_reduction = 25,
		speedloss = 50,
		slots = 2,
		battery = 100,
		carryweight = 0,
		allowmodels = {"models/player/stalker/military_spetsnaz_green.mdl"}
	}
})

GM:CreateItem("item_armor_military_black", {
	Cost = 115000,
	Model = "models/player/stalker/military_spetsnaz_black.mdl",
	Weight = 15,
	Supply = 0,
	Rarity = 7,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_black") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_black") return drop end,
	ArmorStats = {
		reduction = 47.5,
		env_reduction = 27.5,
		speedloss = 70,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
	ArmorStats = {
		reduction = 60,
		env_reduction = 25,
		speedloss = 125,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_merc") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_merc") return drop end,
	ArmorStats = {
		reduction = 57.5,
		env_reduction = 25,
		speedloss = 115,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/merc_exo.mdl"}
	}
})

GM:CreateItem("item_armor_exo_dolg", {
	Cost = 212500,
	Model = "models/player/stalker/duty_exo.mdl",
	Weight = 27.5,
	Supply = 0,
	Rarity = 8,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg") return drop end,
	ArmorStats = {
		reduction = 65,
		env_reduction = 25,
		speedloss = 130,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/duty_exo.mdl"}
	}
})

GM:CreateItem("item_armor_exo_svoboda", {
	Cost = 185000,
	Model = "models/player/stalker/freedom_exo.mdl",
	Weight = 22.5,
	Supply = 0,
	Rarity = 7,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_svoboda") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_svoboda") return drop end,
	ArmorStats = {
		reduction = 55,
		env_reduction = 25,
		speedloss = 110,
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
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_monolith") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_monolith") return drop end,
	ArmorStats = {
		reduction = 62.5,
		env_reduction = 30,
		speedloss = 125,
		slots = 3,
		battery = 100,
		carryweight = 30,
		allowmodels = {"models/player/stalker/monolith_exo.mdl"}
	}
})

GM:CreateItem("item_armor_cs2_goggles", {
	Cost = 450000,
	Model = "models/stalkertnb/cs2_goggles.mdl",
	Weight = 13.5,
	Supply = 0,
	Rarity = 9,
	Category = 4,
	UseFunc = function(ply) UseFunc_EquipArmor(ply, "item_armor_cs2_goggles") end,
	DropFunc = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_cs2_goggles") return drop end,
	ArmorStats = {
		reduction = 40,
		env_reduction = 35,
		speedloss = -12.5,
		slots = 3,
		battery = 200,
		carryweight = 10,
		allowmodels = {"models/stalkertnb/cs2_goggles.mdl"}
	}
})

