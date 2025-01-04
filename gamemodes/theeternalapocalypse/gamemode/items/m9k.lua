-- M9k Weapons --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, { -- It's necessary to use the Entity Classname here for the weapon.
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = 2,
    UseFunc = function(ply) UseFunc_EquipGun(ply, itemid) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, itemid) UseFunc_StripWeapon(ply, itemid, drop)

-- Additional variables if needed
    IsSecret = false,
})

]]

-- Pistols and Revolvers

GM:CreateItem("m9k_coltpython", {
    Cost = 2800,
    Model = "models/weapons/w_colt_python.mdl",
    Weight = 1.36,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_coltpython") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_coltpython") UseFunc_StripWeapon(ply, "m9k_coltpython", drop) return drop end
})

GM:CreateItem("m9k_glock", {
    Cost = 5600,
    Model = "models/weapons/w_dmg_glock.mdl",
    Weight = 1.56,
    Supply = 0,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_glock") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_glock") UseFunc_StripWeapon(ply, "m9k_glock", drop) return drop end
})

GM:CreateItem("m9k_hk45", {
    Cost = 2650,
    Model = "models/weapons/w_hk45c.mdl",
    Weight = 0.96,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_hk45") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_hk45") UseFunc_StripWeapon(ply, "m9k_hk45", drop) return drop end
})

GM:CreateItem("m9k_m92beretta", {
    Cost = 2700,
    Model = "models/weapons/w_beretta_m92.mdl",
    Weight = 1.16,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m92beretta") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m92beretta") UseFunc_StripWeapon(ply, "m9k_m92beretta", drop) return drop end
})

GM:CreateItem("m9k_luger", {
    Cost = 2750,
    Model = "models/weapons/w_luger_p08.mdl",
    Weight = 1.09,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_luger") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_luger") UseFunc_StripWeapon(ply, "m9k_luger", drop) return drop end
})

GM:CreateItem("m9k_ragingbull", {
    Cost = 4225,
    Model = "models/weapons/w_taurus_raging_bull.mdl",
    Weight = 2.16,
    Supply = 0,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ragingbull") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ragingbull") UseFunc_StripWeapon(ply, "m9k_ragingbull", drop) return drop end
})

GM:CreateItem("m9k_scoped_taurus", {
    Cost = 5500,
    Model = "models/weapons/w_raging_bull_scoped.mdl",
    Weight = 2.56,
    Supply = 0,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_scoped_taurus") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_scoped_taurus") UseFunc_StripWeapon(ply, "m9k_scoped_taurus", drop) return drop end
})

GM:CreateItem("m9k_remington1858", {
    Cost = 3675,
    Model = "models/weapons/w_remington_1858.mdl",
    Weight = 1.46,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_remington1858") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington1858") UseFunc_StripWeapon(ply, "m9k_remington1858", drop) return drop end
})

GM:CreateItem("m9k_model3russian", {
    Cost = 3700,
    Model = "models/weapons/w_model_3_rus.mdl",
    Weight = 1.38,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model3russian") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model3russian") UseFunc_StripWeapon(ply, "m9k_model3russian", drop) return drop end
})

GM:CreateItem("m9k_model500", {
    Cost = 4550,
    Model = "models/weapons/w_sw_model_500.mdl",
    Weight = 1.86,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model500") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model500") UseFunc_StripWeapon(ply, "m9k_model500", drop) return drop end
})

GM:CreateItem("m9k_model627", {
    Cost = 4675,
    Model = "models/weapons/w_sw_model_627.mdl",
    Weight = 1.46,
    Supply = 1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_model627") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_model627") UseFunc_StripWeapon(ply, "m9k_model627", drop) return drop end
})

GM:CreateItem("m9k_sig_p229r", {
    Cost = 3850,
    Model = "models/weapons/w_sig_229r.mdl",
    Weight = 1.31,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_sig_p229r") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sig_p229r") UseFunc_StripWeapon(ply, "m9k_sig_p229r", drop) return drop end
})


-- Assault Rifles


GM:CreateItem("m9k_acr", {
    Cost = 29500,
    Model = "models/weapons/w_masada_acr.mdl",
    Weight = 4.2,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_acr") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_acr") UseFunc_StripWeapon(ply, "m9k_acr", drop) return drop end
})

GM:CreateItem("m9k_ak47", {
    Cost = 22250,
    Model = "models/weapons/w_ak47_m9k.mdl",
    Weight = 3.8,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ak47") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak47") UseFunc_StripWeapon(ply, "m9k_ak47", drop) return drop end
})

GM:CreateItem("m9k_ak74", {
    Cost = 22750,
    Model = "models/weapons/w_tct_ak47.mdl",
    Weight = 3.66,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ak74") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ak74") UseFunc_StripWeapon(ply, "m9k_ak74", drop) return drop end
})

GM:CreateItem("m9k_amd65", {
    Cost = 26500,
    Model = "models/weapons/w_amd_65.mdl",
    Weight = 3.9,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_amd65") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_amd65") UseFunc_StripWeapon(ply, "m9k_amd65", drop) return drop end
})

GM:CreateItem("m9k_an94", {
    Cost = 31250,
    Model = "models/weapons/w_rif_an_94.mdl",
    Weight = 4.4,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_an94") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_an94") UseFunc_StripWeapon(ply, "m9k_an94", drop) return drop end
})

GM:CreateItem("m9k_val", {
    Cost = 33000,
    Model = "models/weapons/w_dmg_vally.mdl",
    Weight = 2.8,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_val") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_val") UseFunc_StripWeapon(ply, "m9k_val", drop) return drop end
})

GM:CreateItem("m9k_f2000", {
    Cost = 35750,
    Model = "models/weapons/w_fn_f2000.mdl",
    Weight = 5.24,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_f2000") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_f2000") UseFunc_StripWeapon(ply, "m9k_f2000", drop) return drop end
})

GM:CreateItem("m9k_fal", {
    Cost = 28750,
    Model = "models/weapons/w_fn_fal.mdl",
    Weight = 5.9,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_fal") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fal") UseFunc_StripWeapon(ply, "m9k_fal", drop) return drop end
})

GM:CreateItem("m9k_g36", {
    Cost = 33250,
    Model = "models/weapons/w_hk_g36c.mdl",
    Weight = 3.6,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_g36") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g36") UseFunc_StripWeapon(ply, "m9k_g36", drop) return drop end
})

GM:CreateItem("m9k_m416", {
    Cost = 31000,
    Model = "models/weapons/w_hk_416.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m416") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m416") UseFunc_StripWeapon(ply, "m9k_m416", drop) return drop end
})

GM:CreateItem("m9k_g3a3", {
    Cost = 35250,
    Model = "models/weapons/w_hk_g3.mdl",
    Weight = 5.8,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_g3a3") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_g3a3") UseFunc_StripWeapon(ply, "m9k_g3a3", drop) return drop end
})

GM:CreateItem("m9k_l85", {
    Cost = 36500,
    Model = "models/weapons/w_l85a2.mdl",
    Weight = 5,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_l85") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_l85") UseFunc_StripWeapon(ply, "m9k_l85", drop) return drop end
})

GM:CreateItem("m9k_m16a4_acog", {
    Cost = 35000,
    Model = "models/weapons/w_dmg_m16ag.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m16a4_acog") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m16a4_acog") UseFunc_StripWeapon(ply, "m9k_m16a4_acog", drop) return drop end
})

GM:CreateItem("m9k_vikhr", {
    Cost = 23500,
    Model = "models/weapons/w_dmg_vikhr.mdl",
    Weight = 3.68,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_vikhr") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vikhr") UseFunc_StripWeapon(ply, "m9k_vikhr", drop) return drop end
})

GM:CreateItem("m9k_auga3", {
    Cost = 29500,
    Model = "models/weapons/w_auga3.mdl",
    Weight = 4.18,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_auga3") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_auga3") UseFunc_StripWeapon(ply, "m9k_auga3", drop) return drop end
})

GM:CreateItem("m9k_tar21", {
    Cost = 29500,
    Model = "models/weapons/w_imi_tar21.mdl",
    Weight = 3.35,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_tar21") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tar21") UseFunc_StripWeapon(ply, "m9k_tar21", drop) return drop end
})


-- Machine Guns


GM:CreateItem("m9k_ares_shrike", {
    Cost = 80750,
    Model = "models/weapons/w_ares_shrike.mdl",
    Weight = 9.85,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ares_shrike") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ares_shrike") UseFunc_StripWeapon(ply, "m9k_ares_shrike", drop) return drop end
})

GM:CreateItem("m9k_fg42", {
    Cost = 49000,
    Model = "models/weapons/w_fg42.mdl",
    Weight = 5.2,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_fg42") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_fg42") UseFunc_StripWeapon(ply, "m9k_fg42", drop) return drop end
})

GM:CreateItem("m9k_m1918bar", {
    Cost = 52500,
    Model = "models/weapons/w_m1918_bar.mdl",
    Weight = 5.6,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m1918bar") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m1918bar") UseFunc_StripWeapon(ply, "m9k_m1918bar", drop) return drop end
})

GM:CreateItem("m9k_m60", {
    Cost = 93000,
    Model = "models/weapons/w_m60_machine_gun.mdl",
    Weight = 9.8,
    Supply = 1,
    Rarity = 8,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m60") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m60") UseFunc_StripWeapon(ply, "m9k_m60", drop) return drop end
})

GM:CreateItem("m9k_pkm", {
    Cost = 81500,
    Model = "models/weapons/w_mach_russ_pkm.mdl",
    Weight = 8.5,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_pkm") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_pkm") UseFunc_StripWeapon(ply, "m9k_pkm", drop) return drop end
})


-- Shotguns


GM:CreateItem("m9k_m3", {
    Cost = 31500,
    Model = "models/weapons/w_benelli_m3.mdl",
    Weight = 3.62,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m3") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m3") UseFunc_StripWeapon(ply, "m9k_m3", drop) return drop end
})

GM:CreateItem("m9k_browningauto5", {
    Cost = 37250,
    Model = "models/weapons/w_browning_auto.mdl",
    Weight = 4.4,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_browningauto5") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_browningauto5") UseFunc_StripWeapon(ply, "m9k_browningauto5", drop) return drop end
})

GM:CreateItem("m9k_ithacam37", {
    Cost = 34250,
    Model = "models/weapons/w_ithaca_m37.mdl",
    Weight = 3.45,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ithacam37") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ithacam37") UseFunc_StripWeapon(ply, "m9k_ithacam37", drop) return drop end
})

GM:CreateItem("m9k_mossberg590", {
    Cost = 34150,
    Model = "models/weapons/w_mossberg_590.mdl",
    Weight = 3.69,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mossberg590") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mossberg590") UseFunc_StripWeapon(ply, "m9k_mossberg590", drop) return drop end
})

GM:CreateItem("m9k_jackhammer", {
    Cost = 40000,
    Model = "models/weapons/w_pancor_jackhammer.mdl",
    Weight = 4.6,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_jackhammer") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_jackhammer") UseFunc_StripWeapon(ply, "m9k_jackhammer", drop) return drop end
})

GM:CreateItem("m9k_spas12", {
    Cost = 44500,
    Model = "models/weapons/w_spas_12.mdl",
    Weight = 4.2,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_spas12") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_spas12") UseFunc_StripWeapon(ply, "m9k_spas12", drop) return drop end
})

GM:CreateItem("m9k_striker12", {
    Cost = 42250,
    Model = "models/weapons/w_striker_12g.mdl",
    Weight = 3.66,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_striker12") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_striker12") UseFunc_StripWeapon(ply, "m9k_striker12", drop) return drop end
})

GM:CreateItem("m9k_1897winchester", {
    Cost = 34500,
    Model = "models/weapons/w_winchester_1897_trench.mdl",
    Weight = 3.2,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_1897winchester") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1897winchester") UseFunc_StripWeapon(ply, "m9k_1897winchester", drop) return drop end
})

GM:CreateItem("m9k_1887winchester", {
    Cost = 33750,
    Model = "models/weapons/w_winchester_1887.mdl",
    Weight = 3.12,
    Supply = 1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_1887winchester") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_1887winchester") UseFunc_StripWeapon(ply, "m9k_1887winchester", drop) return drop end
})


-- Sniper Rifles


GM:CreateItem("m9k_barret_m82", {
    Cost = 84000,
    Model = "models/weapons/w_barret_m82.mdl",
    Weight = 11.85,
    Supply = -1,
    Rarity = 8,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_barret_m82") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_barret_m82") UseFunc_StripWeapon(ply, "m9k_barret_m82", drop) return drop end
})

GM:CreateItem("m9k_m98b", {
    Cost = 66000,
    Model = "models/weapons/w_barrett_m98b.mdl",
    Weight = 10.95,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m98b") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m98b") UseFunc_StripWeapon(ply, "m9k_m98b", drop) return drop end
})

GM:CreateItem("m9k_svu", {
    Cost = 68500,
    Model = "models/weapons/w_dragunov_svu.mdl",
    Weight = 5.44,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_svu") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svu") UseFunc_StripWeapon(ply, "m9k_svu", drop) return drop end
})

GM:CreateItem("m9k_sl8", {
    Cost = 49500,
    Model = "models/weapons/w_snip_int.mdl",
    Weight = 4.92,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_sl8") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_sl8") UseFunc_StripWeapon(ply, "m9k_sl8", drop) return drop end
})

GM:CreateItem("m9k_intervention", {
    Cost = 47250,
    Model = "models/weapons/w_snip_int.mdl",
    Weight = 8.46,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_intervention") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_intervention") UseFunc_StripWeapon(ply, "m9k_intervention", drop) return drop end
})

GM:CreateItem("m9k_m24", {
    Cost = 58750,
    Model = "models/weapons/w_snip_m24_6.mdl",
    Weight = 7.98,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_m24") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_m24") UseFunc_StripWeapon(ply, "m9k_m24", drop) return drop end
})

GM:CreateItem("m9k_psg1", {
    Cost = 61250,
    Model = "models/weapons/w_hk_psg1.mdl",
    Weight = 8.28,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_psg1") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_psg1") UseFunc_StripWeapon(ply, "m9k_psg1", drop) return drop end
})

GM:CreateItem("m9k_remington7615p", {
    Cost = 11000,
    Model = "models/weapons/w_remington_7615p.mdl",
    Weight = 5.65,
    Supply = -1,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_remington7615p") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_remington7615p") UseFunc_StripWeapon(ply, "m9k_remington7615p", drop) return drop end
})

GM:CreateItem("m9k_svt40", {
    Cost = 57500,
    Model = "models/weapons/w_svt_40.mdl",
    Weight = 5.48,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_svt40") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_svt40") UseFunc_StripWeapon(ply, "m9k_svt40", drop) return drop end
})

GM:CreateItem("m9k_contender", {
    Cost = 41000,
    Model = "models/weapons/w_g2_contender.mdl",
    Weight = 4.18,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_contender") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_contender") UseFunc_StripWeapon(ply, "m9k_contender", drop) return drop end
})

GM:CreateItem("m9k_honeybadger", {
    Cost = 46750,
    Model = "models/weapons/w_aac_honeybadger.mdl",
    Weight = 4.44,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_honeybadger") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_honeybadger") UseFunc_StripWeapon(ply, "m9k_honeybadger", drop) return drop end
})


-- SMG guns


GM:CreateItem("m9k_mp5", {
    Cost = 21500,
    Model = "models/weapons/w_hk_mp5.mdl",
    Weight = 3.15,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp5") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5") UseFunc_StripWeapon(ply, "m9k_mp5", drop) return drop end
})

GM:CreateItem("m9k_mp7", {
    Cost = 22250,
    Model = "models/weapons/w_mp7_silenced.mdl",
    Weight = 3.2,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp7") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp7") UseFunc_StripWeapon(ply, "m9k_mp7", drop) return drop end
})

GM:CreateItem("m9k_ump45", {
    Cost = 19200,
    Model = "models/weapons/w_hk_ump45.mdl",
    Weight = 2.95,
    Supply = 1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_ump45") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_ump45") UseFunc_StripWeapon(ply, "m9k_ump45", drop) return drop end
})

GM:CreateItem("m9k_kac_pdw", {
    Cost = 21350,
    Model = "models/weapons/w_kac_pdw.mdl",
    Weight = 3.12,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_kac_pdw") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_kac_pdw") UseFunc_StripWeapon(ply, "m9k_kac_pdw", drop) return drop end
})

GM:CreateItem("m9k_vector", {
    Cost = 27150,
    Model = "models/weapons/w_kriss_vector.mdl",
    Weight = 3.1,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_vector") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_vector") UseFunc_StripWeapon(ply, "m9k_vector", drop) return drop end
})

GM:CreateItem("m9k_magpulpdr", {
    Cost = 24150,
    Model = "models/weapons/w_magpul_pdr.mdl",
    Weight = 3.16,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_magpulpdr") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_magpulpdr") UseFunc_StripWeapon(ply, "m9k_magpulpdr", drop) return drop end
})

GM:CreateItem("m9k_mp5sd", {
    Cost = 23400,
    Model = "models/weapons/w_hk_mp5sd.mdl",
    Weight = 2.85,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp5sd") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp5sd") UseFunc_StripWeapon(ply, "m9k_mp5sd", drop) return drop end
})

GM:CreateItem("m9k_mp9", {
    Cost = 24600,
    Model = "models/weapons/w_brugger_thomet_mp9.mdl",
    Weight = 2.68,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_mp9") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_mp9") UseFunc_StripWeapon(ply, "m9k_mp9", drop) return drop end
})

GM:CreateItem("m9k_tec9", {
    Cost = 16800,
    Model = "models/weapons/w_intratec_tec9.mdl",
    Weight = 2.38,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_tec9") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_tec9") UseFunc_StripWeapon(ply, "m9k_tec9", drop) return drop end
})

GM:CreateItem("m9k_thompson", {
    Cost = 24250,
    Model = "models/weapons/w_tommy_gun.mdl",
    Weight = 3.84,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_thompson") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_thompson") UseFunc_StripWeapon(ply, "m9k_thompson", drop) return drop end
})

GM:CreateItem("m9k_uzi", {
    Cost = 19000,
    Model = "models/weapons/w_uzi_imi.mdl",
    Weight = 2.95,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "m9k_uzi") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "m9k_uzi") UseFunc_StripWeapon(ply, "m9k_uzi", drop) return drop end
})
