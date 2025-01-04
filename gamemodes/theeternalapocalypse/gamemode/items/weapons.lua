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
    DropFunc = function(ply) return true end

-- Additional variables if needed
    IsSecret = false,
})

]]

-- Weapons


local i = GM:CreateItem("weapon_tea_noobcannon", {
    Cost = 0,
    Model = "models/weapons/w_pist_glock18.mdl",
    Weight = 1.1,
    Supply = -1, -- -1 stock means the traders will never sell this item (Comment: yea we get it)
    Rarity = 1,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_noobcannon") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_noobcannon") UseFunc_StripWeapon(ply, "weapon_tea_noobcannon", drop) return drop end
})

i = GM:CreateItem("weapon_tea_pigsticker", {
    Cost = 350,
    Model = "models/weapons/w_knife_ct.mdl",
    Weight = 0.38,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_pigsticker") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_pigsticker") UseFunc_StripWeapon(ply, "weapon_tea_pigsticker", drop) return drop end
})

i = GM:CreateItem("weapon_tea_axe", {
    Cost = 800,
    Model = "models/props/CS_militia/axe.mdl",
    Weight = 1.73,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_axe") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_axe") UseFunc_StripWeapon(ply, "weapon_tea_axe", drop) return drop end
})

i = GM:CreateItem("weapon_tea_wrench", {
    Cost = 800,
    Model = "models/props_c17/tools_wrench01a.mdl",
    Weight = 0.47,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_wrench") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_wrench") UseFunc_StripWeapon(ply, "weapon_tea_wrench", drop) return drop end
})

i = GM:CreateItem("weapon_tea_repair", {
    Cost = 5500,
    Model = "models/props_c17/tools_wrench01a.mdl",
    Weight = 0.58,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_repair") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_repair") UseFunc_StripWeapon(ply, "weapon_tea_repair", drop) return drop end
})

i = GM:CreateItem("weapon_tea_scrapsword", {
    Cost = 2000,
    Model = "models/props_c17/TrapPropeller_Blade.mdl",
    Weight = 5.3,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scrapsword") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scrapsword") UseFunc_StripWeapon(ply, "weapon_tea_scrapsword", drop) return drop end
})

i = GM:CreateItem("weapon_tea_g20", {
    Cost = 450,
    Model = "models/weapons/w_pist_glock18.mdl",
    Weight = 1.18,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_g20") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_g20") UseFunc_StripWeapon(ply, "weapon_tea_g20", drop) return drop end
})

i = GM:CreateItem("weapon_tea_57", {
    Cost = 600,
    Model = "models/weapons/w_pist_fiveseven.mdl",
    Weight = 0.82,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_57") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_57") UseFunc_StripWeapon(ply, "weapon_tea_57", drop) return drop end
})

i = GM:CreateItem("weapon_tea_u45", {
    Cost = 700,
    Model = "models/weapons/w_pist_usp.mdl",
    Weight = 1.1,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_u45") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_u45") UseFunc_StripWeapon(ply, "weapon_tea_u45", drop) return drop end
})

i = GM:CreateItem("weapon_tea_warren50", {
    Cost = 850,
    Model = "models/weapons/w_pist_deagle.mdl",
    Weight = 1.73,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_warren50") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_warren50") UseFunc_StripWeapon(ply, "weapon_tea_warren50", drop) return drop end
})

i = GM:CreateItem("weapon_tea_python", {
    Cost = 1200,
    Model = "models/weapons/w_357.mdl",
    Weight = 1.18,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_python") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_python") UseFunc_StripWeapon(ply, "weapon_tea_python", drop) return drop end
})

i = GM:CreateItem("weapon_tea_dual", {
    Cost = 2000,
    Model = "models/weapons/w_pist_elite.mdl",
    Weight = 2.72,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dual") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dual") UseFunc_StripWeapon(ply, "weapon_tea_dual", drop) return drop end
})

i = GM:CreateItem("weapon_tea_satan", {
    Cost = 2250,
    Model = "models/weapons/w_m29_satan.mdl",
    Weight = 3.14,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_satan") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_satan") UseFunc_StripWeapon(ply, "weapon_tea_satan", drop) return drop end
})

i = GM:CreateItem("weapon_tea_mp11", {
    Cost = 2250,
    Model = "models/weapons/w_smg_mac10.mdl",
    Weight = 2.85,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_mp11") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_mp11") UseFunc_StripWeapon(ply, "weapon_tea_mp11", drop) return drop end
})

i = GM:CreateItem("weapon_tea_rg900", {
    Cost = 2500,
    Model = "models/weapons/w_smg_tmp.mdl",
    Weight = 2.9,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_rg900") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_rg900") UseFunc_StripWeapon(ply, "weapon_tea_rg900", drop) return drop end
})

i = GM:CreateItem("weapon_tea_k5a", {
    Cost = 3250,
    Model = "models/weapons/w_smg_mp5.mdl",
    Weight = 3,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k5a") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k5a") UseFunc_StripWeapon(ply, "weapon_tea_k5a", drop) return drop end
})

i = GM:CreateItem("weapon_tea_stinger", {
    Cost = 2800,
    Model = "models/weapons/w_smg1.mdl",
    Weight = 3.85,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_stinger") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_stinger") UseFunc_StripWeapon(ply, "weapon_tea_stinger", drop) return drop end
})

i = GM:CreateItem("weapon_tea_bosch", {
    Cost = 3750,
    Model = "models/weapons/w_sten.mdl",
    Weight = 3.45,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_bosch") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_bosch") UseFunc_StripWeapon(ply, "weapon_tea_bosch", drop) return drop end
})

i = GM:CreateItem("weapon_tea_k8", {
    Cost = 5000,
    Model = "models/weapons/w_smg_ump45.mdl",
    Weight = 3.12,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k8") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k8") UseFunc_StripWeapon(ply, "weapon_tea_k8", drop) return drop end
})

i = GM:CreateItem("weapon_tea_k8c", {
    Cost = 5500,
    Model = "models/weapons/w_hk_usc.mdl",
    Weight = 3.15,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_k8c") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_k8c") UseFunc_StripWeapon(ply, "weapon_tea_k8c", drop) return drop end
})

i = GM:CreateItem("weapon_tea_shredder", {
    Cost = 7750,
    Model = "models/weapons/w_smg_p90.mdl",
    Weight = 3,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_shredder") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_shredder") UseFunc_StripWeapon(ply, "weapon_tea_shredder", drop) return drop end
})

i = GM:CreateItem("weapon_tea_enforcer", {
    Cost = 5000,
    Model = "models/weapons/w_shot_m3super90.mdl",
    Weight = 3.6,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_enforcer") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_enforcer") UseFunc_StripWeapon(ply, "weapon_tea_enforcer", drop) return drop end
})

i = GM:CreateItem("weapon_tea_sweeper", {
    Cost = 7750,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Weight = 3.8,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_sweeper") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_sweeper") UseFunc_StripWeapon(ply, "weapon_tea_sweeper", drop) return drop end
})

i = GM:CreateItem("weapon_tea_ranger", {
    Cost = 7250,
    Model = "models/weapons/w_rif_m4a1.mdl",
    Weight = 4.2,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_ranger") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_ranger") UseFunc_StripWeapon(ply, "weapon_tea_ranger", drop) return drop end
})

i = GM:CreateItem("weapon_tea_fusil", {
    Cost = 7150,
    Model = "models/weapons/w_rif_famas.mdl",
    Weight = 4,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_fusil") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_fusil") UseFunc_StripWeapon(ply, "weapon_tea_fusil", drop) return drop end
})

i = GM:CreateItem("weapon_tea_stugcommando", {
    Cost = 9750, 
    Model = "models/weapons/w_rif_sg552.mdl",
    Weight = 4.45,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_stugcommando") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_stugcommando") UseFunc_StripWeapon(ply, "weapon_tea_stugcommando", drop) return drop end
})

i = GM:CreateItem("weapon_tea_krukov", {
    Cost = 11000,
    Model = "models/weapons/w_rif_ak47.mdl",
    Weight = 3.76,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_krukov") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_krukov") UseFunc_StripWeapon(ply, "weapon_tea_krukov", drop) return drop end
})

i = GM:CreateItem("weapon_tea_krukov_uniq", {
    Cost = 185000,
    Model = "models/weapons/w_rif_ak47.mdl",
    Weight = 4.46,
    Supply = 0,
    Rarity = 8,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_krukov_uniq") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_krukov_uniq") UseFunc_StripWeapon(ply, "weapon_tea_krukov_uniq", drop) return drop end
})

i = GM:CreateItem("weapon_tea_l303", {
    Cost = 13500,
    Model = "models/weapons/w_rif_galil.mdl",
    Weight = 5.35,
    Supply = -1,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_l303") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_l303") UseFunc_StripWeapon(ply, "weapon_tea_l303", drop) return drop end
})

i = GM:CreateItem("weapon_tea_scar", {
    Cost = 22000,
    Model = "models/weapons/w_fn_scar_h.mdl",
    Weight = 4.6,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scar") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scar") UseFunc_StripWeapon(ply, "weapon_tea_scar", drop) return drop end
})

i = GM:CreateItem("weapon_tea_lmg", {
    Cost = 17250,
    Model = "models/weapons/w_mach_m249para.mdl",
    Weight = 7.5,
    Supply = 0,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_lmg") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_lmg") UseFunc_StripWeapon(ply, "weapon_tea_lmg", drop) return drop end
})

i = GM:CreateItem("weapon_tea_antelope", {
    Cost = 9200,
    Model = "models/weapons/w_snip_scout.mdl",
    Weight = 5.25,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_antelope") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_antelope") UseFunc_StripWeapon(ply, "weapon_tea_antelope", drop) return drop end
})

i = GM:CreateItem("weapon_tea_scimitar", {
    Cost = 12250,
    Model = "models/weapons/w_snip_g3sg1.mdl",
    Weight = 5.4,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scimitar") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scimitar") UseFunc_StripWeapon(ply, "weapon_tea_scimitar", drop) return drop end
})

i = GM:CreateItem("weapon_tea_blackhawk", {
    Cost = 15000,
    Model = "models/weapons/w_snip_sg550.mdl",
    Weight = 6.35,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_blackhawk") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_blackhawk") UseFunc_StripWeapon(ply, "weapon_tea_blackhawk", drop) return drop end
})

i = GM:CreateItem("weapon_tea_punisher", {
    Cost = 35000,
    Model = "models/weapons/w_acc_int_aw50.mdl",
    Weight = 7.95,
    Supply = 5,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_punisher") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_punisher") UseFunc_StripWeapon(ply, "weapon_tea_punisher", drop) return drop end
})

i = GM:CreateItem("weapon_tea_scrapcrossbow", {
    Cost = 15000,
    Model = "models/weapons/w_crossbow.mdl",
    Weight = 8,
    Supply = -1,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_scrapcrossbow") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_scrapcrossbow") UseFunc_StripWeapon(ply, "weapon_tea_scrapcrossbow", drop) return drop end
})

i = GM:CreateItem("weapon_tea_winchester", {
    Cost = 6500,
    Model = "models/weapons/w_winchester_1873.mdl",
    Weight = 5.32,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_winchester") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_winchester") UseFunc_StripWeapon(ply, "weapon_tea_winchester", drop) return drop end
})

i = GM:CreateItem("weapon_tea_perrin", {
    Cost = 8500,
    Model = "models/weapons/w_pp19_bizon.mdl",
    Weight = 3.72,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_perrin") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_perrin") UseFunc_StripWeapon(ply, "weapon_tea_perrin", drop) return drop end
})

i = GM:CreateItem("weapon_tea_dammerung", {
    Cost = 12200,
    Model = "models/weapons/w_usas_12.mdl",
    Weight = 6.72,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dammerung") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dammerung") UseFunc_StripWeapon(ply, "weapon_tea_dammerung", drop) return drop end
})

i = GM:CreateItem("weapon_tea_rpg", {
    Cost = 55000,
    Model = "models/weapons/w_rocket_launcher.mdl",
    Weight = 7.2,
    Supply = 0,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_rpg") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_rpg") UseFunc_StripWeapon(ply, "weapon_tea_rpg", drop) return drop end
})

i = GM:CreateItem("weapon_tea_fuckinator", {
    Cost = 28750,
    Model = "models/weapons/w_pist_p228.mdl",
    Weight = 8.74,
    Supply = -1,
    Rarity = 7,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_fuckinator") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_fuckinator") UseFunc_StripWeapon(ply, "weapon_tea_fuckinator", drop) return drop end
})

i = GM:CreateItem("weapon_tea_germanator", {
    Cost = 6800,
    Model = "models/weapons/w_mp40smg.mdl",
    Weight = 3.34,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_germanator") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_germanator") UseFunc_StripWeapon(ply, "weapon_tea_germanator", drop) return drop end
})

i = GM:CreateItem("weapon_tea_807", {
    Cost = 5800,
    Model = "models/weapons/w_remington_870_tact.mdl",
    Weight = 3.82,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_807") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_807") UseFunc_StripWeapon(ply, "weapon_tea_807", drop) return drop end
})

i = GM:CreateItem("weapon_tea_crowbar", {
    Cost = 50000,
    Model = "models/weapons/w_crowbar.mdl",
    Weight = 6.17,
    Supply = -1,
    Rarity = 9,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_crowbar") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_crowbar") UseFunc_StripWeapon(ply, "weapon_tea_crowbar", drop) return drop end
})



-- some ammunition


i = GM:CreateItem("item_pistolammo", {
    Cost = 45,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 1,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end
})

i = GM:CreateItem("item_m9k_smgammo", {
    Cost = 70,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "SMG1") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_smgammo") return drop end
})

i = GM:CreateItem("item_m9k_assaultammo", {
    Cost = 95,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "AR2") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_assaultammo") return drop end
})

i = GM:CreateItem("item_m9k_sniperammo", {
    Cost = 150,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "SniperPenetratedRound") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_m9k_sniperammo") return drop end
})

i = GM:CreateItem("item_magammo", {
    Cost = 60,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_357_jhp.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_magammo") return drop end
})

i = GM:CreateItem("item_buckshotammo", {
    Cost = 65,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_buckshotammo") return drop end
})

i = GM:CreateItem("item_rifleammo", {
    Cost = 90,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_rifleammo") return drop end
})

i = GM:CreateItem("item_sniperammo", {
    Cost = 130,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end
})

i = GM:CreateItem("item_minigunammo", {
    Cost = 1000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_792x33_ap.mdl", -- I'll find the right model for this soon, hopefully.
    Weight = 1,
    Supply = 0,
    Rarity = 4,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_minigun") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_minigunammo") return drop end
})

i = GM:CreateItem("item_ar2pulseammo", {
    Cost = 150,
    Model = "models/Items/combine_rifle_cartridge01.mdl",
    Weight = 1,
    Supply = 10,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_ar2_pulseammo") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_ar2pulseammo") return drop end
})

i = GM:CreateItem("item_crossbowbolt", {
    Cost = 40,
    Model = "models/Items/CrossbowRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = 2,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 6, "XBowBolt") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt") return drop end
})

i = GM:CreateItem("item_crossbowbolt_crate", {
    Cost = 150,
    Model = "models/Items/item_item_crate.mdl",
    Weight = 1.5,
    Supply = 0,
    Rarity = 3,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "XBowBolt") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt_crate") return drop end
})

i = GM:CreateItem("item_deadly_crossbowbolt", {
    Cost = 500,
    Model = "models/Items/CrossbowRounds.mdl",
    Weight = 0.8,
    Supply = 0,
    Rarity = 4,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "ammo_deadlybolt") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_deadly_crossbowbolt") return drop end
})

i = GM:CreateItem("item_rocketammo", {
    Cost = 180,
    Model = "models/weapons/w_missile_closed.mdl",
    Weight = 1.74,
    Supply = 0,
    Rarity = 3,
    Category = 2,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_rocketammo") return drop end
})


-- Following weapons not included in AtE, so they are included in this release


i = GM:CreateItem("weapon_tea_falcon", {
    Cost = 1500,
    Model = "models/weapons/s_dmgf_co1911.mdl",
    Weight = 1.4,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_falcon") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_falcon") UseFunc_StripWeapon(ply, "weapon_tea_falcon", drop) return drop end
})

i = GM:CreateItem("weapon_tea_spas", {
    Cost = 7000,
    Model = "models/weapons/w_shotgun.mdl",
    Weight = 3.6,
    Supply = 0,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_spas") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_spas") UseFunc_StripWeapon(ply, "weapon_tea_spas", drop) return drop end
})

i = GM:CreateItem("weapon_tea_lbr", {
    Cost = 15500,
    Model = "models/weapons/w_snip_m14sp.mdl",
    Weight = 3.8,
    Supply = 0,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_lbr") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_lbr") UseFunc_StripWeapon(ply, "weapon_tea_lbr", drop) return drop end
})

i = GM:CreateItem("weapon_tea_aug", {
    Cost = 16000,
    Model = "models/weapons/w_rif_aug.mdl",
    Weight = 5.15,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_aug") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_aug") UseFunc_StripWeapon(ply, "weapon_tea_aug", drop) return drop end,
})

i = GM:CreateItem("weapon_tea_awm", {
    Cost = 22500,
    Model = "models/weapons/w_snip_awp.mdl",
    Weight = 7.65,
    Supply = 0,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_awm") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_awm") UseFunc_StripWeapon(ply, "weapon_tea_awm", drop) return drop end,
})


-- Other special weapons



i = GM:CreateItem("weapon_tea_plasmalauncher", {
    Cost = 0,
    Model = "models/weapons/w_physics.mdl",
    Weight = 20,
    Supply = -1,
    Rarity = 11,
    Category = 3,
    UseFunc = function(ply) ply:SendChat("You could gladly use that weapon, but the ENTITY CLASS FOR THIS DOESN'T EXIST!!!\n(at least for now)") /*UseFunc_EquipGun(ply, "weapon_tea_plasmalauncher")*/ return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_plasmalauncher") UseFunc_StripWeapon(ply, "weapon_tea_plasmalauncher", drop) return drop end,
    IsSecret = true
})

i = GM:CreateItem("weapon_tea_minigun", {
    Cost = 47000,
    Model = "models/weapons/w_m134_minigun.mdl",
    Weight = 16.96,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_minigun") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_minigun") UseFunc_StripWeapon(ply, "weapon_tea_minigun", drop) return drop end
})

i = GM:CreateItem("weapon_tea_ar2", {
    Cost = 18000,
    Model = "models/weapons/w_irifle.mdl",
    Weight = 5.28,
    Supply = -1,
    Rarity = 6,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_ar2") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_ar2") UseFunc_StripWeapon(ply, "weapon_tea_ar2", drop) return drop end
})

i = GM:CreateItem("weapon_tea_combinepistol", {
    Cost = 10000,
    Model = "models/weapons/w_cmbhgp.mdl",
    Weight = 2.28,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_combinepistol") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_combinepistol") UseFunc_StripWeapon(ply, "weapon_tea_combinepistol", drop) return drop end
})

i = GM:CreateItem("weapon_tea_grenade_pipe", {
    Cost = 120,
    Model = "models/props_lab/pipesystem03a.mdl",
    Weight = 0.34,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_pipe", "nade_pipebombs") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_pipe") UseFunc_StripWeapon(ply, "weapon_tea_grenade_pipe", drop) return drop end,
    IsGrenade = true
})

i = GM:CreateItem("weapon_tea_grenade_flare", {
    Cost = 65,
    Model = "models/props_lab/pipesystem03a.mdl",
    Weight = 0.4,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_flare", "nade_flares") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_flare") UseFunc_StripWeapon(ply, "weapon_tea_grenade_flare", drop) return drop end,
    IsGrenade = true
})

i = GM:CreateItem("weapon_tea_grenade_frag", {
    Cost = 375,
    Model = "models/weapons/w_eq_fraggrenade.mdl",
    Weight = 0.63,
    Supply = -1,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_frag", "Grenade") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_frag") UseFunc_StripWeapon(ply, "weapon_tea_grenade_frag", drop) return drop end,
    IsGrenade = true
})

/* -- ugh this thing can just fcking crash the server, there is currently no fix available so include this item at your own risk
i = GM:CreateItem("weapon_tea_grenade_molotov", {
    Cost = 400,
    Model = "models/props_junk/garbage_glassbottle003a.mdl",
    Weight = 0.35,
    Supply = 0,
    Rarity = 2,
    Category = 3,
    UseFunc = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_tea_grenade_molotov", "nade_molotov") return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_grenade_molotov") UseFunc_StripWeapon(ply, "weapon_tea_grenade_molotov", drop) return drop end,
    IsGrenade = true
})
*/


-- Weapons that were earlier cut in T.E.A., but was added back anyway

i = GM:CreateItem("weapon_tea_amex", {
    Cost = 8500,
    Model = "models/weapons/w_rif_xamas.mdl",
    Weight = 5.75,
    Supply = 0,
    Rarity = 4,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_amex") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_amex") UseFunc_StripWeapon(ply, "weapon_tea_amex", drop) return drop end,
})

i = GM:CreateItem("weapon_tea_mars", {
    Cost = 17500,
    Model = "models/weapons/w_rif_tavor.mdl",
    Weight = 7.92,
    Supply = -1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_mars") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_mars") UseFunc_StripWeapon(ply, "weapon_tea_mars", drop) return drop end,
})

i = GM:CreateItem("weapon_tea_dragunov", {
    Cost = 14000,
    Model = "models/weapons/w_svd_dragunov.mdl",
    Weight = 6.3,
    Supply = 0,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_dragunov") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_dragunov") UseFunc_StripWeapon(ply, "weapon_tea_dragunov", drop) return drop end,
})

i = GM:CreateItem("weapon_tea_boomstick", {
    Cost = 3200,
    Model = "models/weapons/w_double_barrel_shotgun.mdl",
    Weight = 3.2,
    Supply = 0,
    Rarity = 3,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_boomstick") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_boomstick") UseFunc_StripWeapon(ply, "weapon_tea_boomstick", drop) return drop end,
})


-- More Special weapons



i = GM:CreateItem("weapon_tea_deadly_axe", {
    Cost = 30000,
    Model = "models/props/CS_militia/axe.mdl",
    Weight = 3.26,
    Supply = 1,
    Rarity = 5,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_axe") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_axe") UseFunc_StripWeapon(ply, "weapon_tea_deadly_axe", drop) return drop end,
    ModelColor = Color(255, 127, 127) -- not working bruh I need to make it work
})

i = GM:CreateItem("weapon_tea_deadly_scrapcrossbow", {
    Cost = 265000,
    Model = "models/weapons/w_crossbow.mdl",
    Weight = 13.65,
    Supply = 1,
    Rarity = 8,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_scrapcrossbow") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_scrapcrossbow") UseFunc_StripWeapon(ply, "weapon_tea_deadly_scrapcrossbow", drop) return drop end
})

i = GM:CreateItem("weapon_tea_deadly_minigun", {
    Cost = 845000,
    Model = "models/weapons/w_m134_minigun.mdl",
    Weight = 28.52,
    Supply = 1,
    Rarity = 9,
    Category = 3,
    UseFunc = function(ply) UseFunc_EquipGun(ply, "weapon_tea_deadly_minigun") return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "weapon_tea_deadly_minigun") UseFunc_StripWeapon(ply, "weapon_tea_deadly_minigun", drop) return drop end
})

