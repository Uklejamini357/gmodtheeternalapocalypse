
function GM:LoadTraders()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   	file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		self.TraderSpawnpoints = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.TraderSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = Angle(0, v[2], 0)

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

function GM:AddTraderSpawnpoint(pos, ang)
	table.insert(self.TraderSpawnpoints, {pos, ang})

	self:SaveTraderSpawnpoints()

	gamemode.Call("SpawnTraders")
	self:UpdateAdminEyes("Trader")
end

function GM:DeleteTraderSpawnpoint(id)
	if !id or !self.TraderSpawnpoints[id] then return end
	self.TraderSpawnpoints[id] = nil

	self:SaveTraderSpawnpoints()
	self:SpawnTraders()
	self:UpdateAdminEyes("Trader")
end

function GM:ClearTraderSpawnpoints()
	self.TraderSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt")
	end
	for _,ent in ipairs(ents.FindByClass("tea_trader")) do
		ent:Remove()
	end
	self:UpdateAdminEyes("Trader")
end

function GM:SaveTraderSpawnpoints()
	local ftext = ""
	for _,var in pairs(self.TraderSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])
	end

	if ftext == "" then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/traders.txt")
		return
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
		gamemode.Call("SpawnTraders")
	end
end
