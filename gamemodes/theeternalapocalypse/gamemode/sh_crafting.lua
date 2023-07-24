---- The craftable items list is still in progress, so...

GM.CraftableList = {
	["item_armor_scrap"] = {	-- if you know what this is meant for
		["Model"] = "models/player/group03/male_05.mdl",	-- model used for item
		["XP"] = 130,	-- XP gained on successful item craft
		["CraftTime"] = 12,	-- Time in seconds it takes to craft an item
		["Requirements"] = { -- Required items for crafting an item (as a table value)
			["item_craft_battery"] = 1,
			["item_scrap"] = 5,
			["item_armorkevlar"] = 3,
		},
	},

	["item_armorbattery"] = {
		["Model"] = "models/Items/battery.mdl",
		["XP"] = 40,
		["CraftTime"] = 7,
		["Requirements"] = {
			["item_craft_battery"] = 2,
		},
	},

	["item_scrap"] = {
		["Model"] = "models/Items/battery.mdl",
		["XP"] = 40,
		["CraftTime"] = 7,
		["Requirements"] = {
			["item_craft_battery"] = 2,
		},
	},
}


-- Still not working!!

GM.CraftableSpecialList = {
	["weapon_tea_plasmalauncher"] = {
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
		["XP"] = 1500,
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

