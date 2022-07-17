
/*
Item template:

["item_healthkit"] = { 											-- what the item will be called within the games code, can be anything as long as you don't use the same name twice
	["Name"] = "Medkit", 										-- what the item will be called ingame
	["Cost"] = 200,												-- how many Gold will it cost if you buy it from the trader?
	["Model"] = "models/Items/HealthKit.mdl",					-- the items model
	["Description"] = "stuff",									-- the description will show up in the trader buy menu and in your inventory when you mouse over it
	["Weight"] = 1,												-- weight in kilograms (if your american and want to use imperial then your shit out of luck m8)
	["Supply"] = 0,												-- how many of these items does each trader have in stock? stock refills every 24 hours.  Putting 0 means unlimited stock, Putting -1 as stock will make it so the item isn't sold by traders
	["Rarity"] = 1,												-- 0 = trash, 1 = junk, 2 = common, 3 = uncommon, 4 = rare, 5 = super rare, 6 = epic, 7 = mythic, 8 = legendary, 9 = godly, 10 = event, 11 = unobtainable, any other = pending
	["Category"] = 1,											-- 1 = supplies, 2 = ammunition, 3 = weapons, any other = ignored by trader
	["UseFunc"] = stuff 										-- the function to call when the player uses the item from their inventory, you will need lua skillz here
	["DropFunc"] = stuff 										-- the function to call when the player drops the item
}


// IMPORTANT NOTE: use and drop functions must always return true or false here.  Returning true will subtract one of that item type from the player, returning false will make it so nothing is subtracted.
see server/player_inventory.lua for more info


*/



ItemsList = {
	["item_bandage"] = {
		["Name"] = "Bandage",
		["Cost"] = 45,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl",
		["Description"] = "A rolled up bandage that can be used to stop bleeding or to splint broken limbs.\nRestores 15 health, effectiveness is increased by 2.5% per MedSkill point.\n(Item ID: item_bandage)",
		["Weight"] = 0.06,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 15, 0, "comrade_vodka/inv_bandages.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,
	},

	["item_medkit"] = {
		["Name"] = "Medkit",
		["Cost"] = 175,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
		["Description"] = "An all-purpose medkit. Used to treat injuries of various types and severities - wounds, burns, poisonings, etc.\nRestores 45 health, healing effectiveness is increased by 2.5% per MedSkill point and treats 5% of infection.\n(Item ID: item_medkit)",
		["Weight"] = 0.5,
		["Supply"] = 30,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 45, 5, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_medkit") return drop end,
	},

	["item_armymedkit"] = {
		["Name"] = "Army Medkit",
		["Cost"] = 300,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl",
		["Description"] = "A specialized medical set to fight against physical damage and blood loss.\nIn it is included a component for blood coagulation, antibiotics, immunal stimulators, and painkillers.\nRestores 70 health, healing effectiveness is increased by 2.5% per MedSkill point and treats 20% of infection.\n(Item ID: item_armymedkit)",
		["Weight"] = 0.6,
		["Supply"] = 10,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 70, 20, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armymedkit") return drop end,
	},

	["item_scientificmedkit"] = {
		["Name"] = "Scientific Medkit",
		["Cost"] = 500,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl",
		["Description"] = "High end medical set designed for use in The Zone. This medkit includes items used to stop bleeding, treat burns, clean wounds, and treat a variety of different injuries.\nIt also includes anti-radiation pills and medicine.\nRestores 100 health, healing effectiveness is increased by 2.5% per MedSkill point and treats 60% of infection.\n(Item ID: item_scientificmedkit)",
		["Weight"] = 0.65,
		["Supply"] = 5,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 100, 60, "comrade_vodka/inv_aptecka.ogg") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_scientificmedkit") return drop end,
	},

	["item_antidote"] = {
		["Name"] = "Antidote",
		["Cost"] = 100,
		["Model"] = "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl",
		["Description"] = "A rare and expensive antidote that is capable of curing the zombie plague, It's a shame this wasn't invented until most of the world had already been overrun.\nDoesn't restore any health, but treats 40% of infection.\n(Item ID: item_antidote)",
		["Weight"] = 0.08,
		["Supply"] = 12,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 0, 40, "items/medshot4.wav") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end,
	},

	["item_egg"] = {
		["Name"] = "Raw Egg",
		["Cost"] = 5,
		["Model"] = "models/props_phx/misc/egg.mdl",
		["Description"] = "A raw egg. Restores 4% hunger\n(Item ID: item_egg)",
		["Weight"] = 0.08,
		["Supply"] = 0,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 4, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_egg") return drop end,
	},

	["item_milk"] = {
		["Name"] = "Old Milk",
		["Cost"] = 35,
		["Model"] = "models/props_junk/garbage_milkcarton002a.mdl",
		["Description"] = "An old milk. Restores 11% hunger\n(Item ID: item_milk)",
		["Weight"] = 1.05,
		["Supply"] = 20,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 11, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_milk") return drop end,
	},

	["item_soda"] = {
		["Name"] = "Can of Softdrink",
		["Cost"] = 20,
		["Model"] = "models/props_junk/PopCan01a.mdl",
		["Description"] = "An old pre apocalyptic softdrink, it even still has bubbles left in it! Restores 8% hunger.\n(Item ID: item_soda)",
		["Weight"] = 0.33,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 8, 5, 1, "comrade_vodka/inv_drink_can2.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end,
	},

	["item_energydrink"] = {
		["Name"] = "Energy Drink 'S.T.A.L.K.E.R.'",
		["Cost"] = 65,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl",
		["Description"] = "This is an excellent energy drink consisting of caffeine, taurine and a mixture of rejuvenating vitamins. Just the ticket when you're too tired to push forward!\nRestores 5% hunger, 65% of stamina and recovers 8% of sleep.\n(Item ID: item_energydrink)",
		["Weight"] = 0.56,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 5, 65, -8, "comrade_vodka/inv_drink_can1.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink") return drop end,
	},

	["item_energydrink_nonstop"] = {
		["Name"] = "'Nonstop' Energy Drink",
		["Cost"] = 100,
		["Model"] = "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl",
		["Description"] = "This drink will instantly rejuvenate your mind and body. This drink is similar to the common energy drink, but also heals you, reduces radiation somewhat, reduces hunger, and gives you more endurance.\nOf course it's a bit expensive, but the price is worth it! Restores 6% hunger, 100% of stamina and recovers 15% of sleep.\n(Item ID: item_energydrink_nonstop)",
		["Weight"] = 0.58,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 6, 100, -15, "comrade_vodka/inv_drink_can1.ogg") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink_nonstop") return drop end,
	},

	["item_beerbottle"] = {
		["Name"] = "Bottle of Beer",
		["Cost"] = 35,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "Makes the apocalypse a bit more bearable. Restores 19% hunger\n(Item ID: item_beerbottle)",
		["Weight"] = 0.8,
		["Supply"] = 10,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 19, -15, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end,
	},


	["item_tinnedfood"] = {
		["Name"] = "Tinned Rations",
		["Cost"] = 45,
		["Model"] = "models/props_junk/garbage_metalcan001a.mdl",
		["Description"] = "A tin of god knows what, the label fell off a long time ago.  Restores 20% hunger\n(Item ID: item_tinnedfood)",
		["Weight"] = 0.4,
		["Supply"] = 30,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 20, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end,
	},

	["item_potato"] = {
		["Name"] = "Potato",
		["Cost"] = 60,
		["Model"] = "models/props_phx/misc/potato.mdl",
		["Description"] = "A potato, tastes awful raw but it's edible nonetheless.  Restores 22% hunger\n(Item ID: item_potato)",
		["Weight"] = 0.2,
		["Supply"] = 20,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 22, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end,
	},

	["item_traderfood"] = {
		["Name"] = "Trader's Special",
		["Cost"] = 75,
		["Model"] = "models/props_junk/garbage_takeoutcarton001a.mdl",
		["Description"] = "A box of rather dubious looking meat and ramen, prepared for you by your friendly local trader.  Restores 47% Hunger\n(Item ID: item_traderfood)",
		["Weight"] = 0.6,
		["Supply"] = 5,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 47, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end,
	},

	["item_trout"] = {
		["Name"] = "River Trout",
		["Cost"] = 80,
		["Model"] = "models/props/CS_militia/fishriver01.mdl",
		["Description"] = "A tasty, fresh river trout.  Restores 65% Hunger\n(Item ID: item_trout)",
		["Weight"] = 0.75,
		["Supply"] = 2,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 65, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end,
	},

	["item_melon"] = {
		["Name"] = "Watermelon",
		["Cost"] = 150,
		["Model"] = "models/props_junk/watermelon01.mdl",
		["Description"] = "A fresh, tasty watermelon, fresh from the farming compounds up in the mountains. Restores 100% Hunger\n(Item ID: item_melon)",
		["Weight"] = 2,
		["Supply"] = 3,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 100, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end,
	},

	["item_burger"] = {
		["Name"] = "Cheez Burger",
		["Cost"] = 500,
		["Model"] = "models/food/burger.mdl",
		["Description"] = "A Burger which is light and tasty. Restores 100% hunger.\n(Item ID: item_burger)",
		["Weight"] = 0.4,
		["Supply"] = -1,
		["Rarity"] = 7,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 100, 0, 0, "vo/npc/male01/yeah02.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end,
	},

	["item_hotdog"] = {
		["Name"] = "Hotdog",
		["Cost"] = 200,
		["Model"] = "models/food/hotdog.mdl",
		["Description"] = "A tasty Hotdog. Restores 80% hunger\n(Item ID: item_hotdog)",
		["Weight"] = 0.35,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 80, 0, 0, "vo/npc/male01/nice.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_hotdog") return drop end,
	},

	["item_donut"] = {
		["Name"] = "Donut",
		["Cost"] = 65,
		["Model"] = "models/noesis/donut.mdl",
		["Description"] = "A donut. Restores 45% hunger\n(Item ID: item_donut)",
		["Weight"] = 0.2,
		["Supply"] = 5,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 45, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_donut") return drop end,
	},

	["item_bed"] = {
		["Name"] = "Bed",
		["Cost"] = 80,
		["Model"] = "models/props/de_inferno/bed.mdl",
		["Description"] = "Heavy, but allows you to sleep and set your spawn location.\n(Item ID: item_bed)",
		["Weight"] = 4.5,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
		["DropFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
	},

	["item_sleepingbag"] = {
		["Name"] = "Sleeping Bag",
		["Cost"] = 1130,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl",
		["Description"] = "A sleeping bag that can be re-used. Sleeping in the open may attract zombies.\n(Item ID: item_sleepingbag)",
		["Weight"] = 2.2,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) UseFunc_Sleep(ply, false) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end,
	},

	["item_amnesiapills"] = {
		["Name"] = "Amnesia Pill",
		["Cost"] = 450,
		["Model"] = "models/props_lab/jar01b.mdl",
		["Description"] = "USE THIS AT YOUR OWN RISK\nA bottle of pills that cause you to forget everything you've ever learned. Resets all your stats and refunds your stat points.\n(Item ID: item_amnesiapills)",
		["Weight"] = 0.1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_Respec(ply) return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end,
	},

	["item_armorbattery"] = {
		["Name"] = "Armor Battery",
		["Cost"] = 600,
		["Model"] = "models/Items/battery.mdl",
		["Description"] = "An Armor Battery used to boost protection in combat.\nRestores 15% Armor Battery, with +2% effectiveness per Engineer skill.\n(Item ID: item_armorbattery)",
		["Weight"] = 0.55,
		["Supply"] = 6,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 15, "items/battery_pickup.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armorbattery") return drop end,
	},

	["item_armorkevlar"] = {
		["Name"] = "Kevlar Plate",
		["Cost"] = 1250,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl",
		["Description"] = "A part of kevlar armor mostly used to protect user from severe bullet wounds.\nRestores 35% Armor battery, with +2% effectiveness per Engineer skill.\n(Item ID: item_armorkevlar)",
		["Weight"] = 1.13,
		["Supply"] = 3,
		["Rarity"] = 5,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 35, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_armorkevlar") return drop end,
	},





-- sellables





	["item_radio"] = {
		["Name"] = "Radio",
		["Cost"] = 300,
		["Model"] = "models/wick/wrbstalker/anomaly/items/dez_radio.mdl",
		["Description"] = "An old radio. It doesn't work anymore, but traders may pay money for this find.\n(Item ID: item_radio)",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_radio") return drop end,
	},

	["item_scrap"] = {
		["Name"] = "Scrap Metal",
		["Cost"] = 420,
		["Model"] = "models/Gibs/helicopter_brokenpiece_02.mdl",
		["Description"] = "Scrap metal. It doesn't really do anything but you may still use it to improve your armor condition.\nIncreases 10% Armor Battery, +2% Effectiveness per Engineer skill\n(Item ID: item_scrap)",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local armor = UseFunc_Armor(ply, 10, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_scrap") return drop end,
	},

	["item_chems"] = {
		["Name"] = "Chemicals",
		["Cost"] = 600,
		["Model"] = "models/props_junk/plasticbucket001a.mdl",
		["Description"] = "Some old chemicals that might be useful for explosives. The trader will pay good money for this.\n(Item ID: item_chems)",
		["Weight"] = 1.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_chems") return drop end,
	},

	["item_tv"] = {
		["Name"] = "Old TV",
		["Cost"] = 800,
		["Model"] = "models/props_c17/tv_monitor01.mdl",
		["Description"] = "An old television that appears to be intact. The trader will pay good money for this.\n(Item ID: item_tv)",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tv") return drop end,
	},

	["item_beer"] = {
		["Name"] = "Crate of Beer",
		["Cost"] = 1000,
		["Model"] = "models/props/CS_militia/caseofbeer01.mdl",
		["Description"] = "A crate of unopened beer. The trader will pay good money for this.\n(Item ID: item_beer)",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beer") return drop end,
	},

	["item_hamradio"] = {
		["Name"] = "Ham Radio",
		["Cost"] = 1500,
		["Model"] = "models/props_lab/citizenradio.mdl",
		["Description"] = "A working ham radio. The trader will pay good money for this.\n(Item ID: item_hamradio)",
		["Weight"] = 2.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_hamradio") return drop end,
	},

	["item_computer"] = {
		["Name"] = "Old Computer",
		["Cost"] = 2000,
		["Model"] = "models/props_lab/harddrive02.mdl",
		["Description"] = "Working computers are a very rare find these days. The trader will pay good money for this\n(Item ID: item_computer)",
		["Weight"] = 4,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_computer") return drop end,
	},


	["item_blueprint_sawbow"] = {
		["Name"] = "Saw-Bow Blueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "A clipboard containing some highly interesting blueprints for a crossbow that fires sawblades. I should take this to the trader and see what he thinks.\n(Item ID: item_blueprint_sawbow)",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, He might be able to build this thing") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_sawbow") return drop end,
	},

	["item_blueprint_railgun"] = {
		["Name"] = "Railgun Blueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "A clipboard containing some highly interesting blueprints for a high tech railgun. I should take this to the trader and see what he thinks.\n(Item ID: item_blueprint_railgun)",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, He might be able to build this thing") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_railgun") return drop end,
	},









-- junk




	["item_junk_tin"] = {
		["Name"] = "Empty Tin",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_metalcan002a.mdl",
		["Description"] = "This once contained food, now it only contains despair.\n(Item ID: item_junk_tin)",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_tin") return drop end,
	},

	["item_junk_boot"] = {
		["Name"] = "Old Boot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/Shoe001a.mdl",
		["Description"] = "Smells like cheesy feet\n(Item ID: item_junk_boot)",
		["Weight"] = 0.17,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_boot") return drop end,
	},


	["item_junk_paper"] = {
		["Name"] = "Old Newspaper",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_newspaper001a.mdl",
		["Description"] = "The latest news and gossip from 1993\n(Item ID: item_junk_paper)",
		["Weight"] = 0.12,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paper") return drop end,
	},

	["item_junk_keyboard"] = {
		["Name"] = "Keyboard",
		["Cost"] = 0,
		["Model"] = "models/props_c17/computer01_keyboard.mdl",
		["Description"] = "There aren't any computers left to connect this to\n(Item ID: item_junk_keyboard)",
		["Weight"] = 0.23,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_keyboard") return drop end,
	},

	["item_junk_gardenpot"] = {
		["Name"] = "Garden Pot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/terracotta01.mdl",
		["Description"] = "There's no time for watching grass grow these days.\n(Item ID: item_junk_gardenpot)",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_gardenpot") return drop end,
	},

	["item_junk_paint"] = {
		["Name"] = "Bucket of Dried Paint",
		["Cost"] = 0,
		["Model"] = "models/props_junk/metal_paintcan001a.mdl",
		["Description"] = "Dried up old paint\n(Item ID: item_junk_paint)",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paint") return drop end,
	},

	["item_junk_doll"] = {
		["Name"] = "Toy Doll",
		["Cost"] = 0,
		["Model"] = "models/props_c17/doll01.mdl",
		["Description"] = "Creepy looking little bastard\n(Item ID: item_junk_doll)",
		["Weight"] = 0.15,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_doll") return drop end,
	},

	["item_junk_pot"] = {
		["Name"] = "Rusted Tin Pot",
		["Cost"] = 0,
		["Model"] = "models/props_interiors/pot02a.mdl",
		["Description"] = "This could be useful if it wasn't rusted through at the bottom\n(Item ID: item_junk_pot)",
		["Weight"] = 0.2,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end,
	},

	["item_junk_hula"] = {
		["Name"] = "Hula Doll",
		["Cost"] = 0,
		["Model"] = "models/props_lab/huladoll.mdl",
		["Description"] = "Wind it up and it does the macarena! pretty cool but you can't eat it, fuck it or use it as a weapon so in the trash it goes.\n(Item ID: item_junk_hula)",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_hula") return drop end,
	},

	["item_junk_nailbox"] = {
		["Name"] = "Empty Nail Box",
		["Cost"] = 0,
		["Model"] = "models/props_lab/box01a.mdl",
		["Description"] = "This once contained nails, now a family of cockroaches live in it.\n(Item ID: item_junk_nailbox)",
		["Weight"] = 0.06,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_nailbox") return drop end,
	},

	["item_junk_twig"] = {
		["Name"] = "Twig",
		["Cost"] = 0,
		["Model"] = "models/props/cs_office/Snowman_arm.mdl",
		["Description"] = "Get some wood\n(Item ID: item_junk_twig)",
		["Weight"] = 0.1,
		["Supply"] = -1,
		["Rarity"] = 0,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end,
	},

	["upgradestatimmune"] = {
		["Name"] = "[REMOVED ITEM]",
		["Cost"] = 0,
		["Model"] = "models/player/items/humans/graduation_cap.mdl",
		["Description"] = "It is necessary to use this item.",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 2,
		["UseFunc"] = function(ply) SendChat(ply, "NO!") return true end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "upgradestatimmune") return drop end,
	},





-- crafting related




	["item_craft_fueltank"] = {
		["Name"] = "Fuel Tank",
		["Cost"] = 500,
		["Model"] = "models/props_junk/metalgascan.mdl",
		["Description"] = "An empty fuel tank, used to craft vehicles\n(Item ID: item_craft_fueltank)",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_fueltank") return drop end,
	},

	["item_craft_wheel"] = {
		["Name"] = "Car Wheel",
		["Cost"] = 300,
		["Model"] = "models/props_vehicles/carparts_wheel01a.mdl",
		["Description"] = "A car wheel fitted with a tyre that still holds air\n(Item ID: item_craft_wheel)",
		["Weight"] = 1.5,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_wheel") return drop end,
	},

	["item_craft_oil"] = {
		["Name"] = "Engine Oil (1L)",
		["Cost"] = 500,
		["Model"] = "models/props_junk/garbage_plasticbottle001a.mdl",
		["Description"] = "A bottle of engine lubricant, required to make an engine run without exploding\n(Item ID: item_craft_oil)",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_oil") return drop end,
	},

	["item_craft_battery"] = {
		["Name"] = "Battery Cell",
		["Cost"] = 500,
		["Model"] = "models/Items/car_battery01.mdl",
		["Description"] = "A standard battery used in many different things\n(Item ID: item_craft_battery)",
		["Weight"] = 0.6,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_battery") return drop end,
	},

	["item_craft_ecb"] = {
		["Name"] = "Electronic Control Box",
		["Cost"] = 250,
		["Model"] = "models/props_lab/reciever01b.mdl",
		["Description"] = "An electronic control box used in the construction of various vehicles and special weapons\n(Item ID: item_craft_ecb)",
		["Weight"] = 0.35,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_ecb") return drop end,
	},

	["item_craft_engine_small"] = {
		["Name"] = "Small engine",
		["Cost"] = 1000,
		["Model"] = "models/gibs/airboat_broken_engine.mdl",
		["Description"] = "A small petrol engine, it looks to be in decent condition\n(Item ID: item_craft_engine_small)",
		["Weight"] = 3,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_small") return drop end,
	},

	["item_craft_engine_large"] = {
		["Name"] = "Large engine",
		["Cost"] = 3000,
		["Model"] = "models/props_c17/TrapPropeller_Engine.mdl",
		["Description"] = "A big block engine, this looks like a bit of love and care would restore it to working order.\n(Item ID: item_craft_engine_large)",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_large") return drop end,
	},









-- guns









	["weapon_zw_noobcannon"] = {
		["Name"] = "Noob Cannon",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "My first peashooter, given to all players that are under level 15 when they spawn\n(Item ID: weapon_zw_noobcannon)",
		["Weight"] = 1.1,
		["Supply"] = -1, -- -1 stock means the traders will never sell this item
		["Rarity"] = 1,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_noobcannon") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_noobcannon") if drop then ply:StripWeapon("weapon_zw_noobcannon")end  return drop end,
	},

	["weapon_zw_pigsticker"] = {
		["Name"] = "Pig Sticker",
		["Cost"] = 150,
		["Model"] = "models/weapons/w_knife_ct.mdl",
		["Description"] = "A combat knife that can save your ass if you run out of ammo\n(Item ID: weapon_zw_pigsticker)",
		["Weight"] = 0.38,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_pigsticker") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_pigsticker") if drop then ply:StripWeapon("weapon_zw_pigsticker")end  return drop end,
	},

	["weapon_zw_axe"] = {
		["Name"] = "Axe",
		["Cost"] = 800,
		["Model"] = "models/props/CS_militia/axe.mdl",
		["Description"] = "Can i axe you a question?\n(Item ID: weapon_zw_axe)",
		["Weight"] = 1.73,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_axe") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_axe") if drop then ply:StripWeapon("weapon_zw_axe")end  return drop end,
	},

	["weapon_ate_wrench"] = {
		["Name"] = "Builder's Wrench",
		["Cost"] = 800,
		["Model"] = "models/props_c17/tools_wrench01a.mdl",
		["Description"] = "A wrench that is required to build and repair props and base components.  Can also be used as a bashing weapon though it isn't very effective.\n(Item ID: weapon_ate_wrench)",
		["Weight"] = 0.47,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_ate_wrench") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_ate_wrench") if drop then ply:StripWeapon("weapon_ate_wrench")end  return drop end,
	},

	["weapon_zw_scrapsword"] = {
		["Name"] = "Scrap Sword",
		["Cost"] = 1500,
		["Model"] = "models/props_c17/TrapPropeller_Blade.mdl",
		["Description"] = "A massive, heavy blade made of rusty scrap metal welded together.  I hope you have taken your tetanus vaccine\n(Item ID: weapon_zw_scrapsword)",
		["Weight"] = 5.3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapsword") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapsword") if drop then ply:StripWeapon("weapon_zw_scrapsword")end  return drop end,
	},

	["weapon_zw_g20"] = {
		["Name"] = "G20 Gov Issue",
		["Cost"] = 450,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "A newer model of glock that was popular among police and servicemen before the apocalpyse\n(Item ID: weapon_zw_g20)",
		["Weight"] = 1.18,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_g20") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_g20") if drop then ply:StripWeapon("weapon_zw_g20")end  return drop end,
	},

	["weapon_zw_57"] = {
		["Name"] = "FN FiveSeven",
		["Cost"] = 500,
		["Model"] = "models/weapons/w_pist_fiveseven.mdl",
		["Description"] = "A fast firing pistol that spews a hail of small high velocity bullets\n(Item ID: weapon_zw_57)",
		["Weight"] = 0.82,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_57") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_57") if drop then ply:StripWeapon("weapon_zw_57")end  return drop end,
	},

	["weapon_zw_u45"] = {
		["Name"] = "U-45 Whisper",
		["Cost"] = 600,
		["Model"] = "models/weapons/w_pist_usp.mdl",
		["Description"] = "A silencable pistol that used to be popular among swat and miltary outfits\n(Item ID: weapon_zw_u45)",
		["Weight"] = 1.1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_u45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_u45") if drop then ply:StripWeapon("weapon_zw_u45")end  return drop end,
	},


	["weapon_zw_warren50"] = {
		["Name"] = "Warren .50",
		["Cost"] = 750,
		["Model"] = "models/weapons/w_pist_deagle.mdl",
		["Description"] = "A powerful and flashy pistol that fires heavy magnum rounds, warrens are still in high demand despite their high skill requirement to use effectively\n(Item ID: weapon_zw_warren50)",
		["Weight"] = 1.73,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_warren50") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_warren50") if drop then ply:StripWeapon("weapon_zw_warren50")end  return drop end,
	},

	["weapon_zw_python"] = {
		["Name"] = "Python Magnum",
		["Cost"] = 1000,
		["Model"] = "models/weapons/w_357.mdl",
		["Description"] = "A bulky revolver that fires large caliber magnum bullets\n(Item ID: weapon_zw_python)",
		["Weight"] = 1.18,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_python") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_python") if drop then ply:StripWeapon("weapon_zw_python")end  return drop end,
	},

	["weapon_zw_dual"] = {
		["Name"] = "Dual Cutlass-9s",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_pist_elite.mdl",
		["Description"] = "A pair of custom built pistols that once belonged to a gunslinger of great renown\n(Item ID: weapon_zw_dual)",
		["Weight"] = 2.72,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dual") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dual") if drop then ply:StripWeapon("weapon_zw_dual")end  return drop end,
	},

	["weapon_zw_satan"] = {
		["Name"] = "Hand Cannon",
		["Cost"] = 2250,
		["Model"] = "models/weapons/w_m29_satan.mdl",
		["Description"] = "This thing is fucking huge, i hope i can fire it without breaking my wrist\n(Item ID: weapon_zw_satan)",
		["Weight"] = 3.14,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_satan") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_satan") if drop then ply:StripWeapon("weapon_zw_satan")end  return drop end,
	},

	["weapon_zw_mp11"] = {
		["Name"] = "MP-11 PDW",
		["Cost"] = 1750,
		["Model"] = "models/weapons/w_smg_mac10.mdl",
		["Description"] = "An old machine pistol, makes for a decent close quarters weapon but performs poorly at longer ranges. Uses pistol ammo\n(Item ID: weapon_zw_mp11)",
		["Weight"] = 2.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_mp11") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_mp11") if drop then ply:StripWeapon("weapon_zw_mp11")end  return drop end,
	},

	["weapon_zw_rg900"] = {
		["Name"] = "RG-900",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_smg_tmp.mdl",
		["Description"] = "A modern tactical machine pistol fitted with an integrated silencer. Uses pistol ammo\n(Item ID: weapon_zw_rg900)",
		["Weight"] = 2.35,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rg900") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rg900") if drop then ply:StripWeapon("weapon_zw_rg900")end  return drop end,
	},

	["weapon_zw_k5a"] = {
		["Name"] = "Kohl K5-A",
		["Cost"] = 2500,
		["Model"] = "models/weapons/w_smg_mp5.mdl",
		["Description"] = "This old german SMG may be an outdated design but it still packs a punch on the battlefield. Uses pistol rounds\n(Item ID: weapon_zw_k5a)",
		["Weight"] = 2.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k5a") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k5a") if drop then ply:StripWeapon("weapon_zw_k5a")end  return drop end,
	},

	["weapon_zw_stinger"] = {
		["Name"] = "Stinger SR",
		["Cost"] = 2800,
		["Model"] = "models/weapons/w_smg1.mdl",
		["Description"] = "A burst fire machine pistol designed to be accurate enough to go toe to toe with longer range attackers\n(Item ID: weapon_zw_stinger)",
		["Weight"] = 3.85,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stinger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stinger") if drop then ply:StripWeapon("weapon_zw_stinger")end  return drop end,
	},

	["weapon_zw_bosch"] = {
		["Name"] = "Bosch-Sterling B-60",
		["Cost"] = 3250,
		["Model"] = "models/weapons/w_sten.mdl",
		["Description"] = "A dated but still reasonably effective SMG with an interesting side loading magazine\n(Item ID: weapon_zw_bosch)",
		["Weight"] = 3.15,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_bosch") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_bosch") if drop then ply:StripWeapon("weapon_zw_bosch")end  return drop end,
	},

	["weapon_zw_k8"] = {
		["Name"] = "Kohl K8",
		["Cost"] = 4000,
		["Model"] = "models/weapons/w_smg_ump45.mdl",
		["Description"] = "The last weapon design released by Kohl before germany was overrun by the zombies, this is a modern SMG that offers excellent power, efficiency and accuracy. Uses pistol ammo\n(Item ID: weapon_zw_k8)",
		["Weight"] = 2.9,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8") if drop then ply:StripWeapon("weapon_zw_k8")end  return drop end,
	},

	["weapon_zw_k8c"] = {
		["Name"] = "Kohl K8-C",
		["Cost"] = 4500,
		["Model"] = "models/weapons/w_hk_usc.mdl",
		["Description"] = "An accurate carbine variant of the kohl K8 smg. Uses pistol ammo\n(Item ID: weapon_zw_k8c)",
		["Weight"] = 2.85,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8c") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8c") if drop then ply:StripWeapon("weapon_zw_k8c")end  return drop end,
	},

	["weapon_zw_shredder"] = {
		["Name"] = "The Shredder",
		["Cost"] = 5750,
		["Model"] = "models/weapons/w_smg_p90.mdl",
		["Description"] = "An experimental SMG that fires a hail of small high velocity bullets. Uses pistol ammo\n(Item ID: weapon_zw_shredder)",
		["Weight"] = 3,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_shredder") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_shredder") if drop then ply:StripWeapon("weapon_zw_shredder")end  return drop end,
	},

	["weapon_zw_enforcer"] = {
		["Name"] = "M3 Enforcer",
		["Cost"] = 4500,
		["Model"] = "models/weapons/w_shot_m3super90.mdl",
		["Description"] = "A 12 guage pump shotgun that was commonly used by police and sport shooters before the apocalpyse\n(Item ID: weapon_zw_enforcer)",
		["Weight"] = 3.6,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_enforcer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_enforcer") if drop then ply:StripWeapon("weapon_zw_enforcer")end  return drop end,
	},

	["weapon_zw_sweeper"] = {
		["Name"] = "XS-12 Sweeper",
		["Cost"] = 7000,
		["Model"] = "models/weapons/w_shot_xm1014.mdl",
		["Description"] = "A 12 guage pump shotgun that was commonly used by police and sport shooters before the apocalpyse\n(Item ID: weapon_zw_sweeper)",
		["Weight"] = 3.8,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_sweeper") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_sweeper") if drop then ply:StripWeapon("weapon_zw_sweeper")end  return drop end,
	},

	["weapon_zw_ranger"] = {
		["Name"] = "XR-15 Ranger",
		["Cost"] = 6500,
		["Model"] = "models/weapons/w_rif_m4a1.mdl",
		["Description"] = "An iconic american rifle that has been kept up to modern standards via constant upgrades\n(Item ID: weapon_zw_ranger)",
		["Weight"] = 4.2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_ranger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_ranger") if drop then ply:StripWeapon("weapon_zw_ranger")end  return drop end,
	},

	["weapon_zw_fusil"] = {
		["Name"] = "Fusil F1",
		["Cost"] = 7150,
		["Model"] = "models/weapons/w_rif_famas.mdl",
		["Description"] = "A tough, accurate rifle that was used in large numbers by the european union as they tried to quell the zombie plague\n(Item ID: weapon_zw_fusil)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fusil") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fusil") if drop then ply:StripWeapon("weapon_zw_fusil")end  return drop end,
	},

	["weapon_zw_stugcommando"] = {
		["Name"] = "Stug Commando",
		["Cost"] = 8750,
		["Model"] = "models/weapons/w_rif_sg552.mdl",
		["Description"] = "A shortened version of the Stug 556LR Sniper that has been optimized for use as an assault rifle\n(Item ID: weapon_zw_stugcommando)",
		["Weight"] = 4.45,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stugcommando") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stugcommando") if drop then ply:StripWeapon("weapon_zw_stugcommando")end  return drop end,
	},


	["weapon_zw_krukov"] = {
		["Name"] = "Krukov KA-74",
		["Cost"] = 9500,
		["Model"] = "models/weapons/w_rif_ak47.mdl",
		["Description"] = "A basic but still highly effective russian assault rifle\n(Item ID: weapon_zw_krukov)",
		["Weight"] = 3.76,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_krukov") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_krukov") if drop then ply:StripWeapon("weapon_zw_krukov")end  return drop end,
	},

	["weapon_zw_l303"] = {
		["Name"] = "Lior L303",
		["Cost"] = 12000,
		["Model"] = "models/weapons/w_rif_galil.mdl",
		["Description"] = "A rugged assault rifle that was used by the Saudi Union before their homeland was nuked in an attempt to halt the spread of zombies\n(Item ID: weapon_zw_l303)",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_l303") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_l303") if drop then ply:StripWeapon("weapon_zw_l303")end  return drop end,
	},

	["weapon_zw_scar"] = {
		["Name"] = "FN SCAR",
		["Cost"] = 22000,
		["Model"] = "models/weapons/w_fn_scar_h.mdl",
		["Description"] = "The pinnacle of modern assault rifles, was produced in very small numbers before the apocalyose so a gun like this is a rare find indeed.  Uses rifle ammo\n(Item ID: weapon_zw_scar)",
		["Weight"] = 4.6,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scar") if drop then ply:StripWeapon("weapon_zw_scar")end  return drop end,
	},

	["weapon_zw_lmg"] = {
		["Name"] = "Sawtooth LMG-4",
		["Cost"] = 16250,
		["Model"] = "models/weapons/w_mach_m249para.mdl",
		["Description"] = "A bulky light machine gun built to provide constant suppression against enemies in combat\n(Item ID: weapon_zw_lmg)",
		["Weight"] = 7.5,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_lmg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_lmg") if drop then ply:StripWeapon("weapon_zw_lmg")end  return drop end,
	},


	["weapon_zw_antelope"] = {
		["Name"] = "Antelope 7.62",
		["Cost"] = 9200,
		["Model"] = "models/weapons/w_snip_scout.mdl",
		["Description"] = "A scoped sporting rifle that was often used for hunting before the zombie apocalypse.  Uses sniper ammo\n(Item ID: weapon_zw_antelope)",
		["Weight"] = 5.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_antelope") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_antelope") if drop then ply:StripWeapon("weapon_zw_antelope")end  return drop end,
	},

	["weapon_zw_scimitar"] = {
		["Name"] = "Kohl K24 Scimitar",
		["Cost"] = 11000,
		["Model"] = "models/weapons/w_snip_g3sg1.mdl",
		["Description"] = "A burst fire sniper created by kohl to give infantry squads long range capabilites in battle\n(Item ID: weapon_zw_scimitar)",
		["Weight"] = 5.4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scimitar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scimitar") if drop then ply:StripWeapon("weapon_zw_scimitar")end  return drop end,
	},

	["weapon_zw_blackhawk"] = {
		["Name"] = "Blackhawk Sniper",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_snip_sg550.mdl",
		["Description"] = "A powerful military sniper fitted with a silencer and NVG scope.  Uses sniper ammo\n(Item ID: weapon_zw_blackhawk)",
		["Weight"] = 6.35,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_blackhawk") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_blackhawk") if drop then ply:StripWeapon("weapon_zw_blackhawk")end  return drop end,
	},

	["weapon_zw_punisher"] = {
		["Name"] = "The Punisher",
		["Cost"] = 35000,
		["Model"] = "models/weapons/w_acc_int_aw50.mdl",
		["Description"] = "A massively powerful sniper rifle chambered in the .50BMG cartridge.  Uses sniper ammo\n(Item ID: weapon_zw_punisher)",
		["Weight"] = 7.95,
		["Supply"] = 5,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_punisher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_punisher") if drop then ply:StripWeapon("weapon_zw_punisher")end  return drop end,
	},
	
	["weapon_zw_scrapcrossbow"] = {
		["Name"] = "Explosive Crossbow",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_crossbow.mdl",
		["Description"] = "A crossbow cobbled together from various spare parts, it can fire explosive bolts.  Uses steel bolts\n(Item ID: weapon_zw_scrapcrossbow)",
		["Weight"] = 8,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapcrossbow") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapcrossbow") if drop then ply:StripWeapon("weapon_zw_scrapcrossbow")end  return drop end,
	},

	["weapon_zw_winchester"] = {
		["Name"] = "WINchester",
		["Cost"] = 3500,
		["Model"] = "models/weapons/w_winchester_1873.mdl",
		["Description"] = "They don't call this the WINchester for nothing amirite.  Uses Magnum rounds\n(Item ID: weapon_zw_winchester)",
		["Weight"] = 5.32,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_winchester") if drop then ply:StripWeapon("weapon_zw_winchester")end  return drop end,
	},

	["weapon_zw_perrin"] = {
		["Name"] = "Perrin P-64",
		["Cost"] = 8500,
		["Model"] = "models/weapons/w_pp19_bizon.mdl",
		["Description"] = "A russian weapon designed to put assualt rifle levels of firepower in the hands of tankers and support crews.  Uses pistol rounds\n(Item ID: weapon_zw_perrin)",
		["Weight"] = 3.72,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_perrin") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_perrin") if drop then ply:StripWeapon("weapon_zw_perrin")end  return drop end,
	},

	["weapon_zw_dammerung"] = {
		["Name"] = "Dammerung Assault Shotgun",
		["Cost"] = 12200,
		["Model"] = "models/weapons/w_usas_12.mdl",
		["Description"] = "A fully automatic 20 round assault shotgun that chews anybody in the room into pulpy red goop.  Uses shotgun rounds\n(Item ID: weapon_zw_dammerung)",
		["Weight"] = 6.72,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dammerung") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dammerung") if drop then ply:StripWeapon("weapon_zw_dammerung")end  return drop end,
	},

	["weapon_zw_rpg"] = {
		["Name"] = "RPG Launcher",
		["Cost"] = 50000,
		["Model"] = "models/weapons/w_rocket_launcher.mdl",
		["Description"] = "An RPG launcher primarily designed for busting vehicles or fortifications.  Uses rockets\n(Item ID: weapon_zw_rpg)",
		["Weight"] = 7.2,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rpg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rpg") if drop then ply:StripWeapon("weapon_zw_rpg")end  return drop end,
	},


	["weapon_zw_fuckinator"] = {
		["Name"] = "The Fuckinator",
		["Cost"] = 30000,
		["Model"] = "models/weapons/w_pist_p228.mdl",
		["Description"] = "Point away from face\n(Item ID: weapon_zw_fuckinator)",
		["Weight"] = 6.14,
		["Supply"] = -1,
		["Rarity"] = 7,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fuckinator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fuckinator") if drop then ply:StripWeapon("weapon_zw_fuckinator")end  return drop end,
	},

	["weapon_zw_germanator"] = {
		["Name"] = "The Germanator",
		["Cost"] = 5800,
		["Model"] = "models/weapons/w_mp40smg.mdl",
		["Description"] = "An antique SMG that fires an unnecessarily large caliber bullet. Uses pistol ammo\n(Item ID: weapon_zw_germanator)",
		["Weight"] = 3.34,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_germanator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_germanator") if drop then ply:StripWeapon("weapon_zw_germanator")end  return drop end,
	},

	["weapon_zw_807"] = {
		["Name"] = "RM-807",
		["Cost"] = 5800,
		["Model"] = "models/weapons/w_remington_870_tact.mdl",
		["Description"] = "A 12 guage pump shotgun that fires extra strength magnum shells. Uses shotgun ammo\n(Item ID: weapon_zw_807)",
		["Weight"] = 3.82,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_807") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_807") if drop then ply:StripWeapon("weapon_zw_807")end  return drop end,
	},

	["weapon_mad_crowbar"] = {
		["Name"] = "[MAD] Crowbar",
		["Cost"] = 150000,
		["Model"] = "models/weapons/w_crowbar.mdl",
		["Description"] = "A Crowbar???????\n(Item ID: weapon_mad_crowbar)",
		["Weight"] = 6.17,
		["Supply"] = -1,
		["Rarity"] = 9,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_mad_crowbar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_mad_crowbar") if drop then ply:StripWeapon("weapon_mad_crowbar")end  return drop end,
	},




-- ammo

	["item_pistolammo"] = {
		["Name"] = "Pistol Ammo Box",
		["Cost"] = 45,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		["Description"] = "An ammo box that contains 100 pistol rounds\n(Item ID: item_pistolammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end,
	},

	["item_m9k_smgammo"] = {
		["Name"] = "[M9k] SMG Ammo Box",
		["Cost"] = 70,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		["Description"] = "Ammo used for M9k SMG Weapons. Contains 100 SMG rounds.\n(Item ID: item_m9k_smgammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "SMG1") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_smgammo") return drop end,
	},

	["item_m9k_assaultammo"] = {
		["Name"] = "[M9k] Assault Rifle Ammo",
		["Cost"] = 95,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		["Description"] = "Ammo used for M9k Assault Weapons. Contains 100 Assault Rifle rounds.\n(Item ID: item_m9k_assaultammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "AR2") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_assaultammo") return drop end,
	},

	["item_m9k_sniperammo"] = {
		["Name"] = "[M9k] Sniper Rifle Ammo",
		["Cost"] = 150,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		["Description"] = "Ammo used for M9k Sniper Weapons. Contains 50 Sniper Rifle rounds.\n(Item ID: item_m9k_sniperammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "SniperPenetratedRound") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_sniperammo") return drop end,
	},

	["item_magammo"] = {
		["Name"] = "Magnum Bullets",
		["Cost"] = 60,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_357_jhp.mdl",
		["Description"] = "An ammo box that contains 50 magnum rounds\n(Item ID: item_magammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_magammo") return drop end,
	},

	["item_buckshotammo"] = {
		["Name"] = "Buckshot Ammo",
		["Cost"] = 65,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		["Description"] = "An ammo box that contains 50 shotgun rounds\n(Item ID: item_buckshotammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_buckshotammo") return drop end,
	},

	["item_rifleammo"] = {
		["Name"] = "Rifle Ammo Box",
		["Cost"] = 90,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		["Description"] = "An ammo box that contains 100 assault rifle rounds\n(Item ID: item_rifleammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rifleammo") return drop end,
	},

	["item_sniperammo"] = {
		["Name"] = "Sniper Ammo",
		["Cost"] = 130,
		["Model"] = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		["Description"] = "An ammo box that contains 50 sniper rifle bullets\n(Item ID: item_sniperammo)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end,
	},

	["item_crossbowbolt"] = {
		["Name"] = "Steel Bolts",
		["Cost"] = 40,
		["Model"] = "models/Items/CrossbowRounds.mdl",
		["Description"] = "An bundle of 6 steel bolts\n(Item ID: item_crossbowbolt)",
		["Weight"] = 0.3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 6, "XBowBolt") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt") return drop end,
	},

	["item_crossbowbolt_crate"] = {
		["Name"] = "Steel Bolts Crate",
		["Cost"] = 150,
		["Model"] = "models/Items/item_item_crate.mdl",
		["Description"] = "A crate that contains 25 steel bolts\n(Item ID: item_crossbowbolt_crate)",
		["Weight"] = 1.5,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "XBowBolt") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt_crate") return drop end,
	},

	["item_rocketammo"] = {
		["Name"] = "RPG Rocket",
		["Cost"] = 180,
		["Model"] = "models/weapons/w_missile_closed.mdl",
		["Description"] = "A missile designed for use with the RPG launcher\n(Item ID: item_rocketammo)",
		["Weight"] = 2.14,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rocketammo") return drop end,
	},


-- Cut Weapons


    ["weapon_zw_falcon"] = {
		["Name"] = "Warren Falcon .45",
		["Cost"] = 1400,
		["Model"] = "models/weapons/s_dmgf_co1911.mdl",
		["Description"] = "A classic pistol that has been in use for over 100 years and still stands tall on the battlefield.\n(Item ID: weapon_zw_falcon)",
		["Weight"] = 1.4,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_falcon") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_falcon") if drop then ply:StripWeapon("weapon_zw_falcon")end  return drop end,
	},

    ["weapon_zw_spas"] = {
		["Name"] = "SPAS12 Shorty",
		["Cost"] = 4500,
		["Model"] = "models/weapons/w_shotgun.mdl",
		["Description"] = "A pump shotgun that has been cut down from its' original length to save on weight.  It has also been modded with an alternate slamfire mode that fires 2 rounds in quick succession.\n(Item ID: weapon_zw_spas)",
		["Weight"] = 3.6,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_spas") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_spas") if drop then ply:StripWeapon("weapon_zw_spas")end  return drop end,
	},

    ["weapon_zw_lbr"] = {
		["Name"] = "Warren LBR",
		["Cost"] = 9500,
		["Model"] = "models/weapons/w_snip_m14sp.mdl",
		["Description"] = "A powerful semi-auto battle rifle that is a rebuilt version of an old and popular design.\n(Item ID: weapon_zw_lbr)",
		["Weight"] = 3.8,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_lbr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_lbr") if drop then ply:StripWeapon("weapon_zw_lbr")end  return drop end,
	},





-- Other special weapons

	
    ["weapon_zw_plasmalauncher"] = {
		["Name"] = "Experimental Plasma Cannon",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_physics.mdl",
		["Description"] = "The EPC is an experimental plasma launcher that uses no ammo and fires highly volatile and explosive plasma blasts.\n(Item ID: weapon_zw_plasmalauncher)",
		["Weight"] = 20,
		["Supply"] = -1,
		["Rarity"] = 11,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_plasmalauncher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_plasmalauncher") if drop then ply:StripWeapon("weapon_zw_plasmalauncher")end  return drop end,
	},

    ["weapon_zw_minigun"] = {
		["Name"] = "GAU-8C Chaingun",
		["Cost"] = 45000,
		["Model"] = "models/weapons/w_m134_minigun.mdl",
		["Description"] = "An enormous minigun that spews a constant stream of hot lead.\n(Item ID: weapon_zw_minigun)",
		["Weight"] = 18.84,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_minigun") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_minigun") if drop then ply:StripWeapon("weapon_zw_minigun")end  return drop end,
	},

    ["weapon_zw_grenade_pipe"] = {
		["Name"] = "Pipe Bomb",
		["Cost"] = 120,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "An explosive pipe bomb that can be useful for blowing up crowds of zombies or raining fire on enemy bases.\n(Item ID: weapon_zw_grenade_pipe)",
		["Weight"] = 0.34,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_pipe", "nade_pipebombs") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_pipe") if drop then ply:StripWeapon("weapon_zw_grenade_pipe")end  return drop end,
	},

    ["weapon_zw_grenade_flare"] = {
		["Name"] = "Distress Flare",
		["Cost"] = 65,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "A distress flare that is useful for lighting up dark areas\n(Item ID: weapon_zw_grenade_flare)",
		["Weight"] = 0.4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_flare", "nade_flares") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_flare") if drop then ply:StripWeapon("weapon_zw_grenade_flare")end  return drop end,
	},

    ["weapon_zw_grenade_frag"] = {
		["Name"] = "Frag Grenade",
		["Cost"] = 375,
		["Model"] = "models/weapons/w_eq_fraggrenade.mdl",
		["Description"] = "A high powered military fragmentation grenade, these are a relatively rare find in this post apocalyptic world\n(Item ID: weapon_zw_grenade_frag)",
		["Weight"] = 0.63,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_frag", "Grenade") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_frag") if drop then ply:StripWeapon("weapon_zw_grenade_frag")end  return drop end,
	},

    ["weapon_zw_grenade_molotov"] = {
		["Name"] = "Molotov Cocktail",
		["Cost"] = 400,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "A bottle full of petrol with a burning rag stuffed into the top.  Perfect for hosting a zombie BBQ\n(Item ID: weapon_zw_grenade_molotov)",
		["Weight"] = 0.35,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_molotov", "nade_molotov") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_molotov") if drop then ply:StripWeapon("weapon_zw_grenade_molotov")end  return drop end,
	},





-- M9k guns



    ["m9k_coltpython"] = {
		["Name"] = "[M9k] Colt Python",
		["Cost"] = 1500,
		["Model"] = "models/weapons/w_colt_python.mdl",
		["Description"] = "Colt Python from M9k Small Arms. Uses Magnum ammo.\n(Item ID: m9k_coltpython)",
		["Weight"] = 1.36,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_coltpython") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_coltpython") if drop then ply:StripWeapon("m9k_coltpython")end  return drop end,
	},

    ["m9k_glock"] = {
		["Name"] = "[M9k] Glock 18",
		["Cost"] = 4400,
		["Model"] = "models/weapons/w_dmg_glock.mdl",
		["Description"] = "Glock 18 from M9k Small Arms. Uses Pistol ammo.\n(Item ID: m9k_glock)",
		["Weight"] = 1.56,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_glock") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_glock") if drop then ply:StripWeapon("m9k_glock")end  return drop end,
	},

    ["m9k_hk45"] = {
		["Name"] = "[M9k] HK45C",
		["Cost"] = 1000,
		["Model"] = "models/weapons/w_hk45c.mdl",
		["Description"] = "HK45C from M9k Small Arms. Uses Pistol ammo.\n(Item ID: m9k_hk45)",
		["Weight"] = 0.96,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_hk45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_hk45") if drop then ply:StripWeapon("m9k_hk45")end  return drop end,
	},

    ["m9k_m92beretta"] = {
		["Name"] = "[M9k] Beretta M92",
		["Cost"] = 1800,
		["Model"] = "models/weapons/w_beretta_m92.mdl",
		["Description"] = "Beretta M92 from M9k Small Arms. Uses Pistol ammo.\n(Item ID: m9k_m92beretta)",
		["Weight"] = 1.16,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m92beretta") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m92beretta") if drop then ply:StripWeapon("m9k_m92beretta")end  return drop end,
	},

    ["m9k_luger"] = {
		["Name"] = "[M9k] P08 Luger",
		["Cost"] = 1600,
		["Model"] = "models/weapons/w_luger_p08.mdl",
		["Description"] = "description\n(Item ID: m9k_luger)",
		["Weight"] = 1.09,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_luger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_luger") if drop then ply:StripWeapon("m9k_luger")end  return drop end,
	},

    ["m9k_ragingbull"] = {
		["Name"] = "[M9k] Raging Bull",
		["Cost"] = 2500,
		["Model"] = "models/weapons/w_taurus_raging_bull.mdl",
		["Description"] = "description\n(Item ID: m9k_ragingbull)",
		["Weight"] = 2.16,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ragingbull") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ragingbull") if drop then ply:StripWeapon("m9k_ragingbull")end  return drop end,
	},

    ["m9k_scoped_taurus"] = {
		["Name"] = "[M9k] Scoped Raging Bull",
		["Cost"] = 3000,
		["Model"] = "models/weapons/w_raging_bull_scoped.mdl",
		["Description"] = "description\n(Item ID: m9k_scoped_taurus)",
		["Weight"] = 2.56,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_scoped_taurus") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_scoped_taurus") if drop then ply:StripWeapon("m9k_scoped_taurus")end  return drop end,
	},

    ["m9k_remington1858"] = {
		["Name"] = "[M9k] Remington 1858",
		["Cost"] = 2200,
		["Model"] = "models/weapons/w_remington_1858.mdl",
		["Description"] = "description\n(Item ID: m9k_remington1858)",
		["Weight"] = 1.46,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_remington1858") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington1858") if drop then ply:StripWeapon("m9k_remington1858")end  return drop end,
	},

    ["m9k_model3russian"] = {
		["Name"] = "[M9k] S&W Model 3 Russian",
		["Cost"] = 2300,
		["Model"] = "models/weapons/w_model_3_rus.mdl",
		["Description"] = "description\n(Item ID: m9k_model3russian)",
		["Weight"] = 1.38,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model3russian") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model3russian") if drop then ply:StripWeapon("m9k_model3russian")end  return drop end,
	},

    ["m9k_model500"] = {
		["Name"] = "[M9k] S&W Model 500",
		["Cost"] = 2650,
		["Model"] = "models/weapons/w_sw_model_500.mdl",
		["Description"] = "description\n(Item ID: m9k_model500)",
		["Weight"] = 1.36,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model500") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model500") if drop then ply:StripWeapon("m9k_model500")end  return drop end,
	},

    ["m9k_model627"] = {
		["Name"] = "[M9k] S&W Model 627",
		["Cost"] = 2800,
		["Model"] = "models/weapons/w_sw_model_627.mdl",
		["Description"] = "description\n(Item ID: m9k_model627)",
		["Weight"] = 2.10,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_model627") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model627") if drop then ply:StripWeapon("m9k_model627")end  return drop end,
	},

    ["m9k_sig_p229r"] = {
		["Name"] = "[M9k] Sig Sauer P229R",
		["Cost"] = 1900,
		["Model"] = "models/weapons/w_sig_229r.mdl",
		["Description"] = "description\n(Item ID: m9k_sig_p229r)",
		["Weight"] = 1.31,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_sig_p229r") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sig_p229r") if drop then ply:StripWeapon("m9k_sig_p229r")end  return drop end,
	},

    ["m9k_acr"] = {
		["Name"] = "[M9k] ACR",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_masada_acr.mdl",
		["Description"] = "description\n(Item ID: m9k_acr)",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_acr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_acr") if drop then ply:StripWeapon("m9k_acr")end  return drop end,
	},

    ["m9k_ak47"] = {
		["Name"] = "[M9k] AK-47",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_ak47_m9k.mdl",
		["Description"] = "description\n(Item ID: m9k_ak47)",
		["Weight"] = 3.8,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ak47") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak47") if drop then ply:StripWeapon("m9k_ak47")end  return drop end,
	},

    ["m9k_ak74"] = {
		["Name"] = "[M9k] AK-74",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_tct_ak47.mdl",
		["Description"] = "description\n(Item ID: m9k_ak74)",
		["Weight"] = 3.66,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ak74") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak74") if drop then ply:StripWeapon("m9k_ak74")end  return drop end,
	},

    ["m9k_amd65"] = {
		["Name"] = "[M9k] AMD 65",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_amd_65.mdl",
		["Description"] = "description\n(Item ID: m9k_amd65)",
		["Weight"] = 3.9,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_amd65") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_amd65") if drop then ply:StripWeapon("m9k_amd65")end  return drop end,
	},

    ["m9k_an94"] = {
		["Name"] = "[M9k] AN-94",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_rif_an_94.mdl",
		["Description"] = "description\n(Item ID: m9k_an94)",
		["Weight"] = 4.4,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_an94") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_an94") if drop then ply:StripWeapon("m9k_an94")end  return drop end,
	},

    ["m9k_val"] = {
		["Name"] = "[M9k] AS Val",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_dmg_vally.mdl",
		["Description"] = "description\n(Item ID: m9k_val)",
		["Weight"] = 2.8,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_val") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_val") if drop then ply:StripWeapon("m9k_val")end  return drop end,
	},

    ["m9k_f2000"] = {
		["Name"] = "[M9k] F2000",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_fn_f2000.mdl",
		["Description"] = "description\n(Item ID: m9k_f2000)",
		["Weight"] = 5.24,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_f2000") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_f2000") if drop then ply:StripWeapon("m9k_f2000")end  return drop end,
	},

    ["m9k_fal"] = {
		["Name"] = "[M9k] FN Fal",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_fn_fal.mdl",
		["Description"] = "description\n(Item ID: m9k_fal)",
		["Weight"] = 5.9,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_fal") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fal") if drop then ply:StripWeapon("m9k_fal")end  return drop end,
	},

    ["m9k_g36"] = {
		["Name"] = "[M9k] G36",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_g36c.mdl",
		["Description"] = "description\n(Item ID: m9k_g36)",
		["Weight"] = 3.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_g36") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g36") if drop then ply:StripWeapon("m9k_g36")end  return drop end,
	},

    ["m9k_m416"] = {
		["Name"] = "[M9k] HK 416",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_416.mdl",
		["Description"] = "description\n(Item ID: m9k_m416)",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m416") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m416") if drop then ply:StripWeapon("m9k_m416")end  return drop end,
	},

    ["m9k_g3a3"] = {
		["Name"] = "[M9k] HK G3A3",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_g3.mdl",
		["Description"] = "description\n(Item ID: m9k_g3a3)",
		["Weight"] = 5.8,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_g3a3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g3a3") if drop then ply:StripWeapon("m9k_g3a3")end  return drop end,
	},

    ["m9k_l85"] = {
		["Name"] = "[M9k] L85",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_l85a2.mdl",
		["Description"] = "description\n(Item ID: m9k_l85)",
		["Weight"] = 5,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_l85") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_l85") if drop then ply:StripWeapon("m9k_l85")end  return drop end,
	},

    ["m9k_m16a4_acog"] = {
		["Name"] = "[M9k] M16A4 ACOG",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_dmg_m16ag.mdl",
		["Description"] = "description\n(Item ID: m9k_m16a4_acog)",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m16a4_acog") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m16a4_acog") if drop then ply:StripWeapon("m9k_m16a4_acog")end  return drop end,
	},

    ["m9k_vikhr"] = {
		["Name"] = "[M9k] SR-3M Vikhr",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_dmg_vikhr.mdl",
		["Description"] = "description\n(Item ID: m9k_vikhr)",
		["Weight"] = 3.68,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_vikhr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vikhr") if drop then ply:StripWeapon("m9k_vikhr")end  return drop end,
	},

    ["m9k_auga3"] = {
		["Name"] = "[M9k] Steyr AUG A3",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_auga3.mdl",
		["Description"] = "description\n(Item ID: m9k_auga3)",
		["Weight"] = 4.18,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_auga3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_auga3") if drop then ply:StripWeapon("m9k_auga3")end  return drop end,
	},

    ["m9k_tar21"] = {
		["Name"] = "[M9k] TAR-21",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_imi_tar21.mdl",
		["Description"] = "description\n(Item ID: m9k_tar21)",
		["Weight"] = 3.35,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_tar21") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tar21") if drop then ply:StripWeapon("m9k_tar21")end  return drop end,
	},

    ["m9k_ares_shrike"] = {
		["Name"] = "[M9k] Ares Shrike",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_ares_shrike.mdl",
		["Description"] = "description\n(Item ID: m9k_ares_shrike)",
		["Weight"] = 9.85,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ares_shrike") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ares_shrike") if drop then ply:StripWeapon("m9k_ares_shrike")end  return drop end,
	},

    ["m9k_fg42"] = {
		["Name"] = "[M9k] FG 42",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_fg42.mdl",
		["Description"] = "description\n(Item ID: m9k_fg42)",
		["Weight"] = 5.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_fg42") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fg42") if drop then ply:StripWeapon("m9k_fg42")end  return drop end,
	},

    ["m9k_m1918bar"] = {
		["Name"] = "[M9k] M1918 BAR",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_m1918_bar.mdl",
		["Description"] = "description\n(Item ID: m9k_m60)",
		["Weight"] = 5.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m1918bar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m1918bar") if drop then ply:StripWeapon("m9k_m1918bar")end  return drop end,
	},

    ["m9k_m60"] = {
		["Name"] = "[M9k] M60",
		["Cost"] = 100000,
		["Model"] = "models/weapons/w_m60_machine_gun.mdl",
		["Description"] = "The best Weapon reborn - M60. Uses M9k Assault rifle ammo.\n(Item ID: m9k_m60)",
		["Weight"] = 9.8,
		["Supply"] = 1,
		["Rarity"] = 8,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m60") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m60") if drop then ply:StripWeapon("m9k_m60")end  return drop end,
	},

    ["m9k_pkm"] = {
		["Name"] = "[M9k] PKM",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_mach_russ_pkm.mdl",
		["Description"] = "description\n(Item ID: m9k_pkm)",
		["Weight"] = 8.5,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_pkm") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_pkm") if drop then ply:StripWeapon("m9k_pkm")end  return drop end,
	},

    ["m9k_m3"] = {
		["Name"] = "[M9k] Benneli M3",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_benelli_m3.mdl",
		["Description"] = "description\n(Item ID: m9k_m60)",
		["Weight"] = 3.62,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m3") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m3") if drop then ply:StripWeapon("m9k_m3")end  return drop end,
	},

    ["m9k_browningauto5"] = {
		["Name"] = "[M9k] Browning Auto 5",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_browning_auto.mdl",
		["Description"] = "description\n(Item ID: m9k_browningauto5)",
		["Weight"] = 4.4,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_browningauto5") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_browningauto5") if drop then ply:StripWeapon("m9k_browningauto5")end  return drop end,
	},

    ["m9k_ithacam37"] = {
		["Name"] = "[M9k] Ithaca M37",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_ithaca_m37.mdl",
		["Description"] = "description\n(Item ID: m9k_ithacam37)",
		["Weight"] = 3.45,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ithacam37") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ithacam37") if drop then ply:StripWeapon("m9k_ithacam37")end  return drop end,
	},

    ["m9k_mossberg590"] = {
		["Name"] = "[M9k] Mossberg 590",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_mossberg_590.mdl",
		["Description"] = "description\n(Item ID: m9k_mossberg590)",
		["Weight"] = 3.69,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mossberg590") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mossberg590") if drop then ply:StripWeapon("m9k_mossberg590")end  return drop end,
	},

    ["m9k_jackhammer"] = {
		["Name"] = "[M9k] Pancor Jackhammer",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_pancor_jackhammer.mdl",
		["Description"] = "description\n(Item ID: m9k_jackhammer)",
		["Weight"] = 4.6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_jackhammer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_jackhammer") if drop then ply:StripWeapon("m9k_jackhammer")end  return drop end,
	},

    ["m9k_spas12"] = {
		["Name"] = "[M9k] SPAS 12",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_spas_12.mdl",
		["Description"] = "description\n(Item ID: m9k_spas12)",
		["Weight"] = 4.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_spas12") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_spas12") if drop then ply:StripWeapon("m9k_spas12")end  return drop end,
	},

    ["m9k_striker12"] = {
		["Name"] = "[M9k] Striker 12",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_striker_12g.mdl",
		["Description"] = "description\n(Item ID: m9k_striker12)",
		["Weight"] = 3.66,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_striker12") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_striker12") if drop then ply:StripWeapon("m9k_striker12")end  return drop end,
	},

    ["m9k_1897winchester"] = {
		["Name"] = "[M9k] Wincheter 1897",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_winchester_1897_trench.mdl",
		["Description"] = "description\n(Item ID: m9k_1897winchester)",
		["Weight"] = 3.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_1897winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1897winchester") if drop then ply:StripWeapon("m9k_1897winchester")end  return drop end,
	},

    ["m9k_1887winchester"] = {
		["Name"] = "[M9k] Winchester 87",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_winchester_1887.mdl",
		["Description"] = "description\n(Item ID: m9k_1887winchester)",
		["Weight"] = 3.12,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_1887winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1887winchester") if drop then ply:StripWeapon("m9k_1887winchester")end  return drop end,
	},

    ["m9k_barret_m82"] = {
		["Name"] = "[M9k] Barret M82",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_barret_m82.mdl",
		["Description"] = "description\n(Item ID: m9k_barret_m82)",
		["Weight"] = 11.85,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_barret_m82") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_barret_m82") if drop then ply:StripWeapon("m9k_barret_m82")end  return drop end,
	},

    ["m9k_m98b"] = {
		["Name"] = "[M9k] Barret M98B",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_barrett_m98b.mdl",
		["Description"] = "description\n(Item ID: m9k_m98b)",
		["Weight"] = 10.95,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m98b") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m98b") if drop then ply:StripWeapon("m9k_m98b")end  return drop end,
	},

    ["m9k_svu"] = {
		["Name"] = "[M9k] Dragunov SVU",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_dragunov_svu.mdl",
		["Description"] = "description\n(Item ID: m9k_svu)",
		["Weight"] = 5.44,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_svu") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svu") if drop then ply:StripWeapon("m9k_svu")end  return drop end,
	},

    ["m9k_sl8"] = {
		["Name"] = "[M9k] SL8",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_snip_int.mdl",
		["Description"] = "description\n(Item ID: m9k_sl8)",
		["Weight"] = 4.92,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_sl8") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sl8") if drop then ply:StripWeapon("m9k_sl8")end  return drop end,
	},

    ["m9k_intervention"] = {
		["Name"] = "[M9k] Intervention",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_snip_int.mdl",
		["Description"] = "description\n(Item ID: m9k_intervention)",
		["Weight"] = 8.46,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_intervention") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_intervention") if drop then ply:StripWeapon("m9k_intervention")end  return drop end,
	},

    ["m9k_m24"] = {
		["Name"] = "[M9k] M24",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_snip_m24_6.mdl",
		["Description"] = "description\n(Item ID: m9k_m24)",
		["Weight"] = 7.98,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_m24") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m24") if drop then ply:StripWeapon("m9k_m24")end  return drop end,
	},

    ["m9k_psg1"] = {
		["Name"] = "[M9k] PSG-1",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_psg1.mdl",
		["Description"] = "description\n(Item ID: m9k_psg1)",
		["Weight"] = 8.28,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_psg1") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_psg1") if drop then ply:StripWeapon("m9k_psg1")end  return drop end,
	},

    ["m9k_remington7615p"] = {
		["Name"] = "[M9k] Remington 7615P",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_remington_7615p.mdl",
		["Description"] = "description\n(Item ID: m9k_remington7615p)",
		["Weight"] = 5.65,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_remington7615p") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington7615p") if drop then ply:StripWeapon("m9k_remington7615p")end  return drop end,
	},

    ["m9k_svt40"] = {
		["Name"] = "[M9k] SVT 40",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_svt_40.mdl",
		["Description"] = "description\n(Item ID: m9k_svt40)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_svt40") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svt40") if drop then ply:StripWeapon("m9k_svt40")end  return drop end,
	},

    ["m9k_contender"] = {
		["Name"] = "[M9k] Thompson Contender G2",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_g2_contender.mdl",
		["Description"] = "description\n(Item ID: m9k_contender)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_contender") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_contender") if drop then ply:StripWeapon("m9k_contender")end  return drop end,
	},

    ["m9k_honeybadger"] = {
		["Name"] = "[M9k] AAC Honey Badger",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_aac_honeybadger.mdl",
		["Description"] = "description\n(Item ID: m9k_honeybadger)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_honeybadger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_honeybadger") if drop then ply:StripWeapon("m9k_honeybadger")end  return drop end,
	},

    ["m9k_mp5"] = {
		["Name"] = "[M9k] HK MP5",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_mp5.mdl",
		["Description"] = "description\n(Item ID: m9k_mp5)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp5") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5") if drop then ply:StripWeapon("m9k_mp5")end  return drop end,
	},

    ["m9k_mp7"] = {
		["Name"] = "[M9k] HK MP7",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_mp7_silenced.mdl",
		["Description"] = "description\n(Item ID: m9k_mp7)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp7") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp7") if drop then ply:StripWeapon("m9k_mp7")end  return drop end,
	},

    ["m9k_ump45"] = {
		["Name"] = "[M9k] HK UMP45",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_ump45.mdl",
		["Description"] = "description\n(Item ID: m9k_ump45)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_ump45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ump45") if drop then ply:StripWeapon("m9k_ump45")end  return drop end,
	},

    ["m9k_kac_pdw"] = {
		["Name"] = "[M9k] KAC PDW",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_kac_pdw.mdl",
		["Description"] = "description\n(Item ID: m9k_kac_pdw)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_kac_pdw") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_kac_pdw") if drop then ply:StripWeapon("m9k_kac_pdw")end  return drop end,
	},

    ["m9k_vector"] = {
		["Name"] = "[M9k] KRISS Vector",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_kriss_vector.mdl",
		["Description"] = "description\n(Item ID: m9k_vector)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_vector") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vector") if drop then ply:StripWeapon("m9k_vector")end  return drop end,
	},

    ["m9k_magpulpdr"] = {
		["Name"] = "[M9k] Magpul PDR",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_magpul_pdr.mdl",
		["Description"] = "description\n(Item ID: m9k_magpulpdr)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_magpulpdr") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_magpulpdr") if drop then ply:StripWeapon("m9k_magpulpdr")end  return drop end,
	},

    ["m9k_mp5sd"] = {
		["Name"] = "[M9k] MP5SD",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_hk_mp5sd.mdl",
		["Description"] = "description\n(Item ID: m9k_mp5sd)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp5sd") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5sd") if drop then ply:StripWeapon("m9k_mp5sd")end  return drop end,
	},

    ["m9k_mp9"] = {
		["Name"] = "[M9k] MP9",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_brugger_thomet_mp9.mdl",
		["Description"] = "description\n(Item ID: m9k_mp9)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_mp9") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp9") if drop then ply:StripWeapon("m9k_mp9")end  return drop end,
	},

    ["m9k_tec9"] = {
		["Name"] = "[M9k] TEC-9",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_intratec_tec9.mdl",
		["Description"] = "description\n(Item ID: m9k_tec9)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_tec9") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tec9") if drop then ply:StripWeapon("m9k_tec9")end  return drop end,
	},

    ["m9k_thompson"] = {
		["Name"] = "[M9k] Tommy Gun",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_tommy_gun.mdl",
		["Description"] = "description\n(Item ID: m9k_thompson)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_thompson") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_thompson") if drop then ply:StripWeapon("m9k_thompson")end  return drop end,
	},

    ["m9k_uzi"] = {
		["Name"] = "[M9k] UZI",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_uzi_imi.mdl",
		["Description"] = "description\n(Item ID: m9k_uzi)",
		["Weight"] = 0,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "m9k_uzi") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "m9k_uzi") if drop then ply:StripWeapon("m9k_uzi")end  return drop end,
	},



	["item_armor_jacket_leather"] = {
		["Name"] = "Leather Jacket",
		["Cost"] = 5000,
		["Model"] = "models/player/group03/male_07.mdl",
		["Description"] = "A number of stiff leather pads stitched into your suit, will protect you against cuts and bites but it won't stop a bullet\nProtection: 5%\nSpeed Penalty: 0\nAttachment Slots: 1\nBattery: 0\n(Item ID: item_armor_jacket_leather)",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_leather") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_leather") return drop end,

		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 5,    -- damage reduction in percentage
			["speedloss"] = 0,    -- speed loss in source units ( default player sprint speed: 300 (400 with maxed speed stat))
			["slots"] = 1, 	      -- attachment slots
			["battery"] = 0,      -- battery capacity, suits with 0 battery will only be able to use passive attachments
			["allowmodels"] = nil -- force the player to be one of these models, nil to let them choose from the default citizen models
		}
	},

	["item_armor_chainmail"] = {
		["Name"] = "Chainmail Suit",
		["Cost"] = 8500,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "A chainmail vest and leather pad combo that is worn underneath your oversuit\nProtection: 7.5%\nSpeed Penalty: 1\nAttachment Slots: 1\nBattery: 0\n(Item ID: item_armor_chainmail)",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_chain") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chain") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 7.5,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_jacket_bandit"] = {
		["Name"] = "Bandit Jacket",
		["Cost"] = 10000,
		["Model"] = "models/player/stalker/bandit_backpack.mdl",
		["Description"] = "A chainmail vest and leather pad combo that is worn underneath your oversuit\nProtection: 8%\nSpeed Penalty: 1\nAttachment Slots: 1\nBattery: 0\n(Item ID: item_armor_jacket_bandit)",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_jacket_bandit") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_jacket_bandit") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 8,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_backpack.mdl"}
		}
	},

	["item_armor_scrap"] = {
		["Name"] = "Scrap Armor",
		["Cost"] = 12500,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "A set of scrap metal attached to your suit via straps and clips, offers good protection for the price range but it's rather bulky and heavy\nProtection: 10%\nSpeed Penalty: 3\nAttachment Slots: 2\nBattery: 0\n(Item ID: item_armor_scrap)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 12.5,
			["speedloss"] = 35,
			["slots"] = 2,
			["battery"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_trenchcoat_brown"] = {
		["Name"] = "Brown Trenchcoat Armor",
		["Cost"] = 15000,
		["Model"] = "models/player/stalker/bandit_brown.mdl",
		["Description"] = "CHEEKI BREEKI! it may look like an old overcoat but there's actually a light flak jacket and leather padding under there that offers ok-ish protection\nProtection: 10%\nSpeed Penalty: 1\nAttachment Slots: 2\nBattery: 0\n(Item ID: item_armor_trenchcoat_brown)",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_brown") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_brown") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 10,
			["speedloss"] = 10,
			["slots"] = 2,
			["battery"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_brown.mdl"}
		}
	},

	["item_armor_trenchcoat_black"] = {
		["Name"] = "Black Trenchcoat Armor",
		["Cost"] = 20000,
		["Model"] = "models/player/stalker/bandit_black.mdl",
		["Description"] = "CHEEKI BREEKI! it may look like an old overcoat but there's actually a light flak jacket and leather padding under there that offers ok-ish protection\nProtection: 10%\nSpeed Penalty: 1\nAttachment Slots: 2\nBattery: 0\n(Item ID: item_armor_trenchcoat_black)",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 4,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_trenchcoat_black") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_trenchcoat_black") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 10,
			["slots"] = 2,
			["battery"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_black.mdl"}
		}
	},

	["item_armor_mercenary_guerilla"] = {
		["Name"] = "Guerilla Mercenary Armor",
		["Cost"] = 25000,
		["Model"] = "models/player/guerilla.mdl",
		["Description"] = "A flak jacket worn with various other garments. It provides a good mix of protection and mobility for an affordable price.\nProtection: 15%\nSpeed Penalty: 2\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_merc)",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_guerilla") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_guerilla") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/guerilla.mdl"}
		}
	},

	["item_armor_mercernary_arctic"] = {
		["Name"] = "Arctic Mercenary Armor",
		["Cost"] = 27500,
		["Model"] = "models/player/arctic.mdl",
		["Description"] = "A flak jacket worn with various other garments. It provides a good mix of protection and mobility for an affordable price.\nProtection: 15%\nSpeed Penalty: 2\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_merc)",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_arctic") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_arctic") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 15,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/arctic.mdl"}
		}
	},

	["item_armor_mercenary_leet"] = {
		["Name"] = "Leet Mercenary Armor",
		["Cost"] = 26000,
		["Model"] = "models/player/leet.mdl",
		["Description"] = "A flak jacket worn with various other garments. It provides a good mix of protection and mobility for an affordable price.\nProtection: 15%\nSpeed Penalty: 2\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_mercenary_leet)",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_leet") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_leet") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/leet.mdl"}
		}
	},

	["item_armor_mercenary_phoenix"] = {
		["Name"] = "Phoenix Mercenary Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/phoenix.mdl",
		["Description"] = "A flak jacket worn with various other garments. It provides a good mix of protection and mobility for an affordable price.\nProtection: 15%\nSpeed Penalty: 2\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_mercenary_phoenix)",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_mercenary_phoenix") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_mercenary_phoenix") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/phoenix.mdl"}
		}
	},

	["item_armor_police_gasmask"] = {
		["Name"] = "Police Gasmask Armor",
		["Cost"] = 35000,
		["Model"] = "models/player/gasmask.mdl",
		["Description"] = "Heavy riot gear used by swat teams and other special operations personnel.\nProtection: 17.5%\nSpeed Penalty: 5\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_police_gasmask)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_gasmask") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_gasmask") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 22.5,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/gasmask.mdl"}
		}
	},

	["item_armor_police_riot"] = {
		["Name"] = "Police Riot Armor",
		["Cost"] = 37000,
		["Model"] = "models/player/riot.mdl",
		["Description"] = "Heavy riot gear used by swat teams and other special operations personnel.\nProtection: 17.5%\nSpeed Penalty: 5\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_police_riot)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_riot") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_riot") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 25,
			["speedloss"] = 55,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/riot.mdl"}
		}
	},

	["item_armor_police_swat"] = {
		["Name"] = "Police SWAT Armor",
		["Cost"] = 36000,
		["Model"] = "models/player/swat.mdl",
		["Description"] = "Heavy riot gear used by swat teams and other special operations personnel.\nProtection: 17.5%\nSpeed Penalty: 5\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_police_swat)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_swat") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_swat") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 22.5,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/swat.mdl"}
		}
	},

	["item_armor_police_urban"] = {
		["Name"] = "Police Urban Armor",
		["Cost"] = 16000,
		["Model"] = "models/player/urban.mdl",
		["Description"] = "Heavy riot gear used by swat teams and other special operations personnel.\nProtection: 17.5%\nSpeed Penalty: 5\nAttachment Slots: 2\nBattery: 50\n(Item ID: item_armor_police_urban)",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_police_urban") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_police_urban") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 17.5,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/urban.mdl"}
		}
	},

	["item_armor_military_green"] = {
		["Name"] = "SKAT-9 Military Armor",
		["Cost"] = 60000,
		["Model"] = "models/player/stalker/military_spetsnaz_green.mdl",
		["Description"] = "A set of high end military armor.\nProtection: 17.5%\nSpeed Penalty: 3.5\nAttachment Slots: 2\nBattery: 100\n(Item ID: item_armor_military_green)",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_green") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_green") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 35,
			["speedloss"] = 45,
			["slots"] = 2,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_green.mdl"}
		}
	},

	["item_armor_military_black"] = {
		["Name"] = "SKAT-10 Military Armor",
		["Cost"] = 80000,
		["Model"] = "models/player/stalker/military_spetsnaz_black.mdl",
		["Description"] = "A set of very high end military armor.\nProtection: 17.5%\nSpeed Penalty: 3.5\nAttachment Slots: 2\nBattery: 100\n(Item ID: item_armor_military_black)",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_military_black") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military_black") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 40,
			["speedloss"] = 60,
			["slots"] = 2,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_black.mdl"}
		}
	},

	["item_armor_sunrise"] = {
		["Name"] = "Sunrise-5 Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/loner_vet.mdl",
		["Description"] = "A set of custom armor built by a veteran survivor.\nProtection: 30%\nSpeed Penalty: 3\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_sunrise)",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 30,
			["speedloss"] = 30,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/loner_vet.mdl"}
		}
	},

	["item_armor_sunrise_dolg"] = {
		["Name"] = "PSZ-9d Duty Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/duty_vet.mdl",
		["Description"] = "A set of custom armor built by a veteran survivor.\nProtection: 30%\nSpeed Penalty: 3\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_sunrise_dolg)",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_dolg") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_dolg") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 30,
			["speedloss"] = 30,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/duty_vet.mdl"}
		}
	},

	["item_armor_sunrise_svoboda"] = {
		["Name"] = "Wind of Freedom Suit",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/freedom_vet.mdl",
		["Description"] = "A set of custom armor built by a veteran survivor.\nProtection: 30%\nSpeed Penalty: 3\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_sunrise_svoboda)",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_svoboda") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_svoboda") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 30,
			["speedloss"] = 30,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/freedom_vet.mdl"}
		}
	},

	["item_armor_sunrise_monolith"] = {
		["Name"] = "Monolith Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/monolith_vet.mdl",
		["Description"] = "A set of sunrise armor that is used by Monolithians.\nProtection: 40%\nSpeed Penalty: 2\nAttachment Slots: 3\nBattery: 150\n(Item ID: item_armor_sunrise_monolith)",
		["Weight"] = 6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_sunrise_monolith") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_sunrise_monolith") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 40,
			["speedloss"] = 20,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/monolith_vet.mdl"}
		}
	},

	["item_armor_exo"] = {
		["Name"] = "Exoskeleton",
		["Cost"] = 200000,
		["Model"] = "models/player/stalker/loner_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 35%\nSpeed Penalty: 6\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_exo)",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 60,
			["speedloss"] = 100,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/loner_exo.mdl"}
		}
	},

	["item_armor_exo_merc"] = {
		["Name"] = "Mercenary Exoskeleton",
		["Cost"] = 200000,
		["Model"] = "models/player/stalker/merc_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 35%\nSpeed Penalty: 6\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_exo_merc)",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_merc") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_merc") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 60,
			["speedloss"] = 100,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/merc_exo.mdl"}
		}
	},

	["item_armor_exo_dolg"] = {
		["Name"] = "Duty Exoskeleton",
		["Cost"] = 200000,
		["Model"] = "models/player/stalker/duty_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 35%\nSpeed Penalty: 6\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_exo_dolg)",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_dolg") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_dolg") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 60,
			["speedloss"] = 100,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/duty_exo.mdl"}
		}
	},

	["item_armor_exo_svoboda"] = {
		["Name"] = "Freedom Exoskeleton",
		["Cost"] = 200000,
		["Model"] = "models/player/stalker/freedom_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 60%\nSpeed Penalty: 9\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_exo_svoboda)",
		["Weight"] = 12.5,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_svoboda") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_svoboda") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 60,
			["speedloss"] = 90,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/freedom_exo.mdl"}
		}
	},

	["item_armor_exo_monolith"] = {
		["Name"] = "Monolith Exoskeleton",
		["Cost"] = 200000,
		["Model"] = "models/player/stalker/monolith_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 35%\nSpeed Penalty: 6\nAttachment Slots: 3\nBattery: 100\n(Item ID: item_armor_exo_monolith)",
		["Weight"] = 15,
		["Supply"] = 0,
		["Rarity"] = 5,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo_monolith") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo_monolith") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 62.5,
			["speedloss"] = 100,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/monolith_exo.mdl"}
		}
	},

}


function UseFunc_Sleep(ply, bheal)
SendChat( ply, "You are now asleep" )
umsg.Start( "DrawSleepOverlay", ply )
umsg.End()
ply.Fatigue = 0
if bheal then
ply:SetHealth( ply:GetMaxHealth() )
end
end


function UseFunc_DropItem(ply, item)
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "ate_droppeditem" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:SetModel(ItemsList[item]["Model"])
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

return true

end


function UseFunc_DropArmor(ply, item) -- same as drop item but we don't want to set the dropped item to a playermodel do we?
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "ate_droppeditem" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

if ply.EquippedArmor == tostring(item) then
UseFunc_RemoveArmor(ply, item)
end

return true

end


function UseFunc_EquipArmor(ply, item)
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local used = ItemsList[item]

SendUseDelay( ply, 2 )

ply:EmitSound("npc/combine_soldier/zipline_hitground1.wav")

timer.Simple(2, function()
if !ply:IsValid() or !ply:Alive() then return false end
SystemMessage(ply, "You equipped "..used["Name"], Color(205,255,205,255), false)
ply.EquippedArmor = tostring(item)
ply:SetNWString("ArmorType", tostring(item))
RecalcPlayerModel( ply )
RecalcPlayerSpeed(ply)
end )


return false

end

function UseFunc_RemoveArmor(ply, item)
if !SERVER then return false end
if !ply:IsValid() then return false end

local used = ItemsList[item]

ply.EquippedArmor = "none"
ply:SetNWString("ArmorType", "none")
RecalcPlayerModel( ply )
RecalcPlayerSpeed(ply)

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
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "bed" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:Spawn()
EntDrop:Activate()
EntDrop.Owner = ply

for k, v in pairs(ents.FindByClass( "bed") ) do
	if v == EntDrop then continue end
	if !v.Owner:IsValid() or v.Owner == ply then v:Remove() end
end

return true

end


function UseFunc_EquipGun(ply, gun)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
	if ply:GetActiveWeapon() != gun then
		ply:Give( gun )
		ply:SelectWeapon( gun )
	end
return false
end

function UseFunc_EquipNade(ply, gun, nadetype)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
ply:GiveAmmo( 1, nadetype )
ply:Give( gun )

if ply:GetActiveWeapon() != gun then
	ply:SelectWeapon( gun )
end

return true
end

function UseFunc_GiveAmmo(ply, amount, type)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
	ply:GiveAmmo( amount, type )
return true
end


function UseFunc_Heal(ply, hp, infection, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
	if ply:Alive() then
			if ply:Health() >= ( ply:GetMaxHealth() ) and ply.Infection < 1 then SendChat( ply, "You are perfectly fine, using this item would be wasteful." ) return false end
			ply:SetHealth( math.Clamp( ply:Health() + (hp * ( 1 + (ply.StatMedSkill * 0.025) )), 0, ply:GetMaxHealth() ) )
			ply.Infection = math.Clamp( ply.Infection - (infection * 100), 0, 10000 )
			ply:EmitSound(snd, 100, 100)
			SendUseDelay( ply, 2 )
			return true
	else
		SendChat( ply, "You could have healed yourself, before you died." ) -- if they try to call this function when they are dead
		print(ply.StatMedSkill)
		return false
	end
end

function UseFunc_Armor(ply, armor, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
	if ply:Alive() then
			if ply:Armor() >= ply:GetMaxArmor() then SendChat( ply, "Your armor is already at full condition." ) return false end
			ply:SetArmor( math.Clamp( ply:Armor() + (armor * ( 1 + (ply.StatEngineer * 0.02) ) ), 0, 100 + ( ply.StatEngineer * 2 ) ) )
			ply:EmitSound(snd, 100, 100)
			SendUseDelay( ply, 2 )
			return true
	else
		SendChat( ply, "You could have charged your armor battery before you died!" )
		return false
	end
end

function UseFunc_Eat(ply, hunger, stamina, fatigue, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
	if ply:Alive() then
			if ply.Hunger > 9500 then SendChat( ply, "I am not hungry, I should save this for later." ) return false end
			ply.Hunger = math.Clamp( ply.Hunger + (hunger * 100), 0, 10000 )
			ply.Stamina = math.Clamp( ply.Stamina + stamina, 0, 100 )
			ply.Fatigue = math.Clamp( ply.Fatigue + (fatigue * 100), 0, 10000 )
			ply:EmitSound(snd, 100, 100)
			SendUseDelay( ply, 2 )
			return true
	else
		SendChat( ply, "Dead men have no use for food" ) -- if they try to call this function when they are dead
		return false
	end
end


function UseFunc_Respec(ply)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end

local refund = 0 + ply.StatPoints
ply.StatPoints = 0

for k, v in pairs( StatsListServer ) do
	local TheStatPieces = string.Explode( ";", v )
	local TheStatName = TheStatPieces[1]
	refund = refund + tonumber(ply[ TheStatName ])
	ply[ TheStatName ] = 0
end

ply.StatPoints = refund

ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
ply:SetMaxArmor( 100 + ( ply.StatEngineer * 2 ) )
RecalcPlayerSpeed(ply)

ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")

net.Start("UpdatePeriodicStats")
net.WriteFloat( ply.Level )
net.WriteFloat( ply.Money )
net.WriteFloat( ply.XP )
net.WriteFloat( ply.StatPoints )
net.WriteFloat( ply.Bounty )
net.Send( ply )

net.Start("UpdatePerks")
net.WriteFloat( ply.StatDefense )
net.WriteFloat( ply.StatDamage )
net.WriteFloat( ply.StatSpeed )
net.WriteFloat( ply.StatHealth )
net.WriteFloat( ply.StatKnowledge )
net.WriteFloat( ply.StatMedSkill )
net.WriteFloat( ply.StatStrength )
net.WriteFloat( ply.StatEndurance )
net.WriteFloat( ply.StatSalvage )
net.WriteFloat( ply.StatBarter )
net.WriteFloat( ply.StatEngineer )
net.WriteFloat( ply.StatImmunity )
net.WriteFloat( ply.StatSurvivor )
net.Send( ply )

SystemMessage(ply, "You consumed an amnesia pill and forgot everything you have learned. All skills are now set to 0 and stat points are refunded", Color(255,255,205,255), true)

return true

end

function UseFunc_AltRespec(ply)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end

local refund = 0 + ply.StatPoints
ply.StatPoints = 0

refund = refund + tonumber(ply.StatImmunity)

ply.StatPoints = refund

ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
ply:SetMaxArmor( 100 + ( ply.StatEngineer * 2 ) )
RecalcPlayerSpeed(ply)

ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")

net.Start("UpdatePeriodicStats")
net.WriteFloat( ply.Level )
net.WriteFloat( ply.Money )
net.WriteFloat( ply.XP )
net.WriteFloat( ply.StatPoints )
net.WriteFloat( ply.Bounty )
net.Send( ply )

net.Start("UpdatePerks")
net.WriteFloat( ply.StatDefense )
net.WriteFloat( ply.StatDamage )
net.WriteFloat( ply.StatSpeed )
net.WriteFloat( ply.StatHealth )
net.WriteFloat( ply.StatKnowledge )
net.WriteFloat( ply.StatMedSkill )
net.WriteFloat( ply.StatStrength )
net.WriteFloat( ply.StatEndurance )
net.WriteFloat( ply.StatSalvage )
net.WriteFloat( ply.StatBarter )
net.WriteFloat( ply.StatEngineer )
net.WriteFloat( ply.StatImmunity )
net.WriteFloat( ply.StatSurvivor )
net.Send( ply )

SystemMessage(ply, "You consumed an amnesia pill and forgot everything you have learned. All skills are now set to 0 and stat points are refunded", Color(255,255,205,255), true)

return true

end
