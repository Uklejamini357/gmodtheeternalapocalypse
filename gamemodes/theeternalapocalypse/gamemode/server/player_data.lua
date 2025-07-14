function GM:SetStartingVariables(ply)
	ply.Money = tonumber(self.Config["StartMoney"])
	ply.ChosenModel = "models/player/kleiner.mdl"
	ply.XP = 0 
	ply.Level = 1
	ply.Prestige = 0
	ply.StatPoints = 0
	ply.PerkPoints = 0
	ply.EquippedArmor = "none"
	ply:SetNWString("ArmorType", ply.EquippedArmor)
	ply.StatsReset = 0
	ply.CurrentTask = ""
	ply.CurrentTaskProgress = 0
	ply.TaskCooldowns = {}
	ply.LastSessionInfo = nil
	ply.Statistics = {
		BestSurvivalTime = 0,
		ZombieKills = 0,
		PlayersKilled = 0,
		Deaths = 0,
	}

	ply.Inventory = table.Copy(self.Config["NewbieGear"])
	ply.Vault = table.Copy(self.Config["NewbieVault"])
	ply.UnlockedPerks = {}

	ply.MasteryMeleeXP = 0
	ply.MasteryMeleeLevel = 0
	ply.MasteryPvPXP = 0
	ply.MasteryPvPLevel = 0

	for statname, _ in pairs(self.StatConfigs) do
		ply["Stat"..statname] = 0
	end
end

function GM:CorrectPlayerDataFromPreviousVersions(ply, prevdata)
	if ply.Statistics["ZKills"] then
		ply.Statistics["ZombieKills"] = ply.Statistics["ZKills"]
		ply.Statistics["ZKills"] = nil
	end

	if ply.Statistics["playerskilled"] then
		ply.Statistics["PlayersKilled"] = ply.Statistics["playerskilled"]
		ply.Statistics["playerskilled"] = nil
	end

	if ply.Statistics["playerdeaths"] then
		ply.Statistics["Deaths"] = ply.Statistics["playerdeaths"]
		ply.Statistics["playerskilled"] = nil
	end

	if !prevdata.perkpoints then
		ply.PerkPoints = ply.Prestige
	end

end

function GM:LoadPlayer(ply, id)
	local filedir
	local filedir_ply
	if self.PlayerCharactersTest then
		filedir = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_").."/characters")
		filedir_ply = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_") .."/characters/"..tostring(id)..".txt")
	else
		filedir = self.DataFolder.."/players"
		filedir_ply = self.DataFolder.."/players/".. string.lower(string.gsub(ply:SteamID(), ":", "_")) ..".txt"
	end

	gamemode.Call("SetStartingVariables", ply)

	if not file.IsDir(filedir, "DATA") then
		file.CreateDir(filedir)
	end

	if (file.Exists(filedir_ply, "DATA")) then
		local method = self.Config.SFS and sfs.decode or util.JSONToTable
		local tbl = method(file.Read(filedir_ply, "DATA"))

		if self:GetDebug() >= DEBUGGING_NORMAL then
			PrintTable(tbl)
		end

		local prevdata = {}

		for var,value in pairs(tbl) do
			if var == "PerkPoints" then
				prevdata.perkpoints = true
			end

			if var == "BestSurvivalTime" or var == "ZKills" or var == "playerskilled" or var == "playerdeaths" then
				ply.Statistics[var] = value
			else
				ply[var] = value
			end
		end

		self:CorrectPlayerDataFromPreviousVersions(ply, prevdata)

		ply:SetNWInt("PlyLevel", ply.Level)
		ply:SetNWInt("PlyPrestige", ply.Prestige)
		ply:SetNWString("ArmorType", ply.EquippedArmor)
		
		self:DebugLog("Loading player data: "..ply:Nick().." ("..ply:SteamID()..") Level: "..tostring(ply.Level).." Cash: $"..tostring(ply.Money).." XP Total: "..tostring(ply.XP).." Armor Equipped: "..tostring(ply.EquippedArmor))
		self:DebugLog("Loaded player: ".. ply:Nick() .." ("..ply:SteamID()..") from file: "..filedir_ply)

		self:NetUpdatePerks(ply)
	else
		print("Created a new profile for "..ply:Nick() .." ("..ply:SteamID()..")")
		self:DebugLog("Created new data file for: "..ply:Nick().." ("..ply:SteamID()..") located at: "..filedir_ply)

		self:SavePlayer(ply)

	end

	return true
end


function GM:SavePlayer(ply, force)
	if not force and (ply.NoDataSave or not self.DatabaseSaving) then return end
	local filedir = self.DataFolder.."/players/"
	local plyfile = self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")..".txt")

	if not file.IsDir(filedir, "DATA") then
		file.CreateDir(filedir)
	end

	local Data = {}
	Data["XP"] = ply.XP
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
	Data["TaskCooldowns"] = ply.TaskCooldowns

	Data["MasteryMeleeXP"] = ply.MasteryMeleeXP
	Data["MasteryMeleeLevel"] = ply.MasteryMeleeLevel
	Data["MasteryPvPXP"] = ply.MasteryPvPXP
	Data["MasteryPvPLevel"] = ply.MasteryPvPLevel

	Data["Inventory"] = ply.Inventory
	Data["InvalidInventory"] = ply.InvalidInventory
	Data["Vault"] = ply.Vault
	Data["UnlockedPerks"] = ply.UnlockedPerks

	Data["Statistics"] = ply.Statistics

	if ply:Alive() or ply.LastSessionInfo then
		local lastsessioninfo = {}
		if ply:Alive() then
			lastsessioninfo["health"] = ply:Health()
			lastsessioninfo["armor"] = ply:Armor()
			lastsessioninfo["bounty"] = ply.Bounty
			lastsessioninfo["stamina"] = ply.Stamina
			lastsessioninfo["oxygen"] = ply.Oxygen
			lastsessioninfo["hunger"] = ply.Hunger
			lastsessioninfo["thirst"] = ply.Thirst
			lastsessioninfo["fatigue"] = ply.Fatigue
			lastsessioninfo["infection"] = ply.Infection
			lastsessioninfo["battery"] = ply.Battery
			lastsessioninfo["hpregen"] = ply.HPRegen
			lastsessioninfo["survivaltime"] = CurTime() - ply.SurvivalTime
			lastsessioninfo["lastmap"] = game.GetMap()
			lastsessioninfo["lastpos"] = ply:GetPos()
			lastsessioninfo["lastang"] = ply:EyeAngles()
			lastsessioninfo["LifeStats"] = ply.LifeStats

			lastsessioninfo["weapons"] = {}
			for k,v in pairs(ply:GetWeapons()) do
				table.insert(lastsessioninfo["weapons"], {v:GetClass(), v:Clip1(), v:Clip2()})
			end
			lastsessioninfo["ammo"] = {}
			for k,v in pairs(ply:GetAmmo()) do
				table.insert(lastsessioninfo["ammo"], {game.GetAmmoName(k), v})
			end

			local activewep = ply:GetActiveWeapon()
			if activewep:IsValid() then
				lastsessioninfo["heldweapon"] = activewep:GetClass()
			end
		end

		Data["LastSessionInfo"] = ply.LastSessionInfo or lastsessioninfo
	end

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


	self:DebugLog("Saving player data: "..ply:Nick().." ("..ply:SteamID().."), Level: "..tostring(ply.Level)..", Cash: $"..tostring(ply.Money)..", XP Total: "..tostring(ply.XP)..", Armor Equipped: "..tostring(ply.EquippedArmor))
	
	if self:GetDebug() >= DEBUGGING_NORMAL then
		print("✓ ".. ply:Nick() .." profile saved")
	end

	local method = self.Config.SFS and sfs.encode or util.TableToJSON
	if self.Config["FileSystem"] == "Legacy" then
		file.Write(plyfile, method(Data, self.Config.SFS and 50000 or true))
	elseif self.Config["FileSystem"] == "PData" then
		ply:SetPData("tea_playerdata", method(Data,self.Config.SFS and 50000 or false))
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
		return false
	end

	self:DebugLog("Saved player: "..ply:Nick().." ("..ply:SteamID()..") to file: "..plyfile)
end

function GM:DeletePlayerData(ply)
	if not ply.AllowSaveDelete then print("Preventing accidental player data deletion!") return end
	local filedir_ply = self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_"))..".txt"
	if not file.Exists(filedir_ply, "DATA") then
		return
	end
	file.Delete(filedir_ply)
	print("File deleted!")

	ply:KillSilent()
	gamemode.Call("SetStartingVariables", ply)
	ply:Spawn()
end

function GM:LoadPlayerInventory(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player inventory file that doesn't exist!") return end
	ply.Inventory = {}

	local LoadedData
	local InvalidData
	local fs = self.Config["FileSystem"]
	if fs == "Legacy" then
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", "DATA")) then
			LoadedData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/inventory.txt"), "DATA")
		end
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", "DATA")) then
			InvalidData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/invalid_inventory.txt"), "DATA")
		end
	elseif fs == "PData" then
		LoadedData = ply:GetPData("tea_playerinventory")
		InvalidData = ply:GetPData("tea_invalidinventory")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local method = self.Config.SFS and sfs.decode or util.JSONToTable
		local formatted = method(LoadedData)
		local invaliditems = {}
		if InvalidData then
			invaliditems = method(InvalidData) --save invalid items just in case
		end
		for k,v in pairs(formatted) do
			if !self.ItemsList[k] then
				invaliditems[k] = formatted[k]
				formatted[k] = nil
			end
		end
		for k,v in pairs(invaliditems) do
			if self.ItemsList[k] then
				formatted[k] = invaliditems[k]
				invaliditems[k] = nil
			end
		end
		if self:GetDebug() >= DEBUGGING_ADVANCED then
			print("Loading Inventory\n\n")
			PrintTable(formatted)
			print("\nInvalid Items:")
			PrintTable(invaliditems)
		end
		ply.Inventory = formatted
		ply.InvalidInventory = invaliditems
	else
		ply.Inventory = table.Copy(self.Config["NewbieGear"])
	end

	timer.Simple(1, function()
		GAMEMODE:SendInventory(ply)
	end)
end


function GM:SavePlayerInventory(ply, force)
	if !ply:IsValid() then return end
	if not force and (ply.NoDataSave or not self.DatabaseSaving) then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/inventory.txt", data)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/invalid_inventory.txt", invaliddata)
		if self:GetDebug() >= DEBUGGING_NORMAL then
			print(Format("✓ %s inventory saved", ply:Nick()))
		end
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.Inventory)
		local invaliddata = util.TableToJSON(ply.InvalidInventory)
		ply:SetPData("tea_playerinventory", formatted)
		ply:SetPData("tea_invalidinventory", invaliddata)
		if self:GetDebug() >= DEBUGGING_NORMAL then
			print(Format("✓ %s inventory saved", ply:Nick()))
		end
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end
function GM:LoadPlayerPerks(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player perks file that doesn't exist!") return end
	ply.UnlockedPerks = {}

	local LoadedData
	if self.Config["FileSystem"] == "Legacy" then
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/perks.txt", "DATA")) then
			LoadedData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/perks.txt"), "DATA")
		end
	elseif self.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("tea_playerperks")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)

        if self:GetDebug() >= DEBUGGING_ADVANCED then
			print("Loading perks:\n\n")
			PrintTable(formatted)
		end
		ply.UnlockedPerks = formatted
	end
end


function GM:SavePlayerPerks(ply, force)
	if !ply:IsValid() then return end
	if not force and (ply.NoDataSave or not self.DatabaseSaving) then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.UnlockedPerks)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/perks.txt", data)
        if self:GetDebug() >= DEBUGGING_NORMAL then
            print(Format("✓ %s perks saved", ply:Nick()))
        end
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.UnlockedPerks)
		ply:SetPData("tea_playerperks", formatted)
        if self:GetDebug() >= DEBUGGING_NORMAL then
            print(Format("✓ %s perks saved", ply:Nick()))
        end
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end

function GM:LoadPlayerVault(ply)
	local LoadedData
	if self.Config["FileSystem"] == "Legacy" then
		if file.Exists(self.DataFolder.."/players/".. string.lower(string.gsub( ply:SteamID(), ":", "_").."/vault.txt"), "DATA") then
			LoadedData = file.Read(self.DataFolder.."/players/".. string.lower(string.gsub( ply:SteamID(), ":", "_").."/vault.txt"), "DATA")
		end
	elseif self.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("ate_playervault")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)
		ply.Vault = formatted
	else
		ply.Vault = table.Copy(self.Config["NewbieVault"])
	end

	timer.Simple(1, function() gamemode.Call("SendVault", ply) end)
	timer.Simple(2, function() gamemode.Call("SavePlayerVault", ply) end)
end


function GM:SavePlayerVault(ply)
	if not force and (ply.NoDataSave or not self.DatabaseSaving) then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Vault)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_").."/vault.txt"), data)
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.Vault)
		ply:SetPData("ate_playervault", formatted)
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
	print("✓ ".. ply:Nick() .." vault saved")
end

local count,maxcount = 0, 0
local importing
function GM:Import_Player_Saves_From_0_11_3a_And_Below(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then return end


	local demo = false
	local function writeFile(...)
		if demo then return end
		file.Write(...)
	end
	local function deleteFile(...)
		if demo then return end
		file.Delete(...)
	end
	local OMsgC = MsgC
	local function MsgC(...)
		if IsValid(ply) then
			local t = {...}
			local str = ""
			for _,var in pairs(t) do
				if type(var) == "table" then
					if str == "" then
						str = "Color("..var.r..", "..var.g..", "..var.b..")"
					else
						str = str..", Color("..var.r..", "..var.g..", "..var.b..")"
					end
				elseif type(var) == "string" then
					if str == "" then
						str = "[["..var.."]]"
					else
						str = str..", [["..var.."]]"
					end
				
				end

			end

			ply:SendLua("MsgC("..str..") MsgN()")
		else
			OMsgC(...)
			MsgN()
		end
	end

	if importing then
		if IsValid(ply) then
			ply:PrintMessage(3, "Importing Progress: "..count.."/"..maxcount..(count == maxcount and " (DONE)" or ""))
		else
			MsgC(Color(255,0,0), "Importing Progress: "..count.."/"..maxcount..(count == maxcount and " (DONE)" or ""))
		end
		return
	end
	
	local id = IsValid(ply) and ply:EntIndex() or 0

	if not timer.Exists("TEA.ImportSavesConfirmation_"..id) then
		MsgC(Color(255,0,0), "You have activated the saves importing script.")
		MsgC(Color(255,0,0), "This function is available only for superadmins and server operators.")
		MsgC(Color(255,0,0), "When importing player saves, be sure you make a backup them...")
		MsgC(Color(255,0,0), "...as you might not know what can go wrong and can cause you to lose saves!")
		MsgC(Color(255,0,0), "Once you begin, all online players will have their auto saves disabled.")
		MsgC(Color(255,0,0), "REMEMBER: This works on saves from 0.11.3a, but it has not been confirmed if it will also work for older versions.")
		MsgC(Color(255,0,0), "YOU HAVE BEEN WARNED! I am not responsible for any data loss! After running the command you acknowledge that you are held responsible for any data loss.")
		MsgC(Color(255,0,0), "You have 1 minute to confirm. Run the command again to proceed.")

		timer.Create("TEA.ImportSavesConfirmation_"..id, 60, 1, function()
			MsgC(Color(255,0,0), "Timed out.")
			confirmation = false
		end)

		confirmation = true
		return
	else
		timer.Remove("TEA.ImportSavesConfirmation_"..id)
	end

	importing = true


	local timecounttotal = CurTime()
	local function time(t, func)
		timecounttotal = timecounttotal + t
		timer.Simple(timecounttotal - CurTime(), func)
	end
	MsgC(Color(0,255,255), "Beginning the operation.")
	MsgC(Color(0,255,255), "Finding the player tables.")
	local maindir = self.DataFolder.."/players/"

	local _,dirs = file.Find(maindir.."*", "DATA")
	time(engine.TickInterval(), function()
		for k,v in pairs(dirs) do
			maxcount = maxcount + 1
		end
		MsgC(Color(0,255,255), "Found "..maxcount.." directories!")
	end)

	if not demo then
		for _,pl in pairs(player.GetAll()) do
			pl.NoDataSave = true
			pl:PrintTranslatedMessage(3, "data_import_player_warning_savedisabled")
		end
	end

	time(engine.TickInterval(), function()
		for _,dir in pairs(dirs) do
			local data = {}
			local searchdir = maindir..dir.."/"

			for k,v in pairs(file.Find(searchdir.."*", "DATA")) do
				if file.Exists(searchdir..v, "DATA") then
					if v == "profile.txt" then
						local TheFile = file.Read(searchdir..v, "DATA")
						local DataPieces = string.Explode("\n", TheFile)

						local Output = {}
						local perkpoints

						for k, v in pairs(DataPieces) do
							local TheLine = string.Explode(";", v)
							local id, var = TheLine[1], TheLine[2]
							data[id] = tonumber(var) or var

							if id == "TaskCooldowns" or id == "LastSessionInfo" then
								data[id] = util.JSONToTable(var)
							end
						end
					elseif v == "inventory.txt" then
						data["Inventory"] = util.JSONToTable(file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( dir, ":", "_").."/inventory.txt"), "DATA"))
					elseif v == "invalid_inventory.txt" then
						data["InvalidInventory"] = util.JSONToTable(file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( dir, ":", "_").."/invalid_inventory.txt"), "DATA"))
					elseif v == "perks.txt" then
						data["UnlockedPerks"] = util.JSONToTable(file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( dir, ":", "_").."/perks.txt"), "DATA"))
					elseif v == "vault.txt" then
						data["Vault"] = util.JSONToTable(file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( dir, ":", "_").."/vault.txt"), "DATA"))
					end
				end
			end

			MsgC(Color(255,0,0), "Making players folder backup and deleting original files...")
			for _,v in pairs(file.Find(searchdir.."*", "DATA")) do
				-- Back them up just in case
				local backupdir = self.DataFolder.."/players_backup_pre0_11_3/"..dir
				if not file.IsDir(backupdir, "DATA") then
					file.CreateDir(backupdir)
				end

				for _,_file in pairs(file.Find(searchdir.."*", "DATA")) do
					writeFile(backupdir.."/".._file, file.Read(searchdir.._file, "DATA"))
					-- Delete original files and directory
					deleteFile(searchdir.._file)
				end
			end
			deleteFile(searchdir)
			MsgC(Color(255,0,0), "Done!")
			
			
			MsgC(Color(255,0,0), "Processing the newly imported data...")
			time(engine.TickInterval(), function()
				count = count + 1
				MsgC(Color(255,0,0), "Player in database: No."..count)

				local savefile = self.DataFolder.."/players/"..string.lower(string.gsub(dir, ":", "_")..".txt")
				writeFile(savefile, util.TableToJSON(data, true))
				MsgC(Color(255,0,0), "Saved to "..savefile.."!")

				if maxcount == count then
					MsgC(Color(255,0,0), "All old saves have been imported!")
					MsgC(Color(255,0,0), "Note: You might need to restart the map.")
				end
			end)
		end
	end)
end
concommand.Add("tea_sv_performplayerdataimport", function(ply)
	GAMEMODE:Import_Player_Saves_From_0_11_3a_And_Below(ply)
end)


--Bonus multipliers for various supporters (and the dev)
function GM:XPBonus(ply)
	if !ply:IsValid() then return 0 end
	local xpmul = 1
	if ply:HasPerk("xpboost") then
		xpmul = xpmul + 0.1
	end
	if ply:HasPerk("xpboost2") then
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
	if ply:HasPerk("cashboost") then
		cashmul = cashmul + 0.05
	end
	if ply:HasPerk("cashboost2") then
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
		ply:SendChat(translate.ClientGet(ply, "max_level_reached"))
	end
end

net.Receive("Prestige", function(length, ply)
	if !ply:Alive() then ply:SendChat(translate.ClientGet(ply, "must_be_alive_to_prestige")) return end
	if tonumber(ply.Level) >= ply:GetMaxLevel() then
		gamemode.Call("GainPrestige", ply)
	else
		ply:SystemMessage(translate.ClientFormat(ply, "must_be_at_least_lvl_to_prestige", ply:GetMaxLevel()), Color(255,155,155), true)
		ply:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
	end
end)

function GM:GainPrestige(ply)
	local prestige = ply.Prestige + 1
	ply.Prestige = prestige
	ply.Level = 1
	ply.XP = 0
	ply.StatPoints = (ply:HasPerk("skillpointsbonus") and 5 or 0) + (ply:HasPerk("skillpointsbonus2") and prestige or 0)
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
	ply.Battery = ply:GetMaxBattery()
	ply.HPRegen = 0
	ply.SurvivalTime = CurTime()
	ply.SlowDown = 0
	ply.IsAlive = true

	-------- Survival Stats --------
	ply.LifeStats = {
		ZombieKills = 0,
		PlayerKills = 0
	}
	----------------


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

local meta = FindMetaTable("Player")

function meta:LoadLastSession()
	if self.LastSessionInfo then
		if self.LastSessionInfo["health"] then
			self:SetHealth(self.LastSessionInfo["health"])
		end

		if self.LastSessionInfo["armor"] then
			self:SetArmor(self.LastSessionInfo["armor"])
		end

		if self.LastSessionInfo["health"] then
			self.Bounty = self.LastSessionInfo["bounty"]
		end

		if self.LastSessionInfo["stamina"] then
			self.Stamina = self.LastSessionInfo["stamina"]
		end

		if self.LastSessionInfo["oxygen"] then
			self.Stamina = self.LastSessionInfo["oxygen"]
		end

		if self.LastSessionInfo["hunger"] then
			self.Hunger = self.LastSessionInfo["hunger"]
		end

		if self.LastSessionInfo["thirst"] then
			self.Thirst = self.LastSessionInfo["thirst"]
		end

		if self.LastSessionInfo["fatigue"] then
			self.Fatigue = self.LastSessionInfo["fatigue"]
		end

		if self.LastSessionInfo["infection"] then
			self.Infection = self.LastSessionInfo["infection"]
		end

		if self.LastSessionInfo["battery"] then
			self.Battery = self.LastSessionInfo["battery"]
		end

		if self.LastSessionInfo["hpregen"] then
			self.HPRegen = self.LastSessionInfo["hpregen"]
		end

		if self.LastSessionInfo["survivaltime"] then
			self.SurvivalTime = CurTime() - self.LastSessionInfo["survivaltime"]
		end

		if self.LastSessionInfo["LifeStats"] then
			self.LifeStats = self.LastSessionInfo["LifeStats"]
		end

		local lastmap = self.LastSessionInfo["lastmap"]

		if lastmap == game.GetMap() then
			if self.LastSessionInfo["lastpos"] then
				self:SetPos(self.LastSessionInfo["lastpos"])
			end

			if self.LastSessionInfo["lastang"] then
				self:SetEyeAngles(self.LastSessionInfo["lastang"])
			end
		end

		if self.LastSessionInfo["weapons"] then
			for _,wep in pairs(self.LastSessionInfo["weapons"]) do
				local w = self:Give(wep[1], true)
				if w:IsValid() then
					w:SetClip1(wep[2])
					w:SetClip2(wep[3])
				end
			end
		end

		if self.LastSessionInfo["ammo"] then
			for _,ammo in pairs(self.LastSessionInfo["ammo"]) do
				self:SetAmmo(ammo[2],ammo[1])
			end
		end

		if self.LastSessionInfo["heldweapon"] then
			self:SelectWeapon(self.LastSessionInfo["heldweapon"])
		end

		self.LastSessionInfo = nil
	end
end

function meta:ArmorEquip(item)
	if item == "none" then return end
	self.EquippedArmor = tostring(item)
	self:SetNWString("ArmorType", tostring(item))
	self:OnEquippedArmor(item)
end

function meta:ArmorUnequip()
	local item = self.EquippedArmor
	self.EquippedArmor = "none"
	self:SetNWString("ArmorType", "none")
	gamemode.Call("RecalcPlayerModel", self)
	gamemode.Call("RecalcPlayerSpeed", self)
	self:OnUnequippedArmor(item)
end

function meta:OnEquippedArmor(item)
	self:SystemMessage("You equipped "..GAMEMODE:GetItemName(item, self)..".", Color(205,255,205,255), false)
	gamemode.Call("RecalcPlayerModel", self)
	gamemode.Call("RecalcPlayerSpeed", self)
end

function meta:OnUnequippedArmor(item)
	self:SystemMessage(Format("You unequipped %s.", GAMEMODE:GetItemName(item, self)), Color(205,255,205,255), false)
end



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
	*/
		end

		tbl[i] = t
	end

	return tbl
end

