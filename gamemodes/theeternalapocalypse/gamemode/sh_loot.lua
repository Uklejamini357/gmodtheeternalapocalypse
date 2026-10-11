-- Loot tables

function GM:AddItemLootTable(tbl, rarity, class, qty)
	local t = {Class = class, Qty = qty}
	if tbl == self.LootTable then
		tbl[rarity].Items[#tbl[rarity].Items + 1] = t
	else
		tbl[#tbl+1] = t
	end

	return t
end

function GM:AddItemAirdropLoot(typ, id)
--[[
	available types:
	Junk
	Food
	Meds
	Sellables
	Ammo
	NewbieWeapons
	TyrantWeapons
	FactionWeapons
	SpecialWeapons
	RareWeapons
]]

	local tbl = self.AirdropLootTable
	if !tbl then print("no airdrop table! wtf you loaded in...") return end

	if !tbl[typ] then
		tbl[typ] = {}
	end
	tbl[typ][#tbl[typ]+1] = id -- sequential table ahhh


	return t
end

-- Prevents players at levels early progression stage be unable to find super high quality loot. (Prevents OP start)
-- Players at prestige 0 cannot obtain Legendary loot. At level lower than 20 players cannot get Epic loot caches and at level <10 players cannot find Rare loot.
-- Does not affect boss and faction loot caches.
GM.PreventGoodLootRNGForNewPlayers = true

GM.LootTable = {
	[LOOTRARITY_COMMON] = {
		Rarity = 1,
		Items = {}
	},
	[LOOTRARITY_UNCOMMON] = {
		Rarity = 3.5,
		Items = {}
	},
	[LOOTRARITY_RARE] = {
		Rarity = 15,
		Items = {}
	},
	[LOOTRARITY_EPIC] = {
		Rarity = 65,
		Items = {}
	},
	[LOOTRARITY_LEGENDARY] = {
		Rarity = 300,
		Items = {}
	},
}
GM.LootTableBoss = {}
GM.LootTableFaction = {}
GM.AirdropLootTable = {}

-- Load every file in the loots folder.
-- This is very similar to loading items from items folder.
for k,v in pairs(file.Find(GM.FolderName.."/gamemode/loot/*.lua", "LUA")) do
	-- if v:sub(1,1) == "!" then continue end
	if SERVER then
		AddCSLuaFile("loot/"..v)
	end

	include("loot/"..v)
end

