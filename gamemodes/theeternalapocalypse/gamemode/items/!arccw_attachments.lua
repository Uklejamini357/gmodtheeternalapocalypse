-- i am NOT WILLING TO SPEND AN ETERNITY ADDING ALL OF THESE...

GM:CreateItem("arccw_acwatt_ud_m1014_tube_ext", {
    Name = "M4 Super 90 7 Shell Tube",
    Description = "Attachment for Benneli M4 allowing to increase magazine capacity to 7 rounds.",
    Cost = 950,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ud_m1014_tube_ext.png",
    Weight = 0.3,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_WEAPON,
    UseFunc = function(pl,_,item) ArcCW:PlayerGiveAtt(pl, "ud_m1014_tube_ext", 1) ArcCW:PlayerSendAttInv(pl) return true end
})

GM:CreateItem("arccw_acwatt_ud_m1014_barrel_sport", {
    Name = "M4 Super 90 19'' Competition Barrel",
    Description = "Attachment for Benneli M4.",
    Cost = 500,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_ud_m1014_barrel_sport.png",
    Weight = 0.3,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_WEAPON,
    UseFunc = function(pl,_,item) ArcCW:PlayerGiveAtt(pl, "ud_m1014_barrel_sport", 1) ArcCW:PlayerSendAttInv(pl) return true end
})

GM:CreateItem("arccw_acwatt_uc_fg_autotrigger", {
    Name = "Forced Reset Trigger",
    Description = "Attachment for ArcCW weapons allowing for automatic fire.",
    Cost = 1800,
    Model = "models/Items/BoxSRounds.mdl",
    Material = "entities/att/acwatt_uc_fg_autotrigger.png",
    Weight = 0.3,
    Supply = 1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_WEAPON,
    UseFunc = function(pl,_,item) ArcCW:PlayerGiveAtt(pl, "uc_fg_autotrigger", 1) ArcCW:PlayerSendAttInv(pl) return true end
})