function GM:LoadPlayer(ply, id)
	local filedir
	local filedir_ply
	if self.PlayerCharactersTest then
		filedir = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_").."/characters/"..tostring(id))
		filedir_ply = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/characters/"..tostring(id).."/profile.txt")
	else
		filedir = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_"))
		filedir_ply = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt")
	end

	if not file.IsDir(filedir, "DATA") then file.CreateDir(filedir) end

	if (file.Exists(filedir_ply, "DATA")) then
		local TheFile = file.Read(filedir_ply, "DATA")
		local DataPieces = string.Explode("\n", TheFile)

		local Output = {}
		local perkpoints

		for k, v in pairs(DataPieces) do
			local TheLine = string.Explode(";", v) -- convert txt string to stats table
			
			ply[TheLine[1]] = TheLine[2]  -- dump all their stats into their player table

			if self:GetDebug() >= DEBUGGING_EXPERIMENTAL then
				print(TheLine[1].." = "..TheLine[2])
			end

			if TheLine[1] == "PerkPoints" then
				perkpoints = true
			elseif TheLine[1] == "TaskCooldowns" then
				ply[TheLine[1]] = util.JSONToTable(TheLine[2])
			end
		end

		if !perkpoints then
			ply.PerkPoints = ply.Prestige
		end

		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", ply.Prestige)
		ply:SetNWString("ArmorType", ply.EquippedArmor)
		
		self:DebugLog("Loading player data: "..ply:Nick().." ("..ply:SteamID()..") Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor))
		self:DebugLog("Loaded player: ".. ply:Nick() .." ("..ply:SteamID()..") from file: "..filedir_ply)

		self:NetUpdatePerks(ply)
	else
		ply.Money = tonumber(self.Config["StartMoney"])
/*
		ply.ChosenModel = "models/player/kleiner.mdl"
		ply.BestSurvivalTime = 0
		ply.XP = 0 
		ply.Level = 1
		ply.Prestige = 0
		ply.playerskilled = 0
		ply.playerdeaths = 0
		ply.ZKills = 0
		ply.BestSurvivalTime = 0
		ply.StatPoints = 0
		ply.EquippedArmor = "none"
		ply.StatsReset = 0

		ply.MasteryMeleeXP = 0
		ply.MasteryMeleeLevel = 0
		ply.MasteryPvPXP = 0
		ply.MasteryPvPLevel = 0

		for k, v in pairs(self.StatsListServer) do
			local TheStatPieces = string.Explode(";", v)
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end
*/
		print("Created a new profile for "..ply:Nick() .." ("..ply:SteamID()..")")
		self:DebugLog("Created new data file for: "..ply:Nick().." ("..ply:SteamID()..") located at: "..filedir_ply)

		self:SavePlayer(ply)

	end
	self:NetUpdatePeriodicStats(ply)
	self:NetUpdateStatistics(ply)

	return true
end


function GM:SavePlayer(ply)
	if !ply.AllowSave and not self.DatabaseSaving then return end
	local filedir = self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt")

	local Data = {}
	Data["BestSurvivalTime"] = ply.BestSurvivalTime
	Data["ZKills"] = ply.ZKills
	Data["XP"] = ply.XP
	Data["playerskilled"] = ply.playerskilled
	Data["playerdeaths"] = ply.playerdeaths
	Data["Level"] = ply.Level
	Data["Prestige"] = ply.Prestige
	Data["Money"] = ply.Money
	Data["StatPoints"] = ply.StatPoints
	Data["PerkPoints"] = ply.PerkPoints
	Data["EquippedArmor"] = ply.EquippedArmor
	Data["ChosenModel"] = ply.ChosenModel
	Data["StatsReset"] = ply.StatsReset
	Data["ChosenModelColor"] = tostring(ply.ChosenModelColor)
	Data["CurrentTask"] = ply.CurrentTask
	Data["CurrentTaskProgress"] = ply.CurrentTaskProgress
	Data["TaskCooldowns"] = util.TableToJSON(ply.TaskCooldowns)

	Data["MasteryMeleeXP"] = ply.MasteryMeleeXP
	Data["MasteryMeleeLevel"] = ply.MasteryMeleeLevel
	Data["MasteryPvPXP"] = ply.MasteryPvPXP
	Data["MasteryPvPLevel"] = ply.MasteryPvPLevel

/*
	for k, v in pairs(self.StatsListServer) do
		local TheStatPieces = string.Explode(";", v)
		local TheStatName = TheStatPieces[1]
		Data[TheStatName] = ply[TheStatName]
	end
*/
	for statname, v in pairs(self.StatConfigs) do
		local name = "Stat"..statname
		Data[name] = ply[name]
	end


	local StringToWrite = ""
	for k, v in pairs(Data) do
		if StringToWrite == "" then
			StringToWrite = k ..";".. v
		else
			StringToWrite = StringToWrite .."\n".. k ..";".. v
		end
	end
	
	self:DebugLog("Saving player data: "..ply:Nick().." ("..ply:SteamID().."), Level: "..tostring(ply.Level)..", Cash: $"..tostring(ply.Money)..", XP Total: "..tostring(ply.XP)..", Armor Equipped: "..tostring(ply.EquippedArmor))
	
	self:NetUpdatePeriodicStats(ply) --see server/netstuff.lua
	self:NetUpdatePerks(ply)
	self:NetUpdateStatistics(ply)
	
	if self:GetDebug() >= DEBUGGING_NORMAL then
		print("✓ ".. ply:Nick() .." profile saved")
	end

	file.Write(filedir, StringToWrite)
	self:DebugLog("Saved player: "..ply:Nick().." ("..ply:SteamID()..") to file: "..filedir)
end

--Bonus multipliers for various supporters (and the dev)
function GM:XPBonus(ply)
	if !ply:IsValid() then return 0 end
	local xpmul = 1
	if ply.UnlockedPerks["xpboost"] then
		xpmul = xpmul + 0.1
	end
	if ply.UnlockedPerks["xpboost2"] then
		xpmul = xpmul + 0.15
	end
	
	if self.BonusPerksEnabled then
		if ply:SteamID64() == "76561198274314803" then
			xpmul = xpmul * 1.25
		elseif ply:SteamID64() == "76561198028288732" then
			xpmul = xpmul * 1.15
		elseif ply:SteamID64() == "76561198112950441" then
			xpmul = xpmul * 1.05
		end
	end
	return xpmul
end

function GM:CashBonus(ply)
	if !ply:IsValid() then return 0 end
	local cashmul = 1
	if ply.UnlockedPerks["cashboost"] then
		cashmul = cashmul + 0.05
	end
	if ply.UnlockedPerks["cashboost2"] then
		cashmul = cashmul + 0.08
	end
	
	if self.BonusPerksEnabled then
		if ply:SteamID64() == "76561198112950441" then
			cashmul = cashmul * 0.95
		end
	end
	return cashmul
end

--level up
function GM:GainLevel(ply)
	local sp = tonumber(ply.Level) >= 55 and 3 or tonumber(ply.Level) >= 30 and 2 or 1
	local moneyreward = 56 + math.floor((ply.Level ^ 1.1217) * 16 + (ply.Level * 5) + (ply.Prestige * 2.4892))
	local reqxp = ply:GetReqXP()
	
	ply.XP = ply.XP - reqxp
	ply.Level = ply.Level + 1
	ply.Money = ply.Money + moneyreward
	ply.StatPoints = ply.StatPoints + sp

	if self:GetDebug() >= DEBUGGING_NORMAL then
		print(
			Format("%s has leveled up to Level %s with a reward of %s %ss and reduction of %s XP! (XP now: %s)",
			ply:Nick(), ply.Level, moneyreward, self.Config["Currency"], reqxp, ply.XP)
		)
	end

	ply:SendChat(translate.ClientFormat(ply, "pllvlup", ply.Level, sp, moneyreward, self.Config["Currency"]))
	if ply:GetInfoNum("tea_cl_playlevelupsound", 1) >= 1 then
		ply:SendLua('LocalPlayer():ConCommand([[playvol "theeternalapocalypse/levelup.wav" 0.55]])')
	end

	ply:SetNWInt("PlyLevel", ply.Level)

	self:NetUpdatePeriodicStats(ply)

	timer.Simple(0.04, function() -- Timer was created to prevent Buffer Overflow if user has too much XP if user levels up
		if ply:IsValid() and ply.XP >= ply:GetReqXP() and tonumber(ply.Level) < ply:GetMaxLevel() then
			self:GainLevel(ply) -- This is so the user will gain another level if user has required xp for next level and will repeat
		end
	end)

	if tonumber(ply.Level) >= ply:GetMaxLevel() then
		ply.MaxLevelTime = CurTime() + 120
		ply:SendChat("You have reached max level, consider prestiging.")
	end
end

net.Receive("Prestige", function(length, ply)
	if !ply:Alive() then ply:SendChat("Must be alive in order to prestige!") return end
	if tonumber(ply.Level) >= ply:GetMaxLevel() then
		gamemode.Call("GainPrestige", ply)
	else
		ply:SystemMessage("You must be at least level ".. ply:GetMaxLevel() .." to prestige!", Color(255,155,155), true)
		ply:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
	end
end)

function GM:GainPrestige(ply)
	local prestige = ply.Prestige + 1
	ply.Prestige = prestige
	ply.Level = 1
	ply.XP = 0
	ply.StatPoints = (ply.UnlockedPerks["skillpointsbonus"] and 5 or 0) + (ply.UnlockedPerks["skillpointsbonus2"] and prestige or 0)
	ply.PerkPoints = ply.PerkPoints + 1

	for statname, _ in pairs(self.StatConfigs) do
		local name = "Stat"..statname
		ply[name] = 0
	end

	util.ScreenShake(ply:GetPos(), 50, 0.5, 1.5, 800)
	net.Start("PrestigeEffect")
	net.Send(ply)


	local moneyprestigereward = math.floor(847 + (529 * prestige) + (((prestige * 1.592) * (3 * ply.Level)) ^ 1.392))
	ply.Money = ply.Money + moneyprestigereward
	ply:SystemMessage(translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientFormat(ply, "plhasprestiged_2", moneyprestigereward, self.Config["Currency"], 1), Color(155,255,255), true)

	self:SystemBroadcast(translate.Format("plhasprestiged_3", ply:Nick(), prestige), Color(155,205,255), true)
	ply:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 90, math.Rand(75,90))
	ply:EmitSound("ambient/machines/thumper_hit.wav", 120, 50)
	local effectdata = EffectData()
	effectdata:SetOrigin(ply:GetPos() + Vector(0, 0, 60))
	util.Effect("zw_master_strike", effectdata)

	self:NetUpdatePeriodicStats(ply)
	self:NetUpdatePerks(ply)
	self:NetUpdateStatistics(ply)

	ply:SetNWInt("PlyLevel", ply.Level)
	ply:SetNWInt("PlyPrestige", prestige)
	ply:SetMaxHealth(self:CalcMaxHealth(ply))
	ply:SetMaxArmor(self:CalcMaxArmor(ply))
	ply:SetJumpPower(self:CalcJumpPower(ply))
end

function GM:PrepareStats(ply)
	if !ply:IsValid() then return false end
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = self.ItemsList[armorstr]
-- set the stats to default values for a fresh spawn
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Oxygen = 100
	ply.Battery = 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0)
	ply.HPRegen = 0
	ply.SurvivalTime = CurTime()
	ply.SlowDown = 0
	ply.IsAlive = true

	-------- Survival Stats --------
	ply.LifeZKills = 0
	ply.LifePlayerKills = 0
	----------------

	if ply.TEANoTarget then
		ply.TEANoTarget = false
		if SuperAdminCheck(ply) then
			ply:SystemMessage("You died, so your notarget has worn off.", Color(255,255,255), true)
		end
	end


-- send their stats to them so their hud can display it (this function is called every tick, see server/netstuff.lua)
	self:NetUpdateStats(ply)
	self:SendPlayerSurvivalStats(ply)
end


function GM:FullyUpdatePlayer(ply)
	if !ply:IsValid() then return end
	ply:SetNWInt("PlyBounty", ply.Bounty)
	ply:SetNWInt("PlyLevel", ply.Level)
	ply:SetNWInt("PlyPrestige", ply.Prestige)

	self:SendInventory(ply)
	self:NetUpdatePeriodicStats(ply)
	self:NetUpdatePerks(ply)
	self:NetUpdateStatistics(ply)
	self:SendPlayerPerksUnlocked(ply)
	ply:RefreshTasksStats()

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
end

--local meta = FindMetaTable("Player")



function GM:GetPlayerCharacters(ply)
	if !self.PlayerCharactersTest then return end
		local tbl = {}
	for i=1,3 do
		
		local t = {}
		local filedir = self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/characters/"..tostring(id))
		local filedir_ply = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt")

		if (file.Exists(filedir_ply, "DATA")) then
			local TheFile = file.Read(filedir_ply, "DATA")
			local DataPieces = string.Explode("\n", TheFile)
	
			local Output = {}
			local perkpoints
	
			for k, v in pairs(DataPieces) do
				local TheLine = string.Explode(";", v)

				t[TheLine[1]] = TheLine[2]
	
				if TheLine[1] == "PerkPoints" then
					perkpoints = true
				end
			end
	
			if !perkpoints then
				t.PerkPoints = t.Prestige
			end
		else
			t.Money = tonumber(self.Config["StartMoney"])
	/*
			ply.ChosenModel = "models/player/kleiner.mdl"
			ply.BestSurvivalTime = 0
			ply.XP = 0 
			ply.Level = 1
			ply.Prestige = 0
			ply.playerskilled = 0
			ply.playerdeaths = 0
			ply.ZKills = 0
			ply.BestSurvivalTime = 0
			ply.StatPoints = 0
			ply.EquippedArmor = "none"
			ply.StatsReset = 0
	
			ply.MasteryMeleeXP = 0
			ply.MasteryMeleeLevel = 0
			ply.MasteryPvPXP = 0
			ply.MasteryPvPLevel = 0
	
			for k, v in pairs(self.StatsListServer) do
				local TheStatPieces = string.Explode(";", v)
				local TheStatName = TheStatPieces[1]
				ply[TheStatName] = 0
			end
	*/
		end

		tbl[i] = t
	end

	return tbl
end





