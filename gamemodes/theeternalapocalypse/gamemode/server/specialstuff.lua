-- Misc stuff
-- don't mind the stuff here, useful for events though

GM.ZS = {}


function GM.ZS.StartZombieApocalypse(preptime, wavedur)
	if timer.Exists("TEAZombieApocalypse_Preparation") or timer.Exists("TEAZombieApocalypse_Begun") then print("Zombie Apocalypse event has already started!") return false end
	local i = preptime
	local d = wavedur
	local a = GAMEMODE.ZombieSpawningEnabled
	local za = GAMEMODE.ZombieApocalypse

--	GAMEMODE:SystemBroadcast("Ŧĥë əťēʀŉáɩ ɑpɷċãĺʏpşē mode is now active", Color(255,195,95), false)
	GAMEMODE:SystemBroadcast(Format("Attention! A massive horde of zombies is approaching! Estimated time before they arrive: %s minutes", preptime), Color(255,95,95), false)
	GAMEMODE.ZombieSpawningEnabled = false
	BroadcastLua("GAMEMODE.ZombieSpawningEnabled = false")
	GAMEMODE.ZombieApocalypse = false
	BroadcastLua("GAMEMODE.ZombieApocalypse = false")

	timer.Create("TEAZombieApocalypse_Preparation", 60, i, function()
		i = i - 1
		if i <= 0 then
			GAMEMODE.ZombieSpawningEnabled = true
			BroadcastLua("GAMEMODE.ZombieSpawningEnabled = true")
			GAMEMODE.ZombieApocalypse = true
			BroadcastLua("GAMEMODE.ZombieApocalypse = true")
					GAMEMODE:SystemBroadcast(Format("WARNING! Zombies have inbound! Survive for: %s minutes.", wavedur), Color(255,95,95), false)
			timer.Create("TEAZombieApocalypse_Begun", 60, d, function()
				d = d - 1
				if d <= 0 then
					GAMEMODE:SystemBroadcast("Zombies wave ended.", Color(255,95,95), false)
					GAMEMODE.ZombieSpawningEnabled = a
					BroadcastLua(a and "GAMEMODE.ZombieSpawningEnabled = true" or "GAMEMODE.ZombieSpawningEnabled = false")
					GAMEMODE.ZombieApocalypse = za
					BroadcastLua(za and "GAMEMODE.ZombieApocalypse = true" or "GAMEMODE.ZombieApocalypse = false")
				else
					PrintMessage(HUD_PRINTCENTER, Format("%s minutes remaining until wave ends", d))
				end
			end)
		else
			PrintMessage(HUD_PRINTCENTER, Format("%s minutes remaining until zombies approach", i))
		end
	end)
end

