-- FALLOUT 3 Weapons --

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

-- i = GM:CreateItem("item_plasmaammo", {
--     Cost = 500,
--     Model = "models/items/combine_rifle_ammo01.mdl",
--     Weight = 2.5,
--     Supply = 0,
--     Rarity = RARITY_EPIC,
--     Category = ITEMCATEGORY_AMMO,
--     ItemType = ITEMTYPE_AMMO,
--     AmmoType = "ammo_plasmabomb",
--     AmmoAmount = 20,
-- })


-- Following weapons not included in AtE, so they are included in this release


GM:CreateItem("item_fo3ammo_apowercell", {
    Name = "Alien Power Cells",
    Description = "",
    Cost = 190,
    Model = "models/tak/f3/other/microfusion_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "aliencellf3ammo",
    AmmoAmount = 50,
})

GM:CreateItem("item_fo3ammo_apowermodule", {
    Name = "Alien Power Modules",
    Description = "",
    Cost = 190,
    Model = "models/tak/f3/other/microfusion_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "alienmodulef3ammo",
    AmmoAmount = 50,
})

GM:CreateItem("item_fo3ammo_energycell", {
    Name = "Energy Cells",
    Description = "",
    Cost = 190,
    Model = "models/tak/f3/other/microfusion_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "encellf3ammo",
    AmmoAmount = 100,
})

GM:CreateItem("item_fo3ammo_microfusion", {
    Name = "Microfusion Cells",
    Description = "Contains 50 microfusion cells.",
    Cost = 190,
    Model = "models/tak/f3/other/microfusion_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "mfcellf3ammo",
    AmmoAmount = 50,
})


----


GM:CreateItem("weapon_f332snubnose", {
    Name = ".32 Pistol",
    Description = "Are we rushin' in, or we going sneaky-beaky like?",
    Cost = 700,
    Model = "models/tak/f3/32_pistol.mdl",
    Weight = 1.4,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_f332snubnose",
})

GM:CreateItem("weapon_f310mmpistol", {
    Name = "10mm Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/10mm_pistol.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmpistol",
})

GM:CreateItem("weapon_f310mmsmg", {
    Name = "10mm Submachine gun",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/10mm_smg.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmsmg",
})

GM:CreateItem("weapon_f3assaultrifle", {
    Name = "Assault Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_r91.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3assaultrifle",
})

GM:CreateItem("weapon_f3bbgun", {
    Name = "BB Gun",
    Description = "",
    Cost = 350,
    Model = "models/tak/f3/w_bbgun.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3bbgun",
})

GM:CreateItem("weapon_f3chineseassaultrifle", {
    Name = "Chinese Assault Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_type93.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3chineseassaultrifle",
})

GM:CreateItem("weapon_f3mauser", {
    Name = "Chinese Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_mauser.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3mauser",
})

GM:CreateItem("weapon_f3combatshotgun", {
    Name = "Combat Shotgun",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_combat_shotgun.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3combatshotgun",
})

GM:CreateItem("weapon_f3dartgun", {
    Name = "Dart Gun",
    Description = "",
    Cost = 650,
    Model = "models/tak/f3/w_dartgun.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3dartgun",
})

GM:CreateItem("weapon_f3doublebarrelshotgun", {
    Name = "Double Barrel shotgun",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_double-barrel_shotgun.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3doublebarrelshotgun",
})

GM:CreateItem("weapon_f3huntingrifle", {
    Name = "Hunting Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_hunting_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3huntingrifle",
})

GM:CreateItem("weapon_f3assaultrifle_infiltrator", {
    Name = "Infiltrator",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_r91_infiltrator.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3assaultrifle_infiltrator",
})

GM:CreateItem("weapon_f3leveractionrifle", {
    Name = "Lever-Action Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_lever-action_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3leveractionrifle",
})

GM:CreateItem("weapon_f3leveractionrifle_lincoln", {
    Name = "Lincoln's Repeater",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_lever-action_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3leveractionrifle_lincoln",
})

GM:CreateItem("weapon_f3railwayrifle", {
    Name = "Railway Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_railwayrifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3railwayrifle",
})

GM:CreateItem("weapon_f3sawedoffshotgun", {
    Name = "Sawed-Off Shotgun",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_sawed-off_shotgun.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3sawedoffshotgun",
})

GM:CreateItem("weapon_f344magnumrevolver", {
    Name = "Scoped .44 Magnum",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_44magnum.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f344magnumrevolver",
})

GM:CreateItem("weapon_f310mmpistol_silenced", {
    Name = "Silenced 10mm Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_10mm_pistol_silenced.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmpistol_silenced",
})

GM:CreateItem("weapon_f3sniperrifle", {
    Name = "Sniper Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_sniper_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3sniperrifle",
})



-- Alien weapons


GM:CreateItem("weapon_f3alienatomizer", {
    Name = "Alien Atomizer",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_atomizer.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienatomizer",
})

GM:CreateItem("weapon_f3alienblaster", {
    Name = "Alien Blaster",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_blaster.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienblaster",
})

GM:CreateItem("weapon_f3aliendisintegrator", {
    Name = "Alien Disitengrator",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_disintegrator.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3aliendisintegrator",
})

GM:CreateItem("weapon_f3alienblaster_captain", {
    Name = "Captain's Sidearm",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_blaster.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienblaster_captain",
})

GM:CreateItem("weapon_f3gaussrifle", {
    Name = "Gauss Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_gauss_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3gaussrifle",
})

GM:CreateItem("weapon_f3laserpistol", {
    Name = "Laser Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_pistol.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserpistol",
})

GM:CreateItem("weapon_f3laserrifle", {
    Name = "Laser Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserrifle",
})

GM:CreateItem("weapon_f3plasmapistol", {
    Name = "Plasma Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_plasma_pistol.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3plasmapistol",
})

GM:CreateItem("weapon_f3plasmarifle", {
    Name = "Plasma Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_plasma_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3plasmarifle",
})

GM:CreateItem("weapon_f3laserrifle_tribeam", {
    Name = "Tri-Beam Laser Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_rifle_tribeam.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserrifle_tribeam",
})
