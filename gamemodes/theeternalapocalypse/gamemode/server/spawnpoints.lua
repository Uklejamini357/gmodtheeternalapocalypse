
function GM:LoadPlayerSpawns()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
		file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA") then
		self.PlayerSpawnpoints = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA")

		local tbl = {}
		for _,v in pairs(string.Explode("\n", self.PlayerSpawnpoints)) do
			local Booty = string.Explode(";", v)
			local pos = util.StringToType(Booty[1], "Vector")
			local ang = util.StringToType(Booty[2], "Angle")
			local name = Booty[3]

			table.insert(tbl, {pos, ang, name})
		end
		self.PlayerSpawnpoints = tbl

		print("Player spawns file loaded")
	else
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
		if table.Count(GAMEMODE.PlayerSpawnpoints) == 0 then return end
		local random = table.Random(GAMEMODE.PlayerSpawnpoints)
		local pos  = random[1]
		local ang  = random[2]
		local name = random[3]

		ply:SetPos(pos)
		ply:SetAngles(ang)
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

	table.insert(self.PlayerSpawnpoints, {ply:GetPos(), ply:GetAngles(), str})

	self:SavePlayerSpawns()
	
	ply:SendChat("Added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a new player spawnpoint called '"..str.."' at position "..tostring(ply:GetPos()).."!")
	self:LoadPlayerSpawns() --reload them
	timer.Simple(0.5, function() self:LoadPlayerSpawns() end) -- and again (to prevent any unnecessary missing spawnpoints)
end
concommand.Add("tea_addplayerspawnpoint", function(ply, cmd, args, str)
	gamemode.Call("AddPlayerSpawn", ply, cmd, args, str)
end)

function GM:ClearPlayerSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	self.PlayerSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/".. string.lower(game.GetMap()) .."/players.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/players.txt")
	end
	ply:SendChat("Deleted all player spawnpoints")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all player spawnpoints!")
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

function GM:SavePlayerSpawns()
	local ftext = ""
	for _,var in pairs(self.PlayerSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])..";"..tostring(var[3])
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", ftext)
end
