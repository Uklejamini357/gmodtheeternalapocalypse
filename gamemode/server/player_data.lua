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
		ply:SetNWString("ArmorType", ply.EquippedArmor) -- i really shouldnt have 2 different vars for this but whatever, im beyond caring at this point

		ate_DebugLog( "Loading player data: " .. ply:Nick() .." ( "..ply:SteamID().." ) Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor) )

		net.Start("UpdatePeriodicStats")
		net.WriteFloat( ply.Level )
		net.WriteFloat( ply.Money )
		net.WriteFloat( ply.XP )
		net.WriteFloat( ply.StatPoints )
		net.WriteFloat( ply.Bounty )
		net.Send( ply )

		net.Start("UpdatePerks")
		net.WriteFloat( ply.StatDefense )
		net.WriteFloat( ply.StatDamage )
		net.WriteFloat( ply.StatSpeed )
		net.WriteFloat( ply.StatHealth )
		net.WriteFloat( ply.StatKnowledge )
		net.WriteFloat( ply.StatMedSkill )
		net.WriteFloat( ply.StatStrength )
		net.WriteFloat( ply.StatEndurance )
		net.WriteFloat( ply.StatSalvage )
		net.WriteFloat( ply.StatBarter )
		net.WriteFloat( ply.StatEngineer )
		net.WriteFloat( ply.StatImmunity )
		net.WriteFloat( ply.StatSurvivor )
		net.Send( ply )

	else

		ply.ChosenModel = "models/player/kleiner.mdl"
		ply.XP = 0 
		ply.Level = 1
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

		net.Start("UpdatePeriodicStats")
		net.WriteFloat( ply.Level )
		net.WriteFloat( ply.Money )
		net.WriteFloat( ply.XP )
		net.WriteFloat( ply.StatPoints )
		net.WriteFloat( ply.Bounty )
		net.Send( ply )

	end

end


function SavePlayer( ply )
local Data = {}

--	Data[ "ChosenModel" ] = ply.ChosenModel
	Data[ "XP" ] = ply.XP
	Data[ "Level" ] = ply.Level
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

	net.Start("UpdatePeriodicStats")
	net.WriteFloat( ply.Level )
	net.WriteFloat( ply.Money )
	net.WriteFloat( ply.XP )
	net.WriteFloat( ply.StatPoints )
	net.WriteFloat( ply.Bounty )
	net.WriteFloat( ply.Battery )
	net.Send( ply )

	ate_DebugLog( "Saving player data: " .. ply:Nick() .." ( "..ply:SteamID().." ) Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor) )

	net.Start("UpdatePerks")
	net.WriteFloat( ply.StatDefense )
	net.WriteFloat( ply.StatDamage )
	net.WriteFloat( ply.StatSpeed )
	net.WriteFloat( ply.StatHealth )
	net.WriteFloat( ply.StatKnowledge )
	net.WriteFloat( ply.StatMedSkill )
	net.WriteFloat( ply.StatStrength )
	net.WriteFloat( ply.StatEndurance )
	net.WriteFloat( ply.StatSalvage )
	net.WriteFloat( ply.StatBarter )
	net.WriteFloat( ply.StatEngineer )
	net.WriteFloat( ply.StatImmunity )
	net.WriteFloat( ply.StatSurvivor )
	net.Send( ply )

	print("✓ ".. ply:Nick() .." profile data saved into database")


	file.Write( "theeternalapocalypse/players/" ..string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt"), StringToWrite )
	ate_DebugLog( "Saved player: " .. ply:Nick() .." ( "..ply:SteamID().." ) to file: ".."theeternalapocalypse/players/" ..string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/profile.txt") )
end


--level up
function PlayerGainLevel( ply )
/*	if tonumber(ply.Level) >= 1000000000 then
		SendChat( ply, "Level Maxed" )
		return
	end */
--Haha no level limit go brr

	if ply.XP >= GetReqXP( ply ) then
		ply.XP = ply.XP - GetReqXP( ply )
		print(""..ply:Nick().." has leveled up from Level "..ply.Level.." to Level ".. ply.Level + 1 .." with a reward of ".. 62 + ((ply.Level ^ 1.046) * 19) .." "..Config[ "Currency" ].."s and reduction of "..GetReqXP(ply).." XP! (XP now: "..ply.XP..")")
		ply.Level = ply.Level + 1
		ply.StatPoints = ply.StatPoints + 1
		ply.Money = ply.Money + 62 + ((ply.Level ^ 1.046) * 19)
		SendChat( ply, "Congratulations! You are now level " .. ply.Level .. ", you have gained 1 skill point and " .. 62 + ((ply.Level ^ 1.046) * 19) .. " "..Config[ "Currency" ].."s!" )
		ply:ConCommand( "playgamesound theeternalapocalypse/levelup.wav" )

		ply:SetNWInt( "PlyLevel", ply.Level )

		net.Start("UpdatePeriodicStats")
		net.WriteFloat( ply.Level )
		net.WriteFloat( ply.Money )
		net.WriteFloat( ply.XP )
		net.WriteFloat( ply.StatPoints )
		net.WriteFloat( ply.Bounty )
		net.Send( ply )
		timer.Simple(0.03, function() -- Timer was created to prevent Buffer Overflow if user has too much XP if user levels up
		PlayerGainLevel(ply) -- This is so the user will gain another level if user has required xp for next level and will repeat
		end)

	end
end

function PrepareStats( ply )
if !ply:IsValid() then return false end

-- set the stats to default values for a fresh spawn
ply.Stamina = 100
ply.Hunger = 10000
ply.Fatigue = 0
ply.Infection = 0

-- send that shit to them so their hud can display it (this function is called every tick)
net.Start("UpdateStats")
net.WriteFloat( ply.Stamina )
net.WriteFloat( ply.Hunger )
net.WriteFloat( ply.Fatigue )
net.WriteFloat( ply.Infection )
net.Send( ply )

end


function FullyUpdatePlayer( ply )

if !ply:IsValid() then return end

	net.Start("UpdateInventory")
	net.WriteTable( ply.Inventory )
	net.Send( ply )

	net.Start("UpdatePeriodicStats")
	net.WriteFloat( ply.Level )
	net.WriteFloat( ply.Money )
	net.WriteFloat( ply.XP )
	net.WriteFloat( ply.StatPoints )
	net.WriteFloat( ply.Bounty )
	net.Send( ply )

	ply:SetNWInt( "PlyBounty", ply.Bounty )
	ply:SetNWInt( "PlyLevel", ply.Level )

	net.Start("UpdatePerks")
	net.WriteFloat( ply.StatDefense )
	net.WriteFloat( ply.StatDamage )
	net.WriteFloat( ply.StatSpeed )
	net.WriteFloat( ply.StatHealth )
	net.WriteFloat( ply.StatKnowledge )
	net.WriteFloat( ply.StatMedSkill )
	net.WriteFloat( ply.StatStrength )
	net.WriteFloat( ply.StatEndurance )
	net.WriteFloat( ply.StatSalvage )
	net.WriteFloat( ply.StatBarter )
	net.WriteFloat( ply.StatEngineer )
	net.WriteFloat( ply.StatImmunity )
	net.WriteFloat( ply.StatSurvivor )
	net.Send( ply )

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send( ply )
end