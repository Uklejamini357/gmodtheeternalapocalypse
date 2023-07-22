---------------- Zombies! ----------------

local ZombieData = ""

function GM.ZombieCount()
	local AliveZombies = 0
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		for _, ent in pairs(ents.FindByClass(k)) do AliveZombies = AliveZombies + 1 end
	end

	return AliveZombies
end


function GM:LoadZombies()
	if not file.IsDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", "DATA") then
		ZombieData = "" --reset it
		ZombieData = file.Read(GAMEMODE.DataFolder.."/spawns/" .. string.lower(game.GetMap()) .. "/zombies.txt", "DATA")
		print("Zombie spawnpoints loaded")
	else
		ZombieData = "" --just in case
		print("No zombie spawnpoints found for this map")
	end
end

-- note: added the ability to create bosses with this function, setting isboss to true will make the monster distribute its xp reward to all attackers and announce its death
function CreateZombie(class, pos, ang, xp, cash, isboss)
	local isboss = isboss or false
	local class = tostring(class)

	local SpawnZombie = ents.Create(class)
	if !SpawnZombie:IsValid() then return NULL end
	SpawnZombie:SetPos(pos)
	SpawnZombie:SetAngles(ang)
	SpawnZombie.XPReward = xp
	SpawnZombie.MoneyReward = cash
	SpawnZombie.BossMonster = isboss
	if isboss then
		SpawnZombie.DamagedBy = {}
	end
	SpawnZombie:Spawn()
	SpawnZombie:SetHealth(SpawnZombie:Health() * GetConVar("tea_config_zombiehpmul"):GetFloat())
	SpawnZombie:SetMaxHealth(SpawnZombie:GetMaxHealth() * GetConVar("tea_config_zombiehpmul"):GetFloat())
	SpawnZombie:Activate()
	if GetConVar("tea_server_debugging"):GetInt() >= 2 then print("Zombie spawned:", "\n"..class, pos, ang, "XPReward: "..xp, "MoneyReward: "..cash, isboss and "Isboss: true" or "Isboss: false") end
	return SpawnZombie -- used for SpawnZombie command
end

timer.Create("RemoveDesertedZombies", 30, 0, function()
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		for _, ent in pairs(ents.FindByClass(k)) do CheckIfDesertedArea(ent) end
	end
end)

-- delete zombies every 30 seconds if there are no players nearby within radius of 5500 (in source units)
function CheckIfDesertedArea(ent)
	if !ent:IsValid() then return end

	local deserted = true
	local plycheck = ents.FindInSphere(ent:GetPos(), tonumber(GAMEMODE.MaxZombieWanderingDistance))
	for k, v in pairs(plycheck) do
		if v:IsPlayer() then deserted = false end
	end
	if deserted then
		ent.LastAttacker = nil -- we don't want the entities who got removed by the auto-cleanup system to reward those who attacked them previously in an instant
		ent:Remove()
	end
end


function GM.SpawnRandomZombie(pos, ang)
	local dice = math.Rand(0, 100)
	local total = 0
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		total = total + v["SpawnChance"]
		if total >= dice then
			CreateZombie(k, pos, ang, v["XPReward"], v["MoneyReward"], false)
			break
		end
	end
end

function GM.SpawnRandomBoss(pos, ang)
	local dice = math.Rand(0, 100)
	local total = 0
	for k, v in pairs(GAMEMODE.Config["BossClasses"]) do
		total = total + v["SpawnChance"]
		if total >= dice then
			v["BroadCast"]()
			timer.Simple(tonumber(v["SpawnDelay"]), function()
				tea_SystemBroadcast(v["AnnounceMessage"], Color(255,105,105,255), false)
				for k, v in pairs(player.GetAll()) do BroadcastLua([[if GetConVar("tea_cl_soundboss"):GetInt() >= 1 then RunConsoleCommand("playgamesound", "music/stingers/hl1_stinger_song8.mp3") end]]) end
				CreateZombie(k, pos, ang, v["XPReward"], v["MoneyReward"], true)
				if GetConVar("tea_server_debugging"):GetInt() >= 2 then print("Zombie Boss spawned:", "\n"..k, pos, ang, "XPReward: "..v["XPReward"], "MoneyReward: "..v["MoneyReward"]) end
			end)
			break
		end
	end
end


function GM.SpawnZombies()
	local zombiespawnenabled = GAMEMODE.ZombieSpawningEnabled
	if GAMEMODE.ZombieCount() >= GAMEMODE.MaxZombies or !zombiespawnenabled then return false end
	if ZombieData != "" then
		local ZombiesList = string.Explode("\n", ZombieData)
		for k, v in RandomPairs(ZombiesList) do
			Zed = string.Explode(";", v)
			local pos = util.StringToType(Zed[1], "Vector") + Vector(0, 0, 5)
			local ang = util.StringToType(Zed[2], "Angle")
			local inzedrange = true
			local zeds = ents.FindInSphere(pos, 250)
			for k, v in pairs(zeds) do
				if v.Type == "nextbot" or v:IsNPC() or v:IsPlayer() then inzedrange = false end -- ignore spawnpoints that are obstructed by zombies or players
			end

			local inplyrange = false
			local plycheck = ents.FindInSphere(pos, tonumber(GAMEMODE.MaxZombieSpawnDistance))
			for k, v in pairs(plycheck) do
				if v:IsPlayer() then inplyrange = true end
			end

			if inplyrange == false or inzedrange == false then continue end
			if GAMEMODE.ZombieCount() >= GAMEMODE.MaxZombies or !zombiespawnenabled then break end

			GAMEMODE.SpawnRandomZombie(pos + Vector(0, 0, 10), ang)
		end
	end
end
concommand.Add("tea_dev_spawnzombies", function(ply, cmd)
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	GAMEMODE.SpawnZombies()
end)


function GM.AddZombie(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if ZombieData == "" then
		NewData = tostring(ply:GetPos()) ..";".. tostring(ply:GetAngles())
	else
		NewData = ZombieData .. "\n" .. tostring(ply:GetPos()) .. ";" .. tostring(ply:GetAngles())
	end
	
	file.Write(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", NewData)

	GAMEMODE.LoadZombies() --reload them
	
	SendChat(ply, "Added a zombie spawnpoint at position "..tostring(ply:GetPos()).."!")
	tea_DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a zombie spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_addzombiespawn", GM.AddZombie)

function GM.ClearZombies(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
			SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
			ply:ConCommand("playgamesound buttons/button8.wav")
			return
	end
	if file.Exists(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt", "DATA") then
		file.Delete(GAMEMODE.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/zombies.txt")
		ZombieData = ""
	end
	SendChat(ply, "Deleted all zombie spawnpoints")
	tea_DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all zombie spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_clearzombiespawns", GM.ClearZombies)

function SpawnBoss()
	if !GAMEMODE.CanSpawnBoss and table.Count(player.GetAll()) < 2 then return end
	local bspawned = false

	if ZombieData != "" then
		local ZombiesList = string.Explode("\n", ZombieData)
		for k, v in RandomPairs(ZombiesList) do
			Zed = string.Explode(";", v)
			local pos = util.StringToType(Zed[1], "Vector")
			local ang = util.StringToType(Zed[2], "Angle")
			local inzedrange = true
			local zeds = ents.FindInSphere(pos, 250)
			for k, v in pairs(zeds) do
				if v.Type == "nextbot" or v:IsNPC() or v:IsPlayer() then inzedrange = false end -- ignore spawnpoints that are obstructed by zombies or players
			end

			if bspawned == true then continue end
			if inzedrange == false then continue end
			GAMEMODE.SpawnRandomBoss(pos + Vector(0, 0, 40), ang)
			bspawned = true
		end
	end
end


function StoreAttacker(target, dmginfo)
	local dmg = dmginfo:GetDamage()
	local attacker = dmginfo:GetAttacker()
	if (target.Type == "nextbot" or target:IsNPC()) and (!target.LastAttacker or target:Health() > 0) and attacker:IsPlayer() then
		if !target.BossMonster then
			target.LastAttacker = attacker
			timer.Create("TEA_LastAttacker_"..target:EntIndex(), 15, 1, function()
				if !target:IsValid() then return end
				target.LastAttacker = nil	-- if time after the target last received damage from the attacker, we claim that the last target's attacker is no more
			end)
		else
			if !target.DamagedBy[attacker] then 
				target.DamagedBy[attacker] = math.Clamp(dmg, 0, target:GetMaxHealth())
			else
				target.DamagedBy[attacker] = math.Clamp(target.DamagedBy[attacker] + math.Clamp(dmg, 0, target:Health()), 0, target:GetMaxHealth())
			end
		end
	end
end
hook.Add("EntityTakeDamage", "StoreAttacker", StoreAttacker, HOOK_LOW)

function NPCReward(ent)
	local tea_server_xpreward = GetConVar("tea_server_xpreward"):GetFloat()
	local tea_server_moneyreward = GetConVar("tea_server_moneyreward"):GetFloat()

	if (ent.Type == "nextbot" or ent:IsNPC()) and (ent.XPReward and ent.MoneyReward) then
		if ent.LastAttacker and ent.LastAttacker:IsValid() then
			Payout(ent.LastAttacker, ent.XPReward * tea_server_xpreward, ent.MoneyReward * tea_server_moneyreward * (tea_CashBonus(ent.LastAttacker) or 1))
			ent.LastAttacker.ZKills = ent.LastAttacker.ZKills + 1
			tea_NetUpdateStatistics(ent.LastAttacker)
		elseif ent.DamagedBy then
			for k, v in pairs(ent.DamagedBy) do
				if !k:IsValid() or !k:IsPlayer() then continue end
				local payxp = tonumber(v * ent.XPReward / ent:GetMaxHealth())
				local paycash = tonumber(v * ent.MoneyReward / ent:GetMaxHealth())
				Payout(k, math.Round(payxp * tea_server_xpreward), math.Round(paycash * tea_server_moneyreward * (tea_CashBonus(k) or 1)))
				k:PrintMessage(HUD_PRINTTALK, Format("Damage dealt to boss: %s (%s%% damage)", math.Round(v), math.Round((v * 100) / ent:GetMaxHealth())))
			end

			local boss_killer
			local boss_damager = 0
			for ply,dmg in pairs(ent.DamagedBy) do
				if dmg > boss_damager then
					boss_killer = ply
					boss_damager = dmg
				end
			end

			if GetConVar("tea_server_debugging"):GetInt() >= 1 then
				print("BOSS DEFEATED:\n")
				PrintTable(ent.DamagedBy)
			end

			if boss_killer and boss_killer:IsPlayer() then
				tea_SystemBroadcast(boss_killer:Nick().." has dealt most damage to boss ("..boss_damager..") and can pick up the boss cache!", Color(127,127,255), true)
			end
			
			net.Start("BossKilled")
			net.WriteTable(ent.DamagedBy)
			net.Broadcast()

			local EntDrop = ents.Create("loot_cache_boss")
			EntDrop:SetNWEntity("pickup", boss_killer)
			local name = EntDrop:GetNWEntity("pickup"):IsPlayer() and EntDrop:GetNWEntity("pickup"):Nick()
			timer.Simple(300, function() if EntDrop:IsValid() and EntDrop:GetNWEntity("pickup"):IsValid() then tea_SystemBroadcast(name.." didn't want to pick up the boss cache, and now everyone can pick it up!", Color(255,255,255), true) EntDrop:SetNWEntity("pickup", NULL) end end)
			EntDrop:SetPos(ent:GetPos() + Vector(0, 0, 50))
			EntDrop:SetAngles(ent:GetAngles())
			EntDrop.LootType = table.Random(GAMEMODE.LootTableBoss)["Class"]
			EntDrop:Spawn()
			EntDrop:Activate()
		end
	end
end
hook.Add("EntityRemoved", "killpayouts", NPCReward)


function Payout(ply, xp, cash)
	if !ply:IsValid() or !ply:IsPlayer() then return end
	local CurXP = ply.XP
	local CurMoney = ply.Money
	local XPGain = xp * (tea_XPBonus(ply) or 1)
	local MoneyGain = cash
	local XPBonus = math.floor(XPGain * (ply.StatKnowledge * 0.02))
	local MoneyBonus = math.floor(MoneyGain * (ply.StatSalvage * 0.02))

	local TXPGain = XPGain + XPBonus
	local TMoneyGain = MoneyGain + MoneyBonus

	ply.XP = CurXP + TXPGain
	ply.Bounty = ply.Bounty + TMoneyGain
	ply:SetNWInt("PlyBounty", ply.Bounty)
	if GetConVar("tea_server_debugging"):GetInt() >= 1 then
		print(ply:Nick().." gained "..TXPGain.." XP ("..XPGain..", +"..XPBonus.." with Knowledge Skill level "..ply.StatKnowledge..", Total "..ply.XP..") and "..TMoneyGain.." "..GAMEMODE.Config["Currency"].."s to their bounty ("..MoneyGain..", +"..MoneyBonus.." with Salvage Skill level "..ply.StatSalvage..", Total "..ply.Bounty..")")
	end

	if tonumber(ply.Level) < GAMEMODE.MaxLevel + (GAMEMODE.LevelsPerPrestige * ply.Prestige) then tea_GainLevel(ply) end
	net.Start("Payout")
	net.WriteFloat(TXPGain)
	net.WriteFloat(TMoneyGain)
	net.Send(ply)

	if ply.MaxLevelTime < CurTime() and tonumber(ply.Level) >= GAMEMODE.MaxLevel + (GAMEMODE.LevelsPerPrestige * ply.Prestige) then
		SendChat(ply, "You have reached max level, consider prestiging.")
		ply.MaxLevelTime = CurTime() + 120
	end

	tea_NetUpdatePeriodicStats(ply)
	return TXPGain, TMoneyGain
end

-- doesn't work for some reason, so leave it
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
		ply.Infection = ply.Infection + math.random(60,300)
	end
end


function TestZombies(ply, cmd, args)
	if !ply:IsValid() then return end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
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

	local SpawnZombie = ents.Create(class)
	if !IsValid(SpawnZombie) then SystemMessage(ply, "WARNING! Tried to spawn an invalid entity!", Color(255,205,205), true) return end
	SpawnZombie:SetPos(tr.HitPos)
	SpawnZombie:SetAngles(Angle(0, 0, 0))
	SpawnZombie.XPMin = 1
	SpawnZombie.XPMax = 1
	SpawnZombie.MoneyMin = 1
	SpawnZombie.MoneyMax = 1
	SpawnZombie:Spawn()
	SpawnZombie:Activate()

	undo.Create("Test Zombie")
	undo.AddEntity(SpawnZombie)
	undo.SetPlayer(ply)
	undo.Finish()

	SystemMessage(ply, "Spawned zombie "..class, Color(205,255,205,255), true)
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has spawned a zombie "..class.."!")
end
concommand.Add("tea_dev_createtestzombie", TestZombies)

function SpawnZombie(ply, cmd, args)
	if !ply:IsValid() then return end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local class = tostring(args[1]) or "npc_ate_basic"
	local xp = tonumber(args[2]) or 100
	local cash = tonumber(args[3]) or 50
	local isboss = tobool(args[4]) or false
	local shouldsendchat = tonumber(args[5]) or 1
	
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 5000)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	local ent = CreateZombie(class, tr.HitPos, Angle(0,0,0), xp, cash, isboss)
	if !ent:IsValid() then SystemMessage(ply, "ERROR! Tried to spawn in invalid entity!", Color(255,205,205,255), true) return end

	undo.Create("Zombie")
	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()

	if shouldsendchat >= 1 then SystemMessage(ply, "Spawned zombie "..class.." with reward of "..xp.." XP and "..cash.." cash! (Is boss zombie: "..tostring(isboss)..")", Color(205,255,205,255), true) end
end
concommand.Add("tea_dev_spawnzombie", SpawnZombie)
