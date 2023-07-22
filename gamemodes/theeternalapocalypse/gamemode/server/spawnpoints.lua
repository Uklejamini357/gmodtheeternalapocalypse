GM.PlayerSpawnsData = ""

function GM:LoadPlayerSpawns()
	if not file.IsDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
		file.CreateDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA") then
		self.PlayerSpawnsData = ""
		self.PlayerSpawnsData = file.Read(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA")
		print("Player spawns file loaded")
	else
		self.PlayerSpawnsData = ""
		print("No player spawns file for this map")
	end
end


hook.Add("PlayerSpawn", "TEAPlayerSpawnPoints", function(ply)
	if ply.Spawnpoint then
		if ply.Spawnpoint:IsValid() then
		-- for future beds and what not
			ply:SetPos(ply.Spawnpoint:GetPos())
			ply:SystemMessage("You have spawned at your spawn point.", Color(205,255,205), true)
		else
        	ply.Spawnpoint = nil
		end    
	else
		if (GAMEMODE.PlayerSpawnsData != "") then
			local SpawnsList = string.Explode("\n", GAMEMODE.PlayerSpawnsData)
			local RandomSpawnPoint =  table.Random(SpawnsList)
			local SpawnPoint = string.Explode(";", RandomSpawnPoint)
			local pos  = util.StringToType(SpawnPoint[1], "Vector")
			local ang  = util.StringToType(SpawnPoint[2], "Angle")
			local name = tostring(SpawnPoint[3])

			ply:SetPos(pos)
			ply:SetAngles(ang)
		end
	end
end)

function GM:AddPlayerSpawn(ply, cmd, args, str)
	if !SuperAdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if !str or str == "" then
		ply:SystemMessage("Specify a spawnpoint name!", Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local PosAngName = tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles()) .. ";" .. tostring(str)

	if (self.PlayerSpawnsData == "") then
		NewData = tostring(PosAngName)
	else
		NewData = self.PlayerSpawnsData.."\n"..tostring(PosAngName)
	end
	
	file.Write(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", NewData)
	
	ply:SendChat("Added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
	GAMEMODE:LoadPlayerSpawns() --reload them
	timer.Simple(0.5, function() GAMEMODE:LoadPlayerSpawns() end) -- and again (to prevent any unnecessary missing spawnpoints)
end
concommand.Add("tea_addplayerspawnpoint", GM.AddPlayerSpawn)

function GM:ClearPlayerSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(GAMEMODE.DataFolder.."/spawns/".. string.lower(game.GetMap()) .."/players.txt", "DATA") then
		file.Delete(GAMEMODE.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/players.txt")
	end
	ply:SendChat("Deleted all player spawnpoints")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all player spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearplayerspawnpoints", function(ply, cmd, args)
	gamemode.Call("ClearPlayerSpawns", ply, cmd, args)
end)

function GM:RefreshPlayerSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	self:LoadPlayerSpawns()
end
concommand.Add("tea_refreshplayerspawnpoints", function(ply, cmd, args)
	gamemode.Call("RefreshPlayerSpawns", ply, cmd, args)
end)
