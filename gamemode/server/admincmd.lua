function AdminGiveItem( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand("playgamesound buttons/button8.wav")
	return
end

local name = args[1] or "NULL"
local addqty = args[2] or 1
local item = ItemsList[name]
if !item then
	SystemMessage(ply, "ERROR! This item does not exist! (Attempted to give item "..name.."!)", Color(255,205,205,255), true) 
	ply:ConCommand("playgamesound buttons/button8.wav")
return false end

if (CalculateWeight(ply) + (item.Weight * addqty)) > (CalculateMaxWeight(ply)) then SendChat(ply, "You are lacking inventory space! Drop some items first.") return false end

SystemGiveItem(ply, name, addqty)

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..translate.Get(item["Name"]))
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..translate.Get(item["Name"]))
SystemMessage(ply, "You gave yourself "..addqty.."x "..translate.Get(item["Name"]), Color(155,255,155,255), true)
FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("ate_sadmin_giveitem", AdminGiveItem)

function AdminRemoveItem( ply, cmd, args )
	if !ply:IsValid() then return false end
	
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	
	local name = args[1]
	local strip = args[2] or true
	local item = ItemsList[name]
	if !item then SystemMessage(ply, "ERROR! This item does not exist!", Color(255,205,205,255), true) 
	ply:ConCommand( "playgamesound buttons/button8.wav" ) return false end
	
	
	SystemRemoveItem( ply, name, strip )
	
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave "..translate.Get(item["Name"]).." from their inventory!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." removed "..translate.Get(item["Name"]).." from their inventory!")
	SystemMessage(ply, "You removed "..translate.Get(item["Name"]).." from your inventory!", Color(155,255,155,255), true)
	FullyUpdatePlayer( ply )
	ply:ConCommand( "playgamesound buttons/button3.wav" )
	end
	concommand.Add("ate_sadmin_removeitem", AdminRemoveItem)

function AdminGiveCash( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Money = ply.Money + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..Config[ "Currency" ].."s!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." "..Config[ "Currency" ].."s!")
SystemMessage(ply, "You gave yourself "..addqty.." "..Config[ "Currency" ].."s!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("ate_sadmin_givecash", AdminGiveCash)


function AdminClearProps( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button15.wav" )
	return
end

	for k, v in pairs( ents.FindByClass( "prop_flimsy" ) ) do
		v:Remove()
	end

	for k, v in pairs( ents.FindByClass( "prop_strong" ) ) do
		v:Remove()
	end

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all props!")
	SystemMessage(ply, "Cleaned up all props!", Color(155,255,155,255), true)
	ply:ConCommand( "playgamesound buttons/button3.wav" ) 
	return

end
concommand.Add("ate_sadmin_clearprops", AdminClearProps)


function AdminClearZeds( ply, cmd, args )
	if !ply:IsValid() then return false end
	if !AdminCheck(ply) then 
		SystemMessage(ply, "You are not admin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	if args[1] == "force" then
		-- force remove all nextbots and npcs
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
		SystemMessage(ply, "Cleaned up all nextbots and NPCs!", Color(155,255,155,255), true)
		ply:ConCommand( "playgamesound buttons/button15.wav" )
		for k, v in pairs( ents.GetAll() ) do
			if v.Type == "nextbot" or ( v:IsNPC() and v:GetClass() != "trader" ) then v.LastAttacker = nil v:Remove() end
		end
	else
		ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
		print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
		SystemMessage(ply, "Cleaned up all zombies!", Color(155,255,155,255), true)
		ply:ConCommand( "playgamesound buttons/button15.wav" )
		for k, v in pairs(Config[ "ZombieClasses" ]) do
			for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil ent:Remove() end
		end
	end
end
concommand.Add("ate_admin_clearzombies", AdminClearZeds)

function TEADevGiveLevel( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Level = ply.Level + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels!")
SystemMessage(ply, "You gave yourself "..addqty.." levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:SetNWInt( "PlyLevel", ply.Level )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givelevels", TEADevGiveLevel)


function TEADevGiveXP( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.XP = ply.XP + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." XP!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." XP!")
SystemMessage(ply, "You gave yourself "..addqty.." XP!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givexp", TEADevGiveXP)

function TEADevGiveBounty( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Bounty = ply.Bounty + addqty
ply:SetNWInt( "PlyBounty", ply.Bounty )
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." bounty!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." bounty!")
SystemMessage(ply, "You gave yourself "..addqty.." Bounty!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givebounty", TEADevGiveBounty)

function TEADevGiveStatPoints( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatPoints = ply.StatPoints + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." Skill points!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." Skill points!")
SystemMessage(ply, "You gave yourself "..addqty.." Skill points!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatpoints", TEADevGiveStatPoints)

--this was probably one of the hardest commands i've ever added
function TEADevGiveStat( ply, cmd, args )
	if !ply:IsValid() then return false end

	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	
	local statname = args[1] or nil
	local addqty = args[2] or 1
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(StatsListServer) do ply:PrintMessage(2, v) end
	return end
	local stat = "Stat"..statname
	if statname == "Points" then --when they manage to increase their skill points with this command while it's supposed to increase their skill
		SystemMessage(ply, "You can't increase your Skill Points with this command! Use tea_dev_givestatpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = ply[stat] + addqty
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." Skill for "..addqty.." point(s)!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." increased their "..statname.." Skill for "..addqty.." point(s)!")
	SystemMessage(ply, "You increased your "..statname.." Skill for "..addqty.." point(s)!", Color(155,255,155,255), true)

	FullyUpdatePlayer(ply)
	ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestat", TEADevGiveStat)


function TEADevGiveStamina( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Stamina = ply.Stamina + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Stamina!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Stamina!")
SystemMessage(ply, "You gave yourself "..addqty.."% Stamina!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestamina", TEADevGiveStamina)

function TEADevGiveHunger( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Hunger = ply.Hunger + (addqty * 100)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Hunger!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Hunger!")
SystemMessage(ply, "You gave yourself "..addqty.."% Hunger!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givehunger", TEADevGiveHunger)

function TEADevGiveThirst( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Thirst = ply.Thirst + (addqty * 100)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Thirst!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Thirst!")
SystemMessage(ply, "You gave yourself "..addqty.."% Thirst!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givethirst", TEADevGiveThirst)

function TEADevGiveFatigue( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Fatigue = ply.Fatigue + (addqty * 100)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Fatigue!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Fatigue!")
SystemMessage(ply, "You gave yourself "..addqty.."% Fatigue!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givefatigue", TEADevGiveFatigue)

function TEADevGiveInfection( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.Infection = ply.Infection + (addqty * 100)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Infection!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."% Infection!")
SystemMessage(ply, "You gave yourself "..addqty.."% Infection!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_giveinfection", TEADevGiveInfection)

function PlayerForceGainLevel( ply )

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

ply.IsLevelingAllowed = true
CurrentXP = ply.XP
RequiredXP = GetReqXP(ply)
ply.XP = 1e+999
PlayerGainLevel( ply )
ply.IsLevelingAllowed = false
ply.XP = CurrentXP - RequiredXP
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up!")
print("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up!")
FullyUpdatePlayer( ply )

end
concommand.Add("tea_dev_forcelevel", PlayerForceGainLevel)

function PlayerForceGainLevelNoXP( ply )

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

ply.IsLevelingAllowed = true
CurrentXP = ply.XP
RequiredXP = GetReqXP(ply)
ply.XP = 1e+999
PlayerGainLevel( ply )
ply.IsLevelingAllowed = true
ply.XP = CurrentXP
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up! (without reducing XP)")
print("[ADMIN COMMAND USED] "..ply:Nick().." forced themselves to level up! (without reducing XP)")
FullyUpdatePlayer( ply )

end
concommand.Add("tea_dev_forcelevel_noxp", PlayerForceGainLevelNoXP)

function TEADevSetCash( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Money = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their money to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their money to "..setqty.."!")
SystemMessage(ply, "You set your money to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setmoney", TEADevSetCash)


function TEADevSetLevel( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Level = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their level to "..setqty.."!")
SystemMessage(ply, "You set your level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setlevel", TEADevSetLevel)


function TEADevSetXP( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.XP = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their XP to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their XP to "..setqty.."!")
SystemMessage(ply, "You set your XP to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setxp", TEADevSetXP)

function TEADevSetStatPoints( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatPoints = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Skill points value to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Skill points value to "..setqty.."!")
SystemMessage(ply, "You set your Skill points value to "..setqty.."!", Color(155,255,155,255), true)


FullyUpdatePlayer(ply)
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatpoints", TEADevSetStatPoints)

function TEADevSetBounty( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Bounty = setqty
ply:SetNWInt( "PlyBounty", ply.Bounty )
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Bounty to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Bounty to "..setqty.."!")
SystemMessage(ply, "You set your Bounty to "..setqty.."!", Color(155,255,155,255), true)


FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setbounty", TEADevSetBounty)

function TEADevGiveStat( ply, cmd, args )
	if !ply:IsValid() then return false end

	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	
	local statname = args[1] or nil
	local setqty = args[2] or 1
	if statname == nil then
		ply:PrintMessage(2, "Usage:\nArgument #1: Stat Name\nInclude only stat name, do not include Stat before stat name! (Examples: Agility, Speed or Strength)\n \nList:")
		for k,v in ipairs(StatsListServer) do ply:PrintMessage(2, v) end
	return end
	local stat = "Stat"..statname
	if statname == "Points" then
		SystemMessage(ply, "You can't set your Skill Points with this command! Use tea_dev_setstatpoints instead!", Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	ply[stat] = setqty
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." Skill value to "..setqty.."!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." set their "..statname.." Skill value to "..setqty.."!")
	SystemMessage(ply, "You set your "..statname.." Skill value to "..setqty.."!", Color(155,255,155,255), true)

	FullyUpdatePlayer(ply)
	ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstat", TEADevGiveStat)

function TEADevSetStamina( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Stamina = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Stamina to "..setqty.."%!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Stamina to "..setqty.."%!")
SystemMessage(ply, "You set your Stamina to "..setqty.."%!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstamina", TEADevSetStamina)

function TEADevSetHunger( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Hunger = setqty * 100
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Hunger to "..setqty.."%!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Hunger to "..setqty.."%!")
SystemMessage(ply, "You set your Hunger to "..setqty.."%!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_sethunger", TEADevSetHunger)

function TEADevSetThirst( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Thirst = setqty * 100
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Thirst to "..setqty.."%!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Thirst to "..setqty.."%!")
SystemMessage(ply, "You set your Thirst to "..setqty.."%!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setthirst", TEADevSetThirst)

function TEADevSetFatigue( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Fatigue = setqty * 100
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Fatigue to "..setqty.."%!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Fatigue to "..setqty.."%!")
SystemMessage(ply, "You set your Fatigue to "..setqty.."%!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setfatigue", TEADevSetFatigue)

function TEADevSetInfection( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.Infection = setqty * 100
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Infection to "..setqty.."%!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Infection to "..setqty.."%!")
SystemMessage(ply, "You set your Infection to "..setqty.."%!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setinfection", TEADevSetInfection)

function ATEAdminSystemBroadcast( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local message = args[1] or nil
local cr = args[2] or 255
local cg = args[3] or 255
local cb = args[4] or 255

if message == nil then
SystemMessage(ply, "Usage: ate_sadmin_systembroadcast (message) (red color value) (green color value) (blue color value)", Color(255,255,255,255), true)
return end

SystemBroadcast(message, Color(cr,cg,cb,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")
print("[ADMIN COMMAND USED] "..ply:Nick().." broadcasted a message with text '"..message.."' and color ("..cr..","..cg..","..cb..")!")

end
concommand.Add("ate_sadmin_systembroadcast", ATEAdminSystemBroadcast)

function ATEAdminSpawnBoss( ply )
if !AdminCheck( ply ) then 
	SystemMessage(ply, "You are not admin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

CanSpawnBoss = 1
SpawnBoss()
CanSpawnBoss = 0
ply:ConCommand( "playgamesound buttons/button3.wav" )
SystemMessage(ply, "Command received, boss spawning soon.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn boss command!")
end
concommand.Add("ate_admin_spawnboss", ATEAdminSpawnBoss)

function ATEAdminSpawnAirdrop( ply )
if !AdminCheck( ply ) then 
	SystemMessage(ply, "You are not admin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

CanSpawnAirdrop = 1
SpawnAirdrop()
CanSpawnAirdrop = 0
ply:ConCommand( "playgamesound buttons/button3.wav" )
SystemMessage(ply, "Command received, airdrop is dropping soon.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has used spawn airdrop command!")
end
concommand.Add("ate_admin_spawnairdrop", ATEAdminSpawnAirdrop)

function ATEForceSavePlayer( ply )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

AllowSave = 1
SavePlayer(ply)
SavePlayerInventory(ply)
SavePlayerVault(ply)
AllowSave = 0
ply:ConCommand( "playgamesound buttons/button3.wav" )
SystemMessage(ply, "Saved.", Color(155,255,155,255), true)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has saved their data!")
print("[ADMIN COMMAND USED] "..ply:Nick().." has saved their data!")
end
concommand.Add("tea_dev_forcesaveplayer", ATEForceSavePlayer)

function ATERefreshEverything( ply )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
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
concommand.Add("ate_sadmin_refresheverything", ATERefreshEverything)

function ATESpawnItem(ply, cmd, args) 
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local name = args[1]
local item = ItemsList[name]
if item == nil then SendChat(ply, "Usage: ate_sadmin_spawnitem [Item ID] (Spawn a dropped item in front of you)") return false end
if !item then SystemMessage(ply, "ERROR! This item does not exist!", Color(255,205,205,255), true) 
ply:ConCommand( "playgamesound buttons/button8.wav" ) return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
if item.Category == 4 then --it will remain as category 4 so it will detect if it is armor, as long as it doesn't have flaws
local EntDrop = ents.Create( "ate_droppeditem" )
			EntDrop:SetPos( tr.HitPos )
			EntDrop:SetAngles( Angle( 0, 0, 0 ) )
			EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")
			EntDrop:SetNWString("ItemClass", name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
else
	local EntDrop = ents.Create( "ate_droppeditem" )
			EntDrop:SetPos( tr.HitPos )
			EntDrop:SetAngles( Angle( 0, 0, 0 ) )
			EntDrop:SetModel(ItemsList[name]["Model"])
			EntDrop:SetNWString("ItemClass", name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
end

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..translate.Get(item["Name"]))
print("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..translate.Get(item["Name"]))
SystemMessage(ply, "You spawned a dropped item: "..translate.Get(item["Name"]).."!", Color(155,255,155,255), true)

ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("ate_sadmin_spawnitem", ATESpawnItem)

function ATESpawnMoney(ply, cmd, args) 
	if !ply:IsValid() then return false end
	
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	
	local cash = args[1] or 0
	if cash == 0 or tonumber(cash) < 0 then SendChat(ply, "Usage: ate_sadmin_spawnmoney (amount) - Spawn a desired amount of money in front of you [Amount can't be negative]") return end
	
	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine( trace )

	if cash != nil then
		local EntDrop = ents.Create( "ate_cash" )
		EntDrop:SetPos( tr.HitPos )
		EntDrop:SetAngles( Angle( 0, 0, 0 ) )
		EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")	
		EntDrop:SetNWInt("CashAmount", math.floor(cash))
		EntDrop:Spawn()
		EntDrop:Activate()
	end
				
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..Config[ "Currency" ].."s!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." spawned dropped cash with "..cash.." "..Config[ "Currency" ].."s!")
	SystemMessage(ply, "You spawned dropped cash with "..cash.." "..Config[ "Currency" ].."s!", Color(155,255,155,255), true)
	
	ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("ate_sadmin_spawnmoney", ATESpawnMoney)

function TEARefillStats(ply, cmd)
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

ply.Stamina = 100
ply.Hunger = 10000
ply.Thirst = 10000
ply.Fatigue = 0
ply.Infection = 0

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." refilled their stats!")
print("[ADMIN COMMAND USED] "..ply:Nick().." refilled their stats!")
SystemMessage(ply, "You refilled your stats!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_refillstats", TEARefillStats)

function TEADevPayout( ply, cmd, args )
	if !ply:IsValid() then return false end
	
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end
	
	local xp = args[1] or nil
	local cash = args[2] or 0

	if xp == nil or cash == nil then SendChat(ply, "Use this for test! Modifiers such as skills do apply! (tea_dev_payout {xp} {bounty})") return end
	Payout(ply, xp, cash)
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." used Payout command and gained "..xp.." XP and "..cash.." Cash!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." used Payout command and gained "..xp.." XP and "..cash.." Cash!")
	SystemMessage(ply, "You used Payout command and gained "..xp.." XP and "..cash.." Cash!", Color(155,255,155,255), true)
	
	FullyUpdatePlayer( ply )
	ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_payout", TEADevPayout)