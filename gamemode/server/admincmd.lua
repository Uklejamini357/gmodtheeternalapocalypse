--Admin commands
--Feel free to edit this unless you don't know how to do so
GM.AdminCmds = {}

function GM.AdminCmds.GiveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local name = args[1]
	local addqty = math.Clamp(math.floor(tonumber(args[2] or 1)), 1, 200)
	local item = GAMEMODE.ItemsList[name]
	if !name or name == "" then
		SystemMessage(ply, "Specify an item ID! (example: item_pistolammo)", Color(255,230,230,255), true)
		SystemMessage(ply, "Instructions: tea_sadmin_giveitem [item id] [amount of items]", Color(255,230,230))
	return false end

	if !item or (!TEADevCheck(ply) and item.IsSecret) then
		SystemMessage(ply, translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
		ply:ConCommand("playgamesound buttons/button8.wav")
	return false end

	if (tea_CalculateWeight(ply) + (item.Weight * addqty)) > (tea_CalculateMaxWeight(ply)) then SendChat(ply, "You are lacking inventory space! Drop some items first.") return false end

	tea_SystemGiveItem(ply, name, addqty)

	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..translate.Get(name.."_n"))
	SystemMessage(ply, "You gave yourself "..addqty.."x "..translate.ClientGet(ply, name.."_n"), Color(155,255,155,255), true)
	tea_FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_giveitem", GM.AdminCmds.GiveItem)

function GM.AdminCmds.RemoveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local name = args[1]
	local strip = tonumber(args[2] or 0)
	local item = GAMEMODE.ItemsList[name]
	if !item then SystemMessage(ply, translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
	ply:ConCommand("playgamesound buttons/button8.wav") return false end


	tea_SystemRemoveItem(ply, name, strip)
	
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave "..translate.Get(name.."_n").." from their inventory!")
	SystemMessage(ply, "You removed "..translate.ClientGet(ply, name.."_n").." from your inventory!", Color(155,255,155,255), true)
	tea_FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_removeitem", GM.AdminCmds.RemoveItem)

function GM.AdminCmds.GiveCash(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local addqty = math.Clamp(tonumber(args[1] or 1), -1000000, 1000000)
	ply.Money = ply.Money + addqty
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..GAMEMODE.Config["Currency"].."s!")
	SystemMessage(ply, "You gave yourself "..addqty.." "..GAMEMODE.Config["Currency"].."s!", Color(155,255,155,255), true)

	tea_FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_givecash", GM.AdminCmds.GiveCash)

--This command only cleans up all props, and not the faction structures.
function GM.AdminCmds.ClearProps(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	for k, v in pairs(ents.FindByClass("prop_flimsy")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("prop_strong")) do
		v:Remove()
	end

	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")

	SystemMessage(ply, "Cleaned up all props!", Color(155,255,155,255), true)
	ply:ConCommand("playgamesound buttons/button3.wav") 
end
concommand.Add("tea_sadmin_clearprops", GM.AdminCmds.ClearProps)

function GM.AdminCmds.ClearZeds(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local c = 0
	if args[1] == "force" then
		-- force remove all nextbots and npcs
		for k, v in pairs(ents.GetAll()) do
			if v.Type == "nextbot" or (v:IsNPC() and v:GetClass() != "trader") then v.LastAttacker = nil c = c + 1 v:Remove() end
		end
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots! ("..c.." entities removed)")
		SystemMessage(ply, "Cleaned up all nextbots and NPCs! ("..c.." entities removed)", Color(180,255,180,255), true)
		ply:ConCommand("playgamesound buttons/button15.wav")
	else
		for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
			for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil c = c + 1 ent:Remove() end
		end
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies! ("..c.." zombies removed)")
		SystemMessage(ply, "Cleaned up all zombies! ("..c.." zombies removed)", Color(180,255,180,255), true)
		ply:ConCommand("playgamesound buttons/button15.wav")
	end
end
concommand.Add("tea_admin_clearzombies", GM.AdminCmds.ClearZeds)

function GM.AdminCmds.ClearLoots(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if args[1] == "force" then
		if !SuperAdminCheck(ply) then
			SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
			ply:ConCommand("playgamesound buttons/button8.wav")
			return
		end
		for k, v in pairs(ents.FindByClass("loot_cache_boss")) do
			v:Remove()
		end
		for k, v in pairs(ents.FindByClass("loot_cache_faction")) do
			v:Remove()
		end
		for k, v in pairs(ents.FindByClass("loot_cache_special")) do
			v:Remove()
		end
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all loot caches!")
		SystemMessage(ply, "Cleaned up all loot caches!", Color(155,255,155,255), true)
	else
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up loot caches!")
		SystemMessage(ply, "Cleaned up loot caches!", Color(155,255,155,255), true)
	end
	for k, v in pairs(ents.FindByClass("loot_cache")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("loot_cache_weapon")) do
		v:Remove()
	end

	ply:ConCommand("playgamesound buttons/button15.wav") 	
end
concommand.Add("tea_admin_clearloots", GM.AdminCmds.ClearLoots)


function GM.AdminCmds.SystemBroadcast(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local message = args[1]
	local cr = args[2] or 255
	local cg = args[3] or 255
	local cb = args[4] or 255

	if !message or message == "" then
		SystemMessage(ply, "Usage: tea_sadmin_systembroadcast (message) (red color value) (green color value) (blue color value)", Color(255,255,255,255), true)
	return end

	tea_SystemBroadcast(tostring(message), Color(cr,cg,cb,255), true)
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")
end
concommand.Add("tea_sadmin_systembroadcast", GM.AdminCmds.SystemBroadcast)

function GM.AdminCmds.SpawnBoss(ply)
	if !AdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	GAMEMODE.CanSpawnBoss = true
	SpawnBoss()
	GAMEMODE.CanSpawnBoss = false
	ply:ConCommand("playgamesound buttons/button3.wav")
	SystemMessage(ply, "Command received, boss will spawn soon.", Color(155,255,155,255), true)
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
end
concommand.Add("tea_admin_spawnboss", GM.AdminCmds.SpawnBoss)

function GM.AdminCmds.SpawnAirdrop(ply)
	if !AdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	GAMEMODE.CanSpawnAirdrop = true
	GAMEMODE.SpawnAirdrop()
	GAMEMODE.CanSpawnAirdrop = false
	ply:ConCommand("playgamesound buttons/button3.wav")
	SystemMessage(ply, "Command received, airdrop will arrive soon.", Color(155,255,155,255), true)
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
end
concommand.Add("tea_admin_spawnairdrop", GM.AdminCmds.SpawnAirdrop)

function GM.AdminCmds.RefreshEverything(ply)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	GAMEMODE.LoadAD()
	GAMEMODE.LoadLoot()
	GAMEMODE.LoadZombies()
	GAMEMODE.LoadTraders()
	GAMEMODE.LoadPlayerSpawns()
	timer.Simple(1, function() GAMEMODE.SpawnTraders() end)
	SystemMessage(ply, "Refreshed all spawns and traders.", Color(155,255,155,255), true)
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has refreshed all spawns and traders!")
end
concommand.Add("tea_sadmin_refresheverything", GM.AdminCmds.RefreshEverything)

function GM.AdminCmds.SpawnItem(ply, cmd, args) 
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local name = args[1]
	local item = GAMEMODE.ItemsList[name]
	if !name or name == "" then 
		SystemMessage(ply, "Specify an item ID! (example: item_pistolammo)", Color(255,230,230,255), true)
		SystemMessage(ply, "Instructions: tea_sadmin_spawnitem [item id] [amount of items]", Color(255,230,230))
	return false end
	if !item then SystemMessage(ply, translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
	ply:ConCommand("playgamesound buttons/button8.wav") return false end

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local EntDrop = ents.Create("ate_droppeditem")
	EntDrop:SetPos(tr.HitPos)
	EntDrop:SetAngles(Angle(0, 0, 0))
	--if item category is 4 (armor category), it will detect, that it is an armor, as long as it doesn't have flaws it should work fine
	EntDrop:SetModel(item.Category == 4 and "models/props/cs_office/cardboard_box01.mdl" or GAMEMODE.ItemsList[name]["Model"])
	EntDrop:SetNWString("ItemClass", name)
	EntDrop:Spawn()
	EntDrop:Activate()
	EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))

	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..translate.Get(name.."_n"))
	SystemMessage(ply, "You spawned a dropped item: "..translate.ClientGet(ply, name.."_n").."!", Color(155,255,155,255), true)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_spawnitem", GM.AdminCmds.SpawnItem)

function GM.AdminCmds.SpawnMoney(ply, cmd, args) 
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local cash = args[1] or 0
	if cash == 0 or tonumber(cash) < 0 then SendChat(ply, "Usage: tea_sadmin_spawnmoney (amount) - Spawn a desired amount of money in front of you [Amount can't be negative]") return end
	
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	if cash != nil then
		local EntDrop = ents.Create("ate_cash")
		EntDrop:SetPos(tr.HitPos)
		EntDrop:SetAngles(Angle(0, 0, 0))
		EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")	
		EntDrop:SetNWInt("CashAmount", math.floor(cash))
		EntDrop:Spawn()
		EntDrop:Activate()
	end
				
	tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..GAMEMODE.Config["Currency"].."s!")
	SystemMessage(ply, "You spawned dropped cash with "..cash.." "..GAMEMODE.Config["Currency"].."s!", Color(155,255,155,255), true)
	
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_spawnmoney", GM.AdminCmds.SpawnMoney)

function GM.AdminCmds.NoTarget(ply, cmd) --useful for events (but not for abusing)
    if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if !ply.HasNoTarget then
        ply.HasNoTarget = true
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has enabled notarget for themselves!")
		SystemMessage(ply, "Enabled notarget!", Color(155,255,155,255), true)
    else
        ply.HasNoTarget = false
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has disabled notarget for themselves!")
		SystemMessage(ply, "Disabled notarget!", Color(155,255,155,255), true)
    end
end
concommand.Add("tea_sadmin_notarget", GM.AdminCmds.NoTarget)

function GM.AdminCmds.ToggleZSpawns(ply, cmd) --useful for events (but not for abusing)
    if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if !GAMEMODE.ZombieSpawningEnabled then
        GAMEMODE.ZombieSpawningEnabled = true
		BroadcastLua("GAMEMODE.ZombieSpawningEnabled = true")
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has enabled zombie spawning!")
		SendChat(ply, "Zombie spawns enabled")
    else
        GAMEMODE.ZombieSpawningEnabled = false
		BroadcastLua("GAMEMODE.ZombieSpawningEnabled = false")
		tea_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has disabled zombie spawning!")
		SendChat(ply, "Zombie spawns disabled")
    end
end
concommand.Add("tea_sadmin_togglezspawning", GM.AdminCmds.ToggleZSpawns, nil, "Toggles option, whether zombies should spawn or not")

function GM.AdminCmds.SetConVarValue(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local convar = args[1]
	local value = args[2]

	if !convar or convar == "" then SystemMessage(ply, "Usage: tea_sadmin_setconvarvalue {convar} [value]\nNOTE: Cannot set convar value NOT created by lua.", Color(255,255,255), false) return end
	if !GetConVar(convar) then SystemMessage(ply, "Did you just tried to set value on invalid convar?", Color(255,0,0), false) return end
	if !value then SystemMessage(ply, "What about convar value?!?!?", Color(255,0,0), false) return end

	GetConVar(convar):SetString(value)
	SystemMessage(ply, "You set convar "..convar.." value to '"..GetConVar(convar):GetString().."'!", Color(155,255,155,255), true)
end
concommand.Add("tea_sadmin_setconvarvalue", GM.AdminCmds.SetConVarValue, nil, "Sets a ConVar value created by lua. Creates error when trying to set a ConVar value NOT created by lua and created by source engine, though. Use it carefully.")
