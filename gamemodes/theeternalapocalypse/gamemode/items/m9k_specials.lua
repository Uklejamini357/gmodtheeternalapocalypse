-- M9k Weapons --
-- Don't add Prox Mines as it can be used to crash the server. Altho it hasn't been patched ever since.. for some reason

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, { -- It's necessary to use the Entity Classname here for the weapon.
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = ITEMCATEGORY_WEAPONS,
    UseFunc = function(ply) UseFunc_EquipGun(ply, itemid) return false end,
    DropFunc = function(ply, _, item) local drop = UseFunc_DropItem(ply, itemid) UseFunc_StripWeapon(ply, itemid, drop)
})

]]


-- Ammunition
/*
i = GM:CreateItem("item_m9k_smgammo", {
    Cost = 70,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "SMG1") return bool end,
})
*/

-- Specials


GM:CreateItem("m9k_davy_crockett", {
    Cost = 1e9,
    Model = "",
    Weight = 45.92,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_davy_crockett"
})

GM:CreateItem("m9k_ex41", {
    Cost = 176270,
    Model = "models/weapons/w_ex41.mdl",
    Weight = 5.25,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ex41"
})

GM:CreateItem("m9k_ied_detonator", {
    Cost = 28000,
    Model = "models/props_junk/cardboard_box004a.mdl",
    Weight = 1.15,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ied_detonator"
})

-- has buggy collision.
GM:CreateItem("m9k_m202", {
    Cost = 519245,
    Model = "models/weapons/w_m202.mdl",
    Weight = 15.36,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m202"
})

GM:CreateItem("m9k_m79gl", {
    Cost = 70465,
    Model = "models/weapons/w_m79_grenadelauncher.mdl",
    Weight = 4.51,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m79gl"
})

GM:CreateItem("m9k_matador", {
    Cost = 271850,
    Model = "models/weapons/w_gdcw_matador_rl.mdl",
    Weight = 13.05,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_matador"
})

GM:CreateItem("m9k_milkormgl", {
    Cost = 174290,
    Model = "models/weapons/w_milkor_mgl1.mdl",
    Weight = 8.35,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_milkormgl"
})

GM:CreateItem("m9k_nerve_gas", {
    Cost = 198350,
    Model = "models/weapons/w_grenade.mdl",
    Weight = 1.35,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_nerve_gas",

    ModelColor = Color(255,0,0)
})

GM:CreateItem("m9k_nitro", {
    Cost = 29580,
    Model = "models/weapons/w_nitro.mdl",
    Weight = 2.35,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_nitro"
})

GM:CreateItem("m9k_orbital_strike", {
    Cost = 1829355,
    Model = "models/weapons/w_binos.mdl",
    Weight = 0.55,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_orbital_strike"
})

GM:CreateItem("m9k_rpg7", {
    Cost = 185405,
    Model = "models/weapons/w_gdc_rpg7.mdl",
    Weight = 8.28,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_rpg7"
})

GM:CreateItem("m9k_sticky_grenade", {
    Cost = 6940,
    Model = "models/weapons/w_sticky_grenade_thrown.mdl",
    Weight = 0.95,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_sticky_grenade"
})

GM:CreateItem("m9k_suicide_bomb", {
    Cost = 64035,
    Model = "models/weapons/w_sb_planted.mdl",
    Weight = 6.01,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_suicide_bomb"
})

