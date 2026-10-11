-- Generate template for each weapon given

hook.Add("PlayerGiveSWEP", "TEA", function(ply, class, weptbl)


    local s = string.format([[GM:CreateItem("%s", {
    Name = "",
    Description = "",
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "%s",
})]], class, class)

    MsgN(s)

end)
