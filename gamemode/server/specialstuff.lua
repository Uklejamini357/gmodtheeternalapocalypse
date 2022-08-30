-- Misc stuff

function ULXResetSkills(ply)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end

	local refund = 0 + ply.StatPoints
	ply.StatPoints = 0

	for k, v in pairs(StatsListServer) do
		local TheStatPieces = string.Explode( ";", v )
		local TheStatName = TheStatPieces[1]
		refund = refund + tonumber(ply[ TheStatName ])
		ply[ TheStatName ] = 0
	end

	ply.StatPoints = refund

	CalculateMaxHealth(ply)
	CalculateMaxArmor(ply)
	CalculateJumpPower(ply)
	RecalcPlayerSpeed(ply)

	TEANetUpdatePeriodicStats(ply)
	TEANetUpdatePerks(ply)

	SystemMessage(ply, "An admin has reset your skillls! All of your skills are now set to 0 and stat points are refunded", Color(205,205,205,255), true)

	return true
end

hook.Add("PlayerDeathSound", "DeFlatline", function() return true end)
local noise = Sound("common/null.wav") --feel free to edit it
hook.Add("PlayerDeath", "NewSound", function(vic,unused1,unused2)
vic:EmitSound(noise)
end)
