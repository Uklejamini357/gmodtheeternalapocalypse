function AdminGiveItem( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local name = args[1]
local addqty = args[2] or 1
local item = ItemsList[name]
if !item then SystemMessage(ply, "ERROR! This item does not exist!", Color(255,205,205,255), true) 
ply:ConCommand( "playgamesound buttons/button8.wav" ) return false end

if (CalculateWeight(ply) + (item.Weight * addqty)) > (CalculateMaxWeight(ply)) then SendChat(ply, "You are lacking inventory space! Drop some items first.") return false end

SystemGiveItem( ply, name, addqty )

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..item["Name"].."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.."x "..item["Name"].."!")
SystemMessage(ply, "You gave yourself "..addqty.."x "..item["Name"], Color(155,255,155,255), true)
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
	
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave "..item["Name"].." from their inventory!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." removed "..item["Name"].." from their inventory!")
	SystemMessage(ply, "You removed "..item["Name"].." from your inventory!", Color(155,255,155,255), true)
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
	ply:ConCommand( "playgamesound buttons/button8.wav" )
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

if !AdminCheck( ply ) then 
	SystemMessage(ply, "You are not admin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

	if args[1] == "force" then
		-- force remove all nextbots and npcs
	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all NPCs and nextbots!")
	SystemMessage(ply, "Cleaned up all nextbots and NPCs!", Color(155,255,155,255), true)
	ply:ConCommand( "playgamesound buttons/button3.wav" )
		for k, v in pairs( ents.GetAll() ) do
			if v.Type == "nextbot" or ( v:IsNPC() and v:GetClass() != "trader" ) then v.LastAttacker = nil v:Remove() end
		end

	else

	ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
	print("[ADMIN COMMAND USED] "..ply:Nick().." has cleaned up all zombies!")
	SystemMessage(ply, "Cleaned up all zombies!", Color(155,255,155,255), true)
	ply:ConCommand( "playgamesound buttons/button3.wav" )
	for k, v in pairs(Config[ "ZombieClasses" ]) do
		for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil ent:Remove() end
	end


	end


end
concommand.Add("ate_admin_clearzombies", AdminClearZeds)

function ATEDebugGiveLevel( ply, cmd, args )
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
concommand.Add("tea_dev_givelevels", ATEDebugGiveLevel)


function ATEDebugGiveXP( ply, cmd, args )
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
concommand.Add("tea_dev_givexp", ATEDebugGiveXP)

function ATEDebugGiveStatPoints( ply, cmd, args )
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
concommand.Add("tea_dev_givestatpoints", ATEDebugGiveStatPoints)

function ATEDebugGiveBounty( ply, cmd, args )
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
concommand.Add("tea_dev_givebounty", ATEDebugGiveBounty)

function ATEDebugGiveStatDefense( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatDefense = ply.StatDefense + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Defense skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Defense skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Defense skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatdefense", ATEDebugGiveStatDefense)

function ATEDebugGiveStatDamage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatDamage = ply.StatDamage + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Damage skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Damage skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Damage skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatdamage", ATEDebugGiveStatDamage)

function ATEDebugGiveStatSpeed( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSpeed = ply.StatSpeed + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Speed skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Speed skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Speed skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
RecalcPlayerSpeed(ply)
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatspeed", ATEDebugGiveStatSpeed)

function ATEDebugGiveStatHealth( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatHealth = ply.StatHealth + addqty
ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Speed skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Speed skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Health skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestathealth", ATEDebugGiveStatHealth)

function ATEDebugGiveStatKnowledge( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatKnowledge = ply.StatKnowledge + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Knowledge skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Knowledge skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Knowledge skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatknowledge", ATEDebugGiveStatKnowledge)

function ATEDebugGiveStatMedSkill( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatMedSkill = ply.StatMedSkill + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for MedSkill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for MedSkill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for MedSkill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatmedskill", ATEDebugGiveStatMedSkill)

function ATEDebugGiveStatStrength( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatStrength = ply.StatStrength + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Strength skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Strength skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Strength skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatstrength", ATEDebugGiveStatStrength)

function ATEDebugGiveStatEndurance( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatEndurance = ply.StatEndurance + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Endurance skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Endurance skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Endurance skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatendurance", ATEDebugGiveStatEndurance)

function ATEDebugGiveStatSalvage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSalvage = ply.StatSalvage + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Salvage skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Salvage skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Salvage skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatsalvage", ATEDebugGiveStatSalvage)

function ATEDebugGiveStatBarter( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatBarter = ply.StatBarter + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Barter skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Barter skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Barter skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatbarter", ATEDebugGiveStatBarter)

function ATEDebugGiveStatEngineer( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatEngineer = ply.StatEngineer + addqty
CalculateStartingArmor(ply)

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Engineer skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Engineer skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Engineer skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatengineer", ATEDebugGiveStatEngineer)

function ATEDebugGiveStatImmunity( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatImmunity = ply.StatImmunity + addqty

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Immunity skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Immunity skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Immunity skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatimmunity", ATEDebugGiveStatImmunity)

function ATEDebugGiveStatSurvivor( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSurvivor = ply.StatSurvivor + addqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Survivor skill!")
print("[ADMIN COMMAND USED] "..ply:Nick().." gave themselves "..addqty.." levels for Survivor skill!")
SystemMessage(ply, "You gave yourself "..addqty.." levels for Survivor skill!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_givestatsurvivor", ATEDebugGiveStatSurvivor)

function ATEDebugGiveStamina( ply, cmd, args )
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
concommand.Add("tea_dev_givestamina", ATEDebugGiveStamina)

function ATEDebugGiveHunger( ply, cmd, args )
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
concommand.Add("tea_dev_givehunger", ATEDebugGiveHunger)

function ATEDebugGiveThirst( ply, cmd, args )
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
concommand.Add("tea_dev_givethirst", ATEDebugGiveThirst)

function ATEDebugGiveFatigue( ply, cmd, args )
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
concommand.Add("tea_dev_givefatigue", ATEDebugGiveFatigue)

function ATEDebugGiveInfection( ply, cmd, args )
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
concommand.Add("tea_dev_giveinfection", ATEDebugGiveInfection)

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

function ATEDebugSetCash( ply, cmd, args )
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
concommand.Add("tea_dev_setmoney", ATEDebugSetCash)


function ATEDebugSetLevel( ply, cmd, args )
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
concommand.Add("tea_dev_setlevel", ATEDebugSetLevel)


function ATEDebugSetXP( ply, cmd, args )
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
concommand.Add("tea_dev_setxp", ATEDebugSetXP)

function ATEDebugSetStatPoints( ply, cmd, args )
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


FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatpoints", ATEDebugSetStatPoints)

function ATEDebugSetBounty( ply, cmd, args )
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
concommand.Add("tea_dev_setbounty", ATEDebugSetBounty)

function ATEDebugSetStatDefense( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatDefense = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Defense skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Defense skill level to "..setqty.."!")
SystemMessage(ply, "You set your Defense skill level to "..setqty.."!", Color(155,255,155,255), true)


FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatdefense", ATEDebugSetStatDefense)

function ATEDebugSetStatDamage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatDamage = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Damage skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Damage skill level to "..setqty.."!")
SystemMessage(ply, "You set your Damage skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatdamage", ATEDebugSetStatDamage)

function ATEDebugSetStatSpeed( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSpeed = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Speed skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Speed skill level to "..setqty.."!")
SystemMessage(ply, "You set your Speed skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
RecalcPlayerSpeed(ply)
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatspeed", ATEDebugSetStatSpeed)

function ATEDebugSetStatHealth( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatHealth = setqty
ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Health skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Health skill level to "..setqty.."!")
SystemMessage(ply, "You set your Health skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstathealth", ATEDebugSetStatHealth)

function ATEDebugSetStatKnowledge( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatKnowledge = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Knowledge skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Knowledge skill level to "..setqty.."!")
SystemMessage(ply, "You set your Knowledge skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatknowledge", ATEDebugSetStatKnowledge)

function ATEDebugSetStatMedSkill( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatMedSkill = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Medskill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their MedSkill level to "..setqty.."!")
SystemMessage(ply, "You set your MedSkill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatmedskill", ATEDebugSetStatMedSkill)

function ATEDebugSetStatStrength( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatStrength = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Strength skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Strength skill level to "..setqty.."!")
SystemMessage(ply, "You set your Strength skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatstrength", ATEDebugSetStatStrength)

function ATEDebugSetStatEndurance( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatEndurance = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Endurance skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Endurance skill level to "..setqty.."!")
SystemMessage(ply, "You set your Endurance skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatendurance", ATEDebugSetStatEndurance)

function ATEDebugSetStatSalvage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSalvage = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Salvage skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Salvage skill level to "..setqty.."!")
SystemMessage(ply, "You set your Salvage skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatsalvage", ATEDebugSetStatSalvage)

function ATEDebugSetStatBarter( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatBarter = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Barter skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Barter skill level to "..setqty.."!")
SystemMessage(ply, "You set your Barter skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatbarter", ATEDebugSetStatBarter)

function ATEDebugSetStatEngineer( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatEngineer = setqty
CalculateStartingArmor(ply)
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Engineer skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Engineer skill level to "..setqty.."!")
SystemMessage(ply, "You set your Engineer skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatengineer", ATEDebugSetStatEngineer)

function ATEDebugSetStatImmunity( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatImmunity = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Immunity skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Immunity skill level to "..setqty.."!")
SystemMessage(ply, "You set your Immunity skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatimmunity", ATEDebugSetStatImmunity)

function ATEDebugSetStatSurvivor( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSurvivor = setqty
ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." set their Survivor skill level to "..setqty.."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." set their Survivor skill level to "..setqty.."!")
SystemMessage(ply, "You set your Survivor skill level to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add("tea_dev_setstatsurvivor", ATEDebugSetStatSurvivor)

function ATEDebugSetStamina( ply, cmd, args )
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
concommand.Add("tea_dev_setstamina", ATEDebugSetStamina)

function ATEDebugSetHunger( ply, cmd, args )
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
concommand.Add("tea_dev_sethunger", ATEDebugSetHunger)

function ATEDebugSetThirst( ply, cmd, args )
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
concommand.Add("tea_dev_setthirst", ATEDebugSetThirst)

function ATEDebugSetFatigue( ply, cmd, args )
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
concommand.Add("tea_dev_setfatigue", ATEDebugSetFatigue)

function ATEDebugSetInfection( ply, cmd, args )
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
concommand.Add("tea_dev_setinfection", ATEDebugSetInfection)

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

ate_DebugLog("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..item["Name"].."!")
print("[ADMIN COMMAND USED] "..ply:Nick().." spawned a dropped item: "..item["Name"].."!")
SystemMessage(ply, "You spawned a dropped item: "..item["Name"].."!", Color(155,255,155,255), true)

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