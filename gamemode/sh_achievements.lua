-------- Achievements --------
-- please don't modify them unless you know well


GM.Achievements = {
	["killzombies"] = {
		["Tiers"] = {
			[0] = 25,
			[1] = 75,
			[2] = 150,
			[3] = 375,
			[4] = 750,
			[5] = 1375,
			[6] = 2250,
			[7] = 3750,
			[8] = 6250,
			[9] = 15000,
		},
		["Reward"] = function(ply)
			if ply.Achievements["killzombies"] == 9 then
				ply.Money = ply.Money + 50000
			elseif ply.Achievements["killzombies"] == 8 then
				ply.Money = ply.Money + 30000
			elseif ply.Achievements["killzombies"] == 7 then
				ply.Money = ply.Money + 20000
			elseif ply.Achievements["killzombies"] == 6 then
				ply.Money = ply.Money + 10000
			elseif ply.Achievements["killzombies"] == 5 then
				ply.Money = ply.Money + 5000
			elseif ply.Achievements["killzombies"] == 4 then
				ply.Money = ply.Money + 2500
			elseif ply.Achievements["killzombies"] == 3 then
				ply.Money = ply.Money + 1500
			elseif ply.Achievements["killzombies"] == 2 then
				ply.Money = ply.Money + 500
			elseif ply.Achievements["killzombies"] == 1 then
				ply.Money = ply.Money + 250
			elseif ply.Achievements["killzombies"] == 0 then
				ply.Money = ply.Money + 100
			elseif !ply.Achievements["killzombies"] then
				ply.Achievements["killzombies"] = 0
			end
		end,
	},

	["killbosses"] = {
		["Tiers"] = {
			[0] = 1,
			[1] = 3,
			[2] = 5,
			[3] = 8,
			[4] = 12,
			[5] = 20,
			[6] = 30,
			[7] = 45,
			[8] = 65,
			[9] = 100,
		},
		["Reward"] = function(ply)
			if ply.Achievements["killbosses"] == 9 then
				ply.Money = ply.Money + 25000
			elseif ply.Achievements["killbosses"] == 8 then
				ply.Money = ply.Money + 15000
			elseif ply.Achievements["killbosses"] == 7 then
				ply.Money = ply.Money + 8750
			elseif ply.Achievements["killbosses"] == 6 then
				ply.Money = ply.Money + 6250
			elseif ply.Achievements["killbosses"] == 5 then
				ply.Money = ply.Money + 5000
			elseif ply.Achievements["killbosses"] == 4 then
				ply.Money = ply.Money + 3000
			elseif ply.Achievements["killbosses"] == 3 then
				ply.Money = ply.Money + 2000
			elseif ply.Achievements["killbosses"] == 2 then
				ply.Money = ply.Money + 1250
			elseif ply.Achievements["killbosses"] == 1 then
				ply.Money = ply.Money + 1000
			elseif ply.Achievements["killbosses"] == 0 then
				ply.Money = ply.Money + 500
			elseif !ply.Achievements["killbosses"] then
				ply.Achievements["killbosses"] = 0
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
		print("YES!", self, achtype)
		self.Achievements["killzombies"] = self.Achievements["killzombies"] + 1
		tea_FullyUpdatePlayer(self)
	end
end
