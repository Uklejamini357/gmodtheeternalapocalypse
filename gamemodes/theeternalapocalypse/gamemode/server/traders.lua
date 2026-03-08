
function GM:LoadTraders()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   	file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		self.TraderSpawnpoints = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA")

		local tbl = {}
		for _,v in pairs(string.Explode("\n", self.TraderSpawnpoints)) do
			local Booty = string.Explode(";", v)
			local pos = util.StringToType(Booty[1], "Vector")
			local ang = util.StringToType(Booty[2], "Angle")

			table.insert(tbl, {pos, ang})
		end
		self.TraderSpawnpoints = tbl

		print("Traders file loaded")
		return true
	else
		print("No traders file for this map")
		return false
	end
end

function GM:SpawnTraders()
	for k, v in ipairs(ents.FindByClass("tea_trader")) do
		v:Remove()
	end

	for k, v in pairs(self.TraderSpawnpoints) do
		local pos = v[1]
		local ang = v[2]
		local ent = ents.Create("tea_trader")
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetNetworkedString("Owner", "World")
		ent:Spawn()
		ent:Activate()
	end
end

function GM:AddTrader(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	table.insert(self.TraderSpawnpoints, {ply:GetPos(), ply:GetAngles()})

	self:SaveTraderSpawns()

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
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local entries = table.Count(self.TraderSpawnpoints)
	self.TraderSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt")
	end
	for _,ent in ipairs(ents.FindByClass("tea_trader")) do
		ent:Remove()
	end

	ply:SendChat("Deleted all trader spawnpoints!")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all trader spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_cleartraderspawns", function(ply, cmd, args)
	gamemode.Call("ClearTraders", ply, cmd, args)
end)

function GM:SaveTraderSpawns()
	local ftext = ""
	for _,var in pairs(self.TraderSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", ftext)
end

function GM:RefreshTraders(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
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
