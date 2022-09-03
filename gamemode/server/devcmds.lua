function TEASpawnLoot(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 70)
    trace.filter = ply
    local tr = util.TraceLine(trace)
    local EntDrop = ents.Create("loot_cache")
    EntDrop:SetPos(tr.HitPos)
    EntDrop:SetAngles(Angle(0, 0, 0))
    EntDrop.LootType = table.Random(LootTable1)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnloot", TEASpawnLoot)

function TEASpawnLootWeapon(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 70)
    trace.filter = ply
    local tr = util.TraceLine(trace)
    local EntDrop = ents.Create("loot_cache_weapon")
    EntDrop:SetPos(tr.HitPos)
    EntDrop:SetAngles(Angle(0, 0, 0))
    EntDrop.LootType = table.Random(LootTable2)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootweapon", TEASpawnLootWeapon)

function TEASpawnLootFaction(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 70)
    trace.filter = ply
    local tr = util.TraceLine(trace)
    local EntDrop = ents.Create("loot_cache_faction")
    EntDrop:SetPos(tr.HitPos)
    EntDrop:SetAngles(Angle(0, 0, 0))
    EntDrop.LootType = table.Random(LootTableFaction)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootfaction", TEASpawnLootFaction)

function TEASpawnLootBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 70)
    trace.filter = ply
    local tr = util.TraceLine(trace)
    local EntDrop = ents.Create("loot_cache_boss")
    EntDrop:SetPos(tr.HitPos)
    EntDrop:SetAngles(Angle(0, 0, 0))
    EntDrop.LootType = table.Random(LootTableBoss)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootboss", TEASpawnLootBoss)

--literally just a copy + paste from airdrops.lua 
function TEASpawnAirdropCache(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end

    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 70)
    trace.filter = ply
    local tr = util.TraceLine(trace)

	local DropList = string.Explode("\n", "")
	for k, v in RandomPairs(DropList) do
		local dropent = ents.Create("airdrop_cache")
		dropent:SetPos(tr.HitPos)
		dropent:SetAngles(Angle(0,0,0))
		local testinv = {
			["Junk"] = {math.random(0, 2), 1, 1},
			["Ammo"] = {math.random(1, 2), 1, 3},
			["Meds"] = {math.random(0, 1), 1, 3},
			["Food"] = {math.random(0, 2), 1, 3},
			["Sellables"] = {math.random(0, 1), 1, 2},
		}

		local dropchance = math.random(1, 150)
		if dropchance > 100 then
			testinv["TyrantWeapons"] = {1, 1, 1}
		elseif dropchance > 40 then
			testinv["FactionWeapons"] = {1, 1, 1}
		else
			testinv["RookieWeapons"] = {1, 1, 1}
		end

		local loot = RollLootTable(testinv)
		MakeLootContainer(dropent, loot)

		dropent:Spawn()
		dropent:Activate()

	end
    
end
concommand.Add("tea_dev_spawnairdropcache", TEASpawnAirdropCache)

function TEASpawnBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 200)
    trace.filter = ply
    local tr = util.TraceLine(trace)
    CreateZombie("npc_nextbot_boss_tyrant", tr.HitPos, Angle(0,0,0), 0, 0, true)
    
end
concommand.Add("tea_dev_spawnboss", TEASpawnBoss)

function TEADevPayout(ply, cmd, args)
	if !ply:IsValid() then return false end
	
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local xp = args[1] or nil
	local cash = args[2] or 0

	if xp == nil or cash == nil then SendChat(ply, "Use this for test! Modifiers such as skills do apply! (tea_dev_payout {xp} {bounty})") return end
	Payout(ply, xp, cash)
	
	FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_payout", TEADevPayout)

function TEARefillStats(ply, cmd)
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    ply.Stamina = 100
    ply.Hunger = 10000
    ply.Thirst = 10000
    ply.Fatigue = 0
    ply.Infection = 0
    
    FullyUpdatePlayer(ply)
    end
    concommand.Add("tea_dev_refillstats", TEARefillStats)

--this was probably one of the hardest commands i've ever added
function TEADevGivePerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1]
	local addqty = args[2]
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Perk Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(StatsListServer) do ply:PrintMessage(2, v) end
	return end
	if addqty == nil then return end
	local stat = "Stat"..statname
	if statname == "Points" then --when they manage to increase their skill points with this command while it's supposed to increase their skill level
		SystemMessage(ply, "You can't increase your Skill Points with this command! Use tea_dev_giveskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = ply[stat] + addqty
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." Skill for "..addqty.." point(s)!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." Skill for "..addqty.." point(s)!")
	SystemMessage(ply, "You increased your "..statname.." Skill for "..addqty.." point(s)!", Color(155,255,155,255), true)

	CalculateMaxHealth(ply)
	CalculateMaxArmor(ply)
	CalculateJumpPower(ply)
	RecalcPlayerSpeed(ply)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_dev_giveperk", TEADevGivePerk)

function TEADevGiveStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local addqty = tonumber(args[2])
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only (periodic) stats!\n \nList:")
		for k,v in ipairs(StatsListServer2) do ply:PrintMessage(2, v) end
	return end
	if addqty == nil then return end
/*	if string.lower(statname) == "StatAgility" then
		SystemMessage(ply, "You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end*/

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." values for "..addqty.."!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." values for "..addqty.."!")
	SystemMessage(ply, "You gave yourself "..statname.." values for "..addqty.."!", Color(155,255,155,255), true)

    ply[statname] = ply[statname] + addqty

	RecalcPlayerSpeed(ply)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_dev_givestat", TEADevGiveStat)

function TEADevSetPerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local setqty = args[2]
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Perk Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(StatsListServer) do ply:PrintMessage(2, v) end
	return end
	if setqty == nil then return end
	local stat = "Stat"..statname
	if statname == "Points" then
		SystemMessage(ply, "You can't set your Skill Points with this command! Use tea_dev_setskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = setqty
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." Skill value to "..setqty.."!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." Skill value to "..setqty.."!")
	SystemMessage(ply, "You set your "..statname.." Skill value to "..setqty.."!", Color(155,255,155,255), true)

	CalculateMaxHealth(ply)
	CalculateMaxArmor(ply)
	CalculateJumpPower(ply)
	RecalcPlayerSpeed(ply)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_dev_setperk", TEADevSetPerk)


function TEADevSetStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local setqty = tonumber(args[2])
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only (periodic) stats!\n \nList:")
		for k,v in ipairs(StatsListServer2) do ply:PrintMessage(2, v) end
	return end
	if setqty == nil then return end
/*	if string.lower(statname) == "StatAgility" then
		SystemMessage(ply, "You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end*/

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." value to "..setqty.."!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." value to "..setqty.."!")
	SystemMessage(ply, "You set your "..statname.." value to "..setqty.."!", Color(155,255,155,255), true)

    ply[statname] = setqty

	RecalcPlayerSpeed(ply)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_dev_setstat", TEADevSetStat)

function TEADevPauseStats(ply, cmd)
    if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEADevCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if ply.StatsPaused != true then
        ply.StatsPaused = true
    else
        ply.StatsPaused = false
    end
end
concommand.Add("tea_dev_pausestats", TEADevPauseStats)

/*
SetCash
Level
XP
Bounty
StatPoints
Stamina
Hunger
Thirst
Fatigue
Infection
*/
