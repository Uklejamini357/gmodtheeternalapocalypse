TradersData = ""

function GM:LoadTraders()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		TradersData = ""
		TradersData = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA")
		print("Traders file loaded")
		return true
	else
		TradersData = ""
		print("No traders file for this map")
		return false
	end
end

function GM:SpawnTraders()
	if TradersData ~= "" then
		for k, v in pairs(ents.FindByClass("trader")) do
			v:Remove()
		end

		local TradersList = string.Explode("\n", TradersData)
		for k, v in pairs(TradersList) do
			Trader = string.Explode(";", v)
			local pos = util.StringToType(Trader[1], "Vector")
			local ang = util.StringToType(Trader[2], "Angle")
			local ent = ents.Create("trader")
			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetNetworkedString("Owner", "World")
			ent:Spawn()
			ent:Activate()
		end
	end
end
timer.Simple(1, function()
	gamemode.Call("SpawnTraders")
end)

function GM:AddTrader(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if TradersData == "" then
		NewData = tostring(ply:GetPos())..";"..tostring(ply:GetAngles())
	else
		NewData = TradersData.."\n"..tostring(ply:GetPos())..";"..tostring(ply:GetAngles())
	end
	
	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", NewData)

	gamemode.Call("LoadTraders") --reload them
	ply:SendChat("Added a trader spawnpoint at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a trader spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
	timer.Simple(1, function()
		gamemode.Call("SpawnTraders")
	end)
end
concommand.Add("tea_addtrader", function(ply, cmd, args)
	gamemode.Call("AddTrader", ply, cmd, args)
end)

function GM:ClearTraders(ply, cmd, args)
	if !SuperAdminCheck(ply) then
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt")
	end
	ply:SendChat("Deleted all trader spawnpoints!")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all trader spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_cleartraderspawns", function(ply, cmd, args)
	gamemode.Call("ClearTraders", ply, cmd, args)
end)

function GM:RefreshTraders(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if gamemode.Call("LoadTraders") then
		timer.Simple(1, function()
			gamemode.Call("SpawnTraders")
		end)
	end
end
concommand.Add("tea_refreshtraders", function(ply, cmd, args)
	gamemode.Call("RefreshTraders", ply, cmd, args)
end)
