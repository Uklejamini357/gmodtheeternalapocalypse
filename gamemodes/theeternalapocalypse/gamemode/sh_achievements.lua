-------- Achievements --------
-- please don't modify them unless you know well
-- NOTE: This is still work in progress!
-- This is taking so long (idk how to design panel on client)


GM.Achievements = {
	["killzombies"] = {
		Name = "Zombie Killer",
		Decription = "Kill 999 zombies.",
		Tiers = {999, 6969},
		Reward = function(ply, completion)
			if completion == 2 then
				ply.Money = ply.Money + 420
			elseif completion == 1 then
				ply.Money = ply.Money + 50
			end
		end,
	},

	["killbosses"] = {
		Tiers = {1, 45, 65, 100},
		Reward = function(ply, completion)
			local completionmoneyreward = {0, 0, 0, 0}

			if completionmoneyreward[completion] then
				ply.Money = ply.Money + completionmoneyreward[completion]
			end
		end,
	},
}

local meta = FindMetaTable("Player")

function meta:GainAchProgress(achtype, amount)
	if !SERVER then return end
	if !self:IsValid() then return end
	if !achtype or !GAMEMODE.Achievements[achtype] then return end
	local amt = tonumber(amount or 0)

	self.AchProgress[achtype] = (self.AchProgress[achtype] or 0) + amt
	if self.AchProgress[achtype] >= (GAMEMODE.Achievements[achtype]["Tiers"][self.Achievements[achtype]] or 0) then
		self:GainAchievement(achtype)
		print("YES!!!!", self, achtype, amt)
	end
end

function meta:GainAchievement(achtype)
	if !SERVER then return end
	if !self:IsValid() then return end
	if !achtype or !GAMEMODE.Achievements[achtype] then return end
	if self.AchProgress[achtype] >= (GAMEMODE.Achievements[achtype]["Tiers"][self.Achievements[achtype]] or 0) then
		GAMEMODE.Achievements[achtype]["Reward"](self)
		if GAMEMODE:GetDebug() >= DEBUGGING_ADVANCED then
			print("Gave achievement for "..tostring(self), achtype)
		end
		self.Achievements[achtype] = self.Achievements[achtype] + 1
		GAMEMODE:FullyUpdatePlayer(self)
	end
end
