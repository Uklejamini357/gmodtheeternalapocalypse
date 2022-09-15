--Admin commands
--Feel free to edit this unless you don't know how to do so

function AdminGiveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	local name = args[1]
	local addqty = math.floor(args[2] or 1)
	local item = ItemsList[name]
	if !item then
		SystemMessage(ply, translate.ClientGet(ply, "ItemNonExistant"), Color(255,205,205,255), true) 
		ply:ConCommand("playgamesound buttons/button8.wav")
	return false end
	if addqty < 1 then SendChat(ply, "You can't give negative values with tea_sadmin_giveitem! Use tea_sadmin_removeitem instead.") return false end
	if addqty > 1000 then SendChat(ply, "You can't give yourself that many items!") return false end

	if (CalculateWeight(ply) + (item.Weight * addqty)) > (CalculateMaxWeight(ply)) then SendChat(ply, "You are lacking inventory space! Drop some items first.") return false end

	SystemGiveItem(ply, name, addqty)

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..translate.Get(item["Name"]))
	print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..translate.Get(item["Name"]))
	SystemMessage(ply, "You gave yourself "..addqty.."x "..translate.ClientGet(ply, item["Name"]), Color(155,255,155,255), true)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_giveitem", AdminGiveItem)

function AdminRemoveItem(ply, cmd, args)
	if !ply:IsValid() then return false end
	
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	local name = args[1]
	local strip = args[2] or true
	local item = ItemsList[name]
	if !item then SystemMessage(ply, translate.ClientGet(ply, "ItemNonExistant"), Color(255,205,205,255), true) 
	ply:ConCommand("playgamesound buttons/button8.wav") return false end
	
	
	SystemRemoveItem(ply, name, strip)
	
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave "..translate.Get(item["Name"]).." from their inventory!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." removed "..translate.Get(item["Name"]).." from their inventory!")
	SystemMessage(ply, "You removed "..translate.ClientGet(ply, item["Name"]).." from your inventory!", Color(155,255,155,255), true)
	FullyUpdatePlayer(ply)
	ply:ConCommand("playgamesound buttons/button3.wav")
	end
	concommand.Add("tea_sadmin_removeitem", AdminRemoveItem)

function AdminGiveCash(ply, cmd, args)
if !ply:IsValid() then return false end

if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

local addqty = args[1] or 1

ply.Money = ply.Money + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..Config["Currency"].."s!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..Config["Currency"].."s!")
SystemMessage(ply, "You gave yourself "..addqty.." "..Config["Currency"].."s!", Color(155,255,155,255), true)

FullyUpdatePlayer(ply)
ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_givecash", AdminGiveCash)

--This command only cleans up all props, and not the faction structures.
function TEAAdminClearProps(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	for k, v in pairs(ents.FindByClass("prop_flimsy")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("prop_strong")) do
		v:Remove()
	end

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")
	SystemMessage(ply, "Cleaned up all props!", Color(155,255,155,255), true)
	ply:ConCommand("playgamesound buttons/button3.wav") 
end
concommand.Add("tea_sadmin_clearprops", TEAAdminClearProps)

function TEAAdminClearZeds(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEAAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	if args[1] == "force" then
		-- force remove all nextbots and npcs
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
		SystemMessage(ply, "Cleaned up all nextbots and NPCs!", Color(155,255,155,255), true)
		ply:ConCommand("playgamesound buttons/button15.wav")
		for k, v in pairs(ents.GetAll()) do
			if v.Type == "nextbot" or (v:IsNPC() and v:GetClass() != "trader") then v.LastAttacker = nil v:Remove() end
		end
	else
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
		SystemMessage(ply, "Cleaned up all zombies!", Color(155,255,155,255), true)
		ply:ConCommand("playgamesound buttons/button15.wav")
		for k, v in pairs(Config["ZombieClasses"]) do
			for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil ent:Remove() end
		end
	end
end
concommand.Add("tea_admin_clearzombies", TEAAdminClearZeds)

function TEAAdminClearLoots(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	
	if args[1] == "force" then
		if !SuperAdminCheck(ply) then
			SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
			ply:ConCommand("playgamesound buttons/button8.wav")
			return
		end
			for k, v in pairs(ents.FindByClass("loot_cache_boss")) do
			v:Remove()
		end
		for k, v in pairs(ents.FindByClass("loot_cache_faction")) do
			v:Remove()
		end
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all loot caches!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all loot caches!")
		SystemMessage(ply, "Cleaned up all loot caches!", Color(155,255,155,255), true)
	else
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up normal loot caches!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up normal loot caches!")
		SystemMessage(ply, "Cleaned up normal loot caches!", Color(155,255,155,255), true)
	end
	for k, v in pairs(ents.FindByClass("loot_cache")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("loot_cache_weapon")) do
		v:Remove()
	end
	
	
	ply:ConCommand("playgamesound buttons/button15.wav") 	
end
concommand.Add("tea_admin_clearloots", TEAAdminClearLoots)


function PlayerForceGainLevel(ply)

if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

ply.IsLevelingAllowed = true
CurrentXP = ply.XP
RequiredXP = GetReqXP(ply)
ply.XP = 1e+999
PlayerGainLevel(ply)
ply.IsLevelingAllowed = false
ply.XP = CurrentXP - RequiredXP
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up!")
print("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up!")
FullyUpdatePlayer(ply)

end
concommand.Add("tea_dev_forcelevel", PlayerForceGainLevel)

function PlayerForceGainLevelNoXP(ply)

if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

ply.IsLevelingAllowed = true
CurrentXP = ply.XP
RequiredXP = GetReqXP(ply)
ply.XP = 1e+999
PlayerGainLevel(ply)
ply.IsLevelingAllowed = true
ply.XP = CurrentXP
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up! (without reducing XP)")
print("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up! (without reducing XP)")
FullyUpdatePlayer(ply)

end
concommand.Add("tea_dev_forcelevel_noxp", PlayerForceGainLevelNoXP)


function TEAAdminSystemBroadcast(ply, cmd, args)
if !ply:IsValid() then return false end

if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

local message = args[1]
local cr = args[2] or 255
local cg = args[3] or 255
local cb = args[4] or 255

if message == nil then
SystemMessage(ply, "Usage: tea_sadmin_systembroadcast (message) (red color value) (green color value) (blue color value)", Color(255,255,255,255), true)
return end

SystemBroadcast(message, Color(cr,cg,cb,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")
print("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")

end
concommand.Add("tea_sadmin_systembroadcast", TEAAdminSystemBroadcast)

function TEAAdminSpawnBoss(ply)
if !AdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEAAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

CanSpawnBoss = true
SpawnBoss()
CanSpawnBoss = false
ply:ConCommand("playgamesound buttons/button3.wav")
SystemMessage(ply, "Command received, boss will spawn soon.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
end
concommand.Add("tea_admin_spawnboss", TEAAdminSpawnBoss)

function TEAAdminSpawnAirdrop(ply)
if !AdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEAAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

CanSpawnAirdrop = true
SpawnAirdrop()
CanSpawnAirdrop = false
ply:ConCommand("playgamesound buttons/button3.wav")
SystemMessage(ply, "Command received, airdrop will arrive soon.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
end
concommand.Add("tea_admin_spawnairdrop", TEAAdminSpawnAirdrop)

function TEAForceSavePlayer(ply)
if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

AllowSave = 1
SavePlayer(ply)
SavePlayerInventory(ply)
SavePlayerVault(ply)
AllowSave = 0
ply:ConCommand("playgamesound buttons/button3.wav")
SystemMessage(ply, "Saved.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has saved their data!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has saved their data!")
end
concommand.Add("tea_dev_forcesaveplayer", TEAForceSavePlayer)

function TEARefreshEverything(ply)
if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

LoadAD()
LoadLoot()
LoadZombies()
LoadTraders()
LoadPlayerSpawns()
timer.Simple(1, function() SpawnTraders() end)
SystemMessage(ply, "Refreshed all spawns and traders.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has refreshed all spawns and traders!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has refreshed all spawns and traders!")
end
concommand.Add("tea_sadmin_refresheverything", TEARefreshEverything)

function TEASpawnItem(ply, cmd, args) 
if !ply:IsValid() then return false end

if !SuperAdminCheck(ply) then 
	SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

local name = args[1]
local item = ItemsList[name]
if item == nil then SendChat(ply, "Usage: tea_sadmin_spawnitem [Item ID] (Spawn a dropped item in front of you)") return false end
if !item then SystemMessage(ply, translate.ClientGet(ply, "ItemNonExistant"), Color(255,205,205,255), true) 
ply:ConCommand("playgamesound buttons/button8.wav") return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine(trace)
if item.Category == 4 then --it will remain as category 4 so it will detect if it is armor, as long as it doesn't have flaws
local EntDrop = ents.Create("ate_droppeditem")
			EntDrop:SetPos(tr.HitPos)
			EntDrop:SetAngles(Angle(0, 0, 0))
			EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")
			EntDrop:SetNWString("ItemClass", name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
else
	local EntDrop = ents.Create("ate_droppeditem")
			EntDrop:SetPos(tr.HitPos)
			EntDrop:SetAngles(Angle(0, 0, 0))
			EntDrop:SetModel(ItemsList[name]["Model"])
			EntDrop:SetNWString("ItemClass", name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
end

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..translate.Get(item["Name"]))
print("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..translate.Get(item["Name"]))
SystemMessage(ply, "You spawned a dropped item: "..translate.ClientGet(ply, item["Name"]).."!", Color(155,255,155,255), true)

ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_spawnitem", TEASpawnItem)

function TEASpawnMoney(ply, cmd, args) 
	if !ply:IsValid() then return false end
	
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
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
				
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..Config["Currency"].."s!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..Config["Currency"].."s!")
	SystemMessage(ply, "You spawned dropped cash with "..cash.." "..Config["Currency"].."s!", Color(155,255,155,255), true)
	
	ply:ConCommand("playgamesound buttons/button3.wav")
end
concommand.Add("tea_sadmin_spawnmoney", TEASpawnMoney)

function TEASAdminNoTarget(ply, cmd) --useful for events (but not for abusing)
    if !ply:IsValid() then return false end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
    
    if ply.HasNoTarget != true then
        ply.HasNoTarget = true
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has enabled notarget for themselves!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has enabled notarget for themselves!")
		SystemMessage(ply, "Enabled notarget!", Color(155,255,155,255), true)
    else
        ply.HasNoTarget = false
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has disabled notarget for themselves!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has disabled notarget for themselves!")
		SystemMessage(ply, "Disabled notarget!", Color(155,255,155,255), true)
    end
end
concommand.Add("tea_sadmin_notarget", TEASAdminNoTarget)
