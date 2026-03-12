---------------- Zombies! ----------------


function GM:ZombieCount()
	local AliveZombies = 0
	for k, v in pairs(self.Config["ZombieClasses"]) do
		for _, ent in pairs(ents.FindByClass(k)) do AliveZombies = AliveZombies + 1 end
	end

	return AliveZombies
end


function GM:LoadZombies()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", "DATA") then
		self.ZombieSpawnpoints = file.Read(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/zombies.txt", "DATA")

		local tbl = {}
		for _,str in pairs(string.Explode("\n", self.ZombieSpawnpoints)) do
			local v = string.Explode(";", str)
			local pos = util.StringToType(v[1], "Vector")
			local ang = util.StringToType(v[2], "Angle")
			local radius = tonumber(v[3] or 0)
			local tier = tonumber(v[4] or 1)

			table.insert(tbl, {pos, ang, radius, tier})
		end
		self.ZombieSpawnpoints = tbl

		print("Zombie spawnpoints loaded")
	else
		print("No zombie spawnpoints found for this map")
	end
end

function GM:AddZombieSpawnpoint(pos, yaw, radius, tier)
	table.insert(self.ZombieSpawnpoints, {pos, Angle(0, yaw, 0), radius, tier})
	
	self:SaveZombieSpawnpoints()
	return true
end

function GM:ClearZombieSpawnpoints()
	self.ZombieSpawnpoints = {}
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt")
	end
end
concommand.Add("tea_clearzombiespawns", function(ply, cmd, args, str)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	GAMEMODE:ClearZombieSpawnpoints()

	ply:SendChat("Deleted all zombie spawnpoints")
	GAMEMODE:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all zombie spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end)

function GM:SaveZombieSpawnpoints()
	local ftext = ""
	for _,var in pairs(self.ZombieSpawnpoints) do
		ftext = ftext..(ftext=="" and "" or "\n")..tostring(var[1])..";"..tostring(var[2])
	end

	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", ftext)
end


-- Not used currently.
function GM:GetRandomZombieSpawn()
	if table.Count(self.ZombieSpawnpoints) == 0 then return end

	local zombiespawn = table.Random(self.ZombieSpawnpoints)
	local pos = zombiespawn[1] + Vector(0, 0, 5)
	local ang = zombiespawn[2]

	return pos
end

-- note: added the ability to create bosses with this function, setting isboss to true will make the monster distribute its xp reward to all attackers and announce its death
function GM:CreateZombie(class, pos, ang, xp, cash, infectionrate, isboss)
	local isboss = isboss or false
	local class = tostring(class)

	local ent = ents.Create(class)
	if !ent:IsValid() then return NULL end

	local lvl = math.random(1+GAMEMODE:GetInfectionLevel()/7, 10+GAMEMODE:GetInfectionLevel()/5)

	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent.XPReward = xp*(0.75+lvl*0.025)
	ent.MoneyReward = cash*(0.85+lvl*0.015)
	ent.InfectionRate = infectionrate
	ent.IsZombie = true
	ent.BossMonster = isboss
	ent.DamagedBy = {}

	ent:SetZombieLevel(lvl)

	ent:Spawn()
	ent:SetHealth(ent:Health() * self.ZombieHealthMultiplier * self:GetDiffZombieHealthMul() * (0.75+lvl*0.025))
	ent:SetMaxHealth(ent:GetMaxHealth() * self.ZombieHealthMultiplier * self:GetDiffZombieHealthMul() * (0.75+lvl*0.025))
	ent:Activate()
	if self:GetDebug() >= DEBUGGING_ADVANCED then print("Zombie spawned:", "\n"..class, pos, ang, "XPReward: "..xp, "MoneyReward: "..cash, isboss and "Isboss: true" or "Isboss: false") end
	return ent -- used for SpawnZombie command
end

timer.Create("TEARemoveLonelyZombies", 30, 0, function()
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		for _, ent in pairs(ents.FindByClass(k)) do GAMEMODE:CheckIfDesertedArea(ent) end
	end
end)

-- delete zombies every 30 seconds if there are no players nearby within radius of 5500 (in source units)
function GM:CheckIfDesertedArea(ent)
	if !ent:IsValid() then return end

	local deserted = true
	local plycheck = ents.FindInSphere(ent:GetPos(), tonumber(self.MaxZombieWanderingDistance))
	for k, v in pairs(plycheck) do
		if v:IsPlayer() then deserted = false end
	end
	if deserted then
		ent.LastAttacker = nil -- we don't want the entities who got removed by the auto-cleanup system to reward those who attacked them previously in an instant
		ent:Remove()
	end
end


function GM:SpawnRandomZombie(pos, ang)
	local maxchance = 0
	for _,z in pairs(self.Config["ZombieClasses"]) do if !z.Disabled then maxchance = maxchance + z.SpawnChance end end

	local dice = math.Rand(0, maxchance)
	local total = 0
	for k, v in pairs(self.Config["ZombieClasses"]) do
		if v.Disabled then continue end
		total = total + v.SpawnChance
		if total >= dice then
			k = v.Miniboss and (#player.GetAll() >= 3 or self:GetInfectionLevel() > 25) and k or !v.Miniboss and k or "npc_tea_basic"
			v = self.Config["ZombieClasses"][k]

			local elitechance = math.Rand(0, 100)
			local elite = elitechance ~= 0 and elitechance <= self:GetEliteVariantSpawnChance(false)
			local ent = self:CreateZombie(k, pos, ang, v.XPReward * self:GetDiffXPMul(), v.MoneyReward * self:GetDiffCashMul(), v.InfectionRate, false)

			if elite and v.AllowEliteVariants then
				local elite_variant = math.random(8)
				local mult,xp,cash,inf = 1,1,1,1
				if elite_variant == VARIANT_POISONOUS then
					ent:SetColor(Color(0,255,0))
					mult,xp,cash,inf = 1.2, 1.15, 1.1, 1.1
				elseif elite_variant == VARIANT_SHOCK then
					ent:SetColor(Color(64,128,255))
					mult,xp,cash,inf = 1.15, 1.2, 1.25, 1.2
				elseif elite_variant == VARIANT_OVERPOWERED then
					ent:SetColor(Color(64,128,255))
					mult,xp,cash,inf = 1.4, 1.35, 1.3, 1.45
				elseif elite_variant == VARIANT_REFLECTOR then
					ent:SetColor(Color(255,128,0))
					mult,xp,cash,inf = 1.25, 1.25, 1.3, 1.4
				elseif elite_variant == VARIANT_INFECTIVE then
					ent:SetColor(Color(255,128,128))
					mult,xp,cash,inf = 1.25, 1.2, 1.15, 1.15
				elseif elite_variant == VARIANT_SICKNESS then
					ent:SetColor(Color(255,128,255))
					mult,xp,cash,inf = 1.25, 1.25, 1.15, 1.1
				elseif elite_variant == VARIANT_LEECH then
					ent:SetColor(Color(127,255,127))
					mult,xp,cash,inf = 1.3, 1.25, 1.15, 1.2
				elseif elite_variant == VARIANT_ENRAGED then
					ent:SetColor(Color(255,255,95))
					mult,xp,cash,inf = 1.25, 1.25, 1.2, 1.25
				end

				ent:SetEliteVariant(elite_variant)
				ent:SetHealth(ent:Health() * mult)
				ent:SetMaxHealth(ent:GetMaxHealth() * mult)
				ent.XPReward = (ent.XPReward or 0) * xp
				ent.MoneyReward = (ent.MoneyReward or 0) * cash
				ent.InfectionRate = (ent.InfectionRate or 0) * inf
				--PrintMessage(3, tostring(ent).." has become elite variant "..elite_variant)
			end


			break
		end
	end
end

function GM:SpawnRandomBoss(pos, ang, plycountoverride, nonotify)
	local maxchance = 0
	plycountoverride = plycountoverride or #player.GetAll()

	for _,z in pairs(self.Config["BossClasses"]) do if !z.Disabled then maxchance = maxchance + z.SpawnChance end end

	local dice = math.Rand(0, 100)
	local total = 0
	for k, v in pairs(self.Config["BossClasses"]) do
		if v.Disabled then continue end
		total = total + v.SpawnChance
		if total >= dice then
			v.BroadCast(nonotify)
			timer.Simple(tonumber(v.SpawnDelay), function()
				self:SystemBroadcast(v.AnnounceMessage, Color(255,105,105), false)
				BroadcastLua([[if GetConVar("tea_cl_soundboss"):GetInt() >= 1 then RunConsoleCommand("playgamesound", "music/stingers/hl1_stinger_song8.mp3") end]])

				local elitechance = math.Rand(0, 100)
				local elite = elitechance ~= 0 and elitechance <= self:GetEliteVariantSpawnChance(true)
				local ent = self:CreateZombie(k, pos, ang, v.XPReward * self:GetDiffXPMul(), v.MoneyReward * self:GetDiffCashMul(), v.InfectionRate, true)

				if elite and v.AllowEliteVariants then
					local elite_variant = 8--math.random(8)
					local mult,xp,cash,inf = 1,1,1,1
					if elite_variant == VARIANT_POISONOUS then
						ent:SetColor(Color(0,255,0))
						mult,xp,cash,inf = 1.2,1.15,1.1,1
					elseif elite_variant == VARIANT_SHOCK then
						ent:SetColor(Color(64,128,255))
						mult,xp,cash,inf = 1.15,1.2,1.25,1
					elseif elite_variant == VARIANT_OVERPOWERED then
						ent:SetColor(Color(64,128,255))
						mult,xp,cash,inf = 1.4,1.35,1.3,1
					elseif elite_variant == VARIANT_REFLECTOR then
						ent:SetColor(Color(255,128,0))
						mult,xp,cash,inf = 1.25,1.15,1.2,1
					elseif elite_variant == VARIANT_INFECTIVE then
						ent:SetColor(Color(255,128,128))
						mult,xp,cash,inf = 1.25,1.2,1.15,1
					elseif elite_variant == VARIANT_SICKNESS then
						ent:SetColor(Color(255,128,255))
						mult,xp,cash,inf = 1.25,1.25,1.15,1
					elseif elite_variant == VARIANT_LEECH then
						ent:SetColor(Color(127,255,127))
						mult,xp,cash,inf = 1.3, 1.25, 1.15, 1.2
					elseif elite_variant == VARIANT_ENRAGED then
						ent:SetColor(Color(255,255,95))
						mult,xp,cash,inf = 1.25, 1.25, 1.2, 1.25
					end

					ent:SetEliteVariant(elite_variant)
					ent:SetHealth(ent:Health() * mult)
					ent:SetMaxHealth(ent:GetMaxHealth() * mult)
					ent.XPReward = (ent.XPReward or 0) * xp
					ent.MoneyReward = (ent.MoneyReward or 0) * cash
					ent.InfectionRate = (ent.InfectionRate or 0) * inf
					self:SystemBroadcast("ALERT! BOSS HAS SPAWNED AS AN ELITE VARIANT, GOOD LUCK...", Color(255,55,55), true)
				end

				if plycountoverride > 4 then
					local mul = math.max(1, 0.80 + plycountoverride*0.05)
					ent:SetHealth(ent:Health() * mul)
					ent:SetMaxHealth(ent:GetMaxHealth() * mul)
					ent.XPReward = (ent.XPReward or 0) * mul
					ent.MoneyReward = (ent.MoneyReward or 0) * mul
					ent.InfectionRate = (ent.InfectionRate or 0) * mul

					if self:GetDebug() >= DEBUGGING_NORMAL then print("Boss is stronger by "..mul.."x") end
--					self:SystemBroadcast("Boss is stronger by "..mul.."x", Color(155,155,255), true)
				end
	
				if self:GetDebug() >= DEBUGGING_ADVANCED then print("Zombie Boss spawned:", "\n"..k, pos, ang, "XPReward: "..v.XPReward, "MoneyReward: "..v.MoneyReward) end
			end)
			break
		end
	end
end


function GM:SpawnZombies()
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
			for k, v in pairs(zeds) do
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

			self:SpawnRandomZombie(spawnpos + Vector(0, 0, 10), Angle(0,math.random(-180,180),0))

		end
		return true
	end


	if table.Count(self.ZombieSpawnpoints) == 0 then return end

	for k, v in RandomPairs(self.ZombieSpawnpoints) do
		if self:ZombieCount() >= self.MaxZombies then break end

		local pos = v[1] + Vector(0, 0, 5)
		local ang = v[2]

		local inzedrange = true
		for _, v in ipairs(ents.FindInSphere(pos, 200)) do
			-- ignore spawnpoints that are obstructed by zombies or players
			if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then inzedrange = false break end
		end
		if !inzedrange then continue end

		local inplyrange = false
		for _, v in ipairs(ents.FindInSphere(pos, tonumber(self.MaxZombieSpawnDistance))) do
			if v:IsPlayer() then inplyrange = true break end
		end
		if !inplyrange then continue end


		self:SpawnRandomZombie(pos + Vector(0, 0, 10), ang)
	end
end
concommand.Add("tea_dev_spawnzombies", function(ply, cmd)
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	GAMEMODE:SpawnZombies()
end)


function GM:SpawnBoss(plycountoverride, nonotify)
	plycountoverride = plycountoverride or #player.GetAll()

	if table.Count(self.ZombieSpawnpoints) == 0 then return end

	for k, v in RandomPairs(self.ZombieSpawnpoints) do
		local pos = v[1]
		local ang = v[2]

		local inzedrange = true
		for _, v in ipairs(ents.FindInSphere(pos, 200)) do
			if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then inzedrange = false break end -- ignore spawnpoints that are obstructed by zombies or players
		end
		if !inzedrange then continue end
		self:SpawnRandomBoss(pos + Vector(0, 0, 40), ang, plycountoverride, nonotify)
		break
	end
end


function GM:NPCReward(ent)
	local ct = CurTime()

	local isboss = ent.BossMonster
	local isvariant = ent:GetEliteVariant() ~= 0
	local isboss = ent.BossMonster and ent.DamagedBy
	local attackers = ent.DamagedBy
	local killer = ent.LastAttacker
	if !ent.TEA_DeadNPC and (ent:IsNextBot() or ent:IsNPC()) and (ent.XPReward and ent.MoneyReward) and attackers then
		if !isboss and killer and killer:IsValid() then
			for attacker, dmg in pairs(attackers) do
				local hasbountyhunter = attacker:HasPerk("bountyhunter")
				local xp = ent.XPReward * self.XPGainMul * math.Round(1 + (attacker.StatKnowledge * 0.03), 3)
				local cash = ent.MoneyReward * self.CashGainMul * (self:CashBonus(attacker) or 1) * math.Round(1 + (attacker.StatSalvage * 0.03), 3)
				GAMEMODE:Payout(attacker,
					xp * (hasbountyhunter and isvariant and 1.1 or 1) * tonumber(math.min(dmg, ent:GetMaxHealth()) / ent:GetMaxHealth()),
					cash * (hasbountyhunter and isvariant and 1.15 or 1) * tonumber(math.min(dmg, ent:GetMaxHealth()) / ent:GetMaxHealth())
				)

				if attacker ~= killer then
					killer:AddStatisticPoints("ZombieKillAssists", 1)
				end

				self:SendPlayerSurvivalStats(attacker)
				self:NetUpdateStatistics(attacker)
			end
			killer:AddStatisticPoints("ZombieKills", 1)
			killer:AddLifeStatisticPoints("ZombieKills", 1)

			gamemode.Call("GiveTaskProgress", killer, "zombie_killer", 1)
			if isvariant then
				gamemode.Call("GiveTaskProgress", killer, "elite_problem", 1)
			end

			local addinfection = ((ent.InfectionRate or 0) * math.min(3, 1 + (killer.ZombieKillStreak * 0.04))) / (1 + ((player.GetCount() - 1) * (2 / 9))) * self.InfectionLevelGainMul
			addinfection = addinfection * (self:GetInfectionLevel() > 100 and 0.4/(self:GetInfectionMul()-1) or
			self:GetInfectionLevel() > 75 and 0.5 or
			self:GetInfectionLevel() > 50 and 0.75 or 1)

			self:SetInfectionLevel(self:GetInfectionLevel() + addinfection)
			self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, ct + 25)
			self.InfectionDecreasedTimes = math.max(0, self.InfectionDecreasedTimes - 5)
			killer.ZombieKillStreak = killer.ZombieKillStreak + 1
			timer.Create("TEA_InfectionStreak_1_"..killer:EntIndex(), math.min(10, 7+killer.ZombieKillStreak*0.05), 1, function()
				if !killer:IsValid() then return end
				killer.ZombieKillStreak = math.floor(killer.ZombieKillStreak / 2)
			end)
			timer.Create("TEA_InfectionStreak_2_"..killer:EntIndex(), math.min(25, 17.5+killer.ZombieKillStreak*0.1), 1, function()
				if !killer:IsValid() then return end
				killer.ZombieKillStreak = 0
			end)
		elseif isboss then
			for pl, v in pairs(attackers) do
				if !pl:IsValid() or !pl:IsPlayer() then continue end
				local hasbountyhunter = pl:HasPerk("bountyhunter")
				local payxp = tonumber(math.min(v, ent:GetMaxHealth()) * ent.XPReward / ent:GetMaxHealth())
				local paycash = tonumber(math.min(v, ent:GetMaxHealth()) * ent.MoneyReward / ent:GetMaxHealth())
				self:Payout(pl,
					math.Round(payxp * self.XPGainMul * (hasbountyhunter and (isvariant and 1.2 or 1.1) or 1)),
					math.Round(paycash * self.CashGainMul * (self:CashBonus(pl) or 1) * (hasbountyhunter and (isvariant and 1.3 or 1.15) or 1))
				)
				
				if v >= ent:GetMaxHealth()*0.05 then
					gamemode.Call("GiveTaskProgress", pl, "boss_hunter", 1)
				end

				pl:PrintTranslatedMessage(HUD_PRINTTALK, "damage_dealt_to_boss", math.Round(v), math.Round((v * 100) / ent:GetMaxHealth()))

				if pl ~= killer then
					pl:AddStatisticPoints("BossKillAssists", 1)
				end
			end
			if killer and killer:IsValid() then
				killer:AddStatisticPoints("BossKills", 1)
			end
			if table.Count(attackers) > 0 then
				self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, ct + 70 + table.Count(attackers) * 5)
				self:SetInfectionLevel(self:GetInfectionLevel() + ((ent.InfectionRate or 0) * self.InfectionLevelGainMul * math.max(1, 0.5 + #player.GetAll()*0.2)))
			end

			local boss_killer
			local boss_damage = 0
			for ply, dmg in pairs(attackers) do
				if dmg > boss_damage then
					boss_killer = ply
					boss_damage = dmg
				end
			end

			if boss_killer and boss_killer:IsPlayer() then
				ent.TEA_KilledByPlayer = boss_killer
			end
			ent.TEA_MostDamageByPlayer = boss_damage
			
			if table.Count(attackers) > 0 then
				if self:GetDebug() >= DEBUGGING_NORMAL then
					print("BOSS DEFEATED:\n")
					PrintTable(attackers)
				end

				net.Start("BossKilled")
				net.WriteTable(attackers)
				net.Broadcast()
			end
		end
		ent.TEA_DeadNPC = true
	end
end


function GM:Payout(ply, xp, cash)
	if !ply:IsValid() or !ply:IsPlayer() or ply == NULL then return end
	local CurXP = ply.XP
	local CurMoney = ply.Money
	local XPGain = xp * (self:XPBonus(ply) or 1)
	local MoneyGain = cash
	local XPBonus = 0 --math.floor(XPGain * (ply.StatKnowledge * 0.02))
	local MoneyBonus = 0 --math.floor(MoneyGain * (ply.StatSalvage * 0.02))

	local TXPGain = XPGain + XPBonus
	local TMoneyGain = MoneyGain + MoneyBonus

	ply.XP = CurXP + TXPGain
	ply.Bounty = ply.Bounty + TMoneyGain
	ply:SetNWInt("PlyBounty", ply.Bounty)
	if self:GetDebug() >= DEBUGGING_ADVANCED then
		print(Format("%s gained %s XP and %s %ss to their bounty", ply:Nick(), TXPGain, TMoneyGain, self.Config["Currency"]))
	end

	if tonumber(ply.Level) < ply:GetMaxLevel() then
		local reqxp = ply:GetReqXP()
		if ply.XP >= reqxp then
			self:GainLevel(ply)
		end
	end
	net.Start("Payout")
	net.WriteFloat(TXPGain)
	net.WriteFloat(TMoneyGain)
	net.Send(ply)

	if ply.MaxLevelTime < CurTime() and tonumber(ply.Level) >= ply:GetMaxLevel() then
		ply.MaxLevelTime = CurTime() + 120
		ply:SendChat(translate.ClientGet(ply, "max_level_reached"))
	end

	self:NetUpdatePeriodicStats(ply)
	return TXPGain, TMoneyGain
end

function GM:TestZombies(ply, cmd, args)
	if !ply:IsValid() then return end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local class = tostring(args[1]) or "npc_ate_basic"
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 5000)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	local ent = ents.Create(class)
	if !IsValid(ent) then ply:SystemMessage("WARNING! Tried to spawn an invalid entity!", Color(255,205,205), true) return end
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0, 0, 0))
	ent.XPMin = 1
	ent.XPMax = 1
	ent.MoneyMin = 1
	ent.MoneyMax = 1
	ent:Spawn()
	ent:Activate()

	undo.Create("Test Zombie")
	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()

	ply:SystemMessage("Spawned zombie "..class, Color(205,255,205), true)
	GAMEMODE:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has spawned a zombie "..class.."!")
end
concommand.Add("tea_dev_createtestzombie", function(ply, cmd, args)
	GAMEMODE:TestZombies(ply, cmd, args)
end)

function GM:SpawnZombie(ply, cmd, args)
	if !ply:IsValid() then return end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local class = tostring(args[1]) or "npc_ate_basic"
	local xp = tonumber(args[2])
	if !xp or xp == -1 then
		xp = GAMEMODE.Config["ZombieClasses"][class] and GAMEMODE.Config["ZombieClasses"][class].XPReward or GAMEMODE.Config["BossClasses"][class] and GAMEMODE.Config["BossClasses"][class].XPReward or 100
	end
	local cash = tonumber(args[3]) or 50
	if !cash or cash == -1 then
		cash = GAMEMODE.Config["ZombieClasses"][class] and GAMEMODE.Config["ZombieClasses"][class].MoneyReward or GAMEMODE.Config["BossClasses"][class] and GAMEMODE.Config["BossClasses"][class].MoneyReward or 50
	end
	local infectionrate = tonumber(args[4]) or 0.01
	if !infectionrate or infectionrate == -1 then
		infectionrate = GAMEMODE.Config["ZombieClasses"][class] and GAMEMODE.Config["ZombieClasses"][class].InfectionRate or GAMEMODE.Config["BossClasses"][class] and GAMEMODE.Config["BossClasses"][class].InfectionRate or 0.05
	end
	local isboss = tobool(args[5]) or false
	if !isboss or isboss == -1 then
		isboss = tobool(GAMEMODE.Config["BossClasses"][class])
	end
	local shouldsendchat = tonumber(args[6]) or 1
	
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 5000)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	local ent = self:CreateZombie(class, tr.HitPos, Angle(0,0,0), xp, cash, infectionrate, isboss)
	if !ent:IsValid() then ply:SystemMessage("ERROR! Tried to spawn in invalid entity!", Color(255,205,205), true) return end

	undo.Create("Zombie")
	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()

	if shouldsendchat >= 1 then ply:SystemMessage("Spawned zombie "..class.." with reward of "..xp.." XP and "..cash.." cash! (Is boss zombie: "..tostring(isboss)..")", Color(205,255,205), true) end
end
concommand.Add("tea_dev_spawnzombie", function(ply, cmd, args)
	GAMEMODE:SpawnZombie(ply, cmd, args)
end)

function GM:StartSpawningZombiesNearPlayer()
	if GetGlobalBool("GM.ZombieSpawnNearPlayer") then return end
	SetGlobalBool("GM.ZombieSpawnNearPlayer", true)
	PrintMessage(3, "enabled")
end

function GM:StopSpawningZombiesNearPlayer()
	if not GetGlobalBool("GM.ZombieSpawnNearPlayer") then return end
	SetGlobalBool("GM.ZombieSpawnNearPlayer", false)
	PrintMessage(3, "disabled")
end
