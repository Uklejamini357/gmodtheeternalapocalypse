-- addons: 
-- Urban Decay: https://steamcommunity.com/sharedfiles/filedetails/?id=2641653126
-- Urban Renewal: https://steamcommunity.com/sharedfiles/filedetails/?id=2906702282
-- really? EOL now?

-- ArcCW Urban Decay weapons --
-- With attachments, these weapons can become OVERPOWERED.
-- balance issue lmao
-- Realistic weights for weapons are used

GM:CreateItem("arccw_ud_m1014", {
    Name = "Benelli M1014",
    Description = "Semi-automatic shotgun designed for close-quarters urban warfare. Uses an innovative short-stroke gas system that eliminates complex mechanisms found on most gas-operated automatic weapons. Its main use is in destroying locked doors.\n\nDevastating damage output, but control is required to avoid spending more time reloading than fighting.",
    Cost = 14640,
    Model = "models/weapons/arccw/c_ud_m1014.mdl",
    Material = "entities/arccw_ud_m1014.png",
    Weight = 3.63,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_m1014",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_glock", {
    Name = "Glock 17",
    Description = "Handgun originally designed by a curtain rod manufacturer for the Austrian military. Its reliable and cost-effective polymer design has since made it one of the most popular and widely used pistols in the world, common in military, police and civilian use alike.\n\nGreat backup weapon due to its quick draw and sight times, but a relatively low damage output makes it a less than ideal primary.",
    Cost = 5165,
    Model = "models/weapons/arccw/c_ud_glock.mdl",
    Material = "entities/arccw_ud_glock.png",
    Weight = 1.01,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_glock",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_m16", {
    Name = "M16A2",
    Description = "Third generation of America's iconic military rifle. Army tests showed that soldiers were more likely to hit a target if they fired multiple shots, but were likely to spray in full-auto and fail to hit anything. As a result, they implemented a ratcheted three-round burst system which limited the maximum burst a soldier could fire to three shots.\n\nWell-rounded gun with no major downsides.",
    Cost = 23670,
    Model = "models/weapons/arccw/c_ud_m16.mdl",
    Material = "entities/arccw_ud_m16.png",
    Weight = 2.88,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_m16",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_m79", {
    Name = "M79",
    Description = "Single-shot 40mm grenade launcher intended to provide infantry with portable long-range explosive firepower. Accurate, flexible and reliable, it is well-respected among American soldiers.",
    Cost = 28015,
    Model = "models/weapons/arccw/c_ud_m79.mdl",
    Material = "entities/arccw_ud_m79.png",
    Weight = 2.92,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_m79",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_mini14", {
    Name = "Mini-14",
    Description = "Autoloading rifle designed for better accuracy than competing models. Due to its appearance, it is sometimes exempted from gun control laws targeting \"Assault Weapons\" despite its identical ability to kill. This has helped it find success despite its higher cost and non-standard magazine well.\n\nWhile it can perform well in close-quarters combat, its high accuracy excels in mid-range engagements.",
    Cost = 22960,
    Model = "models/weapons/arccw/c_ud_mini14.mdl",
    Material = "entities/arccw_ud_mini14.png",
    Weight = 2.9,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_mini14",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_870", {
    Name = "Remington 870",
    Description = "Classic pump-action shotgun, renowned for its high quality parts and assembly. A simple firearm with a simple purpose.\nMarketed primarily to civilians for use in hunting game and self-defense, but it has found popularity among police departments for a relatively innocuous appearance and ability to accept custom loaded less-lethal shells.",
    Cost = 13915,
    Model = "models/weapons/arccw/c_ud_870.mdl",
    Material = "entities/arccw_ud_870.png",
    Weight = 3.2,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_870",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ud_uzi", {
    Name = "Uzi",
    Description = "Revolutionary submachine gun developed to arm a young State of Israel following the Second World War. Its ergonomic design, low cost, reliability, and great handling made it popular among militaries, police forces, and private security firms worldwide.\n\nBoasts excellent recoil control partially due to a below average cyclic rate. Good for hip firing in close quarters.",
    Cost = 10635,
    Model = "models/weapons/arccw/c_ud_uzi.mdl",
    Material = "entities/arccw_ud_uzi.png",
    Weight = 3.5,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ud_uzi",

    ArcCWCompatible = true
})

-- Urban Renewal --


GM:CreateItem("arccw_ur_ak", {
    Name = "AKM",
    Description = [[One of the first assault rifles, wielded around the world to this day for its cheap price, quick production, ease of maintenance, and infallible reliability. Consequently, it has become the most popular rifle ever; a constant of freedom fighters and third-world armies virtually everywhere. One fifth of all small arms in existence can be traced to this design.

The default pattern is well-rounded and hard-hitting, but kicks harder than other weapons of its class.]],
    Cost = 32535,
    Model = "models/weapons/w_rif_ak47.mdl",    --"models/weapons/arccw/c_ur_ak.mdl", replaced since it's a buggy model
    Material = "entities/arccw_ur_ak.png",
    Weight = 3.3,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_ak",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_aw", {
    Name = "AWP",
    Description = "A heavy rifle purpose-built for extreme range combat under extreme climates, first developed for the British military but quickly adopted by many more. Iconic for its appearance among military and police marksmen, this rifle is a symbol of discipline and order.\n\nOffers outstanding precision and kill potential, but its long bolt pull and reload time can become a hinderance outside its ideal engagement range.\n\nOne shot. One kill. You know the routine.",
    Cost = 36360,
    Model = "models/weapons/arccw/c_ur_aw.mdl",
    Material = "entities/arccw_ur_aw.png",
    Weight = 7.3,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_aw",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_deagle", {
    Name = "Desert Eagle",
    Description = "Unorthodox pistol in both weight and design, marketed as an alternative to high-caliber revolvers. Its huge rounds, unrivaled in power for a handgun cartridge, can easily blast a human skull apart.\nDespite being one of the most famous weapons in action culture, it rarely sees practical use because of its massive, bulky frame and pointlessly large caliber.\n\nWe both know that won't stop you.",
    Cost = 6605,
    Model = "models/weapons/arccw/c_ud_deagle.mdl",
    Material = "entities/arccw_ur_deagle.png",
    Weight = 1.77,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_deagle",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_g3", {
    Name = "G3A3",
    Description = "Heckler & Koch's earliest major weapon design, conceived in collaboration with Spanish research group CETME. As a pioneer of the roller-delay system, its success within the Bundeswehr inspired HK to derive subsequent designs from its layout, including the MP5 submachine gun.\n\nWell known for its excellent accuracy and range, but its powerful cartridge makes sustained fire difficult.",
    Cost = 41655,
    Model = "models/weapons/arccw/c_ur_g3.mdl",
    Material = "entities/arccw_ur_g3.png",
    Weight = 4.38,
    Supply = 1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_g3",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_db", {
    Name = "IZh-58",
    Description = "The design of the double-barrel shotgun is so ubiquitous that it is usually referred to by weapon class instead of model name. These traditional shotguns are very popular in both rural and urban communities around the world for their simplicity and reliability.\n\nBoth barrels can be fired back-to-back in quick, deadly succession, but they must be reloaded frequently. Switch to burst firemode to pull both triggers at once.",
    Cost = 3355,
    Model = "models/weapons/arccw/c_ur_dbs.mdl",
    Material = "entities/arccw_ur_db.png",
    Weight = 3.2,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_db",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_m1911", {
    Name = "M1911",
    Description = "Venerable semi-automatic pistol issued by the US Army throughout both World Wars and then some. Even after more than a century of service, it is rarely considered an obsolete design, and its short recoil mechanism has been inherited by most modern pistols.\n\nEasy to handle and packing respectable stopping power, the antiquated single-stack magazine is its only notable downside.",
    Cost = 2360,
    Model = "models/weapons/arccw/c_ur_m1911.mdl",
    Material = "entities/arccw_ur_m1911.png",
    Weight = 1.1,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_m1911",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_329", {
    Name = "Model 329PD",
    Description = "Though commonly viewed as archaic, revolvers maintain a large following today for their reliability, accuracy, and evocative sentiment. This model was famously \"the most powerful handgun in the world\" at its time, though its usurpers have not changed the fact that it packs a mean punch.\n\nHas a heavy trigger pull. Single-action mode removes trigger delay and increases accuracy, but requires manual cocking of the hammer.",
    Cost = 3650,
    Model = "models/weapons/arccw/c_ur_329pd.mdl",
    Material = "entities/arccw_ur_329.png",
    Weight = 0.72,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_329",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_mp5", {
    Name = "MP5A4",
    Description = "Versatile submachine gun known for its use by high profile police units around the world, most famously by the British SAS during the Iranian embassy siege. Its reliable closed-bolt design and craftsmanship allowed it to remain relevant among new generations of submachine guns.\n\nIf accurate, sophisticated close-combat performance is what you're looking for, no weapon has a better track record.\n\nSwitch to burst fire mode to reduce dispersion from moving and hipfiring.",
    Cost = 12305,
    Model = "models/weapons/arccw/c_ur_mp5.mdl",
    Material = "entities/arccw_ur_mp5.png",
    Weight = 3.04,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_mp5",

    ArcCWCompatible = true
})

GM:CreateItem("arccw_ur_spas12", {
    Name = "Spas-12",
    Description = "Flexible combat shotgun with the ability to toggle between manual and semi-automatic action. This \"dual-mode operation\" allows the weapon to cycle low pressure, less-lethal rounds that lack the energy to extract themselves.\nThe weapon's attempts to reach the American civilian market may have been slowed by legal challenges, but it remains prominent in popular culture for its intimidating and tactical appearance.\n\nHighly versatile, but encumbering to carry and difficult to reload. Switch to pump-action mode to tighten spread and conserve ammo.",
    Cost = 23015,
    Model = "models/weapons/arccw/c_ur_spas12.mdl",
    Material = "entities/arccw_ur_spas12.png",
    Weight = 4.4,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_ur_spas12",

    ArcCWCompatible = true
})




-- Other



GM:CreateItem("midnights_gso_xm8", {
    Name = "XM-8",
    Description = "",
    Cost = 1,
    Model = "models/weapons/arccw/c_ur_spas12.mdl",
    Material = "entities/midnights_gso_xm8.png",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "midnights_gso_xm8",

    ArcCWCompatible = true
})


GM:CreateItem("arccw_uc_usp", {
    Name = "USP",
    Description = "",
    Cost = 1,
    Model = "models/weapons/arccw/c_ur_spas12.mdl",
    Material = "entities/arccw_uc_usp.png",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_uc_usp",

    ArcCWCompatible = true
})


GM:CreateItem("arccw_midnightwolf_type20", {
    Name = "Type 20",
    Description = "",
    Cost = 1,
    Model = "models/weapons/arccw/c_ur_spas12.mdl",
    Material = "entities/arccw_midnightwolf_type20.png",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_midnightwolf_type20",

    ArcCWCompatible = true
})


GM:CreateItem("arccw_myt_uc_scar", {
    Name = "Scar-H",
    Description = "",
    Cost = 1,
    Model = "models/weapons/arccw/c_ur_spas12.mdl",
    Material = "entities/arccw_myt_uc_scar.png",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "arccw_myt_uc_scar",

    ArcCWCompatible = true
})
