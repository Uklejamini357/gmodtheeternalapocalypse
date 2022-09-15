function LoadPlayer(ply)
	if not file.IsDir("theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_")), "DATA") then
	   file.CreateDir("theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_")))
	end
	if (file.Exists("theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), "DATA")) then
		local TheFile = file.Read("theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), "DATA")
		local DataPieces = string.Explode("\n", TheFile)

		local Output = {}

		for k, v in pairs(DataPieces) do
			local TheLine = string.Explode(";", v) -- convert txt string to stats table

			ply[TheLine[1]] = TheLine[2]  -- dump all their stats into their player table
			if GetConVarNumber("tea_server_debugging") >= 1 then
				print(TheLine[1].." = "..TheLine[2])
			end
		end

--		print("Loaded player: ".. ply:Nick() .." ("..ply:SteamID()..")")
		ate_DebugLog("Loaded player: ".. ply:Nick() .." ("..ply:SteamID()..") from file: ".."theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))

		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", ply.Prestige)
		ply:SetNWString("ArmorType", ply.EquippedArmor)

		ate_DebugLog("Loading player data: "..ply:Nick().." ("..ply:SteamID()..") Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor))

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdatePerks(ply)
		TEANetUpdateStatistics(ply)

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
		ply.Money = tonumber(Config["StartMoney"])
		ply.StatPoints = 0
		ply.EquippedArmor = "none"
		
		for k, v in pairs(StatsListServer) do
			local TheStatPieces = string.Explode(";", v)
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end

		print("Created a new profile for "..ply:Nick() .." ("..ply:SteamID()..")")
		ate_DebugLog("Created new data file for: "..ply:Nick().." ("..ply:SteamID()..") located at: ".."theeternalapocalypse/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))

		SavePlayer(ply)

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdateStatistics(ply)
	end
end


function SavePlayer(ply)
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
	local Data = {}

	if AllowSave != 1 and !tobool(tea_server_dbsaving:GetString()) then print("------=== WARNING ===------\n\nDatabase saving is disabled! Players will not have their progress saved during this time.\nSet ConVar 'tea_server_dbsaving' to 1 in order to enable database saving.\n\n------=== WARNING ===------") return end
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
	Data["ChosenModelColor"] = tostring(ply.ChosenModelColor)


	for k, v in pairs(StatsListServer) do
		local TheStatPieces = string.Explode(";", v)
		local TheStatName = TheStatPieces[1]
		Data[TheStatName] = ply[TheStatName]
	end


	local StringToWrite = ""
	for k, v in pairs(Data) do
		if(StringToWrite == "") then
			StringToWrite = k ..";".. v
		else
			StringToWrite = StringToWrite .."\n".. k ..";".. v
		end
	end
	
	TEANetUpdatePeriodicStats(ply) --see server/netstuff.lua
	ate_DebugLog("Saving player data: "..ply:Nick().." ("..ply:SteamID()..") Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor))
	
	TEANetUpdatePerks(ply)
	TEANetUpdateStatistics(ply)
	
	print("✓ ".. ply:Nick() .." profile saved into database")	

	file.Write("theeternalapocalypse/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"), StringToWrite)
	ate_DebugLog("Saved player: "..ply:Nick().." ("..ply:SteamID()..") to file: ".."theeternalapocalypse/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_") .."/profile.txt"))
end

--Bonus multipliers for various supporters (and the dev)
function TEAXPBonus(ply)
	local xpmul = 1
	if tonumber(ply.Prestige) >= 15 then --check if player has prestige 15 then it will give another 1.1x xp mul 
		xpmul = xpmul * 1.15
	end
	if ply:SteamID64() == "76561198274314803" then
		xpmul = xpmul * 1.5 --the dev gains 1.5x XP multiplier, so if xpmul was xpmul * 2 then it would be 2x
	elseif ply:SteamID64() == "76561198028288732" then
		xpmul = xpmul * 1.25
	elseif ply:SteamID64() == "76561198112950441" then
		xpmul = xpmul * 1.05
	end
	return xpmul
end

function TEACashBonus(ply) --works the same as XPBonus with the exception of giving cash bonus
	local cashmul = 1
	if tonumber(ply.Prestige) >= 1 then
		cashmul = cashmul * 1.05
	end
	if ply:SteamID64() == "76561198274314803" then
		cashmul = cashmul * 1.5
	elseif ply:SteamID64() == "76561198028288732" then
		cashmul = cashmul * 1.25
	elseif ply:SteamID64() == "76561198112950441" then
		cashmul = cashmul * 0.95
	end
	return cashmul
end

--level up
function PlayerGainLevel(ply)
	if ply.XP >= GetReqXP(ply) then
		if ply.IsLevelingAllowed != true and tonumber(ply.Level) >= 50 + (ply.Prestige * 5) then
			SendChat(ply, "Level Maxed, prestige to level further.")
			return
		end
		ply.XP = ply.XP - GetReqXP(ply)
		local moneyreward = 65 + math.floor((ply.Level ^ 1.1217) * 19 + (ply.Level * 5) + (ply.Prestige * 2.6892))
		ply.Money = ply.Money + moneyreward
		ply.Level = ply.Level + 1
		ply.StatPoints = ply.StatPoints + 1
		print(ply:Nick().." has leveled up from Level "..ply.Level.." to Level ".. ply.Level + 1 .." with a reward of "..moneyreward.." "..Config["Currency"].."s and reduction of "..GetReqXP(ply).." XP! (XP now: "..ply.XP..")")
		SendChat(ply, translate.Format("PlyLevelUp", ply.Level, moneyreward, Config["Currency"]))
		ply:ConCommand("playvol theeternalapocalypse/levelup.wav 0.55")
		
		ply:SetNWInt("PlyLevel", ply.Level)
		
		TEANetUpdatePeriodicStats(ply)
		
		timer.Simple(0.05, function() -- Timer was created to prevent Buffer Overflow if user has too much XP if user levels up
			if ply.XP >= GetReqXP(ply) and tonumber(ply.Level) < 50 + (ply.Prestige * 5) then
					PlayerGainLevel(ply) -- This is so the user will gain another level if user has required xp for next level and will repeat
			end
		end)
	end
end

net.Receive("Prestige", function(length, ply)
GainPrestige(ply)
end)

-- Always forever --
function GainPrestige(ply)
	if !ply:Alive() then SendChat(ply, "Must be alive in order to prestige!") return end
	if tonumber(ply.Level) >= 50 + (5 * ply.Prestige) then
		ply.Prestige = ply.Prestige + 1
		ply.Level = 1
		ply.XP = 0
		if tonumber(ply.Prestige) >= 10 then
			ply.StatPoints = 5
		else
			ply.StatPoints = 0
		end

		for k, v in pairs(StatsListServer) do
			local TheStatPieces = string.Explode(";", v)
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end

		util.ScreenShake(ply:GetPos(), 50, 0.5, 1.5, 800)
		net.Start("PrestigeEffect")
		net.Send(ply)
		local prestige = ply.Prestige
		if tonumber(prestige) == 1 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo1", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 2 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo2", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 3 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo3", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 4 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo4", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 5 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo5", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 6 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo6", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 8 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo8", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 10 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo10", prestige), Color(155,255,255,255), true)
		elseif tonumber(prestige) == 15 then
			SystemMessage(ply, translate.ClientFormat(ply, "PlyPrestigedTo15", prestige), Color(155,255,255,255), true)
		else
			local moneyprestigereward = math.floor(1603 + (1129 * prestige) + (((prestige * 1.592) * (3 * ply.Level)) ^ 1.392)) --gives players money if they prestige without gaining any other advantage except for more levels
			ply.Money = ply.Money + moneyprestigereward
			SystemMessage(ply, translate.ClientFormat(ply, "PlyHasPrestiged", prestige, moneyprestigereward, Config["Currency"]), Color(155,255,255,255), true)
		end
		SystemBroadcast(translate.Format("PlayerPrestigedTo", ply:Nick(), prestige), Color(155,205,255,255), true)
		ply:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 90, math.Rand(75,90))
		ply:EmitSound("ambient/machines/thumper_hit.wav", 120, 50)
		local effectdata = EffectData()
		effectdata:SetOrigin(ply:GetPos() + Vector(0, 0, 60))
		util.Effect("zw_master_strike", effectdata)

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdatePerks(ply)
		TEANetUpdateStatistics(ply)

		ply:SetNWInt("PlyBounty", ply.Bounty)
		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", prestige)
		CalculateMaxHealth(ply)
		CalculateMaxArmor(ply)
		CalculateJumpPower(ply)
	else
		SystemMessage(ply, "You must be at least level ".. 50 + (5 * ply.Prestige) .." to prestige!", Color(255,155,155,255), true)
		ply:ConCommand("playgamesound buttons/button10.wav")
	end
end

function PrepareStats(ply)
	if !ply:IsValid() then return false end
	local armorstr = ply:GetNWString("ArmorType") or "none"
	local armortype = ItemsList[armorstr]
-- set the stats to default values for a fresh spawn
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	if armorstr and armortype then
		ply.Battery = 100 + armortype["ArmorStats"]["battery"]
	else
		ply.Battery = 100
	end
	ply.HPRegen = 0
	ply.SurvivalTime = math.floor(CurTime())
	ply.SlowDown = false
	ply.IsAlive = true

-- send their stats to them so their hud can display it (this function is called every tick, see server/netstuff.lua)
	TEANetUpdateStats(ply)
end


function FullyUpdatePlayer(ply)
	if !ply:IsValid() then return end

	net.Start("UpdateInventory")
	net.WriteTable(ply.Inventory)
	net.Send(ply)

	ply:SetNWInt("PlyBounty", ply.Bounty)
	ply:SetNWInt("PlyLevel", ply.Level)
	ply:SetNWInt("PlyPrestige", ply.Prestige)

	TEANetUpdatePeriodicStats(ply)
	TEANetUpdatePerks(ply)
	TEANetUpdateStatistics(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
end