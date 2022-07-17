function AdminGiveItem( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local name = args[1]
local addqty = args[2] or 1
local item = ItemsList[name]
if !item then SystemMessage(ply, "ERROR! This item does not exist!", Color(255,205,205,255), true) 
ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" ) return false end

if (CalculateWeight(ply) + (item.Weight * addqty)) > (37.4 + ((ply.StatStrength or 0) * 1.53)) then SendChat(ply, "You are lacking inventory space!") return false end

SystemGiveItem( ply, name, addqty )

SystemMessage(ply, "You gave yourself "..addqty.."x "..item["Name"], Color(155,255,155,255), true)
FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("ate_sadmin_give_item", AdminGiveItem)

function AdminGiveCash( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Money = ply.Money + addqty
SystemMessage(ply, "You gave yourself "..addqty.." "..Config[ "Currency" ].."s!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("ate_sadmin_givecash", AdminGiveCash)


function AdminClearProps( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

	for k, v in pairs( ents.FindByClass( "prop_flimsy" ) ) do
		v:Remove()
	end

	for k, v in pairs( ents.FindByClass( "prop_strong" ) ) do
		v:Remove()
	end

	SystemMessage(ply, "Cleaned up all props!", Color(155,255,155,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" ) 
	return

end
concommand.Add("ate_sadmin_clearprops", AdminClearProps)


function AdminClearZeds( ply, cmd, args )
if !ply:IsValid() then return false end

if !AdminCheck( ply ) then 
	SystemMessage(ply, "You are not admin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

	if args[1] == "force" then
		-- force remove all nextbots and npcs
	SystemMessage(ply, "Cleaned up all nextbots and NPCs!", Color(155,255,155,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
		for k, v in pairs( ents.GetAll() ) do
			if v.Type == "nextbot" or ( v:IsNPC() and v:GetClass() != "trader" ) then v.LastAttacker = nil v:Remove() end
		end

	else

	SystemMessage(ply, "Cleaned up all ATE zombies!", Color(155,255,155,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
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
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Level = ply.Level + addqty
SystemMessage(ply, "You gave yourself "..addqty.." levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:SetNWInt( "PlyLevel", ply.Level )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givelevels", ATEDebugGiveLevel)


function ATEDebugGiveXP( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.XP = ply.XP + addqty
SystemMessage(ply, "You gave yourself "..addqty.." Experience!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givexp", ATEDebugGiveXP)

function ATEDebugGiveStatPoints( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatPoints = ply.StatPoints + addqty
SystemMessage(ply, "You gave yourself "..addqty.." Skill points!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatpoints", ATEDebugGiveStatPoints)

function ATEDebugGiveBounty( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Bounty = ply.Bounty + addqty
SystemMessage(ply, "You gave yourself "..addqty.." Bounty!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givebounty", ATEDebugGiveBounty)

function ATEDebugGiveStatDefense( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatDefense = ply.StatDefense + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatDefense Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatdefense", ATEDebugGiveStatDefense)

function ATEDebugGiveStatDamage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatDamage = ply.StatDamage + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatDamage Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatdamage", ATEDebugGiveStatDamage)

function ATEDebugGiveStatSpeed( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSpeed = ply.StatSpeed + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatSpeed Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
RecalcPlayerSpeed(ply)
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatspeed", ATEDebugGiveStatSpeed)

function ATEDebugGiveStatHealth( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatHealth = ply.StatHealth + addqty
ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
SystemMessage(ply, "You gave yourself "..addqty.." StatHealth Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestathealth", ATEDebugGiveStatHealth)

function ATEDebugGiveStatKnowledge( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatKnowledge = ply.StatKnowledge + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatKnowledge Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatknowledge", ATEDebugGiveStatKnowledge)

function ATEDebugGiveStatMedSkill( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatMedSkill = ply.StatMedSkill + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatMedSkill Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatmedskill", ATEDebugGiveStatMedSkill)

function ATEDebugGiveStatStrength( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatStrength = ply.StatStrength + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatStrength Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatstrength", ATEDebugGiveStatStrength)

function ATEDebugGiveStatEndurance( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatEndurance = ply.StatEndurance + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatEndurance Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatendurance", ATEDebugGiveStatEndurance)

function ATEDebugGiveStatSalvage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSalvage = ply.StatSalvage + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatSalvage Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatsalvage", ATEDebugGiveStatSalvage)

function ATEDebugGiveStatBarter( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatBarter = ply.StatBarter + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatBarter Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatbarter", ATEDebugGiveStatBarter)

function ATEDebugGiveStatEngineer( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatEngineer = ply.StatEngineer + addqty
ply:MaxArmor( 100 + ( ply.StatEngineer * 2 ) )
SystemMessage(ply, "You gave yourself "..addqty.." StatEngineer Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatengineer", ATEDebugGiveStatEngineer)

function ATEDebugGiveStatImmunity( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatImmunity = ply.StatImmunity + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatImmunity Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatimmune", ATEDebugGiveStatImmunity)

function ATEDebugGiveStatSurvivor( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.StatSurvivor = ply.StatSurvivor + addqty
SystemMessage(ply, "You gave yourself "..addqty.." StatSurvivor Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestatsurvivor", ATEDebugGiveStatSurvivor)

function ATEDebugGiveStamina( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Stamina = ply.Stamina + addqty
SystemMessage(ply, "You gave yourself "..addqty.."% Stamina!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givestamina", ATEDebugGiveStamina)

function ATEDebugGiveHunger( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Hunger = ply.Hunger + (addqty * 100)
SystemMessage(ply, "You gave yourself "..addqty.."% Hunger!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givehunger", ATEDebugGiveHunger)

function ATEDebugGiveFatigue( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Fatigue = ply.Fatigue + (addqty * 100)
SystemMessage(ply, "You gave yourself "..addqty.."% Fatigue!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_givefatigue", ATEDebugGiveFatigue)

function ATEDebugGiveInfection( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local addqty = args[1] or 1

ply.Infection = ply.Infection + (addqty * 100)
SystemMessage(ply, "You gave yourself "..addqty.."% Infection!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_giveinfection", ATEDebugGiveInfection)

function PlayerForceGainLevel( ply )

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

	ply.XP = ply.XP - GetReqXP( ply )
	ply.Level = ply.Level + 1
	ply.StatPoints = ply.StatPoints + 1
	ply.Money = ply.Money + 62 + ((ply.Level ^ 1.046) * 19)
	SendChat( ply, "Congratulations! You are now level " .. ply.Level .. ", you have gained 1 skill point and " .. 62 + ((ply.Level ^ 1.043) * 19) .. " cash!" )
	ply:ConCommand( "play theeverlastingapocalypse/levelup.wav" )

	ply:SetNWInt( "PlyLevel", ply.Level )

	net.Start("UpdatePeriodicStats")
	net.WriteFloat( ply.Level )
	net.WriteFloat( ply.Money )
	net.WriteFloat( ply.XP )
	net.WriteFloat( ply.StatPoints )
	net.WriteFloat( ply.Bounty )
	net.Send( ply )

end
concommand.Add("tea_dev_forcelevel", PlayerForceGainLevel)

function PlayerForceGainLevelNoXP( ply )

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end
	ply.Level = ply.Level + 1
	ply.StatPoints = ply.StatPoints + 1
	ply.Money = ply.Money + 62 + ((ply.Level ^ 1.046) * 19)
	SendChat( ply, "Congratulations! You are now level " .. ply.Level .. ", you have gained 1 skill point and " .. 62 + ((ply.Level ^ 1.043) * 19) .. " cash!" )
	ply:ConCommand( "play theeverlastingapocalypse/levelup.wav" )

	ply:SetNWInt( "PlyLevel", ply.Level )

	net.Start("UpdatePeriodicStats")
	net.WriteFloat( ply.Level )
	net.WriteFloat( ply.Money )
	net.WriteFloat( ply.XP )
	net.WriteFloat( ply.StatPoints )
	net.WriteFloat( ply.Bounty )
	net.Send( ply )

end
concommand.Add("tea_dev_forcelevel_noxp", PlayerForceGainLevelNoXP)

function ATEDebugSetCash( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Money = setqty
SystemMessage(ply, "You set your Money amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setmoney", ATEDebugSetCash)


function ATEDebugSetLevel( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Level = setqty
SystemMessage(ply, "You set your Level amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setlevel", ATEDebugSetLevel)


function ATEDebugSetXP( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.XP = setqty
SystemMessage(ply, "You set your Experience amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setxp", ATEDebugSetXP)

function ATEDebugSetStatPoints( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatPoints = setqty
SystemMessage(ply, "You set your Skill Points amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatpoints", ATEDebugSetStatPoints)

function ATEDebugSetBounty( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Bounty = setqty
SystemMessage(ply, "You set your Bounty amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setbounty", ATEDebugSetBounty)

function ATEDebugSetStatDefense( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatDefense = setqty
SystemMessage(ply, "You set your StatDefense amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatdefense", ATEDebugSetStatDefense)

function ATEDebugSetStatDamage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatDamage = setqty
SystemMessage(ply, "You set your StatDamage amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatdamage", ATEDebugSetStatDamage)

function ATEDebugSetStatSpeed( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSpeed = setqty
SystemMessage(ply, "You set your StatSpeed amount to "..setqty.."!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
RecalcPlayerSpeed(ply)
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatspeed", ATEDebugSetStatSpeed)

function ATEDebugSetStatHealth( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatHealth = setqty
ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
SystemMessage(ply, "You gave yourself "..setqty.." StatHealth Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstathealth", ATEDebugSetStatHealth)

function ATEDebugSetStatKnowledge( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatKnowledge = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatKnowledge Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatknowledge", ATEDebugSetStatKnowledge)

function ATEDebugSetStatMedSkill( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatMedSkill = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatMedSkill Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatmedskill", ATEDebugSetStatMedSkill)

function ATEDebugSetStatStrength( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatStrength = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatStrength Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatstrength", ATEDebugSetStatStrength)

function ATEDebugSetStatEndurance( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatEndurance = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatEndurance Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatendurance", ATEDebugSetStatEndurance)

function ATEDebugSetStatSalvage( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSalvage = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatSalvage Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatsalvage", ATEDebugSetStatSalvage)

function ATEDebugSetStatBarter( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatBarter = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatBarter Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatbarter", ATEDebugSetStatBarter)

function ATEDebugSetStatEngineer( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatEngineer = setqty
ply:SetMaxArmor( 100 + ( ply.StatEngineer * 2 ) )
SystemMessage(ply, "You gave yourself "..setqty.." StatEngineer Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatengineer", ATEDebugSetStatEngineer)

function ATEDebugSetStatImmunity( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatImmunity = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatImmunity Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatimmune", ATEDebugSetStatImmunity)

function ATEDebugSetStatSurvivor( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.StatSurvivor = setqty
SystemMessage(ply, "You gave yourself "..setqty.." StatSurvivor Levels!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstatsurvivor", ATEDebugSetStatSurvivor)

function ATEDebugSetStamina( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Stamina = setqty
SystemMessage(ply, "You gave yourself "..setqty.."% Stamina!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setstamina", ATEDebugSetStamina)

function ATEDebugSetHunger( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Hunger = setqty * 100
SystemMessage(ply, "You gave yourself "..setqty.."% Hunger!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_sethunger", ATEDebugSetHunger)

function ATEDebugSetFatigue( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Fatigue = setqty * 100
SystemMessage(ply, "You gave yourself "..setqty.."% Fatigue!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setfatigue", ATEDebugSetFatigue)

function ATEDebugSetInfection( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local setqty = args[1] or 1

ply.Infection = setqty * 100
SystemMessage(ply, "You gave yourself "..setqty.."% Infection!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
end
concommand.Add("tea_dev_setinfection", ATEDebugSetInfection)

function ATEAdminSystemBroadcast( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

local message = args[1] or "#EP2_GameOver_AlyxLeft"
local cr = args[2] or 255
local cg = args[3] or 255
local cb = args[4] or 255

SystemBroadcast(""..message.."", Color(cr,cg,cb,255), true)

end
concommand.Add("ate_sadmin_systembroadcast", ATEAdminSystemBroadcast)

function ATEAdminSpawnBoss( ply )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

SpawnBoss()
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
SystemMessage(ply, "Command received, boss spawning soon.", Color(155,255,155,255), true)
end
concommand.Add("ate_sadmin_spawnboss", ATEAdminSpawnBoss)

function ATEAdminSpawnAirdrop( ply )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

SpawnAirdrop()
ply:ConCommand( "play theeverlastingapocalypse/access_granted.wav" )
SystemMessage(ply, "Command received, airdrop is dropping soon.", Color(155,255,155,255), true)
end
concommand.Add("ate_sadmin_spawnairdrop", ATEAdminSpawnAirdrop)

function ATERefreshEverything( ply )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
end

LoadAD()
LoadLoot()
LoadZombies()
LoadTraders()
LoadPlayerSpawns()
SystemMessage(ply, "Refreshed all spawns.", Color(155,255,155,255), true)
end
concommand.Add("ate_sadmin_refresheverything", ATERefreshEverything)