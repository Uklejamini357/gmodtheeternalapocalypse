
function GM:LoadAD()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
		file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end

	if file.Exists(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/airdrops.txt", "DATA") then
		self.AirdropSpawnpoints = file.Read(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/airdrops.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.AirdropSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = util.StringToType(v[2], "Angle")
			local hitpos = v[3] and util.StringToType(v[3], "Vector")

			if !hitpos then
				local tr = util.TraceLine({
					start = pos + Vector(0,0,1),
					endpos = pos + Vector(0, 0, 90000),
					mask = MASK_SOLID_BRUSHONLY,
				})

				if !tr or !tr.HitSky then continue end
				hitpos = tr.HitPos - Vector(0, 0, 80)
			end

			table.insert(tbl, {pos, ang, hitpos})
		end
		self.AirdropSpawnpoints = tbl

		print("Airdrop spawnpoints loaded")
	else
		print("No airdrop spawnpoints found for this map")
	end
end


function GM:AddAirdropSpawnpoint(pos, ang)
	local tr = util.TraceLine({
		start = pos + Vector(0,0,1),
		endpos = pos + Vector(0, 0, 90000),
		mask = MASK_SOLID_BRUSHONLY,
	})
	if !tr.HitSky then return true, "Must be placed in a place visible to sky." end
	local hitp = tr.HitPos - Vector(0, 0, 80)

	table.insert(self.AirdropSpawnpoints, {pos, ang, hitp})

	self:SaveAirdropSpawnpoints()

	self:UpdateAdminEyes("Airdrop")

	return false
end

function GM:DeleteAirdropSpawnpoint(id)
	if self.AirdropSpawnpoints[id] then
		self.AirdropSpawnpoints[id] = nil

		self:SaveAirdropSpawnpoints()
	end

	self:UpdateAdminEyes("Airdrop")
end


function GM:ClearAirdropSpawnpoints()
	self.AirdropSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/airdrops.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/airdrops.txt")
	end

	self:UpdateAdminEyes("Airdrop")
end

function GM:SaveAirdropSpawnpoints()
	local ftext = ""
	for _,var in pairs(self.AirdropSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])
	end

	if ftext == "" then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/airdrops.txt")
		return
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/airdrops.txt", ftext)
end

function GM:GetRandomAirdropLoot(plycountoverride)
	local plycount = plycountoverride or #player.GetAll()

	local testinv = {
		["Junk"] = {math.random(0, 2), 1, 1},
		["Ammo"] = {math.random(1 + math.floor(plycount / 4), 2 + math.floor(plycount / 4)), 1, 3 + math.floor(plycount / 6)},
		["Meds"] = {math.random(0 + math.floor(plycount / 5), 2 + math.floor(plycount / 5)), 1, 3 + math.floor(plycount / 7)},
		["Food"] = {math.random(0 + math.floor(plycount / 5), 2 + math.floor(plycount / 5)), 1, 3 + math.floor(plycount / 7)},
		["Sellables"] = {math.random(0, 1 + math.floor(plycount / 3)), 1, 2},
		["NewbieWeapons"] = {2, 1, 1}
	}

	local rng = math.random(0, 100)
	if rng >= 90 then
		testinv["SpecialWeapons"] = {1, 1, 1}
	elseif rng >= 80 then
		testinv["RareWeapons"] = {1, 1, 1}
	elseif rng >= 45 then
		testinv["FactionWeapons"] = {1 + math.floor(plycount / 10), 1, 1}
	else
		testinv["TyrantWeapons"] = {1 + math.floor(plycount / 14), 1, 1}
	end

	return testinv
end

function GM:PreSpawnAirdrop(plycountoverride, silent, delay)
	self:RadioTranslatedBroadcast(0, "airdrop_msg1", "sender_shamus", true)
	self:RadioTranslatedBroadcast(3, "airdrop_msg2", "sender_shamus", false)
	self:RadioTranslatedBroadcast(11, "airdrop_msg3", "sender_watchdog", false)
	self:RadioTranslatedBroadcast(16.5, "airdrop_msg4", "sender_watchdog", false)
end

function GM:SpawnAirdrop(plycountoverride, silent, delay)
	local cratedropped = false

	if table.Count(self.AirdropSpawnpoints) == 0 then return end

	local random = table.Random(self.AirdropSpawnpoints)
	local pos = random[3] -- hitpos
	local ang = random[2]

	local dropent = ents.Create("airdrop_cache")
	dropent:SetPos(pos)
	dropent:SetAngles(ang)

	local loot = self:RollLootTable(self:GetRandomAirdropLoot(plycountoverride))
	gamemode.Call("MakeLootContainer", dropent, loot)

	dropent:Spawn()
	dropent:Activate()
end

function GM:CallAirdrop(plycountoverride, silent, delay)
	gamemode.Call("PreSpawnAirdrop", plycountoverride, silent, delay)

	timer.Simple(20, function()
		gamemode.Call("SpawnAirdrops", plycountoverride, silent, delay)
	end)
end

function GM:SpawnAirdrops(plycountoverride, silent, delay)
	plycountoverride = plycountoverride or player.GetCount()

	local count = plycountoverride >= 15 and 3 or plycountoverride >= 8 and 2 or 1
	if count > 1 then
		self:SystemTranslatedBroadcast("x_airdrops_spotted", Color(191,255,255), false, count)
	end

	for i=1,count do
		timer.Create("TEA_AIRDROP_TIMER_"..i, count > 1 and 10+(i*60)-60 or 0, 1, function()
			gamemode.Call("SpawnAirdrop", plycountoverride, silent, delay)


			if count and i < count then
				local last = i+1 >= count
				if last then
					self:SystemTranslatedBroadcast("last_airdrop_in_x", Color(255,255,127), false)
				else
					self:SystemTranslatedBroadcast("next_airdrop_in_x", Color(255,255,127), false, count - i)
				end
			end
		end)
	end
end
