-- Armor Attachments --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, {
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = category,
    UseFunc = function(ply) return false end,
    DropFunc = function(ply, _, item) return true end
})

]]

--[[
Ideas:
- Kevlar: +15% bullet prot.
- Additional Armor layer: +35% armor effectiveness (Armor absorbs significantly more damage, but also reduces damage taken!)
- Radioprotective elements: +25% radiation protection
- ?: +0.5% Stamina/sec regen (Uses up Battery at the rate of 1%/sec!)
- ?: +4% movement speed
- ?: +0.05 HP/sec regen
- ?: +20% protection from zombies/melee
]]

GM:CreateItem("item_armor_attachment_kevlar", {
	Cost = 100000,
	Model = "models/error.mdl", -- Placeholder.
	Weight = 2.5,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end, -- Not yet.
	
	AttachmentStats = {
		Health = 0,
		Armor = 0,
		ArmorProtBullet = 0,
		ArmorProtMelee = 0,
	}
})



GM:CreateItem("item_backpack_1", {
	Cost = 1000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka1.mdl",
	Weight = 0.62,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,			-- Additional weight in kg to give when equipped
		AddStaminaDrain = 2,	-- But also additional stamina loss
	}
})

GM:CreateItem("item_backpack_2", {
	Cost = 5000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka2.mdl",
	Weight = 0.9,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})

GM:CreateItem("item_backpack_3", {
	Cost = 15000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka3.mdl",
	Weight = 1.16,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})

GM:CreateItem("item_backpack_4", {
	Cost = 40000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka4.mdl",
	Weight = 1.48,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})

GM:CreateItem("item_backpack_5", {
	Cost = 100000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka5.mdl",
	Weight = 1.8,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})

GM:CreateItem("item_backpack_6", {
	Cost = 2000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka6.mdl",
	Weight = 0.56,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})

GM:CreateItem("item_backpack_7", {
	Cost = 400000,
	Model = "models/wick/wrbstalker/anomaly/items/dez_sumka7.mdl",
	Weight = 2.5,
	Supply = -1,
	Rarity = RARITY_MYTHIC,
	Category = ITEMCATEGORY_ARMORATT,
	ItemType = ITEMTYPE_ARMORATT,
	UseFunc = function(ply) return false end,
	
	BackpackStats = {
		AddWeight = 5,
		AddStaminaDrain = 2,
	}
})
