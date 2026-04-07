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
AddCSLuaFile("client/cl_tooltip.lua")

local files = file.Find(GM.FolderName.."/gamemode/client/hud/*.lua", "LUA")
for _,f in pairs(files) do
	AddCSLuaFile("client/hud/"..f)
end

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
include("server/commands.lua") -- Drop cash, toggle pvp and such other commands
include("server/player_data.lua") -- Data management for players
include("server/player_inventory.lua") -- Player Inventory management for players
-- include("server/player_perks.lua") -- Data manage with Perks system
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
include("server/openworld.lua") -- Openworld implementation
include("server/safezones.lua") -- Safezones

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
	return 100 + (5 * (ply.StatVitality or 0)) + (ply:HasPerk("healthboost") and 5 or 0) + (ply:HasPerk("healthboost2") and 8 or 0)
end

function GM:CalcMaxArmor(ply)
	return 100 + (2 * (ply.StatEngineer or 0)) + (ply:HasPerk("armorboost") and 5 or 0) --(tonumber(ply.Prestige or 0) >= 5 and 5 or 0)
end

function GM:CalcJumpPower(ply)
	return 160 + (2 * (ply.StatAgility or 0)) + (ply:HasPerk("jumppowerboost") and 10 or 0) --(tonumber(ply.Prestige or 0) >= 4 and 10 or 0)
end

local NextTick = 0
local staminadiffregen = {
	[DIFFICULTY_GAMEPLAY_BASIC] = 1.08,
	[DIFFICULTY_GAMEPLAY_CHALLENGING] = 0.96,
	[DIFFICULTY_GAMEPLAY_ULTIMATE] = 0.93,
	[DIFFICULTY_GAMEPLAY_HELL] = 0.88,
	[DIFFICULTY_GAMEPLAY_IMPOSSIBLE] = 0.75,
}
local statupdaterate = {
	[DIFFICULTY_GAMEPLAY_ULTIMATE] = 1.25,
	[DIFFICULTY_GAMEPLAY_HELL] = 1.5,
	[DIFFICULTY_GAMEPLAY_IMPOSSIBLE] = 2.5,
}
local infectionupdaterate = {
	[DIFFICULTY_GAMEPLAY_ULTIMATE] = 1.25,
	[DIFFICULTY_GAMEPLAY_HELL] = 2.5,
	[DIFFICULTY_GAMEPLAY_IMPOSSIBLE] = 6.66,
}

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
			if plycount >= self.MinPlayersAirdropRequired and #self.AirdropSpawnpoints ~= 0 then
				gamemode.Call("CallAirdrop")
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
				for _,ply in player.Iterator() do ply:SendLua("surface.PlaySound(\"buttons/button15.wav\")") end
			end
			timer.Simple(1, function()
				for k,o in pairs(self.Config["ZombieClasses"]) do
					for _, ent in pairs(ents.FindByClass(k)) do
						ent:Remove()
					end
				end
				SetGlobalBool("GM.ZombieSpawning", false)
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
				self.NextInfectionDecrease = ct + math.max(1, 9/(1+self.InfectionDecreasedTimes*0.03))
				self.InfectionDecreasedTimes = math.max(self.InfectionDecreasedTimes + 1, 0)
			
				self:SetInfectionLevel(math.max(0, self:GetInfectionLevel() - (0.045 + math.Clamp(self.InfectionDecreasedTimes, 0, 60) * 0.0072)))
			end
		else
			local averagelevelprogress = 0
			local averageprestige = 0
			for _,pl in player.Iterator() do
				averagelevelprogress = averagelevelprogress + math.Clamp((pl.Level-1) / (pl:GetMaxLevel()-1), 0, 1)
			end
			averagelevelprogress = averagelevelprogress / player.GetCount()

			for _,pl in player.Iterator() do
				-- averageprestige = pl.Prestige + pl:GetProgressToPrestige()
				averageprestige = averageprestige + math.Clamp(pl.Prestige, 0, 100)
			end
			averageprestige = averageprestige / player.GetCount()


			self:SetInfectionLevel(averagelevelprogress*10+averageprestige*5)
		end

		if self.NextSave + 300 < ct then
			self.NextSave = ct
			gamemode.Call("SaveTimer")
		end

		local noregen_thirst = 3000
		local noregen_hunger = 3000
		local noregen_fatigue = 7000
		local noregen_infection = 5000

		for _,ply in player.Iterator() do
			local paused = self.SafezonePauseStats and ply:IsSZProtected()

			local infectionchance
			if self.RandomPlayerInfection and !paused then
				infectionchance = math.random(1, math.max(10000, 100000 - ply:GetTimeSurvived()))
				if (infectionchance == 1 and ply:GetTimeSurvived() >= 900) and ply.Infection <= 0 and ply:Alive() then
					ply.Infection = ply.Infection + 1
					ply:SendChat(translate.ClientGet(ply, "plcaughtinfection"))
				end
			end

			if (ply.Thirst >= noregen_thirst and ply.Hunger >= noregen_hunger and ply.Fatigue <= noregen_fatigue and ply.Infection <= noregen_infection) then
				if ply.HPRegen and ply:Health() < ply:GetMaxHealth() then
					ply.HPRegen = math.Clamp(ply.HPRegen + 0.11*(1 + ply.StatMedSkill * 0.08)*(ply:IsSleeping() and 10 or 1), 0, ply:GetMaxHealth())
				elseif !ply.HPRegen or ply.HPRegen > 0 then
					ply.HPRegen = 0
				end
			end

			-- Can cause overhealed players' health to be reset to max.
			if ply:GetMaxHealth() <= ply:Health() then
				ply.HPRegen = 0
			end

			if ply.HPRegen or ply.HPRegen >= 1 then
				ply:SetHealth(math.min(ply:Health() + math.floor(ply.HPRegen), ply:GetMaxHealth()))
				ply.HPRegen = ply.HPRegen - math.floor(ply.HPRegen)
			end

			if ply.BloodLustMeleeHealCap > 0 and ply.BloodLustLastMeleeHit + 5 < CurTime() then
				ply.BloodLustMeleeHealCap = math.max(0, ply.BloodLustMeleeHealCap - 0.1 * math.Clamp(CurTime() - (ply.BloodLustLastMeleeHit + 5), 0, 10))
			end
		end
	end

	for _,ply in player.Iterator() do
		if !ply:IsValid() then continue end
		if !ply:Alive() or ply.StatsPaused or ply:GetObserverMode() ~= OBS_MODE_NONE then 
			if (ply.NextTick or 0) < RealTime() then
				self:NetUpdateStats(ply)
				ply.NextTick = RealTime() + 1
			end

			continue
		end

		local sleeping = ply:IsSleeping()
		local paused = self.SafezonePauseStats and ply:IsSZProtected()

		-- hunger, thirst, fatigue, infection
		ply.Hunger = math.Clamp(ply.Hunger - (5*ft / (1 + ply.StatSurvivor * 0.045) * (statupdaterate[self.GameplayDifficulty] or 1))*(sleeping and 20 or paused and 0 or 1), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst - (6*ft / (1 + ply.StatSurvivor * 0.045) * (statupdaterate[self.GameplayDifficulty] or 1))*(sleeping and 20 or paused and 0 or 1), 0, 10000)
		ply.Fatigue = math.Clamp(ply.Fatigue + (sleeping and -200*ft or paused and 0 or (3.2*ft / (1 + ply.StatSurvivor * 0.045) * (statupdaterate[self.GameplayDifficulty] or 1))), 0, 10000)

		if ply.Infection > 0 then
			ply.Infection = math.Clamp(ply.Infection + (16*ft * (1 - ply.StatImmunity * 0.035) * (statupdaterate[self.GameplayDifficulty] or 1))*(sleeping and 8 or 1), 0, 10000)
		end

		if sleeping then
			local wakeupcause = 0

			if ply.Thirst < 500 then
				wakeupcause = 1
			elseif ply.Hunger < 500 then
				wakeupcause = 2
			elseif ply.Infection > 9000 then
				wakeupcause = 3
			elseif ply:WaterLevel() >= 1 then
				wakeupcause = 4
			elseif ply.Fatigue < 1 then
				wakeupcause = 5
			end

			if wakeupcause ~= 0 then
				ply:WakeUp()

				ply:SendChat(
					wakeupcause == 1 and translate.ClientGet(ply, "wakeup_cause_thirst") or
					wakeupcause == 2 and translate.ClientGet(ply, "wakeup_cause_hunger") or
					wakeupcause == 3 and translate.ClientGet(ply, "wakeup_cause_infection") or
					wakeupcause == 4 and translate.ClientGet(ply, "wakeup_cause_water") or
					translate.ClientGet(ply, "wakeup_cause_rested")
				)
			end
		end

		if not (sleeping or ply:IsUsingItem()) then
			if ply.UsingItemSwitchWeapon and ply:GetWeapon(ply.UsingItemSwitchWeapon):IsValid() then
				ply:SelectWeapon(ply.UsingItemSwitchWeapon)
				ply.UsingItemSwitchWeapon = nil
			end
		end

		if ply:IsDying() then
			if ply:Alive() and not ply:HasGodMode() then
				local dmg = ply.StatsDyingDamage or 0
				local hungerdying = ply.Hunger <= 0
				local thirstdying = ply.Thirst <= 0
				local fatiguedying = ply.Fatigue >= 10000
				local infectiondying = self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE and ply.Infection > 1000 or self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL and ply.Infection > 5000 or ply.Infection >= 10000

				if hungerdying then dmg = dmg + 2*ft end
				if thirstdying then dmg = dmg + 2*ft end
				if fatiguedying then dmg = dmg + 2*ft end
				if infectiondying then
					dmg = dmg + (self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE and math.min(2, (ply.Infection-1000)/2000) or 2)*ft
				end
				dmg = dmg + 1*ft

				ply.StatsDyingDamage = dmg
				if dmg >= 1 then
					if ply:Health() > 1 then
						ply:SetHealth(ply:Health() - math.floor(dmg))
						ply.StatsDyingDamage = dmg - math.floor(dmg)
					else
						if infectiondying then
							ply.CauseOfDeath = "Infection"
							ply.DeathMessage = table.Random({"has succumbed to a zombie infection", "died to an infection"})
						elseif fatiguedying then
							ply.CauseOfDeath = "Fatigue"
							ply.DeathMessage = "could not find a place to sleep"
						elseif thirstdying then
							ply.CauseOfDeath = "Thirst"
							ply.DeathMessage = "died from thirst"
						elseif hungerdying then
							ply.CauseOfDeath = "Hunger"
							ply.DeathMessage = "has starved to death"
						end

						ply:Kill()
					end
				end
			end

		end
	
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = self.ItemsList[armorstr]
		if ply:FlashlightIsOn() then
			if ply.Battery <= 0 then
				ply:Flashlight(false)
			else
				ply.Battery = math.Clamp(ply.Battery - 1*ft, 0, ply:GetMaxBattery())
			end
		else
			ply.Battery = math.Clamp(ply.Battery + 1.35*ft, 0, ply:GetMaxBattery())
		end



		local oxygendrainmul = 1
		if armortype and armortype.ArmorStats and armortype.ArmorStats.oxygen_capacity then
			oxygendrainmul = 1 / armortype.ArmorStats.oxygen_capacity
		end
		
		if ply.StatEndurance and ply.StatEndurance > 0 then
			oxygendrainmul = oxygendrainmul / (1 + ply.StatEndurance*0.02)
		end
		
		-- print(armortype)
		if ply:WaterLevel() == 3 then
			ply.Thirst = math.Clamp(ply.Thirst + 16.2*ft, 0, 10000)
			if tonumber(ply.Oxygen) <= 0 then
				if not ply.DrownStartTime then
					ply.DrownStartTime = ct
				end

				ply.DrownDamage = ply.DrownDamage + (8+(0.8*(CurTime()-ply.DrownStartTime)))*ft
				if ply.DrownDamage >= 1 and not ply:HasGodMode() then
					ply:SetHealth(ply:Health() - math.floor(ply.DrownDamage))
					if ply:Health() < 1 then
						ply.CauseOfDeath = "Drowned"
						ply.DeathMessage = "drowned"


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
				ply.Oxygen = math.Clamp(ply.Oxygen - 6*ft*oxygendrainmul, 0, 100)
			end
		else
			ply.Oxygen = math.Clamp(ply.Oxygen + 12*ft*oxygendrainmul, 0, 100)
			ply.DrownStartTime = nil
		end


		local PlayerIsMoving = ply:GetPlayerMoving()
		if ply:GetMoveType() != MOVETYPE_NOCLIP or ply:InVehicle() then	
			local endurance_mul = 1 / (1 + ply.StatEndurance*0.028)
			local weightpenalty = ply:GetStaminaDrainWeightMul()
			local fatigabove70 = ply.Fatigue > 7000
			local fatigabove99 = ply.Fatigue > 9900

			if ply.Fatigue < 9900 then
				ply.Stamina = ply.Stamina + 3.04*ft *
				(ply:HasPerk("enduring_endurance") and ply.Stamina < 25 and 1.3 or 1) *
				(fatigabove99 and 0 or fatigabove70 and 0.8 + ((7000-ply.Fatigue)/10000)*2 or 1) *
				(ply:WaterLevel() == 3 and 2/3 or 1) *
				(staminadiffregen[self.GameplayDifficulty] or 1)
			elseif ply.Fatigue >= 10000 then
				ply.Stamina = ply.Stamina - 2*ft
			end


			if !ply:InVehicle() then
				if (ply:IsSprinting() and PlayerIsMoving and not ply:Crouching()) then
					ply.Stamina = ply.Stamina - 6*ft*endurance_mul*weightpenalty
				elseif PlayerIsMoving and ply:Crouching() then
					ply.Stamina = ply.Stamina - 2.4*ft*endurance_mul*math.sqrt(weightpenalty)
				elseif PlayerIsMoving then
					ply.Stamina = ply.Stamina - 2.6*ft*endurance_mul*math.sqrt(weightpenalty)
				end
			end

			ply.Stamina = math.Clamp(ply.Stamina, 0, 100)
		end

		if (ply.NextTick or 0) < RealTime() then
			self:NetUpdateStats(ply)
			ply.NextTick = RealTime() + 1
		end

		ply:NWSendStamina()
	end
end

function GM:Tick()
end

function GM:PlayerConnect(name, ip)
	for _, ply in player.Iterator() do
		ply:SystemMessage(translate.ClientFormat(ply, "pljoined", name), Color(255,255,155,255), false)
		-- ply:SystemMessage(Format("#tea.chat_message.pljoined", name), Color(255,255,155,255), false)
	end
end

function GM:PlayerDisconnected(ply)
	for _, pl in player.Iterator() do
		pl:SystemMessage(translate.ClientFormat(pl, "plleft", ply:Name()), Color(255,255,155,255), false)
	end

	gamemode.Call("SavePlayer", ply)
	for k,v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
		if v.DamagedBy and v.DamagedBy[ply] then v.DamagedBy[ply] = nil end
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
	self.StatTracker = {}

	self.ServerInitOsTime = os.time()

	self.ZombieSpawnpoints = {}
	self.AirdropSpawnpoints = {}
	self.LootSpawnpoints = {}
	self.TaskDealerSpawnpoints = {}
	self.TraderSpawnpoints = {}
	self.PlayerSpawnpoints = {}
	self.OpenworldTransitions = {}
	self.MapSafezones = {}

	SetGlobalBool("GM.ZombieSpawning", true)

	self:InitializeDataDirs()

	self:LoadServerData()
	self:SetUpSeasonalEvents()

--	self:AddResources()
	self:AddWSResources()
	self:LoadLoot()
	self:LoadAD()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	self:LoadTaskDealers()

	self:LoadTransitionsData()
	self:LoadSafezonesData()

	self:CheckSpawnChanceErrors()

	self:SetInflationMeter(self:CalcInflationMeter())
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
	RunConsoleCommand("M9KDisablePenetration", "1") --they are op with penetration, time to nerf them again (unless you want them to remain the same, remove or comment this line)
	RunConsoleCommand("sv_defaultdeployspeed", "1") --so that users don't just switch weapons too quickly

	self:SpawnTraders()
	self:SpawnTaskDealers()
	self:SpawnLevelTransitions()
	self:SpawnMapSafezones()
	self:MapReInit()
end

function GM:PostCleanupMap()
	self:SpawnTraders()
	self:SpawnTaskDealers()
	self:SpawnLevelTransitions()
	self:SpawnMapSafezones()

	self:MapReInit()
end

function GM:MapReInit()
	--Don't disable this function below, unless you want to have some fun of course
	for k, v in pairs(ents.FindByClass("npc_*")) do v:Remove() end
	for k, v in pairs(ents.FindByClass("weapon_*")) do if v:GetOwner() == NULL or not v:GetOwner() then v:Remove() end end
	for k, v in pairs(ents.FindByClass("item_*")) do v:Remove() end
	for k, v in pairs(ents.FindByClass("prop_physics")) do
		if v:Health() != 0 then continue end
		self:SetupProp(v)
	end --i'm looking forward for new function to scale props health with their size (or their weight)

	for k, v in pairs(ents.FindByClass("prop_door_rotating")) do
		v.doorhealth = tonumber(self.Config["DoorHealth"])
	end
end

function GM:OnReloaded()
	timer.Simple(0.3, function()
		for k, v in player.Iterator() do self:FullyUpdatePlayer(v) end
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
	for _, ply in ipairs(player.GetAll()) do
		gamemode.Call("SavePlayer", ply)
	end
	print("WARNING! WARNING!! THE OBJECT IS GONE!!")
	self:SaveServerData()
	self:DebugLog("Server shutting down/changing map")
	self:SaveLog()
end

function GM:SetupProp(ent)
	if ent:GetModel() == "models/props_junk/harpoon002a.mdl" then return end -- impaling with a destroyed harpoon can crash the game

	local phys = ent:GetPhysicsObject()
	local mass, volume = 100,100
	if phys:IsValid() then
		mass = phys:GetMass()
		volume = phys:GetVolume()
	end
	local hp = 50 + math.floor(math.max(mass^0.5, 20)*0.5 * math.max(volume^0.6, 2) * 0.02)
	ent:SetHealth(hp)
	ent.prophealth = hp
	ent.maxhealth = hp
end


function GM:DoAutoMaintenance(time)
	if self.IsMaintenance then return end
	self:SystemBroadcast(Format("Attention! The server will automatically restart map in %d minutes! Please make sure you have salvaged all of your structures and cashed in your bounties before the server restarts.", time / 60), Color(205,205,205), false)
	print(Format("Starting map restart sequence. ETA: %d minutes.", time / 60))
	for _,v in ipairs(player.GetAll()) do
		v:ConCommand("playgamesound common/warning.wav")
	end
	self.IsMaintenance = true
	self:SetServerRestartTime(CurTime() + time)
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
			self:Payout(attacker, xp*self:GetEconomyXPGainMul(), cash)
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
		local loot = self:SpawnLootCache(LOOTTYPE_BOSS, ent:GetPos() + Vector(0, 0, 50), ent:GetAngles())
		if !loot or !loot:IsValid() then return end
		local killer = ent.TEA_KilledByPlayer
		if killer and killer:IsValid() and killer:IsPlayer() then
			loot:SetNWEntity("pickup", killer)
			self:SystemBroadcast(killer:Nick().." has dealt most damage to boss ("..math.Round(ent.TEA_MostDamageByPlayer, 2)..") and can pick up the boss cache!", Color(127,127,255), true)
		end
		timer.Simple(300, function()
			if loot:IsValid() and loot:GetNWEntity("pickup"):IsValid() then
				loot:SetNWEntity("pickup", NULL)
			end
		end)
	end

end

function GM:DamageFloater(attacker, victim, dmgpos, dmg)
	if attacker == victim then return end
	if victim:Health() < 0 then return end
	if dmgpos == vector_origin then dmgpos = victim:NearestPoint(attacker:EyePos()) end

	net.Start("tea_damagefloater")
	net.WriteFloat(dmg)
	net.WriteVector(dmgpos)
	net.Send(attacker)
end

local function IsMeleeDamage(num)
	return (num == DMG_SLASH or num == DMG_CLUB)
end

function GM:EntityTakeDamage(ent, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if self.SafezoneGrindingPrevention == 1 and (ent:IsNPC() or ent:IsNextBot()) and ent.IsZombie and attacker:IsValid() and attacker:IsPlayer() and attacker:IsSZProtected() then
		return true
	end

	if ent.ProcessDamage and not ent:ProcessDamage(dmginfo) then return true end
	if ent:IsPlayer() and not gamemode.Call("PlayerShouldTakeDamage", ent, dmginfo:GetAttacker()) then return true end
	if ent.ProcessPlayerDamage and not ent:ProcessPlayerDamage(dmginfo) then return true end
	if (ent:IsNPC() or ent:IsNextBot()) and not ent:ProcessNPCDamage(dmginfo) then return true end

	if ent:IsPlayer() and ent:Alive() and dmginfo:GetDamage() > 1 and ent:IsSleeping() then
		ent:WakeUp()

		ent:SendChat(translate.ClientGet(ent, "wakeup_cause_damage"))
	end

	if attacker:IsPlayer() then
		if (ent:IsNextBot() or ent:IsNPC() or ent:IsPlayer()) and IsMeleeDamage(dmginfo:GetDamageType()) and attacker:HasPerk("bloodlust") then
			local heal = math.min(50 - attacker.BloodLustMeleeHealCap, dmginfo:GetDamage()*0.1)*(50-attacker.BloodLustMeleeHealCap)/50
			attacker.BloodLustMeleeHeal = attacker.BloodLustMeleeHeal + heal
			attacker.BloodLustMeleeHealCap = attacker.BloodLustMeleeHealCap + heal
			attacker.BloodLustLastMeleeHit = CurTime()

			if attacker.BloodLustMeleeHeal and attacker.BloodLustMeleeHeal >= 1 then
				attacker:SetHealth(math.min(attacker:GetMaxHealth(), attacker:Health() + math.floor(attacker.BloodLustMeleeHeal)))
				attacker.BloodLustMeleeHeal = attacker.BloodLustMeleeHeal - math.floor(attacker.BloodLustMeleeHeal)
			end
		end
	end

	if (ent:IsNextBot() or ent:IsNPC()) and (!ent.LastAttacker or ent:Health() > 0) and attacker:IsPlayer() and not (self.SafezoneGrindingPrevention == 2 and attacker:IsSZProtected()) then
		ent.LastAttacker = attacker
		if !ent.BossMonster then
			timer.Create("TEAZombieLastAttacker_"..ent:EntIndex(), 15, 1, function()
				if !ent:IsValid() then return end
				ent.LastAttacker = nil	-- after some time when the target last received damage from the attacker, we claim that the last target's attacker is no more
			end)
		else
			self.NextInfectionDecrease = math.max(self.NextInfectionDecrease, CurTime() + 6)
		end

		if ent.DamagedBy then
			if !ent.DamagedBy[attacker] then 
				ent.DamagedBy[attacker] = math.Clamp(dmginfo:GetDamage(), 0, ent:Health())
			else
				ent.DamagedBy[attacker] = math.max(ent.DamagedBy[attacker] + math.Clamp(dmginfo:GetDamage(), 0, ent:Health()), 0)
			end
		end
	end

	if ent:GetClass() == "prop_physics" and ent.prophealth then
		if ent.prophealth then
			ent.prophealth = ent.prophealth - dmginfo:GetDamage()
		end
		-- local ColorAmount = ((ent:Health() / ent.maxhealth) * 255)
		-- ent:SetColor(Color(ColorAmount, ColorAmount, ColorAmount, 255))
		if ent.prophealth <= 0 then
			ent:PrecacheGibs()
			ent:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
			ent:Input("break")
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


local function pvpmsg(pl, msg)
	local handler = "NoPvPMsgAntiSpamTimer"..pl:EntIndex()
	if !timer.Exists(handler) then
		pl:SystemMessage(msg, Color(255,205,205), true)
		timer.Create(handler, 0.5, 1, function() end)
	end
end
function GM:PlayerShouldTakeDamage(ply, attacker)
	if !ply:Alive() then return false end

	if ply:IsSZProtected() then
		if attacker:IsPlayer() then
			pvpmsg(attacker, "Target is in safezone! You can't damage them!")
		end
		return false
	end

	if attacker:IsPlayer() then
		if attacker:IsSZProtected() then
			pvpmsg(attacker, "You can't damage other players while inside a safezone!")
			return false
		end
	end

	if attacker:IsPlayer() and ply != attacker then
		-- ply.Territory != team.GetName(attacker:Team()) -- can cause the faction members able to fucking kill a loner and loner cant deal damage to the attacker. need to fix that

		if !ply:IsPvPForced() then
			if ply:HasGodMode() or ply.SpawnProtected then
				pvpmsg(attacker, "This target is invulnerable!")
				return false
			elseif attacker:Team() == TEAM_LONER and not attacker:GetNWBool("pvp") and GAMEMODE.VoluntaryPvP then
				pvpmsg(attacker, "Your PvP is not enabled!")
				return false
			elseif ply:Team() == TEAM_LONER and not ply:GetNWBool("pvp") and GAMEMODE.VoluntaryPvP then
				pvpmsg(attacker, "You can't attack loners unless they have PvP enabled!")
				return false
			end
		end

		if ply:Team() == attacker:Team() and ply:Team() ~= TEAM_LONER and attacker:Team() ~= TEAM_LONER then
			pvpmsg(attacker, "You can't attack your factionmates!")
			return false
		end
		if attacker:IsPvPGuarded() then
			pvpmsg(attacker, "You have PvP guarded! You can't damage other players!")
			return false
		elseif ply:IsPvPGuarded() then
			pvpmsg(attacker, "Target has PvP guarded! You can't damage that player!")
			return false
		end

		if !ply:IsPvPForced() then
			ply.PvPNoToggle = CurTime() + 60
			attacker.PvPNoToggle = CurTime() + 60
		end
	end

	return true
end

function GM:HandlePlayerArmorReduction(ply, dmginfo)
	-- If no armor, or special damage types, bypass armor 
	if ply:Armor() <= 0 or bit.band(dmginfo:GetDamageType(), DMG_FALL + DMG_DROWN + DMG_POISON + DMG_RADIATION) ~= 0 then return end

	local flBonus = 0.5 -- Each Point of Armor is worth 1/x points of health
	local flRatio = 0.25 -- Armor Takes 75% of the damage

	local flNew = dmginfo:GetDamage() * flRatio
	local flArmor = (dmginfo:GetDamage() - flNew) * flBonus

	-- Does this use more armor than we have?
	if flArmor > ply:Armor() then
		flArmor = ply:Armor() / flBonus
		flNew = dmginfo:GetDamage() - flArmor
		ply:SetArmor(0)
	else
		ply:SetArmor(ply:Armor() - flArmor)
	end

	dmginfo:SetDamage( flNew )
end

function GM:PlayerInitialSpawn(ply, transition)
	self.BaseClass:PlayerInitialSpawn(ply)
	ply:AllowFlashlight(true)
	
	-------- Survival Stats --------
	ply.SurvivalTime = CurTime()
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Battery = 100
	ply.Oxygen = 100

	ply.Radiation = 0

	ply.Money = 0
	ply.Bounty = 0
	----------------
	
	-------- Progression Stats --------
	ply.XP = 0
	ply.Level = 1
	ply.Prestige = 0
	ply.StatPoints = 0
	ply.PerkPoints = 0
	----------------
	
	-------- Statistics --------
	ply.Statistics = {
		BestSurvivalTime = 0,
		
		ZombieKills = 0,
		ZombieKillAssists = 0,
		BossKills = 0,
		BossKillAssists = 0,
		ZombieDamageToZombies = 0,

		PlayersKilled = 0,

		Deaths = 0,
		DeathsByThirst = 0,
		DeathsByHunger = 0,
		DeathsByFatigue = 0,
		DeathsByInfection = 0,
		DeathsByZombies = 0,
		DeathsByPlayers = 0,
		DeathsBySuicide = 0,
	}
	ply.LifeStats = {}
	----------------
	
	-------- Mastery Stats --------
	ply.MasteryMeleeXP = 0
	ply.MasteryMeleeLevel = 0
	ply.MasteryPvPXP = 0
	ply.MasteryPvPLevel = 0
	----------------
	
	-------- Other Stats --------
	ply.PropCount = 0
	ply.SelectedProp = "models/props_debris/wood_board04a.mdl"
	ply.ChosenModel = "models/player/kleiner.mdl"
	ply.Territory = "none"
	ply.EquippedArmor = "none"
	ply.CurrentTask = ""
	ply.CurrentTaskProgress = 0

	ply.Inventory = {}
	ply.Vault = {}
	ply.UnlockedPerks = {}
	ply.ArmorAttachments = {}
	ply.InvitedTo = {}
	ply.Achievements = {}
	ply.AchProgress = {}
	ply.TaskCooldowns = {}
	ply.CharactersData = {}
	ply.AdminEyes = {}

	ply.HPRegen = 0
	ply.SlowDown = 0
	ply.ZombieKillStreak = 0
	ply.MeleeDamageDealt = 0
	ply.LastStunTime = 0
	ply.PoisonDamage = 0
	ply.DrownDamage = 0
	ply.StatsDyingDamage = 0
	ply.BloodLustMeleeHeal = 0
	ply.BloodLustMeleeHealCap = 0
	ply.BloodLustLastMeleeHit = 0
	ply.NextSleepDelay = 0

	ply.CanUseFlashlight = true
	ply.SpawnProtected = false
	ply.DropCashCDcount = 0
	ply.StatsPaused = false
	ply.TEANoTarget = false
	ply.CanUseItem = true
	ply.StatsReset = 0
	ply.InvalidInventory = {} -- saves invalid items here
	ply.MaxLevelTime = 0

	ply.PvPNoToggle = 0
	ply.PvPAntiMsg = 0 -- prevents spamming messages if player attacks with pvp off or something else
	ply.PvPAntiMsgProp = 0 -- same as above but for props
	ply.HitSoundEffect = 0
	ply.UsingItemDuration = 0
	ply.UsingItemTime = 0
	ply.UsingItemActive = false
	ply.UsingItemCanMove = true
	ply.UsingItemSwitchWeapon = ""
	----------------

	-------- Other --------

	for statname, _ in pairs(self.StatConfigs) do
		ply["Stat"..statname] = 0
	end

	for k,v in pairs(self.Achievements) do
		ply.Achievements[k] = 0
		ply.AchProgress[k] = 0
	end

	if !ply:IsBot() then
		timer.Simple(0.01, function()
			ply:KillSilent()
			ply:SetPos(Vector(0,0,100000)) -- for main menu
		end)
	end

	print(Format("Loading datafiles for %s...\n", ply:Nick()))
	gamemode.Call("LoadPlayer", ply)

	ply:SetPvPGuarded(0)
	ply:SetNWBool("pvp", false)
	ply:SetNWString("ArmorType", "none")
	ply:SetTeam(TEAM_LONER)

	ply:ArmorEquip(ply.EquippedArmor)
end

function GM:PlayerPostThink(ply)
end


function GM:PlayerReady(ply)
	self:FullyUpdatePlayer(ply)
	self:SendMapTransitionsInfo(ply)
	self:SendMapSafezonesInfo(ply)
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
	if sv_alltalk:GetInt() == 1 then return true, false end

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

	for i=1,20 do -- There is some kind of annoying-ass inf speed in my gmod instance, so meh. Let it be like it is for now
		timer.Simple(engine.TickInterval()*i, function()
			gamemode.Call("RecalcPlayerSpeed", ply)
		end)
	end

	timer.Simple(1, function()
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
	if ply.AdminMode then
		ply:Give("weapon_physgun")
		ply:Give("gmod_tool")
		ply:Give("tea_admintool")
		ply:Give("tea_buildtool")
		ply:SelectWeapon("tea_admintool")
	else
		ply:Give("tea_fists")
		ply:Give("tea_buildtool")
		ply:SelectWeapon("tea_fists")
	end
	if ply:HasPerk("starting_ammo_upgrade") then
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

	if ply.LastLifeAmmo then
		for k,v in pairs(ply.LastLifeAmmo) do
			ply:SetAmmo(math.max(ply:GetAmmoCount(k), v*0.4), k)
		end

		ply.LastLifeAmmo = nil
	end
end

function GM:PlayerUse(ply, ent) --why is that here??
	if not (ent and ent:IsValid()) then return end
	return true
end


function GM:PlayerSpawnedProp(userid, model, prop)
	prop.owner = userid
	prop.model = model
end

function GM:PlayerNoClip(ply, on)
	if AdminCheck(ply) then
		if game.IsDedicated() then
			print(translate.Format(on and "x_turned_on_noclip" or "x_turned_off_noclip", ply:Name()))
		end
		PrintTranslatedMessage(HUD_PRINTCONSOLE, on and "x_turned_on_noclip" or "x_turned_off_noclip", ply:Name())

		return true
	end

	if ply:GetMoveType(MOVETYPE_NOCLIP) then
		ply:SetMoveType(MOVETYPE_WALK)
	end
	return false
end

-- not like setplayermodel, just reads their model and colour settings and sets them to it
function GM:RecalcPlayerModel(ply)
	if !ply.ChosenModel then ply.ChosenModel = "models/player/kleiner.mdl" end
	if !ply.ChosenModelColor then ply.ChosenModelColor = Vector(0.25, 0, 0) end
	local gmod_hands
	for _,ent in pairs(ents.FindByClass("gmod_hands")) do -- without this, causes LUA ERRORS if spawning in the first time with armor
		if ent:GetOwner() == ply then
			gmod_hands = ent
			break
		end
	end

	if type(ply.ChosenModelColor) == "string" then ply.ChosenModelColor = Vector(ply.ChosenModelColor) end
	ply:SetPlayerColor(ply.ChosenModelColor)

	if ply:IsAdmin() and ply.EquippedArmor == "none" then
		ply:SetModel(player_manager.TranslatePlayerModel(ply:GetInfo("cl_playermodel")))
		return false
	end

	if !self.ItemsList[ply.EquippedArmor] or self.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"] == nil then
		if !table.HasValue(self.DefaultModels, ply.ChosenModel) then
			ply.ChosenModel = table.Random(self.DefaultModels)
		end
		ply:SetModel(ply.ChosenModel)
		if gmod_hands and gmod_hands:IsValid() then
			ply:SetupHands()
		end
		return true
	end

	local models = self.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"]
	if !table.HasValue(models, ply.ChosenModel) then
		ply.ChosenModel = table.Random(models)
		ply:SetModel(ply.ChosenModel)
		if gmod_hands and gmod_hands:IsValid() then
			ply:SetupHands()
		end
		return false
	else
		ply:SetModel(ply.ChosenModel)
		if gmod_hands and gmod_hands:IsValid() then
			ply:SetupHands()
		end
		return true
	end
end

function GM:RecalcPlayerSpeed(ply)
	if !ply:IsValid() then return false end
	local armorspeedmul = 1
	local walkspeed = self.Config["WalkSpeed"]
	local runspeed = self.Config["RunSpeed"]
	local walkspeedbonus = ply.StatSpeed * 3
	local runspeedbonus = ply.StatSpeed * 7
	local plyarmor = ply:GetNWString("ArmorType")
	local slowdown = tonumber(ply.SlowDown or 0)

	if plyarmor and plyarmor != "none" then
		local armortype = self.ItemsList[plyarmor]
		armorspeedmul = 1 - armortype.ArmorStats["speedloss_percent"]*0.01
	end
	
	local totalwspeed = math.max(1, (walkspeed + walkspeedbonus) * (1 - slowdown)) * armorspeedmul -- walk
	local totalrspeed = math.max(1, (runspeed + runspeedbonus) * (1 - slowdown)) * armorspeedmul -- run
	local totalswspeed = math.Clamp((walkspeed + walkspeedbonus) * (0.75 * (1 - slowdown)), 1, 100) * armorspeedmul -- slowwalk


	local weight, maxweight, maxwalkweight = ply:CalculateWeight(), ply:CalculateMaxWeight(), ply:CalculateMaxWalkWeight()
	local weightpenalty = 1
	if weight >= maxwalkweight then
		totalwspeed = 1
		totalrspeed = 1
		totalswspeed = 1
	elseif weight >= maxweight then
		weightpenalty = math.Clamp(0.2 + ((maxwalkweight - maxweight) - (weight - maxweight)) / ((maxwalkweight - maxweight)/0.6), 0.2, 0.8)
	end

	self:SetPlayerSpeed(ply, math.max(1, totalwspeed * weightpenalty), math.max(1, totalrspeed * weightpenalty))
	ply:SetSlowWalkSpeed(math.max(1, totalswspeed * weightpenalty))
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

function GM:AddWSResources()
-------- Workshop addons --------

	resource.AddWorkshop("3702055118") -- gamemode content
	resource.AddWorkshop("2438451886") -- STALKER item models pack
	resource.AddWorkshop("1270991543") -- STALKER armor playermodels
	resource.AddWorkshop("355101935") -- STALKER TNB armor playermodels
	resource.AddWorkshop("128089118") -- m9k assault rifles
	resource.AddWorkshop("128091208") -- m9k heavy weapons
	resource.AddWorkshop("128093075") -- m9k small arms pack
	resource.AddWorkshop("144982052") -- m9k specialties
end
