-- Misc stuff
-- don't mind the stuff here, useful for events though

GM.ZS = GM.ZS or {}
GM.ZS.Hooks = {}
--GM.ZS.ZombiesWaveActive = GM.ZS.ZombiesWaveActive or false
GM.ZS.WaveDuration = GM.ZS.WaveDuration or 1
--GM.ZS.LastZombieApocalypse = GM.ZS.LastZombieApocalypse or false
--GM.ZS.LastZSpawning = GM.ZS.LastZSpawning or true

function GM.ZS.StartZombieApocalypse(preptime, wavedur)
	if GAMEMODE:GetEvent() ~= EVENT_NONE then print("Event has already started!") return false end
	GAMEMODE.ZS.LastZSpawning = GetGlobalBool("GM.ZombieSpawning")
	GAMEMODE.ZS.LastZombieApocalypse = GAMEMODE.ZombieApocalypse

--	GAMEMODE:SystemBroadcast("Ŧĥë əťēʀŉáɩ ɑpɷċãĺʏpşē mode is now active", Color(255,195,95), false)
--	GAMEMODE:SystemBroadcast(Format("Attention! A massive horde of zombies is approaching! Estimated time before they arrive: %s minutes", preptime), Color(255,95,95), false)
	GAMEMODE:SystemBroadcast("---=== ZOMBIE APOCALYPSE EVENT ===---", Color(255,95,95), false)
	GAMEMODE:SystemBroadcast("Welcome to Zombie Apocalypse Event. You must survive the wave of the zombies. If you die during the wave, you are put into spectator mode.", Color(255,95,95), false)
	GAMEMODE:SystemBroadcast(Format("The wave will stay on for %s minutes. You have only %s minutes to prepare. Good luck!", wavedur, preptime), Color(255,95,95), false)
	GAMEMODE:SystemBroadcast("Note: Zombies will track you anywhere on the map. It's recommended to stay inside barricades due to increased zombies speed.", Color(255,95,95), false)
	GAMEMODE:SystemBroadcast("Tip: Make the barricade as strong as possible and you will possibly survive the onslaught!", Color(255,95,95), false)
	GAMEMODE:SystemBroadcast("Damaging players and props is disabled, even if your PVP is enabled.", Color(255,95,95), false)

	GAMEMODE:SetEvent(EVENT_ZOMBIEAPOCALYPSE)
	GAMEMODE:SetEventTimer(CurTime() + preptime*60)
	GAMEMODE.ZS.WaveDuration = wavedur

	SetGlobalBool("GM.ZombieSpawning", false)
	GAMEMODE.ZombieApocalypse = false
	BroadcastLua("GAMEMODE.ZombieApocalypse = false")

	for hookname,func in pairs(GAMEMODE.ZS.Hooks) do
		hook.Add(hookname, "TEA.Event."..hookname, func)
	end
end


function GM.ZS.EndEvent()
	SetGlobalBool("GM.ZombieSpawning", GAMEMODE.ZS.LastZSpawning)
	GAMEMODE.ZombieApocalypse = GAMEMODE.ZS.LastZombieApocalypse
	BroadcastLua(GAMEMODE.ZS.LastZombieApocalypse and "GAMEMODE.ZombieApocalypse = true" or "GAMEMODE.ZombieApocalypse = false")
	GAMEMODE.ZS.ZombiesWaveActive = false
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		for _, ent in pairs(ents.FindByClass(k)) do
			if !ent.BossMonster then
				ent:SetHealth(0)
				ent:TakeDamage(0)
			end
		end
	end

	for hookname,func in pairs(GAMEMODE.ZS.Hooks) do
		hook.Remove(hookname, "TEA.Event."..hookname)
	end

	timer.Simple(5, function()
		for _,pl in pairs(player.GetAll()) do pl:Spectate(OBS_MODE_ROAMING) pl:StripWeapons() end
		timer.Simple(1, function()
			for _,pl in pairs(player.GetAll()) do pl:KillSilent() pl:Spawn() end
			GAMEMODE:SetEvent(EVENT_NONE)
		end)
	end)

end


function GM.ZS.Hooks.DoPlayerDeath(ply, attacker, dmginfo)
	local pos = ply:GetPos()


	if !GAMEMODE.ZS.ZombiesWaveActive then
		ply:SystemMessage("You want to spectate now? I wouldn't do that, focus on surviving.", Color(255,175,175))

		timer.Simple(1, function()
			ply:Spawn()
		end)
		return
	end

	local alive = 0
	for _,pl in pairs(player.GetAll()) do
		if pl:Alive() then
			alive = alive + 1
		end
	end

	for _,pl in pairs(player.GetAll()) do
		if alive == 0 then
			if pl == ply then
				pl:SystemMessage("You died, and the game is over!", Color(255,80,80))
			else
				pl:SystemMessage(ply:Nick()..", as the last survivor, died! Game over", Color(255,105,105))
			end
		else
			if pl == ply then
				pl:SystemMessage("You died, you may not respawn until the wave is over. "..alive.." survivors remain!", Color(255,155,155))
			else
				pl:SystemMessage(ply:Nick().." died, "..alive.." survivors remain!", Color(255,205,205))
			end
		end
	end

	timer.Simple(1, function()
		if ply:IsValid() then
			ply:Spectate(OBS_MODE_ROAMING)
		end
	end)

	if alive == 0 then
		GAMEMODE.ZS.EndEvent()
	end
end

function GM.ZS.Hooks.PlayerDeathThink(ply)
	return false
end

function GM.ZS.Hooks.PlayerSpawn(ply)
	if GAMEMODE.ZS.ZombiesWaveActive then
		timer.Simple(0, function()
			ply:KillSilent()
			ply:Spectate(OBS_MODE_ROAMING)
		end)
	end
end

function GM.ZS.Hooks.PlayerShouldTakeDamage(ent, atk)
	if ent:IsPlayer() and atk:IsPlayer() then
		return false
	end
end

function GM.ZS.Hooks.EntityTakeDamage(ent, dmginfo)
	local atk = dmginfo:GetAttacker()

	if atk:IsPlayer() and ent.IsPropBarricade then
		dmginfo:SetDamage(0)
		return false
	end
end


function GM.ZS.Hooks.Think()
	if !GAMEMODE.ZS.ZombiesWaveActive and GAMEMODE:GetEventTimer() < CurTime() then
		GAMEMODE.ZS.ZombiesWaveActive = true
		GAMEMODE:SetEventTimer(CurTime() + GAMEMODE.ZS.WaveDuration*60)
		SetGlobalBool("GM.ZombieSpawning", true)
		GAMEMODE.ZombieApocalypse = true
		GAMEMODE:SystemBroadcast(Format("Zombies have inbound... Survive for %s minutes.", GAMEMODE.ZS.WaveDuration), Color(255,95,95), false)
	elseif GAMEMODE.ZS.ZombiesWaveActive and GAMEMODE:GetEventTimer() < CurTime() then
		GAMEMODE.ZS.ZombiesWaveActive = false
		GAMEMODE:SystemBroadcast("Zombies wave ended.", Color(255,95,95), false)
		GAMEMODE.ZS.EndEvent()

		GAMEMODE:SystemBroadcast("Survivors:", Color(145,255,125), false)
		for _,ply in pairs(player.GetAll()) do
			if ply:Alive() then
				GAMEMODE:SystemBroadcast(ply:Nick(), Color(145,255,185), false)
			end
		end
	end
end

