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
    DropFunc = function(ply, item) return true end

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
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_noobcannon",
})

i = GM:CreateItem("weapon_tea_pigsticker", {
    Cost = 350,
    Model = "models/weapons/w_knife_ct.mdl",
    Weight = 0.38,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_pigsticker",
})

i = GM:CreateItem("weapon_tea_axe", {
    Cost = 800,
    Model = "models/props/CS_militia/axe.mdl",
    Weight = 1.73,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_axe",
})

i = GM:CreateItem("weapon_tea_wrench", {
    Cost = 800,
    Model = "models/props_c17/tools_wrench01a.mdl",
    Weight = 0.47,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_wrench",
})

i = GM:CreateItem("weapon_tea_repair", {
    Cost = 5500,
    Model = "models/props_c17/tools_wrench01a.mdl",
    Weight = 0.58,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_repair",
})

i = GM:CreateItem("weapon_tea_scrapsword", {
    Cost = 2000,
    Model = "models/props_c17/TrapPropeller_Blade.mdl",
    Weight = 5.3,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_scrapsword",
})

i = GM:CreateItem("weapon_tea_g20", {
    Cost = 450,
    Model = "models/weapons/w_pist_glock18.mdl",
    Weight = 1.18,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_g20",
})

i = GM:CreateItem("weapon_tea_57", {
    Cost = 600,
    Model = "models/weapons/w_pist_fiveseven.mdl",
    Weight = 0.82,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_57",
})

i = GM:CreateItem("weapon_tea_u45", {
    Cost = 700,
    Model = "models/weapons/w_pist_usp.mdl",
    Weight = 1.1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_u45",
})

i = GM:CreateItem("weapon_tea_warren50", {
    Cost = 850,
    Model = "models/weapons/w_pist_deagle.mdl",
    Weight = 1.73,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_warren50",
})

i = GM:CreateItem("weapon_tea_python", {
    Cost = 1200,
    Model = "models/weapons/w_357.mdl",
    Weight = 1.18,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_python",
})

i = GM:CreateItem("weapon_tea_dual", {
    Cost = 2000,
    Model = "models/weapons/w_pist_elite.mdl",
    Weight = 2.72,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_dual",
})

i = GM:CreateItem("weapon_tea_satan", {
    Cost = 2250,
    Model = "models/weapons/w_m29_satan.mdl",
    Weight = 3.14,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_satan",
})

i = GM:CreateItem("weapon_tea_mp11", {
    Cost = 2250,
    Model = "models/weapons/w_smg_mac10.mdl",
    Weight = 2.85,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_mp11",
})

i = GM:CreateItem("weapon_tea_rg900", {
    Cost = 2500,
    Model = "models/weapons/w_smg_tmp.mdl",
    Weight = 2.9,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_rg900",
})

i = GM:CreateItem("weapon_tea_k5a", {
    Cost = 3250,
    Model = "models/weapons/w_smg_mp5.mdl",
    Weight = 3,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_k5a",
})

i = GM:CreateItem("weapon_tea_stinger", {
    Cost = 2800,
    Model = "models/weapons/w_smg1.mdl",
    Weight = 3.85,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_stinger",
})

i = GM:CreateItem("weapon_tea_bosch", {
    Cost = 3750,
    Model = "models/weapons/w_sten.mdl",
    Weight = 3.45,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_bosch",
})

i = GM:CreateItem("weapon_tea_k8", {
    Cost = 5000,
    Model = "models/weapons/w_smg_ump45.mdl",
    Weight = 3.12,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_k8",
})

i = GM:CreateItem("weapon_tea_k8c", {
    Cost = 5500,
    Model = "models/weapons/w_hk_usc.mdl",
    Weight = 3.15,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_k8c",
})

i = GM:CreateItem("weapon_tea_shredder", {
    Cost = 7750,
    Model = "models/weapons/w_smg_p90.mdl",
    Weight = 3,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_shredder",
})

i = GM:CreateItem("weapon_tea_enforcer", {
    Cost = 5000,
    Model = "models/weapons/w_shot_m3super90.mdl",
    Weight = 3.6,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_enforcer",
})

i = GM:CreateItem("weapon_tea_sweeper", {
    Cost = 7750,
    Model = "models/weapons/w_shot_xm1014.mdl",
    Weight = 3.8,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_sweeper",
})

i = GM:CreateItem("weapon_tea_ranger", {
    Cost = 7250,
    Model = "models/weapons/w_rif_m4a1.mdl",
    Weight = 4.2,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_ranger",
})

i = GM:CreateItem("weapon_tea_fusil", {
    Cost = 7150,
    Model = "models/weapons/w_rif_famas.mdl",
    Weight = 4,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_fusil",
})

i = GM:CreateItem("weapon_tea_stugcommando", {
    Cost = 9750, 
    Model = "models/weapons/w_rif_sg552.mdl",
    Weight = 4.45,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_stugcommando",
})

i = GM:CreateItem("weapon_tea_krukov", {
    Cost = 11000,
    Model = "models/weapons/w_rif_ak47.mdl",
    Weight = 3.76,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_krukov",
})

i = GM:CreateItem("weapon_tea_krukov_uniq", {
    Cost = 185000,
    Model = "models/weapons/w_rif_ak47.mdl",
    Weight = 4.46,
    Supply = 0,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_krukov_uniq",
})

i = GM:CreateItem("weapon_tea_l303", {
    Cost = 13500,
    Model = "models/weapons/w_rif_galil.mdl",
    Weight = 5.35,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_l303",
})

i = GM:CreateItem("weapon_tea_scar", {
    Cost = 22000,
    Model = "models/weapons/w_fn_scar_h.mdl",
    Weight = 4.6,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_scar",
})

i = GM:CreateItem("weapon_tea_lmg", {
    Cost = 17250,
    Model = "models/weapons/w_mach_m249para.mdl",
    Weight = 7.5,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_lmg",
})

i = GM:CreateItem("weapon_tea_antelope", {
    Cost = 9200,
    Model = "models/weapons/w_snip_scout.mdl",
    Weight = 5.25,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_antelope",
})

i = GM:CreateItem("weapon_tea_scimitar", {
    Cost = 12250,
    Model = "models/weapons/w_snip_g3sg1.mdl",
    Weight = 5.4,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_scimitar",
})

i = GM:CreateItem("weapon_tea_blackhawk", {
    Cost = 15000,
    Model = "models/weapons/w_snip_sg550.mdl",
    Weight = 6.35,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_blackhawk",
})

i = GM:CreateItem("weapon_tea_punisher", {
    Cost = 35000,
    Model = "models/weapons/w_acc_int_aw50.mdl",
    Weight = 7.95,
    Supply = 5,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_punisher",
})

i = GM:CreateItem("weapon_tea_scrapcrossbow", {
    Cost = 15000,
    Model = "models/weapons/w_crossbow.mdl",
    Weight = 8,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_scrapcrossbow",
})

i = GM:CreateItem("weapon_tea_winchester", {
    Cost = 6500,
    Model = "models/weapons/w_winchester_1873.mdl",
    Weight = 5.32,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_winchester",
})

i = GM:CreateItem("weapon_tea_perrin", {
    Cost = 8500,
    Model = "models/weapons/w_pp19_bizon.mdl",
    Weight = 3.72,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_perrin",
})

i = GM:CreateItem("weapon_tea_dammerung", {
    Cost = 12200,
    Model = "models/weapons/w_usas_12.mdl",
    Weight = 6.72,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_dammerung",
})

i = GM:CreateItem("weapon_tea_rpg", {
    Cost = 55000,
    Model = "models/weapons/w_rocket_launcher.mdl",
    Weight = 7.2,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_rpg",
})

i = GM:CreateItem("weapon_tea_fuckinator", {
    Cost = 28750,
    Model = "models/weapons/w_pist_p228.mdl",
    Weight = 8.74,
    Supply = -1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_fuckinator",
})

i = GM:CreateItem("weapon_tea_germanator", {
    Cost = 6800,
    Model = "models/weapons/w_mp40smg.mdl",
    Weight = 3.34,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_germanator",
})

i = GM:CreateItem("weapon_tea_807", {
    Cost = 5800,
    Model = "models/weapons/w_remington_870_tact.mdl",
    Weight = 3.82,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_807",
})

i = GM:CreateItem("weapon_tea_crowbar", {
    Cost = 50000,
    Model = "models/weapons/w_crowbar.mdl",
    Weight = 6.17,
    Supply = -1,
    Rarity = RARITY_GODLY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_crowbar",
})



-- some ammunition


i = GM:CreateItem("item_pistolammo", {
    Cost = 45,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
})

i = GM:CreateItem("item_magammo", {
    Cost = 60,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_357_jhp.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
})

i = GM:CreateItem("item_buckshotammo", {
    Cost = 65,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
})

i = GM:CreateItem("item_rifleammo", {
    Cost = 90,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
})

i = GM:CreateItem("item_sniperammo", {
    Cost = 130,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
})

i = GM:CreateItem("item_minigunammo", {
    Cost = 1000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_ammo_792x33_ap.mdl", -- I'll find the right model for this soon, hopefully.
    Weight = 1,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_minigun") return bool end,
})

i = GM:CreateItem("item_ar2pulseammo", {
    Cost = 150,
    Model = "models/Items/combine_rifle_cartridge01.mdl",
    Weight = 1,
    Supply = 10,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_ar2_pulseammo") return bool end,
})

i = GM:CreateItem("item_crossbowbolt", {
    Cost = 40,
    Model = "models/Items/CrossbowRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 6, "XBowBolt") return bool end,
})

i = GM:CreateItem("item_crossbowbolt_crate", {
    Cost = 150,
    Model = "models/Items/item_item_crate.mdl",
    Weight = 1.5,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "XBowBolt") return bool end,
})

i = GM:CreateItem("item_deadly_crossbowbolt", {
    Cost = 500,
    Model = "models/Items/CrossbowRounds.mdl",
    Weight = 0.8,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 25, "ammo_deadlybolt") return bool end,
})

i = GM:CreateItem("item_rocketammo", {
    Cost = 180,
    Model = "models/weapons/w_missile_closed.mdl",
    Weight = 1.74,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_AMMO,
    ItemType = ITEMTYPE_AMMO,
    UseFunc = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
})


-- Following weapons not included in AtE, so they are included in this release


i = GM:CreateItem("weapon_tea_falcon", {
    Cost = 1500,
    Model = "models/weapons/s_dmgf_co1911.mdl",
    Weight = 1.4,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_falcon",
})

i = GM:CreateItem("weapon_tea_spas", {
    Cost = 7000,
    Model = "models/weapons/w_shotgun.mdl",
    Weight = 3.6,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_spas",
})

i = GM:CreateItem("weapon_tea_lbr", {
    Cost = 15500,
    Model = "models/weapons/w_snip_m14sp.mdl",
    Weight = 3.8,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_lbr",
})

i = GM:CreateItem("weapon_tea_aug", {
    Cost = 16000,
    Model = "models/weapons/w_rif_aug.mdl",
    Weight = 5.15,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_aug",
})

i = GM:CreateItem("weapon_tea_awm", {
    Cost = 22500,
    Model = "models/weapons/w_snip_awp.mdl",
    Weight = 7.65,
    Supply = 0,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_awm",
})


-- Other special weapons



i = GM:CreateItem("weapon_tea_plasmalauncher", {
    Cost = 0,
    Model = "models/weapons/w_physics.mdl",
    Weight = 20,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "error_weapon_class_inexistant")) /*UseFunc_EquipGun(ply, "weapon_tea_plasmalauncher")*/ return false end,
    IsSecret = true
})

i = GM:CreateItem("weapon_tea_minigun", {
    Cost = 47000,
    Model = "models/weapons/w_m134_minigun.mdl",
    Weight = 16.96,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_minigun",
})

i = GM:CreateItem("weapon_tea_ar2", {
    Cost = 18000,
    Model = "models/weapons/w_irifle.mdl",
    Weight = 5.28,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_ar2",
})

i = GM:CreateItem("weapon_tea_combinepistol", {
    Cost = 10000,
    Model = "models/weapons/w_cmbhgp.mdl",
    Weight = 2.28,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_combinepistol",
})

i = GM:CreateItem("weapon_tea_grenade_pipe", {
    Cost = 120,
    Model = "models/props_lab/pipesystem03a.mdl",
    Weight = 0.34,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_grenade_pipe",
    IsGrenade = true
})

i = GM:CreateItem("weapon_tea_grenade_flare", {
    Cost = 65,
    Model = "models/props_lab/pipesystem03a.mdl",
    Weight = 0.4,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_grenade_flare",
    IsGrenade = true
})

i = GM:CreateItem("weapon_tea_grenade_frag", {
    Cost = 375,
    Model = "models/weapons/w_eq_fraggrenade.mdl",
    Weight = 0.63,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_grenade_frag",
    IsGrenade = true
})

/* -- ugh this thing can just fcking crash the server, there is currently no fix available so include this item at your own risk
i = GM:CreateItem("weapon_tea_grenade_molotov", {
    Cost = 400,
    Model = "models/props_junk/garbage_glassbottle003a.mdl",
    Weight = 0.35,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_grenade_molotov",
    IsGrenade = true
})
*/


-- Weapons that were earlier cut in T.E.A., but was added back anyway

i = GM:CreateItem("weapon_tea_amex", {
    Cost = 8500,
    Model = "models/weapons/w_rif_xamas.mdl",
    Weight = 5.75,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_amex",
})

i = GM:CreateItem("weapon_tea_mars", {
    Cost = 17500,
    Model = "models/weapons/w_rif_tavor.mdl",
    Weight = 7.92,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_mars",
})

i = GM:CreateItem("weapon_tea_dragunov", {
    Cost = 14000,
    Model = "models/weapons/w_svd_dragunov.mdl",
    Weight = 6.3,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_dragunov",
})

i = GM:CreateItem("weapon_tea_boomstick", {
    Cost = 3200,
    Model = "models/weapons/w_double_barrel_shotgun.mdl",
    Weight = 3.2,
    Supply = 0,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_boomstick",
})


-- More Special weapons



i = GM:CreateItem("weapon_tea_deadly_axe", {
    Cost = 30000,
    Model = "models/props/CS_militia/axe.mdl",
    Weight = 3.26,
    Supply = 1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_deadly_axe",
    ModelColor = Color(255, 127, 127) -- doesn't seem to work :/
})

i = GM:CreateItem("weapon_tea_deadly_scrapcrossbow", {
    Cost = 265000,
    Model = "models/weapons/w_crossbow.mdl",
    Weight = 13.65,
    Supply = 1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_deadly_scrapcrossbow",
})

i = GM:CreateItem("weapon_tea_deadly_minigun", {
    Cost = 845000,
    Model = "models/weapons/w_m134_minigun.mdl",
    Weight = 28.52,
    Supply = 1,
    Rarity = RARITY_GODLY,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,
    WeaponType = "weapon_tea_deadly_minigun",
})

