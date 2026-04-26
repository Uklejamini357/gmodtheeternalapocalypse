-- ARC9 Stalker2 weapons --
-- The real world models for these weren't made. They just used CS:S models. I don't understand why tho.
-- At the time of making this itemlist, ARC9 errors on client when initializing for the first time. This could potentially impact addon compatibility.
-- TEMPORARY FIX: Set cvar value of arc9_phystweak to 0.
-- addon: https://steamcommunity.com/sharedfiles/filedetails/?id=3394681012

GM:CreateItem("arc9_stalker2_ar_ak74", {
    Name = "AKM-74S",
    Description = "",
    Cost = 11585,
    Model = "models/weapons/w_rif_ak47.mdl",
    Material = "entities/arc9_stalker2_ar_ak74.png",
    Weight = 3,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_ak74",

    ArcCWCompatible = true -- Always use this for ArcCW/ARC9 weapons or you might have issues with infinite ammo stuff.
})


GM:CreateItem("arc9_stalker2_ar_m416", {
    Name = "AR416",
    Description = "",
    Cost = 21560,
    Model = "models/weapons/w_rif_m4a1.mdl",
    Material = "entities/arc9_stalker2_ar_m416.png",
    Weight = 3,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_m416",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_ar_val", {
    Name = "AS Lavina",
    Description = "",
    Cost = 19185,
    Model = "models/weapons/w_rif_galil.mdl",
    Material = "entities/arc9_stalker2_ar_val.png",
    Weight = 2.5,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_val",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_ar_dnipro", {
    Name = "Dnipro",
    Description = "",
    Cost = 15830,
    Model = "models/weapons/w_rif_m4a1.mdl",
    Material = "entities/arc9_stalker2_ar_dnipro.png",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_dnipro",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_ar_tar21", {
    Name = "Fora-221",
    Description = "",
    Cost = 13260,
    Model = "models/weapons/w_rif_famas.mdl",
    Material = "entities/arc9_stalker2_ar_tar21.png",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_tar21",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_ar_grom", {
    Name = "GROM S-14",
    Description = "",
    Cost = 18505,
    Model = "models/weapons/w_rif_ak47.mdl",
    Material = "entities/arc9_stalker2_ar_grom.png",
    Weight = 3.5,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_ar_grom",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_shot_boomstick", {
    Name = "Boomstick",
    Description = "",
    Cost = 1505,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Material = "entities/arc9_stalker2_shot_boomstick.png",
    Weight = 1.94,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_shot_boomstick",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_shot_m860", {
    Name = "M860 Cracker",
    Description = "",
    Cost = 8595,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Material = "entities/arc9_stalker2_shot_m860.png",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_shot_m860",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_shot_saiga", {
    Name = "Saiga D-12",
    Description = "",
    Cost = 12600,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Material = "entities/arc9_stalker2_shot_saiga.png",
    Weight = 3.6,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_shot_saiga",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_shot_spas", {
    Name = "SPSA-14",
    Description = "",
    Cost = 15205,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Material = "entities/arc9_stalker2_shot_spas.png",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_shot_spas",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_shot_toz", {
    Name = "TOZ-34",
    Description = "",
    Cost = 2650,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Material = "entities/arc9_stalker2_shot_toz.png",
    Weight = 3.3,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_shot_toz",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_pt_pm", {
    Name = "PTM",
    Description = "",
    Cost = 1430,
    Model = "models/weapons/w_pist_p228.mdl",
    Material = "entities/arc9_stalker2_pt_pm.png",
    Weight = 0.7,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_pt_pm",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_pt_rhino", {
    Name = "Rhino",
    Description = "",
    Cost = 8205
    Model = "models/weapons/w_pist_deagle.mdl", -- invisible model..
    Material = "entities/arc9_stalker2_pt_rhino.png",
    Weight = 1.7,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_pt_rhino",

    ArcCWCompatible = true
})


GM:CreateItem("arc9_stalker2_sr_gauss", {
    Name = "Gauss Rifle",
    Description = "Developed in the Zone and incorporating an electromagnetic bullet acceleration system, this sniper rifle is used exclusively within the Zone.",
    Cost = 64035,
    Model = "models/weapons/w_snip_awp.mdl",
    Material = "entities/arc9_stalker2_sr_gauss.png",
    Weight = 7,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arc9_stalker2_sr_gauss",

    ArcCWCompatible = true
})


