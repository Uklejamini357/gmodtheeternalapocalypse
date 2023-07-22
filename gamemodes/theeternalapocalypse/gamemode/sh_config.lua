-------- GAMEMODE CONFIG --------

GM.DataFolder = "theeternalapocalypse"

-- self explanatory. to edit xp requirement for levels go to shared.lua and edit function GetReqXP
GM.MaxLevel = 40

-- Additional number of levels needed per every prestige level 
GM.LevelsPerPrestige = 3

-- i don't feel like i have to explain about this one
GM.MaxZombies = 45

-- Max distance from players in hammer units zombies can spawn
GM.MaxZombieSpawnDistance = 6000

-- Max distance from players that zombies can wander from nearest players. If zombies are too far away, they are removed.
GM.MaxZombieWanderingDistance = 7000

-- Should give ammo back that remain in clip?
-- If enabled, dropping weapon from inventory will give ammo that remains in clip, if having weapon.
-- Does not count for weapons that does not use any ammo
GM.GiveAmmoOnDropWeapon = true

-- Minimal required player count for boss to spawn
GM.MinPlayersBossRequired = 2

-- Minimal required player count for airdrop event to be called
GM.MinPlayersAirdropRequired = 5

GM.DeathSounds = true

-- Infection Level. Manipulates between many things if players are continously killing zombies.
GM.InfectionLevelEnabled = true

-- Infection Level gaining mul.
GM.InfectionLevelGainMul = 1

-- Should infection level NOT decrease? Suggesting for setting to true if doing events.
GM.InfectionLevelShouldNotDecrease = false

-- Should players lose XP if they die to zombie? Only 1% of their XP is lost.
GM.PlayerLoseXPOnDeath = true

-------- CONFIG --------

GM.Config = {
	-- Save debug logs once per every while?
	-- Logs will be found found in garrysmod/data/theeternalapocalypse/logs and can be sent to the developer to find and fix bugs in the gamemode
	-- NOTE: Also Logs, who uses admin commands.
	-- Will add separate logging system in future
	["DebugLogging"] = true,

	-- the 's' is added onto strings where needed, for example if you put the currency as "Dollar" it will come out as "Dollars" as needed
	["Currency"] = "Dollar",

	-- how much damage should doors endure (can be destroyed from zombies only)
	["DoorHealth"] = 150,
	-- time in seconds after doors being broken down, doors should reset
	["DoorResetTime"] = 120,

	-- time in hours after server started will restart map, in order to prevent lag
	["AutoMaintenanceTime"] = 12,
	-- amount of minutes after server started auto-maintenance sequence will restart map, to give players some time to get their base salvaged
	["AutoMaintenanceDelay"] = 15,

	-- people who are this level or below are considered Newbies (Note: this is being replaced to function PLAYER:IsNewbie(), see sh_player.lua)
--	["NewbieLevel"] = 10,
	-- what gun to give to players if they are under the Newbie level and if they lost their previous one
	["NewbieWeapon"] = "weapon_tea_noobcannon",
	-- How much money should new players have?
	["StartMoney"] = 500,

	-- fresh zombies will be spawned in every x seconds
	["ZombieSpawnRate"] = 8, -- increased due to new infection level system
	-- how fast the boss spawn timer will be run in seconds. Keep in mind that if there is less than 2 players online then the boss will not spawn
	["BossSpawnRate"] = 3150,
	-- same as boss spawn rate but for airdrops except required amount of players for an airdrop to spawn is 5 or more
	["AirdropSpawnRate"] = 4000,

	-- how much carry weight should we have by default (in kg)
	["MaxCarryWeight"] = 36.72,

	-- vault size in kg
	["VaultSize"] = 175,

	-- remember that the speed skill increases your walk speed by 3.5 for each level, so at 140 walkspeed players can reach a possible maximum of 175 walk speed
	["WalkSpeed"] = 135,
	-- speed skill increases your running speed by 7 per skill level, so if default is 280, players can reach max of 350 run speed
	["RunSpeed"] = 260,

	-- set to Legacy or PData
	-- legacy saves player data as text files under garrysmod/data/theeternalapocalypse/profiles/(players steamid)/
	-- Pdata saves their data to the servers sql file (garrysmod/sv.db)
	-- Use the pdata system if you are having issues with text file saving/loading or if you prefer everything to be in the sql file.
	-- No there isn't support for MySQL and there proably won't be unless you code it yourself.
	["FileSystem"] = "Legacy",
	
}


-----------------------------SKILLS CONFIG-----------------------------


GM.StatConfigs = {
	["Agility"] = {
		Max = 10,
		Cost = 1,
	},

	["Barter"] = {
		Max = 10,
		Cost = 1,
	},

	["Defense"] = {
		Max = 10,
		Cost = 1,
	},

	["Endurance"] = {
		Max = 10,
		Cost = 1,
	},

	["Engineer"] = {
		Max = 10,
		Cost = 1,
	},

	["Gunslinger"] = {
		Max = 10,
		Cost = 1,
	},

	["Immunity"] = {
		Max = 10,
		Cost = 1,
	},

	["Knowledge"] = {
		Max = 10,
		Cost = 1,
	},

	["MedSkill"] = {
		Max = 10,
		Cost = 1,
	},

	["Salvage"] = {
		Max = 10,
		Cost = 1,
	},

	["Scavenging"] = {
		Max = 10,
		Cost = 1
	},

	["Speed"] = {
		Max = 10,
		Cost = 1,
	},

	["Strength"] = {
		Max = 10,
		Cost = 1,
	},

	["Survivor"] = {
		Max = 10,
		Cost = 1,
	},

	["Vitality"] = {
		Max = 10,
		Cost = 1,
	},
}


-----------------------------ZOMBIE CLASSES-----------------------------

GM.Config["ZombieClasses"] = {
	["npc_tea_basic"] = {		-- table name must be the entclass name of the zombie, see garrysmod/gamemodes/theeternalapocalypse/entities for entclasses (or you can add other zombie types by yourself)
		Name = "Shambler Zombie",	-- Name for the zombie, used in death notice/killfeed
		SpawnChance = 66.8,	-- spawn chance in % (there is a helper function that will tell you how much the current total spawn chance for zombies is)
		XPReward = 48,		-- xp reward for killing this zombie, varies with the convar tea_server_xpreward convar
		MoneyReward = 22,	-- money reward for killing this zombie, varies with the convar tea_server_moneyreward convar
		InfectionRate = 0.03,	-- Infection Level increase if the zombie is killed by player (Affected by player count!)
	},

	["npc_tea_leaper"] = {
		Name = "Leaper Zombie",
		SpawnChance = 18.75,
		XPReward = 55,
		MoneyReward = 30,
		InfectionRate = 0.035,
	},

	["npc_tea_wraith"] = {
		Name = "Wraith Zombie",
		SpawnChance = 5,
		XPReward = 80,
		MoneyReward = 45,
		InfectionRate = 0.048,
	},

	["npc_tea_tank"] = {
		Name = "Tank Zombie",
		SpawnChance = 4,
		XPReward = 220,
		MoneyReward = 90,
		InfectionRate = 0.07,
	},

	["npc_tea_puker"] = {
		Name = "Puker Zombie",
		SpawnChance = 2.25,
		XPReward = 240,
		MoneyReward = 105,
		InfectionRate = 0.062,
	},

	["npc_tea_lord"] = {
		Name = "Zombie Lord",
		SpawnChance = 1.5,
		XPReward = 450,
		MoneyReward = 320,
		InfectionRate = 0.135,
	},

	["npc_tea_tormented_wraith"] = {
		Name = "Tormented Wraith",
		SpawnChance = 1.25,
		XPReward = 185,
		MoneyReward = 150,
		InfectionRate = 0.1,
	},

	["npc_tea_superlord"] = {
		Name = "Zombie Superlord",
		SpawnChance = 0.25,
		XPReward = 850,
		MoneyReward = 700,
		InfectionRate = 0.35,
	},

	["npc_tea_heavy_tank"] = {
		Name = "Heavy Tank Zombie",
		SpawnChance = 0.2,
		XPReward = 750,
		MoneyReward = 650,
		InfectionRate = 0.4,
	},

}

-----------------------------BOSS CLASSES-----------------------------

GM.Config["BossClasses"] = {
	["npc_tea_boss_tyrant"] = {
		Name = "The Tyrant",	-- Name used in deathnotice for boss
		SpawnChance = 60,
		XPReward = 5000, -- remember that xp and money for bosses is distributed by who damaged them, if you did all of the damage you would get 5,000 xp in this case
		MoneyReward = 4500,
		SpawnDelay = 14, -- how long to wait before actually spawning it, gives the radio message time to play out
		AnnounceMessage = "[BOSS]: The Tyrant has appeared!",
		BroadCast = function()
			GAMEMODE:RadioBroadcast(0.5, "This is an urgent broadcast on all bands!", "Watchdog", true)
			GAMEMODE:RadioBroadcast(4, "Siesmic readings are showing a massive quadruped approaching the area, most likely a tyrant.", "Watchdog", false)
			GAMEMODE:RadioBroadcast(8, "It is currently inbound for this sector, so you better get inside something solid and make sure you have good amount of ammo.", "Watchdog", false)
		end,
		InfectionRate = 1.85,
	},
	
	["npc_tea_boss_lordking"] = {
		Name = "Zombie Lord King",
		SpawnChance = 40,
		XPReward = 8000,
		MoneyReward = 6250,
		SpawnDelay = 15,
		AnnounceMessage = "[BOSS]: The Zombie Lord King has appeared!",
		BroadCast = function()
			GAMEMODE:RadioBroadcast(0.5, "This is an urgent broadcast for all the survivors out there!", "Watchdog", true)
			GAMEMODE:RadioBroadcast(4.5, "We have spotted a Mutated Lord Zombie, tougher than the other variants. It got an ability to teleport nearby zombies.", "Watchdog", false)
			GAMEMODE:RadioBroadcast(9, "It will arrive into the area, so prepare a good barricade, multiple layers of barricades and plenty of ammo.", "Watchdog", false)
		end,
		InfectionRate = 2.125,
	},
}


-----------------------------Newbie GEAR-----------------------------

-- what to give to players when they join the server for the first time

GM.Config["NewbieGear"] = {
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
GM.Config["NewbieVault"] = {
	["weapon_tea_grenade_pipe"] = 2,
	["item_soda"] = 1,
}


-- Vehicles don't exist, maybe they'll be added in next, future update or even never
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


-- IN PROGRESS, DO NOT EDIT. IT'S STILL NOT WORKING.
-- MORE WILL BE ADDED SOON. MOSTLY FROM PRESTIGE PERKS.
/*
GM.PerksList = {
	["healthbonus"] = {
		Name = "Health bonus",
		Decription = "Increase your max health by +5",
		Cost = 1,
		PrestigeReq = 1,
	},
}
*/

-- Default player models, in other words, what new players look like before they buy armor
GM.DefaultModels = {
	"models/player/kleiner.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_06.mdl",
	"models/player/breen.mdl",
	"models/player/Eli.mdl",
	"models/player/mossman.mdl",
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
