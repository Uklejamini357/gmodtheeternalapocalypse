-- M9k Weapons --

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

i = GM:CreateItem("item_m9k_assaultammo", {
    Cost = 95,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "AR2") return bool end,
})

i = GM:CreateItem("item_m9k_sniperammo", {
    Cost = 150,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "SniperPenetratedRound") return bool end,
})


-- Pistols and Revolvers

GM:CreateItem("m9k_coltpython", {
    Cost = 900,
    Model = "models/weapons/w_colt_python.mdl",
    Weight = 1.36,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_coltpython"
})

GM:CreateItem("m9k_glock", {
    Cost = 3000,
    Model = "models/weapons/w_dmg_glock.mdl",
    Weight = 1.56,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_glock"
})

GM:CreateItem("m9k_hk45", {
    Cost = 2400,
    Model = "models/weapons/w_hk45c.mdl",
    Weight = 0.96,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_hk45"
})

GM:CreateItem("m9k_m92beretta", {
    Cost = 700,
    Model = "models/weapons/w_beretta_m92.mdl",
    Weight = 1.16,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m92beretta"
})

GM:CreateItem("m9k_luger", {
    Cost = 2500,
    Model = "models/weapons/w_luger_p08.mdl",
    Weight = 1.09,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_luger"
})

GM:CreateItem("m9k_ragingbull", {
    Cost = 1500,
    Model = "models/weapons/w_taurus_raging_bull.mdl",
    Weight = 2.16,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ragingbull"
})

GM:CreateItem("m9k_scoped_taurus", {
    Cost = 2500,
    Model = "models/weapons/w_raging_bull_scoped.mdl",
    Weight = 2.56,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_scoped_taurus"
})

GM:CreateItem("m9k_remington1858", {
    Cost = 1680,
    Model = "models/weapons/w_remington_1858.mdl",
    Weight = 1.46,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_remington1858"
})

GM:CreateItem("m9k_model3russian", {
    Cost = 1120,
    Model = "models/weapons/w_model_3_rus.mdl",
    Weight = 1.38,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_model3russian"
})

GM:CreateItem("m9k_model500", {
    Cost = 2020,
    Model = "models/weapons/w_sw_model_500.mdl",
    Weight = 1.86,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_model500"
})

GM:CreateItem("m9k_model627", {
    Cost = 650,
    Model = "models/weapons/w_sw_model_627.mdl",
    Weight = 1.46,
    Supply = 1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_model627"
})

GM:CreateItem("m9k_sig_p229r", {
    Cost = 1330,
    Model = "models/weapons/w_sig_229r.mdl",
    Weight = 1.31,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_sig_p229r"
})


-- Assault Rifles


GM:CreateItem("m9k_acr", {
    Cost = 29500,
    Model = "models/weapons/w_masada_acr.mdl",
    Weight = 4.2,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_acr"
})

GM:CreateItem("m9k_ak47", {
    Cost = 17250,
    Model = "models/weapons/w_ak47_m9k.mdl",
    Weight = 3.8,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ak47"
})

GM:CreateItem("m9k_ak74", {
    Cost = 18450,
    Model = "models/weapons/w_tct_ak47.mdl",
    Weight = 3.66,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ak74"
})

GM:CreateItem("m9k_amd65", {
    Cost = 26500,
    Model = "models/weapons/w_amd_65.mdl",
    Weight = 3.9,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_amd65"
})

GM:CreateItem("m9k_an94", {
    Cost = 28250, -- burst fire makes this a powerful weapon
    Model = "models/weapons/w_rif_an_94.mdl",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_an94"
})

GM:CreateItem("m9k_val", {
    Cost = 31000,
    Model = "models/weapons/w_dmg_vally.mdl",
    Weight = 3.3,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_val"
})

GM:CreateItem("m9k_f2000", {
    Cost = 22750,
    Model = "models/weapons/w_fn_f2000.mdl",
    Weight = 5.24,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_f2000"
})

GM:CreateItem("m9k_fal", {
    Cost = 28750,
    Model = "models/weapons/w_fn_fal.mdl",
    Weight = 5.9,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_fal"
})

GM:CreateItem("m9k_g36", {
    Cost = 23250,
    Model = "models/weapons/w_hk_g36c.mdl",
    Weight = 3.6,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_g36"
})

GM:CreateItem("m9k_m416", {
    Cost = 31000,
    Model = "models/weapons/w_hk_416.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m416"
})

GM:CreateItem("m9k_g3a3", {
    Cost = 22250,
    Model = "models/weapons/w_hk_g3.mdl",
    Weight = 5.8,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_g3a3"
})

GM:CreateItem("m9k_l85", {
    Cost = 26500,
    Model = "models/weapons/w_l85a2.mdl",
    Weight = 5,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_l85"
})

GM:CreateItem("m9k_m16a4_acog", {
    Cost = 35000,
    Model = "models/weapons/w_dmg_m16ag.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m16a4_acog"
})

GM:CreateItem("m9k_vikhr", {
    Cost = 33500,
    Model = "models/weapons/w_dmg_vikhr.mdl",
    Weight = 3.68,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_vikhr"
})

GM:CreateItem("m9k_auga3", {
    Cost = 15500,
    Model = "models/weapons/w_auga3.mdl",
    Weight = 4.18,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_auga3"
})

GM:CreateItem("m9k_tar21", {
    Cost = 39500,
    Model = "models/weapons/w_imi_tar21.mdl",
    Weight = 3.35,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_tar21"
})


-- Machine Guns


GM:CreateItem("m9k_ares_shrike", {
    Cost = 64750,
    Model = "models/weapons/w_ares_shrike.mdl",
    Weight = 9.85,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ares_shrike"
})

GM:CreateItem("m9k_fg42", {
    Cost = 55000,
    Model = "models/weapons/w_fg42.mdl",
    Weight = 5.2,
    Supply = 0,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_fg42"
})

-- This one is incredibly powerful yet heavy. well! here goes nothing...
GM:CreateItem("m9k_minigun", {
    Cost = 325175,
    Model = "models/weapons/w_m134_minigun.mdl",
    Weight = 5.2,
    Supply = 0,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_minigun"
})

GM:CreateItem("m9k_m1918bar", {
    Cost = 35000,
    Model = "models/weapons/w_m1918_bar.mdl",
    Weight = 5.16,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m1918bar"
})

GM:CreateItem("m9k_m60", {
    Cost = 78590,
    Model = "models/weapons/w_m60_machine_gun.mdl",
    Weight = 9.8,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m60"
})

GM:CreateItem("m9k_pkm", {
    Cost = 61220,
    Model = "models/weapons/w_mach_russ_pkm.mdl",
    Weight = 8.5,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_pkm"
})


-- Shotguns


GM:CreateItem("m9k_m3", {
    Cost = 11500,
    Model = "models/weapons/w_benelli_m3.mdl",
    Weight = 3.62,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m3"
})

GM:CreateItem("m9k_browningauto5", {
    Cost = 19250,
    Model = "models/weapons/w_browning_auto.mdl",
    Weight = 4.4,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_browningauto5"
})

GM:CreateItem("m9k_ithacam37", {
    Cost = 14350,
    Model = "models/weapons/w_ithaca_m37.mdl",
    Weight = 3.45,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ithacam37"
})

GM:CreateItem("m9k_mossberg590", {
    Cost = 16150,
    Model = "models/weapons/w_mossberg_590.mdl",
    Weight = 3.69,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_mossberg590"
})

GM:CreateItem("m9k_jackhammer", {
    Cost = 18650,
    Model = "models/weapons/w_pancor_jackhammer.mdl",
    Weight = 4.6,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_jackhammer"
})

GM:CreateItem("m9k_spas12", {
    Cost = 64500,
    Model = "models/weapons/w_spas_12.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_spas12"
})

GM:CreateItem("m9k_striker12", {
    Cost = 27250,
    Model = "models/weapons/w_striker_12g.mdl",
    Weight = 3.66,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_striker12"
})

GM:CreateItem("m9k_1897winchester", {
    Cost = 14500,
    Model = "models/weapons/w_winchester_1897_trench.mdl",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_1897winchester"
})

GM:CreateItem("m9k_1887winchester", {
    Cost = 13750,
    Model = "models/weapons/w_winchester_1887.mdl",
    Weight = 3.12,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_1887winchester"
})


-- Sniper Rifles


GM:CreateItem("m9k_barret_m82", {
    Cost = 64000,
    Model = "models/weapons/w_barret_m82.mdl",
    Weight = 11.85,
    Supply = -1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_barret_m82"
})

GM:CreateItem("m9k_m98b", {
    Cost = 46000,
    Model = "models/weapons/w_barrett_m98b.mdl",
    Weight = 10.95,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m98b"
})

GM:CreateItem("m9k_svu", {
    Cost = 68500,
    Model = "models/weapons/w_dragunov_svu.mdl",
    Weight = 5.44,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_svu"
})

GM:CreateItem("m9k_sl8", {
    Cost = 36500,
    Model = "models/weapons/w_snip_int.mdl",
    Weight = 4.92,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_sl8"
})

GM:CreateItem("m9k_intervention", {
    Cost = 36550,
    Model = "models/weapons/w_snip_int.mdl",
    Weight = 8.46,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_intervention"
})

GM:CreateItem("m9k_m24", {
    Cost = 29900,
    Model = "models/weapons/w_snip_m24_6.mdl",
    Weight = 7.98,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_m24"
})

GM:CreateItem("m9k_psg1", {
    Cost = 66250,
    Model = "models/weapons/w_hk_psg1.mdl",
    Weight = 8.28,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_psg1"
})

-- who tf made this weapon weak?!?!?
GM:CreateItem("m9k_remington7615p", {
    Cost = 4000,
    Model = "models/weapons/w_remington_7615p.mdl",
    Weight = 5.65,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_remington7615p"
})

GM:CreateItem("m9k_svt40", {
    Cost = 43500,
    Model = "models/weapons/w_svt_40.mdl",
    Weight = 5.48,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_svt40"
})

GM:CreateItem("m9k_contender", {
    Cost = 8000,
    Model = "models/weapons/w_g2_contender.mdl",
    Weight = 3.65,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_contender"
})


-- SMG guns



GM:CreateItem("m9k_honeybadger", {
    Cost = 19640,
    Model = "models/weapons/w_aac_honeybadger.mdl",
    Weight = 4.24,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_honeybadger"
})

GM:CreateItem("m9k_mp5", {
    Cost = 18350,
    Model = "models/weapons/w_hk_mp5.mdl",
    Weight = 3.15,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_mp5"
})

GM:CreateItem("m9k_mp7", {
    Cost = 22250,
    Model = "models/weapons/w_mp7_silenced.mdl",
    Weight = 3.2,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_mp7"
})

GM:CreateItem("m9k_ump45", {
    Cost = 13200,
    Model = "models/weapons/w_hk_ump45.mdl",
    Weight = 2.95,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_ump45"
})

GM:CreateItem("m9k_kac_pdw", {
    Cost = 2650,
    Model = "models/weapons/w_kac_pdw.mdl",
    Weight = 3.12,
    Supply = 1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_kac_pdw"
})

GM:CreateItem("m9k_vector", {
    Cost = 16150,
    Model = "models/weapons/w_kriss_vector.mdl",
    Weight = 3.1,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_vector"
})

GM:CreateItem("m9k_magpulpdr", {
    Cost = 22150,
    Model = "models/weapons/w_magpul_pdr.mdl",
    Weight = 3.16,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_magpulpdr"
})

GM:CreateItem("m9k_mp5sd", {
    Cost = 23400,
    Model = "models/weapons/w_hk_mp5sd.mdl",
    Weight = 2.85,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_mp5sd"
})

GM:CreateItem("m9k_mp9", {
    Cost = 16680,
    Model = "models/weapons/w_brugger_thomet_mp9.mdl",
    Weight = 2.68,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_mp9"
})

GM:CreateItem("m9k_tec9", {
    Cost = 6800,
    Model = "models/weapons/w_intratec_tec9.mdl",
    Weight = 2.38,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_tec9"
})

GM:CreateItem("m9k_thompson", {
    Cost = 9850,
    Model = "models/weapons/w_tommy_gun.mdl",
    Weight = 3.84,
    Supply = 1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_thompson"
})

GM:CreateItem("m9k_uzi", {
    Cost = 11250,
    Model = "models/weapons/w_uzi_imi.mdl",
    Weight = 2.95,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
	ItemType = ITEMTYPE_WEAPON,
    WeaponType = "m9k_uzi"
})
