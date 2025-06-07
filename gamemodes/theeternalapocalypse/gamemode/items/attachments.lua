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
    DropFunc = function(ply) return true end

-- Additional variables if needed
    IsSecret = false,
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
	Rarity = 8,
	Category = ITEMCATEGORY_ARMORATT,
	UseFunc = function(ply) return false end, -- Not yet.
	DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armor_attachment_kevlar") return drop end,

	AttachmentStats = {
		Health = 0,
		Armor = 0,
		ArmorProtBullet = 0,
		ArmorProtMelee = 0,
	}
})
