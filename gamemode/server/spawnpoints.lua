PlayerSpawnsData = ""

function LoadPlayerSpawns()
if not file.IsDir("theeternalapocalypse/spawns/"..string.lower(game.GetMap()), "DATA") then
   file.CreateDir("theeternalapocalypse/spawns/"..string.lower(game.GetMap()))
end
	if file.Exists( "theeternalapocalypse/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA" ) then
		PlayerSpawnsData = ""
		PlayerSpawnsData = file.Read( "theeternalapocalypse/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA" )
		print( "Player spawns file loaded" )
	else
		PlayerSpawnsData = ""
		print( "No player spawns file for this map" )
	end
end
LoadPlayerSpawns()

function SpawnPlayer(ply)
	if ply.Spawnpoint then
		if ply.Spawnpoint:IsValid() then
		-- for future beds and what not
			ply:SetPos(ply.Spawnpoint:GetPos())
			SystemMessage(ply, "You have spawned at your spawn point.", Color(205,255,205,255), true)
		else
        	ply.Spawnpoint = nil
		end    
	else
		if (PlayerSpawnsData != "") then
			local SpawnsList = string.Explode("\n", PlayerSpawnsData)
			local RandomSpawnPoint =  table.Random(SpawnsList)
			local SpawnPoint = string.Explode(";", RandomSpawnPoint)
			local pos  = util.StringToType(SpawnPoint[1], "Vector")
			local ang  = util.StringToType(SpawnPoint[2], "Angle")
			local name = tostring(SpawnPoint[3])

			ply:SetPos(pos)
			ply:SetAngles(ang)
		end
	end
end
hook.Add("PlayerSpawn", "ate_whoknowswhattocallhooksthesedays", SpawnPlayer)

function AddPlayerSpawn(ply, cmd, args)
	if !SuperAdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local str = args[1] or "New Spawn"

	local PosAngName = tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() ) .. ";" .. tostring(str)

	if( PlayerSpawnsData == "" ) then
		NewData = tostring( PosAngName )
	else
		NewData = PlayerSpawnsData.."\n"..tostring(PosAngName)
	end
	
	file.Write("theeternalapocalypse/spawns/"..string.lower(game.GetMap()).."/players.txt", NewData )
	
	SendChat(ply, "Added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	print("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	ate_DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
	LoadPlayerSpawns() --reload them
	timer.Simple(0.5, function() LoadPlayerSpawns() end) -- and again (to prevent any unnecessary missing spawnpoints)
end
concommand.Add("ate_addplayerspawnpoint", AddPlayerSpawn)

function ClearPlayerSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists("theeternalapocalypse/spawns/".. string.lower(game.GetMap()) .."/players.txt", "DATA") then
		file.Delete("theeternalapocalypse/spawns/" .. string.lower(game.GetMap()) .. "/players.txt")
	end
	SendChat( ply, "Deleted all player spawnpoints")
	print("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all player spawnpoints!")
	ate_DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all player spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("ate_clearplayerspawnpoints", ClearPlayerSpawns)

function RefreshPlayerSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	LoadPlayerSpawns()
end
concommand.Add( "ate_refreshplayerspawnpoints", RefreshPlayerSpawns)