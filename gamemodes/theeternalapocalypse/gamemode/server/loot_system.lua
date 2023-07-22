util.AddNetworkString("SendCrateItems")
util.AddNetworkString("UseCrate")

LootData = ""

function GM.LootCount()
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
	if not file.IsDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		LootData = "" --reset it
		LootData = file.Read(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA")
		print("Loot spawnpoints loaded")
	else
		LootData = "" --just in case
		print("No loot spawnpoints found for this map")
	end
end

function GM.AddLoot(ply, cmd, args)
	if !SuperAdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if LootData == "" then
		NewData = tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	else
		NewData = LootData .. "\n" .. tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	end
	
	file.Write(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", NewData)
	
	GAMEMODE:LoadLoot() --reload them
	
	SendChat(ply, "Added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	tea_DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_addlootspawn", GM.AddLoot)


function GM.ClearLoot(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(	GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt", "DATA") then
		file.Delete(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/loot.txt")
	end
	SendChat(ply, "Deleted all loot spawnpoints")
	tea_DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all loot spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearlootspawns", GM.ClearLoot)



function GM.SpawnLoot()
	local tea_config_maxcaches = GetConVar("tea_config_maxcaches"):GetInt()
	if (GAMEMODE.LootCount() >= tea_config_maxcaches) then return false end -- dont even bother running any checks if theres already too much loot
		if (LootData != "") then

		local LootList = string.Explode("\n", LootData)
		for k, v in RandomPairs(LootList) do
			if (GAMEMODE.LootCount() >= tea_config_maxcaches) then break end
			local Booty = string.Explode(";", v)
			local pos = util.StringToType(Booty[1], "Vector")
			local ang = util.StringToType(Booty[2], "Angle")
			local rng = math.Rand(0,300)
			if rng < 100 then
				if rng > 14 then
					local EntDrop = ents.Create("loot_cache")
					EntDrop:SetPos(pos)
					EntDrop:SetAngles(ang)
					EntDrop.LootType = table.Random(GAMEMODE.LootTable1)["Class"]
					EntDrop:Spawn()
					EntDrop:Activate()
					if GetConVar("tea_server_debugging"):GetInt() >= 2 then print("Loot cache spawned:", "\n"..EntDrop:GetClass(), pos, ang, "Loot Type: "..EntDrop.LootType) end
				elseif rng > 2 then
					local EntDrop = ents.Create("loot_cache_weapon")
					EntDrop:SetPos(pos)
					EntDrop:SetAngles(ang)
					EntDrop.LootType = table.Random(GAMEMODE.LootTable2)["Class"]
					EntDrop:Spawn()
					EntDrop:Activate()
					if GetConVar("tea_server_debugging"):GetInt() >= 2 then print("Loot cache spawned:", "\n"..EntDrop:GetClass(), pos, ang, "Loot Type: "..EntDrop.LootType) end
				else
					local EntDrop = ents.Create("loot_cache_special")
					EntDrop:SetPos(pos)
					EntDrop:SetAngles(ang)
					EntDrop.LootType = table.Random(GAMEMODE.LootTable3)["Class"]
					EntDrop:Spawn()
					EntDrop:Activate()
					if GetConVar("tea_server_debugging"):GetInt() >= 2 then print("Loot cache spawned:", "\n"..EntDrop:GetClass(), pos, ang, "Loot Type: "..EntDrop.LootType) end
				end
			end
		end
	end
end
timer.Create("LootSpawnTimer", 60, 0, GM.SpawnLoot)

concommand.Add("tea_dev_spawnloots", function(ply, cmd)
	if TEADevCheck(ply) then
		GAMEMODE.SpawnLoot()
	else 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
	end
end)


function tea_MakeLootContainer(ent, items, size, env) -- env is a bool for environment caches such as airdrops and random loot
	if !ent:IsValid() or !istable(items) then return end
	local size = size or 1000 -- doesnt matter what size is if env is true
	local env = env or true

	ent.ContainerItems = items
	ent.ContainerSize = size
	ent.ContainerRemoveEmpty = env
end


function tea_CalculateContainerWeight(ent)
	if !ent:IsValid() or !ent.ContainerItems then return end
	local totalweight = 0
	for k, v in pairs(ent.ContainerItems) do
		local ref = GAMEMODE.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
	return totalweight
end

-- unused since there is no entity class that can store items yet
function tea_PlaceInContainer(ply, str, ent)
	if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
	if ply:GetPos():Distance(ent:GetPos()) > 120 then return end
	if !GAMEMODE.ItemsList[str] then return end
	if ent.ContainerRemoveEmpty then SystemMessage(ply, "You cannot place items into this container! Buy a faction stash if you need item storage!", Color(255,205,205,255), true) return end

	local item = GAMEMODE.ItemsList[str]
	if (tea_CalculateContainerWeight(ent) + item["Weight"]) > ent.ContainerSize then SystemMessage(ply, "There isn't enough room for that!", Color(255,205,205,255), true) return end
	if ent.ContainerItems[str] then
		ent.ContainerItems[str] = ent.ContainerItems[str] + 1
	else 
		ent.ContainerItems[str] = 1
	end

	tea_SystemRemoveItem(ply, str, true)
	tea_SendInventory(ply)
end


function tea_WithdrawFromContainer(ply, str, ent)
	if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
	if ply:GetPos():Distance(ent:GetPos()) > 120 then return end
	if !GAMEMODE.ItemsList[str] or !ent.ContainerItems[str] then return end

	local item = GAMEMODE.ItemsList[str]

	if ((tea_CalculateWeight(ply) + item["Weight"]) > tea_CalculateMaxWeight(ply)) then SystemMessage(client, "You don't have enough space for that!", Color(255,205,205,255), true) return end


	ent.ContainerItems[str] = ent.ContainerItems[str] - 1
	if ent.ContainerItems[str] < 1 then ent.ContainerItems[str] = nil end

	tea_SystemGiveItem(ply, str)
	tea_SendInventory(ply)

-- airdrops and random loot caches need to be deleted when there's no items left in them
	if ent.ContainerRemoveEmpty and table.Count(ent.ContainerItems) < 1 then
		ent.ContainerItems = nil
		timer.Simple(15, function()
			if ent:IsValid() then
				tea_SystemBroadcast("Airdrop crate is gone!", Color(255,105,105,255), true)
				ent:Remove()
			end
		end)
	end
end

function tea_OpenContainer(ent, ply)
	if !ent:IsValid() then return end
	if !ent.ContainerItems then SystemMessage(ply, "It's empty!", Color(255,205,205,255), false) return end
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
		tea_PlaceInContainer(ply, item, ent)
	else
		tea_WithdrawFromContainer(ply, item, ent)
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

function tea_RollLootTable(params, maxrolls)
	if not istable(params) then return end
	local maxrolls = maxrolls or -1
	local rolls = 0
	local rolled = {}
	for k, v in pairs(params) do
		if !GAMEMODE.LootTable[k] then ErrorNoHalt("---=== FUNCTION RollLootTable ERROR: ===---\n"..k.." IS NOT A VALID LOOT TABLE! See gamemode/sh_loot.lua for more info\n---======---\n") continue end
		if rolls >= maxrolls and maxrolls >= 0 then continue end
		for i = 1, v[1] do
			local item = table.Random(GAMEMODE.LootTable[k])
			local qty = math.random(v[2], v[3])

			if rolls >= maxrolls and maxrolls >= 0 then continue end
			if maxrolls >= 0 then rolls = rolls + 1 end
			if rolled[item] then rolled[item] = rolled[item] + qty else rolled[item] = qty end
		end
	end
	return rolled
end
