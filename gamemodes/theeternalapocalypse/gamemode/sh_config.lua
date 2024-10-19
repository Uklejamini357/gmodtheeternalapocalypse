-------- GAMEMODE CONFIG --------

GM.DataFolder = "theeternalapocalypse"

-- self explanatory. to edit xp requirement for levels go to shared.lua and edit function GetReqXP. Default: 40
GM.MaxLevel = 40

-- Additional number of levels needed per every prestige level. Default: 3
GM.LevelsPerPrestige = 3

-- Max zombies to spawn by natural spawns. Default: 45
GM.MaxZombies = 45

-- Max distance from players in hammer units zombies can spawn. Default: 6000
GM.MaxZombieSpawnDistance = 6000

-- Max distance from players that zombies can wander from nearest players. If zombies are too far away, they are removed. Default: 7000
GM.MaxZombieWanderingDistance = 7000

-- Should give ammo back that remain in clip?
-- If enabled, dropping weapon from inventory will give ammo that remains in clip, if having weapon.
-- Does not count for weapons that does not use any ammo
-- Default: true
GM.GiveAmmoOnDropWeapon = true

-- Minimal required player count for boss to spawn. Default: 3
GM.MinPlayersBossRequired = 3

-- Minimal required player count for airdrop event to be called. Default: 4
GM.MinPlayersAirdropRequired = 4

-- Play death sound if player dies. Default: true
GM.DeathSounds = true

-- Infection Level. Manipulates between many things if players are continously killing zombies. Default: true
GM.InfectionLevelEnabled = true

-- Infection Level gaining mul. Default: 1
GM.InfectionLevelGainMul = 1

-- Should infection level NOT decrease? Suggesting for setting to true if doing events. Default: false
GM.InfectionLevelShouldNotDecrease = false


-- How should Infection Level increasing work?
-- 1 = Killing zombies increases Infection Level, slowly decreases when no zombies are being killed.
-- Current level is saved between server restarts and infection shard increases infection level by +50%
-- (wip) 2 = Let players decide how much infection level should be globally, infection shard however increases infection level by +50%, with its' bonus slowly degrading.
-- (wip) 3 = Infection Level amount depends on online player count, but infection shard works like in 2.
-- (done) 4 = Infection Level amount depends on average player progression. (Only affects players who are online)
-- This makes it a good challenge for high prestige players. Infection Shard works just like in 2.

-- Currently Infection Shard is only usable when this value is 1
GM.InfectionLevelIncreaseType = 1


-- Should players lose XP if they die to zombie? Only 1% of their XP is lost, max of 250. Default: false
GM.PlayerLoseXPOnDeath = false

-- Should players drop their weapons when they die? Set false if making deathmatch for fun, doing an event or anything else in which you don't want anyone to lose their weapons. Default: true
GM.DropActiveWeaponOnDeath = true

-- Enable map cycling system for every maintenance. Map is rolled out before auto-maintenance. Default: false (Doesn't work yet)
GM.EnableMapCycleSystem = false

-- Maps to cycle through
GM.MapCycles = {
	"rp_pripyat_fixed",
	"gm_construct",
}

-- Enable Special events. Default: true (Doesn't work yet)
-- Info:
-- 1 - Zombie Fog: Limited Vision to 1500 hammer units, vision obscured by greenish fog, zombies defense increased by +20% and move 20% faster. Rewards increased.
-- 2 - Blood Moon: Vision turns more red and dark, zombie speed greatly increased (+60%), zombies deal +30% damage
-- 3 - Increased Infection Level gain from killing zombies by +50% and Infection Level does not decrease by its' own.
-- 4 - Horde Event: Zombie spawn rate decreased down to 2 seconds and zombies can see players 2.5x further.
GM.EnableSpecialEventsSystem = true

-- Weapon Damage Multiplier against zombies. Does not affect players!
GM.WeaponDamageVsZombiesMul = {
	["weapon_tea_punisher"] = 1.55,
	["m9k_intervention"] = 1.3,
}

-- Zombies don't target players if they're in trader area. This also means that they can't damage zombies to prevent farming! Default: false (not working)
GM.TraderAreaProtectsFromZombies = false

-- Rules for server. Please keep the default ones! (You can still change them)
GM.ServerRules = {
-- Default rules
	"You may not block off spawn area nor traders with your props. You can still build it as a fort against zombies.",
	"Do not block off loot spawns so that only you can access it. Unless you're building a base.",
	"Building a base just to claim airdrop spots is not allowed. You can still build near it, but not in it.",
	"Faction Base cores are only for basing and NOT for trolling, do NOT use the base core to kill players near spawn!",

-- Put your rules below

}

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
	["ZombieSpawnRate"] = 11,
	-- how fast the boss spawn timer will be run in seconds. Keep in mind that if there is less than 2 players online then the boss will not spawn
	["BossSpawnRate"] = 3150,
	-- same as boss spawn rate but for airdrops except required amount of players for an airdrop to spawn is 5 or more
	["AirdropSpawnRate"] = 4000,

	-- how much carry weight should we have by default (in kg)
	["MaxCarryWeight"] = 36.72,

	-- vault size in kg
	["VaultSize"] = 175,

	-- remember that the speed skill increases your walk speed by 3.5 for each level, so at 140 walkspeed players can reach a possible maximum of 175 walk speed
	["WalkSpeed"] = 155,
	-- speed skill increases your running speed by 7 per skill level, so if default is 280, players can reach max of 350 run speed
	["RunSpeed"] = 270,

	-- set to Legacy or PData
	-- legacy saves player data as text files under garrysmod/data/theeternalapocalypse/profiles/(players steamid)/
	-- Pdata saves their data to the servers sql file (garrysmod/sv.db)
	-- Use the pdata system if you are having issues with text file saving/loading or if you prefer everything to be in the sql file.
	-- No there isn't support for MySQL and there proably won't be unless you code it yourself.
	["FileSystem"] = "Legacy",
	
}


-----------------------------SKILLS CONFIG-----------------------------


GM.StatConfigs = {
	-- Keep this at max of 10!
	["Agility"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5, -- Max amount that can be applied for this skill is increased by this amount when having a perk "Empowered Skills"
	},

	-- Keep this at max of 10!
	["Barter"] = {
		Max = 10,
		Cost = 1,
	},

	-- Keep this at max of 10!
	["Defense"] = {
		Max = 10,
		Cost = 1,
	},

	-- Keep this at max of 10!
	["Endurance"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5,
	},

	-- Keep this at max of 10!
	["Engineer"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	["Gunslinger"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	-- Keep this at max of 10!
	["Immunity"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5,
	},

	["Knowledge"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	["MedSkill"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	["Salvage"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	-- Keep this at max of 10!
	["Scavenging"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},

	-- Keep this at max of 10!
	["Speed"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5,
	},

	["Strength"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5,
	},

	-- Keep this at max of 10!
	["Survivor"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 5,
	},

	["Vitality"] = {
		Max = 10,
		Cost = 1,
		PerkMaxIncrease = 10,
	},
}


-----------------------------ZOMBIE CLASSES-----------------------------

GM.Config["ZombieClasses"] = {
	["npc_tea_basic"] = {		-- table name must be the entclass name of the zombie, see garrysmod/gamemodes/theeternalapocalypse/entities for entclasses (or you can add other zombie types by yourself)
		Name = "Shambler Zombie",	-- Name for the zombie, used in death notice/killfeed
		SpawnChance = 66.75,	-- spawn chance in % (there is a helper function that will tell you how much the current total spawn chance for zombies is)
		XPReward = 48,		-- xp reward for killing this zombie, varies with the convar tea_server_xpreward convar
		MoneyReward = 22,	-- money reward for killing this zombie, varies with the convar tea_server_moneyreward convar
		InfectionRate = 0.03,	-- Infection Level increase if the zombie is killed by player (Affected by player count!)
		AllowEliteVariants = true,	-- Some zombies may not like being as elite variant as it confuses between colors - Only allow some! (By default, it's true)
		Miniboss = false,	-- If it is true, they are not spawned unless Infection Level is 25% or more, or if the player count is less than 3! Instead, they will be rerolled as a basic zombie.
		-- (in that case, if minibosses can't spawn then there is slightly higher chance for basics to spawn)
	},

	["npc_tea_leaper"] = {
		Name = "Leaper Zombie",
		SpawnChance = 18.75,
		XPReward = 55,
		MoneyReward = 30,
		InfectionRate = 0.035,
		AllowEliteVariants = true,
	},

	["npc_tea_wraith"] = {
		Name = "Wraith Zombie",
		SpawnChance = 5,
		XPReward = 80,
		MoneyReward = 45,
		InfectionRate = 0.048,
		AllowEliteVariants = true,
	},

	["npc_tea_tank"] = {
		Name = "Tank Zombie",
		SpawnChance = 4,
		XPReward = 220,
		MoneyReward = 90,
		InfectionRate = 0.07,
		AllowEliteVariants = true,
	},

	["npc_tea_puker"] = {
		Name = "Puker Zombie",
		SpawnChance = 2.25,
		XPReward = 240,
		MoneyReward = 105,
		InfectionRate = 0.062,
		AllowEliteVariants = true,
	},

	["npc_tea_lord"] = {
		Name = "Zombie Lord",
		SpawnChance = 1.5,
		XPReward = 450,
		MoneyReward = 320,
		InfectionRate = 0.135,
		AllowEliteVariants = true,
	},

	["npc_tea_tormented_wraith"] = {
		Name = "Tormented Wraith",
		SpawnChance = 1.25,
		XPReward = 185,
		MoneyReward = 150,
		InfectionRate = 0.1,
		AllowEliteVariants = true,
	},

	["npc_tea_superlord"] = {
		Name = "Zombie Superlord",
		SpawnChance = 0.2,
		XPReward = 850,
		MoneyReward = 700,
		InfectionRate = 0.35,
		AllowEliteVariants = true,
		Miniboss = true,
	},

	["npc_tea_heavy_tank"] = {
		Name = "Heavy Tank Zombie",
		SpawnChance = 0.15,
		XPReward = 750,
		MoneyReward = 650,
		InfectionRate = 0.4,
		AllowEliteVariants = true,
		Miniboss = true,
	},

	["npc_tea_hunter"] = {
		Name = "Hunter Zombie",
		SpawnChance = 0.15,
		XPReward = 750,
		MoneyReward = 650,
		InfectionRate = 0.4,
		AllowEliteVariants = true,
		Miniboss = true,
	},

}

-----------------------------BOSS CLASSES-----------------------------

GM.Config["BossClasses"] = {
	["npc_tea_boss_tyrant"] = {
		Name = "The Tyrant",	-- Name used in deathnotice for boss
		SpawnChance = 70,	-- Chance for the boss to be selected to spawn
		XPReward = 5000,	-- remember that xp and money for bosses is distributed by who damaged them, if you did all of the damage you would get 5,000 xp in this case
		MoneyReward = 4500,	-- same here
		SpawnDelay = 14,	-- how long to wait before actually spawning it, gives the radio message time to play out
		AnnounceMessage = "[BOSS]: The Tyrant has appeared!",	-- Announce the message when boss spawns in
		BroadCast = function(nonotify)	-- Call a function before boss spawns
			if !nonotify then
				GAMEMODE:RadioBroadcast(0, "This is an urgent broadcast on all bands!", "Watchdog", true)
				GAMEMODE:RadioBroadcast(4, "Siesmic readings are showing a massive quadruped approaching the area, most likely a tyrant.", "Watchdog", false)
				GAMEMODE:RadioBroadcast(8, "It is currently inbound for this sector, so you better get inside something solid and make sure you have good amount of ammo.", "Watchdog", false)
			end
		end,
		InfectionRate = 1.85,	-- Infection rate
		AllowEliteVariants = true,	-- Some bosses don't like being elite variants, so we only enable for some of them!
	},
	
	["npc_tea_boss_lordking"] = {
		Name = "Zombie Lord King",
		SpawnChance = 30,
		XPReward = 7500,
		MoneyReward = 6250,
		SpawnDelay = 15,
		AnnounceMessage = "[BOSS]: The Zombie Lord King has appeared!",
		BroadCast = function(nonotify)
			if !nonotify then
				GAMEMODE:RadioBroadcast(0, "This is an urgent broadcast for all the survivors out there!", "Watchdog", true)
				GAMEMODE:RadioBroadcast(4.5, "We have spotted a Mutated Lord Zombie, tougher than the other variants. It got an ability to teleport nearby zombies.", "Watchdog", false)
				GAMEMODE:RadioBroadcast(9, "It will arrive into the area, so prepare a good barricade, multiple layers of barricades and plenty of ammo.", "Watchdog", false)
			end
		end,
		InfectionRate = 2.125,
		AllowEliteVariants = true,
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
	["item_medkit"] = 2,
	["item_pistolammo"] = 3,
}

-- What new players will have in their vault
GM.Config["NewbieVault"] = {
	["weapon_tea_grenade_pipe"] = 2,
	["item_soda"] = 2,
	["item_potato"] = 1,
}


-- Vehicles don't exist, maybe they'll be added in next, future update or even never. (Consider this as unfinished for now)
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


-- Perks list.

GM.PerksList = {
	["healthboost"] = {
		Name = "Health boost I",
		Description = "Increase your max health by +5 points",
		Cost = 1,
		PrestigeReq = 1,
	},

	["healthboost2"] = {
		Name = "Health boost II",
		Description = "Increase your max health by +8 points",
		Cost = 2,
		PrestigeReq = 4,
	},

	["weightboost"] = {
		Name = "Weight boost I",
		Description = "Increase your max carrying capacity by +1.5kg",
		Cost = 1,
		PrestigeReq = 1,
	},

	["weightboost2"] = {
		Name = "Weight boost II",
		Description = "Increase your max carrying capacity by +2.5kg",
		Cost = 1,
		PrestigeReq = 4,
	},

	["weightboost3"] = {
		Name = "Heavyweight",
		Description = "Increase your max carrying capacity by +3.5kg and melee damage multiplier increased by 5%",
		Cost = 2,
		PrestigeReq = 7,
	},

	["xpboost"] = {
		Name = "XP gain boost I",
		Description = "Increase your XP gain rate by +10%",
		Cost = 2,
		PrestigeReq = 5,
	},

	["xpboost2"] = {
		Name = "XP gain boost II",
		Description = "Increase your XP gain rate by +15%",
		Cost = 4,
		PrestigeReq = 13,
	},

	["jumpboost"] = {
		Name = "Jump boost I",
		Description = "Increase your jump power by 10 units.",
		Cost = 1,
		PrestigeReq = 2,
	},

	["cashboost"] = {
		Name = "Cash gain boost I",
		Description = "Increase your cash gain rate by +5% from zombies.",
		Cost = 1,
		PrestigeReq = 2,
	},

	["cashboost2"] = {
		Name = "Cash gain boost II",
		Description = "Increase your cash gain rate by +8% from zombies.",
		Cost = 2,
		PrestigeReq = 5,
	},

	["skillpointsbonus"] = {
		Name = "Bonus skill points I",
		Description = "You start every prestige with additional 5 skill points.",
		AddDescription = "Also applies to current prestige. Resetting this perk takes away your skill points.\nIf skill points go negative whilst resetting this perk, your skills may get forcefully reset.",
		Cost = 1,
		PrestigeReq = 4,
		OnUnlock = function(ply)
			ply.StatPoints = tonumber(ply.StatPoints) + 5
		end,
		OnReset = function(ply)
			ply.StatPoints = tonumber(ply.StatPoints) - 5
			if ply.StatPoints < 0 then
				ply:SkillsReset()
			end
		end
	},

	["criticaldamage"] = {
		Name = "Critical Damage",
		Description = "Increased damage by 1.2x damage with 1 in 15 chance on inflicting damage.",
		Cost = 1,
		PrestigeReq = 4,
	},

	["skillpointsbonus2"] = {
		Name = "Bonus skill points II",
		Description = "You start every prestige with the additional skill points based on your current prestige.",
		AddDescription = "Also applies to current prestige. Resetting this perk takes away your skill points.\nIf skill points go negative whilst resetting this perk, your skills may get forcefully reset.",
		Cost = 2,
		PrestigeReq = 10,
		OnUnlock = function(ply)
			ply.StatPoints = tonumber(ply.StatPoints) + tonumber(ply.Prestige)
		end,
		OnReset = function(ply)
			ply.StatPoints = tonumber(ply.StatPoints) - tonumber(ply.Prestige)
			if ply.StatPoints < 0 then
				ply:SkillsReset()
			end
		end
	},

	["damageresistance"] = {
		Name = "Damage Resistance",
		Description = "-7.5% damage taken from all sources",
		Cost = 1,
		PrestigeReq = 6,
	},

	["celestiality"] = {
		Name = "Celestiality",
		Description = "+10% damage dealt to elite variant zombies. Otherwise, +3% damage to zombies. Does not affect bosses.",
		AddDescription = "Makes you feel slightly more powerful.",
		GetTextColor = function()
			return Color(255,255,215)
		end,
		KeepUpdatingColor = false,
		Cost = 2,
		PrestigeReq = 7,
	},

	["bountyhunter"] = {
		Name = "Bounty Hunter",
		Description = "You steal 50% of killed player's bounty. Hover for more info",
		AddDescription = "You steal 50% of killed player's bounty. This also makes killed player drop 50% less bounty as cash.\nKilling elite variants or bosses also give +15% cash bonus and +10% XP bonus.\nIf the boss zombie has elite variant, the bonus works twice as efficient.",
		Cost = 2,
		PrestigeReq = 7,
	},

	["enduring_endurance"] = {
		Name = "Enduring Endurance",
		Description = "Stamina regeneration is doubled and stamina drain is decreased when your stamina is below 25%",
		Cost = 1,
		PrestigeReq = 3,
	},

	["starting_ammunition"] = {
		Name = "Starting Ammo",
		Description = "You spawn with more ammo.",
		AddDescription = "You spawn with:\n200 Pistol ammo\n150 Rifle ammo\n100 buckhot ammo\n75 sniper ammo\n5 crossbow bolts",
		Cost = 1,
		PrestigeReq = 2,
	},

	["speedy_hands"] = {
		Name = "Handy Engineer",
		Description = "Gives big buffs for prop and Builder's Wrench",
		AddDescription = "Your unbuilt props take 20x damage instead of being destroyed instantly on being hit.\nBuilder's Wrench delay is decreased by 20% and spends less stamina.\nYour wrench builds props 1.5x faster.\nFlimsy Props are automatically built within 60 seconds (If they're not obstructed)\nYou salvage your props 2x faster.",
		Cost = 2,
		PrestigeReq = 6,
	},

	["bloodlust"] = { -- Not done
		Name = "Bloodlust",
		Description = "Heal 10% of your damage with melee.",
		AddDescription = "Beware, as the heal cap is quickly drained the more this is used in short time!",
		Cost = 1,
		PrestigeReq = 2,
	},

	["dead_luck"] = { -- Not done
		Name = "Dead luck",
		Description = "On death, you keep 80% of your ammo you had and you do not drop your active weapon outside PVP.",
		AddDescription = "In addition, you keep 40% of your bounty you had on death, minimum of 20 bounty is lost.\nYou still lose some of your bounty if killed by a player who has Bounty Hunter perk.",
		Cost = 1,
		PrestigeReq = 2,
	},

	["empowered_skills"] = {
		Name = "Empowered Skills",
		Description = "You can apply more skill points to the same skill, but cost is doubled if applying beyond normal limit",
		AddDescription = "On perks reset, your skills will be reset.",
		Cost = 3,
		PrestigeReq = 10,
		OnReset = function(ply)
			ply:SkillsReset()
		end
	},


}


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
