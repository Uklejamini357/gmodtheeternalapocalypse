function LoadPlayer( ply )

if not file.IsDir("theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" )) .. "", "DATA") then
   file.CreateDir("theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. ""))
end
	if (file.Exists( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt"), "DATA" )) then
		local TheFile = file.Read( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt"), "DATA" )
		local DataPieces = string.Explode( "\n", TheFile )

		local Output = {}

		for k, v in pairs( DataPieces ) do
			local TheLine = string.Explode( ";", v ) -- convert txt string to stats table

			ply[TheLine[1]] = TheLine[2]  -- dump all their stats into their player table
--			print(TheLine[1].." = "..TheLine[2])
		end

--		print( "Loaded player: " .. ply:Nick() .." ( "..ply:SteamID().." )" )
		ate_DebugLog( "Loaded player: " .. ply:Nick() .." ( "..ply:SteamID().." ) from file: ".."theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt") )

		ply:SetNWInt( "PlyLevel", ply.Level )
		net.WriteFloat( "PlyPrestige", ply.Prestige )
		ply:SetNWString("ArmorType", ply.EquippedArmor) -- i really shouldnt have 2 different vars for this but whatever, im beyond caring at this point

		ate_DebugLog( "Loading player data: " .. ply:Nick() .." ( "..ply:SteamID().." ) Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor) )

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdatePerks(ply)

	else

		ply.ChosenModel = "models/player/kleiner.mdl"
		ply.BestSurvivalTime = 0
		ply.XP = 0 
		ply.Level = 1
		ply.Prestige = 0
		ply.Money = tonumber(Config[ "StartMoney" ])
		ply.StatPoints = 0
		ply.EquippedArmor = "none"
		
		for k, v in pairs( StatsListServer ) do
			local TheStatPieces = string.Explode( ";", v )
			local TheStatName = TheStatPieces[1]
			ply[TheStatName] = 0
		end

		print( "Created a new profile for "..ply:Nick() .." ( "..ply:SteamID().." )" )
		ate_DebugLog( "Created new data file for: " .. ply:Nick() .." ( "..ply:SteamID().." ) located at: ".."theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt") )

		SavePlayer( ply )

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdateStatistics(ply)

	end

end

net.Receive("Prestige", function(length, ply)
GainPrestige(ply)
end)

function GainPrestige(ply)
	if !ply:Alive() then SendChat(ply, "Must be alive in order to prestige!") return end
	if tonumber(ply.Level) >= 50 + (10 * ply.Prestige) then
		ply.Prestige = ply.Prestige + 1
		ply.Level = 1
		ply.XP = 0
		if tonumber(ply.Prestige) >= 20 then
			ply.StatPoints = 5
		else
			ply.StatPoints = 0
		end


		for k, v in pairs( StatsListServer ) do
			local TheStatPieces = string.Explode( ";", v )
			local TheStatName = TheStatPieces[1]
			ply[ TheStatName ] = 0
		end

		util.ScreenShake(ply:GetPos(), 50, 0.5, 1.5, 800)
		if tonumber(ply.Prestige) == 1 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now gain +5% more overall money from zombies!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 2 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now spawn with +5 more health!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 3 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now can carry +2kg more!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 4 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now jump +10 units higher!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 5 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now spawn with +5 more armor!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 10 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now can carry +3kg more!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 15 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You now take 5% less damage from all sources!", Color(155,255,255,255), true)
		elseif tonumber(ply.Prestige) == 20 then
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! Everytime you prestige, you start with 5 skill points instead of 0!", Color(155,255,255,255), true)
		else
			local moneyprestigereward = math.floor((1500 * ply.Prestige) + (((24 ^ 1.592) * (3 * ply.Level)) ^ 1.392)) --gives players money if they prestige without gaining any other advantage except for more levels
			ply.Money = ply.Money + moneyprestigereward
			SystemMessage(ply, "You have prestiged to Prestige level "..ply.Prestige.."! You have gained "..moneyprestigereward.." "..Config["Currency"].."s!", Color(155,255,255,255), true)
		end
		SystemBroadcast(ply:Nick().." has prestiged to Prestige level "..ply.Prestige.."!", Color(155,205,255,255), true)
		ply:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 90, math.Rand(75,90))
		ply:EmitSound("ambient/machines/thumper_hit.wav", 120, 50)
		local effectdata = EffectData()
		effectdata:SetOrigin(ply:GetPos() + Vector(0, 0, 60))
		util.Effect("zw_master_strike", effectdata)

		TEANetUpdatePeriodicStats(ply)
		TEANetUpdatePerks(ply)
		TEANetUpdateStatistics(ply)

		ply:SetNWInt( "PlyBounty", ply.Bounty )
		ply:SetNWInt( "PlyLevel", ply.Level )
		ply:SetNWInt( "PlyPrestige", ply.Prestige )
		CalculateMaxHealth(ply)
		CalculateMaxArmor(ply)
		CalculateJumpPower(ply)
	else
		SystemMessage(ply, "You must be at least level ".. 50 + (10 * ply.Prestige) .." to prestige!", Color(255,155,155,255), true)
		ply:ConCommand("playgamesound buttons/button10.wav")
	end
end

function SavePlayer( ply )
local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
local Data = {}

if AllowSave != 1 and tea_server_dbsaving:GetInt() < 1 then print("Warning! Database saving is disabled! Players will not have their progress saved during this time.") return end
--	Data[ "ChosenModel" ] = ply.ChosenModel
	Data[ "BestSurvivalTime" ] = ply.BestSurvivalTime
	Data[ "ZKills" ] = ply.ZKills
	Data[ "XP" ] = ply.XP
	Data[ "Level" ] = ply.Level
	Data[ "Prestige" ] = ply.Prestige
	Data[ "Money" ] = ply.Money
	Data[ "StatPoints" ] = ply.StatPoints
	Data[ "EquippedArmor" ] = ply.EquippedArmor
	Data[ "ChosenModel" ] = ply.ChosenModel
	Data[ "ChosenModelColor" ] = tostring(ply.ChosenModelColor)


	for k, v in pairs( StatsListServer ) do
		local TheStatPieces = string.Explode( ";", v )
		local TheStatName = TheStatPieces[1]
		Data[ TheStatName ] = ply[ TheStatName ]
	end


	local StringToWrite = ""
	for k, v in pairs( Data ) do
		if( StringToWrite == "" ) then
			StringToWrite = k .. ";" .. v
		else
			StringToWrite = StringToWrite .. "\n" .. k .. ";" .. v
		end
	end

	TEANetUpdatePeriodicStats(ply)
	ate_DebugLog( "Saving player data: " .. ply:Nick() .." ( "..ply:SteamID().." ) Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor) )

	TEANetUpdatePerks(ply)

	TEANetUpdateStatistics(ply)

	print("✓ ".. ply:Nick() .." profile saved into database")


	file.Write( "theeternalapocalypse/players/" ..string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt"), StringToWrite )
	ate_DebugLog( "Saved player: " .. ply:Nick() .." ( "..ply:SteamID().." ) to file: ".."theeternalapocalypse/players/" ..string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt") )
end


--level up
function PlayerGainLevel( ply )


	if ply.XP >= GetReqXP( ply ) then
		if ply.IsLevelingAllowed != true and tonumber(ply.Level) >= 50 + (ply.Prestige * 10) then
			SendChat( ply, "Level Maxed, prestige to level further." )
			return
		end
		ply.XP = ply.XP - GetReqXP( ply )
		local moneyreward = 65 + math.floor((ply.Level ^ 1.1217) * 19 + (ply.Level * 5) + (ply.Prestige * 1.6892))
		ply.Money = ply.Money + moneyreward
		ply.Level = ply.Level + 1
		ply.StatPoints = ply.StatPoints + 1
		print(""..ply:Nick().." has leveled up from Level "..ply.Level.." to Level ".. ply.Level + 1 .." with a reward of ".. moneyreward .." "..Config[ "Currency" ].."s and reduction of "..GetReqXP(ply).." XP! (XP now: "..ply.XP..")")
		SendChat( ply, "Congratulations! You are now level " .. ply.Level .. ", you have gained 1 skill point and " .. moneyreward .. " "..Config[ "Currency" ].."s!" )
		ply:ConCommand( "playgamesound theeternalapocalypse/levelup.wav" )

		ply:SetNWInt( "PlyLevel", ply.Level )

		TEANetUpdatePeriodicStats(ply)

		timer.Simple(0.05, function() -- Timer was created to prevent Buffer Overflow if user has too much XP if user levels up
		PlayerGainLevel(ply) -- This is so the user will gain another level if user has required xp for next level and will repeat
		end)

	end
end

function PrepareStats( ply )
if !ply:IsValid() then return false end

-- set the stats to default values for a fresh spawn
ply.Stamina = 100
ply.Hunger = 10000
ply.Thirst = 10000
ply.Fatigue = 0
ply.Infection = 0
ply.Battery = 100
ply.SurvivalTime = math.floor(CurTime())

-- send that shit to them so their hud can display it (this function is called every tick)
TEANetUpdateStats(ply)

end


function FullyUpdatePlayer( ply )

if !ply:IsValid() then return end

	net.Start("UpdateInventory")
	net.WriteTable( ply.Inventory )
	net.Send( ply )

	TEANetUpdatePeriodicStats(ply)

	ply:SetNWInt( "PlyBounty", ply.Bounty )
	ply:SetNWInt( "PlyLevel", ply.Level )
	ply:SetNWInt( "PlyPrestige", ply.Prestige )

	TEANetUpdatePerks(ply)

	TEANetUpdateStatistics(ply)
	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send( ply )
end