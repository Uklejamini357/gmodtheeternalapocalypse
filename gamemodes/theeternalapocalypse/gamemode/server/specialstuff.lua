-- Misc stuff
-- don't mind the stuff here, useful for events though

GM.ZS = {}

function ULXResetSkills(ply)
	if !SERVER then return false end
	if !ply:IsValid() or !ply:Alive() then return false end

	local refund = 0 + ply.StatPoints
	ply.StatPoints = 0

	for k, v in pairs(GAMEMODE.StatsListServer) do
		local TheStatPieces = string.Explode( ";", v )
		local TheStatName = TheStatPieces[1]
		refund = refund + tonumber(ply[TheStatName])
		ply[TheStatName] = 0
	end

	ply.StatPoints = refund

	GAMEMODE:CalcMaxHealth(ply)
	GAMEMODE:CalcMaxArmor(ply)
	GAMEMODE:CalcJumpPower(ply)
	tea_RecalcPlayerSpeed(ply)

	tea_NetUpdatePeriodicStats(ply)
	tea_NetUpdatePerks(ply)

	SystemMessage(ply, "An admin has reset your skillls! All of your skills are now set to 0 and stat points are refunded", Color(205,205,205,255), true)

	return true
end

function GM.ZS.StartZombieApocalypse(preptime, wavedur)
	if timer.Exists("TEAZombieApocalypse_Preparation") or timer.Exists("TEAZombieApocalypse_Begun") then print("Zombie Apocalypse event has already started!") return false end
	local i = preptime
	local d = wavedur
	local a = GAMEMODE.ZombieSpawningEnabled

	tea_SystemBroadcast(Format("Attention! A massive horde of zombies is approaching! Estimated time before they arrive: %s minutes", preptime), Color(255,95,95), false)
	GAMEMODE.ZombieSpawningEnabled = false
	BroadcastLua("GAMEMODE.ZombieSpawningEnabled = false")
	
	timer.Create("TEAZombieApocalypse_Preparation", 60, i, function()
		i = i - 1
		if i <= 0 then
			GAMEMODE.ZombieSpawningEnabled = true
			BroadcastLua("GAMEMODE.ZombieSpawningEnabled = true")
			tea_SystemBroadcast(Format("WARNING! Zombies have inbound! Survive for: %s minutes.", wavedur), Color(255,95,95), false)
			timer.Create("TEAZombieApocalypse_Begun", 60, d, function()
				d = d - 1
				if d <= 0 then
					tea_SystemBroadcast("Zombies wave ended.", Color(255,95,95), false)
					GAMEMODE.ZombieSpawningEnabled = a
					BroadcastLua(GAMEMODE.ZombieSpawningEnabled and "GAMEMODE.ZombieSpawningEnabled = true" or "GAMEMODE.ZombieSpawningEnabled = false")
				else
					PrintMessage(HUD_PRINTCENTER, Format("%s minutes remaining until wave ends", d))
				end
			end)
		else
			PrintMessage(HUD_PRINTCENTER, Format("%s minutes remaining until zombies approach", i))
		end
	end)
end

