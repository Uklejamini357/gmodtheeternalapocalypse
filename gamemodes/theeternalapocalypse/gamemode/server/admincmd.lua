--Admin commands
--Feel free to edit this unless you don't know how to do so

-- in future i add adding admin commands like this:
GM.AdminCmdCmds = GM.AdminCmdCmds or {}

function GM:RegisterAdminCmd(name, callback)
	self.AdminCmdCmds[name] = callback
end

GM:RegisterAdminCmd("GiveItem", function(pl, target, args, str)

end)




function GM:AdminCmds_GiveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local name = args[1]
	local addqty = math.Clamp(math.floor(tonumber(args[2] or 1)), 1, 200)
	local item = self.ItemsList[name]
	if !name or name == "" then
		ply:SystemMessage("Specify an item ID! (example: item_pistolammo)", Color(255,230,230,255), true)
		ply:SystemMessage("Instructions: tea_sadmin_giveitem [item id] [amount of items]", Color(255,230,230))
	return false end

	if !item or (!TEADevCheck(ply) and item.IsSecret) then
		ply:SystemMessage(translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
		ply:ConCommand("playgamesound buttons/button8.wav")
	return false end

	-- if (ply:CalculateWeight() + (item.Weight * addqty)) > (ply:CalculateMaxWeight()) then ply:SendChat("You don't have any inventory space left for this item! (Need "..-ply:CalculateMaxWeight() + ply:CalculateWeight() + (addqty * item["Weight"]).."kg more space)") return false end

	gamemode.Call("SystemGiveItem", ply, name, addqty)

	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..GAMEMODE:GetItemName(name))
	ply:SystemMessage("You gave yourself "..addqty.."x "..GAMEMODE:GetItemName(name, ply), Color(155,255,155,255), true)
	self:FullyUpdatePlayer(ply)
end
concommand.Add("tea_sadmin_giveitem", function(ply, cmd, args)
	gamemode.Call("AdminCmds_GiveItem", ply, cmd, args)
end)

function GM:AdminCmds_RemoveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local name = args[1]
	local strip = tonumber(args[2] or 0)
	local item = self.ItemsList[name]
	if !item then ply:SystemMessage(translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
	ply:ConCommand("playgamesound buttons/button8.wav") return false end


	gamemode.Call("SystemRemoveItem", ply, name, strip)
	
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave "..GAMEMODE:GetItemName(name).." from their inventory!")
	ply:SystemMessage("You removed "..GAMEMODE:GetItemName(name, ply).." from your inventory!", Color(155,255,155,255), true)
	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_sadmin_removeitem", function(ply, cmd, args)
	gamemode.Call("AdminCmds_RemoveItem", ply, cmd, args)
end)

function GM:AdminCmds_GiveCash(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local addqty = math.Clamp(tonumber(args[1] or 1), -1e30, 1e30)
	ply.Money = ply.Money + addqty
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..self.Config["Currency"].."s!")
	ply:SystemMessage("You gave yourself "..addqty.." "..self.Config["Currency"].."s!", Color(155,255,155,255), true)

	gamemode.Call("FullyUpdatePlayer", ply)
end
concommand.Add("tea_sadmin_givecash", function(ply, cmd, args)
	gamemode.Call("AdminCmds_GiveCash", ply, cmd, args)
end)

--This command only cleans up all props, and not the faction structures.
function GM:AdminCmds_ClearProps(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	for k, v in pairs(ents.FindByClass("prop_flimsy")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("prop_strong")) do
		v:Remove()
	end

	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")

	ply:SystemMessage("Cleaned up all props!", Color(155,255,155,255), true)
end
concommand.Add("tea_sadmin_clearprops", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ClearProps", ply, cmd, args)
end)

function GM:AdminCmds_ClearZeds(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local c = 0
	if args[1] == "force" then
		-- force remove all nextbots and npcs
		for k, v in pairs(ents.GetAll()) do
			if v.Type == "nextbot" or (v:IsNPC() and v:GetClass() != "tea_trader" and v:GetClass() != "tea_taskdealer") then v.LastAttacker = nil c = c + 1 v:Remove() end
		end
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots! ("..c.." entities removed)")
		ply:SystemMessage("Cleaned up all nextbots and NPCs! ("..c.." entities removed)", Color(180,255,180,255), true)
	else
		for k, v in pairs(self.Config["ZombieClasses"]) do
			for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil c = c + 1 ent:Remove() end
		end
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies! ("..c.." zombies removed)")
		ply:SystemMessage("Cleaned up all zombies! ("..c.." zombies removed)", Color(180,255,180,255), true)
	end
end
concommand.Add("tea_admin_clearzombies", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ClearZeds", ply, cmd, args)
end)

function GM:AdminCmds_ClearLoots(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if args[1] == "force" then
		if !SuperAdminCheck(ply) then
			ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
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
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all loot caches!")
		ply:SystemMessage("Cleaned up all loot caches!", Color(155,255,155,255), true)
	else
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up loot caches!")
		ply:SystemMessage("Cleaned up loot caches!", Color(155,255,155,255), true)
	end
	for k, v in pairs(ents.FindByClass("loot_cache")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("loot_cache_weapon")) do
		v:Remove()
	end

end
concommand.Add("tea_admin_clearloots", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ClearLoots", ply, cmd, args)
end)


function GM:AdminCmds_SystemBroadcast(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local message = args[1]
	local cr = args[2] or 255
	local cg = args[3] or 255
	local cb = args[4] or 255

	if !message or message == "" then
		ply:SystemMessage("Usage: tea_sadmin_systembroadcast (message) (red color value) (green color value) (blue color value)", Color(255,255,255,255), true)
	return end

	self:SystemBroadcast(tostring(message), Color(cr,cg,cb,255), true)
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")
end
concommand.Add("tea_sadmin_systembroadcast", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SystemBroadcast", ply, cmd, args)
end)

function GM:AdminCmds_SpawnBoss(ply)
	if !AdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	gamemode.Call("SpawnBoss")
	ply:SystemMessage("Command received, boss will spawn soon.", Color(155,255,155,255), true)
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
end
concommand.Add("tea_admin_spawnboss", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SpawnBoss", ply, cmd, args)
end)

function GM:AdminCmds_SpawnAirdrop(ply)
	if !AdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "admincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	gamemode.Call("SpawnAirdrop")
	ply:SystemMessage("Command received, airdrop will arrive soon.", Color(155,255,155,255), true)
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
end
concommand.Add("tea_admin_spawnairdrop", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SpawnAirdrop", ply, cmd, args)
end)

function GM:AdminCmds_RefreshEverything(ply)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	self:LoadAD()
	self:LoadLoot()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	self:LoadTaskDealers()
	timer.Simple(1, function() self:SpawnTraders() end)
	ply:SystemMessage("Refreshed all spawns and traders.", Color(155,255,155,255), true)
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has refreshed all spawns and traders!")
end
concommand.Add("tea_sadmin_refresheverything", function(ply, cmd, args)
	gamemode.Call("AdminCmds_RefreshEverything", ply, cmd, args)
end)

function GM:AdminCmds_SpawnItem(ply, cmd, args) 
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local name = args[1]
	local item = self.ItemsList[name]
	if !name or name == "" then 
		ply:SystemMessage("Specify an item ID! (example: item_pistolammo)", Color(255,230,230,255), true)
		ply:SystemMessage("Instructions: tea_sadmin_spawnitem [item id] [amount of items]", Color(255,230,230))
	return false end
	if !item then ply:SystemMessage(translate.ClientGet(ply, "itemnonexistant"), Color(255,205,205,255), true) 
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
	--if item category is 4 (armor category), it will detect that it is an armor, as long as it doesn't have flaws it should work fine
	EntDrop:SetModel(item.Category == ITEMCATEGORY_ARMOR and "models/props/cs_office/cardboard_box01.mdl" or self.ItemsList[name]["Model"])
	EntDrop:SetNWString("ItemClass", name)
	EntDrop:Spawn()
	EntDrop:Activate()
	EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))

	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..GAMEMODE:GetItemName(name))
	ply:SystemMessage("You spawned a dropped item: "..GAMEMODE:GetItemName(name, ply).."!", Color(155,255,155,255), true)
end
concommand.Add("tea_sadmin_spawnitem", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SpawnItem", ply, cmd, args)
end)

function GM:AdminCmds_SpawnMoney(ply, cmd, args) 
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local cash = math.Clamp(tonumber(args[1]) or 0, 1, 1000000)
	if tonumber(cash) <= 0 then
		ply:SendChat("Usage: tea_sadmin_spawnmoney (amount) - Spawn a desired amount of money in front of you [Amount can't be negative]")
		return
	end
	
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	if cash then
		local ent = ents.Create("ate_cash")
		ent:SetPos(tr.HitPos)
		ent:SetAngles(Angle(0, 0, 0))
		ent:SetModel("models/props/cs_office/cardboard_box01.mdl")	
		ent:SetNWInt("CashAmount", math.floor(cash))
		ent:Spawn()
		ent:Activate()
	end
				
	self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..self.Config["Currency"].."s!")
	ply:SystemMessage("You spawned dropped cash with "..cash.." "..self.Config["Currency"].."s!", Color(155,255,155,255), true)
	
end
concommand.Add("tea_sadmin_spawnmoney", function(ply, cmd, args)
	gamemode.call("AdminCmds_SpawnMoney", ply, cmd, args)
end)

function GM:AdminCmds_NoTarget(ply, cmd) --useful for events (but not for abusing)
    if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if !ply.TEANoTarget then
        ply.TEANoTarget = true
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has enabled notarget for themselves!")
		ply:SystemMessage("Enabled notarget!", Color(155,255,155,255), true)
    else
        ply.TEANoTarget = false
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has disabled notarget for themselves!")
		ply:SystemMessage("Disabled notarget!", Color(155,255,155,255), true)
    end
end
concommand.Add("tea_sadmin_notarget", function(ply, cmd, args)
	gamemode.Call("AdminCmds_NoTarget", ply, cmd, args)
end)

function GM:AdminCmds_ToggleZSpawns(ply, cmd) --useful for events (but not for abusing)
    if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if not GetGlobalBool("GM.ZombieSpawning") then
        SetGlobalBool("GM.ZombieSpawning", true)
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has enabled zombie spawning!")
		ply:SendChat("Zombie spawns enabled")
    else
        SetGlobalBool("GM.ZombieSpawning", false)
		self:DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has disabled zombie spawning!")
		ply:SendChat("Zombie spawns disabled")
    end
end
concommand.Add("tea_sadmin_togglezspawning", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ToggleZSpawns", ply, cmd, args)
end, nil, "Toggles option, whether zombies should spawn or not")

function GM:AdminCmds_SetConVarValue(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !TEADevCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local convar = args[1]
	local value = args[2]

	if !convar or convar == "" then ply:SystemMessage("Usage: tea_sadmin_setconvarvalue {convar} [value]\nNOTE: Cannot set convar value NOT created by lua.", Color(255,255,255), false) return end
	if !GetConVar(convar) then ply:SystemMessage("Did you just tried to set value on invalid convar?", Color(255,0,0), false) return end
	if !value then ply:SystemMessage("What about convar value?!?!?", Color(255,0,0), false) return end

	GetConVar(convar):SetString(value)
	ply:SystemMessage("You set convar "..convar.." value to '"..GetConVar(convar):GetString().."'!", Color(155,255,155,255), true)
end
concommand.Add("tea_sadmin_setconvarvalue", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SetConVarValue", ply, cmd, args)
end, nil, "Sets a ConVar value created by lua. Creates error when trying to set a ConVar value NOT created by lua and created by source engine, though. Use it carefully.")

function GM:AdminCmds_SendGMSpawns(ply)
	if !SuperAdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	self:SendAllSpawnsToPlayer(ply)
end
concommand.Add("tea_sadmin_sendgmspawns", function(ply, cmd, args)
	gamemode.Call("AdminCmds_SendGMSpawns", ply, cmd, args)
end, nil, "Sends zombie spawns and such to client")

function GM:AdminCmds_ClearGMSpawns(ply)
	if !SuperAdminCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply:SendLua("GAMEMODE.Spawns = {}")
end
concommand.Add("tea_sadmin_cleargmspawns", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ClearGMSpawns", ply, cmd, args)
end, nil, "Clears Zombie spawns and such for client")
