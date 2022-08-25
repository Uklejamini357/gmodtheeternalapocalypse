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