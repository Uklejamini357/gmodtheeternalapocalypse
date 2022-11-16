--Dev commands
--Do not change, unless there are bugs or if adding more
GM.DevCmds = {}

function GM.DevCmds.SpawnLoot(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    EntDrop.LootType = table.Random(GAMEMODE.LootTable1)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
end
concommand.Add("tea_dev_spawnloot", GM.DevCmds.SpawnLoot, nil, "Spawns a loot cache in front of you")

function GM.DevCmds.SpawnLootWeapon(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    EntDrop.LootType = table.Random(GAMEMODE.LootTable2)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootweapon", GM.DevCmds.SpawnLootWeapon, nil, "Spawns a weapon loot cache in front of you")

function GM.DevCmds.SpawnLootFaction(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    EntDrop.LootType = table.Random(GAMEMODE.LootTableFaction)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootfaction", GM.DevCmds.SpawnLootFaction, nil, "Spawns a faction loot cache in front of you")

function GM.DevCmds.SpawnLootBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    EntDrop.LootType = table.Random(GAMEMODE.LootTableBoss)["Class"]
    EntDrop:Spawn()
    EntDrop:Activate()
    EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootboss", GM.DevCmds.SpawnLootBoss, nil, "Spawns a boss cache in front of you")

--literally just a copy + paste from airdrops.lua but now as a command
function GM.DevCmds.SpawnAirdropCache(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
			["Junk"] = {math.random(0, 1), 1, 1},
			["Ammo"] = {math.random(1, 2), 1, 3},
			["Meds"] = {math.random(0, 2), 1, 3},
			["Food"] = {math.random(0, 2), 1, 3},
			["Sellables"] = {math.random(0, 1), 1, 2},
		}

		local rng = math.random(0, 100)
		if rng >= 95 then
			testinv["SpecialWeapons"] = {1, 1, 1}
		elseif rng >= 50 then
			testinv["FactionWeapons"] = {1, 1, 1}
		elseif rng >= 15 then
			testinv["FactionWeapons"] = {1, 1, 1}
		else
			testinv["RookieWeapons"] = {math.random(1, 3), 1, 2}
		end


		local loot = tea_RollLootTable(testinv)
		tea_MakeLootContainer(dropent, loot)

		dropent:Spawn()
		dropent:Activate()

	end
end
concommand.Add("tea_dev_spawnairdropcache", GM.DevCmds.SpawnAirdropCache, nil, "Spawns an airdrop cache in front of you")

function GM.DevCmds.SpawnBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
	local dice = math.random(0, 100)
	local total = 0
	for k, v in pairs(GAMEMODE.Config["BossClasses"]) do
		total = total + v["SpawnChance"]
		if total >= dice then
			CreateZombie(k, tr.HitPos, Angle(0,0,0), v["XPReward"], v["MoneyReward"], true)
			break
		end
	end
end
concommand.Add("tea_dev_spawnboss", GM.DevCmds.SpawnBoss, nil, "Spawns a random boss in your direction")

function GM.DevCmds.Payout(ply, cmd, args)
	if !ply:IsValid() then return false end
	
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local xp = tonumber(args[1]) or nil
	local cash = tonumber(args[2]) or 0

	if !xp or !cash then SendChat(ply, "Use this for test! Modifiers such as skills do apply! (tea_dev_payout {xp} {bounty})") return end
	Payout(ply, xp, cash)
	
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_payout", GM.DevCmds.Payout, nil, "Gives XP and Cash (with Payout function)")

function GM.DevCmds.RefillStats(ply, cmd)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
    
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_refillstats", GM.DevCmds.RefillStats, nil, "Refills your Stamina, Hungeer, Thirst, Fatigue and Infection.")

function GM.DevCmds.GivePerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1]
	local addqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Perk Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(GAMEMODE.StatsListServer) do ply:PrintMessage(2, v) end
	return end
	if !addqty then return end
	local stat = "Stat"..statname
	if statname == "Points" then --when they manage to increase their skill points with this command while it's supposed to increase their skill level
		SystemMessage(ply, "You can't increase your Skill Points with this command! Use tea_dev_giveskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = ply[stat] + addqty
	SystemMessage(ply, "You increased your "..statname.." Skill for "..addqty.." point(s)!", Color(155,255,155,255), true)

	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	tea_RecalcPlayerSpeed(ply)
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_giveperk", GM.DevCmds.GivePerk)

function GM.DevCmds.GiveStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local addqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only (periodic) stats!\n \nList:")
		for k,v in ipairs(GAMEMODE.StatsListServer2) do ply:PrintMessage(2, v) end
	return end
	if !addqty then return end
/*	if string.lower(statname) == "StatAgility" then
		SystemMessage(ply, "You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end*/

	SystemMessage(ply, "You gave yourself "..statname.." values for "..addqty.."!", Color(155,255,155,255), true)

    ply[statname] = ply[statname] + addqty

	tea_RecalcPlayerSpeed(ply)
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_givestat", GM.DevCmds.GiveStat)

function GM.DevCmds.SetPerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local setqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Perk Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(GAMEMODE.StatsListServer) do ply:PrintMessage(2, v) end
	return end
	if !setqty then return end
	local stat = "Stat"..statname
	if statname == "Points" then
		SystemMessage(ply, "You can't set your Skill Points with this command! Use tea_dev_setskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = setqty
	SystemMessage(ply, "You set your "..statname.." Skill value to "..setqty.."!", Color(155,255,155,255), true)

	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	tea_RecalcPlayerSpeed(ply)
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_setperk", GM.DevCmds.SetPerk)


function GM.DevCmds.SetStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local setqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only (periodic) stats!\n \nList:")
		for k,v in ipairs(GAMEMODE.StatsListServer2) do ply:PrintMessage(2, v) end
	return end
	if !setqty then return end
/*	if string.lower(statname) == "StatAgility" then
		SystemMessage(ply, "You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end*/

	SystemMessage(ply, "You set your "..statname.." value to "..setqty.."!", Color(155,255,155,255), true)

    ply[statname] = setqty

	tea_RecalcPlayerSpeed(ply)
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_setstat", GM.DevCmds.SetStat)

function GM.DevCmds.PauseStats(ply, cmd)
    if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if !ply.StatsPaused then
        ply.StatsPaused = true
    else
        ply.StatsPaused = false
    end
end
concommand.Add("tea_dev_pausestats", GM.DevCmds.PauseStats)

function GM.DevCmds.ForceEquipArmor(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local name = args[1]
	local item = GAMEMODE.ItemsList[name]

	if !item then
		UseFunc_RemoveArmor(ply)
		SystemMessage(ply, "You removed equipped armor for yourself!", Color(155,255,155,255), true)
	else
		ForceEquipArmor(ply, name)
		SystemMessage(ply, "You equipped armor '"..translate.ClientGet(ply, name.."_n").."' for yourself!", Color(155,255,155,255), true)
	end
end
concommand.Add("tea_dev_forceequiparmor", GM.DevCmds.ForceEquipArmor)

function GM.DevCmds.PlayerForceGainLevel(ply)
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local CurrentXP = ply.XP
	local RequiredXP = GetReqXP(ply)
	ply.IsLevelingAllowed = true
	ply.XP = tonumber((RequiredXP + 1) or 2^1024)
	tea_GainLevel(ply)
	ply.IsLevelingAllowed = false
	ply.XP = CurrentXP - RequiredXP
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_forcelevel", GM.DevCmds.PlayerForceGainLevel)

function GM.DevCmds.PlayerForceGainLevelNoXP(ply)
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local CurrentXP = ply.XP
	local RequiredXP = GetReqXP(ply)
	ply.IsLevelingAllowed = true
	ply.XP = tonumber((RequiredXP + 1) or 2^1024)
	tea_GainLevel(ply)
	ply.IsLevelingAllowed = false
	ply.XP = CurrentXP
	tea_FullyUpdatePlayer(ply)
end
concommand.Add("tea_dev_forcelevel_noxp", GM.DevCmds.PlayerForceGainLevelNoXP, nil, "Same as tea_dev_forcelevel, but actually won't decrease their XP from user")

function GM.DevCmds.ForceSavePlayer(ply)
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply.AllowSave = true
	tea_SavePlayer(ply)
	tea_SavePlayerInventory(ply)
	tea_SavePlayerVault(ply)
	ply.AllowSave = false
end
concommand.Add("tea_dev_forcesaveplayer", GM.DevCmds.ForceSavePlayer, nil, "Forces a save function upon player, even with tea_server_dbsaving convar disabled")


/*
Cash
Level
Prestige
XP
Bounty
StatPoints
Stamina
Hunger
Thirst
Fatigue
Infection
*/
