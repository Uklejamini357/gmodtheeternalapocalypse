-- Extra Armors --
-- Sometimes, the fallout power/tesla armor is just far stronger than STALKER armors...

-- https://steamcommunity.com/sharedfiles/filedetails/?id=1478903778
-- Special ability: Absorbs 30% of incoming damage, for each 1 damage absorbed uses up 1 battery point.
GM:CreateItem("item_armor_marine_combat", {
	Name = "Marine Combat Armor",
	Description = "Marine Combat Armor",
	Cost = 275695,
	Model = "models/kuma96/marinecombatarmor_male/marinecombatarmor_male_pm.mdl",
	Weight = 31.09,
	Supply = -1,
	Rarity = RARITY_GODLY,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 72,
		env_reduction = 58,
		speedloss_percent = 18,
		slots = 3,
		battery = 250,
		carryweight = 5,
		allowmodels = {"models/kuma96/marinecombatarmor_male/marinecombatarmor_male_pm.mdl"}
	},

	ModOrigin = "Fallout 4"
})

-- https://steamcommunity.com/sharedfiles/filedetails/?id=1432299222 (replaced with lighter addon)
GM:CreateItem("item_armor_x01_tesla", {
	Name = "X-01 Power Armor",
	Description = "X-01 Power Armor from Fallout 4. Incredibly overpowered.",
	Cost = 1260235,
	Model = "models/models/frix/x01/xo1_powerarmor.mdl",
	Weight = 41.73,
	Supply = -1,
	Rarity = RARITY_GODLY,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 91.8,
		env_reduction = 86,
		speedloss_percent = 31,
		slots = 3,
		battery = 2500,
		carryweight = 10,
		allowmodels = {"models/models/frix/x01/xo1_powerarmor.mdl"}
	},

	ModOrigin = "Fallout 4"
})


-- https://steamcommunity.com/sharedfiles/filedetails/?id=3259876543
-- Special ability: deflects 5 + 10% of received melee damage (NYI)
GM:CreateItem("item_armor_power_tesla", {
	Name = "Tesla Power Armor",
	Description = "Tesla Power Armor",
	Cost = 128450,
	Model = "models/player/enc/tesla_power_armor.mdl",
	Weight = 18.14,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 68,
		env_reduction = 46,
		speedloss_percent = 16,
		slots = 3,
		battery = 650,
		carryweight = 10,
		allowmodels = {"models/player/enc/tesla_power_armor.mdl"}
	},

	ModOrigin = "Fallout 3"
})

-- https://steamcommunity.com/sharedfiles/filedetails/?id=175697854
GM:CreateItem("item_armor_daedric", {
	Name = "Daedric Armor",
	Description = "An extremely heavy Armor from Skyrim TES 5. No normal person can wear this without getting heavily burdened.",
	Cost = 393570,
	Model = "models/player/daedric.mdl",
	Weight = 43.54,
	Supply = -1,
	Rarity = RARITY_GODLY,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 83,
		env_reduction = 52,
		speedloss_percent = 42,
		slots = 3,
		battery = 100,
		carryweight = 20,
		allowmodels = {"models/player/daedric.mdl"}
	},

	ModOrigin = "The Elder Scrolls V: Skyrim"
})

-- https://steamcommunity.com/sharedfiles/filedetails/?id=1681584444
GM:CreateItem("item_armor_juggernaut", {
	Name = "Juggernaut Armor",
	Description = "Juggernaut Armor",
	Cost = 136025,
	Model = "models/mw2guy/riot/juggernaut.mdl",
	Weight = 28.68,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 68,
		env_reduction = 46,
		speedloss_percent = 16,
		slots = 3,
		battery = 150,
		carryweight = 10,
		allowmodels = {"models/mw2guy/riot/juggernaut.mdl"}
	},

	ModOrigin = "Call of Duty: Modern Warfare 2"
})

-- https://steamcommunity.com/sharedfiles/filedetails/?id=1739786965
-- Empowers damage by 15% (up to additional 100 damage), uses 1% battery for each 40 damage points boosted
GM:CreateItem("item_armor_razorback", {
	Name = "Razorback Armor",
	Description = "Razorback Armor",
	Cost = 195035,
	Model = "models/player/keitho/razorback.mdl",
	Weight = 17.23,
	Supply = -1,
	Rarity = RARITY_GODLY,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 68,
		env_reduction = 46,
		speedloss_percent = 16,
		slots = 3,
		battery = 250,
		carryweight = 10,
		allowmodels = {"models/player/keitho/razorback.mdl", "models/player/keitho/razormajor.mdl", "models/player/keitho/razorlight.mdl", "models/player/keitho/razorgrunt.mdl"}
	},

	-- ModOrigin = "Unknown"
})

-- https://steamcommunity.com/sharedfiles/filedetails/?id=3237166759
GM:CreateItem("item_armor_t45d", {
	Name = "T-45d Power Armor",
	Description = "T-45d Power Armor",
	Cost = 219235,
	Model = "models/player/fallout_3/slow_t45d.mdl",
	Weight = 22.68,
	Supply = -1,
	Rarity = RARITY_GODLY,
	Category = ITEMCATEGORY_ARMOR,
    ItemType = ITEMTYPE_ARMOR,
	ArmorStats = {
		reduction = 73,
		env_reduction = 66,
		speedloss_percent = 21,
		slots = 3,
		battery = 750,
		carryweight = 10,
		allowmodels = {"models/player/fallout_3/slow_t45d.mdl"}
	},

	ModOrigin = "Fallout 3"
})


