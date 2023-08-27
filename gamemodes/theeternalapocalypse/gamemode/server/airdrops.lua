local DropData = ""

function GM:LoadAD()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
		file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/airdrops.txt", "DATA") then
		DropData = "" --reset it
		DropData = file.Read(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/airdrops.txt", "DATA")
		print("Airdrop spawnpoints loaded")
	else
		DropData = "" --just in case
		print("No airdrop spawnpoints found for this map")
	end
end


function GM:AddAirdropSpawn(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local tr = util.TraceLine({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 90000),
		mask = MASK_SOLID_BRUSHONLY,
	})
	if !tr.HitSky then ply:SystemMessage("You can only place airdrop spawns in areas that are visible to the skybox!", Color(255,205,205,255), true) return end
	local hitp = tr.HitPos - Vector(0, 0, 80)

	if (DropData == "") then
		NewData = tostring(hitp) ..";".. tostring(ply:GetAngles())
	else
		NewData = DropData .."\n".. tostring(hitp) .. ";".. tostring(ply:GetAngles())
	end
	
	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/airdrops.txt", NewData)

	self:LoadAD() --reload them

	ply:SendChat("Added an airdrop spawnpoint at position "..tostring(hitp).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added an airdrop spawnpoint at position "..tostring(hitp).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_addairdropspawn", function(ply, cmd, args)
	gamemode.Call("AddAirdropSpawn", ply, cmd, args)
end)


function GM:ClearAirdropSpawns(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(self.DataFolder.."/spawns/".. string.lower(game.GetMap()) .."/airdrops.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/".. string.lower(game.GetMap()) .."/airdrops.txt")
	end
	DropData = ""
	ply:SendChat("Deleted all airdrop spawnpoints")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all airdrop spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearairdropspawns", function(ply, cmd, args)
	gamemode.Call("ClearAirdropSpawns", ply, cmd, args)
end)

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
	if rng >= 95 then
		testinv["SpecialWeapons"] = {1, 1, 1}
	elseif rng >= 85 then
		testinv["RareWeapons"] = {1, 1, 1}
	elseif rng >= 45 then
		testinv["FactionWeapons"] = {1 + math.floor(plycount / 10), 1, 1}
	else
		testinv["TyrantWeapons"] = {1 + math.floor(plycount / 14), 1, 1}
	end

	return testinv
end

function GM:SpawnAirdrop()
	local plycount = #player.GetAll()

	self:RadioBroadcast(0, "Christmas has come early ladies!", "Shamus", true)
	self:RadioBroadcast(3, "I've got a little present for y'all to entertain yourselves with!", "Shamus", false)
	self:RadioBroadcast(11, "Attention survivors! That airdrop crate is fitted with an IFF jammer.", "Watchdog", false)
	self:RadioBroadcast(16.5, "In addition, if you go near it you'll need to watch your back or risk being shot by other loot hunters!", "Watchdog", false)

	local count = plycount >= 20 and 3 or plycount >= 12 and 2 or 1
	timer.Simple(20, function()
		if count > 1 then
			self:SystemBroadcast(count.." airdrops have been spotted // First airdrop appears in 10 seconds", Color(191,255,255), false)
		end

		for i=1,count do
			timer.Create("TEA_AIRDROP_TIMER_"..i, count > 1 and 10+(i*60)-60 or 0, 1, function()
				local cratedropped = false

				if DropData == "" then return end

				local DropList = string.Explode("\n", DropData)
				for k, v in RandomPairs(DropList) do
					if cratedropped then break end
					local Booty = string.Explode(";", v)
					local pos = util.StringToType(Booty[1], "Vector")
					local ang = util.StringToType(Booty[2], "Angle")

					local dropent = ents.Create("airdrop_cache")
					dropent:SetPos(pos)
					dropent:SetAngles(ang)

					local loot = self:RollLootTable(self:GetRandomAirdropLoot())
					gamemode.Call("MakeLootContainer", dropent, loot)

					dropent:Spawn()
					dropent:Activate()
					cratedropped = true
				end

				for k, v in pairs(player.GetAll()) do
					v:SendLua("surface.PlaySound(\"ambient/overhead/hel1.wav\")")
				end

				self:SystemBroadcast("An airdrop crate has appeared!", Color(255,127,255), false)
				if i < count then
					local last = i+1 >= count
					self:SystemBroadcast((last and "Last" or "Next").." airdrop appears in 60 seconds"..(last and "" or " ("..count - i.." remaining)"), Color(255,255,127), false)
				end
			end)
		end
--		self:SystemBroadcast((count > 1 and count.." airdrop crates have" or "An airdrop crate has").." appeared!", Color(255,255,255,255), false)
	end)
end
