
function GM:OnConVarChanged(cvar, old, new)
	if SERVER then
		if tonumber(old) ~= tonumber(new) then
			PrintMessage(HUD_PRINTTALK, Format("ConVar '%s' value is changed from '%s' to '%s'", cvar, old, new))
		end
		print(Format("ConVar '%s' value is changed from '%s' to '%s'", cvar, old, new))
	end
end

GM.RespawnTime = CreateConVar("tea_server_respawntime", 15, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies respawn time for players. Warning: Do not set it too high or players won't be able to respawn. Set to 0 for no respawn delay. Recommended values: 10 - 20.", 0, 60):GetFloat()
cvars.AddChangeCallback("tea_server_respawntime", function(cvar,old,new)
	GAMEMODE.RespawnTime = tonumber(new)
	BroadcastLua(Format("GAMEMODE.RespawnTime = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_respawntime")

GM.CashGainMul = CreateConVar("tea_server_moneyreward", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Money gain rewards for killing zombies. This convar is dynamic (affects all zombies) and does not affect XP rewards for destroying faction structures. Useful for making events or modifying difficulty.", 0.1, 10):GetFloat()
cvars.AddChangeCallback("tea_server_moneyreward", function(cvar,old,new)
	GAMEMODE.CashGainMul = tonumber(new)
	BroadcastLua(Format("GAMEMODE.CashGainMul = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_moneyreward")

GM.XPGainMul = CreateConVar("tea_server_xpreward", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies XP gain multiplier for killing zombies. This convar is dynamic (affects all zombies) and does not affect Money rewards for destroying faction structures. Useful for making events or modifying difficulty.", 0.1, 10):GetFloat()
cvars.AddChangeCallback("tea_server_xpreward", function(cvar,old,new)
	GAMEMODE.XPGainMul = tonumber(new)
	BroadcastLua(Format("GAMEMODE.XPGainMul = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_xpreward")

GM.SpawnProtectionEnabled = CreateConVar("tea_server_spawnprotection", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should give players temporary damage invulnerability on spawn? Convar tea_server_spawnprotection_duration must be above 0 for it to work!", 0, 1):GetBool()
cvars.AddChangeCallback("tea_server_spawnprotection", function(cvar,old,new)
	GAMEMODE.SpawnProtectionEnabled = tobool(new)
	BroadcastLua(Format("GAMEMODE.SpawnProtectionEnabled = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_spawnprotection")

GM.SpawnProtectionDur = CreateConVar("tea_server_spawnprotection_duration", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How long should god mode after spawning last? (in seconds) Convar tea_server_spawnprotection is required for it to work!", 0, 10):GetFloat()
cvars.AddChangeCallback("tea_server_spawnprotection_duration", function(cvar,old,new)
	GAMEMODE.SpawnProtectionDur = math.floor(tonumber(new))
	BroadcastLua(Format("GAMEMODE.SpawnProtectionDur = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_spawnprotection_duration")

GM.VoluntaryPvP = CreateConVar("tea_server_voluntarypvp", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables whether players are free to pvp voluntarily or have forced PvP. If disabled, players will have forced PvP at any time. (Note: Factions don't have friendly fire)", 0, 1):GetBool()
cvars.AddChangeCallback("tea_server_voluntarypvp", function(cvar,old,new)
	GAMEMODE.VoluntaryPvP = tobool(new)
	BroadcastLua(Format("GAMEMODE.VoluntaryPvP = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_voluntarypvp")

GM.DebuggingModeClient = CreateConVar("tea_server_debugging_client", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables debugging features for clients. Note: This is a serverside convar.\
WARNING: YOU CAN ENABLE THIS FOR DEDICATED SERVER AS LONG AS YOU USE IT ONLY FOR TESTING PURPOSES.", 0, 4):GetInt()
cvars.AddChangeCallback("tea_server_debugging_client", function(cvar,old,new)
	GAMEMODE.DebuggingModeClient = tonumber(new)
	BroadcastLua(Format("GAMEMODE.DebuggingModeClient = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_debugging_client")

GM.DatabaseSaving = CreateConVar("tea_server_dbsaving", 1, {FCVAR_REPLICATED}, "Allow saving players' progress to database? It is recommended to keep this enabled, unless when testing something.", 0, 1):GetBool()
cvars.AddChangeCallback("tea_server_dbsaving", function(cvar,old,new)
	GAMEMODE.DatabaseSaving = tobool(new)
	BroadcastLua(Format("GAMEMODE.DatabaseSaving = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_dbsaving")

GM.BonusPerksEnabled = CreateConVar("tea_server_bonusperks", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should bonus XP and bonus Cash perks for special players be enabled?", 0, 1):GetBool()
cvars.AddChangeCallback("tea_server_bonusperks", function(cvar,old,new)
	GAMEMODE.BonusPerksEnabled = tobool(new)
	BroadcastLua(Format("GAMEMODE.BonusPerksEnabled = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_bonusperks")

GM.MaxCaches = CreateConVar("tea_config_maxcaches", 10, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many caches should there be at any given time?", 0, 250):GetInt()
cvars.AddChangeCallback("tea_config_maxcaches", function(cvar,old,new)
	GAMEMODE.MaxCaches = math.floor(tonumber(new))
	BroadcastLua(Format("GAMEMODE.MaxCaches = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_maxcaches")

GM.FactionCost = CreateConVar("tea_config_factioncost", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How much creating the faction should cost?", 0, 10000):GetInt()
cvars.AddChangeCallback("tea_config_factioncost", function(cvar,old,new)
	GAMEMODE.FactionCost = math.floor(tonumber(new))
	BroadcastLua(Format("GAMEMODE.FactionCost = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_factioncost")

GM.MaxProps = CreateConVar("tea_config_maxprops", 60, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many props can players create? Note: It's recommended to keep this on middle-low values, such as 75-125.", 0, 500):GetInt()
cvars.AddChangeCallback("tea_config_maxprops", function(cvar,old,new)
	GAMEMODE.MaxProps = math.floor(tonumber(new))
	BroadcastLua(Format("GAMEMODE.MaxProps = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_maxprops")

GM.PropCostEnabled = CreateConVar("tea_config_propcostenabled", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enable prop spawning cost money? Recommended to keep this on. Good for making events that needs props.", 0, 1):GetBool()
cvars.AddChangeCallback("tea_config_propcostenabled", function(cvar,old,new)
	GAMEMODE.PropCostEnabled = tobool(new)
	BroadcastLua(Format("GAMEMODE.PropCostEnabled = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_propcostenabled")

GM.FactionStructureCostEnabled = CreateConVar("tea_config_factionstructurecostenabled", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables whether spawning faction structures should cost money or not. Recommended to keep this on. Good for making events that needs faction structures.", 0, 1):GetBool()
cvars.AddChangeCallback("tea_config_factionstructurecostenabled", function(cvar,old,new)
	GAMEMODE.FactionStructureCostEnabled = tobool(new)
	BroadcastLua(Format("GAMEMODE.FactionStructureCostEnabled = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_factionstructurecostenabled")

--For this one, be sure to have good navmesh so zombies can navigate through the map!
GM.ZombieApocalypse = CreateConVar("tea_config_zombieapocalypse", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should zombies closest to players see them anywhere? WARNING: THIS ONLY WORKS FOR ZOMBIES MADE IN THE GAMEMODE AND MAY CAUSE LAG ON VERY LARGE MAPS!! Good for making event or mini-game like zombie survival or something.", 0, 1):GetBool()
cvars.AddChangeCallback("tea_config_zombieapocalypse", function(cvar,old,new)
	GAMEMODE.ZombieApocalypse = tobool(new)
	BroadcastLua(Format("GAMEMODE.ZombieApocalypse = %s", tobool(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombieapocalypse")

GM.ZombieHealthMultiplier = CreateConVar("tea_config_zombiehpmul", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Zombie Health for future spawned zombies. Best use with this is to increase XP and Cash gain multiplier as the convar value is higher. Useful for events or modifying difficulty.", 0.2, 5):GetFloat()
cvars.AddChangeCallback("tea_config_zombiehpmul", function(cvar,old,new)
	GAMEMODE.ZombieHealthMultiplier = tonumber(new)
	BroadcastLua(Format("GAMEMODE.ZombieHealthMultiplier = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombiehpmul")

GM.ZombieSpeedMultiplier = CreateConVar("tea_config_zombiespeedmul", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Zombies' speed, whether they should move faster or slower. NOTE: THIS ONLY WORKS WITH ZOMBIES THAT ARE MADE FOR THIS GAMEMDOE AND NOT MADE OUTSIDE OF THE GAMEMODE! Useful for events or modifying difficulty.", 0.4, 3):GetFloat()
cvars.AddChangeCallback("tea_config_zombiespeedmul", function(cvar,old,new)
	GAMEMODE.ZombieSpeedMultiplier = tonumber(new)
	BroadcastLua(Format("GAMEMODE.ZombieSpeedMultiplier = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombiespeedmul")

GM.PropSpawnTraderDistance = CreateConVar("tea_config_propspawndistance", 250, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how close can players spawn props from nearest trader", 0, 500):GetFloat()
cvars.AddChangeCallback("tea_config_propspawndistance", function(cvar,old,new)
	GAMEMODE.PropSpawnTraderDistance = tonumber(new)
	BroadcastLua(Format("GAMEMODE.PropSpawnTraderDistance = %s", tonumber(new)))
	GAMEMODE:OnConVarChanged(cvar, old, new)
end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_propspawndistance")


if CLIENT then

	GM.HUDEnabled = CreateClientConVar("tea_cl_hud", 1, true, false, "Enable The Eternal Apocalypse HUD", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_hud", function(cvar,old,new)
		GAMEMODE.HUDEnabled = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_hud")

	GM.HUDStyle = CreateClientConVar("tea_cl_hudstyle", 0, true, false, "Switch between HUD styles", 0, 2):GetInt()
	cvars.AddChangeCallback("tea_cl_hudstyle", function(cvar,old,new)
		GAMEMODE.HUDStyle = math.floor(tonumber(new))
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_hudstyle")

	GM.BossSound = CreateClientConVar("tea_cl_soundboss", 1, true, true, "Should play HL2 Stinger sound when boss appears?", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_soundboss", function(cvar,old,new)
		GAMEMODE.BossSound = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_soundboss")

	GM.DeathSoundEffectEnabled = CreateClientConVar("tea_cl_deathsfx", 1, true, true, "Play Sound Effect on dying?", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_deathsfx", function(cvar,old,new)
		GAMEMODE.DeathSoundEffectEnabled = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_deathsfx")

	GM.DeathSoundEffectVolume = CreateClientConVar("tea_cl_deathsfx_vol", 1, true, true, "How loud should be death sound effect?", 0, 1):GetFloat()
	cvars.AddChangeCallback("tea_cl_deathsfx_vol", function(cvar,old,new)
		GAMEMODE.DeathSoundEffectVolume = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_deathsfx_vol")

	GM.DeathSound = CreateClientConVar("tea_cl_deathsound", "theeternalapocalypse/gameover_music.wav", true, false, "Play sound effect on death. Use the valid sound or the sound effect will not play! Tip: Use string '*#' at start of convar string to play the sound as music"):GetString()
	cvars.AddChangeCallback("tea_cl_deathsound", function(cvar,old,new)
		GAMEMODE.DeathSound = tostring(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_deathsound")

	GM.HitSounds = CreateClientConVar("tea_cl_hitsounds", 1, true, true, "Play sound on dealing damage to zombies and players", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_hitsounds", function(cvar,old,new)
		GAMEMODE.HitSounds = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_hitsounds")

	GM.HitSoundsVolume = CreateClientConVar("tea_cl_hitsounds_vol", 0.3, true, true, "Volume ratio of playing hitsound when dealing damage to players", 0, 1):GetFloat()
	cvars.AddChangeCallback("tea_cl_hitsounds_vol", function(cvar,old,new)
		GAMEMODE.HitSoundsVolume = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_hitsounds_vol")

	GM.HitSoundsVolumeNPC = CreateClientConVar("tea_cl_hitsounds_volnpc", 0.225, true, true, "Volume ratio of playing hitsound when dealing damage to NPC's and nextbots", 0, 1):GetFloat()
	cvars.AddChangeCallback("tea_cl_hitsounds_volnpc", function(cvar,old,new)
		GAMEMODE.HitSoundsVolumeNPC = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_hitsounds_volnpc")

	GM.HUDDecimalValues = CreateClientConVar("tea_cl_huddec", 0, true, false, "Enables decimal values on HUD elements, mostly Stamina, Hunger, Thirst, etc.", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_huddec", function(cvar,old,new)
		GAMEMODE.HUDDecimalValues = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_huddec")

	GM.PlayLevelUpSound = CreateClientConVar("tea_cl_playlevelupsound", 1, true, true, "Play sound on level up?", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_playlevelupsound", function(cvar,old,new)
		GAMEMODE.PlayLevelUpSound = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_playlevelupsound")

	GM.UseReloadKeyToPickup = CreateClientConVar("tea_cl_usereloadtopickup", 0, true, true, "Enables whether reload key needs to be held while picking up an item", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_usereloadtopickup", function(cvar,old,new)
		GAMEMODE.UseReloadKeyToPickup = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_usereloadtopickup")

	GM.NoEarrings = CreateClientConVar("tea_cl_noearrings", 0, true, true, "Disables annoying sound when taking damage from explosions", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_noearrings", function(cvar,old,new)
		GAMEMODE.NoEarrings = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_noearrings")

	GM.DisableTips = CreateClientConVar("tea_cl_notips", 0, true, false, "Disables tips that are displayed in chat.", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_notips", function(cvar,old,new)
		GAMEMODE.DisableTips = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_notips")

	GM.DrawZombiesInfo = CreateClientConVar("tea_cl_drawzinfo", 0, true, false, "Draw zombie info? (Name, Health and its' purpose (or what does it do)) Currently not working", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_drawzinfo", function(cvar,old,new)
		GAMEMODE.DrawZombiesInfo = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_drawzinfo")

	GM.NoDisplayBountyTipMessage = CreateClientConVar("tea_cl_nobountytipmessage", 0, true, false, "Displays bounty tip message when you die with bounty.", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_nobountytipmessage", function(cvar,old,new)
		GAMEMODE.NoDisplayBountyTipMessage = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_nobountytipmessage")

	GM.EnableDamageNumbers = CreateClientConVar("tea_cl_damagenumber_enable", 1, true, false, "Enable damage numbers when damaging entity.", 0, 1):GetBool()
	cvars.AddChangeCallback("tea_cl_damagenumber_enable", function(cvar,old,new)
		GAMEMODE.EnableDamageNumbers = tobool(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_damagenumber_enable")

	GM.DamageNumberScale = CreateClientConVar("tea_cl_damagenumber_scale", 1, true, false, "", 0.5, 2):GetFloat()
	cvars.AddChangeCallback("tea_cl_damagenumber_scale", function(cvar,old,new)
		GAMEMODE.DamageNumberScale = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_damagenumber_scale")

	GM.DamageNumberSpeed = CreateClientConVar("tea_cl_damagenumber_speed", 1, true, false, "", 0.5, 2):GetFloat()
	cvars.AddChangeCallback("tea_cl_damagenumber_speed", function(cvar,old,new)
		GAMEMODE.DamageNumberSpeed = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_damagenumber_speed")

	GM.DamageNumberLifetime = CreateClientConVar("tea_cl_damagenumber_lifetime", 1, true, false, "", 0.5, 2):GetFloat()
	cvars.AddChangeCallback("tea_cl_damagenumber_lifetime", function(cvar,old,new)
		GAMEMODE.DamageNumberLifetime = tonumber(new)
		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_cl_damagenumber_lifetime")

else

	GM.DebuggingMode = CreateConVar("tea_server_debugging", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables debugging features. Use value '2' for advanced debug mode. Note: For client debugging mode, use tea_server_debugging_client convar.", 0, 4):GetInt()
	cvars.AddChangeCallback("tea_server_debugging", function(cvar,old,new)
		GAMEMODE.DebuggingMode = tonumber(new)
--		GAMEMODE:OnConVarChanged(cvar, old, new)
	end, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_debugging")

end

