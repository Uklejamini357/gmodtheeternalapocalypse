function tea_LoadPlayer(ply)
	if not file.IsDir(GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_")), "DATA") then
	   file.CreateDir(GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_")))
	end
	if (file.Exists(GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), "DATA")) then
		local TheFile = file.Read(GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), "DATA")
		local DataPieces = string.Explode("\n", TheFile)

		local Output = {}

		for k, v in pairs(DataPieces) do
			local TheLine = string.Explode(";", v) -- convert txt string to stats table
			
			ply[TheLine[1]] = TheLine[2]  -- dump all their stats into their player table
			if GetConVar("tea_server_debugging"):GetInt() >= 1 then
				print(TheLine[1].." = "..TheLine[2])
			end
		end

		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", ply.Prestige)
		ply:SetNWString("ArmorType", ply.EquippedArmor)
		
		tea_DebugLog("Loading player data: "..ply:Nick().." ("..ply:SteamID()..") Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor))
		tea_DebugLog("Loaded player: ".. ply:Nick() .." ("..ply:SteamID()..") from file: "..GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))
		
		tea_NetUpdatePeriodicStats(ply)
		tea_NetUpdatePerks(ply)
		tea_NetUpdateStatistics(ply)
	else
		ply.ChosenModel = "models/player/kleiner.mdl"
		ply.BestSurvivalTime = 0
		ply.XP = 0 
		ply.Level = 1
		ply.Prestige = 0
		ply.playerskilled = 0
		ply.playerdeaths = 0
		ply.ZKills = 0
		ply.BestSurvivalTime = 0
		ply.Money = tonumber(GAMEMODE.Config["StartMoney"])
		ply.StatPoints = 0
		ply.EquippedArmor = "none"
		ply.StatsReset = 0

		ply.MasteryMeleeXP = 0
		ply.MasteryMeleeLevel = 0
		ply.MasteryPvPXP = 0
		ply.MasteryPvPLevel = 0
		
		for k, v in pairs(GAMEMODE.StatsListServer) do
			local TheStatPieces = string.Explode(";", v)
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end

		print("Created a new profile for "..ply:Nick() .." ("..ply:SteamID()..")")
		tea_DebugLog("Created new data file for: "..ply:Nick().." ("..ply:SteamID()..") located at: "..GAMEMODE.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))

		tea_SavePlayer(ply)

		tea_NetUpdatePeriodicStats(ply)
		tea_NetUpdateStatistics(ply)
	end
end


function tea_SavePlayer(ply)
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving"):GetInt() >= 1
	if !ply.AllowSave and !tea_server_dbsaving then print("------=== WARNING ===------\n\nDatabase saving is disabled! Players will not have their progress saved during this time.\nSet ConVar 'tea_server_dbsaving' to 1 in order to enable database saving.\n\n------======------") return end
	
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
	Data["EquippedArmor"] = ply.EquippedArmor
	Data["ChosenModel"] = ply.ChosenModel
	Data["StatsReset"] = ply.StatsReset
	Data["ChosenModelColor"] = tostring(ply.ChosenModelColor)

	Data["MasteryMeleeXP"] = ply.MasteryMeleeXP
	Data["MasteryMeleeLevel"] = ply.MasteryMeleeLevel
	Data["MasteryPvPXP"] = ply.MasteryPvPXP
	Data["MasteryPvPLevel"] = ply.MasteryPvPLevel


	for k, v in pairs(GAMEMODE.StatsListServer) do
		local TheStatPieces = string.Explode(";", v)
		local TheStatName = TheStatPieces[1]
		Data[TheStatName] = ply[TheStatName]
	end


	local StringToWrite = ""
	for k, v in pairs(Data) do
		if StringToWrite == "" then
			StringToWrite = k ..";".. v
		else
			StringToWrite = StringToWrite .."\n".. k ..";".. v
		end
	end
	
	tea_DebugLog("Saving player data: "..ply:Nick().." ("..ply:SteamID().."), Level: "..tostring(ply.Level)..", Cash: $"..tostring(ply.Money)..", XP Total: "..tostring(ply.XP)..", Armor Equipped: "..tostring(ply.EquippedArmor))
	
	tea_NetUpdatePeriodicStats(ply) --see server/netstuff.lua
	tea_NetUpdatePerks(ply)
	tea_NetUpdateStatistics(ply)
	
	print("✓ ".. ply:Nick() .." profile saved into database")	

	file.Write(GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), StringToWrite)
	tea_DebugLog("Saved player: "..ply:Nick().." ("..ply:SteamID()..") to file: "..GAMEMODE.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))
end

--Bonus multipliers for various supporters (and the dev)
function tea_XPBonus(ply)
	if !ply:IsValid() then return 0 end
	local xpmul = 1
	if tonumber(ply.Prestige or 0) >= 15 then --check if player has prestige 15 then it will give another 1.15x xp mul 
		xpmul = xpmul * 1.15
	end
	
	if GetConVar("tea_server_bonusperks"):GetInt() >= 1 then
		if ply:SteamID64() == "76561198274314803" then
			xpmul = xpmul * 1.25 --the dev gains 1.25x XP multiplier, so if xpmul was xpmul * 2 then it would be 2x
		elseif ply:SteamID64() == "76561198028288732" then
			xpmul = xpmul * 1.15
		elseif ply:SteamID64() == "76561198112950441" then
			xpmul = xpmul * 1.05
		end
	end
	return xpmul
end

function tea_CashBonus(ply) --works the same as XPBonus with the exception of giving cash bonus
	if !ply:IsValid() then return 0 end
	local cashmul = 1
	if tonumber(ply.Prestige or 0) >= 1 then
		cashmul = cashmul * 1.05
	end
	
	if GetConVar("tea_server_bonusperks"):GetInt() >= 1 then
		if ply:SteamID64() == "76561198274314803" then
			cashmul = cashmul * 1.25
		elseif ply:SteamID64() == "76561198028288732" then
			cashmul = cashmul * 1.15
		elseif ply:SteamID64() == "76561198112950441" then
			cashmul = cashmul * 0.95
		end
	end
	return cashmul
end

--level up
function tea_GainLevel(ply)
	if ply.XP >= GetReqXP(ply) then
		if !ply.IsLevelingAllowed and tonumber(ply.Level) >= GAMEMODE.MaxLevel + (ply.Prestige * GAMEMODE.LevelsPerPrestige) then
			SendChat(ply, "You have reached max level, consider prestiging.")
			return
		end
		ply.XP = ply.XP - GetReqXP(ply)
		local moneyreward = 56 + math.floor((ply.Level ^ 1.1217) * 16 + (ply.Level * 5) + (ply.Prestige * 2.4892))
		ply.Money = ply.Money + moneyreward
		ply.Level = ply.Level + 1
		ply.StatPoints = ply.StatPoints + 1
		if GetConVar("tea_server_debugging"):GetInt() >= 1 then
			print(ply:Nick().." has leveled up to Level "..ply.Level.." with a reward of "..moneyreward.." "..GAMEMODE.Config["Currency"].."s and reduction of "..GetReqXP(ply).." XP! (XP now: "..ply.XP..")")
		end
		SendChat(ply, translate.ClientFormat(ply, "pllvlup", ply.Level, moneyreward, GAMEMODE.Config["Currency"]))
		ply:SendLua('LocalPlayer():ConCommand([[playvol "theeternalapocalypse/levelup.wav" 0.55]])')
		
		ply:SetNWInt("PlyLevel", ply.Level)
		
		tea_NetUpdatePeriodicStats(ply)
		
		timer.Simple(0.05, function() -- Timer was created to prevent Buffer Overflow if user has too much XP if user levels up
			if ply:IsValid() and ply.XP >= GetReqXP(ply) and tonumber(ply.Level) < GAMEMODE.MaxLevel + (ply.Prestige * GAMEMODE.LevelsPerPrestige) then
				tea_GainLevel(ply) -- This is so the user will gain another level if user has required xp for next level and will repeat
			end
		end)

		if tonumber(ply.Level) >= GAMEMODE.MaxLevel + (ply.Prestige * GAMEMODE.LevelsPerPrestige) then
			SendChat(ply, "You have reached max level, consider prestiging.")
		end
	end
end

net.Receive("Prestige", function(length, ply)
	tea_GainPrestige(ply)
end)

function tea_GainPrestige(ply)
	if !ply:Alive() then SendChat(ply, "Must be alive in order to prestige!") return end
	if tonumber(ply.Level) >= GAMEMODE.MaxLevel + (GAMEMODE.LevelsPerPrestige * ply.Prestige) then
		ply.Prestige = ply.Prestige + 1
		ply.Level = 1
		ply.XP = 0
		if tonumber(ply.Prestige) >= 10 then
			ply.StatPoints = 5
		else
			ply.StatPoints = 0
		end

		for k, v in pairs(GAMEMODE.StatsListServer) do
			local TheStatPieces = string.Explode(";", v)
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end

		util.ScreenShake(ply:GetPos(), 50, 0.5, 1.5, 800)
		net.Start("PrestigeEffect")
		net.Send(ply)
		local prestige = ply.Prestige
		if tonumber(prestige) == 1 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_4"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 2 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_5"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 3 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_6"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 4 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_7"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 5 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_8"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 6 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_9"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 8 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_10"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 10 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_11"), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 15 then
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientGet(ply, "plhasprestiged_12"), Color(155,255,255,255), true)
		else
			local moneyprestigereward = math.floor(1603 + (1129 * prestige) + (((prestige * 1.592) * (3 * ply.Level)) ^ 1.392)) --gives players money if they prestige without gaining any other advantage except for more levels
			ply.Money = ply.Money + moneyprestigereward
			SystemMessage(ply, translate.ClientFormat(ply, "plhasprestiged_1", prestige).." "..translate.ClientFormat(ply, "plhasprestiged_2", moneyprestigereward, GAMEMODE.Config["Currency"]), Color(155,255,255,255), true)
		end
		tea_SystemBroadcast(translate.Format("plhasprestiged_3", ply:Nick(), prestige), Color(155,205,255,255), true)
		ply:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 90, math.Rand(75,90))
		ply:EmitSound("ambient/machines/thumper_hit.wav", 120, 50)
		local effectdata = EffectData()
		effectdata:SetOrigin(ply:GetPos() + Vector(0, 0, 60))
		util.Effect("zw_master_strike", effectdata)

		tea_NetUpdatePeriodicStats(ply)
		tea_NetUpdatePerks(ply)
		tea_NetUpdateStatistics(ply)

		ply:SetNWInt("PlyBounty", ply.Bounty)
		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", prestige)
		ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
		ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
		ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	else
		SystemMessage(ply, "You must be at least level ".. GAMEMODE.MaxLevel + (GAMEMODE.LevelsPerPrestige * ply.Prestige) .." to prestige!", Color(255,155,155,255), true)
		ply:ConCommand("playgamesound buttons/button10.wav")
	end
end

function tea_PrepareStats(ply)
	if !ply:IsValid() then return false end
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]
-- set the stats to default values for a fresh spawn
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	if armorstr and armortype then ply.Battery = 100 + armortype["ArmorStats"]["battery"] else ply.Battery = 100 end
	ply.HPRegen = 0
	ply.SurvivalTime = math.floor(CurTime())
	ply.SlowDown = 0
	ply.IsAlive = true

-- send their stats to them so their hud can display it (this function is called every tick, see server/netstuff.lua)
	tea_NetUpdateStats(ply)
end


function tea_FullyUpdatePlayer(ply)
	if !ply:IsValid() then return end
	net.Start("UpdateInventory")
	net.WriteTable(ply.Inventory)
	net.Send(ply)

	ply:SetNWInt("PlyBounty", ply.Bounty)
	ply:SetNWInt("PlyLevel", ply.Level)
	ply:SetNWInt("PlyPrestige", ply.Prestige)

	tea_NetUpdatePeriodicStats(ply)
	tea_NetUpdatePerks(ply)
	tea_NetUpdateStatistics(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
end
