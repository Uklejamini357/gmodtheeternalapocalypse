-- Counter Strike + Attachments
-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2131058270

GM:CreateItem("arccw_acwatt_ammo_api", {
    Name = "Fire and Brimstone",
    Description = "Load weapon with armor-piercing incendiary ammo, which deals extra damage, ignites targets within its effective range, and has superior penetration. However, due to reliability issues, reduced-capacity magazines are used.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_api.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_api"
})

GM:CreateItem("arccw_acwatt_ammo_blank", {
    Name = "Blanks",
    Description = "Cartridges which contain no bullet and only emit a loud bang and muzzle flash. Completely incapable of doing harm.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_blank.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_blank"
})

GM:CreateItem("arccw_acwatt_ammo_dragon", {
    Name = "Dragon's Breath",
    Description = "Incendiary load shotgun shells deal extra damage at both close and long range, as well as igniting targets within its effective range. However, a reduced magazine is equipped.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_dragon.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_dragon"
})

GM:CreateItem("arccw_acwatt_ammo_frangible", {
    Name = "Hollow Point",
    Description = "Bullets with a frangible hollow tip penetrating far less, but have better stopping power up-close.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_frangible.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_frangible"
})

GM:CreateItem("arccw_acwatt_ammo_lowpower", {
    Name = "Reduced Load",
    Description = "Rounds with a low-power charge. Reduces kick, but also reduces stopping power.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_lowpower.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_lowpower"
})

GM:CreateItem("arccw_acwatt_ammo_magnum", {
    Name = "Magnum Buckshot",
    Description = "Powerful overloaded rounds deal extra damage at close range, but at the cost of increased recoil, spread, and long-range damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_magnum.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_magnum"
})

GM:CreateItem("arccw_acwatt_ammo_match", {
    Name = "Match Ammo",
    Description = "High-quality competition-grade ammunition. Consistent power loads allow for greater accuracy. Custom-tooled bullets cut rifling more smoothly and keep energy for longer. Such bullets cannot be used in bulk.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_match.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_match"
})

GM:CreateItem("arccw_acwatt_ammo_ricochet", {
    Name = "Cornerfragger",
    Description = "Bullets ricochet off surfaces once, and gain increased damage when doing so. Specialized bullet head reduces damage and makes penetration impossible. More of a revolver technique.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_ricochet.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_ricochet"
})

GM:CreateItem("arccw_acwatt_ammo_rpg7_he", {
    Name = "RPG-7 High Explosive",
    Description = "Load high explosive rockets that have a greater splash radius but no HEAT jet, reducing impact damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_rpg7_he.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_rpg7_he"
})

GM:CreateItem("arccw_acwatt_ammo_rpg7_smoke", {
    Name = "RPG-7 Smokescreen",
    Description = "Smoke rockets that produce a wide smokescreen on impact. Also does light damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_rpg7_smoke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_rpg7_smoke"
})

GM:CreateItem("arccw_acwatt_ammo_rpg7_tandem", {
    Name = "RPG-7 Tandem Warhead",
    Description = "Load tandem shaped charge warheads that have excellent direct hit damage but very poor splash damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_rpg7_he.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_rpg7_tandem"
})

GM:CreateItem("arccw_acwatt_ammo_sabot", {
    Name = "Sabot Slug",
    Description = "Shell containing a subcaliber projectile with discarding sabot. This enables superior muzzle velocity on the armor-piercing projectile, allowing it to deal more damage at range and penetrate a lot of armor. However, it is not as powerful as a full-caliber slug round.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_sabot.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_sabot"
})

GM:CreateItem("arccw_acwatt_ammo_slug", {
    Name = "Deer Slug",
    Description = "Shell containing a single heavy lead slug. More accurate, and more effective at range, but at the cost of being only a single projectile.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_slug.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_slug"
})

GM:CreateItem("arccw_acwatt_ammo_tmj", {
    Name = "Total Metal Jacket",
    Description = "Bullets with a total copper coating which keep energy better at long range, improving damage at distance but overpenetrating targets which are too close.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ammo_tmj.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ammo_tmj"
})

GM:CreateItem("arccw_acwatt_bipod", {
    Name = "Bipod",
    Description = "Bipod can be deployed by pressing +USE while in an eligible spot. While deployed, the user's aiming angle is limited and recoil is reduced to near-zero. Moving will release bipod. While not in use, the bipod negatively impacts weapon maneuverability.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_bipod.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "bipod"
})

GM:CreateItem("arccw_acwatt_fcg_accelerator", {
    Name = "Accelerator",
    Description = "Firemode conversion that increases fire rate the longer you shoot, up to 7 shots. Includes 14-round burst.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_accelerator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_accelerator"
})

GM:CreateItem("arccw_acwatt_fcg_auto", {
    Name = "Automatic",
    Description = "Firemode conversion allowing for full-auto and semi-auto fire modes.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_auto.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_auto"
})

GM:CreateItem("arccw_acwatt_fcg_burst", {
    Name = "Burst",
    Description = "Firemode conversion allowing for 3-round burst and semi-auto fire modes.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_burst.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_burst"
})

GM:CreateItem("arccw_acwatt_fcg_double", {
    Name = "Double Stuff",
    Description = "Fire system that can fit one extra round in the chamber at a time through esoteric mechanical magic.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_double.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_double"
})

GM:CreateItem("arccw_acwatt_fcg_hyper", {
    Name = "Hyper-Burst",
    Description = "Firemode conversion allowing for a rapid two-round 'hyper burst' mode that fires both bullets in extremely rapid succession. Extra mechanical complexity increases weight and reduces effective precision.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_hyper.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_hyper"
})

GM:CreateItem("arccw_acwatt_fcg_regulator", {
    Name = "Regulator",
    Description = "Fire control device that allows the selection of varying fire rates.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_regulator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_regulator"
})

GM:CreateItem("arccw_acwatt_fcg_semi", {
    Name = "Semi",
    Description = "Firemode conversion which allows only semi-auto fire.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_semi.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_semi"
})

GM:CreateItem("arccw_acwatt_fcg_sputter", {
    Name = "Sputter",
    Description = "Firemode conversion designed to circumvent early machine gun regulations by making the gun fire continuously until empty.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_fcg_sputter.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "fcg_sputter"
})

GM:CreateItem("arccw_acwatt_foregrip_angled", {
    Name = "Angled Foregrip",
    Description = "Angled foregrip which enables superior agility, at the cost of recoil control due to a harder-to-grip surface.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_foregrip_angled.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "foregrip_angled"
})

GM:CreateItem("arccw_acwatt_foregrip_cqc", {
    Name = "CQC Foregrip",
    Description = "Foregrip allowing for superior strafe speed and hip fire accuracy at the cost of recoil control and sight speed.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_foregrip_cqc.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "foregrip_cqc"
})

GM:CreateItem("arccw_acwatt_foregrip_pistol", {
    Name = "Light Foregrip",
    Description = "Lightweight pistol-style foregrip. Improves recoil marginally.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_foregrip_pistol.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "foregrip_pistol"
})

GM:CreateItem("arccw_acwatt_foregrip_stubby", {
    Name = "Stubby Foregrip",
    Description = "Short foregrip which provides good stability while moving as well as helping stabilize recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_foregrip_stubby.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "foregrip_stubby"
})

GM:CreateItem("arccw_acwatt_foregrip_vertical", {
    Name = "Vertical Foregrip",
    Description = "Attachable foregrip for long guns.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_foregrip_vertical.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "foregrip_vertical"
})

GM:CreateItem("arccw_acwatt_grip_ergo", {
    Name = "Ergo Grip",
    Description = "Ergonomic grip improves effective recoil control at the cost of moving accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_grip_ergo.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "grip_ergo"
})

GM:CreateItem("arccw_acwatt_grip_rubberized", {
    Name = "Rubberized Grip",
    Description = "Rubberized grip improves movement accuracy, but reduces agility.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_grip_rubberized.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "grip_rubberized"
})

GM:CreateItem("arccw_acwatt_grip_smooth", {
    Name = "Smooth Grip",
    Description = "Smooth grip improves agility at the cost of recoil control.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_grip_smooth.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "grip_smooth"
})

GM:CreateItem("arccw_acwatt_grip_sturdy", {
    Name = "Sturdy Grip",
    Description = "Sturdy grip that allows for better hip fire accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_grip_sturdy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "grip_sturdy"
})

GM:CreateItem("arccw_acwatt_laser_compact", {
    Name = "Compact Laser",
    Description = "Small lightweight laser for pistols. Red beam assists with aiming from the hip. Not as powerful as a bright laser.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_laser_compact.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "laser_compact"
})

GM:CreateItem("arccw_acwatt_muzz_booster", {
    Name = "Muzzle Booster",
    Description = "Muzzle device which boosts exhaust gases in order to increase fire rate. Doing so increases felt recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_booster.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_booster"
})

GM:CreateItem("arccw_acwatt_muzz_brake", {
    Name = "Muzzle Brake",
    Description = "Muzzle device that aggressively fights recoil by sending exhaust gases upward to combat muzzle rise. Improves vertical recoil, but makes recoil less stable. Also increases weapon report.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_brake.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_brake"
})

GM:CreateItem("arccw_acwatt_muzz_breacher", {
    Name = "Breaching Device",
    Description = "Heavy muzzle device with spiked front that increases melee damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_breacher.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_breacher"
})

GM:CreateItem("arccw_acwatt_muzz_choke", {
    Name = "Tight Choke",
    Description = "Shotgun choke which reduces pellet spread, at the cost of directly worsening clump dispersion while hip firing. Also increases felt recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_choke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_choke"
})

GM:CreateItem("arccw_acwatt_muzz_circlechoke", {
    Name = "Concentric Choke",
    Description = "Shotgun choke producing a circular pattern which is hollow in the middle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_circlechoke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_circlechoke"
})

GM:CreateItem("arccw_acwatt_muzz_compensator", {
    Name = "Compensator",
    Description = "Muzzle device which redirects exhaust gases in order to improve the consistency of felt recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_compensator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_compensator"
})

GM:CreateItem("arccw_acwatt_muzz_crosschoke", {
    Name = "Cross Choke",
    Description = "Shotgun choke producing a cross-shaped pattern.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_crosschoke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_crosschoke"
})

GM:CreateItem("arccw_acwatt_muzz_duckbill", {
    Name = "Duckbill Choke",
    Description = "Shotgun choke which produces a wide horizontal dispersion pattern. Potentially good for crowd control.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_duckbill.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_duckbill"
})

GM:CreateItem("arccw_acwatt_muzz_flashhider", {
    Name = "Flash Hider",
    Description = "Muzzle device which hides muzzle flash while improving hip fire characteristics.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_flashhider.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_flashhider"
})

GM:CreateItem("arccw_acwatt_muzz_hbar", {
    Name = "Heavy Barrel",
    Description = "Reinforced barrel with superior performance characteristics. Improves accuracy and recoil control at the cost of weapon weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_hbar.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_hbar"
})

GM:CreateItem("arccw_acwatt_muzz_lbar", {
    Name = "Light Barrel",
    Description = "Lightweight barrel with reduced weight with reduced precision compared to stock barrels.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_lbar.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_lbar"
})

GM:CreateItem("arccw_acwatt_muzz_mp5sd", {
    Name = "Integral Schalldämpfer",
    Description = "Integrated sound dampener which reduces bullets to subsonic velocity. Slows down fire rate due to quieter internal parts, but is otherwise a more egronomic Colossal Suppressor.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_mp5sd.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_mp5sd"
})

GM:CreateItem("arccw_acwatt_muzz_widechoke", {
    Name = "Wide Choke",
    Description = "Shotgun choke which increases pellet spread, but greatly reduces hip fire dispersion and felt recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_muzz_widechoke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "muzz_widechoke"
})

GM:CreateItem("arccw_acwatt_optic_acog", {
    Name = "ACOG (3x)",
    Description = "Magnified medium-range optic. ACOG stands for 'Advanced Combat Optical Gunsight'.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_acog.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_acog"
})

GM:CreateItem("arccw_acwatt_optic_aimpoint", {
    Name = "Aimpoint (RDS)",
    Description = "Tube-based red dot sight for rifles.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_aimpoint.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_aimpoint"
})

GM:CreateItem("arccw_acwatt_optic_aug_scope", {
    Name = "Integral Scope (1.5-3x)",
    Description = "Integrated scope designed specifically for a single weapon. Superior ergonomics compared to modular scopes. Includes a backup iron sight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_aug_scope.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_aug_scope"
})

GM:CreateItem("arccw_acwatt_optic_delta", {
    Name = "Delta (LP)",
    Description = "Low-profile red dot sight for pistols, with dot reticle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_delta.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_delta"
})

GM:CreateItem("arccw_acwatt_optic_delta_backup", {
    Name = "Canted Delta (RDS)",
    Description = "Backup red dot sight on 45 degree mount for use in combination with magnified optics.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_delta.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_delta_backup"
})

GM:CreateItem("arccw_acwatt_optic_docter", {
    Name = "Docter (LP)",
    Description = "Low-profile pistol sight with triangular sight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_docter.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_docter"
})

GM:CreateItem("arccw_acwatt_optic_farview", {
    Name = "Farview (4-9x)",
    Description = "High-magnification sniper rifle scope for long range combat.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_farview.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_farview"
})

GM:CreateItem("arccw_acwatt_optic_hamr", {
    Name = "HAMR (2.7x)",
    Description = "Zoom scope with integrated red dot sight. Slightly heavier than similar scopes.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_hamr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_hamr"
})

GM:CreateItem("arccw_acwatt_optic_holo", {
    Name = "Holographic (HOLO)",
    Description = "Boxy holographic sight designed for rifles.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_holo.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_holo"
})

GM:CreateItem("arccw_acwatt_optic_hunter", {
    Name = "Hunter (2-5x)",
    Description = "Adjustable medium-long range sniper optic.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_hunter.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_hunter"
})

GM:CreateItem("arccw_acwatt_optic_kobra", {
    Name = "Kobra (HOLO)",
    Description = "Russian holographic sight with three-prong reticle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_kobra.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_kobra"
})

GM:CreateItem("arccw_acwatt_optic_magnus", {
    Name = "Magnus (3-6x)",
    Description = "Sniper rifle optic with the ability to be adjusted between long and medium range magnification options.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_magnus.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_magnus"
})

GM:CreateItem("arccw_acwatt_optic_micro", {
    Name = "Micro (2x)",
    Description = "Miniature optic intended for low-magnification applications and close combat. Very lightweight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_micro.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_micro"
})

GM:CreateItem("arccw_acwatt_optic_mrs", {
    Name = "MRS (HOLO)",
    Description = "Holographic sight with circle-cross reticle. Wide lens and open sight reticle make this sight optimal for close-range combat.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_mrs.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_mrs"
})

GM:CreateItem("arccw_acwatt_optic_mrs_dot", {
    Name = "MRS (RDS)",
    Description = "Holographic sight with dot reticle. Wide lens makes this sight optimal for close-range combat.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_mrs.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_mrs_dot"
})

GM:CreateItem("arccw_acwatt_optic_okp", {
    Name = "OKP-7 (HOLO)",
    Description = "Russian holographic sight with chevron reticle.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_okp.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_okp"
})

GM:CreateItem("arccw_acwatt_optic_p90_ring", {
    Name = "Integral Ring (HOLO)",
    Description = "Integrated scope designed specifically for a single weapon. Superior ergonomics compared to modular scopes.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_p90_ring.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_p90_ring"
})

GM:CreateItem("arccw_acwatt_optic_reflex", {
    Name = "Reflex (RDS)",
    Description = "Lightweight reflex sight for rifles. Small frame allows for high ergonomics.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_reflex.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_reflex"
})

GM:CreateItem("arccw_acwatt_optic_t1", {
    Name = "T-1 (LP)",
    Description = "Mid-profile red dot sight with magnification properties.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_t1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_t1"
})

GM:CreateItem("arccw_acwatt_optic_vampire", {
    Name = "Vampire (FLIR)",
    Description = "Heavy infrared thermal vision scope. Capable of highlighting targets in white. Complex electronics require bulky chassis.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_optic_vampire.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "optic_vampire"
})

GM:CreateItem("arccw_acwatt_perk_extendedmags", {
    Name = "American Action Hero",
    Description = "High-capacity magazines allow for more time before needing to reload, but slow down reloading and add weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_extendedmags.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_extendedmags"
})

GM:CreateItem("arccw_acwatt_perk_fastreload", {
    Name = "Rushed Reloading",
    Description = "Improves reloading speed by 15% through improved magwell design.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_fastreload.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_fastreload"
})

GM:CreateItem("arccw_acwatt_perk_last", {
    Name = "Memento Mori",
    Description = "Significant damage multiplier at the cost of being able to fire only one round at a time, extremely slow reloading, and damage at range. It's got to be personal.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_last.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_last"
})

GM:CreateItem("arccw_acwatt_perk_lightweight", {
    Name = "Light Frame",
    Description = "Lightened frame allows faster movement and aiming, but worsens recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_lightweight.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_lightweight"
})

GM:CreateItem("arccw_acwatt_perk_owyn", {
    Name = "Make It Count",
    Description = "The last bullet in your magazine does up to double bonus damage based on capacity.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_owyn.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_owyn"
})

GM:CreateItem("arccw_acwatt_perk_quickdraw", {
    Name = "Bodyguard",
    Description = "A sling system helps with drawing more quickly, as well as firing from the hip. However, it is more difficult to use when aiming.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_quickdraw.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_quickdraw"
})

GM:CreateItem("arccw_acwatt_perk_refund", {
    Name = "Never Stop Shooting",
    Description = "Shots which successfully hit have a 50% chance to be refunded to your reserve ammo.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_refund.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_refund"
})

GM:CreateItem("arccw_acwatt_perk_underwater", {
    Name = "Diver",
    Description = "Allows gun to shoot underwater.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_perk_underwater.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "perk_underwater"
})

GM:CreateItem("arccw_acwatt_stock_heavy", {
    Name = "Heavy Stock",
    Description = "Heavy stock which improves recoil control and stability but takes longer to aim with.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_stock_heavy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "stock_heavy"
})

GM:CreateItem("arccw_acwatt_stock_light", {
    Name = "Light Stock",
    Description = "Lightened stock that allows for faster sight time and ergonomic control, at the cost of recoil control.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_stock_light.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "stock_light"
})

GM:CreateItem("arccw_acwatt_stock_skeleton", {
    Name = "Skeleton Stock",
    Description = "Hollow skeleton stock allows for improved movement speed, but harms recoil control.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_stock_skeleton.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "stock_skeleton"
})

GM:CreateItem("arccw_acwatt_stock_strafe", {
    Name = "Adjustable Stock",
    Description = "Adjustable stock improves sighted strafe speed, with a marginal weight increase.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_stock_strafe.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "stock_strafe"
})

GM:CreateItem("arccw_acwatt_stock_sturdy", {
    Name = "Sturdy Stock",
    Description = "Strengthened stock has reduced 'play' while maneuvering, improving moving accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_stock_sturdy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "stock_sturdy"
})

GM:CreateItem("arccw_acwatt_supp_heavy", {
    Name = "Colossal Suppressor",
    Description = "Large sound suppressor with ballistic-enhancing qualities. Extremely cumbersome.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_supp_heavy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "supp_heavy"
})

GM:CreateItem("arccw_acwatt_supp_light", {
    Name = "Light Suppressor",
    Description = "Lightweight weapon suppressor. Negatively impacts ballistic performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_supp_light.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "supp_light"
})

GM:CreateItem("arccw_acwatt_supp_med", {
    Name = "Tactical Suppressor",
    Description = "Balanced sound suppressor. Moderately improves performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_supp_med.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "supp_med"
})

GM:CreateItem("arccw_acwatt_supp_shotgun", {
    Name = "Colossal Suppressor",
    Description = "Sound suppressor with large bore intended for shotguns. Reduces weapon sound, at the cost of heavy bulk.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_supp_heavy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "supp_shotgun"
})

GM:CreateItem("arccw_acwatt_tac_anpeq", {
    Name = "Red Laser",
    Description = "Powerful red laser aiming module. Laser assists with aiming from the hip. Far more effective than other laser colors.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_tac_anpeq.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "tac_anpeq"
})

GM:CreateItem("arccw_acwatt_tac_green", {
    Name = "Green Laser",
    Description = "Green laser aiming module. Reduces time taken to bring sights on target.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_tac_green.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "tac_green"
})

GM:CreateItem("arccw_acwatt_tac_pointer", {
    Name = "Blue Laser",
    Description = "Blue-colored laser pointer. Bright blue dot improves accuracy while moving.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_tac_pointer.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "tac_pointer"
})

GM:CreateItem("arccw_acwatt_ubgl_gp25", {
    Name = "GP25 (HEAT)",
    Description = "Russian underbarrel launcher with anti-tank rocket rounds. Rockets travel straight and deal heavy direct damage with light splash damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_gp25.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_gp25"
})

GM:CreateItem("arccw_acwatt_ubgl_gp25_flash", {
    Name = "GP25 (FLASH)",
    Description = "Russian underbarrel launcher with flashbang rounds. Flashbangs temporarily blind targets and deal a small amount of explosive damage.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_gp25.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_gp25_flash"
})

GM:CreateItem("arccw_acwatt_ubgl_m203", {
    Name = "M203 (HE)",
    Description = "American-made underbarrel grenade launcher. Fires high explosive shells.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_m203.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_m203"
})

GM:CreateItem("arccw_acwatt_ubgl_m203_smk", {
    Name = "M203 (SMOKE)",
    Description = "American-made underbarrel grenade launcher. Fires smoke shells, which produce a white smokescreen. Smoke can be seen through with thermal vision.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_m203.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_m203_smk"
})

GM:CreateItem("arccw_acwatt_ubgl_mass", {
    Name = "MASS-12 (BUCK)",
    Description = "Magazine-fed bolt-action 12 gauge underbarrel shotgun.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_mass.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_mass"
})

GM:CreateItem("arccw_acwatt_ubgl_mass_slug", {
    Name = "MASS-12 (SLUG)",
    Description = "Magazine-fed bolt-action 12 gauge underbarrel shotgun using slug rounds. Poor accuracy.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/acwatt_ubgl_mass.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "ubgl_mass_slug"
})

