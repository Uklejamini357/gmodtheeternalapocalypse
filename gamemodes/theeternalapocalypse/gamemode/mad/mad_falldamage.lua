
function MPFallDamage(ply, vel)
	if GetConVar("mp_falldamage"):GetInt() >= 1 then
		vel = vel - 580
		return vel*(100/(1024-580))
	end
	return 10
end
hook.Add("GetFallDamage", "MPFallDamage", MPFallDamage)
