util.AddNetworkString("SendCrateItems")
util.AddNetworkString("UseCrate")


function GM:LootCount()
	local LootBoxes = 0
	for _,ent in ipairs(ents.FindByClass("loot_cache")) do
		if ent:GetNWInt("loottype") ~= LOOTTYPE_NORMAL then continue end
		LootBoxes = LootBoxes + 1
	end
	return LootBoxes
end

function GM:LoadLoot()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		self.LootSpawnpoints = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.LootSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = util.StringToType(v[2], "Angle")
			local tier = tonumber(v[3] or 1) or 1

			table.insert(tbl, {pos, ang, tier})
		end
		self.LootSpawnpoints = tbl

		print("Loot spawnpoints loaded")
	else
		print("No loot spawnpoints found for this map")
	end
end

function GM:AddLootSpawnpoint(pos, ang, tier)
	table.insert(self.LootSpawnpoints, {pos, ang, tier or 1})

	self:SaveLootSpawns()
	self:UpdateAdminEyes("Loot")
	return true
end

function GM:DeleteLootSpawnpoint(id)
	self.LootSpawnpoints[id] = nil
	
	for i=1,#self.LootSpawnpoints do
		if i <= 1 then continue end
		if !self.LootSpawnpoints[i-1] then
			self.LootSpawnpoints[i-1] = self.LootSpawnpoints[i]
			self.LootSpawnpoints[i] = nil
		end
	end

	self:SaveLootSpawns()
	self:UpdateAdminEyes("Loot")
end

function GM:ClearLootSpawnpoints()
	self.LootSpawnpoints = {}

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt")
	end
	self:UpdateAdminEyes("Loot")
end

function GM:SaveLootSpawns()
	local ftext = ""
	for _,var in pairs(self.LootSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])..";"..tonumber(var[3] or 1)
	end

	if ftext == "" then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt")
		return
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", ftext)
end

function GM:SpawnLootCache(ltype, pos, ang, tier)
	local ent = ents.Create("loot_cache")

	if !tier then tier = 1 end
	if !ent:IsValid() then return end
	ent:SetNWInt("loottype", ltype)
	ent:SetNWInt("lootrarity", self:RandomizeLootRarity(tier))
	ent:SetPos(pos)
	ent:SetAngles(ang)
	if ltype == LOOTTYPE_BOSS or ltype == LOOTTYPE_FACTION then
		ent:SetModel("models/props/de_prodigy/ammo_can_02.mdl")
	else
		ent:SetModel("models/props/cs_office/cardboard_box03.mdl")
	end
	self:RandomizeEntityLoot(ent)
	ent:Spawn()

	if self:GetDebug() >= DEBUGGING_ADVANCED then
		local l,r = self:GetLootTypeName(ent:GetNWInt("loottype")), self:GetLootRarityName(ent:GetNWInt("lootrarity"))
		print("Loot spawned:", l, "Rarity: ", r, pos, ang)
	end

	return ent
end

function GM:RandomizeLootRarity(tier)
	local rng = 1 / math.Rand(0, 1) -- float/double value between 0 and 1, and then reverse it to a much larger value 
	if rng > 1e6 then rng = 1e6 end -- if it somehow ends up being larger than 1mil, just reset it.
	if !tier then tier = 1 end

	local rare = LOOTRARITY_COMMON
	local prevrarity = 1
	for i,loot in ipairs(self.LootTable) do
		if !loot.Rarity then continue end

		print(i, rng, loot.Rarity)
		if loot.Rarity < rng then
			rare = i
			prevrarity = loot.Rarity
		elseif loot.Rarity >= rng then
			rare = rare + ((rng-prevrarity) / (loot.Rarity-prevrarity))
			break
		end
	end

	return math.floor(math.min(#self.LootTable, rare + (tier-1)*0.1))
end

function GM:RandomizeEntityLoot(ent, forceloottype)
	local loottype = forceloottype or ent:GetNWInt("loottype")
	local loot
	if loottype == LOOTTYPE_NORMAL then
		loot = self.LootTable[ent:GetNWInt("lootrarity")].Items
	elseif loottype == LOOTTYPE_BOSS then
		loot = self.LootTableBoss
	elseif loottype == LOOTTYPE_FACTION then
		loot = self.LootTableFaction
	end
	if !loot then error("oh no, something went wrong with randomizing loot tables.") return end
	loot = table.Random(loot)

	ent.LootType = loot.Class
	ent.LootQuantity = loot.Qty or 1
	return loot
end

function GM:SpawnLoot()
	local lootcount = self:LootCount()
	if lootcount >= self.MaxCaches then return false end -- dont even bother running any checks if theres already too much loot
	if table.Count(self.LootSpawnpoints) == 0 then return end

	local spawned = 0
	for k, v in RandomPairs(self.LootSpawnpoints) do
		if lootcount+spawned >= self.MaxCaches then break end
		local ent

		local pos = v[1]
		local ang = v[2]
		local tier = v[3]

		self:SpawnLootCache(LOOTTYPE_NORMAL, pos, ang, tier)
		spawned = spawned + 1
		if spawned >= 3 then break end
	end
end

concommand.Add("tea_dev_spawnloots", function(ply, cmd)
	if TEADevCheck(ply) then
		gamemode.Call("SpawnLoot")
	else 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
	end
end)


function GM:MakeLootContainer(ent, items, size, env) -- env is a bool for environment caches such as airdrops and random loot
	if !ent:IsValid() or !istable(items) then return end
	local size = size or 1000 -- doesnt matter what size is if env is true
	env = env == nil and true or env

	ent.ContainerItems = items
	ent.ContainerSize = size
	ent.ContainerRemoveEmpty = env
end


function GM:CalculateContainerWeight(ent)
	if !ent:IsValid() or !ent.ContainerItems then return end
	local totalweight = 0
	for k, v in pairs(ent.ContainerItems) do
		local ref = self.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
	return totalweight
end

-- unused since there is no entity class that can store items yet
function GM:PlaceInContainer(ply, str, ent)
	if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
	if ply:GetPos():Distance(ent:GetPos()) > 120 then return end
	if !self.ItemsList[str] then return end
	if ent.ContainerRemoveEmpty then ply:SystemMessage("You cannot place items into this container! Buy a faction stash if you need item storage!", Color(255,205,205,255), true) return end

	local item = self.ItemsList[str]
	if (gamemode.Call("CalculateContainerWeight", ent) + item["Weight"]) > ent.ContainerSize then ply:SystemMessage("There isn't enough room for that!", Color(255,205,205,255), true) return end
	if ent.ContainerItems[str] then
		ent.ContainerItems[str] = ent.ContainerItems[str] + 1
	else 
		ent.ContainerItems[str] = 1
	end

	gamemode.Call("SystemRemoveItem", ply, str, true)
	gamemode.Call("SendInventory", ply)
end


function GM:WithdrawFromContainer(ply, str, ent)
	if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
	if ply:GetPos():Distance(ent:GetPos()) > 120 then return end
	if !self.ItemsList[str] or !ent.ContainerItems[str] then return end

	local item = self.ItemsList[str]

	-- if ((gamemode.Call("CalculateWeight", ply) + item["Weight"]) > gamemode.Call("CalculateMaxWeight", ply)) then ply:SystemMessage("You don't have enough space for that!", Color(255,205,205,255), true) return end


	ent.ContainerItems[str] = ent.ContainerItems[str] - 1
	if ent.ContainerItems[str] < 1 then ent.ContainerItems[str] = nil end

	gamemode.Call("SystemGiveItem", ply, str)
	gamemode.Call("SendInventory", ply)

-- airdrops and random loot caches need to be deleted when there's no items left in them
	if ent.ContainerRemoveEmpty and table.Count(ent.ContainerItems) < 1 then
		ent.ContainerItems = nil
		timer.Simple(15, function()
			if ent:IsValid() then
				GAMEMODE:SystemBroadcast("Airdrop crate is gone!", Color(255,105,105,255), true)
				ent:Remove()
			end
		end)
	end
end

function GM:OpenContainer(ent, ply)
	if !ent:IsValid() then return end
	if !ent.ContainerItems then ply:SystemMessage("It's empty!", Color(255,205,205,255), false) return end
	net.Start("SendCrateItems")
	net.WriteEntity(ent)
	net.WriteTable(ent.ContainerItems)
	net.WriteBool(!ent.ContainerRemoveEmpty)
	net.Send(ply)
end

--maybe i will add buildable (or usable) containers in future
net.Receive("UseCrate", function(len, ply)
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local stash = net.ReadBool() or false

	if !ent:IsValid() or !ent.ContainerItems or !ply:IsValid() or !ply:Alive() then return end
	if stash then
		GAMEMODE:PlaceInContainer(ply, item, ent)
	else
		GAMEMODE:WithdrawFromContainer(ply, item, ent)
		ply:PrintTranslatedMessage(4, "loottaken", GAMEMODE:GetItemName(item, ply))
	end
end)



-- EXAMPLE OF PARAMS (this is used for airdrops)
--[[
{

Syntax is as follows:
"Table to roll from" = { number of times to roll this table, qty low, qty high }

This rolls twice from the junk table, selecting 2 random item classes from it and spawning minimum of 1 and maximum of 3, each of them.
"Junk" = {2, 1, 3}

}
]]

function GM:RollLootTable(params, maxrolls)
	if not istable(params) then return end
	local maxrolls = maxrolls or -1
	local rolls = 0
	local rolled = {}
	for k, v in pairs(params) do
		if !self.AirdropLootTable[k] then ErrorNoHalt("---=== FUNCTION RollLootTable ERROR: ===---\n"..k.." IS NOT A VALID LOOT TABLE! See gamemode/sh_loot.lua for more info\n---======---\n") continue end
		if rolls >= maxrolls and maxrolls >= 0 then continue end
		for i = 1, v[1] do
			local item = table.Random(self.AirdropLootTable[k])
			local qty = math.random(v[2], v[3])

			if rolls >= maxrolls and maxrolls >= 0 then continue end
			if maxrolls >= 0 then rolls = rolls + 1 end
			if rolled[item] then rolled[item] = rolled[item] + qty else rolled[item] = qty end
		end
	end
	return rolled
end
