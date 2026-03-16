-- Resources --
do return end -- whoo knows when
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

i = GM:CreateItem("item_resources_wood", {
    Cost = 0,
    Model = "models/props_foliage/tree_slice_chunk02.mdl",
    Weight = 0.1,
    Supply = -1,
    Rarity = RARITY_GARBAGE,
    Category = ITEMCATEGORY_JUNK,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
})

i = GM:CreateItem("item_resources_stone", {
    Cost = 0,
    Model = "models/props_foliage/tree_slice_chunk02.mdl",
    Weight = 0.1,
    Supply = -1,
    Rarity = RARITY_GARBAGE,
    Category = ITEMCATEGORY_JUNK,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouse")) return false end,
})
