

-- you know this can ruin others' fun right?
/*
function MAD.SetSpawnpoint(ply, command, args)

	ply.SpawnPoint = ply:GetPos()
	ply:ChatPrint("Spawnpoint set.")
end
concommand.Add("mad_spawnpoint", MAD.SetSpawnpoint)

local function PlayerSpawn(ply)

	if ply.SpawnPoint then 
		ply:SetPos(ply.SpawnPoint + Vector(0, 0, 16)) 
	end
end
hook.Add("PlayerSpawn", "PlayerSpawn", PlayerSpawn)
*/
-- Disabled.