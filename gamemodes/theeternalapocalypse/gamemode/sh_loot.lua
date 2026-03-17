-- Loot tables

function GM:AddItemLootTable(tbl, rarity, class, qty)
	local t = {Class = class, Qty = qty}
	if tbl == self.LootTable then
		tbl[rarity].Items[#tbl[rarity].Items + 1] = t
	else
		tbl[#tbl+1] = t
	end

	return t
end


GM.LootTable = {
	[LOOTRARITY_COMMON] = {
		Rarity = 1,
		Items = {}
	},
	[LOOTRARITY_UNCOMMON] = {
		Rarity = 4,
		Items = {}
	},
	[LOOTRARITY_RARE] = {
		Rarity = 15,
		Items = {}
	},
	[LOOTRARITY_EPIC] = {
		Rarity = 75,
		Items = {}
	},
	[LOOTRARITY_LEGENDARY] = {
		Rarity = 500,
		Items = {}
	},
}
GM.LootTableBoss = {}
GM.LootTableFaction = {}

GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_bandage", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_medkit", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_antidote", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_soda", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_tinnedfood", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_melon", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_pistolammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_magammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_buckshotammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_rifleammo", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_m9k_smgammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_m9k_assaultammo", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "weapon_tea_pigsticker", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_scrap", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_chems", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "weapon_tea_grenade_pipe", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "weapon_tea_grenade_flare", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "weapon_tea_grenade_frag", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_COMMON, "item_craft_battery", 1)

GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_sleepingbag", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_armorbattery", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "weapon_tea_axe", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "weapon_tea_falcon", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "weapon_tea_dual", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_sniperammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_tv", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_beer", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "item_hamradio", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "weapon_tea_grenade_frag", 3)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "weapon_tea_807", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_UNCOMMON, "m9k_model500", 1)

GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "item_rocketammo", 2)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "item_armorkevlar", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "item_computer", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_scrapsword", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_grenade_frag", 5)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_shredder", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_satan", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_k8c", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_bosch", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "item_armor_jacket_leather", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_RARE, "weapon_tea_l303", 1)

GM:AddItemLootTable(GM.LootTable, LOOTRARITY_EPIC, "weapon_tea_blackhawk", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_EPIC, "weapon_tea_combinepistol", 1)

GM:AddItemLootTable(GM.LootTable, LOOTRARITY_LEGENDARY, "weapon_tea_ar2", 1)
GM:AddItemLootTable(GM.LootTable, LOOTRARITY_LEGENDARY, "m9k_mp7", 1)


GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_scar", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_minigun", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_scrapcrossbow", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_punisher", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_blackhawk", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "item_burger", 1)
GM:AddItemLootTable(GM.LootTableBoss, nil, "weapon_tea_germanator", 1)

GM:AddItemLootTable(GM.LootTableFaction, nil, "weapon_tea_perrin", 1)
GM:AddItemLootTable(GM.LootTableFaction, nil, "weapon_tea_winchester", 1)
GM:AddItemLootTable(GM.LootTableFaction, nil, "weapon_tea_dammerung", 1)
GM:AddItemLootTable(GM.LootTableFaction, nil, "item_money", 3000)


GM.AirdropLootTable = {}
GM.AirdropLootTable.Junk = {
	"item_junk_tin",
	"item_junk_boot",
	"item_junk_paper",
	"item_junk_doll",
	"item_junk_gardenpot",
	"item_junk_hula",
	"item_junk_nailbox",
	"item_junk_twig",
	"item_junk_paint",
	"item_junk_pot",
	"item_junk_keyboard",
}

GM.AirdropLootTable.Food = {
	"item_soda",
	"item_milk",
	"item_beerbottle",
	"item_tinnedfood",
	"item_potato",
	"item_traderfood",
	"item_trout",
	"item_melon",
	"item_donut",
	"item_energydrink",
	"item_energydrink_nonstop",

-- before, this was in tyrant weapons loot table, but this was too less to be worth it, so it was moved here.
	"item_hotdog",
}

GM.AirdropLootTable.Meds = {
	"item_bandage",
	"item_medkit",
	"item_armymedkit",
	"item_scientificmedkit",
	"item_antidote",
}

GM.AirdropLootTable.Sellables = {
	"item_radio",
	"item_scrap",
	"item_chems",
	"item_tv",
	"item_beer",
	"item_hamradio",
	"item_computer",
}

GM.AirdropLootTable.Ammo = {
	"item_pistolammo",
	"item_magammo",
	"item_buckshotammo",
	"item_rifleammo",
	"item_sniperammo",
	"item_rocketammo",
	"item_m9k_smgammo",
	"item_m9k_assaultammo",
	"item_m9k_sniperammo",
	"weapon_tea_grenade_flare",
	"weapon_tea_grenade_pipe",
	"weapon_tea_grenade_frag",
}

-- 100% to get one of the following weapons.
GM.AirdropLootTable.NewbieWeapons = {
	"weapon_tea_pigsticker",
	"weapon_tea_axe",
	"weapon_tea_wrench",
	"weapon_tea_g20",
	"weapon_tea_57",
	"weapon_tea_u45",
	"weapon_tea_python",
	"weapon_tea_grenade_frag",
--	"weapon_tea_grenade_molotov", --excluded due to causing crashes
}

-- the stuff you get from killing the tyrant boss
GM.AirdropLootTable.TyrantWeapons = {
	"weapon_tea_scar",
	"weapon_tea_minigun",
	"weapon_tea_scrapcrossbow",
	"weapon_tea_punisher",
	"weapon_tea_blackhawk",
	"weapon_tea_k8c",
	"weapon_tea_germanator",
	"item_burger",
}

-- faction weapons are acquired from destroying enemy faction bases
GM.AirdropLootTable.FactionWeapons = {
	"weapon_tea_perrin",
	"weapon_tea_winchester",
	"weapon_tea_dammerung",
	"m9k_ak47",
}

-- special weapons are acquired only from the airdrop and nothing else, rare chance to appear (airdrop-exclusive items)
GM.AirdropLootTable.SpecialWeapons = {
	"weapon_tea_crowbar", -- to get this thing you need to get lucky
	"weapon_tea_fuckinator",
}

-- Rare weapons, only 10% chance to get one of those
GM.AirdropLootTable.RareWeapons = {
	"weapon_tea_ar2",
	"m9k_vector",
	"m9k_mp9",
	"m9k_m3",
	"m9k_jackhammer",
}
