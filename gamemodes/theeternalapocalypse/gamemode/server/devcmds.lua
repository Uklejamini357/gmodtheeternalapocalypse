--Dev commands
--Do not change, unless there are bugs or if adding more

function GM:DevCmds_SpawnLoot(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    local ent = ents.Create("loot_cache")
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, 0, 0))
    ent.LootType = table.Random(GAMEMODE.LootTable1)["Class"]
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
end
concommand.Add("tea_dev_spawnloot", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnLoot", ply, cmd, args)
end, nil, "Spawns a loot cache in front of you")

function GM:DevCmds_SpawnLootWeapon(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    local ent = ents.Create("loot_cache_weapon")
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, 0, 0))
    ent.LootType = table.Random(GAMEMODE.LootTable2)["Class"]
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootweapon", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnLootWeapon", ply, cmd, args)
end, nil, "Spawns a weapon loot cache in front of you")

function GM:DevCmds_SpawnLootRare(ply)
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    local ent = ents.Create("loot_cache_special")
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, 0, 0))
    ent.LootType = table.Random(self.LootTable3)["Class"]
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootrare", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnLootRare", ply, cmd, args)
end, nil, "Spawns a rare cache in front of you")


function GM:DevCmds_SpawnLootFaction(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    local ent = ents.Create("loot_cache_faction")
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, 0, 0))
    ent.LootType = table.Random(GAMEMODE.LootTableFaction)["Class"]
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootfaction", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnLootFaction", ply, cmd, args)
end, nil, "Spawns a faction loot cache in front of you")

function GM:DevCmds_SpawnLootBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
    local ent = ents.Create("loot_cache_boss")
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, 0, 0))
    ent.LootType = table.Random(GAMEMODE.LootTableBoss)["Class"]
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
    
end
concommand.Add("tea_dev_spawnlootboss", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnLootBoss", ply, cmd, args)
end, nil, "Spawns a boss cache in front of you")

function GM:DevCmds_SpawnAirdropCache(ply, cmd, args)
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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

		local loot = gamemode.Call("RollLootTable", self:GetRandomAirdropLoot())
		gamemode.Call("MakeLootContainer", dropent, loot)

		dropent:Spawn()
		dropent:Activate()

	end
end
concommand.Add("tea_dev_spawnairdropcache", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnAirdropCache", ply, cmd, args)
end, nil, "Spawns an airdrop cache in front of you")

function GM:DevCmds_SpawnBoss(ply) 
    if !ply:IsValid() then return false end
    
    if !TEADevCheck(ply) then 
        ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
        ply:ConCommand("playgamesound buttons/button8.wav")
        return
    end
    
    local vStart = ply:GetShootPos()
    local vForward = ply:GetAimVector()
    local trace = {}
    trace.start = vStart
    trace.endpos = vStart + (vForward * 500)
    trace.filter = ply
    local tr = util.TraceLine(trace)
	local dice = math.random(0, 100)
	local total = 0
	for k, v in pairs(GAMEMODE.Config["BossClasses"]) do
		total = total + v["SpawnChance"]
		if total >= dice then
			gamemode.Call("CreateZombie", k, tr.HitPos, Angle(0,0,0), v.XPReward, v.MoneyReward, v.InfectionRate, true)
			break
		end
	end
end
concommand.Add("tea_dev_spawnboss", function(ply, cmd, args)
	gamemode.Call("DevCmds_SpawnBoss", ply, cmd, args)
end, nil, "Spawns a random boss in your direction")

function GM:DevCmds_RefillStats(ply, cmd)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
    
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_refillstats", function(ply, cmd, args)
	gamemode.Call("DevCmds_RefillStats", ply, cmd, args)
end, nil, "Refills your Stamina, Hungeer, Thirst, Fatigue and Infection.")

function GM:DevCmds_GivePerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1]
	local addqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Perk Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(self.StatsListServer) do ply:PrintMessage(2, v) end
	return end
	if !addqty then return end
	local stat = "Stat"..statname
	if statname == "Points" then --when they manage to increase their skill points with this command while it's supposed to increase their skill level
		ply:SystemMessage("You can't increase your Skill Points with this command! Use tea_dev_giveskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = ply[stat] + addqty
	ply:SystemMessage("You increased your "..statname.." Skill for "..addqty.." point(s)!", Color(155,255,155,255), true)

	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	gamemode.Call("RecalcPlayerSpeed", ply)
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_giveperk", function(ply, cmd, args)
	gamemode.Call("DevCmds_GivePerk", ply, cmd, args)
end)

function GM:DevCmds_GiveStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
		ply:SystemMessage("You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
*/

	ply:SystemMessage("You gave yourself "..statname.." values for "..addqty.."!", Color(155,255,155,255), true)

    ply[statname] = ply[statname] + addqty

	gamemode.Call("RecalcPlayerSpeed", ply)
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_givestat", function(ply, cmd, args)
	gamemode.Call("DevCmds_GiveStat", ply, cmd, args)
end)

function GM:DevCmds_SetPerk(ply, cmd, args)
	if !ply:IsValid() then return false end

	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
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
		ply:SystemMessage("You can't set your Skill Points with this command! Use tea_dev_setskillpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = setqty
	ply:SystemMessage("You set your "..statname.." Skill value to "..setqty.."!", Color(155,255,155,255), true)

	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	gamemode.Call("RecalcPlayerSpeed", ply)
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_setperk", function(ply, cmd, args)
	gamemode.Call("DevCmds_SetPerk", ply, cmd, args)
end)


function GM:DevCmds_SetStat(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local statname = args[1] 
	local setqty = tonumber(args[2])
	if !statname then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only (periodic) stats!\n \nList:")
		for k,v in ipairs(self.StatsListServer2) do ply:PrintMessage(2, v) end
	return end
	if !setqty then return end
/*	if string.lower(statname) == "StatAgility" then
		ply:SystemMessage("You can't set your Perk Values with this command! Use tea_dev_setperk instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end*/

	ply:SystemMessage("You set your "..statname.." value to "..setqty.."!", Color(155,255,155,255), true)

    ply[statname] = setqty

	gamemode.Call("RecalcPlayerSpeed", ply)
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_setstat", function(ply, cmd, args)
	gamemode.Call("DevCmds_SetStat", ply, cmd, args)
end)

function GM:DevCmds_PauseStats(ply, cmd)
    if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if ply.StatsPaused then
		ply.SurvivalTime = CurTime() - ply.StatsPaused_LastSurvivalTime
		ply.StatsPaused_LastSurvivalTime = nil
	else
		ply.StatsPaused_LastSurvivalTime = CurTime() - ply.SurvivalTime
    end
	ply.StatsPaused = !ply.StatsPaused
end
concommand.Add("tea_dev_pausestats", function(ply, cmd)
	gamemode.Call("DevCmds_PauseStats", ply, cmd, args)
end)

function GM:DevCmds_ForceEquipArmor(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local name = args[1]
	local item = GAMEMODE.ItemsList[name]

	if !item then
		UseFunc_RemoveArmor(ply)
		ply:SystemMessage("You removed equipped armor for yourself!", Color(155,255,155,255), true)
	else
		ForceEquipArmor(ply, name)
		ply:SystemMessage("You equipped armor '"..GAMEMODE:GetItemName(name, ply).."' for yourself!", Color(155,255,155,255), true)
	end
end
concommand.Add("tea_dev_forceequiparmor", function(ply, cmd, args)
	gamemode.Call("DevCmds_ForceEquipArmor", ply, cmd, args)
end)

function GM:DevCmds_PlayerForceGainLevel(ply)
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local CurrentXP = ply.XP
	local RequiredXP = ply:GetReqXP()
	ply.XP = tonumber((RequiredXP + 1) or 2^1024)
	gamemode.Call("GainLevel", ply)
	ply.XP = CurrentXP - RequiredXP
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_forcelevel", function(ply, cmd, args)
	gamemode.Call("DevCmds_PlayerForceGainLevel", ply, cmd, args)
end)

function GM:DevCmds_PlayerForceGainLevelNoXP(ply)
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local CurrentXP = ply.XP
	local RequiredXP = ply:GetReqXP()
	ply.XP = tonumber((RequiredXP + 1) or 2^1024)
	gamemode.Call("GainLevel", ply)
	ply.XP = CurrentXP
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_dev_forcelevel_noxp", function(ply, cmd, args)
	gamemode.Call("DevCmds_PlayerForceGainLevelNoXP", ply, cmd, args)
end, nil, "Same as tea_dev_forcelevel, but actually won't decrease their XP from user")

function GM:DevCmds_ForceSavePlayer(ply)
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply.AllowSave = true
	gamemode.Call("SavePlayer", ply)
	gamemode.Call("SavePlayerInventory", ply)
	gamemode.Call("SavePlayerVault", ply)
	gamemode.Call("SavePlayerPerks", ply)
	ply.AllowSave = false
end
concommand.Add("tea_dev_forcesaveplayer", function(ply, cmd, args)
	gamemode.Call("DevCmds_ForceSavePlayer", ply, cmd, args)
end, nil, "Forces a save function upon player, even with tea_server_dbsaving convar disabled")


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
