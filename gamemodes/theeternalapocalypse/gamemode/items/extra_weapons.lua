-- Weapons --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, {
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = category,
    UseFunc = function(ply) return false end,
    DropFunc = function(ply, item) return true end
})

]]

-- Ammo

i = GM:CreateItem("item_plasmaammo", {
    Cost = 500,
    Model = "models/items/combine_rifle_ammo01.mdl",
    Weight = 2.5,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    AmmoType = "ammo_plasmabomb",
    AmmoAmount = 20,
})


-- Following weapons not included in AtE, so they are included in this release


i = GM:CreateItem("weapon_tea_falcon", {
    Cost = 700,
    Model = "models/weapons/s_dmgf_co1911.mdl",
    Weight = 1.4,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_falcon",
})

i = GM:CreateItem("weapon_tea_spas", {
    Cost = 3500,
    Model = "models/weapons/w_shotgun.mdl",
    Weight = 3.6,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_spas",
})

i = GM:CreateItem("weapon_tea_lbr", {
    Cost = 8000,
    Model = "models/weapons/w_snip_m14sp.mdl",
    Weight = 3.8,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_lbr",
})


-- Other weapons from MAD Base

i = GM:CreateItem("weapon_tea_usp_match", {
    Cost = 950,
    Model = "models/weapons/w_pistol.mdl",
    Weight = 1.84,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_usp_match",
})

i = GM:CreateItem("weapon_tea_p228", {
    Cost = 665,
    Model = "models/weapons/w_pist_p228.mdl",
    Weight = 1.39,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_p228",
})

i = GM:CreateItem("weapon_tea_mp7", {
    Cost = 2150,
    Model = "models/weapons/w_smg1.mdl",
    Weight = 2.75,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_mp7",
})

i = GM:CreateItem("weapon_tea_mp7_elite", {
    Cost = 7350,
    Model = "models/weapons/w_smg1.mdl",
    Weight = 3.15,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_mp7_elite",
})

i = GM:CreateItem("weapon_tea_xm1014_elite", {
    Cost = 15000,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Weight = 4.84,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_xm1014_elite",
})

i = GM:CreateItem("weapon_tea_sg550", {
    Cost = 8500,
    Model = "models/weapons/w_snip_sg550.mdl",
    Weight = 5.60,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_sg550",
})

i = GM:CreateItem("weapon_tea_plasmamortar", {
    Cost = 85000,
    Model = "models/weapons/w_rocket_launcher.mdl",
    Weight = 14.27,
    Supply = 0,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_plasmamortar",
})


i = GM:CreateItem("weapon_tea_aug", {
    Cost = 9650,
    Model = "models/weapons/w_rif_aug.mdl",
    Weight = 5.15,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_aug",
})

i = GM:CreateItem("weapon_tea_awm", {
    Cost = 11140,
    Model = "models/weapons/w_snip_awp.mdl",
    Weight = 7.65,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_awm",
})
