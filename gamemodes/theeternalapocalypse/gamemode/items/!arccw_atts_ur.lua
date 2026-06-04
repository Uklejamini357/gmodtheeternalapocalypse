-- Urban Renewal attachments
-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2906702282

GM:CreateItem("arccw_acwatt_ur_1911_cal_10auto", {
    Name = "Delta Elite 10mm Auto Conversion",
    Description = [[The FBI's preferred caliber of choice.
Despite its distinctive power, it's not as large as .45 ACP, though its damage curve is more balanced.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_cal_10auto"
})

GM:CreateItem("arccw_acwatt_ur_1911_cal_9mm", {
    Name = "SR1911 9x19mm Parabellum Conversion",
    Description = "A popular alternative caliber to .45 ACP. With a reduced diameter, the round achieves greater muzzle velocity and magazine capacity.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/9x19.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_cal_9mm"
})

GM:CreateItem("arccw_acwatt_ur_1911_grip_pachmayr", {
    Name = "M1911 Pachmayr Grip",
    Description = [[Aftermarket grip with finger grooves and a pleasant rosewood texture.
The finger grooves steadies aim, but is a bit slower to draw.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/grip_pach.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_grip_pachmayr"
})

GM:CreateItem("arccw_acwatt_ur_1911_grip_snake", {
    Name = "M1911 Snake Grip",
    Description = [[A gaudy grip for those with too much taste and those with too little taste. Made from genuine rattlesnake skin.
Its rough texture marginally reduces moving spread.

"Whoever did this is a professional, no question. This thing could shoot a one-hole at 25 yards in a machine rest."]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/grip_snake.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_grip_snake"
})

GM:CreateItem("arccw_acwatt_ur_1911_mag_ext", {
    Name = "AMAS 11-Round Extended Magazine",
    Description = "A higher capacity magazine increases the time you can spend without reloading.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/mag11.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_mag_ext"
})

GM:CreateItem("arccw_acwatt_ur_1911_slide_compact", {
    Name = "Colt Officer's Model 3.5\" Slide",
    Description = "A shortened slide reduces the amount of holster to clear and further improves agility to the detriment of long-range performance and recoil control.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/slide_compact.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_slide_compact"
})

GM:CreateItem("arccw_acwatt_ur_1911_slide_compact_custom", {
    Name = "Colt Officer's Model 3.5\" Slide w/ Custom Finish",
    Description = [[A shortened slide reduces the amount of holster to clear and further improves agility to the detriment of long-range performance and recoil control.

This variant will use your configured custom color for that extra flair.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/slide_compact.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_slide_compact_custom"
})

GM:CreateItem("arccw_acwatt_ur_1911_slide_m45", {
    Name = "M45 MEUSOC 5\" Slide",
    Description = [[Modernized slide, hammer and trigger assembly designed and hand-built for the U.S. Marine Corps, bringing an old gun to a new age.
Improves handling and ballistics, but is worse when hip fired.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/slide_45tan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_slide_m45"
})

GM:CreateItem("arccw_acwatt_ur_1911_slide_m45_custom", {
    Name = "M45 MEUSOC 5\" Slide w/ Custom Finish",
    Description = [[Modernized slide, hammer and trigger assembly designed and hand-built for the U.S. Marine Corps, bringing an old gun to a new age.
Improves handling and ballistics, but is worse when hip fired.

This variant will use your configured custom color for that extra flair.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_1911/slide_45.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_1911_slide_m45_custom"
})

GM:CreateItem("arccw_acwatt_ur_329_barrel_m29", {
    Name = "6\" Model 29 Barrel",
    Description = "Extended barrel that provides extra counterweight in addition to marginal ballistic enhancements.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_329_barrel_m29.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_329_barrel_m29"
})

GM:CreateItem("arccw_acwatt_ur_329_barrel_master", {
    Name = "7\" Master Barrel",
    Description = "Huge, imposing barrel with extra frontal weight and precision rifling. Hard to keep steady, but hones accuracy even further.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_329_barrel_master.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_329_barrel_master"
})

GM:CreateItem("arccw_acwatt_ur_329_caliber_44special", {
    Name = "Model 329PD .44 Special Chambering",
    Description = "A shorter length cartridge with lower recoil but reduced stopping power.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/44special.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_329_caliber_44special"
})

GM:CreateItem("arccw_acwatt_ur_329_caliber_snakeshot", {
    Name = "Model 329PD .44 Snakeshot Chambering",
    Description = [[Rounds containing small lead shots. Due to bullet diameter and barrel length, this round has an extremely low effective range.
As its name implies, it's mostly useful for shooting snakes and rodents only.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/44special.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_329_caliber_snakeshot"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_105", {
    Name = "AK-105 12\" Carbine Barrel",
    Description = "Reduced length barrel that serves as a middle ground between full-size and SMG-length barrels. Reduces weight and profile while keeping the weapon accurate and controllable.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/105.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_105"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_krinkov", {
    Name = "AKS-74U 8\" Compact Barrel",
    Description = [[Special carbine length handguard and barrel. Its reduced length leads to less unwieldiness, and the shortened gas system increases cyclic rate respectably.
These traits combined, however, result in a difficult weapon to control.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/aksu.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_krinkov"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_rpk", {
    Name = "RPK 23\" SAW Barrel",
    Description = [[Light machine gun barrel as used on the RPK. In addition to improved precision from the elongated barrel, it features an integrated bipod which can be deployed for even greater accuracy and control.
Very front-heavy due to the long, more massive barrel.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/rpk.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_rpk"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_t56", {
    Name = "Type 56 16\" Bayonet Barrel",
    Description = "Chinese derivative barrel with a fully hooded front sight and a folding spike bayonet. When unfolded, the bayonet increases melee damage substantially, but adds some forward weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/type.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_t56"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_vepr", {
    Name = "Vepr 20\" Marksman Barrel",
    Description = "Long civilian hunting barrel. Improved performance at range, but fires much slower.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/vepr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_vepr"
})

GM:CreateItem("arccw_acwatt_ur_ak_barrel_vityaz", {
    Name = "PP-19 9\" SMG Barrel",
    Description = "Submachine gun barrel with a rail interface for additional modularity. More lightweight than the compact barrel, but confers more recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/barrel/smg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_barrel_vityaz"
})

GM:CreateItem("arccw_acwatt_ur_ak_cal_366", {
    Name = "VPO-209 .366 TKM Receiver",
    Description = "Hunting round based on 7.62x39mm, with more powerful ranged ballistics than the parent cartridge. Weapons chambered for it are exclusively produced for the Russian civilian market, and are therefore semi-automatic only.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/762x39.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cal_366"
})

GM:CreateItem("arccw_acwatt_ur_ak_cal_545", {
    Name = "AK-74 5.45x39mm Receiver",
    Description = "Lighter, more accurate cartridge that maintains wounding potential up close, but lacks penetration.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/545x39.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cal_545"
})

GM:CreateItem("arccw_acwatt_ur_ak_cal_556", {
    Name = "AK-101 5.56x45mm NATO Receiver",
    Description = [[Designed for the export market, this receiever uses the NATO standard 5.56x45mm cartridge.
The smaller round yields a higher muzzle velocity and accuracy at range with similiar wounding potential to 5.45x39mm, but with a slower cyclic rate.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/556x45.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cal_556"
})

GM:CreateItem("arccw_acwatt_ur_ak_cal_9mm", {
    Name = "PP-19 Vityaz 9x19mm Parabellum Receiver",
    Description = "Converts the weapon to a submachine gun. The smaller caliber drastically reduces recoil, but has much less range and is less accurate.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/9x19.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cal_9mm"
})

GM:CreateItem("arccw_acwatt_ur_ak_charm_tl", {
    Name = "Tactical Laser Position",
    Description = "Give your AN/PEQ a reason to be thin.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/aksidemount.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_charm_tl"
})

GM:CreateItem("arccw_acwatt_ur_ak_cover_alpha", {
    Name = "Alpha AK Dust Cover",
    Description = "Alternative US-made dust cover with an upper picattiny rail.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/dustcover_alpha.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cover_alpha"
})

GM:CreateItem("arccw_acwatt_ur_ak_cover_smooth", {
    Name = "Smooth Dust Cover",
    Description = "Early dust cover with a smooth profile. Realistically down to preference.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/dustcover_ribbed.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cover_smooth"
})

GM:CreateItem("arccw_acwatt_ur_ak_cover_truniun_rail", {
    Name = "Trunnion Sight Mount",
    Description = "Picatinny rail mounted on trunnion sights",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/dustcover_mount.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_cover_truniun_rail"
})

GM:CreateItem("arccw_acwatt_ur_ak_grip_alpha", {
    Name = "Helix Polymer Grip",
    Description = "Rough US-made polymer grip, prodiving a bit more sighted mobility.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/grip_helix.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_grip_alpha"
})

GM:CreateItem("arccw_acwatt_ur_ak_grip_type3", {
    Name = "Vintage Grip",
    Description = "Original pistol grip with a rougher, heavier shape.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/grip_3.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_grip_type3"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_74m", {
    Name = "Polymer Handguard",
    Description = "Light polymer handguard with superior agility, but higher recoil from the reduced counterweight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/handguards/poly.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_74m"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_alpha", {
    Name = "AK Zenitco Aluminum Handguard",
    Description = "Fancy Russian-made handguard featuring a rail interface for additional modularity. Especially lightweight, though less comfortable to grip.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/handguards/alpha.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_alpha"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_dong", {
    Name = "\"Romanian Dong\" Integral Foregrip",
    Description = "Romanian lower handguard design, shaped into an integrated foregrip.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/dong.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_dong"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_rpk74m", {
    Name = "Polymer SAW Handguard",
    Description = "Light polymer handguard used on the RPK-74M. Its additional grooves makes it a bit steadier to hold.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/handguards/rpk.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_rpk74m"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_type3", {
    Name = "Type 3 Vintage Handguard",
    Description = "Lacks grip protrusions, reducing grip surface but enhancing agility.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/handguards/vintage.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_type3"
})

GM:CreateItem("arccw_acwatt_ur_ak_hg_vepr", {
    Name = "Heavy Handguard",
    Description = "Bottom-heavy marksman handguard. Hard to handle, but steady and accurate. Does not have a bottom rail, and thus cannot accept underbarrel attachments.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/handguards/vepr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_hg_vepr"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_545_45", {
    Name = "45-Round Extended Mag",
    Description = "Extended magazine for the AK-74. While intended for squad gunners, the extra ammo is useful for any loadout, though the longer mag is noticeably heavier.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/545_45.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_545_45"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_545_black", {
    Name = "30-Round Black Bakelite Mag",
    Description = "Identical to the stock magazine, spray-painted black. Might suit your taste better.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/545_30_b.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_545_black"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_762_10", {
    Name = "AK-47 10-Round Compact Mag",
    Description = "Sporting purpose magazine with a very low capacity. The lighter load reduces the weapon's weight significantly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/366_10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_762_10"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_762_75", {
    Name = "AK-47 75-Round Drum Mag",
    Description = "Cylindrical drum magazine with capacity for a very large number of rounds, ideal for machine gunners. It is heavy enough to shift the weapon's center of mass, disorienting recoil control in addition to the existing drawbacks of extreme weight. Prone to feeding failures.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/762_75.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_762_75"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_762_bakelite", {
    Name = "30-Round Bakelite Mag",
    Description = "Plastic variant of the standard issue magazine. Might suit your taste better.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/762_b.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_762_bakelite"
})

GM:CreateItem("arccw_acwatt_ur_ak_mag_762_pmag", {
    Name = "PMAG 30 AK/AKM MOE",
    Description = "American aftermarket magazine. The grooves give it a slightly better grip surface, but the difference in practice is negligible.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/magazines/762_p.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_mag_762_pmag"
})

GM:CreateItem("arccw_acwatt_ur_ak_muzzle_ak74", {
    Name = "100 Series Compensator",
    Description = "Modernized compensator produced for AKs of multiple calibers.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/muzzle_74m.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_muzzle_ak74"
})

GM:CreateItem("arccw_acwatt_ur_ak_muzzle_bayonet", {
    Name = "Type 2 Bayonet",
    Description = "External bayonet unique to early AK-pattern rifles. Wide and sharp, it's a bit bulky but allows for a devastating melee attack.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/acwatt_ur_ak_muzzle_bayonet.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_muzzle_bayonet"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_ak74m", {
    Name = "AK Polymer Stock",
    Description = [[Full side-folding stock. While extended, it functions similarly to a standard wood stock, albeit with less stability.
Folding the stock boosts mobility and recoil, though not as significantly as skeletal folding stocks.

Toggling this stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/n.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_ak74m"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_aks", {
    Name = "AK Sidefolding Stock",
    Description = [[Side-folding stock found since the 74 series' debut. The triangular structure reduces its compromise on stability, but it is still less effective than a fixed stock. Folding the stock provides massively boosted maneuverability at the cost of severe recoil.

Toggling this stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/fold.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_aks"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_alpha", {
    Name = "AK SOPMOD Stock",
    Description = "US-made lightweight stock that mounts on an AR buffer tube. More maneuverable than the solid wood stock.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/helix.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_alpha"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_rpk", {
    Name = "AK Clubfoot Stock",
    Description = "Heavy-duty machine gun stock, designed with prone shooting in mind. It has more mass than the factory stock, but is generally more comfortable to aim and shoot with.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/rpk.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_rpk"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_type3", {
    Name = "Type 3 Slanted Stock",
    Description = "A solid, slanted stock that eases handling. The slant design has a lowered cheek rest, which can impede accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/3.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_type3"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_underfolder", {
    Name = "AK Underfolding Stock",
    Description = [[Folding stock of the AKS-47. While not as stable as a full wood stock, it is much lighter. Folding the stock provides massively boosted maneuverability at the cost of severe recoil.

Toggling this stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/under.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_underfolder"
})

GM:CreateItem("arccw_acwatt_ur_ak_stock_vepr", {
    Name = "AK Thumbhole Stock",
    Description = "Marksman stock with integrated grip. The thumbhole design provides unparalleled stability.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_ak/stock/vepr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_ak_stock_vepr"
})

GM:CreateItem("arccw_acwatt_ur_aw_barrel_long", {
    Name = "AW 27\" Magnum Barrel",
    Description = "Lengthened fluted-steel barrel used with high-caliber setups for enhanced muzzle velocity and recoil reduction.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/bar_long.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_barrel_long"
})

GM:CreateItem("arccw_acwatt_ur_aw_barrel_sd", {
    Name = "AWS 28\" Suppressed Barrel",
    Description = [[Integrally suppressed barrel for the Arctic Warfare, designed for use with subsonic ammunition. Very effective for noise reduction, but reduces effective range.
Incompatible with magnum ammunition.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/bar_sup.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_barrel_sd"
})

GM:CreateItem("arccw_acwatt_ur_aw_barrel_short", {
    Name = "AT 20\" Shortened Barrel",
    Description = "Custom-tooled \"close-quarters\" barrel that compromises long-range performance, but reduces forward weight significantly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/bar_short.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_barrel_short"
})

GM:CreateItem("arccw_acwatt_ur_aw_cal_300", {
    Name = "AWM .300 Winchester Magnum Receiver",
    Description = "Versatile magnum cartridge identical in diameter to 7.62x51mm rounds but with significantly higher muzzle energy. Liable to overpenetration at close range.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/300winchester.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_cal_300"
})

GM:CreateItem("arccw_acwatt_ur_aw_cal_338", {
    Name = "AWM .338 Lapua Magnum Receiver",
    Description = "Powerful sniper cartridge that exerts substantially more muzzle energy, practically guaranteed to be fatal on a successful hit beyond point blank. The recoil is tremendous, and the lengthened bolt required to accommodate the cartridge is harder to cycle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/338lapua.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_cal_338"
})

GM:CreateItem("arccw_acwatt_ur_aw_mag_10", {
    Name = "AW 10-Round Extended Mag",
    Description = "Extended magazine for the Arctic Warfare. The extra rounds add weight to the magazine, but allow for twice as many shots to be taken between reloads.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/mag308_10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_mag_10"
})

GM:CreateItem("arccw_acwatt_ur_aw_mag_10m", {
    Name = "AWM .300 10-Round Extended Mag",
    Description = "Extended magazine for the Arctic Warfare. The extra rounds add weight to the magazine, but allow for twice as many shots to be taken between reloads.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/mag338_10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_mag_10m"
})

GM:CreateItem("arccw_acwatt_ur_aw_muzzle_brake", {
    Name = "AI Muzzle Brake",
    Description = "Light muzzle brake unique to the AW platform.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/muzzle.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_muzzle_brake"
})

GM:CreateItem("arccw_acwatt_ur_aw_muzzle_brake_sights", {
    Name = "AI Ironsight Brake",
    Description = [[Light muzzle brake unique to the AW platform.

Equips alternative "compact" iron sights.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/muzzle_sights.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_muzzle_brake_sights"
})

GM:CreateItem("arccw_acwatt_ur_aw_skin_black", {
    Name = "Black Finish",
    Description = "As used by law enforcement, or those lacking a father figure.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/skin_black.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_skin_black"
})

GM:CreateItem("arccw_acwatt_ur_aw_skin_custom", {
    Name = "Custom Finish",
    Description = "A customizable finish. Let your imagination run wild.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/skin_rainbow.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_skin_custom"
})

GM:CreateItem("arccw_acwatt_ur_aw_skin_tan", {
    Name = "Flat Dark Earth Finish",
    Description = "The fury of the sandstorm, realized.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/skin_tan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_skin_tan"
})

GM:CreateItem("arccw_acwatt_ur_aw_stock_at", {
    Name = "Tactical Stock",
    Description = "Variant folding stock with a pistol grip design. Lighter and perhaps more comfortable, but not as sturdy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/stock_at.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_stock_at"
})

GM:CreateItem("arccw_acwatt_ur_aw_stock_fixed", {
    Name = "Fixed Stock",
    Description = "Variant, one-piece stock without a hinge for folding. More rigid than side-folding stocks, but the lack of folding makes it harder to conceal.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/stock_nonfold.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_stock_fixed"
})

GM:CreateItem("arccw_acwatt_ur_aw_stock_ru", {
    Name = "Magpul UBR GEN2 Stock",
    Description = "Polymer stock designed for assault rifles. Unstable, but provides much-needed mobility.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/stock_ru.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_stock_ru"
})

GM:CreateItem("arccw_acwatt_ur_aw_stock_ru_rubber", {
    Name = "Magpul UBR GEN2 Stock (Rubberized)",
    Description = "Polymer stock designed for assault rifles. Rubber accents reduce the impact on aim sway, but weigh the stock down.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_aw/stock_rurubber.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_aw_stock_ru_rubber"
})

GM:CreateItem("arccw_acwatt_ur_dbs_barrel_compact", {
    Name = "IZh-58 18\" Coach Gun Barrel",
    Description = "Named for use by private guards aboard stagecoaches in the Wild West, its short length is ideal for small rooms, though not quite as ideal at any longer distances.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_dbs/bcomp.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_dbs_barrel_compact"
})

GM:CreateItem("arccw_acwatt_ur_dbs_barrel_mid", {
    Name = "IZh-58 22\" Trimmed Barrel",
    Description = "Take off just a bit of the barrel for an edge in close-quarters while maintaining as much performance as possible.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_dbs/bmid.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_dbs_barrel_mid"
})

GM:CreateItem("arccw_acwatt_ur_dbs_barrel_sawedoff", {
    Name = "IZh-58 12\" Sawed-off Barrel",
    Description = "Sawed-off barrel, often associated with outlaws. Enhances portability and looks the part for hunting unholy creatures.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_dbs/bsw.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_dbs_barrel_sawedoff"
})

GM:CreateItem("arccw_acwatt_ur_dbs_barrel_sawedoffplus", {
    Name = "IZh-58 10\" Jury-rigged Barrel",
    Description = "So cut down that you need a custom handguard to go with it. Reduces the weapon to a pistol-like profile, ruining accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_dbs/bswp.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_dbs_barrel_sawedoffplus"
})

GM:CreateItem("arccw_acwatt_ur_dbs_fg_extractor", {
    Name = "Custom Extractor",
    Description = "Install a heavy aftermarket extractor to speeden reloads.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_dbs_fg_extractor"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_annihilator", {
    Name = "6.75\" Desert Eagle Annihilator Barrel",
    Description = "Heavily modified barrel with gilded parts and an oversized integral muzzle brake. Effects are exacerbated, and the sheer volume of vented gas can get disorienting.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_annihilator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_annihilator"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_compact", {
    Name = "5.5\" Desert Eagle Compact Barrel",
    Description = "Aftermarket reduced barrel that enhances concealability and ergonomics at the cost of ranged performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_compact.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_compact"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_compen", {
    Name = "6\" Desert Eagle Compensated Barrel",
    Description = "Barrel with an integral muzzle brake. Redirects propellant gases to stabilize the weapon's heavy recoil, but the reduced volume of gas directed to the bolt mechanism results in a lower cyclic rate.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_compensated.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_compen"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_ext", {
    Name = "7\" Desert Eagle Extended Barrel",
    Description = "Slightly extended barrel that provides extra counterweight in addition to marginal ballistic enhancements.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_long.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_ext"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_marksman", {
    Name = "10\" Desert Eagle Marksman Barrel",
    Description = "Elongated barrel for niche mid-range roles. Especially front-heavy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_police.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_marksman"
})

GM:CreateItem("arccw_acwatt_ur_deagle_barrel_modern", {
    Name = "6\" Desert Eagle Mark XIX Barrel",
    Description = "Variation of the factory barrel with a built-in Weaver attachment mount.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_barrel_modern.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_barrel_modern"
})

GM:CreateItem("arccw_acwatt_ur_deagle_caliber_357", {
    Name = "Desert Eagle .357 Magnum Conversion",
    Description = "A more practical caliber with higher capacity magazines and actually manageable recoil, but not as much raw power.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/357magnum.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_caliber_357"
})

GM:CreateItem("arccw_acwatt_ur_deagle_caliber_410", {
    Name = "Desert Eagle .410 Bore Conversion",
    Description = "Hobbyist conversion that allows the weapon to accept .410 bore shotgun shells. Because the weapon was never meant to fire these, performance beyond point blank is poor.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/20g.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_caliber_410"
})

GM:CreateItem("arccw_acwatt_ur_deagle_caliber_44", {
    Name = "Desert Eagle .44 Magnum Conversion",
    Description = "Smaller (comparatively speaking) caliber that retains most of .50 AE's iconic punch, but is small enough to fit an extra round in the magazine.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/44magnum.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_caliber_44"
})

GM:CreateItem("arccw_acwatt_ur_deagle_grip_rubber", {
    Name = "Desert Eagle Rubberized Grip",
    Description = "Creates higher friction against the shooter's hands, dampening recoil slightly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_grip_rubber.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_grip_rubber"
})

GM:CreateItem("arccw_acwatt_ur_deagle_grip_wood", {
    Name = "Desert Eagle Wooden Grip",
    Description = "Premium and hand-carved. Classy and smooth, but more difficult to grip.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_grip_plastic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_grip_wood"
})

GM:CreateItem("arccw_acwatt_ur_deagle_mag_10", {
    Name = "Desert Eagle 10-Round Extended Magazine",
    Description = "A higher capacity magazine increases the time you can spend without reloading. However, the extra rounds add even more weight to an already unwieldy weapon.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_mag_10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_mag_10"
})

GM:CreateItem("arccw_acwatt_ur_deagle_skin_black", {
    Name = "Desert Eagle Matte Black Finish",
    Description = [[The finish of choice for assassins and agents everywhere.

"We're willing to wipe the slate clean, give you a fresh start. All that we're asking in return is your cooperation in bringing a known terrorist to justice."]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_finish_black.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_skin_black"
})

GM:CreateItem("arccw_acwatt_ur_deagle_skin_chrome", {
    Name = "Desert Eagle Polished Chrome Finish",
    Description = [[A luster that demands attention.

"I had to kill Bob Morton because he made a mistake. Now it's time to erase that mistake."]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_finish_chrome.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_skin_chrome"
})

GM:CreateItem("arccw_acwatt_ur_deagle_skin_gold", {
    Name = "Desert Eagle Titanium Gold Finish",
    Description = [[Look, you're already using a Desert Eagle, so we might as well gut whatever sense of modesty you have left.

"The time has come to show our true strength. They underestimate our resolve. Let us show that we do not fear them. As one people, we shall free our brethren from the yoke of foreign oppression!"]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_finish_gold.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_skin_gold"
})

GM:CreateItem("arccw_acwatt_ur_deagle_skin_modern", {
    Name = "Desert Eagle Two-Tone Finish",
    Description = [[Double trouble. Yin and yang. Call it whatever you like; it will remain an ornate look for an ornate man.

"You ever hear the old saying, 'the enemy of my enemy is my friend?'"]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_finish_modern.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_skin_modern"
})

GM:CreateItem("arccw_acwatt_ur_deagle_skin_sex", {
    Name = "The Ultimate",
    Description = [[Administrator powers not included.

"This is an extremely OP admin weapon. fires every .05 seconds, 75 bullets per shot, and no recoil..... it's awesome.

Right click spawns rapid fire explosions"]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_finish_sex.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_skin_sex"
})

GM:CreateItem("arccw_acwatt_ur_deagle_tritium", {
    Name = "Tritium Night Sights",
    Description = "A set of luminescent iron sights for use in low-lit conditions.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_deagle_tritium.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_deagle_tritium"
})

GM:CreateItem("arccw_acwatt_ur_g3_barrel_12", {
    Name = "G3KA4 12\" Carbine Barrel",
    Description = "Shortened barrel for the carbine variant of the rifle. Improves both fire rate and handling.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/barrel_k.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_barrel_12"
})

GM:CreateItem("arccw_acwatt_ur_g3_barrel_15", {
    Name = "HK33A2 15\" Assault Barrel",
    Description = "Standard barrel for the intermediate carbine variant of the rifle. Improves weapon handling while marginally reducing range.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/barrel_33.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_barrel_15"
})

GM:CreateItem("arccw_acwatt_ur_g3_barrel_26", {
    Name = "PSG-1 26\" Sniper Barrel",
    Description = [[Long barrel and handguard assembly for the sniper variant of the rifle. Reduces fire rate, but enhances ranged performance greatly.
Designed purely for long range usage, this barrel lacks a front sight post.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/barrel_psg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_barrel_26"
})

GM:CreateItem("arccw_acwatt_ur_g3_barrel_8", {
    Name = "HK51 8\" Compact Barrel",
    Description = [[Ridiculously short aftermarket barrel. Colloquially known as a "flashbang dispenser," the tiny barrel drastically increases fire rate - for better and for worse.

The reduced dimensions are compatible with some MP5 furniture.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/barrel_51.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_barrel_8"
})

GM:CreateItem("arccw_acwatt_ur_g3_hg_pica", {
    Name = "RIS Handguard",
    Description = "A handguard with three picatinny rails extending down the barrel, enabling higher modularity.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/hg_pica.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_hg_pica"
})

GM:CreateItem("arccw_acwatt_ur_g3_hg_slim", {
    Name = "Slim Handguard",
    Description = "Alternative factory handguard influenced by older models. Lighter than the bulkier standard, but more difficult to brace.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/hg_slim.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_hg_slim"
})

GM:CreateItem("arccw_acwatt_ur_g3_mag_10", {
    Name = "G3 10-Round Marksman Mag",
    Description = "Magazine with a very low capacity. The lighter load reduces the weapon's weight significantly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/mag10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_mag_10"
})

GM:CreateItem("arccw_acwatt_ur_g3_mag_20_556", {
    Name = "HK33 20-Round Compact Mag",
    Description = "Low-capacity magazine for the 5.56 variant of the rifle. The lighter load makes the weapon more ergonomic.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/mag556_20.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_mag_20_556"
})

GM:CreateItem("arccw_acwatt_ur_g3_mag_40_556", {
    Name = "HK33 40-Round Extended Mag",
    Description = "Extended magazine for the 5.56 variant of the rifle. Though very reliable, its oblong design makes it awkward to load.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/mag556_40.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_mag_40_556"
})

GM:CreateItem("arccw_acwatt_ur_g3_mag_50", {
    Name = "G3 50-Round Drum Mag",
    Description = "50 round drum-style magazine. Though highly cumbersome and unreliable, it more than doubles the standard capacity of the rifle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/mag50.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_mag_50"
})

GM:CreateItem("arccw_acwatt_ur_g3_optic_psg1", {
    Name = "Hensoldt ZF 6x42 PSG1",
    Description = [[Long range combat scope for precision shooting.
Exclusive to the G3 pattern rifle.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_g3_optic_psg1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_optic_psg1"
})

GM:CreateItem("arccw_acwatt_ur_g3_optic_sg1", {
    Name = "Zeiss Diavari DA 1.5-6x Sniper Scope",
    Description = [[Variable power scope, adjustable for a very wide range of magnifications.
Exclusive to the G3 pattern rifle.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ur_g3_optic_sg1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_optic_sg1"
})

GM:CreateItem("arccw_acwatt_ur_g3_rec_hk33", {
    Name = "HK33 5.56x45mm Receiver",
    Description = "Receiver and barrel group that accepts an intermediate cartridge, changing the weapon into an assault rifle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/rec_33.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_rec_hk33"
})

GM:CreateItem("arccw_acwatt_ur_g3_rec_psg", {
    Name = "PSG-1 Receiver",
    Description = "Infamously expensive semi-automatic receiver. Comes with sublime long-range performance and a comfortable wooden grip that improves handling.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/rec_psg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_rec_psg"
})

GM:CreateItem("arccw_acwatt_ur_g3_skin_custom", {
    Name = "G3 Custom Furniture",
    Description = [[Custom color furniture. 

(Note: Do not let a gun purist see this.)]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/skin_cust.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_skin_custom"
})

GM:CreateItem("arccw_acwatt_ur_g3_skin_olive", {
    Name = "G3 Olive Drab Furniture",
    Description = "Olive drab furniture; less official but more iconic.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/skin_oliva.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_skin_olive"
})

GM:CreateItem("arccw_acwatt_ur_g3_skin_tan", {
    Name = "G3 Flat Dark Earth Furniture",
    Description = "FDE furniture for the two-tone tacticool feel... or desert operations.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/skin_fde.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_skin_tan"
})

GM:CreateItem("arccw_acwatt_ur_g3_skin_wood", {
    Name = "G3 CETME Wooden Furniture",
    Description = "Old-fashioned wooden furniture that makes you feel like the apocalypse is near.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/skin_wood.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_skin_wood"
})

GM:CreateItem("arccw_acwatt_ur_g3_stock_collapsible", {
    Name = "G3 Collapsible Stock",
    Description = [[Lightweight collapsable stock that significantly shortens the rifle when collapsed. Though sturdy for a collapsing stock, acquiring a proper cheek weld is practically impossible, and its felt recoil reduction is poor.

Toggling the stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/stock_colap.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_stock_collapsible"
})

GM:CreateItem("arccw_acwatt_ur_g3_stock_psg", {
    Name = "PSG-1 Sniper Stock",
    Description = "Heavy-duty marksman stock made for the sniper variant of the rifle. Cumbersome, but very comfortable to shoot with.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/stock_psg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_stock_psg"
})

GM:CreateItem("arccw_acwatt_ur_g3_stock_rucar", {
    Name = "Magpul UBR GEN2 Stock",
    Description = "AR-style buffer tube adapter fit with an adjustable aftermarket stock. Improves weapon control on the move, but lacks weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/stock_ar.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_stock_rucar"
})

GM:CreateItem("arccw_acwatt_ur_g3_stock_sg", {
    Name = "G3 Padded Stock",
    Description = "Padded stock found on the marksman rifle variant of the rifle. The cheek padding reduces sway but weighs the stock down.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_g3/stock_sg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_g3_stock_sg"
})

GM:CreateItem("arccw_acwatt_ur_mp5_barrel_eod", {
    Name = "11\" EOD Barrel",
    Description = [[Extended barrel and handguard assembly with a massive integrated muzzle brake to protect underbarrel weapons.
Decreases muzzle rise, but performs poorly when hip firing.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/upper_eod.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_barrel_eod"
})

GM:CreateItem("arccw_acwatt_ur_mp5_barrel_kurz", {
    Name = "4.5\" Kurz Upper",
    Description = [[Machine pistol variant with a maximally compact barrel and a lightened bolt assembly for increased cyclic rate.
Mid-range accuracy is poor, and recoil is noticibly increased.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/upper_k.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_barrel_kurz"
})

GM:CreateItem("arccw_acwatt_ur_mp5_barrel_sd", {
    Name = "13\" Schalldämpfer Barrel",
    Description = [[Large, specialized integral suppressor for the MP5.
Muzzle velocity is reduced, resulting in an extremely quiet report but reduced effective range.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/upper_sd.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_barrel_sd"
})

GM:CreateItem("arccw_acwatt_ur_mp5_barrel_sword", {
    Name = "9\" Swordfish Upper",
    Description = "Aftermarket upper receiver that aggressively counters recoil using an integrated compensator. The added weight makes the weapon harder to aim with.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/upper_fish.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_barrel_sword"
})

GM:CreateItem("arccw_acwatt_ur_mp5_caliber_10auto", {
    Name = "MP5/10 10mm Auto Conversion",
    Description = [[The FBI's preferred caliber of choice.
Significantly more powerful, but with reliability issues, and weapon handling suffers.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/10.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_caliber_10auto"
})

GM:CreateItem("arccw_acwatt_ur_mp5_caliber_22lr", {
    Name = "MP5 .22 LR Conversion",
    Description = [[A semi-automatic civilian model of the MP5 rechambered in .22 Long Rifle.
The low lethality of the cartridge makes this unfit for tactical operations, but far more fun to plink with.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/22lr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_caliber_22lr"
})

GM:CreateItem("arccw_acwatt_ur_mp5_caliber_40sw", {
    Name = "MP5/40 .40 Smith & Wesson Conversion",
    Description = [[Law-enforcement caliber with a slightly larger bullet and shorter case.
Retains damage over distance better than other calibers.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/uc_bullets/40sw.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_caliber_40sw"
})

GM:CreateItem("arccw_acwatt_ur_mp5_caliber_noburst", {
    Name = "MP5A3 SEF Receiver",
    Description = "Vintage receiver that lacks the Navy receiver's three-round burst fire mode. Its grooved grip is more comfortable to hold.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/sef.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_caliber_noburst"
})

GM:CreateItem("arccw_acwatt_ur_mp5_caliber_semi", {
    Name = "SP5 Sporter Receiver",
    Description = "A semi-automatic receiver sold in civilian markets. Designed for sport shooting, this receiver is more accurate and lightweight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/grip.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_caliber_semi"
})

GM:CreateItem("arccw_acwatt_ur_mp5_mag_15", {
    Name = "MP5 15-Round Flush Mag",
    Description = "Low-capacity magazine. The lighter load makes the weapon even more ergonomic.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/mag20.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_mag_15"
})

GM:CreateItem("arccw_acwatt_ur_mp5_mag_50", {
    Name = "MP5 50-Round Drum Magazine",
    Description = "Drum magazine with a 50-round capacity. Compact and reliable as far as drum magazines come, but still prone to jamming and ergonomics problems.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/mag50.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_mag_50"
})

GM:CreateItem("arccw_acwatt_ur_mp5_optic_alt", {
    Name = "Closed Irons",
    Description = [[Closed iron sights with a smaller field of view, potentially increasing user precision.
In reality, it's all preference.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/altirons.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_optic_alt"
})

GM:CreateItem("arccw_acwatt_ur_mp5_optic_mount", {
    Name = "M1913 Mount",
    Description = [[An optics mount, hold the optics.
"Worry not, my friend, for in the world of video games the weight of picatinny rails cannot hurt you."]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/somemount.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_optic_mount"
})

GM:CreateItem("arccw_acwatt_ur_mp5_stock_a3", {
    Name = "MP5A3 Retractable Stock",
    Description = [[Retractable skeletal stock, signficantly less massive than solid polymer. It can be collapsed to reduce profile even further at the cost of stability.

Toggling the stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/stock_colap.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_stock_a3"
})

GM:CreateItem("arccw_acwatt_ur_mp5_stock_future", {
    Name = "MP5 \"Swordfish\" Futuristic Stock",
    Description = [[Plastic-polymer stock with a telescoping buttstock and adjustable cheek riser. Though these features make for much situational adaptability, recoil control suffers as a result of the light construction.

Toggling the stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/stock_fish.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_stock_future"
})

GM:CreateItem("arccw_acwatt_ur_mp5_stock_pdw", {
    Name = "MP5K PDW Folding Stock",
    Description = [[Light polymer "personal defense weapon" stock. Ideal for point shooting due to its conventional shape. It can be folded to reduce profile even further at the cost of recoil.

Toggling the stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/stock_pdw.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_stock_pdw"
})

GM:CreateItem("arccw_acwatt_ur_mp5_stock_ump", {
    Name = "UMP Style B&T Folding Stock",
    Description = [[Folding stock derived from a later submachine gun pattern by the same manufacturer. Its wide buttpad reduces horizontal recoil at the cost of mobility and aim speed. 

Toggling the stock modifies performance accordingly.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/stock_ump.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_stock_ump"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_classic", {
    Name = "Slim Handguard",
    Description = "Early rounded handguard, lighter than the current iteration but more difficult to brace.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_slim.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_classic"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_kurzgrip", {
    Name = "VFG-K Handguard",
    Description = "The iconic handguard for the Kurz machine pistol variant, featuring a stubby foregrip and handstop that make the shortened SMG much more comfortable and controllable.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_k.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_kurzgrip"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_mlok", {
    Name = "MP5 M-LOK Handguard",
    Description = "American aftermarket handguard. Lighter than the basic, polymer handguard it replaces, improving handling, but somewhat unwieldy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_moe.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_mlok"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_ris", {
    Name = "RIS Handguard",
    Description = "Alternative handguard with a tacticool picatinny rail interface. Does not have any tacticool benefits.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_pica.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_ris"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_surefire", {
    Name = "MP5 Surefire Handguard",
    Description = "Alternative handguard with an integrated flashlight and a wider grip.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_flash.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_surefire"
})

GM:CreateItem("arccw_acwatt_ur_mp5_ub_surefire_mlok", {
    Name = "Sherlock Handguard",
    Description = [[Alternative handguard with an integrated flashlight and M-LOK pattern attachment points.

Functionally identical to the Surefire Handguard.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_mp5/hg_flash_mlok.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_mp5_ub_surefire_mlok"
})

GM:CreateItem("arccw_acwatt_ur_spas12_barrel_hl", {
    Name = "21.5\" Freeman Barrel",
    Description = [[Futuristic fire control group and barrel accomodation that supports slamfire and a near-instant, gas-powered two-round burst. However, the original dual-mode mechanism is replaced.

The two-round burst can shred most targets, but depletes ammo quickly. The complicated mechanism also has a heavier pump.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_spas/barrel_std.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_spas12_barrel_hl"
})

GM:CreateItem("arccw_acwatt_ur_spas12_barrel_short", {
    Name = "18\" SPAS-12 Compact Barrel",
    Description = "Rare short barrel intended for breaching and close quarters use. Noticeably increases pellet spread, but is easier to manuver.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_spas/barrel_short.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_spas12_barrel_short"
})

GM:CreateItem("arccw_acwatt_ur_spas12_charm_rail", {
    Name = "Modern Rail Mount",
    Description = "As if this thing wasn't imposing enough.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_spas/modernmount.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_spas12_charm_rail"
})

GM:CreateItem("arccw_acwatt_ur_spas12_stock_full", {
    Name = "SPAS-12 Fixed Polymer Stock",
    Description = "Solid, non-adjustable polymer stock designed specifically for the civilian market. Provides a better brace at the cost of combat mobility.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_spas/stock_full.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_spas12_stock_full"
})

GM:CreateItem("arccw_acwatt_ur_spas12_tube_reduced", {
    Name = "SPAS-12 6 Shell Tube",
    Description = "Shortened shell tube that holds fewer rounds, but reduces weapon weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/ur_spas/magsmall.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ur_spas12_tube_reduced"
})

