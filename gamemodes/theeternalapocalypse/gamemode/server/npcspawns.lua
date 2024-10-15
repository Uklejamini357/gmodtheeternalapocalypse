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
		ZombieData = "" --reset it
		ZombieData = file.Read(self.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/zombies.txt", "DATA")
		print("Zombie spawnpoints loaded")
	else
		ZombieData = "" --just in case
		print("No zombie spawnpoints found for this map")
	end
end


-- Not used currently.
function GM:GetRandomZombieSpawn()
	if ZombieData ~= "" then

		local ZombiesList = string.Explode("\n", ZombieData)
		local zombiespawn = table.Random(ZombiesList)
		local Zed = string.Explode(";", zombiespawn)
		local pos = util.StringToType(Zed[1], "Vector") + Vector(0, 0, 5)
		local ang = util.StringToType(Zed[2], "Angle")

		return pos
	end

	return nil
end

-- note: added the ability to create bosses with this function, setting isboss to true will make the monster distribute its xp reward to all attackers and announce its death
function GM:CreateZombie(class, pos, ang, xp, cash, infectionrate, isboss)
	local isboss = isboss or false
	local class = tostring(class)

	local ent = ents.Create(class)
	if !ent:IsValid() then return NULL end
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent.XPReward = xp
	ent.MoneyReward = cash
	ent.InfectionRate = infectionrate
	ent.IsZombie = true
	ent.BossMonster = isboss
	if isboss then
		ent.DamagedBy = {}
	end
	ent:Spawn()
	ent:SetHealth(ent:Health() * self.ZombieHealthMultiplier)
	ent:SetMaxHealth(ent:GetMaxHealth() * self.ZombieHealthMultiplier)
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
			local elite = elitechance ~= 0 and elitechance <= self:GetEliveVariantSpawnChance(false)
			local ent = self:CreateZombie(k, pos, ang, v.XPReward, v.MoneyReward, v.InfectionRate, false)

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
				for k, v in pairs(player.GetAll()) do BroadcastLua([[if GetConVar("tea_cl_soundboss"):GetInt() >= 1 then RunConsoleCommand("playgamesound", "music/stingers/hl1_stinger_song8.mp3") end]]) end

				local elitechance = math.Rand(0, 100)
				local elite = elitechance ~= 0 and elitechance <= self:GetEliveVariantSpawnChance(true)
				local ent = self:CreateZombie(k, pos, ang, v.XPReward, v.MoneyReward, v.InfectionRate, true)
	
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
						ent:SetColor(Color(64,128,255))
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
	if ZombieData ~= "" then
		local ZombiesList = string.Explode("\n", ZombieData)
		for k, v in RandomPairs(ZombiesList) do
			local Zed = string.Explode(";", v)
			local pos = util.StringToType(Zed[1], "Vector") + Vector(0, 0, 5)
			local ang = util.StringToType(Zed[2], "Angle")
			local inzedrange = true
			local zeds = ents.FindInSphere(pos, 250)
			for k, v in pairs(zeds) do
				if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then inzedrange = false end -- ignore spawnpoints that are obstructed by zombies or players
			end

			local inplyrange = false
			local plycheck = ents.FindInSphere(pos, tonumber(self.MaxZombieSpawnDistance))
			for k, v in pairs(plycheck) do
				if v:IsPlayer() then inplyrange = true end
			end

			if inplyrange == false or inzedrange == false then continue end
			if self:ZombieCount() >= self.MaxZombies then break end

			self:SpawnRandomZombie(pos + Vector(0, 0, 10), ang)
		end
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


function GM:AddZombie(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if ZombieData == "" then
		NewData = tostring(ply:GetPos()) ..";".. tostring(ply:GetAngles())
	else
		NewData = ZombieData .. "\n" .. tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	end
	
	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", NewData)

	self:LoadZombies() --reload them
	
	ply:SendChat("Added a zombie spawnpoint at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a zombie spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_addzombiespawn", function(ply, cmd, args, str)
	GAMEMODE:AddZombie(ply, cmd, args, str)
end)

function GM:ClearZombies(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205), true)
			ply:ConCommand("playgamesound buttons/button8.wav")
			return
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt")
		ZombieData = ""
	end
	ply:SendChat("Deleted all zombie spawnpoints")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all zombie spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearzombiespawns", function(ply, cmd, args, str)
	GAMEMODE:ClearZombies(ply, cmd, args, str)
end)

function GM:SpawnBoss(plycountoverride, nonotify)
	local bspawned = false
	plycountoverride = plycountoverride or #player.GetAll()

	if ZombieData != "" then
		local ZombiesList = string.Explode("\n", ZombieData)
		for k, v in RandomPairs(ZombiesList) do
			local Zed = string.Explode(";", v)
			local pos = util.StringToType(Zed[1], "Vector")
			local ang = util.StringToType(Zed[2], "Angle")
			local inzedrange = true
			local zeds = ents.FindInSphere(pos, 250)
			for k, v in pairs(zeds) do
				if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then inzedrange = false end -- ignore spawnpoints that are obstructed by zombies or players
			end

			if bspawned then continue end
			if !inzedrange then continue end
			self:SpawnRandomBoss(pos + Vector(0, 0, 40), ang, plycountoverride, nonotify)
			bspawned = true
		end
	end
end


function GM:NPCReward(ent)
	local ct = CurTime()

	local attacker = ent.LastAttacker
	local isvariant = ent:GetEliteVariant() ~= 0
	local isboss = ent.BossMonster and ent.DamagedBy
	if !ent.TEA_DeadNPC and (ent:IsNextBot() or ent:IsNPC()) and (ent.XPReward and ent.MoneyReward) then
		if !isboss and attacker and attacker:IsValid() then
			local plyhasperk = attacker.UnlockedPerks["bountyhunter"]
			local xp = ent.XPReward * self.XPGainMul * GAMEMODE:GetInfectionMul() * math.Round(1 + (attacker.StatKnowledge * 0.025), 3)
			local cash = ent.MoneyReward * self.CashGainMul * (0.5 + (GAMEMODE:GetInfectionMul() * 0.5)) * (self:CashBonus(attacker) or 1) * math.Round(1 + (attacker.StatSalvage * 0.025), 3)
			GAMEMODE:Payout(attacker,
				xp * (plyhasperk and (isvariant and 1.1 or 1) or 1),
				cash * (plyhasperk and (isvariant and 1.15 or 1) or 1)
			)
			attacker.ZKills = attacker.ZKills + 1
			attacker.LifeZKills = attacker.LifeZKills + 1
			gamemode.Call("GiveTaskProgress", attacker, "zombie_killer", 1)

			self:SendPlayerSurvivalStats(attacker)
			self:NetUpdateStatistics(attacker)
			local addinfection = ((ent.InfectionRate or 0) * math.min(3, 1 + (attacker.ZombieKillStreak * 0.04))) / (1 + ((player.GetCount() - 1) * (7 / 9))) * self.InfectionLevelGainMul
			addinfection = addinfection * (self:GetInfectionLevel() > 100 and 0.25/(self:GetInfectionMul()-1) or self:GetInfectionLevel() > 75 and 0.5 or self:GetInfectionLevel() > 50 and 0.75 or 1)

			self:SetInfectionLevel(self:GetInfectionLevel() + addinfection)
			self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, ct + 25)
			self.InfectionDecreasedTimes = 0
			attacker.ZombieKillStreak = attacker.ZombieKillStreak + 1
			timer.Create("TEA_InfectionStreak_1_"..attacker:EntIndex(), 7.5, 1, function()
				if !attacker:IsValid() then return end
				attacker.ZombieKillStreak = math.floor(attacker.ZombieKillStreak / 3)
			end)
			timer.Create("TEA_InfectionStreak_2_"..attacker:EntIndex(), 20, 1, function()
				if !attacker:IsValid() then return end
				attacker.ZombieKillStreak = 0
			end)
		elseif isboss then
			for pl, v in pairs(ent.DamagedBy) do
				if !pl:IsValid() or !pl:IsPlayer() then continue end
				local plyhasperk = pl.UnlockedPerks["bountyhunter"]
				local payxp = tonumber(math.min(v, ent:GetMaxHealth()) * ent.XPReward / ent:GetMaxHealth())
				local paycash = tonumber(math.min(v, ent:GetMaxHealth()) * ent.MoneyReward / ent:GetMaxHealth())
				self:Payout(pl,
					math.Round(payxp * self.XPGainMul * self:GetInfectionMul() * (plyhasperk and (isvariant and 1.2 or 1.1) or 1)),
					math.Round(paycash * self.CashGainMul * (0.5 + (GAMEMODE:GetInfectionMul() * 0.5)) * (self:CashBonus(pl) or 1) * (plyhasperk and (isvariant and 1.3 or 1.15) or 1))
				)
				pl:PrintMessage(HUD_PRINTTALK, Format("Damage dealt to boss: %s (%s%% damage)", math.Round(v), math.Round((v * 100) / ent:GetMaxHealth())))
			end

			if table.Count(ent.DamagedBy) > 0 then
				self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, ct + 70 + table.Count(ent.DamagedBy) * 5)
				self:SetInfectionLevel(self:GetInfectionLevel() + ((ent.InfectionRate or 0) * self.InfectionLevelGainMul * math.max(1, 0.5 + #player.GetAll()*0.2)))
			end

			local boss_killer
			local boss_damage = 0
			for ply, dmg in pairs(ent.DamagedBy) do
				if dmg > boss_damage then
					boss_killer = ply
					boss_damage = dmg
				end
			end

			if boss_killer and boss_killer:IsPlayer() then
				ent.TEA_KilledByPlayer = boss_killer
			end
			ent.TEA_MostDamageByPlayer = boss_damage
			
			if table.Count(ent.DamagedBy) > 0 then
				if self:GetDebug() >= DEBUGGING_NORMAL then
					print("BOSS DEFEATED:\n")
					PrintTable(ent.DamagedBy)
				end

				net.Start("BossKilled")
				net.WriteTable(ent.DamagedBy)
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
		ply:SendChat("You have reached max level, consider prestiging.")
	end

	self:NetUpdatePeriodicStats(ply)
	return TXPGain, TMoneyGain
end

-- doesn't work for some reason, so leave it
/*
function ZombieDealDamage(ply, zed, dmgmin, dmgmax, force, infection)
	local damageInfo = DamageInfo()
	local dmg1 = math.random(dmgmin, dmgmax)

	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end

	local armorbonus = dmg1 * armorvalue
	local defencebonus = dmg1 * (0.015 * ply.StatDefense)
	local dmg2 = dmg1 - (defencebonus + armorbonus)

	damageInfo:SetAttacker(zed)
	damageInfo:SetDamage(dmg2)
	damageInfo:SetDamageType(DMG_CLUB)

	local force = ply:GetAimVector() * force
	force.z = 32
	damageInfo:SetDamageForce(force)

	ply:TakeDamageInfo(damageInfo)
	ply:EmitSound("npc/zombie/zombie_hit.wav", 100, math.random(80, 110))
	ply:ViewPunch(VectorRand():Angle() * 0.05)
	ply:SetVelocity(force)
	if math.random(0, 100) > (100 - (infection * (1 - (0.04 * ply.StatImmunity)))) then
		ply:AddInfection(math.random(60,300))
	end
end
*/

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
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has spawned a zombie "..class.."!")
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
	local xp = tonumber(args[2]) or 100
	local cash = tonumber(args[3]) or 50
	local infectionrate = tonumber(args[4]) or 0.01
	local isboss = tobool(args[5]) or false
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
