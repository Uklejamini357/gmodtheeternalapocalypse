--sorry i haven't finished m9k item list yet
/*
Item template:

["item_healthkit"] = { 				-- what the item will be called within the games code, can be anything as long as you don't use the same name twice
	["Name"] = "Medkit", 			-- what the item will be called ingame
	["Cost"] = 200,					-- how many Gold will it cost if you buy it from the trader?
	["Model"] = "models/Items/HealthKit.mdl",			-- the items model
	["Description"] = "stuff",				-- the description will show up in the trader buy menu and in your inventory when you mouse over it
	["Weight"] = 1,						-- weight in kilograms (if your american and want to use imperial then your shit out of luck m8)
	["Supply"] = 0,						-- how many of these items does each trader have in stock? stock refills every 24 hours. (Stock limits don't work, will try to fix/add one)  Putting 0 means unlimited stock, Putting -1 as stock will make it so the item isn't sold by traders
	["Rarity"] = 1,						-- 0 = trash, 1 = junk, 2 = common, 3 = uncommon, 4 = rare, 5 = super rare, 6 = epic, 7 = mythic, 8 = legendary, 9 = godly, 10 = event, 11 = unobtainable, any other = pending
	["Category"] = 1,					-- 1 = supplies, 2 = ammunition, 3 = weapons, 4 = armor, any other = ignored by trader
	["UseFunc"] = stuff 				-- the function to call when the player uses the item from their inventory, you will need lua skillz here
	["DropFunc"] = stuff 				-- the function to call when the player drops the item, just like usefunc, you need to know lua here
}


// IMPORTANT NOTE: Use and drop functions must always return true or false here.  Returning true will subtract one of that item type from the player, returning false will make it so nothing is subtracted.
see server/player_inventory.lua for more info


*/


ItemsList = {
	["item_bandage"] = {
		["Name"] = "Bandage",
		["Cost"] = 65,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl",
		["Description"] = "Bandage_d",
		["Weight"] = 0.06,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 3, 11, 0, "comrade_vodka/inv_bandages.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,
	},

	["item_medkit"] = {
		["Name"] = "Medkit",
		["Cost"] = 175,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
		["Description"] = "Medkit_d",
		["Weight"] = 0.5,
		["Supply"] = 30,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 3, 45, 5, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_medkit") return drop end,
	},

	["item_armymedkit"] = {
		["Name"] = "ArmyMedkit",
		["Cost"] = 300,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl",
		["Description"] = "ArmyMedkit_d",
		["Weight"] = 0.6,
		["Supply"] = 10,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 3, 70, 20, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armymedkit") return drop end,
	},

	["item_scientificmedkit"] = {
		["Name"] = "ScientificMedkit",
		["Cost"] = 500,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl",
		["Description"] = "ScientificMedkit_d",
		["Weight"] = 0.65,
		["Supply"] = 5,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 3, 100, 60, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_scientificmedkit") return drop end,
	},

	["item_antidote"] = {
		["Name"] = "Antidote",
		["Cost"] = 100,
		["Model"] = "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl",
		["Description"] = "Antidote_d",
		["Weight"] = 0.08,
		["Supply"] = 12,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_HealInfection(ply, 4, 40, "items/medshot4.wav") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end,
	},

	["item_egg"] = {
		["Name"] = "Egg",
		["Cost"] = 10,
		["Model"] = "models/props_phx/misc/egg.mdl",
		["Description"] = "Egg_d",
		["Weight"] = 0.08,
		["Supply"] = 0,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 1, 0, 4, -1, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_egg") return drop end,
	},

	["item_milk"] = {
		["Name"] = "Milk",
		["Cost"] = 35,
		["Model"] = "models/props_junk/garbage_milkcarton002a.mdl",
		["Description"] = "Milk_d",
		["Weight"] = 1.05,
		["Supply"] = 20,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Drink(ply, 4, 0, 3, 20, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_milk") return drop end,
	},

	["item_soda"] = {
		["Name"] = "Soda",
		["Cost"] = 50,
		["Model"] = "models/props_junk/PopCan01a.mdl",
		["Description"] = "Soda_d",
		["Weight"] = 0.33,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Drink(ply, 3, 1, 8, 35, 5, -1, "comrade_vodka/inv_drink_can2.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end,
	},

	["item_energydrink"] = {
		["Name"] = "EnergyDrink",
		["Cost"] = 70,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl",
		["Description"] = "EnergyDrink_d",
		["Weight"] = 0.36,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Drink(ply, 4, 1, 5, 30, 55, -8, "comrade_vodka/inv_drink_can.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink") return drop end,
	},

	["item_energydrink_nonstop"] = {
		["Name"] = "NonstopEnergyDrink",
		["Cost"] = 110,
		["Model"] = "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl",
		["Description"] = "NonstopEnergyDrink_d",
		["Weight"] = 0.38,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Drink(ply, 4, 2, 6, 32, 85, -11, "comrade_vodka/inv_drink_can.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink_nonstop") return drop end,
	},

	["item_beerbottle"] = {
		["Name"] = "BeerBottle",
		["Cost"] = 35,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "BeerBottle_d",
		["Weight"] = 0.8,
		["Supply"] = 10,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Drink(ply, 5, 1, 9, 5, -15, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end,
	},


	["item_tinnedfood"] = {
		["Name"] = "TinnedRations",
		["Cost"] = 45,
		["Model"] = "models/props_junk/garbage_metalcan001a.mdl",
		["Description"] = "TinnedRations_d",
		["Weight"] = 0.4,
		["Supply"] = 30,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 2, 3, 20, -10, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end,
	},

	["item_potato"] = {
		["Name"] = "Potato",
		["Cost"] = 60,
		["Model"] = "models/props_phx/misc/potato.mdl",
		["Description"] = "Potato_d",
		["Weight"] = 0.2,
		["Supply"] = 20,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 2, 2, 22, -8, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end,
	},

	["item_traderfood"] = {
		["Name"] = "TraderSpecial",
		["Cost"] = 75,
		["Model"] = "models/props_junk/garbage_takeoutcarton001a.mdl",
		["Description"] = "TraderSpecial_d",
		["Weight"] = 0.6,
		["Supply"] = 5,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 5, 4, 47, -15, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end,
	},

	["item_trout"] = {
		["Name"] = "RiverTrout",
		["Cost"] = 95,
		["Model"] = "models/props/CS_militia/fishriver01.mdl",
		["Description"] = "RiverTrout_d",
		["Weight"] = 0.75,
		["Supply"] = 2,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 6, 5, 65, -4, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end,
	},

	["item_melon"] = {
		["Name"] = "Melon",
		["Cost"] = 150,
		["Model"] = "models/props_junk/watermelon01.mdl",
		["Description"] = "Melon_d",
		["Weight"] = 2,
		["Supply"] = 3,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 7, 7, 85, 20, 3, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end,
	},

	["item_burger"] = {
		["Name"] = "Burger",
		["Cost"] = 750,
		["Model"] = "models/food/burger.mdl",
		["Description"] = "Burger_d",
		["Weight"] = 0.4,
		["Supply"] = -1,
		["Rarity"] = 7,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 5, 30, 100, 15, 90, -15, "vo/npc/male01/yeah02.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end,
	},

	["item_hotdog"] = {
		["Name"] = "Hotdog",
		["Cost"] = 400,
		["Model"] = "models/food/hotdog.mdl",
		["Description"] = "Hotdog_d",
		["Weight"] = 0.35,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 5, 20, 80, 10, 40, -15, "vo/npc/male01/nice.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_hotdog") return drop end,
	},

	["item_donut"] = {
		["Name"] = "Donut",
		["Cost"] = 65,
		["Model"] = "models/noesis/donut.mdl",
		["Description"] = "Donut_d",
		["Weight"] = 0.2,
		["Supply"] = 5,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 3, 2, 25, -7, 5, -1, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_donut") return drop end,
	},

	["item_bed"] = {
		["Name"] = "Bed",
		["Cost"] = 80,
		["Model"] = "models/props/de_inferno/bed.mdl",
		["Description"] = "Bed_d",
		["Weight"] = 4.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
		["DropFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
	},

	["item_sleepingbag"] = {
		["Name"] = "SleepingBag",
		["Cost"] = 1130,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl",
		["Description"] = "SleepingBag_d",
		["Weight"] = 2.2,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) UseFunc_Sleep(ply, false) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end,
	},

	["item_amnesiapills"] = {
		["Name"] = "AmnesiaPills",
		["Cost"] = 1250,
		["Model"] = "models/props_lab/jar01b.mdl",
		["Description"] = "AmnesiaPills_d",
		["Weight"] = 0.1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_Respec(ply) return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end,
	},

	["item_armorbattery"] = {
		["Name"] = "ArmorBattery",
		["Cost"] = 600,
		["Model"] = "models/Items/battery.mdl",
		["Description"] = "ArmorBattery_d",
		["Weight"] = 0.35,
		["Supply"] = 6,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 2, 15, "items/battery_pickup.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armorbattery") return drop end,
	},

	["item_armorkevlar"] = {
		["Name"] = "ArmorKevlar",
		["Cost"] = 1500,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl",
		["Description"] = "ArmorKevlar_d",
		["Weight"] = 1.13,
		["Supply"] = 3,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 4, 35, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armorkevlar") return drop end,
	},





-- sellables





	["item_radio"] = {
		["Name"] = "Radio",
		["Cost"] = 300,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_radio.mdl",
		["Description"] = "Radio_d",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_radio") return drop end,
	},

	["item_scrap"] = {
		["Name"] = "ScrapMetal",
		["Cost"] = 350,
		["Model"] = "models/Gibs/helicopter_brokenpiece_02.mdl",
		["Description"] = "ScrapMetal_d",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 3, 10, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_scrap") return drop end,
	},

	["item_chems"] = {
		["Name"] = "Chemicals",
		["Cost"] = 600,
		["Model"] = "models/props_junk/plasticbucket001a.mdl",
		["Description"] = "Chemicals_d",
		["Weight"] = 1.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_chems") return drop end,
	},

	["item_tv"] = {
		["Name"] = "OldTV",
		["Cost"] = 800,
		["Model"] = "models/props_c17/tv_monitor01.mdl",
		["Description"] = "OldTV_d",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tv") return drop end,
	},

	["item_beer"] = {
		["Name"] = "CrateofBeer",
		["Cost"] = 1200,
		["Model"] = "models/props/CS_militia/caseofbeer01.mdl",
		["Description"] = "CrateofBeer_d",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beer") return drop end,
	},

	["item_hamradio"] = {
		["Name"] = "HamRadio",
		["Cost"] = 1500,
		["Model"] = "models/props_lab/citizenradio.mdl",
		["Description"] = "HamRadio_d",
		["Weight"] = 2.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_hamradio") return drop end,
	},

	["item_computer"] = {
		["Name"] = "OldPC",
		["Cost"] = 2000,
		["Model"] = "models/props_lab/harddrive02.mdl",
		["Description"] = "OldPC_d",
		["Weight"] = 4,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseSellable")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_computer") return drop end,
	},


	["item_blueprint_sawbow"] = {
		["Name"] = "SawBowBlueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "SawBowBlueprint_d",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseWeapon")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_sawbow") return drop end,
	},

	["item_blueprint_railgun"] = {
		["Name"] = "RailgunBlueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "RailgunBlueprint_d",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseWeapon")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_railgun") return drop end,
	},









-- junk




	["item_junk_tin"] = {
		["Name"] = "EmptyTin",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_metalcan002a.mdl",
		["Description"] = "EmptyTin_d",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_tin") return drop end,
	},

	["item_junk_boot"] = {
		["Name"] = "OldBoot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/Shoe001a.mdl",
		["Description"] = "OldBoot_d",
		["Weight"] = 0.17,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_boot") return drop end,
	},


	["item_junk_paper"] = {
		["Name"] = "OldNewspaper",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_newspaper001a.mdl",
		["Description"] = "OldNewspaper_d",
		["Weight"] = 0.12,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paper") return drop end,
	},

	["item_junk_keyboard"] = {
		["Name"] = "Keyboard",
		["Cost"] = 0,
		["Model"] = "models/props_c17/computer01_keyboard.mdl",
		["Description"] = "Keyboard_d",
		["Weight"] = 0.23,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_keyboard") return drop end,
	},

	["item_junk_gardenpot"] = {
		["Name"] = "GardenPot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/terracotta01.mdl",
		["Description"] = "GardenPot_d",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_gardenpot") return drop end,
	},

	["item_junk_paint"] = {
		["Name"] = "BucketPaint",
		["Cost"] = 0,
		["Model"] = "models/props_junk/metal_paintcan001a.mdl",
		["Description"] = "BucketPaint_d",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paint") return drop end,
	},

	["item_junk_doll"] = {
		["Name"] = "ToyDoll",
		["Cost"] = 0,
		["Model"] = "models/props_c17/doll01.mdl",
		["Description"] = "ToyDoll_d",
		["Weight"] = 0.15,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_doll") return drop end,
	},

	["item_junk_pot"] = {
		["Name"] = "TinPot",
		["Cost"] = 0,
		["Model"] = "models/props_interiors/pot02a.mdl",
		["Description"] = "TinPot_d",
		["Weight"] = 0.2,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end,
	},

	["item_junk_hula"] = {
		["Name"] = "HulaDoll",
		["Cost"] = 0,
		["Model"] = "models/props_lab/huladoll.mdl",
		["Description"] = "HulaDoll_d",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_hula") return drop end,
	},

	["item_junk_nailbox"] = {
		["Name"] = "Nailbox",
		["Cost"] = 0,
		["Model"] = "models/props_lab/box01a.mdl",
		["Description"] = "Nailbox_d",
		["Weight"] = 0.06,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_nailbox") return drop end,
	},

	["item_junk_twig"] = {
		["Name"] = "Twig",
		["Cost"] = 0,
		["Model"] = "models/props/cs_office/Snowman_arm.mdl",
		["Description"] = "Twig_d",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUse")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end,
	},

	--secret item?????
	["upgradestatimmune"] = {
		["Name"] = "[REMOVED ITEM]",
		["Cost"] = 0,
		["Model"] = "models/items/healthkit.mdl",
		["Description"] = "It is necessary to use this item.",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "NO!") return true end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "upgradestatimmune") return drop end,
	},


-- crafting related


	["item_craft_fueltank"] = {
		["Name"] = "FuelTank",
		["Cost"] = 500,
		["Model"] = "models/props_junk/metalgascan.mdl",
		["Description"] = "FuelTank_d",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseVehicle")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_fueltank") return drop end,
	},

	["item_craft_wheel"] = {
		["Name"] = "CarWheel",
		["Cost"] = 300,
		["Model"] = "models/props_vehicles/carparts_wheel01a.mdl",
		["Description"] = "CarWheel_d",
		["Weight"] = 1.5,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseVehicle")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_wheel") return drop end,
	},

	["item_craft_oil"] = {
		["Name"] = "EngineOil",
		["Cost"] = 500,
		["Model"] = "models/props_junk/garbage_plasticbottle001a.mdl",
		["Description"] = "EngineOil_d",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseVehicle")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_oil") return drop end,
	},

	["item_craft_battery"] = {
		["Name"] = "BatteryCell",
		["Cost"] = 500,
		["Model"] = "models/Items/car_battery01.mdl",
		["Description"] = "BatteryCell_d",
		["Weight"] = 0.6,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_battery") return drop end,
	},

	["item_craft_ecb"] = {
		["Name"] = "ECB",
		["Cost"] = 250,
		["Model"] = "models/props_lab/reciever01b.mdl",
		["Description"] = "ECB_d",
		["Weight"] = 0.35,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_ecb") return drop end,
	},

	["item_craft_engine_small"] = {
		["Name"] = "SmallEngine",
		["Cost"] = 1000,
		["Model"] = "models/gibs/airboat_broken_engine.mdl",
		["Description"] = "SmallEngine_d",
		["Weight"] = 3,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseVehicle")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_small") return drop end,
	},

	["item_craft_engine_large"] = {
		["Name"] = "LargeEngine",
		["Cost"] = 3000,
		["Model"] = "models/props_c17/TrapPropeller_Engine.mdl",
		["Description"] = "LargeEngine_d",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, translate.ClientGet(ply, "ItemNoUseVehicle")) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_large") return drop end,
	},






-- guns






	["weapon_zw_noobcannon"] = {
		["Name"] = "NoobCannon",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "NoobCannon_d",
		["Weight"] = 1.1,
		["Supply"] = -1, -- -1 stock means the traders will never sell this item
		["Rarity"] = 1,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_noobcannon") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_noobcannon") if drop then ply:StripWeapon("weapon_zw_noobcannon") end return drop end,
	},

	["weapon_zw_pigsticker"] = {
		["Name"] = "PigSticker",
		["Cost"] = 350,
		["Model"] = "models/weapons/w_knife_ct.mdl",
		["Description"] = "PigSticker_d",
		["Weight"] = 0.38,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_pigsticker") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_pigsticker") if drop then ply:StripWeapon("weapon_zw_pigsticker") end return drop end,
	},

	["weapon_zw_axe"] = {
		["Name"] = "Axe",
		["Cost"] = 800,
		["Model"] = "models/props/CS_militia/axe.mdl",
		["Description"] = "Axe_d",
		["Weight"] = 1.73,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_axe") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_axe") if drop then ply:StripWeapon("weapon_zw_axe")end return drop end,
	},

	["weapon_ate_wrench"] = {
		["Name"] = "BuildersWrench",
		["Cost"] = 800,
		["Model"] = "models/props_c17/tools_wrench01a.mdl",
		["Description"] = "BuildersWrench_d",
		["Weight"] = 0.47,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_ate_wrench") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_ate_wrench") if drop then ply:StripWeapon("weapon_ate_wrench")end  return drop end,
	},

	["weapon_zw_scrapsword"] = {
		["Name"] = "ScrapSword",
		["Cost"] = 1500,
		["Model"] = "models/props_c17/TrapPropeller_Blade.mdl",
		["Description"] = "ScrapSword_d",
		["Weight"] = 5.3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapsword") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapsword") if drop then ply:StripWeapon("weapon_zw_scrapsword")end return drop end,
	},

	["weapon_zw_g20"] = {
		["Name"] = "G20Gov",
		["Cost"] = 450,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "G20Gov_d",
		["Weight"] = 1.18,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_g20") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_g20") if drop then ply:StripWeapon("weapon_zw_g20")end  return drop end,
	},

	["weapon_zw_57"] = {
		["Name"] = "FN_FiveSeven",
		["Cost"] = 600,
		["Model"] = "models/weapons/w_pist_fiveseven.mdl",
		["Description"] = "FN_FiveSeven_d",
		["Weight"] = 0.82,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_57") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_57") if drop then ply:StripWeapon("weapon_zw_57")end  return drop end,
	},

	["weapon_zw_u45"] = {
		["Name"] = "U45Whisper",
		["Cost"] = 700,
		["Model"] = "models/weapons/w_pist_usp.mdl",
		["Description"] = "U45Whisper_d",
		["Weight"] = 1.1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_u45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_u45") if drop then ply:StripWeapon("weapon_zw_u45")end  return drop end,
	},


	["weapon_zw_warren50"] = {
		["Name"] = "Warren50",
		["Cost"] = 850,
		["Model"] = "models/weapons/w_pist_deagle.mdl",
		["Description"] = "Warren50_d",
		["Weight"] = 1.73,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_warren50") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_warren50") if drop then ply:StripWeapon("weapon_zw_warren50")end  return drop end,
	},

	["weapon_zw_python"] = {
		["Name"] = "PythonMagnum",
		["Cost"] = 1200,
		["Model"] = "models/weapons/w_357.mdl",
		["Description"] = "PythonMagnum_d",
		["Weight"] = 1.18,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_python") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_python") if drop then ply:StripWeapon("weapon_zw_python")end  return drop end,
	},

	["weapon_zw_dual"] = {
		["Name"] = "DualCutlass",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_pist_elite.mdl",
		["Description"] = "DualCutlass_d",
		["Weight"] = 2.72,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dual") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dual") if drop then ply:StripWeapon("weapon_zw_dual")end  return drop end,
	},

	["weapon_zw_satan"] = {
		["Name"] = "HandCannon",
		["Cost"] = 2250,
		["Model"] = "models/weapons/w_m29_satan.mdl",
		["Description"] = "HandCannon_d",
		["Weight"] = 3.14,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_satan") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_satan") if drop then ply:StripWeapon("weapon_zw_satan")end  return drop end,
	},

	["weapon_zw_mp11"] = {
		["Name"] = "MP11PDW",
		["Cost"] = 2250,
		["Model"] = "models/weapons/w_smg_mac10.mdl",
		["Description"] = "MP11PDW_d",
		["Weight"] = 2.85,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_mp11") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_mp11") if drop then ply:StripWeapon("weapon_zw_mp11")end  return drop end,
	},

	["weapon_zw_rg900"] = {
		["Name"] = "RG900",
		["Cost"] = 2500,
		["Model"] = "models/weapons/w_smg_tmp.mdl",
		["Description"] = "RG900_d",
		["Weight"] = 2.9,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rg900") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rg900") if drop then ply:StripWeapon("weapon_zw_rg900")end  return drop end,
	},

	["weapon_zw_k5a"] = {
		["Name"] = "KohlK5A",
		["Cost"] = 3250,
		["Model"] = "models/weapons/w_smg_mp5.mdl",
		["Description"] = "KohlK5A_d",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k5a") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k5a") if drop then ply:StripWeapon("weapon_zw_k5a")end  return drop end,
	},

	["weapon_zw_stinger"] = {
		["Name"] = "StingerSR",
		["Cost"] = 2800,
		["Model"] = "models/weapons/w_smg1.mdl",
		["Description"] = "StingerSR_d",
		["Weight"] = 3.85,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stinger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stinger") if drop then ply:StripWeapon("weapon_zw_stinger")end  return drop end,
	},

	["weapon_zw_bosch"] = {
		["Name"] = "BoschSterlingB60",
		["Cost"] = 3750,
		["Model"] = "models/weapons/w_sten.mdl",
		["Description"] = "BoschSterlingB60_d",
		["Weight"] = 3.45,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_bosch") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_bosch") if drop then ply:StripWeapon("weapon_zw_bosch")end  return drop end,
	},

	["weapon_zw_k8"] = {
		["Name"] = "KohlK8",
		["Cost"] = 5000,
		["Model"] = "models/weapons/w_smg_ump45.mdl",
		["Description"] = "KohlK8_d",
		["Weight"] = 3.12,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8") if drop then ply:StripWeapon("weapon_zw_k8")end  return drop end,
	},

	["weapon_zw_k8c"] = {
		["Name"] = "KohlK8C",
		["Cost"] = 5500,
		["Model"] = "models/weapons/w_hk_usc.mdl",
		["Description"] = "KohlK8C_d",
		["Weight"] = 3.15,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8c") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8c") if drop then ply:StripWeapon("weapon_zw_k8c")end  return drop end,
	},

	["weapon_zw_shredder"] = {
		["Name"] = "TheShredder",
		["Cost"] = 7750,
		["Model"] = "models/weapons/w_smg_p90.mdl",
		["Description"] = "TheShredder_d",
		["Weight"] = 3,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_shredder") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_shredder") if drop then ply:StripWeapon("weapon_zw_shredder")end  return drop end,
	},

	["weapon_zw_enforcer"] = {
		["Name"] = "M3Enforcer",
		["Cost"] = 5000,
		["Model"] = "models/weapons/w_shot_m3super90.mdl",
		["Description"] = "M3Enforcer_d",
		["Weight"] = 3.6,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_enforcer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_enforcer") if drop then ply:StripWeapon("weapon_zw_enforcer")end  return drop end,
	},

	["weapon_zw_sweeper"] = {
		["Name"] = "XS12Sweeper",
		["Cost"] = 7750,
		["Model"] = "models/weapons/w_shot_xm1014.mdl",
		["Description"] = "XS12Sweeper_d",
		["Weight"] = 3.8,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_sweeper") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_sweeper") if drop then ply:StripWeapon("weapon_zw_sweeper")end  return drop end,
	},

	["weapon_zw_ranger"] = {
		["Name"] = "XR15Ranger",
		["Cost"] = 7250,
		["Model"] = "models/weapons/w_rif_m4a1.mdl",
		["Description"] = "XR15Ranger_d",
		["Weight"] = 4.2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_ranger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_ranger") if drop then ply:StripWeapon("weapon_zw_ranger")end  return drop end,
	},

	["weapon_zw_fusil"] = {
		["Name"] = "FusilF1",
		["Cost"] = 7150,
		["Model"] = "models/weapons/w_rif_famas.mdl",
		["Description"] = "FusilF1_d",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fusil") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fusil") if drop then ply:StripWeapon("weapon_zw_fusil")end  return drop end,
	},

	["weapon_zw_stugcommando"] = {
		["Name"] = "StugCommando",
		["Cost"] = 9750, --time to increase cost again
		["Model"] = "models/weapons/w_rif_sg552.mdl",
		["Description"] = "StugCommando_d",
		["Weight"] = 4.45,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stugcommando") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stugcommando") if drop then ply:StripWeapon("weapon_zw_stugcommando")end  return drop end,
	},


	["weapon_zw_krukov"] = {
		["Name"] = "KrukovKA74",
		["Cost"] = 11000,
		["Model"] = "models/weapons/w_rif_ak47.mdl",
		["Description"] = "KrukovKA74_d",
		["Weight"] = 3.76,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_krukov") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_krukov") if drop then ply:StripWeapon("weapon_zw_krukov")end  return drop end,
	},

	["weapon_zw_l303"] = {
		["Name"] = "LiorL303",
		["Cost"] = 13500,
		["Model"] = "models/weapons/w_rif_galil.mdl",
		["Description"] = "LiorL303_d",
		["Weight"] = 5.35,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_l303") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_l303") if drop then ply:StripWeapon("weapon_zw_l303")end  return drop end,
	},

	["weapon_zw_scar"] = {
		["Name"] = "FNScar",
		["Cost"] = 22000,
		["Model"] = "models/weapons/w_fn_scar_h.mdl",
		["Description"] = "FNScar_d",
		["Weight"] = 4.6,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scar") if drop then ply:StripWeapon("weapon_zw_scar")end  return drop end,
	},

	["weapon_zw_lmg"] = {
		["Name"] = "SawtoothLMG4",
		["Cost"] = 16250,
		["Model"] = "models/weapons/w_mach_m249para.mdl",
		["Description"] = "SawtoothLMG4_d",
		["Weight"] = 7.5,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_lmg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_lmg") if drop then ply:StripWeapon("weapon_zw_lmg")end  return drop end,
	},


	["weapon_zw_antelope"] = {
		["Name"] = "Antelope762",
		["Cost"] = 9200,
		["Model"] = "models/weapons/w_snip_scout.mdl",
		["Description"] = "Antelope762_d",
		["Weight"] = 5.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_antelope") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_antelope") if drop then ply:StripWeapon("weapon_zw_antelope")end  return drop end,
	},

	["weapon_zw_scimitar"] = {
		["Name"] = "KohlK24Scimitar",
		["Cost"] = 12250, --wouldn't be a bad weapon with that low cost would it? now its' cost is higher
		["Model"] = "models/weapons/w_snip_g3sg1.mdl",
		["Description"] = "KohlK24Scimitar_d",
		["Weight"] = 5.4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scimitar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scimitar") if drop then ply:StripWeapon("weapon_zw_scimitar")end  return drop end,
	},

	["weapon_zw_blackhawk"] = {
		["Name"] = "BlackhawkSniper",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_snip_sg550.mdl",
		["Description"] = "BlackhawkSniper_d",
		["Weight"] = 6.35,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_blackhawk") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_blackhawk") if drop then ply:StripWeapon("weapon_zw_blackhawk")end  return drop end,
	},

	["weapon_zw_punisher"] = {
		["Name"] = "ThePunisher",
		["Cost"] = 35000,
		["Model"] = "models/weapons/w_acc_int_aw50.mdl",
		["Description"] = "ThePunisher_d",
		["Weight"] = 7.95,
		["Supply"] = 5,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_punisher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_punisher") if drop then ply:StripWeapon("weapon_zw_punisher")end  return drop end,
	},
	
	["weapon_zw_scrapcrossbow"] = {
		["Name"] = "ExplosiveCrossbow",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_crossbow.mdl",
		["Description"] = "ExplosiveCrossbow_d",
		["Weight"] = 8,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapcrossbow") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapcrossbow") if drop then ply:StripWeapon("weapon_zw_scrapcrossbow")end  return drop end,
	},

	["weapon_zw_winchester"] = {
		["Name"] = "Winchester",
		["Cost"] = 6500,
		["Model"] = "models/weapons/w_winchester_1873.mdl",
		["Description"] = "Winchester_d",
		["Weight"] = 5.32,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_winchester") if drop then ply:StripWeapon("weapon_zw_winchester")end  return drop end,
	},

	["weapon_zw_perrin"] = {
		["Name"] = "PerrinP64",
		["Cost"] = 8500,
		["Model"] = "models/weapons/w_pp19_bizon.mdl",
		["Description"] = "PerrinP64_d",
		["Weight"] = 3.72,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_perrin") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_perrin") if drop then ply:StripWeapon("weapon_zw_perrin")end  return drop end,
	},

	["weapon_zw_dammerung"] = {
		["Name"] = "Dammerung",
		["Cost"] = 12200,
		["Model"] = "models/weapons/w_usas_12.mdl",
		["Description"] = "Dammerung_d",
		["Weight"] = 6.72,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dammerung") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dammerung") if drop then ply:StripWeapon("weapon_zw_dammerung")end  return drop end,
	},

	["weapon_zw_rpg"] = {
		["Name"] = "RPGLauncher",
		["Cost"] = 60000,
		["Model"] = "models/weapons/w_rocket_launcher.mdl",
		["Description"] = "RPGLauncher_d",
		["Weight"] = 7.2,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rpg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rpg") if drop then ply:StripWeapon("weapon_zw_rpg")end  return drop end,
	},


	["weapon_zw_fuckinator"] = {
		["Name"] = "TheFuckinator",
		["Cost"] = 35000,
		["Model"] = "models/weapons/w_pist_p228.mdl",
		["Description"] = "TheFuckinator_d",
		["Weight"] = 8.74, --i absolutely have no idea about this one except increasing its' size again
		["Supply"] = -1,
		["Rarity"] = 7,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fuckinator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fuckinator") if drop then ply:StripWeapon("weapon_zw_fuckinator")end  return drop end,
	},

	["weapon_zw_germanator"] = {
		["Name"] = "TheGermanator",
		["Cost"] = 6800,
		["Model"] = "models/weapons/w_mp40smg.mdl",
		["Description"] = "TheGermanator_d",
		["Weight"] = 3.34,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_germanator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_germanator") if drop then ply:StripWeapon("weapon_zw_germanator")end  return drop end,
	},

	["weapon_zw_807"] = {
		["Name"] = "RM807",
		["Cost"] = 5800,
		["Model"] = "models/weapons/w_remington_870_tact.mdl",
		["Description"] = "RM807_d",
		["Weight"] = 3.82,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_807") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_807") if drop then ply:StripWeapon("weapon_zw_807")end  return drop end,
	},

	["weapon_mad_crowbar"] = {
		["Name"] = "MADCrowbar",
		["Cost"] = 150000,
		["Model"] = "models/weapons/w_crowbar.mdl",
		["Description"] = "MADCrowbar_d",
		["Weight"] = 6.17,
		["Supply"] = -1,
		["Rarity"] = 9,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_mad_crowbar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_mad_crowbar") if drop then ply:StripWeapon("weapon_mad_crowbar")end  return drop end,
	},


-- some ammunition


	["item_pistolammo"] = {
		["Name"] = "PistolAmmo",
		["Cost"] = 45,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		["Description"] = "PistolAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end,
	},

	["item_m9k_smgammo"] = {
		["Name"] = "M9kSMGAmmo",
		["Cost"] = 70,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		["Description"] = "M9kSMGAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "SMG1") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_smgammo") return drop end,
	},

	["item_m9k_assaultammo"] = {
		["Name"] = "M9kAssaultRifleAmmo",
		["Cost"] = 95,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		["Description"] = "M9kAssaultRifleAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "AR2") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_assaultammo") return drop end,
	},

	["item_m9k_sniperammo"] = {
		["Name"] = "M9kSniperRifleAmmo",
		["Cost"] = 150,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		["Description"] = "M9kSniperRifleAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "SniperPenetratedRound") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_sniperammo") return drop end,
	},

	["item_magammo"] = {
		["Name"] = "MagnumAmmo",
		["Cost"] = 60,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_357_jhp.mdl",
		["Description"] = "MagnumAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_magammo") return drop end,
	},

	["item_buckshotammo"] = {
		["Name"] = "BuckshotAmmo",
		["Cost"] = 65,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		["Description"] = "BuckshotAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_buckshotammo") return drop end,
	},

	["item_rifleammo"] = {
		["Name"] = "RifleAmmo",
		["Cost"] = 90,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		["Description"] = "RifleAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rifleammo") return drop end,
	},

	["item_sniperammo"] = {
		["Name"] = "SniperAmmo",
		["Cost"] = 130,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		["Description"] = "SniperAmmo_d",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end,
	},

	["item_crossbowbolt"] = {
		["Name"] = "SteelBolts",
		["Cost"] = 40,
		["Model"] = "models/Items/CrossbowRounds.mdl",
		["Description"] = "SteelBolts_d",
		["Weight"] = 0.3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 6, "XBowBolt") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt") return drop end,
	},

	["item_crossbowbolt_crate"] = {
		["Name"] = "SteelBoltsCrate",
		["Cost"] = 150,
		["Model"] = "models/Items/item_item_crate.mdl",
		["Description"] = "SteelBoltsCrate_d",
		["Weight"] = 1.5,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "XBowBolt") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt_crate") return drop end,
	},

	["item_rocketammo"] = {
		["Name"] = "RPGRound",
		["Cost"] = 180,
		["Model"] = "models/weapons/w_missile_closed.mdl",
		["Description"] = "RPGRound_d",
		["Weight"] = 2.14,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rocketammo") return drop end,
	},


-- Weapons not included in AtE


    ["weapon_zw_falcon"] = {
		["Name"] = "WarrenFalcon45",
		["Cost"] = 2300,
		["Model"] = "models/weapons/s_dmgf_co1911.mdl",
		["Description"] = "WarrenFalcon45_d",
		["Weight"] = 1.4,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_falcon") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_falcon") if drop then ply:StripWeapon("weapon_zw_falcon") end return drop end,
	},

    ["weapon_zw_spas"] = {
		["Name"] = "SPAS12Shorty",
		["Cost"] = 8000,
		["Model"] = "models/weapons/w_shotgun.mdl",
		["Description"] = "SPAS12Shorty_d",
		["Weight"] = 3.6,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_spas") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_spas") if drop then ply:StripWeapon("weapon_zw_spas") end return drop end,
	},

    ["weapon_zw_lbr"] = {
		["Name"] = "WarrenLBR",
		["Cost"] = 15500,
		["Model"] = "models/weapons/w_snip_m14sp.mdl",
		["Description"] = "WarrenLBR_d",
		["Weight"] = 3.8,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_lbr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_lbr") if drop then ply:StripWeapon("weapon_zw_lbr") end return drop end,
	},


-- Other special weapons

	-- don't use this one, the weapon is literally non-existant
    ["weapon_zw_plasmalauncher"] = {
		["Name"] = "PlasmaLauncher",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_physics.mdl",
		["Description"] = "PlasmaLauncher_d",
		["Weight"] = 20,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_plasmalauncher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_plasmalauncher") if drop then ply:StripWeapon("weapon_zw_plasmalauncher")end  return drop end,
	},

    ["weapon_zw_minigun"] = {
		["Name"] = "GAU8CChaingun",
		["Cost"] = 45000,
		["Model"] = "models/weapons/w_m134_minigun.mdl",
		["Description"] = "GAU8CChaingun_d",
		["Weight"] = 16.62,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_minigun") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_minigun") if drop then ply:StripWeapon("weapon_zw_minigun")end  return drop end,
	},

    ["weapon_zw_grenade_pipe"] = {
		["Name"] = "PipeBomb",
		["Cost"] = 120,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "PipeBomb_d",
		["Weight"] = 0.34,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_pipe", "nade_pipebombs") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_pipe") if drop then ply:StripWeapon("weapon_zw_grenade_pipe")end  return drop end,
		["IsGrenade"] = true
	},

    ["weapon_zw_grenade_flare"] = {
		["Name"] = "DistressFlare",
		["Cost"] = 65,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "DistressFlare_d",
		["Weight"] = 0.4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_flare", "nade_flares") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_flare") if drop then ply:StripWeapon("weapon_zw_grenade_flare")end  return drop end,
		["IsGrenade"] = true
	},

    ["weapon_zw_grenade_frag"] = {
		["Name"] = "FragGrenade",
		["Cost"] = 375,
		["Model"] = "models/weapons/w_eq_fraggrenade.mdl",
		["Description"] = "FragGrenade_d",
		["Weight"] = 0.63,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_frag", "Grenade") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_frag") if drop then ply:StripWeapon("weapon_zw_grenade_frag")end  return drop end,
		["IsGrenade"] = true
	},

    ["weapon_zw_grenade_molotov"] = {
		["Name"] = "MolotovCocktail",
		["Cost"] = 400,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "MolotovCocktail_d",
		["Weight"] = 0.35,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_molotov", "nade_molotov") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_molotov") if drop then ply:StripWeapon("weapon_zw_grenade_molotov")end  return drop end,
		["IsGrenade"] = true
	},


-- M9k guns
-- decreasing their cost because they're too expensive

    ["m9k_coltpython"] = {
		["Name"] = "M9KColtPython",
		["Cost"] = 3800,
		["Model"] = "models/weapons/w_colt_python.mdl",
		["Description"] = "M9KColtPython_d",
		["Weight"] = 1.36,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_coltpython") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_coltpython") if drop then ply:StripWeapon("m9k_coltpython")end  return drop end,
	},

    ["m9k_glock"] = {
		["Name"] = "M9kGlock18",
		["Cost"] = 8000,
		["Model"] = "models/weapons/w_dmg_glock.mdl",
		["Description"] = "M9kGlock18_d",
		["Weight"] = 1.56,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_glock") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_glock") if drop then ply:StripWeapon("m9k_glock")end  return drop end,
	},

    ["m9k_hk45"] = {
		["Name"] = "M9kHK45C",
		["Cost"] = 3450,
		["Model"] = "models/weapons/w_hk45c.mdl",
		["Description"] = "M9kHK45C_d",
		["Weight"] = 0.96,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_hk45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_hk45") if drop then ply:StripWeapon("m9k_hk45") end return drop end,
	},

    ["m9k_m92beretta"] = {
		["Name"] = "M9kBerettaM92",
		["Cost"] = 3350,
		["Model"] = "models/weapons/w_beretta_m92.mdl",
		["Description"] = "M9kBerettaM92_d",
		["Weight"] = 1.16,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m92beretta") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m92beretta") if drop then ply:StripWeapon("m9k_m92beretta") end return drop end,
	},

    ["m9k_luger"] = {
		["Name"] = "M9kP08Luger",
		["Cost"] = 3500,
		["Model"] = "models/weapons/w_luger_p08.mdl",
		["Description"] = "M9kP08Luger_d",
		["Weight"] = 1.09,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_luger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_luger") if drop then ply:StripWeapon("m9k_luger")end  return drop end,
	},

    ["m9k_ragingbull"] = {
		["Name"] = "M9kRagingBull",
		["Cost"] = 5125,
		["Model"] = "models/weapons/w_taurus_raging_bull.mdl",
		["Description"] = "M9kRagingBull_d",
		["Weight"] = 2.16,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ragingbull") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ragingbull") if drop then ply:StripWeapon("m9k_ragingbull")end  return drop end,
	},

    ["m9k_scoped_taurus"] = {
		["Name"] = "M9kScopedTaurus",
		["Cost"] = 7000,
		["Model"] = "models/weapons/w_raging_bull_scoped.mdl",
		["Description"] = "M9kScopedTaurus_d",
		["Weight"] = 2.56,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_scoped_taurus") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_scoped_taurus") if drop then ply:StripWeapon("m9k_scoped_taurus")end  return drop end,
	},

    ["m9k_remington1858"] = {
		["Name"] = "M9kRemington1858",
		["Cost"] = 4875,
		["Model"] = "models/weapons/w_remington_1858.mdl",
		["Description"] = "M9kRemington1858_d",
		["Weight"] = 1.46,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_remington1858") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington1858") if drop then ply:StripWeapon("m9k_remington1858")end  return drop end,
	},

    ["m9k_model3russian"] = {
		["Name"] = "M9kSWModel3Russian",
		["Cost"] = 4950,
		["Model"] = "models/weapons/w_model_3_rus.mdl",
		["Description"] = "M9kSWModel3Russian_d",
		["Weight"] = 1.38,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model3russian") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model3russian") if drop then ply:StripWeapon("m9k_model3russian")end  return drop end,
	},

    ["m9k_model500"] = {
		["Name"] = "M9kSWModel500",
		["Cost"] = 5950,
		["Model"] = "models/weapons/w_sw_model_500.mdl",
		["Description"] = "M9kSWModel500_d",
		["Weight"] = 1.86,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model500") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model500") if drop then ply:StripWeapon("m9k_model500")end  return drop end,
	},

    ["m9k_model627"] = {
		["Name"] = "M9kSWModel627",
		["Cost"] = 6100,
		["Model"] = "models/weapons/w_sw_model_627.mdl",
		["Description"] = "M9kSWModel627_d",
		["Weight"] = 1.46,
		["Supply"] = 1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model627") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model627") if drop then ply:StripWeapon("m9k_model627")end  return drop end,
	},

    ["m9k_sig_p229r"] = {
		["Name"] = "M9kSigSauerP229R",
		["Cost"] = 4700,
		["Model"] = "models/weapons/w_sig_229r.mdl",
		["Description"] = "M9kSigSauerP229R_d",
		["Weight"] = 1.31,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_sig_p229r") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sig_p229r") if drop then ply:StripWeapon("m9k_sig_p229r")end  return drop end,
	},
	
    ["m9k_acr"] = {
		["Name"] = "M9kACR",
		["Cost"] = 28500,
		["Model"] = "models/weapons/w_masada_acr.mdl",
		["Description"] = "M9kACR_d",
		["Weight"] = 4.2,
		["Supply"] = 0,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_acr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_acr") if drop then ply:StripWeapon("m9k_acr")end  return drop end,
	},
	
    ["m9k_ak47"] = {
		["Name"] = "M9kAK47",
		["Cost"] = 24500,
		["Model"] = "models/weapons/w_ak47_m9k.mdl",
		["Description"] = "M9kAK47_d",
		["Weight"] = 3.8,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ak47") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak47") if drop then ply:StripWeapon("m9k_ak47")end  return drop end,
	},
	
    ["m9k_ak74"] = {
		["Name"] = "M9kAK74",
		["Cost"] = 24750,
		["Model"] = "models/weapons/w_tct_ak47.mdl",
		["Description"] = "M9kAK74_d",
		["Weight"] = 3.66,
		["Supply"] = 0,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ak74") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak74") if drop then ply:StripWeapon("m9k_ak74")end  return drop end,
	},
	
	--rest of m9k guns not included because they are still... unfinished (and i'm running out of ideas what to do next)

    ["m9k_amd65"] = {
		["Name"] = "M9kAMD65",
		["Cost"] = 28750,
		["Model"] = "models/weapons/w_amd_65.mdl",
		["Description"] = "M9kAMD65_d",
		["Weight"] = 3.9,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_amd65") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_amd65") if drop then ply:StripWeapon("m9k_amd65") end return drop end,
	},
	
    ["m9k_an94"] = {
		["Name"] = "M9kAN94",
		["Cost"] = 35000,
		["Model"] = "models/weapons/w_rif_an_94.mdl",
		["Description"] = "M9kAN94_d",
		["Weight"] = 4.4,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_an94") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_an94") if drop then ply:StripWeapon("m9k_an94") end return drop end,
	},

    ["m9k_val"] = {
		["Name"] = "M9kASVal",
		["Cost"] = 33000,
		["Model"] = "models/weapons/w_dmg_vally.mdl",
		["Description"] = "M9kASVal_d",
		["Weight"] = 2.8,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_val") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_val") if drop then ply:StripWeapon("m9k_val") end return drop end,
	},

    ["m9k_f2000"] = {
		["Name"] = "M9kF2000",
		["Cost"] = 40000,
		["Model"] = "models/weapons/w_fn_f2000.mdl",
		["Description"] = "M9kF2000_d",
		["Weight"] = 5.24,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_f2000") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_f2000") if drop then ply:StripWeapon("m9k_f2000")end  return drop end,
	},

    ["m9k_fal"] = {
		["Name"] = "M9kFNFal",
		["Cost"] = 31500,
		["Model"] = "models/weapons/w_fn_fal.mdl",
		["Description"] = "M9kFNFal_d",
		["Weight"] = 5.9,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_fal") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fal") if drop then ply:StripWeapon("m9k_fal")end  return drop end,
	},

    ["m9k_g36"] = {
		["Name"] = "M9kG36",
		["Cost"] = 36500,
		["Model"] = "models/weapons/w_hk_g36c.mdl",
		["Description"] = "M9kG36_d",
		["Weight"] = 3.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_g36") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g36") if drop then ply:StripWeapon("m9k_g36")end  return drop end,
	},

    ["m9k_m416"] = {
		["Name"] = "M9kHK416",
		["Cost"] = 34000,
		["Model"] = "models/weapons/w_hk_416.mdl",
		["Description"] = "M9kHK416_d",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m416") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m416") if drop then ply:StripWeapon("m9k_m416")end  return drop end,
	},

    ["m9k_g3a3"] = {
		["Name"] = "M9kHKG3A3",
		["Cost"] = 38500,
		["Model"] = "models/weapons/w_hk_g3.mdl",
		["Description"] = "M9kHKG3A3_d",
		["Weight"] = 5.8,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_g3a3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g3a3") if drop then ply:StripWeapon("m9k_g3a3")end  return drop end,
	},

    ["m9k_l85"] = {
		["Name"] = "M9kL85",
		["Cost"] = 42000,
		["Model"] = "models/weapons/w_l85a2.mdl",
		["Description"] = "M9kL85_d",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_l85") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_l85") if drop then ply:StripWeapon("m9k_l85")end  return drop end,
	},

    ["m9k_m16a4_acog"] = {
		["Name"] = "M9kM16A4ACOG",
		["Cost"] = 43000,
		["Model"] = "models/weapons/w_dmg_m16ag.mdl",
		["Description"] = "M9kM16A4ACOG_d",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m16a4_acog") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m16a4_acog") if drop then ply:StripWeapon("m9k_m16a4_acog")end  return drop end,
	},

    ["m9k_vikhr"] = {
		["Name"] = "M9kSR3MVikhr",
		["Cost"] = 26000,
		["Model"] = "models/weapons/w_dmg_vikhr.mdl",
		["Description"] = "M9kSR3MVikhr_d",
		["Weight"] = 3.68,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_vikhr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vikhr") if drop then ply:StripWeapon("m9k_vikhr")end  return drop end,
	},

    ["m9k_auga3"] = {
		["Name"] = "M9kSteyrAUGA3",
		["Cost"] = 33500,
		["Model"] = "models/weapons/w_auga3.mdl",
		["Description"] = "M9kSteyrAUGA3_d",
		["Weight"] = 4.18,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_auga3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_auga3") if drop then ply:StripWeapon("m9k_auga3")end  return drop end,
	},

    ["m9k_tar21"] = {
		["Name"] = "M9kTAR21",
		["Cost"] = 32000,
		["Model"] = "models/weapons/w_imi_tar21.mdl",
		["Description"] = "M9kTAR21_d",
		["Weight"] = 3.35,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_tar21") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tar21") if drop then ply:StripWeapon("m9k_tar21")end  return drop end,
	},

    ["m9k_ares_shrike"] = {
		["Name"] = "M9kAresShrike",
		["Cost"] = 101250,
		["Model"] = "models/weapons/w_ares_shrike.mdl",
		["Description"] = "M9kAresShrike_d",
		["Weight"] = 9.85,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ares_shrike") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ares_shrike") if drop then ply:StripWeapon("m9k_ares_shrike")end  return drop end,
	},

    ["m9k_fg42"] = {
		["Name"] = "M9kFG42",
		["Cost"] = 62000,
		["Model"] = "models/weapons/w_fg42.mdl",
		["Description"] = "M9kFG42_d",
		["Weight"] = 5.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_fg42") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fg42") if drop then ply:StripWeapon("m9k_fg42")end  return drop end,
	},

    ["m9k_m1918bar"] = {
		["Name"] = "M9kM1918Bar",
		["Cost"] = 65000,
		["Model"] = "models/weapons/w_m1918_bar.mdl",
		["Description"] = "M9kM1918Bar_d",
		["Weight"] = 5.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m1918bar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m1918bar") if drop then ply:StripWeapon("m9k_m1918bar")end  return drop end,
	},

    ["m9k_m60"] = {
		["Name"] = "M9kM60",
		["Cost"] = 115000,
		["Model"] = "models/weapons/w_m60_machine_gun.mdl",
		["Description"] = "M9kM60_d",
		["Weight"] = 9.8,
		["Supply"] = 1,
		["Rarity"] = 8,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m60") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m60") if drop then ply:StripWeapon("m9k_m60")end  return drop end,
	},

    ["m9k_pkm"] = {
		["Name"] = "M9kPKM",
		["Cost"] = 97500,
		["Model"] = "models/weapons/w_mach_russ_pkm.mdl",
		["Description"] = "M9kPKM_d",
		["Weight"] = 8.5,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_pkm") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_pkm") if drop then ply:StripWeapon("m9k_pkm") end return drop end,
	},

    ["m9k_m3"] = {
		["Name"] = "M9kBenneliM3",
		["Cost"] = 40000,
		["Model"] = "models/weapons/w_benelli_m3.mdl",
		["Description"] = "M9kBenneliM3_d",
		["Weight"] = 3.62,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m3") if drop then ply:StripWeapon("m9k_m3")end  return drop end,
	},

    ["m9k_browningauto5"] = {
		["Name"] = "M9kBrowningAuto5",
		["Cost"] = 47500,
		["Model"] = "models/weapons/w_browning_auto.mdl",
		["Description"] = "M9kBrowningAuto5_d",
		["Weight"] = 4.4,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_browningauto5") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_browningauto5") if drop then ply:StripWeapon("m9k_browningauto5")end  return drop end,
	},

    ["m9k_ithacam37"] = {
		["Name"] = "M9kIthacaM37",
		["Cost"] = 44000,
		["Model"] = "models/weapons/w_ithaca_m37.mdl",
		["Description"] = "M9kIthacaM37_d",
		["Weight"] = 3.45,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ithacam37") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ithacam37") if drop then ply:StripWeapon("m9k_ithacam37")end  return drop end,
	},

    ["m9k_mossberg590"] = {
		["Name"] = "M9kMossberg590",
		["Cost"] = 42500,
		["Model"] = "models/weapons/w_mossberg_590.mdl",
		["Description"] = "M9kMossberg590_d",
		["Weight"] = 3.69,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mossberg590") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mossberg590") if drop then ply:StripWeapon("m9k_mossberg590")end  return drop end,
	},

    ["m9k_jackhammer"] = {
		["Name"] = "M9kPancorJackhammer",
		["Cost"] = 55000,
		["Model"] = "models/weapons/w_pancor_jackhammer.mdl",
		["Description"] = "M9kPancorJackhammer_d",
		["Weight"] = 4.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_jackhammer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_jackhammer") if drop then ply:StripWeapon("m9k_jackhammer")end  return drop end,
	},

    ["m9k_spas12"] = {
		["Name"] = "M9kSPAS12",
		["Cost"] = 60000,
		["Model"] = "models/weapons/w_spas_12.mdl",
		["Description"] = "M9kSPAS12_d",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_spas12") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_spas12") if drop then ply:StripWeapon("m9k_spas12")end  return drop end,
	},

    ["m9k_striker12"] = {
		["Name"] = "M9kStriker12",
		["Cost"] = 57500,
		["Model"] = "models/weapons/w_striker_12g.mdl",
		["Description"] = "M9kStriker12_d",
		["Weight"] = 3.66,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_striker12") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_striker12") if drop then ply:StripWeapon("m9k_striker12")end  return drop end,
	},

    ["m9k_1897winchester"] = {
		["Name"] = "M9kWinchester1897",
		["Cost"] = 41000,
		["Model"] = "models/weapons/w_winchester_1897_trench.mdl",
		["Description"] = "M9kWinchester1897_d",
		["Weight"] = 3.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_1897winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1897winchester") if drop then ply:StripWeapon("m9k_1897winchester")end  return drop end,
	},

    ["m9k_1887winchester"] = {
		["Name"] = "M9kWinchester87",
		["Cost"] = 39500,
		["Model"] = "models/weapons/w_winchester_1887.mdl",
		["Description"] = "M9kWinchester87_d",
		["Weight"] = 3.12,
		["Supply"] = 1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_1887winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1887winchester") if drop then ply:StripWeapon("m9k_1887winchester")end  return drop end,
	},

    ["m9k_barret_m82"] = {
		["Name"] = "M9kBarretM82",
		["Cost"] = 105000,
		["Model"] = "models/weapons/w_barret_m82.mdl",
		["Description"] = "M9kBarretM82_d",
		["Weight"] = 11.85,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_barret_m82") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_barret_m82") if drop then ply:StripWeapon("m9k_barret_m82") end return drop end,
	},

    ["m9k_m98b"] = {
		["Name"] = "M9kBarretM98B",
		["Cost"] = 80000,
		["Model"] = "models/weapons/w_barrett_m98b.mdl",
		["Description"] = "M9kBarretM98B_d",
		["Weight"] = 10.95,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m98b") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m98b") if drop then ply:StripWeapon("m9k_m98b")end  return drop end,
	},

    ["m9k_svu"] = {
		["Name"] = "M9kDragunovSVU",
		["Cost"] = 81500,
		["Model"] = "models/weapons/w_dragunov_svu.mdl",
		["Description"] = "M9kDragunovSVU_d",
		["Weight"] = 5.44,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_svu") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svu") if drop then ply:StripWeapon("m9k_svu")end  return drop end,
	},

    ["m9k_sl8"] = {
		["Name"] = "M9kSL8",
		["Cost"] = 57500,
		["Model"] = "models/weapons/w_snip_int.mdl",
		["Description"] = "M9kSL8_d",
		["Weight"] = 4.92,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_sl8") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sl8") if drop then ply:StripWeapon("m9k_sl8") end return drop end,
	},

    ["m9k_intervention"] = {
		["Name"] = "M9kIntervention",
		["Cost"] = 55000,
		["Model"] = "models/weapons/w_snip_int.mdl",
		["Description"] = "M9kIntervention_d",
		["Weight"] = 8.46,
		["Supply"] = 0,
		["Rarity"] = 7,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_intervention") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_intervention") if drop then ply:StripWeapon("m9k_intervention") end return drop end,
	},

    ["m9k_m24"] = {
		["Name"] = "M9kM24",
		["Cost"] = 69000,
		["Model"] = "models/weapons/w_snip_m24_6.mdl",
		["Description"] = "M9kM24_d",
		["Weight"] = 7.98,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m24") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m24") if drop then ply:StripWeapon("m9k_m24")end  return drop end,
	},

    ["m9k_psg1"] = {
		["Name"] = "M9kPSG1",
		["Cost"] = 73500,
		["Model"] = "models/weapons/w_hk_psg1.mdl",
		["Description"] = "M9kPSG1_d",
		["Weight"] = 8.28,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_psg1") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_psg1") if drop then ply:StripWeapon("m9k_psg1") end return drop end,
	},

    ["m9k_remington7615p"] = {
		["Name"] = "M9kRemington7615P",
		["Cost"] = 18000,
		["Model"] = "models/weapons/w_remington_7615p.mdl",
		["Description"] = "M9kRemington7615P_d",
		["Weight"] = 5.65,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_remington7615p") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington7615p") if drop then ply:StripWeapon("m9k_remington7615p") end return drop end,
	},

    ["m9k_svt40"] = {
		["Name"] = "M9kSVT40",
		["Cost"] = 63000,
		["Model"] = "models/weapons/w_svt_40.mdl",
		["Description"] = "M9kSVT40_d",
		["Weight"] = 5.48,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_svt40") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svt40") if drop then ply:StripWeapon("m9k_svt40")end  return drop end,
	},

    ["m9k_contender"] = {
		["Name"] = "M9kThompsonContenderG2",
		["Cost"] = 45000,
		["Model"] = "models/weapons/w_g2_contender.mdl",
		["Description"] = "M9kThompsonContenderG2_d",
		["Weight"] = 4.18,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_contender") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_contender") if drop then ply:StripWeapon("m9k_contender")end  return drop end,
	},

    ["m9k_honeybadger"] = {
		["Name"] = "M9kAACHoneyBadger",
		["Cost"] = 51500,
		["Model"] = "models/weapons/w_aac_honeybadger.mdl",
		["Description"] = "M9kAACHoneyBadger_d",
		["Weight"] = 4.44,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_honeybadger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_honeybadger") if drop then ply:StripWeapon("m9k_honeybadger")end  return drop end,
	},

    ["m9k_mp5"] = {
		["Name"] = "M9kHKMP5",
		["Cost"] = 26500,
		["Model"] = "models/weapons/w_hk_mp5.mdl",
		["Description"] = "M9kHKMP5_d",
		["Weight"] = 3.15,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp5") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5") if drop then ply:StripWeapon("m9k_mp5")end  return drop end,
	},

    ["m9k_mp7"] = {
		["Name"] = "M9kHKMP7",
		["Cost"] = 29250,
		["Model"] = "models/weapons/w_mp7_silenced.mdl",
		["Description"] = "M9kHKMP7_d",
		["Weight"] = 3.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp7") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp7") if drop then ply:StripWeapon("m9k_mp7")end  return drop end,
	},

    ["m9k_ump45"] = {
		["Name"] = "M9kHKUMP45",
		["Cost"] = 24000,
		["Model"] = "models/weapons/w_hk_ump45.mdl",
		["Description"] = "M9kHKUMP45_d",
		["Weight"] = 2.95,
		["Supply"] = 1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ump45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ump45") if drop then ply:StripWeapon("m9k_ump45")end  return drop end,
	},

    ["m9k_kac_pdw"] = {
		["Name"] = "M9kKACPDW",
		["Cost"] = 26750,
		["Model"] = "models/weapons/w_kac_pdw.mdl",
		["Description"] = "M9kKACPDW_d",
		["Weight"] = 3.12,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_kac_pdw") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_kac_pdw") if drop then ply:StripWeapon("m9k_kac_pdw")end  return drop end,
	},

    ["m9k_vector"] = {
		["Name"] = "M9kKRISSVector",
		["Cost"] = 34650,
		["Model"] = "models/weapons/w_kriss_vector.mdl",
		["Description"] = "M9kKRISSVector_d",
		["Weight"] = 3.1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_vector") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vector") if drop then ply:StripWeapon("m9k_vector")end  return drop end,
	},

    ["m9k_magpulpdr"] = {
		["Name"] = "M9kMagpulPDR",
		["Cost"] = 29000,
		["Model"] = "models/weapons/w_magpul_pdr.mdl",
		["Description"] = "M9kMagpulPDR_d",
		["Weight"] = 3.16,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_magpulpdr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_magpulpdr") if drop then ply:StripWeapon("m9k_magpulpdr")end  return drop end,
	},

    ["m9k_mp5sd"] = {
		["Name"] = "M9kMP5SD",
		["Cost"] = 28000,
		["Model"] = "models/weapons/w_hk_mp5sd.mdl",
		["Description"] = "M9kMP5SD_d",
		["Weight"] = 2.85,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp5sd") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5sd") if drop then ply:StripWeapon("m9k_mp5sd")end  return drop end,
	},

    ["m9k_mp9"] = {
		["Name"] = "M9kMP9",
		["Cost"] = 28500,
		["Model"] = "models/weapons/w_brugger_thomet_mp9.mdl",
		["Description"] = "M9kMP9_d",
		["Weight"] = 2.68,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp9") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp9") if drop then ply:StripWeapon("m9k_mp9")end  return drop end,
	},

    ["m9k_tec9"] = {
		["Name"] = "M9kTEC9",
		["Cost"] = 20500,
		["Model"] = "models/weapons/w_intratec_tec9.mdl",
		["Description"] = "M9kTEC9_d",
		["Weight"] = 2.38,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_tec9") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tec9") if drop then ply:StripWeapon("m9k_tec9")end  return drop end,
	},

    ["m9k_thompson"] = {
		["Name"] = "M9kTommyGun",
		["Cost"] = 26000,
		["Model"] = "models/weapons/w_tommy_gun.mdl",
		["Description"] = "M9kTommyGun_d",
		["Weight"] = 3.84,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_thompson") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_thompson") if drop then ply:StripWeapon("m9k_thompson")end  return drop end,
	},

    ["m9k_uzi"] = {
		["Name"] = "M9kUZI",
		["Cost"] = 22000,
		["Model"] = "models/weapons/w_uzi_imi.mdl",
		["Description"] = "M9kUZI_d",
		["Weight"] = 2.95,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_uzi") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_uzi") if drop then ply:StripWeapon("m9k_uzi")end  return drop end,
	},



	["item_armor_jacket_leather"] = {
		["Name"] = "LeatherJacket",
		["Cost"] = 5000,
		["Model"] = "models/player/group03/male_07.mdl",
		["Description"] = "LeatherJacket_d",
		["Weight"] = 1.1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_leather") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_leather") return drop end,

		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 5,		-- damage reduction in percentage
			["speedloss"] = 0,		-- speed loss in source units (default player sprint speed: 250 (320 with maxed speed stat))
			["slots"] = 1,			-- attachment slots (to be removed)
			["battery"] = 0,		-- battery capacity, suits with 0 battery will only be able to use passive attachments (may be reworked, with flashlight)
			["carryweight"] = 0,	-- additional max carryweight when user wears the armor
			["allowmodels"] = nil	-- force the player to be one of these models, nil to let them choose from the default citizen models
		}
	},

	["item_armor_chainmail"] = {
		["Name"] = "ChainmailSuit",
		["Cost"] = 8500,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "ChainmailSuit_d",
		["Weight"] = 1.6,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_chainmail") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chainmail") return drop end,

		["ArmorStats"] = {
			["reduction"] = 7.5,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_jacket_bandit"] = {
		["Name"] = "BanditJacket",
		["Cost"] = 10000,
		["Model"] = "models/player/stalker/bandit_backpack.mdl",
		["Description"] = "BanditJacket_d",
		["Weight"] = 1.4,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_bandit") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_bandit") return drop end,
		["ArmorStats"] = {
			["reduction"] = 8,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_backpack.mdl"}
		}
	},

	["item_armor_scrap"] = {
		["Name"] = "ScrapArmor",
		["Cost"] = 12500,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "ScrapArmor_d",
		["Weight"] = 3.8,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
		["ArmorStats"] = {
			["reduction"] = 12.5,
			["speedloss"] = 35,
			["slots"] = 2,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_trenchcoat_brown"] = {
		["Name"] = "BrownTrenchcoatArmor",
		["Cost"] = 15000,
		["Model"] = "models/player/stalker/bandit_brown.mdl",
		["Description"] = "BrownTrenchcoatArmor_d",
		["Weight"] = 2.28,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_brown") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_brown") return drop end,
		["ArmorStats"] = {
			["reduction"] = 10,
			["speedloss"] = 10,
			["slots"] = 2,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_brown.mdl"}
		}
	},

	["item_armor_trenchcoat_black"] = {
		["Name"] = "BlackTrenchcoatArmor",
		["Cost"] = 20000,
		["Model"] = "models/player/stalker/bandit_black.mdl",
		["Description"] = "BlackTrenchcoatArmor_d",
		["Weight"] = 2.9,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_black") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_black") return drop end,
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 17.5,
			["slots"] = 2,
			["battery"] = 0,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_black.mdl"}
		}
	},

	["item_armor_mercenary_guerilla"] = {
		["Name"] = "GuerillaMercArmor",
		["Cost"] = 25000,
		["Model"] = "models/player/guerilla.mdl",
		["Description"] = "GuerillaMercArmor_d",
		["Weight"] = 3.2,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_guerilla") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_guerilla") return drop end,
		["ArmorStats"] = {
			["reduction"] = 16.25,
			["speedloss"] = 25,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/guerilla.mdl"}
		}
	},

	["item_armor_mercernary_arctic"] = {
		["Name"] = "ArcticMercArmor",
		["Cost"] = 27500,
		["Model"] = "models/player/arctic.mdl",
		["Description"] = "ArcticMercArmor_d",
		["Weight"] = 3.35,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_arctic") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_arctic") return drop end,
		["ArmorStats"] = {
			["reduction"] = 16.25,
			["speedloss"] = 27.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/arctic.mdl"}
		}
	},

	["item_armor_mercenary_leet"] = {
		["Name"] = "LeetMercArmor",
		["Cost"] = 26000,
		["Model"] = "models/player/leet.mdl",
		["Description"] = "LeetMercArmor_d",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_leet") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_leet") return drop end,
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/leet.mdl"}
		}
	},

	["item_armor_mercenary_phoenix"] = {
		["Name"] = "PhoenixMercArmor",
		["Cost"] = 30000,
		["Model"] = "models/player/phoenix.mdl",
		["Description"] = "PhoenixMercArmor_d",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_phoenix") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_phoenix") return drop end,
		["ArmorStats"] = {
			["reduction"] = 20,
			["speedloss"] = 30,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/phoenix.mdl"}
		}
	},

	["item_armor_police_gasmask"] = {
		["Name"] = "PoliceGasmaskArmor",
		["Cost"] = 35000,
		["Model"] = "models/player/gasmask.mdl",
		["Description"] = "PoliceGasmaskArmor_d",
		["Weight"] = 5.5,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_gasmask") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_gasmask") return drop end,
		["ArmorStats"] = {
			["reduction"] = 22.5,
			["speedloss"] = 47.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/gasmask.mdl"}
		}
	},

	["item_armor_police_riot"] = {
		["Name"] = "PoliceRiotArmor",
		["Cost"] = 37000,
		["Model"] = "models/player/riot.mdl",
		["Description"] = "PoliceRiotArmor_d",
		["Weight"] = 5.8,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_riot") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_riot") return drop end,
		["ArmorStats"] = {
			["reduction"] = 25,
			["speedloss"] = 55,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/riot.mdl"}
		}
	},

	["item_armor_police_swat"] = {
		["Name"] = "PoliceSWATArmor",
		["Cost"] = 36000,
		["Model"] = "models/player/swat.mdl",
		["Description"] = "PoliceSWATArmor_d",
		["Weight"] = 5.8,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_swat") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_swat") return drop end,
		["ArmorStats"] = {
			["reduction"] = 23.75,
			["speedloss"] = 53.75,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/swat.mdl"}
		}
	},

	["item_armor_police_urban"] = {
		["Name"] = "PoliceUrbanArmor",
		["Cost"] = 40000,
		["Model"] = "models/player/urban.mdl",
		["Description"] = "PoliceUrbanArmor_d",
		["Weight"] = 6.5,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_urban") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_urban") return drop end,
		["ArmorStats"] = {
			["reduction"] = 27.5,
			["speedloss"] = 57.5,
			["slots"] = 2,
			["battery"] = 50,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/urban.mdl"}
		}
	},

	["item_armor_sunrise"] = {
		["Name"] = "SunriseArmor",
		["Cost"] = 55000,
		["Model"] = "models/player/stalker/loner_vet.mdl",
		["Description"] = "SunriseArmor_d",
		["Weight"] = 5.5,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise") return drop end,
		["ArmorStats"] = {
			["reduction"] = 30,
			["speedloss"] = 33.75,
			["slots"] = 3,
			["battery"] = 75,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/loner_vet.mdl"}
		}
	},

	["item_armor_sunrise_dolg"] = {
		["Name"] = "DolgArmor",
		["Cost"] = 80000,
		["Model"] = "models/player/stalker/duty_vet.mdl",
		["Description"] = "DolgArmor_d",
		["Weight"] = 7.1,
		["Supply"] = 0,
		["Rarity"] = 6,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_dolg") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_dolg") return drop end,
		["ArmorStats"] = {
			["reduction"] = 37.5,
			["speedloss"] = 42.5,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/duty_vet.mdl"}
		}
	},

	["item_armor_sunrise_svoboda"] = {
		["Name"] = "SvobodaArmor",
		["Cost"] = 60000,
		["Model"] = "models/player/stalker/freedom_vet.mdl",
		["Description"] = "SvobodaArmor_d",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 6,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_svoboda") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_svoboda") return drop end,
		["ArmorStats"] = {
			["reduction"] = 30,
			["speedloss"] = 27.5,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/freedom_vet.mdl"}
		}
	},

	["item_armor_sunrise_monolith"] = {
		["Name"] = "MonolithArmor",
		["Cost"] = 75000,
		["Model"] = "models/player/stalker/monolith_vet.mdl",
		["Description"] = "MonolithArmor_d",
		["Weight"] = 6,
		["Supply"] = 3,
		["Rarity"] = 6,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_monolith") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_monolith") return drop end,
		["ArmorStats"] = {
			["reduction"] = 35,
			["speedloss"] = 35,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/monolith_vet.mdl"}
		}
	},

	["item_armor_military_green"] = {
		["Name"] = "MilitaryGreenArmor",
		["Cost"] = 125000,
		["Model"] = "models/player/stalker/military_spetsnaz_green.mdl",
		["Description"] = "MilitaryGreenArmor_d",
		["Weight"] = 12,
		["Supply"] = 0,
		["Rarity"] = 6,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_green") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_green") return drop end,
		["ArmorStats"] = {
			["reduction"] = 42.5,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 100,
			["carryweight"] = 0,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_green.mdl"}
		}
	},

	["item_armor_military_black"] = {
		["Name"] = "MilitaryBlackArmor",
		["Cost"] = 150000,
		["Model"] = "models/player/stalker/military_spetsnaz_black.mdl",
		["Description"] = "MilitaryBlackArmor_d",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 7,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_black") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_black") return drop end,
		["ArmorStats"] = {
			["reduction"] = 47.5,
			["speedloss"] = 70,
			["slots"] = 2,
			["battery"] = 125,
			["carryweight"] = 5,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_black.mdl"}
		}
	},

	["item_armor_exo"] = {
		["Name"] = "ExoArmor",
		["Cost"] = 250000,
		["Model"] = "models/player/stalker/loner_exo.mdl",
		["Description"] = "ExoArmor_d",
		["Weight"] = 25,
		["Supply"] = 0,
		["Rarity"] = 7,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
		["ArmorStats"] = {
			["reduction"] = 60,
			["speedloss"] = 125,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/loner_exo.mdl"}
		}
	},

	["item_armor_exo_merc"] = {
		["Name"] = "MercExoArmor",
		["Cost"] = 225000,
		["Model"] = "models/player/stalker/merc_exo.mdl",
		["Description"] = "MercExoArmor_d",
		["Weight"] = 23.75,
		["Supply"] = 0,
		["Rarity"] = 8,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_merc") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_merc") return drop end,
		["ArmorStats"] = {
			["reduction"] = 57.5,
			["speedloss"] = 115,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/merc_exo.mdl"}
		}
	},

	["item_armor_exo_dolg"] = {
		["Name"] = "DolgExoArmor",
		["Cost"] = 275000,
		["Model"] = "models/player/stalker/duty_exo.mdl",
		["Description"] = "DolgExoArmor_d",
		["Weight"] = 27.5,
		["Supply"] = 0,
		["Rarity"] = 8,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg") return drop end,
		["ArmorStats"] = {
			["reduction"] = 65,
			["speedloss"] = 130,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/duty_exo.mdl"}
		}
	},

	["item_armor_exo_svoboda"] = {
		["Name"] = "SvobodaExoArmor",
		["Cost"] = 237500,
		["Model"] = "models/player/stalker/freedom_exo.mdl",
		["Description"] = "SvobodaExoArmor_d",
		["Weight"] = 22.5,
		["Supply"] = 0,
		["Rarity"] = 7,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_svoboda") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_svoboda") return drop end,
		["ArmorStats"] = {
			["reduction"] = 55,
			["speedloss"] = 110,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 25,
			["allowmodels"] = {"models/player/stalker/freedom_exo.mdl"}
		}
	},

	["item_armor_exo_monolith"] = {
		["Name"] = "MonolithExoArmor",
		["Cost"] = 262500,
		["Model"] = "models/player/stalker/monolith_exo.mdl",
		["Description"] = "MonolithExoArmor_d",
		["Weight"] = 25,
		["Supply"] = 0,
		["Rarity"] = 8,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_monolith") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_monolith") return drop end,
		["ArmorStats"] = {
			["reduction"] = 62.5,
			["speedloss"] = 125,
			["slots"] = 3,
			["battery"] = 100,
			["carryweight"] = 30,
			["allowmodels"] = {"models/player/stalker/monolith_exo.mdl"}
		}
	},

	["item_armor_cs2_goggles"] = {
		["Name"] = "CS2GogglesArmor",
		["Cost"] = 650000,
		["Model"] = "models/stalkertnb/cs2_goggles.mdl",
		["Description"] = "CS2GogglesArmor_d",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 9,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_cs2_goggles") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_cs2_goggles") return drop end,
		["ArmorStats"] = {
			["reduction"] = 40,
			["speedloss"] = -12.5,
			["slots"] = 3,
			["battery"] = 200,
			["carryweight"] = 5,
			["allowmodels"] = {"models/stalkertnb/cs2_goggles.mdl"}
		}
	},

}


function UseFunc_Sleep(ply, bheal)
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoSleepCooldownSleeping")) return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't sleep while using an item!") return false end
if ply.Fatigue <= 2000 then SendChat(ply, "You are not tired") return false end
if ply.Hunger <= 3000 then SendChat(ply, "You are hungry, you should eat something.") return false end
if ply.Thirst <= 3000 then SendChat(ply, "You are thirsty, you should drink something.") return false end
if ply.Infection >= 8000 then SendChat(ply, "You are greatly infected") return false end
SendChat(ply, "You are now asleep")
umsg.Start("DrawSleepOverlay", ply)
umsg.End()
ply.Fatigue = 0
ply:Freeze(true)
timer.Create("IsSleeping_"..ply:UniqueID(), 25, 1, function()
	ply:Freeze(false)
	timer.Destroy("IsSleeping_"..ply:UniqueID())
end)
if bheal then
ply:SetHealth(ply:GetMaxHealth())
end
end


function UseFunc_DropItem(ply, item)
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] then return false end
if !ply:Alive() then SendChat(ply, "no dropping items when dead") return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't drop an item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't drop an item while using one!") return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine(trace)
local EntDrop = ents.Create("ate_droppeditem")
EntDrop:SetPos(tr.HitPos)
EntDrop:SetAngles(Angle(0, 0, 0))
EntDrop:SetModel(ItemsList[item]["Model"])
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

return true end


function UseFunc_DropArmor(ply, item) -- same as drop item but we don't want to set the dropped item to a playermodel do we?
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] then return false end
if !ply:Alive() then SendChat(ply, "no dropping items when dead") return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't drop armor while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't drop armor while using an item!") return false end
if timer.Exists("Isplyequippingarmor"..ply:UniqueID().."_"..item) then SendChat(ply, "Can't drop armor while currently equipping one!") return false end
if !timer.Exists("Plywantstodropequippedarmor"..ply:UniqueID()) and ply:GetNWString("ArmorType") == item then
	SendChat(ply, "WARNING! You are about to drop an armor that you have it equipped, drop the same armor again within 10 seconds to confirm.")
	timer.Create("Plywantstodropequippedarmor"..ply:UniqueID(), 10, 1, function() end)
return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine(trace)
local EntDrop = ents.Create("ate_droppeditem")
EntDrop:SetPos(tr.HitPos)
EntDrop:SetAngles(Angle(0, 0, 0))
EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

if ply.EquippedArmor == tostring(item) then
UseFunc_RemoveArmor(ply, item)
end

return true end


function UseFunc_EquipArmor(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end
	if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't equip armor while sleeping!") return false end
	if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't equip armor while using an item!") return false end
	if timer.Exists("Isplyequippingarmor"..ply:UniqueID().."_"..item) then SendChat(ply, "Can't equip armor while equipping one now!") return false end

	local used = ItemsList[item]
	if !timer.Exists("plywantstoremovearmor"..ply:UniqueID().."_"..item) and ply.EquippedArmor == item then timer.Create("plywantstoremovearmor"..ply:UniqueID().."_"..item, 10, 1, function() end) SendChat(ply, "Unequip "..translate.ClientGet(ply, used["Name"]).."? Use the same armor again to confirm.") return false
	elseif timer.Exists("plywantstoremovearmor"..ply:UniqueID().."_"..item) and ply.EquippedArmor == item then
		SendUseDelay(ply, 3)
		ply:EmitSound("npc/combine_soldier/zipline_hitground2.wav")
		timer.Simple(3, function()
			if !ply:IsValid() or !ply:Alive() then return false end
			SystemMessage(ply, "You unequipped "..translate.ClientGet(ply, used["Name"])..".", Color(205,255,205,255), false)
			UseFunc_RemoveArmor(ply, item)
		end)
		return false
	end

	SendUseDelay(ply, 3)
	ply:EmitSound("npc/combine_soldier/zipline_hitground1.wav")

	timer.Create("Isplyequippingarmor"..ply:UniqueID(), 3, 1, function() end)
	timer.Create("Isplyequippingarmor"..ply:UniqueID().."_"..item, 3, 1, function()
		if !ply:IsValid() or !ply:Alive() then return false end
		SystemMessage(ply, "You equipped "..translate.ClientGet(ply, used["Name"])..". Use the same armor again to unequip.", Color(205,255,205,255), false)
		ply.EquippedArmor = tostring(item)
		ply:SetNWString("ArmorType", tostring(item))
		RecalcPlayerModel(ply)
		RecalcPlayerSpeed(ply)
	end)

	return false
end

function ForceEquipArmor(ply, item) --Same as Equip armor, but we don't want to have cooldown from moving nor make noise of equipping armor when spawning right?
	if !SERVER then return false end
	if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end
	
	local used = ItemsList[item]
	
	ply.EquippedArmor = tostring(item)
	ply:SetNWString("ArmorType", tostring(item))
	RecalcPlayerModel(ply)
	RecalcPlayerSpeed(ply)
	
	return false	
end

function UseFunc_RemoveArmor(ply, item)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	local used = ItemsList[item]

	ply.EquippedArmor = "none"
	ply:SetNWString("ArmorType", "none")
	RecalcPlayerModel(ply)
	RecalcPlayerSpeed(ply)

	return false
end

function UseFunc_DeployBed(ply, type)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't deploy bed while sleeping!") return false end
	if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local EntDrop = ents.Create("bed")
	EntDrop:SetPos(tr.HitPos)
	EntDrop:SetAngles(Angle(0, 0, 0))
	EntDrop:Spawn()
	EntDrop:Activate()
	EntDrop.Owner = ply

	for k, v in pairs(ents.FindByClass("bed")) do
		if v == EntDrop then continue end
		if !v.Owner:IsValid() or v.Owner == ply then v:Remove() end
	end
	return true
end


function UseFunc_EquipGun(ply, gun)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't equip a gun while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't equip a gun while using an item!") return false end
	if ply:GetActiveWeapon() != gun then
		ply:Give(gun)
		ply:SelectWeapon(gun)
	end
return false end

function UseFunc_EquipNade(ply, gun, nadetype)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't equip a grenade while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't equip a grenade while using an item!") return false end
ply:GiveAmmo(1, nadetype)
ply:Give(gun)

if ply:GetActiveWeapon() != gun then
	ply:SelectWeapon(gun)
end

return true end

function UseFunc_GiveAmmo(ply, amount, type)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end
	if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use ammo while sleeping!") return false end
	if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, "Can't use ammo while using an item!") return false end
	ply:GiveAmmo(amount, type)
return true end


function UseFunc_Heal(ply, usetime, hp, infection, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end
	if ply:Alive() then
			if ply:Health() >= ply:GetMaxHealth() and ply.Infection < 1 then SendChat(ply, "You are perfectly fine, using this would be wasteful at this time.") return false end
			ply:SetHealth(math.Clamp(ply:Health() + (hp * (1 + (ply.StatMedSkill * 0.025))), 0, ply:GetMaxHealth()))
			ply.Infection = math.Clamp(ply.Infection - (infection * 100), 0, 10000)
			ply:EmitSound(snd, 100, 100)
			SendUseDelay(ply, usetime)
			timer.Create("Isplyusingitem"..ply:UniqueID(), usetime, 1, function()
			timer.Destroy("Isplyusingitem"..ply:UniqueID())
			end)
			return true
	else
		SendChat(ply, "You could have healed yourself, before you died.") -- if they try to call this function when they are dead
		return false
	end
end

function UseFunc_HealInfection(ply, usetime, infection, snd)
	if !SERVER then return false end
	if !ply:IsValid() then return false end
	if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
	if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end
	if ply:Alive() then
			if ply.Infection < 1 then SendChat(ply, "You are feeling well, why would you use antidote now?") return false end
			ply.Infection = math.Clamp(ply.Infection - (infection * 100), 0, 10000)
			ply:EmitSound(snd, 100, 100)
			SendUseDelay(ply, usetime)
			timer.Create("Isplyusingitem"..ply:UniqueID(), usetime, 1, function()
			timer.Destroy("Isplyusingitem"..ply:UniqueID())
			end)
			return true
	else
		SendChat(ply, "You could have healed yourself, before you died.") -- if they try to call this function when they are dead
		return false
	end
end

function UseFunc_Armor(ply, usetime, armor, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end
	if ply:Alive() then
			if ply:Armor() >= ply:GetMaxArmor() then SendChat(ply, "Your armor is already at full condition.") return false end
			ply:SetArmor(math.Clamp(ply:Armor() + (armor * (1 + (ply.StatEngineer * 0.02))), 0, ply:GetMaxArmor()))
			ply:EmitSound(snd, 100, 100)
			SendUseDelay(ply, usetime)
			timer.Create("Isplyusingitem"..ply:UniqueID(), usetime, 1, function()
			timer.Destroy("Isplyusingitem"..ply:UniqueID())
			end)
			return true
	else
		SendChat(ply, "You could have charged your armor battery before you died!")
		return false
	end
end

function UseFunc_Eat(ply, usetime, health, hunger, thirst, stamina, fatigue, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end
	if ply:Alive() then
			if ply.Hunger > 9500 then SendChat(ply, "I am not hungry, I should save this for later.") return false end
			ply:SetHealth(math.Clamp(ply:Health() + health, 0, ply:GetMaxHealth()))
			ply.Hunger = math.Clamp(ply.Hunger + (hunger * 100), 0, 10000)
			ply.Thirst = math.Clamp(ply.Thirst + (thirst * 100), 0, 10000)
			ply.Stamina = math.Clamp(ply.Stamina + stamina, 0, 100)
			ply.Fatigue = math.Clamp(ply.Fatigue + (fatigue * 100), 0, 10000)
			ply:EmitSound(snd, 100, 100)
			SendUseDelay(ply, usetime)
			timer.Create("Isplyusingitem"..ply:UniqueID(), usetime, 1, function()
			timer.Destroy("Isplyusingitem"..ply:UniqueID())
			end)
			return true
	else
		SendChat(ply, "You don't have to eat when you're dead.") -- if they try to call this function when they are dead
		return false
	end
end

function UseFunc_Drink(ply, usetime, health, hunger, thirst, stamina, fatigue, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end
if ply:WaterLevel() == 3 then SendChat(ply, "It is impossible to drink when you are underwater. Get out of the water if you want to drink.") return false end
	if ply:Alive() then
			if !timer.Exists("plywantstouseitem"..ply:UniqueID()) and ply.Thirst > 9500 then timer.Create("plywantstouseitem"..ply:UniqueID(), 10, 1, function() timer.Destroy("plywantstouseitem"..ply:UniqueID()) end) SendChat(ply, "You are not thirsty, consider saving this for later. Use item again within 10 seconds to confirm usage.") return false end
			ply:SetHealth(math.Clamp(ply:Health() + health, 0, ply:GetMaxHealth()))
			ply.Hunger = math.Clamp(ply.Hunger + (hunger * 100), 0, 10000)
			ply.Thirst = math.Clamp(ply.Thirst + (thirst * 100), 0, 10000)
			ply.Stamina = math.Clamp(ply.Stamina + stamina, 0, 100)
			ply.Fatigue = math.Clamp(ply.Fatigue + (fatigue * 100), 0, 10000)
			ply:EmitSound(snd, 100, 100)
			SendUseDelay(ply, usetime)
			timer.Create("Isplyusingitem"..ply:UniqueID(), usetime, 1, function()
			timer.Destroy("plywantstouseitem"..ply:UniqueID())
			end)
			return true
	else
		SendChat(ply, "You should not drink when you're dead.")
		return false
	end
end

function UseFunc_Respec(ply)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "Can't use item while sleeping!") return false end
if timer.Exists("Isplyusingitem"..ply:UniqueID()) then SendChat(ply, translate.ClientGet(ply, "ItemNoUseCooldown")) return false end

local refund = 0 + ply.StatPoints
ply.StatPoints = 0

for k, v in pairs(StatsListServer) do
	local TheStatPieces = string.Explode(";", v)
	local TheStatName = TheStatPieces[1]
	refund = refund + tonumber(ply[ TheStatName ])
	ply[ TheStatName ] = 0
end

ply.StatPoints = refund

CalculateMaxHealth(ply)
CalculateMaxArmor(ply)
CalculateJumpPower(ply)
RecalcPlayerSpeed(ply)

ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")

TEANetUpdatePeriodicStats(ply)

TEANetUpdatePerks(ply)

SystemMessage(ply, translate.ClientGet(ply, "ItemUsedSkillsReset"), Color(255,255,205,255), true)

return true

end