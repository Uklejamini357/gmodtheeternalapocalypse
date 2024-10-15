AddCSLuaFile("cl_init.lua") -- clientside init file
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_globals.lua")
AddCSLuaFile("sh_translate.lua")
AddCSLuaFile("sh_convars.lua")

AddCSLuaFile("sh_player.lua")
AddCSLuaFile("sh_items.lua")
AddCSLuaFile("sh_loot.lua")
AddCSLuaFile("sh_spawnables.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_crafting.lua")
AddCSLuaFile("sh_achievements.lua")
AddCSLuaFile("sh_deathsounds.lua")
AddCSLuaFile("sh_taskslist.lua")

AddCSLuaFile("client/cl_scoreboard.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/cl_createfaction.lua")
AddCSLuaFile("client/cl_modelsmenu.lua")
AddCSLuaFile("client/cl_contextmenu.lua")
AddCSLuaFile("client/cl_customdeathnotice.lua")
AddCSLuaFile("client/cl_spawnmenu.lua")
AddCSLuaFile("client/cl_tradermenu.lua")
AddCSLuaFile("client/cl_tasksmenu.lua")
AddCSLuaFile("client/cl_dermahooks.lua")
AddCSLuaFile("client/cl_lootmenu.lua")
AddCSLuaFile("client/cl_adminmenu.lua")
AddCSLuaFile("client/cl_statsmenu.lua")
AddCSLuaFile("client/cl_helpmenu.lua")
AddCSLuaFile("client/cl_bosspanel.lua")
AddCSLuaFile("client/cl_options.lua")
AddCSLuaFile("client/cl_changelogs.lua")
AddCSLuaFile("client/cl_deathscreen.lua")
AddCSLuaFile("client/cl_mainmenu.lua")
AddCSLuaFile("client/cl_perksmenu.lua")

AddCSLuaFile("client/cl_net.lua")
AddCSLuaFile("cl_killicons.lua")

AddCSLuaFile("minigames/cl_init.lua")
AddCSLuaFile("minigames/shared.lua")


include("shared.lua")


---- Serverside only ----
include("server/achievements.lua") -- just achievements
include("server/admincmd.lua") -- admin commands
include("server/devcmds.lua") -- commands for dev, do not edit unless using for good purposes
include("server/netstuff.lua") -- just some network functions
include("server/server_util.lua")
include("server/config.lua")
include("server/commands.lua") -- Drop cash, toggle pvp and such other commands
include("server/player_data.lua") -- Data management for players
include("server/player_inventory.lua") -- Player Inventory management for players
include("server/player_perks.lua") -- Data manage with Perks system
include("server/player_props.lua") -- Managing with props
include("server/player_vault.lua") -- And vault
include("server/npcspawns.lua") -- Zombie spawns
include("server/traders.lua") -- Traders
include("server/airdrops.lua") -- Airdrops
include("server/factions.lua") -- Anything here included for factions
include("server/loot_system.lua") -- loots
include("server/debug.lua") -- Debug stuff, highly advised not to edit
include("server/specialstuff.lua") -- anything uncategorized, hard to name or for server can be added here
include("server/spawnpoints.lua") -- spawnpoints
include("server/crafting.lua") -- crafting managing
include("server/mastery.lua") -- Mastery for various types, including pvp and melee
--include("server/weather_events.lua") -- excluded because file is empty
--include("time_weather.lua") -- excluded due to file being non-existant
include("server/player_quests.lua") -- Tasks and task dealers

include("server_data/data_saving.lua")

include("minigames/init.lua")
include("minigames/shared.lua")


Factions = Factions or {}

function GM:ShowHelp(ply)
end

function GM:ShowTeam(ply)
end

function GM:ShowSpare1(ply)
end

function GM:ShowSpare2(ply)
end

function GM:CalcMaxHealth(ply)
	return 100 + (5 * (ply.StatVitality or 0)) + (ply.UnlockedPerks["healthboost"] and 5 or 0) + (ply.UnlockedPerks["healthboost2"] and 8 or 0)
end

function GM:CalcMaxArmor(ply)
	return 100 + (2 * (ply.StatEngineer or 0)) + (ply.UnlockedPerks["armorboost"] and 5 or 0) --(tonumber(ply.Prestige or 0) >= 5 and 5 or 0)
end

function GM:CalcJumpPower(ply)
	return 160 + (2 * (ply.StatAgility or 0)) + (ply.UnlockedPerks["jumppowerboost"] and 10 or 0) --(tonumber(ply.Prestige or 0) >= 4 and 10 or 0)
end

function GM:OnPlayerHitGround(ply, inWater, onFloater, speed)
    if speed > (450 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(math.random(5, 6), 0, math.random(-0.3, 0.3)))
--        ply:ViewPunch(Angle(5, 0, 0))
		if !ply.StatsPaused then
			ply.Stamina = math.Clamp(ply.Stamina - (10 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    elseif speed > (300 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(math.random(2, 2.4), 0, math.random(-0.25, 0.25)))
		if !ply.StatsPaused then
			ply.Stamina = math.Clamp(ply.Stamina - (7 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    elseif speed > (140 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(math.random(1, 1.2), 0, math.random(-0.2, 0.2)))
		if !ply.StatsPaused then
			ply.Stamina = math.Clamp(ply.Stamina - (5.5 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    end
end

local NextTick = 0

function GM:Think()
	local ct = CurTime()
	local ft = FrameTime()

	if NextTick < ct then
		NextTick = ct + 1
		local plycount = #player.GetAll()

		if ct > tonumber(self.NextZombieSpawn) then
			self.NextZombieSpawn = ct + tonumber(self.Config["ZombieSpawnRate"]) 
			if GetGlobalBool("GM.ZombieSpawning") then
				self:SpawnZombies()
			end
		end

		if ct > tonumber(self.NextBossSpawn) then
			self.NextBossSpawn = ct + tonumber(self.Config["BossSpawnRate"])
			if GetGlobalBool("GM.ZombieSpawning") and plycount >= self.MinPlayersBossRequired then
				gamemode.Call("SpawnBoss")
			end
		end

		if ct > tonumber(self.NextAirdropSpawn) then
			self.NextAirdropSpawn = ct + tonumber(self.Config["AirdropSpawnRate"]) 
			if plycount >= self.MinPlayersAirdropRequired then
				gamemode.Call("SpawnAirdrop")
			end
		end

		if ct > tonumber(self.NextLootSpawn) then
			self.NextLootSpawn = ct + 60
			gamemode.Call("SpawnLoot")
		end

		-- The Ultimate timer of Auto-Maintenance (no.)
		if !self.IsMaintenance and ct >= tonumber(self.Config["AutoMaintenanceTime"]) * 3600 then
			self:DoAutoMaintenance(tonumber(self.Config["AutoMaintenanceDelay"]) * 60)
		elseif self.IsMaintenance and ct > self:GetServerRestartTime() then
			if !self.RestartingLevel then
				self:SystemBroadcast("Restarting map...", Color(205,205,205), true)
				self.RestartingLevel = true
				for _,ply in pairs(player.GetAll()) do ply:SendLua("surface.PlaySound(\"buttons/button15.wav\")") end
			end
			timer.Simple(1, function()
				for k,o in pairs(self.Config["ZombieClasses"]) do
					for _, ent in pairs(ents.FindByClass(k)) do
						ent:Remove()
					end
				end
			end)
			timer.Simple(2, function()
				for k,o in pairs(self.Config["BossClasses"]) do
					for _, ent in pairs(ents.FindByClass(k)) do
						ent:Remove()
					end
				end
			end)
			timer.Simple(5, function()
				RunConsoleCommand("changelevel", game.GetMap())
			end)
		end

		if self.InfectionLevelIncreaseType == 1 then
			if self.InfectionLevelEnabled and plycount > 0 and self.NextInfectionDecrease < ct and self:GetInfectionLevel() > 0 and not self.InfectionLevelShouldNotDecrease then
				self.NextInfectionDecrease = ct + 9
				self.InfectionDecreasedTimes = math.Clamp(self.InfectionDecreasedTimes + 1, 0, 45)
			
				self:SetInfectionLevel(math.max(0, self:GetInfectionLevel() - (0.045 + (self.InfectionDecreasedTimes * 0.0072))))
			end
		else
			local averagelevelprogress = 0
			local averageprestige = 0
			for _,pl in pairs(player.GetAll()) do
				averagelevelprogress = averagelevelprogress + math.Clamp((pl.Level-1) / (pl:GetMaxLevel()-1), 0, 1)
			end
			averagelevelprogress = averagelevelprogress / player.GetCount()

			for _,pl in pairs(player.GetAll()) do
				-- averageprestige = pl.Prestige + pl:GetProgressToPrestige()
				averageprestige = averageprestige + math.Clamp(pl.Prestige, 0, 100)
			end
			averageprestige = averageprestige / player.GetCount()


			self:SetInfectionLevel(averagelevelprogress*10+averageprestige*5)
		end

		if self.NextSave + 240 < ct then
			self.NextSave = ct
			gamemode.Call("SaveTimer")
		end
	
		for _,ply in pairs(player.GetAll()) do
			local hp = ply.HPRegen
			local noregen_thirst = (3000 - (125 * ply.StatSurvivor))
			local noregen_hunger = (3000 - (150 * ply.StatSurvivor))
			local noregen_fatigue = (7000 + (150 * ply.StatSurvivor))
			local noregen_infection = (5000 - (100 * ply.StatImmunity))
			if !hp or hp < 1 or !(ply.Thirst >= noregen_thirst and ply.Hunger >= noregen_hunger and ply.Fatigue <= noregen_fatigue and ply.Infection <= noregen_infection) then continue end
			ply:SetHealth(math.Clamp(ply:Health() + math.floor(hp), 5, ply:GetMaxHealth()))
			ply.HPRegen = ply.HPRegen - math.floor(ply.HPRegen)
		end

	end

	for _,ply in pairs(player.GetAll()) do
		if !ply:IsValid() then continue end
		if !ply:Alive() or ply.StatsPaused or ply:GetObserverMode() ~= OBS_MODE_NONE then 
			if (ply.NextTick or 0) < RealTime() then
				self:NetUpdateStats(ply)
				ply.NextTick = RealTime() + 0.06
			end
			continue
		end

		local hunger = ply.Hunger or 10000
		local thirst = ply.Thirst or 10000
		local fatig = ply.Fatigue or 0
		local infection = ply.Infection or 0
		local battery = ply.Battery or 0
	
		local endurance = ((ply.StatEndurance or 0) / 500) * ft
	
		-- hunger, thirst, fatigue, infection
		ply.Hunger = math.Clamp(hunger - (4.35*ft * (1 - (ply.StatSurvivor * 0.04))), 0, 10000)
		ply.Thirst = math.Clamp(thirst - (5.2*ft * (1 - (ply.StatSurvivor * 0.0425))), 0, 10000)
		ply.Fatigue = math.Clamp(fatig + (3*ft * (1 - (ply.StatSurvivor * 0.035))), 0, 10000)
	
		if (ply.Thirst <= 0 or ply.Hunger <= 0 or ply.Fatigue >= 10000 or ply.Infection >= 10000) then
			if !timer.Exists("DyingFromStats_"..ply:EntIndex()) then
				timer.Create("DyingFromStats_"..ply:EntIndex(), 30, 1, function()
					if ply:Alive() then ply:Kill() end
				end)
			end
		else
			if timer.Exists("DyingFromStats_"..ply:EntIndex()) then
				timer.Destroy("DyingFromStats_"..ply:EntIndex())
			end
		end
	
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = self.ItemsList[armorstr]
		if ply:FlashlightIsOn() then
			if ply.Battery <= 0 then
				ply:Flashlight(false)
				ply:AllowFlashlight(false)
				ply.CanUseFlashlight = false
			else
				ply.Battery = math.Clamp(ply.Battery - 1*ft, 0, 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0))
			end
		else
			ply.Battery = math.Clamp(ply.Battery + 1.35*ft, 0, 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0))
			if ply.Battery >= 10 then
				ply:AllowFlashlight(true)
				ply.CanUseFlashlight = true
			end
		end
	
	-- in case if player's HPRegen value is nil then it's set to 0
		if ply.HPRegen and ply:Health() < ply:GetMaxHealth() and ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity)) then
			ply.HPRegen = math.Clamp(ply.HPRegen + 0.11*ft + (ply.StatMedSkill * 0.0001), 0, ply:GetMaxHealth())
		elseif !ply.HPRegen or ply.HPRegen > 0 then
			ply.HPRegen = 0
		end
	
		--random chance of getting infected per tick is very rare, but has chance if survived for more than 10 minutes, can decrease chance of this happening by increasing immunity skill level
/*		-- Disabled. If you want to, you can enable it back again.
		local infectionchance = math.random(1, 2000000 + (100000 * ply.StatImmunity) - (ct - ply.SurvivalTime))
		if (infectionchance <= 1 and math.floor(ct - ply.SurvivalTime) >= 600) and ply.Infection <= 0 and ply:Alive() then
--			ply:SendChat(translate.ClientGet(ply, "plcaughtinfection"))
		end
*/
		if (ply.Infection > 0 or infectionchance and infectionchance <= 1 and math.floor(ct - ply.SurvivalTime) >= 900) then
			ply.Infection = math.Clamp(ply.Infection + (7.84*ft * (1 - (ply.StatImmunity * 0.04))), 0, 10000)
		end


		if ply:WaterLevel() == 3 then
			ply.Thirst = math.Clamp(ply.Thirst + 16.2*ft, 0, 10000)
			if tonumber(ply.Oxygen) <= 0 then
				if not ply.DrownStartTime then
					ply.DrownStartTime = ct
				end

				ply.DrownDamage = ply.DrownDamage + (0.08+(0.008*(CurTime()-ply.DrownStartTime)))*ft*ply:GetMaxHealth()
				if ply.DrownDamage >= 1 then
					ply:SetHealth(ply:Health() - math.floor(ply.DrownDamage))
					if ply:Health() < 1 then
						local d = DamageInfo()
						d:SetDamage(1)
						d:SetDamageType(DMG_DROWN)
						d:SetAttacker(ply)
						d:SetInflictor(ply)
						ply:TakeDamageInfo(d)
					end
					ply.DrownDamage = ply.DrownDamage - math.floor(ply.DrownDamage)
				end
			else
				ply.Oxygen = math.Clamp(ply.Oxygen - 6*ft, 0, 100)
				-- ply.Stamina = math.Clamp(ply.Stamina - ((0.093 / staminaperk) - endurance), 0, 100)
			end
		else
			ply.Oxygen = math.Clamp(ply.Oxygen + 12*ft, 0, 100)
			ply.DrownStartTime = nil
		end


		local PlayerIsMoving = ply:GetPlayerMoving()
		if ply:GetMoveType() != MOVETYPE_NOCLIP or ply:InVehicle() then
	
	/*		if ply:OnGround() and ply:KeyPressed(IN_JUMP) then
			ply.Stamina = ply.Stamina - 5
		end
	*/ -- Trying to find function that drains stamina on jumping, but this one doesn't really work
	
			local staminaperk = ply.UnlockedPerks["enduring_endurance"] and ply.Stamina < 25 and 2 or 1

			if !ply:InVehicle() and (ply:IsSprinting() and PlayerIsMoving and not ply:Crouching()) then
				ply.Stamina = math.Clamp(ply.Stamina - ((5.03*ft / staminaperk) - endurance), 0, 100)
			elseif !ply:InVehicle() and PlayerIsMoving and ply:Crouching() then
				ply.Stamina = math.Clamp(ply.Stamina + (0.73*ft + endurance) * staminaperk, 0, 100)
			elseif !ply:InVehicle() and PlayerIsMoving then
				ply.Stamina = math.Clamp(ply.Stamina + (0.55*ft + endurance) * staminaperk, 0, 100)
			elseif ply:InVehicle() or ply:Crouching() then
				ply.Stamina = math.Clamp(ply.Stamina + (2.86*ft + endurance) * staminaperk, 0, 100)
			else
				ply.Stamina = math.Clamp(ply.Stamina + (3.13*ft + endurance) * staminaperk, 0, 100)
			end
		
			-- if ply.Stamina > 30 then
			-- 	ply.sprintrecharge = false
			-- end

			-- if (ply:IsSprinting() and PlayerIsMoving and ply.Stamina <= 0) then
			-- 	-- ply:ConCommand("-speed")
			-- 	ply.sprintrecharge = true
			-- end

			-- if (ply:IsSprinting() and PlayerIsMoving and ply.sprintrecharge and ply.Stamina <= 30) then
			-- 	ply:ConCommand("-speed")
			-- end
		end
/*	
		if tonumber(ply.Stamina) > 0 or ply:WaterLevel() != 3 then
			if timer.Exists("DrownTimer"..ply:EntIndex()) then
				timer.Destroy("DrownTimer"..ply:EntIndex())
			end
		end
*/
		if (ply.NextTick or 0) < RealTime() then
			self:NetUpdateStats(ply)
			ply.NextTick = RealTime() + 0.06
		end
	end
end

function GM:Tick()
end

function GM:PlayerConnect(name, ip)
	for _, ply in pairs(player.GetAll()) do
		ply:SystemMessage(translate.ClientFormat(ply, "pljoined", name), Color(255,255,155,255), false)
		-- ply:SystemMessage(Format("#tea.chat_message.pljoined", name), Color(255,255,155,255), false)
	end
end

function GM:PlayerDisconnected(ply)
	self:SystemBroadcast(Format("%s has left the server", ply:Name()), Color(255,255,155,255), false)

	if ply.Bounty >= 5 then
		local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
		local bountyloss = ply.Bounty - cashloss
		print(ply:Nick() .." has left the server with "..ply.Bounty.." bounty and dropped money worth of "..math.floor(cashloss).." "..self.Config["Currency"].."s!")

		local ent = ents.Create("ate_cash")
		ent:SetPos(ply:GetPos() + Vector(0, 0, 10))
		ent:SetAngles(Angle(0, 0, 0))
		ent:SetNWInt("CashAmount", math.floor(cashloss))
		ent:Spawn()
		ent:Activate()
	end
	
	self:SavePlayer(ply)
	self:SavePlayerInventory(ply)
	self:SavePlayerVault(ply)
	self:SavePlayerPerks(ply)
	for k,v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
		if v.BossMonster and v.DamagedBy[ply] then v.DamagedBy[ply] = nil end
	end

	if ply:Team() ~= TEAM_LONER then
		local plyfaction = team.GetName(ply:Team())
		if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
			timer.Simple(0.4, function() --this time it should work properly
				gamemode.Call("SelectRandomLeader", plyfaction)
			end)
		elseif team.NumPlayers(ply:Team()) <= 1 then
			gamemode.Call("AutoDisbandFaction", plyfaction)
		end
	end
end

function GM:PreGamemodeLoaded()
end

function GM:Initialize()
	self.NextZombieSpawn = 0
	self.NextBossSpawn = 0
	self.NextAirdropSpawn = 0
	self.NextLootSpawn = 0
	self.NextInfectionDecrease = 0
	self.InfectionDecreasedTimes = 0
	self.NextSave = 0
	self.DebugLogs = {}

	ZombieData = ""
	DropData = ""
	LootData = ""
	TaskDealersData = TaskDealersData or ""
	TradersData = ""
	self.PlayerSpawnsData = self.PlayerSpawnsData or ""

	SetGlobalBool("GM.ZombieSpawning", true)

	self:LoadServerData()
	self:SetUpSeasonalEvents()

--	self:AddResources()
	self:LoadLoot()
	self:LoadAD()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	self:LoadTaskDealers()
	self:CheckSpawnChanceErrors()
end

function GM:OnGamemodeLoaded()
end

function GM:PostGamemodeLoaded()
	MsgC(Color(255,191,191), "\n==============================================\n\n")
	MsgC(Color(255,191,191), Format("%s (%s) Gamemode Loaded Successfully\n\n", self.Name, self.AltName))
	MsgC(Color(255,191,191), Format("Made by %s\n\n", self.Author))
	MsgC(Color(255,191,191), "Original Creator: LegendofRobbo\n\n")
	MsgC(Color(255,191,191), Format("Version: %s\n\n", self.Version))
	MsgC(Color(255,191,191), "Github: https://github.com/Uklejamini357/gmodtheeternalapocalypse \n\n")
	MsgC(Color(255,191,191), "Remember to check out github site for new updates\n\n")
	MsgC(Color(255,191,191), "==============================================\n\n")
end

function GM:InitPostEntity()
	RunConsoleCommand("mp_falldamage", "1")
	RunConsoleCommand("M9KDefaultClip", "0") --it's set to 0 so the users don't abuse use and drop commands on m9k weapons over and over again
	RunConsoleCommand("M9KDisablePenetration", "1") --they are op with penetration, time to nerf them again (unless you want them to remain the same, remove or exclude this line)
	RunConsoleCommand("sv_defaultdeployspeed", "1") --so that users don't just switch weapons too quickly

	self:MapReInit()
end

function GM:MapReInit()
	--Don't disable this function below, unless you want to have some fun of course
	for k, v in pairs(ents.FindByClass("npc_*")) do v:Remove() end
	for k, v in pairs(ents.FindByClass("weapon_*")) do v:Remove() end
	for k, v in pairs(ents.FindByClass("item_*")) do v:Remove() end
	for k, v in pairs(ents.FindByClass("prop_physics")) do
		v.maxhealth = 2000
		v:SetHealth(2000)
	end --i'm looking forward for new function to scale props health with their size (or their weight)
	for k, v in pairs(ents.FindByClass("prop_door_rotating")) do
		v.doorhealth = tonumber(self.Config["DoorHealth"])
	end
end

function GM:OnReloaded()
	timer.Simple(0.3, function()
		for k, v in pairs(player.GetAll()) do self:FullyUpdatePlayer(v) end
	end)
	print("\n")

	self:LoadLoot()
	self:LoadAD()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	self:LoadTaskDealers()
	self:CheckSpawnChanceErrors()
end

function GM:ShutDown()
	for k, v in pairs(player.GetAll()) do
		self:SavePlayer(v)
		self:SavePlayerInventory(v)
		self:SavePlayerVault(v)
		self:SavePlayerPerks(v)
	end
	print("WARNING! WARNING!! THE OBJECT IS GONE!!")
	self:SaveServerData()
	self:DebugLog("Server shutting down/changing map")
	self:SaveLog()
end

function GM:DoAutoMaintenance(time)
	if self.IsMaintenance then return end
	self:SystemBroadcast(Format("Attention! The server will automatically restart map in %d minutes! Please make sure you have salvaged all of your structures and cashed in your bounties before the server restarts.", time / 60), Color(205,205,205), false)
	print(Format("Starting map restart sequence. ETA: %d minutes.", time / 60))
	for _,v in pairs(player.GetAll()) do v:ConCommand("playgamesound common/warning.wav") end
	self.IsMaintenance = true
	self:SetServerRestartTime(CurTime() + time)

	/* -- It will be now reworked
	timer.Create("TEAChangingLevel", 60, 0, function()
		if self.MinutesBeforeMaintenance > 1 then
			self.MinutesBeforeMaintenance = self.MinutesBeforeMaintenance - 1
			self:SystemBroadcast(Format("Due to maintenances, the server will restart in %d minutes.", self.MinutesBeforeMaintenance), Color(205,205,205), true)
		else
			self:SystemBroadcast("WARNING! Server is restarting in:", Color(205,205,205), true)
			timer.Destroy("TEAChangingLevel")
			self.AutoMaintenancePhase = 10
			timer.Create("TEAChangingLevel_2", 1, 0, function()
				if self.AutoMaintenancePhase >= 1 then
					self:SystemBroadcast(self.AutoMaintenancePhase.."...", Color(205,25.5*self.AutoMaintenancePhase,25.5*self.AutoMaintenancePhase), false)
					for _,ply in pairs(player.GetAll()) do ply:ConCommand("playgamesound buttons/button17.wav") end
					self.AutoMaintenancePhase = self.AutoMaintenancePhase - 1
				else
					if !self.RestartingLevel then
						self:SystemBroadcast("Restarting server...", Color(205,205,205), true)
						self.RestartingLevel = true
						for _,ply in pairs(player.GetAll()) do ply:ConCommand("playgamesound buttons/button15.wav") end
					end
					timer.Simple(1, function()
						for k,o in pairs(self.Config["ZombieClasses"]) do
							for _, ent in pairs(ents.FindByClass(k)) do
								ent:Remove()
							end
						end
					end)
					timer.Simple(2, function()
						for k,o in pairs(self.Config["BossClasses"]) do
							for _, ent in pairs(ents.FindByClass(k)) do
								ent:Remove()
							end
						end
					end)
					timer.Simple(5, function()
						RunConsoleCommand("changelevel", game.GetMap())
					end)
				end
			end)
		end
	end)
	*/
end

function GM:PostCleanupMap()
	self:MapReInit()
	timer.Simple(0.5, function() self:SpawnTraders() end)
end

function GM:OnNPCKilled(ent, attacker, inflictor, dmginfo)
	local entclass = ent:GetClass()
	local npcrewards = { -- override rewards for killing NPC
/*
		["npc_vj_l4d_com_male"] = {7, 4},
		["npc_vj_l4d_com_female"] = {7, 4},
		["npc_vj_l4d_com_f_nurse"] = {8, 5},
		["npc_vj_l4d_com_m_hospital"] = {8, 5},
		["npc_vj_l4d_com_m_airport"] = {9, 5},
		["npc_vj_l4d_com_m_police"] = {11, 6},
		["npc_vj_l4d_com_m_soldier"] = {14, 6},
		["npc_vj_l4d_com_m_ceda"] = {21, 7},
		["npc_vj_l4d_com_m_clown"] = {19, 7},
		["npc_vj_l4d_com_m_mudmen"] = {11, 4},
		["npc_vj_l4d_com_m_worker"] = {12, 5},
		["npc_vj_l4d_com_m_riot"] = {43, 14},
		["npc_vj_l4d_com_m_fallsur"] = {29, 11},
		["npc_vj_l4d_com_m_jimmy"] = {16, 6},
		["npc_zombie"] = {14, 7},
		["npc_zombie_torso"] = {11, 5},
		["npc_fastzombie"] = {12, 6},
		["npc_poisonzombie"] = {27, 11},
		["npc_combine_s"] = {34, 14},
*/
	}

	if npcrewards[entclass] then
		local xp = npcrewards[entclass][1]
		local cash = npcrewards[entclass][2]
		if !self.Config["ZombieClasses"][entclass] and !ent.XPReward and !ent.MoneyReward then
			self:Payout(attacker, xp, cash)
		end
	elseif !ent.TEA_DeadNPC then
		gamemode.Call("NPCReward", ent)
	end
end

function GM:EntityRemoved(ent)
	if !ent.TEA_DeadNPC then
		gamemode.Call("NPCReward", ent)
	end

	if ent.BossMonster and ent.DamagedBy and table.Count(ent.DamagedBy) > 0 then
		local loot = ents.Create("loot_cache_boss")
		local killer = ent.TEA_KilledByPlayer
		if killer and killer:IsValid() and killer:IsPlayer() then
			loot:SetNWEntity("pickup", killer)
			self:SystemBroadcast(killer:Nick().." has dealt most damage to boss ("..math.Round(ent.TEA_MostDamageByPlayer, 2)..") and can pick up the boss cache!", Color(127,127,255), true)
		end
		timer.Simple(300, function()
			if loot:IsValid() and loot:GetNWEntity("pickup"):IsValid() then
				loot:SetNWEntity("pickup", ent.TEA_KilledByPlayer)
			end
		end)
		loot:SetPos(ent:GetPos() + Vector(0, 0, 50))
		loot:SetAngles(ent:GetAngles())
		loot.LootType = table.Random(self.LootTableBoss)["Class"]
		loot:Spawn()
		loot:Activate()
	end

end

function GM:DamageFloater(attacker, victim, dmgpos, dmg)
	if attacker == victim then return end
	if dmgpos == vector_origin then dmgpos = victim:NearestPoint(attacker:EyePos()) end

	net.Start("tea_damagefloater")
	net.WriteFloat(dmg)
	net.WriteVector(dmgpos)
	net.Send(attacker)
end

function GM:EntityTakeDamage(ent, dmginfo)
	if ent.ProcessDamage and not ent:ProcessDamage(dmginfo) then return end
	if ent:IsPlayer() and not gamemode.Call("PlayerShouldTakeDamage", ent, dmginfo:GetAttacker()) then return end
	if ent.ProcessPlayerDamage and not ent:ProcessPlayerDamage(dmginfo) then return end
	if (ent:IsNPC() or ent:IsNextBot()) and not ent:ProcessNPCDamage(dmginfo) then return end

	local attacker = dmginfo:GetAttacker()

	if (ent.Type == "nextbot" or ent:IsNPC()) and (!ent.LastAttacker or ent:Health() > 0) and attacker:IsPlayer() then
		if !ent.BossMonster then
			ent.LastAttacker = attacker
			timer.Create("TEAZombieLastAttacker_"..ent:EntIndex(), 15, 1, function()
				if !ent:IsValid() then return end
				ent.LastAttacker = nil	-- after some time when the target last received damage from the attacker, we claim that the last target's attacker is no more
			end)
		else
			if !ent.DamagedBy[attacker] then 
				ent.DamagedBy[attacker] = math.Clamp(dmginfo:GetDamage(), 0, ent:Health())
			else
				ent.DamagedBy[attacker] = math.max(ent.DamagedBy[attacker] + math.Clamp(dmginfo:GetDamage(), 0, ent:Health()), 0)
			end
			self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, CurTime() + 6)
		end
	end

	if ent:GetClass() == "prop_physics" and ent.maxhealth then
		ent:SetHealth(ent:Health() - dmginfo:GetDamage())
		local ColorAmount = ((ent:Health() / ent.maxhealth) * 255)
		ent:SetColor(Color(ColorAmount, ColorAmount, ColorAmount, 255))
		if ent:Health() <= 0 then
			ent:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
			ent:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)
			ent:Remove()
		end
	end

	if self:GetDebug() >= DEBUGGING_ADVANCED then
		if ent:IsPlayer() and ent:Alive() and (!ent.SpawnProtected and !ent:HasGodMode()) then
			local dmg = dmginfo:GetDamage()
			ent:SendLua("notification.AddLegacy(translate.Format(\"dmgtaken\", \""..math.Round(dmg, 1).."\"), 0, 4)")
			print(ent:Nick().." has taken "..dmg.." damage!")
		end
	end

	if attacker:IsPlayer() then
		if ent:IsPlayer() or ent:IsNextBot() or (ent:IsNPC() and ent:GetClass() ~= "tea_trader") and ent:Health() ~= 0 then
			self:DamageFloater(attacker, ent, dmginfo:GetDamagePosition(), ent:IsPlayer() and math.floor(dmginfo:GetDamage()) or dmginfo:GetDamage())
		end
	end
end

function GM:PlayerShouldTakeDamage(ply, attacker)
	if ply:IsPlayer() and attacker:IsPlayer() and ply != attacker and !ply:IsPvPForced() and ply.Territory != team.GetName(attacker:Team()) then
		 
		if ply:Alive() and attacker:IsPlayer() and ply:IsPlayer() and (ply:HasGodMode() or ply.SpawnProtected) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("This target is invulnerable!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		elseif ply:Alive() and attacker:IsPlayer() and ply:IsPlayer() and attacker:IsPvPGuarded() then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You have PvP guarded! You can't damage other players!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		elseif ply:Alive() and attacker:IsPlayer() and ply:IsPlayer() and ply:IsPvPGuarded() then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("Target has PvP guarded! You can't damage that player!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		end

		if ply:Alive() and attacker:Team() == TEAM_LONER and attacker:GetNWBool("pvp") == false and GAMEMODE.VoluntaryPvP then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("Your PvP is not enabled!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		elseif ply:Alive() and ply:Team() == TEAM_LONER and ply:GetNWBool("pvp") == false and GAMEMODE.VoluntaryPvP then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You can't attack loners unless they have PvP enabled!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		elseif ply:Alive() and (ply:Team() == attacker:Team()) and not (ply:Team() == TEAM_LONER or attacker:Team() == TEAM_LONER) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You can't attack your factionmates!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			return false
		end

		ply.PvPNoToggle = CurTime() + 60
		attacker.PvPNoToggle = CurTime() + 60
	end

	return true
end

function GM:PlayerInitialSpawn(ply, transition)
	self.BaseClass:PlayerInitialSpawn(ply)
	ply:AllowFlashlight(true)
	
	-------- Normal Stats --------
	ply.SurvivalTime = CurTime()
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Battery = 100
	ply.Oxygen = 100
	ply.HPRegen = 0
	ply.ChosenModel = "models/player/kleiner.mdl"
	ply.Inventory = {}
	ply.Vault = {}
	ply.UnlockedPerks = {}
	ply.XP = 0
	ply.Money = 0
	ply.Bounty = 0
	ply.Level = 1
	ply.Prestige = 0
	ply.StatPoints = 0
	ply.PerkPoints = 0
	ply.PropCount = 0
	ply.ArmorAttachments = {}
	ply.InvitedTo = {} -- stores faction invites
	ply.Achievements = {} -- stores gained achievements
	ply.AchProgress = {}
	ply.TaskCooldowns = {}
	ply.SelectedProp = "models/props_debris/wood_board04a.mdl"
	ply:SetPvPGuarded(0)
	ply.Territory = "none"
	ply.EquippedArmor = "none"
	ply.BestSurvivalTime = 0
	ply.ZKills = 0
	ply.playerskilled = 0
	ply.playerdeaths = 0
	ply.CurrentTask = ""
	ply.CurrentTaskProgress = 0
	ply.CharactersData = {}
	----------------
	
	-------- Mastery Stats --------
	ply.MasteryMeleeXP = 0
	ply.MasteryMeleeLevel = 0
	ply.MasteryPvPXP = 0
	ply.MasteryPvPLevel = 0
	----------------
	
	-------- Special Stats --------
	ply.SlowDown = 0
	ply.CanUseFlashlight = true
	ply.SpawnProtected = false
	ply.DropCashCDcount = 0
	ply.StatsPaused = false
	ply.TEANoTarget = false
	ply.CanUseItem = true
	ply.MeleeDamageDealt = 0
	ply.StatsReset = 0
	ply.InvalidInventory = {} -- saves invalid items here
	ply.MaxLevelTime = 0
	ply.ZombieKillStreak = 0
	ply.LastStunTime = 0
	ply.PoisonDamage = 0
	ply.DrownDamage = 0

	ply.PvPNoToggle = 0
	ply.PvPAntiMsg = 0 -- prevents spamming messages if player attacks with pvp off or something else
	ply.PvPAntiMsgProp = 0 -- same as above but for props
	ply.HitSoundEffect = 0
	----------------

	-------- Other --------

	for statname, _ in pairs(self.StatConfigs) do
		ply["Stat"..statname] = 0
	end
/*
	for k, v in pairs(self.StatsListServer) do
		local TheStatPieces = string.Explode(";", v)
		local TheStatName = TheStatPieces[1]
		ply[TheStatName] = 0
	end
*/
	for k,v in pairs(self.Achievements) do
		ply.Achievements[k] = 0
		ply.AchProgress[k] = 0
	end

	if !ply:IsBot() then
		timer.Simple(0.01, function()
			ply:KillSilent()
			ply:SetPos(Vector(0,0,130000)) -- for main menu
		end)
	end

	print(Format("Loading datafiles for %s...\n", ply:Nick()))
	gamemode.Call("LoadPlayer", ply)
	gamemode.Call("LoadPlayerInventory", ply)
	gamemode.Call("LoadPlayerVault", ply)
	gamemode.Call("LoadPlayerPerks", ply)

	ply:SetNWBool("pvp", false)
	ply:SetNWString("ArmorType", "none")
	ply:SetTeam(TEAM_LONER)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
	self:NetUpdateStatistics(ply)

	ForceEquipArmor(ply, ply.EquippedArmor)
end

function GM:PlayerPostThink(ply)
end


function GM:PlayerReady(ply)
	self:FullyUpdatePlayer(ply)
end

function GM:PlayerSay(ply, text, team)
	return text
end

hook.Add("PlayerSay", "TheEternalApocalypse.PlayerSay", function(ply, text, team)
	if ply:IsValid() and string.Explode(" ", text)[1] == "!help" then
		ply:SendLua("GAMEMODE:HelpMenu()")
		return false
	end
end)

local sv_alltalk = GetConVar("sv_alltalk")
function GM:PlayerCanHearPlayersVoice(listener, talker)
	if sv_alltalk:GetInt() ~= 1 then return true, false end


	if listener:GetPos():Distance(talker:GetPos()) <= 1250 then
		return true, false
	else
		return false, false
	end
end

function GM:PlayerShouldTaunt(ply, actid)
	return true
end


local function IsPosBlocked(pos)
	local tr = {
		start = pos,
		endpos = pos,
		mins = Vector(-16, -16, 0),
		maxs = Vector(16, 16, 71),
		mask = MASK_SOLID,
	}
	local trc = util.TraceHull(tr)
	if (trc.Hit) then
		return true
	end
	return false
end

local function FindGoodSpawnPoint(e)
	local tests = {
		e:GetPos() + e:GetAngles():Right() * 50 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Right() * -50 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Right() * -50 + e:GetAngles():Forward() * 60 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Right() * 50 + e:GetAngles():Forward() * 60 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Right() * -50 + e:GetAngles():Forward() * -60 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Right() * 50 + e:GetAngles():Forward() * -60 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Forward() * 80 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Forward() * -80 + e:GetAngles():Up() * 20,
		e:GetPos() + e:GetAngles():Up() * 35,
		e:GetPos() + e:GetAngles():Up() * -20,
	}
	local goodspawn = false
	for k, v in pairs(tests) do
		if !IsPosBlocked(v) then goodspawn = v break end
	end
	return goodspawn
end


function GM:PlayerSpawn(ply)
	self.BaseClass:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_ate")
	gamemode.Call("RecalcPlayerModel", ply)

	for k, v in pairs(ents.FindByClass("bed")) do
		if v.Owner and v.Owner:IsValid() and v.Owner == ply then
			local bedspawnpoint = FindGoodSpawnPoint(v)
			if bedspawnpoint then ply:SetPos(bedspawnpoint) end
		end
	end

	if timer.Exists("pvpnominge_"..ply:EntIndex()) then timer.Destroy("pvpnominge_"..ply:EntIndex()) end

	if self.SpawnProtectionDur > 0 and self.SpawnProtectionEnabled then
		if !ply:Alive() then return end
		ply.SpawnProtected = true
		ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "plspawnprot_on", self.SpawnProtectionDur)
	end
	if self.SpawnProtectionDur > 0 and self.SpawnProtectionEnabled then
		timer.Create("IsSpawnProtectionTimerEnabled"..ply:EntIndex(), self.SpawnProtectionDur, 1, function()
			if !ply:IsValid() or !ply:Alive() then return end
			ply.SpawnProtected = false
			ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "plspawnprot_off")
		end)
	end

	gamemode.Call("RecalcPlayerSpeed", ply)
	timer.Simple(3, function()
		gamemode.Call("RecalcPlayerSpeed", ply)
	end)

	ply.CauseOfDeath = ""
	ply.DeathMessage = ""
	ply:SetNWBool("pvp", false)
	ply:SetPvPGuarded(0)
	ply:SetPlayerColor(Vector(cl_playercolor))
	ply:SetMaxHealth(self:CalcMaxHealth(ply))
	ply:SetHealth(self:CalcMaxHealth(ply))
	ply:SetMaxArmor(self:CalcMaxArmor(ply))
	ply:SetJumpPower(self:CalcJumpPower(ply))
	gamemode.Call("RecalcPlayerModel", ply)
	gamemode.Call("PrepareStats", ply)
	gamemode.Call("FullyUpdatePlayer", ply)

	-- give them a new gun if they are still levels under Newbie Level and are at prestige 0
	local newgun = self.Config["NewbieWeapon"]
	if ply:IsNewbie() and !ply.Inventory[newgun] then
		self:SystemGiveItem(ply, newgun)
		self:SendInventory(ply)
	end
end

function GM:PlayerLoadout(ply)
	ply:Give("tea_fists")
	ply:Give("tea_buildtool")

	if ply.UnlockedPerks["starting_ammo_upgrade"] then
		ply:GiveAmmo(200, "Pistol")
		ply:GiveAmmo(150, "ammo_rifle")
		ply:GiveAmmo(100, "Buckshot")
		ply:GiveAmmo(75, "ammo_sniper")
		ply:GiveAmmo(5, "XBowBolt")
	elseif ply:IsNewbie() then
		ply:GiveAmmo(100, "Pistol")
		ply:GiveAmmo(50, "Buckshot")
		ply:GiveAmmo(100, "ammo_rifle")
	else
		ply:GiveAmmo(50, "Pistol")
	end

	ply:SelectWeapon("tea_fists")
end

function GM:PlayerUse(ply, ent) --why is that here??
	if not ent then return end
	if not ent:IsValid() then return end
	return true
end


function GM:PlayerSpawnedProp(userid, model, prop)
	prop.owner = userid
	prop.model = model
end

function GM:PlayerNoClip(ply, on)
	if AdminCheck(ply) then
		PrintMessage(HUD_PRINTCONSOLE, translate.Format(on and "x_turned_on_noclip" or "x_turned_off_noclip", ply:Name()))
		return true
	end

	if ply:GetMoveType(MOVETYPE_NOCLIP) then
		ply:SetMoveType(MOVETYPE_WALK)
	end
	return false
end

-- not like setplayermodel, just reads their model and colour settings and sets them to it
function GM:RecalcPlayerModel(ply)
	if ply:IsBot() then ply:SetModel("models/player/soldier_stripped.mdl") return end -- this only works for bots
	if !ply.ChosenModel then ply.ChosenModel = "models/player/kleiner.mdl" end
	if !ply.ChosenModelColor then ply.ChosenModelColor = Vector(0.25, 0, 0) end

	if type(ply.ChosenModelColor) == "string" then ply.ChosenModelColor = Vector(ply.ChosenModelColor) end
	ply:SetPlayerColor(ply.ChosenModelColor)

	if !self.ItemsList[ply.EquippedArmor] or self.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"] == nil then
		if !table.HasValue(self.DefaultModels, ply.ChosenModel) then
			ply.ChosenModel = table.Random(self.DefaultModels)
		end
		ply:SetModel(ply.ChosenModel)
		return false
	end

	local models = self.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"]
	if !models[ply.ChosenModel] then ply.ChosenModel = table.Random(models) ply:SetModel(ply.ChosenModel) end
end

function GM:RecalcPlayerSpeed(ply)
	if !ply:IsValid() then return false end
	local armorspeed = 0
	local walkspeed = self.Config["WalkSpeed"]
	local runspeed = self.Config["RunSpeed"]
	local walkspeedbonus = ply.StatSpeed * 3.5
	local runspeedbonus = ply.StatSpeed * 7
	local plyarmor = ply:GetNWString("ArmorType")
	local slowdown = tonumber(ply.SlowDown or 0)

	if plyarmor and plyarmor != "none" then
		local armortype = self.ItemsList[plyarmor]
		armorspeed = tonumber(armortype["ArmorStats"]["speedloss"])
	end
	
	local totalwspeed,totalrspeed = math.max(1, ((walkspeed - (armorspeed / 2)) + walkspeedbonus) * (1 - slowdown)), math.max(1, ((runspeed - armorspeed) + runspeedbonus) * (1 - slowdown))
	local totalswspeed = math.Clamp(((walkspeed - (armorspeed / 2)) + walkspeedbonus) * (0.75 * (1 - slowdown)), 1, 100)


	local weight, maxweight, maxwalkweight = ply:CalculateWeight(), ply:CalculateMaxWeight(), ply:CalculateMaxWalkWeight()
	local weightpenalty = 1
	if weight >= maxwalkweight then
		totalwspeed = 1
		totalrspeed = 1
		totalswspeed = 1
	elseif weight >= maxweight then
		weightpenalty = math.Clamp(0.2 + ((maxwalkweight - maxweight) - (weight - maxweight)) / ((maxwalkweight - maxweight)/0.6), 0.2, 0.8)
	end

	self:SetPlayerSpeed(ply, totalwspeed * weightpenalty, totalrspeed * weightpenalty)
	ply:SetSlowWalkSpeed(totalswspeed * weightpenalty)
end

function GM:CheckSpawnChanceErrors()
	local chance = 0
	for k, v in pairs(self.Config["ZombieClasses"]) do
		chance = chance + v.SpawnChance
	end
	MsgC(Color(191,191,255,255), "Total normal zombie spawn chance: "..chance.."%\n")

	chance = 0
	for k, v in pairs(self.Config["BossClasses"]) do
		chance = chance + v.SpawnChance
	end
	MsgC(Color(191,191,255,255), "Total boss zombies spawn chance: "..chance.."%\n")
end

function GM:SetUpSeasonalEvents()
	local function n_date(format, time)
		return tonumber(os.date(format, time))
	end

	MsgC(Color(255,255,255), "\n------ Setting up any available seasonal events... ------\n")
	if n_date("%d") >= 25 and n_date("%m") == 10 or n_date("%d") <= 3 and n_date("%m") == 11 then
		self:SetSeasonalEvent(SEASONAL_EVENT_HALLOWEEN)
		MsgC(Color(255,191,0), "\n------ Halloween event is active! ------\n\n")
		MsgC(Color(255,191,0), "---[[[ All zombies give +25% XP during this event! ]]]---\n")
		MsgC(Color(255,191,0), "---[[[ Probability of elite zombie variant spawning is increased! ]]]---\n")
		MsgC(Color(255,191,0), "---[[[ Lasts for 10 days! 25th October - 3rd November ]]]---\n\n")
		MsgC(Color(255,191,0), "------ Happy halloween ;) ------\n")
	elseif n_date("%d") >= 19 and n_date("%m") == 12 or n_date("%d") <= 3 and n_date("%m") == 1 then
		self:SetSeasonalEvent(SEASONAL_EVENT_CHRISTMAS)
		MsgC(Color(0,191,255), "\n------ Christmas event is active! ------\n\n")
		MsgC(Color(0,191,255), "---[[[ All zombies give +15% XP during this event! ]]]---\n")
		MsgC(Color(0,191,255), "---[[[ Zombies have chance to spawn a gift after being killed! 1 in 50 chance, for normal zombies, 1 in 3 chance for bosses! ]]]---\n")
		MsgC(Color(0,191,255), "---[[[ Elite zombies are more likely to drop gifts! ]]]---\n")
		MsgC(Color(0,191,255), "---[[[ Lasts for 15 days! 19th December - 3rd January ]]]---\n\n")
		MsgC(Color(0,191,255), "------ Merry Christmas and Happy New Year! ;) ------\n")
	else
		self:SetSeasonalEvent(SEASONAL_EVENT_NONE)
		MsgC(Color(255,255,255), "\n------ No seasonal event is currently active... ------\n\n")
	end
end




-- NOT YET
function GM:AddResources()
-------- Gamemode Content Files --------
	local folder = "materials/arleitiss/riotshield"

	for _, filename in pairs(file.Find(folder.."/*.vmt", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end
	for _, filename in pairs(file.Find(folder.."/*.vtf", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end

	folder = "materials/entities"
	for _, filename in pairs(file.Find(folder.."/*.vtf", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end

	folder = "materials/environment maps"
	for _, filename in pairs(file.Find(folder.."/*.vtf", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end

	folder = "materials/models/weapons/v_wrench"
	for _, filename in pairs(file.Find(folder.."/*.vmt", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end
	for _, filename in pairs(file.Find(folder.."/*.vtf", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end

	folder = "materials/models/weapons/w_wrench"
	for _, filename in pairs(file.Find(folder.."/*.vmt", "GAME")) do
		resource.AddFile(folder.."/"..filename)
	end
	for _, filename in pairs(file.Find("materials/rg/*.vmt", "GAME")) do
		resource.AddFile("materials/rg/"..filename)
	end
	for _, filename in pairs(file.Find("materials/rg/*.vtf", "GAME")) do
		resource.AddFile("materials/rg/"..filename)
	end
	for _, filename in pairs(file.Find("materials/scope/*.vmt", "GAME")) do
		resource.AddFile("materials/scope/"..filename)
	end
	for _, filename in pairs(file.Find("materials/scope/*.vtf", "GAME")) do
		resource.AddFile("materials/scope/"..filename)
	end
	for _, filename in pairs(file.Find("materials/vgui/entities/*.vmt", "GAME")) do
		resource.AddFile("materials/vgui/entities/"..filename)
	end
	for _, filename in pairs(file.Find("materials/weapons/*.vmt", "GAME")) do
		resource.AddFile("materials/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("materials/weapons/*.vtf", "GAME")) do
		resource.AddFile("materials/weapons/"..filename)
	end

	for _, filename in pairs(file.Find("models/items/*.mdl", "GAME")) do
		resource.AddFile("models/items/"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.phy", "GAME")) do
		resource.AddFile("models/items/"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.vtx", "GAME")) do
		resource.AddFile("models/items/"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.vvd", "GAME")) do
		resource.AddFile("models/items/"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.mdl", "GAME")) do
		resource.AddFile("models/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.phy", "GAME")) do
		resource.AddFile("models/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.vtx", "GAME")) do
		resource.AddFile("models/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.vvd", "GAME")) do
		resource.AddFile("models/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("models/*.phy", "GAME")) do
		resource.AddFile("models/"..filename)
	end


	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.wav", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.mp3", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.ogg", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/grenade/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/grenade/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/44k/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/44k/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/test/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/test/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/shared/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/shared/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/universal/", "GAME")) do
		resource.AddFile("sound/weapons/universal/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/", "GAME")) do
		resource.AddFile("sound/weapons/"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/", "GAME")) do
		resource.AddFile("sound/weapons/"..filename)
	end
end



-------- Workshop addons --------

	resource.AddWorkshop("128089118") -- m9k assault rifles
	resource.AddWorkshop("128091208") -- m9k heavy weapons
	resource.AddWorkshop("128093075") -- m9k small arms pack
	resource.AddWorkshop("355101935") -- stalker playermodels
	resource.AddWorkshop("411284648") -- gamemode content pack
	--resource.AddWorkshop("448170926") -- ate swep pack (excluded because i copied and remade my own (no, the textures are not fixed yet because i don't know which textures were used by some weapons))
	resource.AddWorkshop("1270991543") -- armor models
	resource.AddWorkshop("1680884607") -- project stalker sounds 
	resource.AddWorkshop("2438451886") -- stalker item models pack
