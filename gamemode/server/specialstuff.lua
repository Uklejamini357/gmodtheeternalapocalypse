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
net.WriteFloat( ply.Prestige )
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
net.WriteFloat( ply.StatImmunity )
net.WriteFloat( ply.StatSurvivor )
net.WriteFloat( ply.StatAgility )
net.Send( ply )

SystemMessage(ply, "An admin has reset your skillls! All of your skills are now set to 0 and stat points are refunded", Color(205,205,205,255), true)

return true

end