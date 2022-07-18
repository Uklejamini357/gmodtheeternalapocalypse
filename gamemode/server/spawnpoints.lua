
PlayerSpawnsData = ""

function LoadPlayerSpawns()
if not file.IsDir("theeternalapocalypse/spawns/players", "DATA") then
   file.CreateDir("theeternalapocalypse/spawns/players")
end
	if file.Exists( "theeternalapocalypse/spawns/players/" .. string.lower(game.GetMap()) .. ".txt", "DATA" ) then
		PlayerSpawnsData = ""
		PlayerSpawnsData = file.Read( "theeternalapocalypse/spawns/players/" .. string.lower(game.GetMap()) .. ".txt", "DATA" )
		print( "Player spawns file loaded" )
	else
		PlayerSpawnsData = ""
		print( "No player spawns file for this map" )
	end
end
LoadPlayerSpawns()

function SpawnPlayer( ply )
	if ply.Spawnpoint then -- i took daddys advice
	    if ply.Spawnpoint:IsValid() then
	    	 -- for future beds and what not
	        ply:SetPos(ply.Spawnpoint:GetPos())
		    SystemMessage(ply, "You have spawned at your spawn point.", Color(205,255,205,255), true)
	    else
            ply.Spawnpoint = nil
	    end    
	else
        if( PlayerSpawnsData != "" ) then
		
			local SpawnsList = string.Explode( "\n", PlayerSpawnsData )
			local RandomSpawnPoint =  table.Random(SpawnsList)
		    local SpawnPoint = string.Explode( ";", RandomSpawnPoint )
				
				local pos  = util.StringToType( SpawnPoint[1], "Vector" )
				local ang  = util.StringToType( SpawnPoint[2], "Angle" )
				local name = tostring(SpawnPoint[3])
                
                ply:SetPos( pos )
			    ply:SetAngles( ang )
			    SystemMessage(ply, "You have spawned in " .. name .. "!", Color(205,255,205,255), true)
	    
	    end
    end
end
hook.Add("PlayerSpawn", "ate_whoknowswhattocallhooksthesedays", SpawnPlayer)

function AddPlayerSpawn( ply, cmd, args, str )
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
		return
	end
	
	LoadPlayerSpawns() --reload them
	
    str = str or "New Spawn"

    local PosAngName = tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() ) .. ";" .. tostring(str)

	if( PlayerSpawnsData == "" ) then
		NewData = tostring( PosAngName )
	else
		NewData = PlayerSpawnsData .. "\n" .. tostring( PosAngName )
	end
	
	file.Write( "theeternalapocalypse/spawns/players/" .. string.lower(game.GetMap()) .. ".txt", NewData )
	
	SendChat( ply, "Added a new player spawnpoint called '" .. str .. "'" )

	timer.Simple(1, function() LoadPlayerSpawns() end) -- and again
end
concommand.Add( "ate_addspawnpoint", AddPlayerSpawn )

function ClearPlayerSpawns( ply, cmd, args )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end

if file.Exists(	"theeternalapocalypse/spawns/players/" .. string.lower(game.GetMap()) .. ".txt", "DATA") then
	file.Delete("theeternalapocalypse/spawns/players/" .. string.lower(game.GetMap()) .. ".txt")
end
SendChat( ply, "Deleted all player spawnpoints" )
end
concommand.Add( "ate_clearplayerspawnpoints", ClearPlayerSpawns )

function RefreshPlayerSpawns(ply, cmd, args)
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end
LoadPlayerSpawns()
end
concommand.Add( "ate_refreshplayerspawnpoints", RefreshPlayerSpawns )