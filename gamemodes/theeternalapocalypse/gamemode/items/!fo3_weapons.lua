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
    Description = "Contains 50 alien power cells.",
    Cost = 380,
    Model = "models/tak/f3/other/alienpower_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "aliencellf3ammo",
    AmmoAmount = 50,
    ModOrigin = "Fallout 3"
})

GM:CreateItem("item_fo3ammo_apowermodule", {
    Name = "Alien Power Modules",
    Description = "Contains 100 alien power module cells.",
    Cost = 270,
    Model = "models/tak/f3/other/alienpower_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "alienmodulef3ammo",
    AmmoAmount = 100,
    ModOrigin = "Fallout 3"
})

GM:CreateItem("item_fo3ammo_energycell", {
    Name = "Energy Cells",
    Description = "Contains 50 energy cells.",
    Cost = 230,
    Model = "models/tak/f3/other/smallenergy_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "encellf3ammo",
    AmmoAmount = 100,
    ModOrigin = "Fallout 3"
})

GM:CreateItem("item_fo3ammo_microfusion", {
    Name = "Microfusion Cells",
    Description = "Contains 50 microfusion cells.",
    Cost = 210,
    Model = "models/tak/f3/other/microfusion_cell.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,

    AmmoType = "mfcellf3ammo",
    AmmoAmount = 50,
    ModOrigin = "Fallout 3"
})


----


GM:CreateItem("weapon_f332snubnose", {
    Name = ".32 Pistol",
    Description = "Are we rushin' in, or we going sneaky-beaky like?",
    Cost = 700,
    Model = "models/tak/f3/32_pistol.mdl",
    Weight = 1.4,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_f332snubnose",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f310mmpistol", {
    Name = "10mm Pistol",
    Description = "",
    Cost = 880,
    Model = "models/tak/f3/10mm_pistol.mdl",
    Weight = 1.08,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmpistol",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f310mmsmg", {
    Name = "10mm Submachine gun",
    Description = "",
    Cost = 1650,
    Model = "models/tak/f3/10mm_smg.mdl",
    Weight = 2.8,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmsmg",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3assaultrifle", {
    Name = "Assault Rifle",
    Description = "",
    Cost = 3650,
    Model = "models/tak/f3/w_r91.mdl",
    Weight = 3.78,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3assaultrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3bbgun", {
    Name = "BB Gun",
    Description = "it's fucking useless.",
    Cost = 350,
    Model = "models/tak/f3/w_bbgun.mdl",
    Weight = 0.68,
    Supply = -1,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3bbgun",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3chineseassaultrifle", {
    Name = "Chinese Assault Rifle",
    Description = "",
    Cost = 3100,
    Model = "models/tak/f3/w_type93.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3chineseassaultrifle",
    ModOrigin = "Fallout 3"
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
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3combatshotgun", {
    Name = "Combat Shotgun",
    Description = "",
    Cost = 6650,
    Model = "models/tak/f3/w_combat_shotgun.mdl",
    Weight = 3.85,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3combatshotgun",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3dartgun", {
    Name = "Dart Gun",
    Description = "also useless, just like BB Gun.",
    Cost = 650,
    Model = "models/tak/f3/w_dartgun.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3dartgun",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3doublebarrelshotgun", {
    Name = "Double Barrel shotgun",
    Description = "Double the barrel - double the fun!",
    Cost = 3500,
    Model = "models/tak/f3/w_double-barrel_shotgun.mdl",
    Weight = 2.8,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3doublebarrelshotgun",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3huntingrifle", {
    Name = "Hunting Rifle",
    Description = "For whoever likes to snipe the creatures from afar.",
    Cost = 5400,
    Model = "models/tak/f3/w_hunting_rifle.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3huntingrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3assaultrifle_infiltrator", {
    Name = "Infiltrator",
    Description = "",
    Cost = 7900,
    Model = "models/tak/f3/w_r91_infiltrator.mdl",
    Weight = 4.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3assaultrifle_infiltrator",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3leveractionrifle", {
    Name = "Lever-Action Rifle",
    Description = "",
    Cost = 3100,
    Model = "models/tak/f3/w_lever-action_rifle.mdl",
    Weight = 3.2,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3leveractionrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3leveractionrifle_lincoln", {
    Name = "Lincoln's Repeater",
    Description = "",
    Cost = 4800,
    Model = "models/tak/f3/w_lever-action_rifle.mdl",
    Weight = 3.6,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3leveractionrifle_lincoln",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3railwayrifle", {
    Name = "Railway Rifle",
    Description = "wtf is this rifle?",
    Cost = 2100,
    Model = "models/tak/f3/w_railwayrifle.mdl",
    Weight = 4.8,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3railwayrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3sawedoffshotgun", {
    Name = "Sawed-Off Shotgun",
    Description = "",
    Cost = 2850,
    Model = "models/tak/f3/w_sawed-off_shotgun.mdl",
    Weight = 2.2,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3sawedoffshotgun",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f344magnumrevolver", {
    Name = "Scoped .44 Magnum",
    Description = "",
    Cost = 2200,
    Model = "models/tak/f3/w_44magnum.mdl",
    Weight = 1.94,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f344magnumrevolver",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f310mmpistol_silenced", {
    Name = "Silenced 10mm Pistol",
    Description = "",
    Cost = 1350,
    Model = "models/tak/f3/w_10mm_pistol_silenced.mdl",
    Weight = 1.3,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f310mmpistol_silenced",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3sniperrifle", {
    Name = "Sniper Rifle",
    Description = "A sniper rifle.",
    Cost = 9000,
    Model = "models/tak/f3/w_sniper_rifle.mdl",
    Weight = 5.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3sniperrifle",
    ModOrigin = "Fallout 3"
})



-- Alien weapons


GM:CreateItem("weapon_f3alienatomizer", {
    Name = "Alien Atomizer",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_atomizer.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienatomizer",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3alienblaster", {
    Name = "Alien Blaster",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_blaster.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienblaster",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3aliendisintegrator", {
    Name = "Alien Disitengrator",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_disintegrator.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3aliendisintegrator",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3alienblaster_captain", {
    Name = "Captain's Sidearm",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_alien_blaster.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3alienblaster_captain",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3gaussrifle", {
    Name = "Gauss Rifle",
    Description = "One round projectile rifle does massive damage.",
    Cost = 24000,
    Model = "models/tak/f3/w_gauss_rifle.mdl",
    Weight = 6.8,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3gaussrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3laserpistol", {
    Name = "Laser Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_pistol.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserpistol",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3laserrifle", {
    Name = "Laser Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_rifle.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserrifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3plasmapistol", {
    Name = "Plasma Pistol",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_plasma_pistol.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3plasmapistol",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3plasmarifle", {
    Name = "Plasma Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_plasma_rifle.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3plasmarifle",
    ModOrigin = "Fallout 3"
})

GM:CreateItem("weapon_f3laserrifle_tribeam", {
    Name = "Tri-Beam Laser Rifle",
    Description = "",
    Cost = 1000,
    Model = "models/tak/f3/w_laser_rifle_tribeam.mdl",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "weapon_f3laserrifle_tribeam",
    ModOrigin = "Fallout 3"
})
