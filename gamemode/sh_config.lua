-------- GAMEMODE CONFIG --------

GM.DataFolder = "theeternalapocalypse"
GM.MaxLevel = 50	-- self explanatory. to edit xp requirement for levels go to shared.lua and edit function GetReqXP
GM.LevelsPerPrestige = 5	-- Additional number of levels needed per every prestige level 
GM.MaxZombies = 45	-- i think i don't have to explain about this one
GM.MaxZombieSpawnDistance = 6000	-- Max distance from players in hammer units zombies can spawn
GM.MaxZombieWanderingDistance = 7000	-- Max distance from players that zombies can wander from nearest players. If zombies are too far away, they are removed.
GM.GiveAmmoOnDropWeapon = true -- Should give ammo back that remain in clip?
-- If enabled, dropping weapon from inventory will give ammo that remains in clip, if having weapon.
-- Does not count for weapons that does not use any ammo


-------- CONFIG --------

GM.Config = {
	["DebugLogging"] = true, -- Save debug logs once per every while?
-- Logs will be found found in garrysmod/data/theeternalapocalypse/logs and can be sent to the developer to find and fix bugs in the gamemode
-- NOTE: Also Logs, who uses admin commands.
-- Will add separate logging system in future

	["Currency"] = "Dollar",	-- the 's' is added onto strings where needed, for example if you put the currency as "Dollar" it will come out as "Dollars" as needed

	["DoorHealth"] = 150,	-- how much damage should doors endure (can be destroyed from zombies only)
	["DoorResetTime"] = 120,	-- time in seconds after doors being broken down, doors should reset

	["AutoMaintenanceTime"] = 12,	-- amount of hours after server started will restart map, in order to prevent lag
	["AutoMaintenanceDelay"] = 15,	-- amount of minutes after server started auto-maintenance sequence will restart map, probably to give players some time to get their base salvaged and such

	["RookieLevel"] = 10,	-- people who are this level or below are considered Rookies
	["RookieWeapon"] = "weapon_tea_noobcannon",	-- what gun to give to players if they are under the Rookie level and if they lost their previous one
	["StartMoney"] = 500,	-- How much money should new players have?

	["ZombieSpawnRate"] = 14,	-- fresh zombies will be spawned in every x seconds
	["BossSpawnRate"] = 3150,	-- how fast the boss spawn timer will be run in seconds (3600 seconds = 1 hour). Keep in mind that if there is less than 2 players online then the boss will never spawn unless summoned by tea_admin_spawnboss
	["AirdropSpawnRate"] = 4000,	-- same as boss spawn rate but for airdrops except required amount of players for an airdrop to spawn is 5 or more

	["MaxCarryWeight"] = 36.72,	-- how much carry weight should we have by default (in kg)
	["VaultSize"] = 175, --	vault size in kg

	["WalkSpeed"] = 135,	--	remember that the speed skill increases your walk speed by 3.5 for each level, so at 140 walkspeed players can reach a possible maximum of 175 walk speed
	["RunSpeed"] = 260,	--	speed skill increases your running speed by 7 per skill level, so if default is 280, players can reach max of 350 run speed
	["FileSystem"] = "Legacy" --	set to Legacy or PData
-- legacy saves player data as text files under garrysmod/data/theeternalapocalypse/profiles/(players steamid)/
-- Pdata saves their data to the servers sql file (garrysmod/sv.db)
-- Use the pdata system if you are having issues with text file saving/loading or if you prefer everything to be in the sql file.
-- No there isn't support for MySQL and there proably won't be unless you code it yourself.

-- Excluded due to feature of convars
}

-------- STAT CONFIG --------

-- THIS DOES NOT WORK YET!!
-- Still working on it
GM.StatConfig = {
-- effectivenesses for skills (per point)

	["Agility_eff1"] = 2,	-- jump power (in units) for Agility
	["Agility_eff2"] = 0.1,	-- 
	["Barter_eff1"] = 0.5,	-- Item Sell Price bonus (in %)
	["Barter_eff2"] = 1.5,	-- Item Buying discount bonus (in %)
	["Damage_eff1"] = 1,	-- Dammage multiplier (in %)
	["Defense_eff1"] = 1.5,	-- Normal Damage Resistance (in %)
	["Defense_eff2"] = 1,	-- Environmental Damage Resistance (in %)
	["Endurance_eff1"] = 0.01,	-- idk
	["Engineer_eff1"] = 3,	-- repaired hp with wrench (in units)
	["Immunity_eff2"] = 4,	-- decreasing multiplier of increasing infection (in %)
	["Knowledge_eff1"] = 1.5,	-- XP gain in %
	["MedSkill_eff1"] = 1,	-- idk
	["MedSkill_eff2"] = 1,	-- idk
	["Salvage_eff1"] = 2,	-- Cash gain in %
}


-----------------------------ZOMBIE CLASSES-----------------------------

GM.Config["ZombieClasses"] = {
	["npc_tea_basic"] = {		-- table name must be the entclass name of the zombie, see garrysmod/gamemodes/theeternalapocalypse/entities for entclasses (or you can add other zombie types by yourself)
		["Name"] = "Shambler Zombie",	-- Name for the zombie, used in death notice/killfeed
		["SpawnChance"] = 67,	-- spawn chance in %, be careful as the spawn chance of all your zombies totalled up must not exceed 100% (there is a helper function that will tell you if this has happened or how much the current total spawn chance for zombies is)
		["XPReward"] = 48,		-- xp reward for killing this zombie, varies with the convar tea_server_xpreward convar
		["MoneyReward"] = 22,	-- money reward for killing this zombie, varies with the convar tea_server_moneyreward convar
	},

	["npc_tea_leaper"] = {
		["Name"] = "Leaper Zombie",
		["SpawnChance"] = 18.75,
		["XPReward"] = 55,
		["MoneyReward"] = 30,
	},

	["npc_tea_wraith"] = {
		["Name"] = "Wraith Zombie",
		["SpawnChance"] = 5,
		["XPReward"] = 80,
		["MoneyReward"] = 45,
	},

	["npc_tea_tank"] = {
		["Name"] = "Tank Zombie",
		["SpawnChance"] = 4,
		["XPReward"] = 220,
		["MoneyReward"] = 90,
	},

	["npc_tea_puker"] = {
		["Name"] = "Puker Zombie",
		["SpawnChance"] = 2.25,
		["XPReward"] = 240,
		["MoneyReward"] = 105,
	},

	["npc_tea_lord"] = {
		["Name"] = "Zombie Lord",
		["SpawnChance"] = 1.5,
		["XPReward"] = 430,
		["MoneyReward"] = 310,
	},

	["npc_tea_tormented_wraith"] = {
		["Name"] = "Tormented Wraith",
		["SpawnChance"] = 1.25,
		["XPReward"] = 185,
		["MoneyReward"] = 150,
	},

	["npc_tea_superlord"] = {
		["Name"] = "Zombie Superlord",
		["SpawnChance"] = 0.25,
		["XPReward"] = 850,
		["MoneyReward"] = 700,
	},

}

-----------------------------BOSS CLASSES-----------------------------

GM.Config["BossClasses"] = {
	["npc_tea_boss_tyrant"] = {
		["Name"] = "The Tyrant",	-- Name used in deathnotice for boss
		["SpawnChance"] = 60,
		["XPReward"] = 5000, -- remember that xp and money for bosses is distributed by who damaged them, if you did all of the damage you would get 5,000 xp in this case
		["MoneyReward"] = 4500,
		["SpawnDelay"] = 14, -- how long to wait before actually spawning it, gives the radio message time to play out
		["AnnounceMessage"] = "[BOSS]: The Tyrant has appeared!",
		["BroadCast"] = function()
			RadioBroadcast(0.5, "This is an urgent broadcast on all bands!", "Watchdog", true)
			RadioBroadcast(4, "Siesmic readings are showing a massive quadruped approaching the area, most likely a tyrant.", "Watchdog", false)
			RadioBroadcast(8, "It is currently inbound for this sector, so you better get inside something solid and make sure you have good amount of ammo.", "Watchdog", false)
		end,
	},
	
	["npc_tea_boss_lordking"] = {
		["Name"] = "Zombie Lord King",
		["SpawnChance"] = 40,
		["XPReward"] = 8000,
		["MoneyReward"] = 6250,
		["SpawnDelay"] = 15,
		["AnnounceMessage"] = "[BOSS]: The Zombie Lord King has appeared!",
		["BroadCast"] = function()
			RadioBroadcast(0.5, "This is an urgent broadcast for all the survivors out there!", "Watchdog", true)
			RadioBroadcast(4.5, "We have spotted a Mutated Lord Zombie, tougher than the other variants. It got an ability to teleport nearby zombies.", "Watchdog", false)
			RadioBroadcast(9, "It will arrive into the area, so prepare a good barricade, multiple layers of barricades and plenty of ammo.", "Watchdog", false)
		end,
	},
}


-----------------------------ROOKIE GEAR-----------------------------

-- what to give to players when they join the server for the first time

GM.Config["RookieGear"] = {
	-- behold the beautiful new inventory format (yes)
	["item_bandage"] = 3,
	["item_antidote"] = 2,
	["item_bed"] = 1,
	["item_tinnedfood"] = 2,
	["weapon_tea_noobcannon"] = 1,
	["item_soda"] = 1,
	["item_medkit"] = 1,
	["item_pistolammo"] = 3,
}

-- What new players will have in their vault
GM.Config["RookieVault"] = {
	["weapon_tea_grenade_pipe"] = 2,
	["item_soda"] = 1,
}


-- Vehicles don't exist, maybe they'll be added in next, future update or never
GM.Config["Vehicles"] = {
	["Basic Hatchback (Yellow)"] = {
		["Health"] = 1000,
		["Description"] = "A basic hatchback, not the fastest or the strongest but it'll get you there (eventually)",
		["Seats"] = 2,
		["Fuel"] = 1000,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin1.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 5,
		},
	},

	["Basic Hatchback (Red)"] = {
		["Health"] = 1000,
		["Description"] = "A basic hatchback, not the fastest or the strongest but it'll get you there (eventually)",
		["Seats"] = 2,
		["Fuel"] = 1000,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin0.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 5,
		},
	},

	["Large Sedan"] = {
		["Health"] = 1375,
		["Description"] = "A large, rather slow sedan that can carry 4 people",
		["Seats"] = 4,
		["Fuel"] = 1500,
		["Model"] = "models/source_vehicles/car005a.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 8,
		},
	},

	["Hotrodded Hatchback (yellow)"] = {
		["Health"] = 1250,
		["Description"] = "A tougher, faster version of the standard hatchback",
		["Seats"] = 2,
		["Fuel"] = 1250,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin0.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_large"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 2,
			["item_craft_oil"] = 2,
			["item_scrap"] = 5,
		},
	},
}


----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------ADMIN CHECKS-----------------------------------------------------------
-------- I'm creating these functions here so that you can alter the checks to suit your own servers ranking system --------
--  Superadmins can use any commands however, admins only have the ate_admin_clearzombies and spawn boss/airdrop command  --
----------------------------------------------------------------------------------------------------------------------------

-- Add your steamid or your steamid64 here. This must be edited in order to use Dev Commands!
function TEASVOwnerCheck(ply) -- use either your steamid64 or steamid. example: [[ply:SteamID64() == {your steam id here}]]
	if !ply:IsValid() then return false end
	if ply:SteamID64() == "76561198274314803" then return true end
	return false
end

--Dev Check function will also impact other function checks so be sure you know what you are doing
function TEADevCheck(ply)
	if !ply:IsValid() then return false end
	if ply:SteamID64() == "76561198274314803" or ply:SteamID64() == "76561198028288732" or TEASVOwnerCheck(ply) then return true end
	return false --check will only work for dev, regardless of players' ranks (unless they're owner)
end

function SuperAdminCheck(ply)
	if !ply:IsValid() then return false end
	if ply:IsUserGroup("superadmin") or ply:IsSuperAdmin() or TEADevCheck(ply) then return true end
	return false -- above check failed so they are not superadmin
end

function AdminCheck(ply)
	if !ply:IsValid() then return false end
	if ply:IsUserGroup("admin") or ply:IsAdmin() or SuperAdminCheck(ply) then return true end
	return false
end
