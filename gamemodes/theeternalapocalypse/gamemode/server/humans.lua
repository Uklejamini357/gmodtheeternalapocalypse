--- Insert code for human spawns here.
--- (stalker npc spawns, vj spawns, etc. as i managed to make zombies target other npc's)
---------------- Humans! ----------------

-- aint finished with it yet
do return end

function GM:NPCHumanCount()
	local livingHumans = 0
	for k, v in pairs(self.HumanSpawnClasses) do
		for _, ent in ipairs(ents.FindByClass(k)) do livingHumans = livingHumans + 1 end
	end

	return livingHumans
end


function GM:LoadHumanSpawns()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/humans.txt", "DATA") then
		self.HumanSpawnpoints = file.Read(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/humans.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.HumanSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = util.StringToType(v[2], "Angle")
			local class = v[3]
			local weapon = v[4]

			table.insert(tbl, {pos, ang, class})
		end
		self.HumanSpawnpoints = tbl

		print("Humans spawnpoints loaded")
	else
		print("No Humans spawnpoints found for this map")
	end
end

function GM:AddHumanSpawnpoint(pos, yaw, class, weapon)
	table.insert(self.HumanSpawnpoints, {pos, Angle(0, yaw, 0), tier})
	
	self:SaveHumanSpawnpoints()
	self:UpdateAdminEyes("Humans")
	return true
end

function GM:DeleteHumanSpawnpoint(id)
	if self.HumanSpawnpoints[id] then
		self.HumanSpawnpoints[id] = nil

		self:SaveHumanSpawnpoints()
		self:UpdateAdminEyes("Humans")
	end
end

function GM:ClearHumanSpawnpoints()
	self.HumanSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/humans.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/humans.txt")
	end
	self:UpdateAdminEyes("Humans")
end

function GM:SaveHumanSpawnpoints()
	local ftext = ""
	for _,var in pairs(self.HumanSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])..";"..(var[3] or 1)
	end

	if ftext == "" then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/humans.txt")
		return
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/humans.txt", ftext)
end


-- Not used currently.
function GM:GetRandomHumanSpawn()
	if table.Count(self.HumanSpawnpoints) == 0 then return end

	local hspawn = table.Random(self.HumanSpawnpoints)
	local pos = hspawn[1] + Vector(0, 0, 5)
	local ang = hspawn[2]

	return pos
end

function GM:CreateNPCHuman(class, pos, ang, xp, cash, infectionrate, level, isboss)
	local isboss = isboss or false
	local class = tostring(class)

	local ent = ents.Create(class)
	if !ent:IsValid() then return NULL end

	local lvl = level or 1

	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent.XPReward = FORCED_LVL and xp or xp*(0.75+lvl*0.025)
	ent.MoneyReward = FORCED_LVL and cash or cash*(0.85+lvl*0.015)
	ent.InfectionRate = FORCED_LVL and infectionrate or infectionrate*(0.9+lvl*0.01)
	ent.IsZombie = true
	ent.BossMonster = isboss
	ent.DamagedBy = {}

	ent:Spawn()
	-- ent:SetHealth(ent:Health() * self.ZombieHealthMultiplier * self:GetDiffZombieHealthMul() * (0.75+lvl*0.025))
	-- ent:SetMaxHealth(ent:GetMaxHealth() * self.ZombieHealthMultiplier * self:GetDiffZombieHealthMul() * (0.75+lvl*0.025))
	ent:Activate()
	if self:GetDebug() >= DEBUGGING_ADVANCED then print("Zombie spawned:", "\n"..class, pos, ang, "XPReward: "..xp, "MoneyReward: "..cash, isboss and "Isboss: true" or "Isboss: false") end
	return ent -- used for SpawnZombie command
end

function GM:SpawnRandomHuman(pos, ang, tier)
	local maxchance = 0
	local iter,tbl,cons = pairs(self.Config["HumanClasses"])
	for _,z in iter,tbl,cons do if !z.Disabled then maxchance = maxchance + z.SpawnChance end end

	local dice = math.Rand(0, maxchance)
	local total = 0
	for k, v in iter,tbl,cons do
		if v.Disabled then continue end
		total = total + v.SpawnChance
		if total >= dice then
			k = v.Miniboss and (#player.GetAll() >= 3 or self:GetInfectionLevel() > 25) and k or !v.Miniboss and k or "npc_tea_basic"
			v = self.Config["HumanClasses"][k]

			local elitechance = math.Rand(0, 100)
			local elite = elitechance ~= 0 and elitechance <= self:GetEliteVariantSpawnChance(false)
			local ent = self:CreateNPCHuman(k, pos, ang, v.XPReward * self:GetDiffXPMul(), v.MoneyReward * self:GetDiffCashMul(), v.InfectionRate, tier, false)

			if elite and v.AllowEliteVariants then
				self:ApplyEliteVariant(ent, math.random(8))
			end

			break
		end
	end
end


function GM:SpawnHumans()
	if self:ZombieCount() >= self.MaxZombies then return false end
	if GetGlobalBool("GM.ZombieSpawnNearPlayer") then
		local spawned = 0
		local maxspawns = 5

		while spawned < maxspawns do
			spawned = spawned + 1

			local ply = table.Random(player.GetAll())
			local spawnpos

			local canspawn = true

			spawnpos = ply:GetPos() + Vector(
				math.random(-5000, 5000),
				math.random(-5000, 5000),
				math.random(-1000, 1000)
			)

			local zeds = ents.FindInSphere(spawnpos, 1000)
			for k, v in ipairs(zeds) do
				if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then canspawn = false break end
			end

			for i=1,50 do
				spawnpos.z = spawnpos.z + 100
				local tr = util.TraceLine({start = spawnpos, endpos = spawnpos + Vector(0,0,-10000)})
				if tr.Hit then
					spawnpos.z = tr.HitPos.z
					break
				end
			end

			self:SpawnRandomZombie(spawnpos + Vector(0, 0, 10), Angle(0,math.random(-180,180),0), 1)

		end
		return true
	end


	if table.Count(self.ZombieSpawnpoints) == 0 then return end

	for k, v in RandomPairs(self.ZombieSpawnpoints) do
		if self:ZombieCount() >= self.MaxZombies then break end

		local pos = v[1] + Vector(0, 0, 5)
		local ang = v[2]
		local tier = v[3]

		local nospawn = false
		for _, v in ipairs(ents.FindInSphere(pos, 200)) do
			-- ignore spawnpoints that are obstructed by zombies or players
			if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then nospawn = true break end
		end
		if nospawn then continue end
		for _, v in ipairs(ents.FindInSphere(pos, 600)) do
			if v:IsPlayer() then nospawn = true break end
		end
		if nospawn then continue end

		nospawn = true
		for _, v in ipairs(ents.FindInSphere(pos, tonumber(self.MaxZombieSpawnDistance))) do
			if v:IsPlayer() then nospawn = false break end
		end
		if nospawn then continue end


		self:SpawnRandomZombie(pos + Vector(0, 0, 10), ang, tier)
	end
end
