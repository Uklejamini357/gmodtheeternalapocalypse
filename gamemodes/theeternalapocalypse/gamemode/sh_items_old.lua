
-- This file is only to get old items table. Only in case if something happened.

local trans_get = translate.Get
local trans_format = translate.Format

-- Consumables


GM.ItemsList = {
	["item_bandage"] = {
		Name = trans_get("item_bandage_n"),
		Description = trans_get("item_bandage_d"),
		Cost = 55,
		Model = "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl",
		Weight = 0.06,
		Supply = 0,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local healing = UseFunc_Heal(ply, 3, 11, 0, "comrade_vodka/inv_bandages.ogg") return healing end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end
	},

	["item_medkit"] = {
		Name = "",
		Description = "",
		Cost = 175,
		Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
		Weight = 0.5,
		Supply = 30,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) local healing = UseFunc_Heal(ply, 3, 45, 5, "comrade_vodka/inv_aptecka.ogg") return healing end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_medkit") return drop end
	},

	["item_armymedkit"] = {
		Name = "",
		Description = "",
		Cost = 300,
		Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl",
		Weight = 0.6,
		Supply = 10,
		Rarity = 4,
		Category = 1,
		UseFunc = function(ply) local healing = UseFunc_Heal(ply, 3, 70, 20, "comrade_vodka/inv_aptecka.ogg") return healing end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armymedkit") return drop end
	},

	["item_scientificmedkit"] = {
		Name = "",
		Description = "",
		Cost = 500,
		Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl",
		Weight = 0.65,
		Supply = 5,
		Rarity = 5,
		Category = 1,
		UseFunc = function(ply) local healing = UseFunc_Heal(ply, 3, 100, 60, "comrade_vodka/inv_aptecka.ogg") return healing end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_scientificmedkit") return drop end
	},

	["item_antidote"] = {
		Name = "",
		Description = "",
		Cost = 100,
		Model = "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl",
		Weight = 0.08,
		Supply = 12,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) local healing = UseFunc_HealInfection(ply, 3, 40, "items/medshot4.wav") return healing end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end
	},

	["item_egg"] = {
		Name = "",
		Description = "",
		Cost = 10,
		Model = "models/props_phx/misc/egg.mdl",
		Weight = 0.08,
		Supply = 0,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 1, 0, 4, -1, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_egg") return drop end
	},

	["item_milk"] = {
		Name = "",
		Description = "",
		Cost = 35,
		Model = "models/props_junk/garbage_milkcarton002a.mdl",
		Weight = 1.05,
		Supply = 20,
		Rarity = RARITY_JUNK,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 0, 3, 20, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_milk") return drop end
	},

	["item_soda"] = {
		Name = "",
		Description = "",
		Cost = 50,
		Model = "models/props_junk/PopCan01a.mdl",
		Weight = 0.33,
		Supply = 0,
		Rarity = RARITY_JUNK,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Drink(ply, 3, 1, 8, 35, 5, -1, "comrade_vodka/inv_drink_can2.ogg") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end
	},

	["item_energydrink"] = {
		Name = "",
		Description = "",
		Cost = 100,
		Model = "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl",
		Weight = 0.36,
		Supply = 0,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 1, 5, 30, 55, -8, "comrade_vodka/inv_drink_can.ogg") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink") return drop end
	},

	["item_energydrink_nonstop"] = {
		Name = "",
		Description = "",
		Cost = 145,
		Model = "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl",
		Weight = 0.38,
		Supply = 0,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 2, 6, 32, 85, -11, "comrade_vodka/inv_drink_can.ogg") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink_nonstop") return drop end
	},

	["item_beerbottle"] = {
		Name = "",
		Description = "",
		Cost = 35,
		Model = "models/props_junk/garbage_glassbottle003a.mdl",
		Weight = 0.8,
		Supply = 10,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Drink(ply, 5, 1, 9, 5, -15, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end
	},


	["item_tinnedfood"] = {
		Name = "",
		Description = "",
		Cost = 45,
		Model = "models/props_junk/garbage_metalcan001a.mdl",
		Weight = 0.4,
		Supply = 30,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 2, 3, 20, -10, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end
	},

	["item_potato"] = {
		Name = "",
		Description = "",
		Cost = 60,
		Model = "models/props_phx/misc/potato.mdl",
		Weight = 0.2,
		Supply = 20,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 2, 2, 22, -8, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end
	},

	["item_traderfood"] = {
		Name = "",
		Description = "",
		Cost = 75,
		Model = "models/props_junk/garbage_takeoutcarton001a.mdl",
		Weight = 0.6,
		Supply = 5,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 4, 47, -15, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end
	},

	["item_trout"] = {
		Name = "",
		Description = "",
		Cost = 95,
		Model = "models/props/CS_militia/fishriver01.mdl",
		Weight = 0.75,
		Supply = 2,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 6, 5, 65, -4, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end
	},

	["item_melon"] = {
		Name = "",
		Description = "",
		Cost = 150,
		Model = "models/props_junk/watermelon01.mdl",
		Weight = 2,
		Supply = 3,
		Rarity = 3,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 7, 7, 85, 20, 3, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end
	},

	["item_burger"] = {
		Name = "",
		Description = "",
		Cost = 750,
		Model = "models/food/burger.mdl",
		Weight = 0.4,
		Supply = -1,
		Rarity = 7,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 30, 100, 15, 90, -15, "vo/npc/male01/yeah02.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end
	},

	["item_hotdog"] = {
		Name = "",
		Description = "",
		Cost = 400,
		Model = "models/food/hotdog.mdl",
		Weight = 0.35,
		Supply = -1,
		Rarity = 6,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 20, 80, 10, 40, -15, "vo/npc/male01/nice.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_hotdog") return drop end
	},

	["item_donut"] = {
		Name = "",
		Description = "",
		Cost = 65,
		Model = "models/noesis/donut.mdl",
		Weight = 0.2,
		Supply = 5,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local food = UseFunc_Eat(ply, 3, 2, 25, -7, 5, -1, "npc/barnacle/barnacle_gulp2.wav") return food end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_donut") return drop end
	},

	["item_bed"] = {
		Name = "",
		Description = "",
		Cost = 80,
		Model = "models/props/de_inferno/bed.mdl",
		Weight = 4.5,
		Supply = 0,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
		DropFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
	},

	["item_sleepingbag"] = {
		Name = "",
		Description = "",
		Cost = 1130,
		Model = "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl",
		Weight = 2.2,
		Supply = 0,
		Rarity = 5,
		Category = 1,
		UseFunc = function(ply) UseFunc_Sleep(ply, false) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end
	},

	["item_amnesiapills"] = {
		Name = "",
		Description = "",
		Cost = 1250,
		Model = "models/props_lab/jar01b.mdl",
		Weight = 0.1,
		Supply = 0,
		Rarity = 2,
		Category = 1,
		UseFunc = function(ply) local bool = UseFunc_Respec(ply) return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end
	},

	["item_armorbattery"] = {
		Name = "",
		Description = "",
		Cost = 600,
		Model = "models/Items/battery.mdl",
		Weight = 0.35,
		Supply = 6,
		Rarity = 4,
		Category = 1,
		UseFunc = function(ply) local armor = UseFunc_Armor(ply, 2, 50, 15, "items/battery_pickup.wav") return armor end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armorbattery") return drop end
	},

	["item_armorkevlar"] = {
		Name = "",
		Description = "",
		Cost = 1500,
		Model = "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl",
		Weight = 1.13,
		Supply = 3,
		Rarity = 5,
		Category = 1,
		UseFunc = function(ply) local armor = UseFunc_Armor(ply, 4, 0, 35, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armorkevlar") return drop end
	},





-- sellables





	["item_radio"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 0,
		Model = "models/props/cs_office/Snowman_arm.mdl",
		Weight = 0.1,
		Supply = -1,
		Rarity = RARITY_TRASH,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end
	},

	--secret item?????
	["upgradestatimmune"] = {
		Name = "",
		Description = "",
		Cost = 0,
		Model = "models/items/healthkit.mdl",
		Weight = 0,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat("NO!") return true end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "upgradestatimmune") return drop end,
		IsSecret = true
	},


-- crafting related


	["item_craft_fueltank"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 3000,
		Model = "models/props_c17/TrapPropeller_Engine.mdl",
		Weight = 5,
		Supply = -1,
		Rarity = 11,
		Category = 1,
		UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_large") return drop end
	},



	["item_boss_shard"] = {
		Cost = 75000,
		Model = "models/props_lab/clipboard.mdl",
		Weight = 1,
		Supply = -1,
		Rarity = 8,
		Category = 1,
		UseFunc = function(ply) ply:SendChat("No ;)") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_boss_shard") return drop end
	},

	["item_money"] = {
		Cost = 0,
		Model = "",
		Weight = 0,
		Supply = -1,
		Rarity = RARITY_COMMON,
		Category = 1,
		UseFunc = function(ply)  return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_money") return drop end
	},




-- guns





	["weapon_tea_noobcannon"] = {
		Name = "",
		Description = "",
		Cost = 0,
		Model = "models/weapons/w_pist_glock18.mdl",
		Weight = 1.1,
		Supply = -1, -- -1 stock means the traders will never sell this item (yea we get it)
		Rarity = RARITY_JUNK,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_noobcannon") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_noobcannon") UseFunc_StripWeapon(ply, "weapon_tea_noobcannon", drop) return drop end
	},

	["weapon_tea_pigsticker"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 45,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = RARITY_JUNK,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end
	},

	["item_m9k_smgammo"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 130,
		Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		Weight = 1,
		Supply = 0,
		Rarity = 2,
		Category = 2,
		UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end
	},

	["item_crossbowbolt"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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

-- Weapons that were earlier cut in The Eternal Apocalypse, but added back anyway

	["weapon_tea_amex"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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



["weapon_tea_deadly_minigun"] = {
	Name = "",
	Description = "",
	Cost = 47000,
	Model = "models/weapons/w_m134_minigun.mdl",
	Weight = 16.96,
	Supply = -1,
	Rarity = 6,
	Category = 3,
	UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_minigun") return false end,
	DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_minigun") UseFunc_StripWeapon(ply, "weapon_tea_deadly_minigun", drop) return drop end
},




-- M9k guns


	["m9k_coltpython"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 26500,
		Model = "models/weapons/w_masada_acr.mdl",
		Weight = 4.2,
		Supply = 0,
		Rarity = 6,
		Category = 3,
		UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_acr") return false end,
		DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_acr") UseFunc_StripWeapon(ply, "m9k_acr", drop) return drop end
	},
	
	["m9k_ak47"] = {
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
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
		Name = "",
		Description = "",
		Cost = 5000,
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
		Name = "",
		Description = "",
		Cost = 8500,
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
		Name = "",
		Description = "",
		Cost = 10000,
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
		Name = "",
		Description = "",
		Cost = 12500,
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
		Name = "",
		Description = "",
		Cost = 15000,
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
		Name = "",
		Description = "",
		Cost = 20000,
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
		Name = "",
		Description = "",
		Cost = 25000,
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
		Name = "",
		Description = "",
		Cost = 27500,
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
		Name = "",
		Description = "",
		Cost = 26000,
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
		Name = "",
		Description = "",
		Cost = 30000,
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
		Name = "",
		Description = "",
		Cost = 35000,
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
		Name = "",
		Description = "",
		Cost = 37000,
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
		Name = "",
		Description = "",
		Cost = 36000,
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
		Name = "",
		Description = "",
		Cost = 40000,
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
		Name = "",
		Description = "",
		Cost = 55000,
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
		Name = "",
		Description = "",
		Cost = 80000,
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
		Name = "",
		Description = "",
		Cost = 60000,
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
		Name = "",
		Description = "",
		Cost = 75000,
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
		Name = "",
		Description = "",
		Cost = 125000,
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
		Name = "",
		Description = "",
		Cost = 150000,
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
		Name = "",
		Description = "",
		Cost = 250000,
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
		Name = "",
		Description = "",
		Cost = 225000,
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
		Name = "",
		Description = "",
		Cost = 275000,
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
		Name = "",
		Description = "",
		Cost = 237500,
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
		Name = "",
		Description = "",
		Cost = 262500,
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
		Name = "",
		Description = "",
		Cost = 650000,
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

