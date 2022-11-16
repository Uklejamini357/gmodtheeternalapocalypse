TradersData = ""

function GM.LoadTraders()
	if not file.IsDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		TradersData = ""
		TradersData = file.Read(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA" )
		print( "Traders file loaded" )
		return true
	else
		TradersData = ""
		print( "No traders file for this map" )
		return false
	end
end

function GM.SpawnTraders()
	if( TradersData != "" ) then
		local targets = ents.FindByClass( "trader" )
		for k, v in pairs( targets ) do
			v:Remove()
		end
		local TradersList = string.Explode( "\n", TradersData )
		for k, v in pairs( TradersList ) do
			Trader = string.Explode( ";", v )
			local pos = util.StringToType( Trader[1], "Vector" )
			local ang = util.StringToType( Trader[2], "Angle" )
			local EntDrop = ents.Create( "trader" )
			EntDrop:SetPos( pos )
			EntDrop:SetAngles( ang )
			EntDrop:SetNetworkedString( "Owner", "World" )
			EntDrop:Spawn()
			EntDrop:Activate()
		end
	end
end
timer.Simple(1, function() GAMEMODE.SpawnTraders() end) --spawn them right away

function GM.AddTrader( ply, cmd, args )
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end

	if( TradersData == "" ) then
		NewData = tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	else
		NewData = TradersData .. "\n" .. tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	end
	
	file.Write(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", NewData)

	GAMEMODE:LoadTraders() --reload them
	SendChat( ply, "Added a trader spawnpoint at position "..tostring(ply:GetPos()).."!" )
	tea_DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a trader spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
	timer.Simple(1, function() GAMEMODE:SpawnTraders() end)
end
concommand.Add("tea_addtrader", GM.AddTrader)

function GM.ClearTraders( ply, cmd, args )
	if !SuperAdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end

	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		file.Delete(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt")
	end
	SendChat(ply, "Deleted all trader spawnpoints!")
	tea_DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all trader spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add( "tea_cleartraderspawns", GM.ClearTraders )

function GM.RefreshTraders(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end

	if GAMEMODE:LoadTraders() then timer.Simple(1, function() GAMEMODE:SpawnTraders() end) end
end
concommand.Add("tea_refreshtraders", GM.RefreshTraders)
