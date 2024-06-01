-------- Tasks list --------
-- just adding new tasks won't work - you need good lua skills in order for it to work
-- NOTE: This is still work in progress!

GM.Tasks = {

	["zombie_killer"] = {
		Name = "Kill zombies", -- Name of a task
		Description = "Kill 65 zombies", -- Description of a task and what should we do to complete it
		RewardText = "950XP & 600$", -- Text for a reward (display for client)
		Cooldown = TIME_HOUR * 4, -- Cooldown before taking a new task after completing this task
		CancelCooldown = TIME_HOUR * 8, -- cooldown before taking in a new task after cancelling task
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
		CancelCooldown = TIME_HOUR * 12,
		ReqProgress = 10,
		LevelReq = 10,
		Callback = function(ply)
			ply.XP = ply.XP + 1250
			ply.Money = ply.Money + 800
			ply:SystemMessage("You gained 1250 XP and 800 cash for completing a task!", Color(180,255,255))
		end
	},


}
