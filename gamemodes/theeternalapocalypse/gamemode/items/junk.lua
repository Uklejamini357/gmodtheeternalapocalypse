-- Junk Items --

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

i = GM:CreateItem("item_junk_tin", {
    Cost = 0,
    Model = "models/props_junk/garbage_metalcan002a.mdl",
    Weight = 0.1,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_tin") return drop end
})

i = GM:CreateItem("item_junk_boot", {
    Cost = 0,
    Model = "models/props_junk/Shoe001a.mdl",
    Weight = 0.17,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_boot") return drop end
})

i = GM:CreateItem("item_junk_paper", {
    Cost = 0,
    Model = "models/props_junk/garbage_newspaper001a.mdl",
    Weight = 0.12,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paper") return drop end
})

i = GM:CreateItem("item_junk_keyboard", {
    Cost = 0,
    Model = "models/props_c17/computer01_keyboard.mdl",
    Weight = 0.23,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_keyboard") return drop end
})

i = GM:CreateItem("item_junk_gardenpot", {
    Cost = 0,
    Model = "models/props_junk/terracotta01.mdl",
    Weight = 0.25,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_gardenpot") return drop end
})

i = GM:CreateItem("item_junk_paint", {
    Cost = 0,
    Model = "models/props_junk/metal_paintcan001a.mdl",
    Weight = 0.25,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paint") return drop end
})

i = GM:CreateItem("item_junk_doll", {
    Cost = 0,
    Model = "models/props_c17/doll01.mdl",
    Weight = 0.15,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_doll") return drop end
})

i = GM:CreateItem("item_junk_pot", {
    Cost = 0,
    Model = "models/props_interiors/pot02a.mdl",
    Weight = 0.2,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end
})

i = GM:CreateItem("item_junk_hula", {
    Cost = 0,
    Model = "models/props_lab/huladoll.mdl",
    Weight = 0.1,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_hula") return drop end
})

i = GM:CreateItem("item_junk_nailbox", {
    Cost = 0,
    Model = "models/props_lab/box01a.mdl",
    Weight = 0.06,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_nailbox") return drop end
})

i = GM:CreateItem("item_junk_twig", {
    Cost = 0,
    Model = "models/props/cs_office/Snowman_arm.mdl",
    Weight = 0.1,
    Supply = -1,
    Rarity = RARITY_TRASH,
    Category = ITEMCATEGORY_JUNK,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end
})
