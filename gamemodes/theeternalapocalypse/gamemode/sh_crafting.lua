GM.CraftableList = {
	["item_armor_scrap"] = {	-- if you know
		["Model"] = "models/player/group03/male_05.mdl",	-- model used for item
		["XP"] = 100,	-- XP gained on successful item craft
		["CraftTime"] = 5,	-- Time in seconds it takes to craft an item
		["Requirements"] = {
			["item_craft_battery"] = 1,
			["item_scrap"] = 5,
			["item_armorkevlar"] = 3,
		},
	},
}

GM.CraftableSpecialList = {
	["weapon_zw_plasmalauncher"] = {
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
		["XP"] = 500,
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 5,
		},
	},
}

