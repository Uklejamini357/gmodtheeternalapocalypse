-- Common Attachments
-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2640556672

GM:CreateItem("arccw_acwatt_uc_40mm_airburst", {
    Name = "40mm Airburst Grenades",
    Description = "Grenades filled with fragmentation. While usually detonated by a time fuse, this one has been modified to detonate by proximity. Intended for indirect fire, the projectile is slow and has high drag, with a safety fuse to prevent point-blank detonations.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_airburst"
})

GM:CreateItem("arccw_acwatt_uc_40mm_buckshot", {
    Name = "40mm Buckshot Grenades",
    Description = [[Officially desginated the 'Multiple Projectile Anti Personnel' ammunition, these grenades are effectively large buckshot rounds containing 20 pellets.
Intended to be used when the enemy is too close to use explosives.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_buckshot"
})

GM:CreateItem("arccw_acwatt_uc_40mm_caseless", {
    Name = "40mm Caseless Grenades",
    Description = [[Russian caseless VOG-25 grenades converted for use in regular tubes.
Without the need to remove an empty case, these can be reloaded faster; but the caseless design also means less propellant and less explosive power.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_caseless.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_caseless"
})

GM:CreateItem("arccw_acwatt_uc_40mm_dp", {
    Name = "40mm Dual Purpose Grenades",
    Description = "Grenades with a shaped charge for armor penetration, allowing it to punch through thin walls or deal massive impact damage to enemies or vehicles.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_dp"
})

GM:CreateItem("arccw_acwatt_uc_40mm_dummy", {
    Name = "40mm Dummy Grenades",
    Description = [[Non-lethal grenades with an empty ceramic shell.
Used for target practice, the grenade has a noticable trail and paints its impact point with blue chalk.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_dummy"
})

GM:CreateItem("arccw_acwatt_uc_40mm_flash", {
    Name = "40mm Stun Grenades",
    Description = [[Less-than-lethal grenades that create a blinding flash and deafening bang.
While typically used as hand grenades, the larger projectile allows for a more visible and audible effect.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_flash"
})

GM:CreateItem("arccw_acwatt_uc_40mm_hornetnest", {
    Name = "40mm 'Hornet's Nest' Grenades",
    Description = [[Aftermarket grenades that fit 16 .22 LR cartridges.
Made to circumvent legal restrictions, these grenades are less lethal but more accurate than an equivalent 40mm buckshot round.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_hornetnest"
})

GM:CreateItem("arccw_acwatt_uc_40mm_hv", {
    Name = "40mm High Velocity Grenades",
    Description = [[Fin-stabilized, lightweight grenade with explosive payload.
Flies fast and with low drag, but creates a smaller and less lethal explosion.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_hv"
})

GM:CreateItem("arccw_acwatt_uc_40mm_incendiary", {
    Name = "40mm Incendiary Grenades",
    Description = "Hand-made grenades loaded with a fuel mixture that disperses on impact, burning an area over time.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_incendiary"
})

GM:CreateItem("arccw_acwatt_uc_40mm_napalm", {
    Name = "40mm Napalm Grenades",
    Description = [[Extremely illegal airburst grenades loaded with sticky napalm.
While the napalm only disperses in a small radius, it will stick onto targets that come into contact with it, causing a gruesome and fiery death.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_napalm"
})

GM:CreateItem("arccw_acwatt_uc_40mm_smoke", {
    Name = "40mm Smoke Grenades",
    Description = "Less-than-lethal grenades that create a ring of smoke, obscuring vision.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_40mm_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_40mm_smoke"
})

GM:CreateItem("arccw_acwatt_uc_ammo_ap", {
    Name = "\"AP\" Armor-piercing Rounds",
    Description = [[Bullets designed to penetrate body armor, usually built around a penetrator of hardened steel, tungsten, or tungsten carbide.
Upon impact on a hard target, the case is destroyed, but the penetrator continues its motion and penetrates the target.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_ap"
})

GM:CreateItem("arccw_acwatt_uc_ammo_blank", {
    Name = "\"BLNK\" Blank Cartridges",
    Description = [[Cartridges sealed without a solid projectile. Performance is otherwise identical. Used when the muzzle report of a gunshot is necessary without the bullet, such as in filming, ceremonies, sports, and combat training.

In real life, blanks are not harmless. The muzzle shockwave or discharged wadding can and have killed people who do not exercise standard firearm precautions.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_blank.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_blank"
})

GM:CreateItem("arccw_acwatt_uc_ammo_jhp", {
    Name = "\"JHP\" Jacketed Hollow-point Rounds",
    Description = [[A type of bullet with a hollow tip that expands on impact, causing a more lethal hit without penetrating further than necessary.
For use in environments where over-penetration could cause collateral damage.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_jhp"
})

GM:CreateItem("arccw_acwatt_uc_ammo_jsp", {
    Name = "\"JSP\" Jacketed Soft-point Rounds",
    Description = [[Bullets with an exposed lead tip that expands on impact.
Increases wounding potential while maintaining an aerodynamic profile.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_jsp"
})

GM:CreateItem("arccw_acwatt_uc_ammo_lowtr", {
    Name = "\"TR\" Intermittent Tracers",
    Description = "Every 5 rounds as well as the last few rounds of the magazine are tracer rounds, providing a visual indication of rounds remaining and make hip firing somewhat easier.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_lowtr"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_baton", {
    Name = "\"BATON\" Flexible Baton",
    Description = [[Less-lethal law enforcement round that fires a cushioned, low-velocity "bean bag" filled with lead pellets.
Designed to apprehend targets through pain instead of killing them, though the 40-gram projectile can still inflict deadly or permanent injuries.

Only compatible with manual action shotguns due to a weak pressure curve.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_baton"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_bird", {
    Name = "\"BIRD\" #9 Birdshot",
    Description = [[Hunting rounds with a wide spread and a very large number of pellets, designed to shoot birds out of the sky.
While not as lethal as buckshot, the loose clump spread makes it easier to hit small or multiple targets.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_bird"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_bird2", {
    Name = "\"BIRD\" #9 Birdshot",
    Description = [[Hunting rounds with a wide spread and a very large number of pellets, designed to shoot birds out of the sky.
While not as lethal as buckshot, the loose clump spread makes it easier to hit small or multiple targets.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_bird2"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_confetti", {
    Name = "\"PARTY\" Confetti",
    Description = [[Joke ammunition filled with tiny pieces of colorful paper. Produces a celebratory puff instead of anything reasonably lethal, allowing your weapon to double as a party popper.

Shotguns are truly the most versatile firearms.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_confetti"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_drgn", {
    Name = "\"DRGN\" Dragon's Breath",
    Description = [[Novelty magnesium-based round that projects a spectacular jet of sparks and fire. Burning at over 3,000 °F, the blast isn't immediately lethal, but can easily set objects and people ablaze.

Only compatible with manual action shotguns due to a weak pressure curve.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_drgn"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_flech", {
    Name = "\"FLECH\" Flechettes",
    Description = "Payload consisting of heavy, aerodynamic metal darts, which have less clump spread and more penetration than buckshot.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_flech"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_frag", {
    Name = "\"HE\" FRAG-12",
    Description = [[Shotgun slug with a small high-explosive warhead. On impact, the round saturates its surroundings with shrapnel like a frag grenade.
Meant for breaching, but it can also useful for applying damage over an area.
Beware: the explosion doesn't care who it hurts.

Only compatible with manual action shotguns due to a weak pressure curve.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_frag"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_magnum", {
    Name = "\"MAG\" #000 Magnum Buckshot",
    Description = "Buckshot load using fewer, larger diameter shots and a more intense powder load. This ammo type is particularly effective up close, but its energy fizzles out quickly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_magnum"
})

GM:CreateItem("arccw_acwatt_uc_ammo_sg_slug", {
    Name = "\"SLUG\" Full-Bore Slug",
    Description = [[A single heavy projectile, comparable in performance to a high-caliber rifle cartridge at close to medium range.
Applicable in situations that require marksmanship and minimal collateral damage.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_shotgun_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_sg_slug"
})

GM:CreateItem("arccw_acwatt_uc_ammo_tmj", {
    Name = "\"TMJ\" Total Metal Jacket Rounds",
    Description = [[Bullet entirely encased in a thin jacket of metal over a core of different metal to protect it from abrasion or corrosion.
Protecting the base of a lead-core bullet from burning powder gas may prevent molten lead from being released as a fine spray in turbulent gas leaving the muzzle of a firearm.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_tmj"
})

GM:CreateItem("arccw_acwatt_uc_ammo_tr", {
    Name = "\"TR\" Tracer Rounds",
    Description = "A pyrotechnic charge inside the bullet creates a bright, colorful trail behind it during flight. The bright trails can help the shooter predict ballistic trajectories without using sights.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_ammo_generic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ammo_tr"
})

GM:CreateItem("arccw_acwatt_uc_choke_cyl", {
    Name = "Cylinder Choke",
    Description = "A mildly tight shotgun choke. Tightens pellet spread at the cost of straight recoil.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_choke_cyl"
})

GM:CreateItem("arccw_acwatt_uc_choke_full", {
    Name = "Full Choke",
    Description = "A very tight choke for shotguns, noticably tightening spread. However, it tends to offset aiming.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_choke_full"
})

GM:CreateItem("arccw_acwatt_uc_choke_rifled", {
    Name = "Rifled Choke",
    Description = "A special choke that improves the aerodynamics of slug rounds. It is not as effective as a fully rifled barrel.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_choke_rifled"
})

GM:CreateItem("arccw_acwatt_uc_choke_wide", {
    Name = "Wide Choke",
    Description = "A loose choke that widens pellet spread, potentailly making targets easier to hit.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_choke_wide"
})

GM:CreateItem("arccw_acwatt_uc_fg_autotrigger", {
    Name = "Forced Reset Trigger",
    Description = "Trigger system that pushes back against the shooter's finger, allowing them to fire much more rapidly. By the definition of the ATF, this does not count as full-automatic, for the time being at least.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_forcedresettrigger.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_autotrigger"
})

GM:CreateItem("arccw_acwatt_uc_fg_civvy", {
    Name = "Competition Internals",
    Description = "High quality, precision manufactured aftermarket parts that improve weapon performance. Because of the parts' civilian origin, the fire control group doesn't support automatic fire.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_fg_civvy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_civvy"
})

GM:CreateItem("arccw_acwatt_uc_fg_deeprifling", {
    Name = "Deep Rifling",
    Description = "A custom tailored rifling scheme allows bullets to strike with greater impact, penetrating deeper.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_deeprifling.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_deeprifling"
})

GM:CreateItem("arccw_acwatt_uc_fg_dualstage", {
    Name = "Dual-Stage Trigger",
    Description = "A heavy trigger with a semi-automatic middle stage and a fully-automatic end stage. Can shoot semi- and fully- automatically without the need for switching a fire selector.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_dualstage"
})

GM:CreateItem("arccw_acwatt_uc_fg_heavy", {
    Name = "Heavy Bolt",
    Description = "Heavyweight bolt springs reduce the cyclic rate of the weapon, improving its controllability.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_heavybolt.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_heavy"
})

GM:CreateItem("arccw_acwatt_uc_fg_light", {
    Name = "Light Bolt",
    Description = "A low weight set of bolt components increase the cyclic speed of the weapon at the cost of recoil absorption.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_lightbolt.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_light"
})

GM:CreateItem("arccw_acwatt_uc_fg_longrifling", {
    Name = "Long Rifling",
    Description = "Custom rifling improves muzzle velocity, allowing the weapon to shoot further.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_longrifling.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_longrifling"
})

GM:CreateItem("arccw_acwatt_uc_fg_loosesprings", {
    Name = "Loose Springs",
    Description = "With help from some loose magazine springs, it is possible to stuff more ammo in a magazine than is usually recommended.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_loosesprings.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_loosesprings"
})

GM:CreateItem("arccw_acwatt_uc_fg_lubedparts", {
    Name = "UD-40 Coating",
    Description = "Liberal use of a special lubricant greatly reduces the likelihood of jams and other malfuntions.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_lubedparts.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_lubedparts"
})

GM:CreateItem("arccw_acwatt_uc_fg_match", {
    Name = "Match Trigger",
    Description = "Hair trigger for competition shooting allows crisp trigger pulls, improving first shot performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_matchgradetrigger.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_match"
})

GM:CreateItem("arccw_acwatt_uc_fg_preciserifling", {
    Name = "Precision Rifling",
    Description = "High-precision machined rifling allows the weapon to shoot much more consistently.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_precisionrifling.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_preciserifling"
})

GM:CreateItem("arccw_acwatt_uc_fg_sg_rifled", {
    Name = "Rifled Barrel",
    Description = "Specially made lightweight barrel designed for slug rounds. Improves precision and time to aim noticably.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_precisionrifling.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_sg_rifled"
})

GM:CreateItem("arccw_acwatt_uc_fg_slamfire", {
    Name = "Slamfire Kit",
    Description = "Reckless removal of trigger safety features allows shells to fire immediately upon being cycled while the trigger is held. This enables rapid \"rack and fire\" behavior similar to old trench guns, but impacts weapon performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_slamfire"
})

GM:CreateItem("arccw_acwatt_uc_fg_underwater", {
    Name = "Sealed Bolt",
    Description = "Watertight modifications that allow the weapon to fire underwater.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_sealedbolt.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_fg_underwater"
})

GM:CreateItem("arccw_acwatt_uc_grip_bcmvfg", {
    Name = "BCMGUNFIGHTER Vertical Grip Mod 3",
    Description = [[A short grip providing a more natural holding position, making the weapon easier to use while moving.
]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_grip_bcmvfg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_grip_bcmvfg"
})

GM:CreateItem("arccw_acwatt_uc_grip_handstop", {
    Name = "Handstop",
    Description = "Prevents the hand from sliding down the barrel, allowing improved point shooting precision.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_grip_handstop.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_grip_handstop"
})

GM:CreateItem("arccw_acwatt_uc_grip_kacvfg", {
    Name = "Knight's Armament Company Vertical Foregrip",
    Description = "Medium-length vertical foregrip that assists in control of the weapon, but detracts from its concealability.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_grip_kacvfg.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_grip_kacvfg"
})

GM:CreateItem("arccw_acwatt_uc_grip_mafg2", {
    Name = "MAGPUL AFG-2 Angled Fore Grip",
    Description = "An ergonomically angled grip surface reduces wrist strain, increasing maneuverability.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_grip_magpul_afg2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_grip_mafg2"
})

GM:CreateItem("arccw_acwatt_uc_grip_mafg2_tan", {
    Name = "MAGPUL AFG-2 Angled Fore Grip (Tan)",
    Description = [[An ergonomically angled grip surface reduces wrist strain, increasing maneuverability.
This unit is cosmetically colored tan.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_grip_magpul_afg2_tan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_grip_mafg2_tan"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_brake1", {
    Name = "Hammerhead Muzzle Brake",
    Description = [[Redirects propellant gases to reduce weapon recoil.
Reduces muzzle rise substantially.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_brake1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_brake1"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_brake2", {
    Name = "Helix Muzzle Brake",
    Description = [[Redirects propellant gases to reduce weapon recoil.
Slightly reduces recoil.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_brake2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_brake2"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_compensator", {
    Name = "Basilisk Heavy Compensator",
    Description = [[Redirects propellant gases to reduce weapon recoil.
Improves recoil stability.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_compensator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_compensator"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_fhider1", {
    Name = "Flash Hider",
    Description = "Reduces muzzle flash to the point where it can't block the shooter's vision or compromise their position. The enhanced clarity marginally improves hip fire performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_fhider1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_fhider1"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_fhider2", {
    Name = "Cage Compensator",
    Description = "Dual purpose compensator and flash hider, improving weapon stability while providing a clearer firing view from the hip.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_fhider2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_fhider2"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_cylinder", {
    Name = "Cylinder Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Bulky and heavy, but provides better ballistic performance.

"By the time you figured it out, it would be too late."]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_cylinder.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_cylinder"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_ga9", {
    Name = "GA9 Revolution 9 Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Compact and lightweight, with little impact on handling, but still lengthens profile more than other muzzle attachments.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_ga9.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_ga9"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_giraffe", {
    Name = "ATA Giraffe Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Extremely long suppressor tube provides excellent noise reduction, but is also very unwieldy.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_giraffe.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_giraffe"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_lighthouse", {
    Name = "L15 'Lighthouse' Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Improves close range stopping power slightly due to redirection of gas pressure.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_lighthouse.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_lighthouse"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_masada", {
    Name = "Magpul PTS AAC Masada Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Reduces recoil by providing extra room for gas expansion.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_masada.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_masada"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_pbs1", {
    Name = "PBS-1 Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Gas redirection causes the side benefit of straightening recoil.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_pbs1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_pbs1"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_pbs4", {
    Name = "PBS-4 Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Originally designed for carbine barrels, this suppressor compensates for inaccuracy, and can be mounted to other barrels with some gunsmithing work.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_pbs4.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_pbs4"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_salvo", {
    Name = "Salvo 12 Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Low profile and relatively lightweight, with no negative ballistic impact.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_salvo.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_salvo"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_ssq", {
    Name = "US G.I. 45 Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Enhances ballistics performance significantly, but its low maximum pressure makes it incompatible with supersonic ammunition.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_ssq.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_ssq"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_tac", {
    Name = "Mountain Armory Tactical Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Low-profile and enhances ballistics, but slightly cumbersome.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_tactical.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_tac"
})

GM:CreateItem("arccw_acwatt_uc_muzzle_supp_tgpa", {
    Name = "TGP-A Suppressor",
    Description = [[Traps propellant gas from the muzzle, reducing visual and audible report.
Well rounded suppressor with no notable downsides.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_muzzle_supp_tgpa.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_muzzle_supp_tgpa"
})

GM:CreateItem("arccw_acwatt_uc_optic_acog", {
    Name = "Trijicon Advanced Combat Optical Gunsight (4x)",
    Description = [[Medium range combat scope for improved precision at longer ranges.
Equipped with backup iron sights for use in emergencies.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_acog.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_acog"
})

GM:CreateItem("arccw_acwatt_uc_optic_annihilator", {
    Name = "Annihilator Handcannon Laser",
    Description = "Oversized laser module with iron sights, attached on the upper rail.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_annihilator.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_annihilator"
})

GM:CreateItem("arccw_acwatt_uc_optic_comp_m2", {
    Name = "AIMPOINT CompM2 Red Dot (RDS)",
    Description = "Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_comp_m2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_comp_m2"
})

GM:CreateItem("arccw_acwatt_uc_optic_elcan", {
    Name = "ELCAN C79 (2.5x)",
    Description = [[Durable, dependable, and venerable medium-range combat scope built to stand up to constant heavy fire.
Equipped with backup iron sights for use in emergencies.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_elcan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_elcan"
})

GM:CreateItem("arccw_acwatt_uc_optic_eotech552", {
    Name = "EOTech 552 (HOLO)",
    Description = "Improves target acquisition with a highly precise circle-dot holographic reticle, while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_eotech552.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_eotech552"
})

GM:CreateItem("arccw_acwatt_uc_optic_eotech553", {
    Name = "EOTech 553 (HOLO)",
    Description = "Tried-and-true sighting solution for close to medium ranges. Improves target acquisition with a highly precise circle-dot holographic reticle while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_eotech553.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_eotech553"
})

GM:CreateItem("arccw_acwatt_uc_optic_hamr", {
    Name = "Leupold Mark 4 High Accuracy Multi-Range Riflescope (3x/HOLO)",
    Description = [[Top-of-the-line magnified combat optic with an integral DeltaPoint.
Though it is moderately heavy, a skilled operator will be able to make use of it at every typical engagement distance.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_hamr.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_hamr"
})

GM:CreateItem("arccw_acwatt_uc_optic_holosun1", {
    Name = "Holosun HS510C (Riser) (RDS)",
    Description = [[Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.
Includes a riser.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_holosun1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_holosun1"
})

GM:CreateItem("arccw_acwatt_uc_optic_holosun2", {
    Name = "Holosun HS510C (RDS)",
    Description = "Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_holosun2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_holosun2"
})

GM:CreateItem("arccw_acwatt_uc_optic_kobra", {
    Name = "Kobra EKP-8-16 Reflex Sight (RDS)",
    Description = [[Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.
Exclusive to the "Warsaw Pact" optic mount, and is slightly more agile than rail mounted optics.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_kobra.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_kobra"
})

GM:CreateItem("arccw_acwatt_uc_optic_leupold_dppro", {
    Name = "Leupold DeltaPoint Pro Reflex Sight (LP)",
    Description = "Low-profile reflex sight. While its lens isn't as wide as other reflex sights, it's significantly lighter and small enough to use on pistols.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_leupold_dppro.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_leupold_dppro"
})

GM:CreateItem("arccw_acwatt_uc_optic_micro_t1", {
    Name = "AIMPOINT Micro T-1 Red Dot Reflex Sight (RDS)",
    Description = "Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_micro_t1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_micro_t1"
})

GM:CreateItem("arccw_acwatt_uc_optic_nvis", {
    Name = "N-Vision HALO-LR Thermal Scope (1-6x)",
    Description = "Cutting-edge night vision optic that highlights targets via infrared imaging. The complicated electronics result in a massive weight gain for the base weapon.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_nvis.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_nvis"
})

GM:CreateItem("arccw_acwatt_uc_optic_pso1", {
    Name = "PSO-1 (4x)",
    Description = [[Medium range combat scope for improved precision at longer ranges.
Exclusive to the "Warsaw Pact" optic mount, and is slightly more agile than rail mounted optics.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_pso1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_pso1"
})

GM:CreateItem("arccw_acwatt_uc_optic_sureshot", {
    Name = "Sightmark Sure Shot Reflex Sight (RDS)",
    Description = "Improves sighted visibility with a red-dot targeting reticle, while adding minimal extra weight.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_sureshot.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_sureshot"
})

GM:CreateItem("arccw_acwatt_uc_optic_trijicon_tars", {
    Name = "Trijicon Tactical Advanced Riflescope (3-8x)",
    Description = "Variable power scope, adjustable for a very wide range of magnifications.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_trijicon_tars.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_trijicon_tars"
})

GM:CreateItem("arccw_acwatt_uc_optic_vortex_3x", {
    Name = "Vortex SPITFIRE PRISM SCOPE (1.5x)",
    Description = "Short to medium range combat scope that allows a more versatile engagement range.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_optic_vortex_3x.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_optic_vortex_3x"
})

GM:CreateItem("arccw_acwatt_uc_powder_high", {
    Name = "Increased Load",
    Description = "Ammunition loaded with a higher amount of powder, slightly increasing ballistic performance.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_powder_high.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_powder_high"
})

GM:CreateItem("arccw_acwatt_uc_powder_low", {
    Name = "Reduced Load",
    Description = "Underpressured ammunition places less strain on the weapon, but lowers muzzle velocity and cyclic rate.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_powder_low.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_powder_low"
})

GM:CreateItem("arccw_acwatt_uc_powder_overpressure", {
    Name = "Overpressured",
    Description = "Higher pressure ammunition allows for higher muzzle velocity at the cost of stronger knockback. Such immense pressure increases the likelihood of extraction failures.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_powder_overpressure.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_powder_overpressure"
})

GM:CreateItem("arccw_acwatt_uc_powder_subsonic", {
    Name = "Subsonic",
    Description = [[Powder load low enough to make the bullet travel slower than the speed of sound. This reduces range significantly, but makes gunfire very comfortable and quiet (comparatively speaking).
The sonic boom typical of the round is eliminated, rendering it even more silent than usual with a suppressed firearm.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_powder_subsonic.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_powder_subsonic"
})

GM:CreateItem("arccw_acwatt_uc_stock_pistol", {
    Name = "FAB Defense Collapsible Tactical Stock",
    Description = [[Mitigates the recoil disadvantage typical of most pistols, but extends the weapon's profile substantially.

You probably shouldn't let the feds know you have this.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_stock_pistol.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_stock_pistol"
})

GM:CreateItem("arccw_acwatt_uc_tac_anpeq16a", {
    Name = "Insight Technologies MIPIM AN/PEQ-16A",
    Description = [[Low-profile flashlight and laser module for rifles. The laser increases accuracy without the use of sights.
The laser and flashlight can be toggled individually.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_anpeq16a.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_anpeq16a"
})

GM:CreateItem("arccw_acwatt_uc_tac_anpeq16a_tan", {
    Name = "Insight Technologies MIPIM AN/PEQ-16A (Tan)",
    Description = [[Low-profile flashlight and laser module for rifles. The laser increases accuracy without the use of sights.
The laser and flashlight can be toggled individually.
This unit is cosmetically colored tan.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_anpeq16a_tan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_anpeq16a_tan"
})

GM:CreateItem("arccw_acwatt_uc_tac_anpeq2", {
    Name = "Insight Technologies ATPIAL AN/PEQ-2",
    Description = [[Large flashlight and laser module for rifles, with a stronger, more effective laser that also aids target acquisition.
The laser and flashlight can be toggled individually.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_anpeq2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_anpeq2"
})

GM:CreateItem("arccw_acwatt_uc_tac_anpeq2_tan", {
    Name = "Insight Technologies ATPIAL AN/PEQ-2 (Tan)",
    Description = [[Large flashlight and laser module for rifles, with a stronger, more effective laser that also aids target acquisition.
The laser and flashlight can be toggled individually.
This unit is cosmetically colored tan.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_anpeq2_tan.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_anpeq2_tan"
})

GM:CreateItem("arccw_acwatt_uc_tac_flashlight1", {
    Name = "Civilian Rail-Mounted Flashlight",
    Description = [[Illuminates dark areas in front of the muzzle.
Can be adjusted for a wide light.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_flashlight1.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_flashlight1"
})

GM:CreateItem("arccw_acwatt_uc_tac_flashlight2", {
    Name = "Tactical Rail-Mounted Flashlight",
    Description = [[Illuminates dark areas in front of the muzzle.
Can be adjusted for a focused light.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_flashlight2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_flashlight2"
})

GM:CreateItem("arccw_acwatt_uc_tac_flashlight3", {
    Name = "High-Power Rail-Mounted Flashlight",
    Description = [[Illuminates dark areas in front of the muzzle.
Emits a strong, orange-tinted light.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_flashlight3.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_flashlight3"
})

GM:CreateItem("arccw_acwatt_uc_tac_laser_green", {
    Name = "Rail-Mounted Laser Sight (Green)",
    Description = "Projects a laser in the direction of the target, assisting the user to line up shots without iron sights.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_flashlight2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_laser_green"
})

GM:CreateItem("arccw_acwatt_uc_tac_laser_red", {
    Name = "Rail-Mounted Laser Sight (Red)",
    Description = "Projects a laser in the direction of the target, assisting the user to line up shots without iron sights.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_flashlight2.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_laser_red"
})

GM:CreateItem("arccw_acwatt_uc_tac_tlr2hl", {
    Name = "TLR-2 HL Pistol Flashlight",
    Description = [[A combined flashlight and laser module for pistols.
The laser and flashlight can be toggled individually.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_tac_tlr2hl.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tac_tlr2hl"
})

GM:CreateItem("arccw_acwatt_uc_tp_bruiser", {
    Name = "Bruiser",
    Description = "With the proper technique and upper body strength, you can more quickly and effectively use your weapon as a bludgeon.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_bruiser.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_bruiser"
})

GM:CreateItem("arccw_acwatt_uc_tp_endurance", {
    Name = "Endurance",
    Description = "Long courses of physical training allow you to bear more weight and control the recoil of your weapon, reducing the influence of your weapon's bulk on your speed and controlling its kick to stay on target for longer.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_endurance.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_endurance"
})

GM:CreateItem("arccw_acwatt_uc_tp_fastreload", {
    Name = "Loading Drills",
    Description = "Every second counts in the heat of battle. Repeated training drills allow you to reload your weapon more quickly.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_loading_drills.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_fastreload"
})

GM:CreateItem("arccw_acwatt_uc_tp_fullstroke", {
    Name = "Full Stroke",
    Description = "Specialist training and a little extra gun oil allow you to cycle the action more quickly after a shot, improving your rate of fire.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_full_stroke.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_fullstroke"
})

GM:CreateItem("arccw_acwatt_uc_tp_gang", {
    Name = "Homeboy",
    Description = "GANGSTAS ROLL UP IN DA HOOD, POP POP POP POP POP [-----], I BALL HARD STICK A GLOCK UP IN YOUR FACE [-----], DROP DROP DROP DROP DROP GO YOUR HOMIES [-----]",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_homeboy.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_gang"
})

GM:CreateItem("arccw_acwatt_uc_tp_gong", {
    Name = "Action Hero",
    Description = [[Operate the firearm using only one hand. This improves weapon mobility, but accurate fire becomes difficult at best and near impossible at worst.
Because accuracy is already out the window, practictioners of this style also opt to shoot while sprinting at full speed.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_actionhero.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_gong"
})

GM:CreateItem("arccw_acwatt_uc_tp_overload", {
    Name = "Overload",
    Description = "With a little grease and some physical force, most magazines can be made to accept an extra round.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_overload.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_overload"
})

GM:CreateItem("arccw_acwatt_uc_tp_pointman", {
    Name = "Pointman",
    Description = [[Firearms and dexterity training for quick response in breaching situations. Drills in confined spaces allow you to more effectively handle long weapons in close quarters.

The pointman is always the first to enter, and the first to identify and disable threats.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_pointman.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_pointman"
})

GM:CreateItem("arccw_acwatt_uc_tp_pointshoot", {
    Name = "Point Shooting",
    Description = "Dedicated practice at shooting without using the sights has given you the ability to fire from the hip more effectively. If John Rambo can do it, so can you.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_pointshooting.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_pointshoot"
})

GM:CreateItem("arccw_acwatt_uc_tp_quickdraw", {
    Name = "Quick Draw",
    Description = [[Like the fastest guns in the Old West, you can draw, aim, and shoot in the blink of an eye.

Texas Red had not cleared leather 'fore a bullet fairly ripped, and the Ranger's aim was deadly with the big iron on his hip.]],
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_quickdraw.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_quickdraw"
})

GM:CreateItem("arccw_acwatt_uc_tp_runandgun", {
    Name = "On the Move",
    Description = "Expert training in high-verticality maneuvers and countless moving-while-shooting drills allow you to aim steadily even while moving between cover, across open ground, or while mid-air.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_run_and_gun.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_runandgun"
})

GM:CreateItem("arccw_acwatt_uc_tp_strafe", {
    Name = "Strafe",
    Description = "Active experience in simulated combat drills has conditioned you to shoot while walking towards the enemy. When firing, you can walk at your normal speed.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_strafe"
})

GM:CreateItem("arccw_acwatt_uc_tp_sway", {
    Name = "Nerves of Steel",
    Description = "A series of carefully honed concentration and nerve techniques, plus a good helping of Diazepam, reduce hand jitter while aiming.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_nerves_of_steel.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_sway"
})

GM:CreateItem("arccw_acwatt_uc_tp_underload", {
    Name = "Underload",
    Description = "Just because it fits, does not mean you have to fill it. Partially filled magazines reduces follower stress and improves feeding rate.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/arccw_uc_tp_underload.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_tp_underload"
})

GM:CreateItem("arccw_acwatt_uc_ubgl_gp25", {
    Name = "GP-25 Underbarrel Grenade Launcher",
    Description = "Single-shot long-barreled underbarrel grenade launcher designed for the AK. The VOG-25 caseless projectiles can be reloaded faster, but hold less propellant and explosive yield.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_ubgl_gp25.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ubgl_gp25"
})

GM:CreateItem("arccw_acwatt_uc_ubgl_m203", {
    Name = "M203 Underbarrel Grenade Launcher",
    Description = "Single-shot underbarrel grenade launcher designed to replace the Colt XM148. Able to fire several basic 40x46mm grenade types.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_ubgl_m203.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ubgl_m203"
})

GM:CreateItem("arccw_acwatt_uc_ubgl_masterkey", {
    Name = "Masterkey Underslung Shotgun",
    Description = "Underslung shotgun primarily used to breach doors, but loaded with #00 Buckshot for your pleasure.",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_ubgl_masterkey.png",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "uc_ubgl_masterkey"
})

