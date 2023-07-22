util.AddNetworkString("SendCrateItems")
util.AddNetworkString("UseCrate")

LootData = ""

function GM:LootCount()
	local LootBoxes = 0
	for k, v in pairs(ents.FindByClass("loot_cache")) do
		LootBoxes = LootBoxes + 1
	end
	for k, v in pairs(ents.FindByClass("loot_cache_weapon")) do
		LootBoxes = LootBoxes + 1
	end
	for k, v in pairs(ents.FindByClass("loot_cache_special")) do
		LootBoxes = LootBoxes + 1
	end
	return LootBoxes
end

function GM:LoadLoot()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		LootData = "" --reset it
		LootData = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA")
		print("Loot spawnpoints loaded")
	else
		LootData = "" --just in case
		print("No loot spawnpoints found for this map")
	end
end

function GM:AddLoot(ply, cmd, args)
	if !SuperAdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if LootData == "" then
		NewData = tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	else
		NewData = LootData .. "\n" .. tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	end
	
	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", NewData)
	
	self:LoadLoot() --reload them
	
	ply:SendChat("Added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_addlootspawn", function(ply, cmd, args)
	gamemode.Call("AddLoot", ply, cmd, args)
end)


function GM:ClearLoot(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt")
	end
	ply:SendChat("Deleted all loot spawnpoints")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all loot spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearlootspawns", function(ply, cmd, args)
	gamemode.Call("ClearLoot", ply, cmd, args)
end)



function GM:SpawnLoot()
	if (self.LootCount() >= self.MaxCaches) then return false end -- dont even bother running any checks if theres already too much loot
		if (LootData != "") then

		local LootList = string.Explode("\n", LootData)
		for k, v in RandomPairs(LootList) do
			if (self.LootCount() >= self.MaxCaches) then break end
			local ent

			local Booty = string.Explode(";", v)
			local pos = util.StringToType(Booty[1], "Vector")
			local ang = util.StringToType(Booty[2], "Angle")
			local rng = math.Rand(0,300)
			if rng < 100 then
				if rng > 14 then
					ent = ents.Create("loot_cache")
					ent:SetPos(pos)
					ent:SetAngles(ang)
					ent.LootType = table.Random(self.LootTable1)["Class"]
					ent:Spawn()
					ent:Activate()
					if self:GetDebug() >= DEBUGGING_ADVANCED then print("Loot cache spawned:", "\n"..ent:GetClass(), pos, ang, "Loot Type: "..ent.LootType) end
				elseif rng > 2 then
					ent = ents.Create("loot_cache_weapon")
					ent:SetPos(pos)
					ent:SetAngles(ang)
					ent.LootType = table.Random(self.LootTable2)["Class"]
					ent:Spawn()
					ent:Activate()
					if self:GetDebug() >= DEBUGGING_ADVANCED then print("Loot cache spawned:", "\n"..ent:GetClass(), pos, ang, "Loot Type: "..ent.LootType) end
				else
					ent = ents.Create("loot_cache_special")
					ent:SetPos(pos)
					ent:SetAngles(ang)
					ent.LootType = table.Random(self.LootTable3)["Class"]
					ent:Spawn()
					ent:Activate()
					if self:GetDebug() >= DEBUGGING_ADVANCED then print("Loot cache spawned:", "\n"..ent:GetClass(), pos, ang, "Loot Type: "..ent.LootType) end
				end
			end
		end
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
	local env = env or true

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

	if ((gamemode.Call("CalculateWeight", ply) + item["Weight"]) > gamemode.Call("CalculateMaxWeight", ply)) then ply:SystemMessage("You don't have enough space for that!", Color(255,205,205,255), true) return end


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
		ply:PrintTranslatedMessage(4, "loottaken", translate.ClientGet(ply, item.."_n"))
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
		if !self.LootTable[k] then ErrorNoHalt("---=== FUNCTION RollLootTable ERROR: ===---\n"..k.." IS NOT A VALID LOOT TABLE! See gamemode/sh_loot.lua for more info\n---======---\n") continue end
		if rolls >= maxrolls and maxrolls >= 0 then continue end
		for i = 1, v[1] do
			local item = table.Random(self.LootTable[k])
			local qty = math.random(v[2], v[3])

			if rolls >= maxrolls and maxrolls >= 0 then continue end
			if maxrolls >= 0 then rolls = rolls + 1 end
			if rolled[item] then rolled[item] = rolled[item] + qty else rolled[item] = qty end
		end
	end
	return rolled
end
