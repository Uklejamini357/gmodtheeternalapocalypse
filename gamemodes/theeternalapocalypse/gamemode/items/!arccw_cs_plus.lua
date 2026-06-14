-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2131058270
-- Generated with a template

local modOrigin = "[ArcCW] Counter Strike +"

GM:CreateItem("arccw_ak47", {
    Name = "AK-47",
    Description = "An early assault rifle pattern, designed by a Soviet tank mechanic in response to the need for a more versatile infantry weapon. Poor accuracy, but packs a serious punch.",
    Cost = 8600,
    Model = "models/weapons/arccw/w_type2.mdl",
    Material = "entities/arccw_ak47.png",
    Weight = 3.47,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_ak47",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_aug", {
    Name = "AUG A2",
    Description = "Bullpup assault rifle, whose design puts the mechanism behind the grip, allowing for a longer barrel without extending the effective length of the weapon. Good magazine capacity, poor recoil characteristics.",
    Cost = 9000,
    Model = "models/weapons/arccw/w_para.mdl",
    Material = "entities/arccw_aug.png",
    Weight = 3.6,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_aug",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_augpara", {
    Name = "AUG Para",
    Description = "Bullpup SMG based on the Para-556. Bullpup design enables superior accuracy and range out of a compact SMG package.",
    Cost = 7800,
    Model = "models/weapons/arccw/w_para9.mdl",
    Material = "entities/arccw_augpara.png",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_augpara",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_awm", {
    Name = "AWM",
    Description = "A high-caliber sniper rifle designed for cold-weather police and military units. Heavy rounds pack an extreme punch and are designed for maximum precision.",
    Cost = 16000,
    Model = "models/weapons/arccw/w_hs338.mdl",
    Material = "entities/arccw_awm.png",
    Weight = 6.9,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_awm",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_bizon", {
    Name = "PP-19-02 Bizon",
    Description = "Submachine gun with huge helical magazine. Fires relatively weak rounds, slowly, but at a reliable pace. Developed for FSB-Spetsnaz units in the Russian Federation, and employed in combat against militants in the Caucasus region, its straight-blowback design reduces manufacturing costs while sharing components with other common weapons.",
    Cost = 5000,
    Model = "models/weapons/arccw/w_bizon.mdl",
    Material = "entities/arccw_bizon.png",
    Weight = 2.1,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_bizon",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_contender", {
    Name = "G2 Contender",
    Description = "Break action pistol in a full-sized rifle round. Offers incredible power, but at the cost of poor range due to an insufficiently sized barrel for the cartridge.",
    Cost = 4600,
    Model = "models/weapons/arccw/w_contender.mdl",
    Material = "entities/arccw_contender.png",
    Weight = 1.7,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_contender",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_db", {
    Name = "DB",
    Description = "Basic double-barrel shotgun manufactured as an entry-level hunting weapon. Long barrel makes for great spread and extra range, at the cost of poor hip fire characteristics. Switch to BOTH firemode to fire both barrels in quick succession.",
    Cost = 2670,
    Model = "models/weapons/arccw/w_db.mdl",
    Material = "entities/arccw_db.png",
    Weight = 3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_db",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_db_sawnoff", {
    Name = "Sawn-Off",
    Description = "Sawn-off version of the Partner, improving agility at the cost of spread and range.",
    Cost = 2210,
    Model = "models/weapons/arccw/w_sawnoff.mdl",
    Material = "entities/arccw_db_sawnoff.png",
    Weight = 2,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_db_sawnoff",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_deagle357", {
    Name = "Desert Eagle .357",
    Description = ".357 Magnum heavy automatic pistol, designed for self-defense against large wild animals such as grizzly bears. A rotating-bolt gas-operated design makes it able to handle the huge round, resembling an assault rifle more than a handgun. Lighter, higher-capacity version of the Century Eagle.",
    Cost = 3150,
    Model = "models/weapons/w_pist_deagle.mdl",
    Material = "entities/arccw_deagle357.png",
    Weight = 1.91,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_deagle357",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_deagle50", {
    Name = "Desert Eagle .50",
    Description = ".50 Calibre heavy automatic pistol, designed for self-defense against large wild animals such as grizzly bears. A rotating-bolt gas-operated design makes it able to handle the huge round, resembling an assault rifle more than a handgun.",
    Cost = 3765,
    Model = "models/weapons/arccw/w_gce.mdl",
    Material = "entities/arccw_deagle50.png",
    Weight = 2,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_deagle50",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_famas", {
    Name = "FAMAS",
    Description = "Bullpup 3 round burst assault rifle. Reliable, well-rounded option for medium to long range battle.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_canin.mdl",
    Material = "entities/arccw_famas.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_famas",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_fiveseven", {
    Name = "Five-seveN",
    Description = "5.7mm self loading pistol, designed as a handgun counterpart to the PDW-57. 'NXS' stands for 'New eXperimental Sidearm'.",
    Cost = 1000,
    Model = "models/weapons/w_pist_fiveseven.mdl",
    Material = "entities/arccw_fiveseven.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_fiveseven",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_g18", {
    Name = "G18",
    Description = "9mm fully automatic police machine pistol. Low damage, but a sophisticated recoil control system allows for excellent automatic performance.",
    Cost = 1000,
    Model = "models/weapons/w_pist_glock18.mdl",
    Material = "entities/arccw_g18.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_g18",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_g3a3", {
    Name = "G3A3",
    Description = "Heavy 7.62mm battle rifle. Fully automatic, with punishing recoil. Effective at long range. Slow fire rate.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_ag63.mdl",
    Material = "entities/arccw_g3a3.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_g3a3",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_galil556", {
    Name = "Galil ARM",
    Description = "Very low recoil assault rifle. Highly controllable. Has a bottle opener in the front handguard.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_lior556.mdl",
    Material = "entities/arccw_galil556.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_galil556",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m1014", {
    Name = "M1014",
    Description = "12 gauge automatic tube-fed shotgun. Excellent fire rate, but takes a long time to reload.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_as1217.mdl",
    Material = "entities/arccw_m1014.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m1014",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m107", {
    Name = "M107",
    Description = "High caliber semi automatic rifle designed to take out light armored vehicles and military equipment. BFG stands for 'Big Fifty Gun'. Deals great damage at all ranges. Extremely heavy and cumbersome.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_bfg.mdl",
    Material = "entities/arccw_m107.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m107",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m14", {
    Name = "M14",
    Description = "Semi-automatic DMR. Well-rounded performance supplemented by railed polymer furniture, which offers superior handling characteristics. 7.62 NATO round overpenetrates at close range.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_m14.mdl",
    Material = "entities/arccw_m14.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m14",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m4a1", {
    Name = "M4A1",
    Description = "Shortened carbine-length version of the M16 rifle, designed for use in situations where a shorter or lighter weapon is required. After the turn of the millennium, many armies began adopting carbines as their main infantry weapons.",
    Cost = 1000,
    Model = "models/weapons/arccw/mk4.mdl",
    Material = "entities/arccw_m4a1.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m4a1",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m60", {
    Name = "M60",
    Description = "General purpose machine gun firing full length cartridges. Nicknamed \"The Pig\" for its bulky shape, it is nevertheless a capable beast, and a favorite among action heroes.",
    Cost = 46500,
    Model = "models/weapons/arccw/w_m60.mdl",
    Material = "entities/arccw_m60.png",
    Weight = 10.5,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m60",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_m9", {
    Name = "M92FS",
    Description = "9mm self-loading pistol. Cheap firearm popular among gangsters. Reliable, but not overall very special.",
    Cost = 1000,
    Model = "models/weapons/w_pist_elite_single.mdl",
    Material = "entities/arccw_m9.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_m9",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_mac11", {
    Name = "MAC-11",
    Description = "An often handcrafted submachine gun. Known for its incredibly low price at the cost of almost all else. It shoots, and that's about the best thing going for it.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_mk201.mdl",
    Material = "entities/arccw_mac11.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_mac11",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_makarov", {
    Name = "Makarov",
    Description = "Soviet self-loading pistol. Incredibly widespread in Ex-Soviet areas. Distributed to military officers and police units. Low damage, but low recoil and fast to reload.",
    Cost = 880,
    Model = "models/weapons/arccw/w_pmt.mdl",
    Material = "entities/arccw_makarov.png",
    Weight = 0.73,
    Supply = 1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_makarov",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_minigun", {
    Name = "M134",
    Description = "A heavy machine gun capable of firing at an extremely fast fire rate due to its electric fire control system. The ultimate weapon. Carrying it will reduce your movement speed to a halt, and you can forget about sprinting with it. In return, up to 2400 RPM of 7.62 Real Fuckin' NATO is in your hands, if you can control them. Wield it with care.",
    Cost = 850000,
    Model = "models/weapons/arccw/w_minigun.mdl",
    Material = "entities/arccw_minigun.png",
    Weight = 39,
    Supply = -1,
    Rarity = RARITY_GODLY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_minigun",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_minimi", {
    Name = "Minimi Para",
    Description = "Air-cooled, belt-fed fully automatic squad assault weapon. Capable of laying down sustained suppressive fire. Depleting a belt fully negates the need to remove it before inserting a new one, meaning that reloading when the weapon is totally empty is actually faster.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_m2000g.mdl",
    Material = "entities/arccw_minimi.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_minimi",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_mp5", {
    Name = "MP5A3",
    Description = "Light SMG predating the MP-K1. Less precise, with slightly more recoil, but is lighter in weight.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_mp5.mdl",
    Material = "entities/arccw_mp5.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_mp5",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_p228", {
    Name = "P228",
    Description = "9mm self-loading pistol with reliable mechanism. ",
    Cost = 1000,
    Model = "models/weapons/w_pist_p228.mdl",
    Material = "entities/arccw_p228.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_p228",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_p90", {
    Name = "P90",
    Description = "5.7mm PDW developed to arm rear-line soldiers in need of a more effective weapon to combat enemy paratroopers wearing body armor. Offers high fire rate with excellent damage characteristics retained at long range.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_pdw57.mdl",
    Material = "entities/arccw_p90.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_p90",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_ragingbull", {
    Name = "Raging Bull",
    Description = "Popular, reliable double-action revolver, able to switch to single-action for improved precision. While semi-automatics may hold more rounds and be no less reliable, a cylinder full of magnum rounds is still an intimidating sight. Did you fire six shots, or only five?",
    Cost = 1000,
    Model = "models/weapons/arccw/w_ragingbull.mdl",
    Material = "entities/arccw_ragingbull.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_ragingbull",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_rpg7", {
    Name = "RPG-7",
    Description = "A rocket launcher with 4 different payload options; HE, HEAT, Tandem, and Smoke. HE rockets have high splash but low immediate damage. HEAT rounds have good damage and splash. Tandem rounds have very little splash, but massive damage. Smoke rounds do no damage, but create an obscuring smokescreen.",
    Cost = 74520,
    Model = "models/weapons/arccw/w_rpg7.mdl",
    Material = "entities/arccw_rpg7.png",
    Weight = 6.3,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_rpg7",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_ruger", {
    Name = "Mk. 2",
    Description = "A small caliber plinking weapon. Its cartridge is hardly lethal, but sports high precision and minimal recoil.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_ruger.mdl",
    Material = "entities/arccw_ruger.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_ruger",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_saiga", {
    Name = "Saiga-12",
    Description = "A magazine fed 12 gauge shotgun. Designed for hunting use as well as for police forces.",
    Cost = 11760,
    Model = "models/weapons/arccw/w_saiga.mdl",
    Material = "entities/arccw_saiga.png",
    Weight = 3.6,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_saiga",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_scout", {
    Name = "Scout",
    Description = "The Precision Sharpshooter Rifle System is a high-spec bolt-action rifle, tailored to the needs of Police snipers. It is also marketed to civilian competition shooters.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_psrs.mdl",
    Material = "entities/arccw_scout.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_scout",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_sg550", {
    Name = "SG550-1",
    Description = "Swiss police marksman rifle in 5.56. Designed for use at closer ranges than most sniper rifles.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_sg550.mdl",
    Material = "entities/arccw_sg550.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_sg550",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_sg552", {
    Name = "SG552",
    Description = "Lightweight assault rifle, with compact 24-round magazine as default. Controllable fire rate. Great accuracy.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_roland.mdl",
    Material = "entities/arccw_sg552.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_sg552",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_shorty", {
    Name = "M3 Super 90",
    Description = "12 gauge pistol grip pump shotgun. Designed for maneuverability in confined spaces.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_defender.mdl",
    Material = "entities/arccw_shorty.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_shorty",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_tmp", {
    Name = "MP9",
    Description = "A machine pistol with extremely high fire rate. In order to control this, it has been limited to three-round burst mode.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_tmp.mdl",
    Material = "entities/arccw_tmp.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_tmp",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_ump45", {
    Name = "UMP-45",
    Description = ".45 calibre version of the MP-K1. Packs a greater punch at short range, but has a worse fire rate.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_mps2.mdl",
    Material = "entities/arccw_ump45.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_ump45",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_ump9", {
    Name = "UMP-9",
    Description = "Ubiquitous 9mm SMG. Created as a response to the need for a faster-firing and more reliable submachine gun than existing options at the time.",
    Cost = 1000,
    Model = "models/weapons/arccw/w_mpk1.mdl",
    Material = "entities/arccw_ump9.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_ump9",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_usp", {
    Name = "USP-40",
    Description = ".40 Caliber semi automatic pistol. Commonly used among police and popular with civilians for its reliability.",
    Cost = 1000,
    Model = "models/weapons/w_pist_usp.mdl",
    Material = "entities/arccw_usp.png",
    Weight = 0.3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_usp",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

GM:CreateItem("arccw_welrod", {
    Name = "Welrod",
    Description = ".45 caliber pistol designed to be as silent as absolutely possible. A bolt action allows it to reduce its report by eliminating bolt carrier noise.",
    Cost = 1260,
    Model = "models/weapons/arccw/w_welrod.mdl",
    Material = "entities/arccw_welrod.png",
    Weight = 1,
    Supply = 1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "arccw_welrod",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})

