
function GM:LoadPlayerSpawns()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
		file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA") then
		self.PlayerSpawnpoints = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.PlayerSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = util.StringToType(v[2], "Angle")

			table.insert(tbl, {pos, ang})
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

		ply:SetPos(pos)
		ply:SetAngles(ang)
	end
end)

function GM:AddPlayerSpawnpoint(pos, ang)
	table.insert(self.PlayerSpawnpoints, {pos, ang})

	self:SavePlayerSpawns()
end

function GM:ClearPlayerSpawnpoints()
	self.PlayerSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/".. string.lower(game.GetMap()) .."/players.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/players.txt")
	end
end
concommand.Add("tea_clearplayerspawnpoints", function(ply)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	gamemode.Call("ClearPlayerSpawnpoints")

	ply:SendChat("Deleted all player spawnpoints")
	GAMEMODE:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all player spawnpoints!")
end)

function GM:SavePlayerSpawns()
	local ftext = ""
	for _,var in pairs(self.PlayerSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])..";"..tostring(var[3])
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/players.txt", ftext)
end
