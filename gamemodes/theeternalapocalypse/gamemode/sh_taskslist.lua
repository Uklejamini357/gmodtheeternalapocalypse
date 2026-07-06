-------- Tasks list --------
-- just adding new tasks won't work - you need good lua skills in order for it to work
-- NOTE: This is still work in progress!

GM.Tasks = {

	["zombie_killer"] = {
		Name = "Kill zombies", -- Name of a task
		Description = "Kill 65 zombies", -- Description of a task and what should we do to complete it
		RewardText = "950XP & 600$", -- Text for a reward (display for client)
		Cooldown = TIME_HOUR * 4, -- Cooldown before taking a new task after completing this task
		ReqProgress = 65, -- Needed progress to complete task
		LevelReq = 5, -- Level required to assign a task
		Callback = function(ply) -- calls a LUA function callback after completing task - Here, you need good Lua coding skills
			ply.XP = ply.XP + 950
			ply.Money = ply.Money + 600
			ply:SystemMessage("You gained 950 XP and 600 cash for completing a task!", Color(180,255,255))
		end
	},

	["loot_finder"] = {
		Name = "Loot Finder",
		Description = "Find 10 loot caches.",
		RewardText = "1250XP & 800$",
		Cooldown = TIME_HOUR * 6,
		ReqProgress = 10,
		LevelReq = 10,
		Callback = function(ply)
			ply.XP = ply.XP + 1250
			ply.Money = ply.Money + 800
			ply:SystemMessage("You gained 1250 XP and 800 cash for completing a task!", Color(180,255,255))
		end
	},

	["elite_problem"] = {
		Name = "Elite Problem",
		Description = "Kill 5 elite zombie variants.",
		RewardText = "1550XP & 1150$",
		Cooldown = TIME_HOUR * 12,
		ReqProgress = 5,
		LevelReq = 16,
		Callback = function(ply)
			ply.XP = ply.XP + 1550
			ply.Money = ply.Money + 1150
			ply:SystemMessage("You gained 1550 XP and 1150 cash for completing a task!", Color(180,255,255))
		end
	},

	["boss_hunter"] = {
		Name = "Boss Hunter",
		Description = "Kill 1 boss zombie. (At least 5% damage dealt to boss is required)",
		RewardText = "2000XP, 1500$ & 1x Army Medkit",
		Cooldown = TIME_HOUR * 16,
		ReqProgress = 1,
		LevelReq = 18,
		Callback = function(ply)
			ply.XP = ply.XP + 2000
			ply.Money = ply.Money + 1500
			gamemode.Call("SystemGiveItem", ply, "item_armymedkit", 1)
			GAMEMODE:SendInventory(ply)
			ply:SystemMessage("You gained 2000 XP, 1500 cash and 1x Army Medkit for completing a task!", Color(180,255,255))
		end
	},

	["medical_attention"] = {
		Name = "Medical Attention",
		Description = "Heal other players 3 times using an item.",
		RewardText = "1550XP, 1150$ & 1x Army Medkit",
		Cooldown = TIME_HOUR * 6,
		ReqProgress = 3,
		LevelReq = 16,
		Callback = function(ply)
			ply.XP = ply.XP + 1550
			ply.Money = ply.Money + 1150
			gamemode.Call("SystemGiveItem", ply, "item_armymedkit", 1)
			GAMEMODE:SendInventory(ply)
			ply:SystemMessage("You gained 1550 XP, 1150 cash and 1x Army Medkit for completing a task!", Color(180,255,255))
		end
	},


}

do return end


local easy = 1
local medium = 2
local hard = 3
local expert = 4
local insane = 5

GM.Tasks = {
	["zombie_killer"] = {
		Name = "Kill zombies", -- Name of a task
		Description = "Lately, there have been too many zombies in this area. I would hunt them down, but I'm not risking my life for this. Would you be able to kill the zombies for me? You will be rewarded.", -- Description of the task
		Objective = "Kill %d zombies.", -- What should we do to complete the task (can also be specified in the difficulties table to override objective)
		Difficulties = { -- Difficulty levels for the task. Each difficulty has different requirements for accepting and completing the task, yet also has different rewards!
			{
				Name = "Easy",
				RewardText = "550XP & 300$", -- Text for a reward (displaying only for client)
				Cooldown = TIME_HOUR * 2, -- Cooldown before taking a new task after completing this task (any difficulty)
				ReqProgress = 35, -- Needed progress to complete task on selected difficulty. (Can also be used for tables, indicating more than 1 thing to do.)
				LevelReq = 3, -- Level required to assign a task
			},
			{
				Name = "Medium",
				RewardText = "950XP & 600$",
				Cooldown = TIME_HOUR * 4,
				ReqProgress = 75,
				LevelReq = 11,
			},
			{
				Name = "Hard",
				RewardText = "2000XP, 900$ & 1x Kevlar Plate",
				Cooldown = TIME_HOUR * 9,
				ReqProgress = 170,
				LevelReq = 23,
			},
			{
				Name = "Expert",
				Objective = "Kill %d zombies, and kill %d zombies above level 20.",
				RewardText = "3500XP, 1350$, 1x Kevlar Plate & 2x Trader's Special",
				Cooldown = TIME_HOUR * 16,
				ReqProgress = {280, 20},
				LevelReq = 28,
				PrestigeReq = 1,
			},
			{
				Name = "Insane",
				Objective = "Kill %d zombies, and kill %d zombies above level 30.",
				RewardText = "6500XP, 2500$, 1x Medical Bag Enhanced & +5% XP boost for 1 hour",
				Cooldown = TIME_HOUR * 24,
				ReqProgress = {500, 50},
				LevelReq = 34,
				PrestigeReq = 3,
			},
		},
		Callback = function(ply, difficulty) -- calls a LUA function callback after completing task - Here, you need good Lua coding skills
			if difficulty == insane then
				ply.XP = ply.XP + 6500
				ply.Money = ply.Money + 2500
				gamemode.Call("SystemGiveItem", ply, "item_medbag_enhanced", 1)
				GAMEMODE:SendInventory(ply)
				ply.AddXPMuls[#ply.AddXPMuls+1] = {0.05, os.time() + 3600}
				
				ply:SystemMessage("", Color(180,255,255))
			elseif difficulty == expert then
				ply.XP = ply.XP + 6500
				ply.Money = ply.Money + 2500
				gamemode.Call("SystemGiveItem", ply, "item_armorkevlar", 1)
				gamemode.Call("SystemGiveItem", ply, "item_traderfood", 2)
				GAMEMODE:SendInventory(ply)

				ply:SystemMessage("", Color(180,255,255))
			elseif difficulty == hard then
				ply.XP = ply.XP + 6500
				ply.Money = ply.Money + 2500
				gamemode.Call("SystemGiveItem", ply, "item_armorkevlar", 1)
				GAMEMODE:SendInventory(ply)

				ply:SystemMessage("You gained 2000 XP, 900 cash and 1x Kevlar Plate for completing this task!", Color(180,255,255))
			elseif difficulty == medium then
				ply.XP = ply.XP + 950
				ply.Money = ply.Money + 600
				ply:SystemMessage("You gained 950 XP and 600 cash for completing this task!", Color(180,255,255))
			elseif difficulty == easy then
				ply.XP = ply.XP + 550
				ply.Money = ply.Money + 300
				ply:SystemMessage("You gained 550 XP and 300 cash for completing this task!", Color(180,255,255))
			end
		end
	},

	["loot_finder"] = {
		Name = "Loot Finder",
		Description = "Find loot caches.",
		Objective = "Find %d loot caches.",
		Difficulties = {
			{
				Name = "Easy",
				RewardText = "450XP & 120$",
				Cooldown = TIME_HOUR * 3,
				ReqProgress = 5,
				LevelReq = 3,
			},
			{
				Name = "Medium",
				RewardText = "875XP & 250$",
				Cooldown = TIME_HOUR * 7,
				ReqProgress = 10,
				LevelReq = 8,
			},
			{
				Name = "Hard",
				Objective = "Find %d loot caches, and %d loot caches above \"Uncommon\" rarity.",
				RewardText = "1800XP, 400$ & 1x Hotdog",
				Cooldown = TIME_HOUR * 9,
				ReqProgress = {20, 8},
				LevelReq = 25,
			},
			{
				Name = "Expert",
				Objective = "Find %d loot caches, and %d loot caches above \"Rare\" rarity.",
				RewardText = "2500XP, $, 1x Kevlar Plate & 2x Trader's Special",
				Cooldown = TIME_HOUR * 16,
				ReqProgress = {35, 4},
				LevelReq = 33,
				PrestigeReq = 1,
			},
			{
				Name = "Insane",
				Objective = "Find %d loot caches, %d loot caches above \"Rare\" rarity, and %d loot caches above \"Epic\" rarity.",
				RewardText = "6500XP, 2500$, 1x Medical Bag Enhanced & +5% XP boost for 1 hour",
				Cooldown = TIME_HOUR * 24,
				ReqProgress = {55, 7, 2},
				LevelReq = 37,
				PrestigeReq = 3,
			},
		},
		Callback = function(ply, difficulty)
			ply.XP = ply.XP + 1250
			ply.Money = ply.Money + 800
			ply:SystemMessage("You gained 1250 XP and 800 cash for completing this task!", Color(180,255,255))
		end
	},

	["elite_problem"] = {
		Name = "Elite Problem",
		Description = "I've heard that some survivors have been spotting the elite zombies recently. They're often more dangerous, although for weak zombies they aren't a big problem. Until a strong zombie appears and it's an Elite Hunter Zombie, that is a problem! I am looking for a survivor to handle these zombies, and you seem to be the right person to handle this situation. Are you up for this assignment, survivor? Your efforts won't go to waste.",
		Objective = "Kill %d elite variant zombies.",
		Difficulties = {
			{
				Name = "Easy",
				RewardText = "550XP & 300$",
				Cooldown = TIME_HOUR * 2,
				ReqProgress = 35,
				LevelReq = 3,
			},
			{
				Name = "Medium",
				RewardText = "950XP & 600$",
				Cooldown = TIME_HOUR * 4,
				ReqProgress = 75,
				LevelReq = 11,
			},
			{
				Name = "Hard",
				RewardText = "2000XP, 900$ & 1x Kevlar Plate",
				Cooldown = TIME_HOUR * 9,
				ReqProgress = 170,
				LevelReq = 28,
			},
			{
				Name = "Expert",
				RewardText = "3500XP, 1350$, 1x Kevlar Plate & 2x Trader's Special",
				Cooldown = TIME_HOUR * 16,
				ReqProgress = 280,
				LevelReq = 17,
				PrestigeReq = 1,
			},
			{
				Name = "Insane",
				RewardText = "6500XP, 2500$, 1x Medical Bag Enhanced & +5% XP boost for 1 hour",
				Cooldown = TIME_HOUR * 24,
				ReqProgress = 500,
				LevelReq = 26,
				PrestigeReq = 3,
			},
		},
		Callback = function(ply, difficulty)
			ply.XP = ply.XP + 1550
			ply.Money = ply.Money + 1150
			ply:SystemMessage("You gained 1550 XP and 1150 cash for completing this task!", Color(180,255,255))
		end
	},

	["boss_hunter"] = {
		Name = "Boss Hunter",
		Description = "",
		Objective = "",
		Difficulties = {
			{
				Name = "Hard",
				Objective = "Kill a boss zombie. (With at least 10% damage)",
				RewardText = "1550XP & 600$",
				Cooldown = TIME_HOUR * 12,
				ReqProgress = 1,
				LevelReq = 17,
			},
			{
				Name = "Challenging",
				Objective = "Kill 2 boss zombies. (Each with at least 10% damage)",
				RewardText = "2500XP, 1300$ & 5x Assault Rifle ammo",
				Cooldown = TIME_HOUR * 24,
				ReqProgress = 2,
				LevelReq = 25,
				PrestigeReq = 1,
			},
			{
				Name = "Expert",
				Objective = "Kill an elite variant boss zombie. (With at least 10% damage)",
				RewardText = "4000XP, 1000$ & 3x RPG Rocket",
				Cooldown = TIME_HOUR * 30,
				ReqProgress = 1,
				LevelReq = 38,
				PrestigeReq = 2,
			},
		},
		Callback = function(ply, difficulty)
			ply.XP = ply.XP + 2000
			ply.Money = ply.Money + 1500
			gamemode.Call("SystemGiveItem", ply, "item_armymedkit", 1)
			GAMEMODE:SendInventory(ply)
			ply:SystemMessage("You gained 2000 XP, 1500 cash and 1x Army Medkit for completing this task!", Color(180,255,255))
		end
	},

	["medical_attention"] = {
		Name = "Medical Attention",
		Description = "",
		Objective = "Heal %d health to other players.",
		Difficulties = {
			{
				Name = "Easy",
				RewardText = "500XP & 100$",
				Cooldown = TIME_HOUR * 3,
				ReqProgress = 55,
				LevelReq = 5,
			},
			{
				Name = "Medium",
				RewardText = "950XP & 600$",
				Cooldown = TIME_HOUR * 8,
				ReqProgress = 150,
				LevelReq = 12,
			},
			{
				Name = "Hard",
				Objective = "Heal %d health to other players, and cure infection from players %d times.",
				RewardText = "2000XP, 900$ & 1x Kevlar Plate",
				Cooldown = TIME_HOUR * 15,
				ReqProgress = {350, 2},
				LevelReq = 29,
			},
		},
		Callback = function(ply, difficulty)
			ply.XP = ply.XP + 1550
			ply.Money = ply.Money + 1150
			gamemode.Call("SystemGiveItem", ply, "item_armymedkit", 1)
			GAMEMODE:SendInventory(ply)
			ply:SystemMessage("You gained 1550 XP, 1150 cash and 1x Army Medkit for completing this task!", Color(180,255,255))
		end
	},

	["high_on_bounty"] = {
		Name = "High on bounty",
		Description = "",
		Objective = "Cash in at %d bounty.",
		Difficulties = {
			{
				Name = "Easy",
				RewardText = "350XP & 100$",
				Cooldown = TIME_HOUR * 1,
				ReqProgress = 1000,
				LevelReq = 6,
			},
			{
				Name = "Medium",
				RewardText = "950XP & 250$",
				Cooldown = TIME_HOUR * 4,
				ReqProgress = 2500,
				LevelReq = 13,
			},
			{
				Name = "Hard",
				RewardText = "2000XP, 400$ & ",
				Cooldown = TIME_HOUR * 9,
				ReqProgress = 6500,
				LevelReq = 28,
			},
			{
				Name = "Expert",
				RewardText = "3500XP, 500$ & 1x Dammerung Assault Shotgun",
				Cooldown = TIME_HOUR * 16,
				ReqProgress = 15000,
				LevelReq = 17,
				PrestigeReq = 1,
			},
		},
		Callback = function(ply, difficulty)
			ply.XP = ply.XP + 1550
			ply.Money = ply.Money + 1150
			gamemode.Call("SystemGiveItem", ply, "item_armymedkit", 1)
			GAMEMODE:SendInventory(ply)
			ply:SystemMessage("You gained 1550 XP, 1150 cash and 1x Army Medkit for completing this task!", Color(180,255,255))
		end
	},

	["in_need_of_medical_attention"] = {
		Name = "In need of medical attention",
		Description = "",
		Objective = "", -- remains empty because difficulties below
		Difficulties = {
			{
				Name = "Easy",
				Objective = "Bring 2x medkits & 5x bandages.",
				RewardText = "550XP, 50$, 2x Pistol Ammo & 1x Magnum Ammo",
				Cooldown = TIME_HOUR * 3,
				ReqProgress = function(pl)
					return pl.Inventory["item_medkit"] and pl.Inventory["item_medkit"] >= 2 and pl.Inventory["item_bandage"] and pl.Inventory["item_bandage"] >= 5
				end,
				LevelReq = 4,
			},
			{
				Name = "Medium",
				Objective = "Bring 3x army medkits & 3x antidotes.",
				RewardText = "1000XP, 100$, 2x Buckshot ammo & 2x SMG ammo",
				Cooldown = TIME_HOUR * 6,
				ReqProgress = function(pl)
					return pl.Inventory["item_armymedkit"] and pl.Inventory["item_armymedkit"] >= 3 and pl.Inventory["item_antidote"] and pl.Inventory["item_antidote"] >= 3
				end,
				LevelReq = 11,
			},
			{
				Name = "Difficult",
				Objective = "Bring 5x scientific medkits, 5x army medkits & 5x medkits.",
				RewardText = "1750XP, 200$ & 2x Kevlar Plate",
				Cooldown = TIME_HOUR * 11,
				ReqProgress = function(pl)
					return pl.Inventory["item_medkit"] and pl.Inventory["item_medkit"] >= 2 and pl.Inventory["item_bandage"] and pl.Inventory["item_bandage"] >= 5
				end,
				LevelReq = 23,
			},
			{
				Name = "Demanding",
				Objective = "Bring 2x MedBag Enhanced & 5x scientific medkit.",
				RewardText = "3000XP, 1350$",
				Cooldown = TIME_HOUR * 24,
				ReqProgress = function(pl)
					return pl.Inventory["item_medkit"] and pl.Inventory["item_medkit"] >= 2 and pl.Inventory["item_bandage"] and pl.Inventory["item_bandage"] >= 5
				end,
				LevelReq = 26,
				PrestigeReq = 1,
			},
			{
				Name = "Taxing",
				Description = "",
				Objective = "Bring 5x MedBag Enhanced, 8x scientific medkit, 4x army medkit, 7x medkit, 10x antidotes & 25x bandages.",
				RewardText = "7500XP & 1 random loot from boss cache",
				Cooldown = TIME_HOUR * 72,
				ReqProgress = function(pl)
					return pl.Inventory["item_medkit"] and pl.Inventory["item_medkit"] >= 2 and pl.Inventory["item_bandage"] and pl.Inventory["item_bandage"] >= 5
				end,
				LevelReq = 32,
				PrestigeReq = 2,
			},
		},
		Callback = function(ply, difficulty)
		end
	},


}
