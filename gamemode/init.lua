AddCSLuaFile("cl_init.lua") -- clientside init file
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_translate.lua")
AddCSLuaFile("sh_items.lua")
AddCSLuaFile("sh_loot.lua")
AddCSLuaFile("sh_spawnables.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_crafting.lua")
AddCSLuaFile("sh_achievements.lua")
AddCSLuaFile("sh_deathsounds.lua")

AddCSLuaFile("client/cl_scoreboard.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/cl_createfaction.lua")
AddCSLuaFile("client/cl_modelsmenu.lua")
AddCSLuaFile("client/cl_contextmenu.lua")
AddCSLuaFile("client/cl_customdeathnotice.lua")
AddCSLuaFile("client/cl_spawnmenu.lua")
AddCSLuaFile("client/cl_tradermenu.lua")
AddCSLuaFile("client/cl_dermahooks.lua")
AddCSLuaFile("client/cl_lootmenu.lua")
AddCSLuaFile("client/cl_adminmenu.lua")
AddCSLuaFile("client/cl_statsmenu.lua")
AddCSLuaFile("client/cl_helpmenu.lua")
AddCSLuaFile("client/cl_bosspanel.lua")
AddCSLuaFile("client/cl_options.lua")
AddCSLuaFile("client/cl_changelogs.lua")
--AddCSLuaFile("client/cl_deathscreen.lua") -- if you want, but it's unfinished


include("shared.lua")
include("sh_translate.lua") -- translation file
include("sh_items.lua") -- items for inventory
include("sh_loot.lua") -- for loots
include("sh_spawnables.lua") -- spawnable props with build tool
include("sh_config.lua") -- gamemode config
include("sh_crafting.lua") -- list for craftable items
include("sh_achievements.lua") -- achievements
include("sh_deathsounds.lua") -- death sounds used for various player models

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
include("server/player_props.lua") -- Managing with props
include("server/player_vault.lua") -- And vault
include("server/npcspawns.lua") -- Zombie spawns
include("server/traders.lua") -- Traders
include("server/airdrops.lua") -- Airdrops
include("server/factions.lua") -- Anything here included for faction
include("server/loot_system.lua") -- loots
include("server/debug.lua") -- Debug stuff, highly advised not to edit
include("server/specialstuff.lua") -- anything uncategorized, hard to name or for server can be added here
include("server/spawnpoints.lua") -- spawnpoints
include("server/crafting.lua") -- crafting managing
include("server/mastery.lua") -- Mastery for various types, including pvp and melee
--include("server/weather_events.lua") -- excluded because file is empty
--include("time_weather.lua") -- excluded due to file being non-existant


Factions = Factions or {}
DEBUG = false

function GM:ShowHelp(ply)
	ply:SendLua("HelpMenu()")
end

function GM:ShowTeam(ply)
	if !SuperAdminCheck(ply) then return false end
	ply:SendLua("AdminMenu()")
end

function GM:ShowSpare1(ply)
	ply:SendLua("DropGoldMenu()")
end

function GM:ShowSpare2(ply)
	ply:SendLua("MakeOptions()")
end

function GM:CalcMaxHealth(ply) return 100 + (5 * (ply.StatVitality or 0)) + (tonumber(ply.Prestige or 0) >= 2 and 5 or 0) end
function GM:CalcMaxArmor(ply) return 100 + (2 * (ply.StatEngineer or 0)) + (tonumber(ply.Prestige or 0) >= 5 and 5 or 0) end
function GM:CalcJumpPower(ply) return 160 + (2 * (ply.StatAgility or 0)) + (tonumber(ply.Prestige or 0) >= 4 and 10 or 0) end

function GM:OnPlayerHitGround(ply, inWater, onFloater, speed)
    if speed > (450 + (2 * ply.StatAgility)) then
        ply:ViewPunch(Angle(5, 0, 0))
		if !ply.StatsPaused then
			ply.Stamina = math.Clamp(ply.Stamina - (10 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    elseif speed > (300 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(5, 0, 0))
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

--You will no longer be able to regenerate your health when having either 40%< Hunger, 35%< Thirst, >65% Fatigue or >40% Infection (dependent on "Immunity" and "Survivor" skills' values)
function GM.HealthRegen()
	for k, ply in pairs(player.GetAll()) do
		local hp = ply.HPRegen
		if !hp or hp < 1 or !(ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity))) then continue end
		ply:SetHealth(math.Clamp(ply:Health() + math.floor(hp), 5, ply:GetMaxHealth()))
		ply.HPRegen = ply.HPRegen - math.floor(ply.HPRegen)
	end
end
timer.Create("tea_HealthRegen", 2, 0, GM.HealthRegen)


function GM:Think()
	for k, ply in pairs(player.GetAll()) do
		if !ply:IsValid() or !ply:Alive() then continue end
		if ply.StatsPaused then tea_NetUpdateStats(ply) continue end

		local endurance = ((ply.StatEndurance - (0.15 * ply.StatSpeed)) / 500)

		-- hunger, thirst, fatigue, infection
		ply.Hunger = math.Clamp(ply.Hunger - (0.065 * (1 - (ply.StatSurvivor * 0.04))), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst - (0.0782 * (1 - (ply.StatSurvivor * 0.0425))), 0, 10000)

		if (ply.Thirst <= 0 or ply.Hunger <= 0 or ply.Fatigue >= 10000 or ply.Infection >= 10000) and ply:Alive() then
			if !timer.Exists("DyingFromStats_"..ply:EntIndex()) then
				timer.Create("DyingFromStats_"..ply:EntIndex(), 30, 1, function()
					ply:Kill()
				end)
			end
		else
			if timer.Exists("DyingFromStats_"..ply:EntIndex()) then
				timer.Destroy("DyingFromStats_"..ply:EntIndex())
			end
		end

		ply.Fatigue = math.Clamp(ply.Fatigue + (0.045 * (1 - (ply.StatSurvivor * 0.035))), 0, 10000)
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = self.ItemsList[armorstr]
		if ply:FlashlightIsOn() then
			if ply.Battery <= 0 then
				ply:Flashlight(false)
				ply:AllowFlashlight(false)
				ply.CanUseFlashlight = false
			else
				ply.Battery = math.Clamp(ply.Battery - 0.01, 0, 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0))
			end
		else
			ply.Battery = math.Clamp(ply.Battery + 0.0135, 0, 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0))
			if ply.Battery >= 10 then
				ply:AllowFlashlight(true)
				ply.CanUseFlashlight = true
			end
		end

-- in case if player's HPRegen value is nil then it's set to 0
		if ply.HPRegen and ply:Health() < ply:GetMaxHealth() and ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity)) then
			ply.HPRegen = math.Clamp(ply.HPRegen + 0.00175 + (ply.StatMedSkill * 0.0001), 0, ply:GetMaxHealth())
		elseif !ply.HPRegen or ply.HPRegen > 0 then
			ply.HPRegen = 0
		end

		--random chance of getting infected per tick is very rare, but has chance if survived for more than 10 minutes, can decrease chance of this happening by increasing immunity skill level
		local infectionchance = math.random(1, 2000000 + (100000 * ply.StatImmunity) - (CurTime() - ply.SurvivalTime))
		if (infectionchance <= 1 and math.floor(CurTime() - ply.SurvivalTime) >= 600) and ply.Infection <= 0 and ply:Alive() then
			SendChat(ply, translate.ClientGet(ply, "plcaughtinfection"))
		end
		if (ply.Infection > 0 or (infectionchance <= 1 and math.floor(CurTime() - ply.SurvivalTime) >= 600)) and ply:Alive() then
			ply.Infection = math.Clamp(ply.Infection + (0.1176 * (1 - (ply.StatImmunity * 0.04))), 0, 10000)
		end

		if ply:GetMoveType() != MOVETYPE_NOCLIP or ply:InVehicle() then
			if (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)) then
				PlayerIsMoving = true
			else
				PlayerIsMoving = false
			end

/*		if ply:OnGround() and ply:KeyPressed(IN_JUMP) then
			ply.Stamina = ply.Stamina - 5
		end
*/ -- Trying to find function that drains stamina on jumping, but this one doesn't really work

			if ply:WaterLevel() == 3 and ply:Alive() then
				ply.Thirst = math.Clamp(ply.Thirst + 0.243 , 0, 10000)
				if tonumber(ply.Stamina) <= 0 and !timer.Exists("DrownTimer"..ply:EntIndex()) then
					timer.Create("DrownTimer"..ply:EntIndex(), 10, 1, function()
						ply:Kill()
					end)
				else
					ply.Stamina = math.Clamp(ply.Stamina - (0.093 - endurance), 0, 100)
				end
			elseif !ply:InVehicle() and (ply:KeyDown(IN_SPEED) and PlayerIsMoving and not ply:Crouching()) then
				ply.Stamina = math.Clamp(ply.Stamina - (0.0755 - endurance), 0, 100)
			elseif !ply:InVehicle() and PlayerIsMoving and ply:Crouching() then
				ply.Stamina = math.Clamp(ply.Stamina + 0.00897 + endurance, 0, 100)
			elseif !ply:InVehicle() and PlayerIsMoving then
				ply.Stamina = math.Clamp(ply.Stamina + 0.00691 + endurance, 0, 100)
			elseif ply:InVehicle() or ply:Crouching() then
				ply.Stamina = math.Clamp(ply.Stamina + 0.043 + endurance, 0, 100)
			else
				ply.Stamina = math.Clamp(ply.Stamina + 0.047 + endurance, 0, 100)
			end
		
			if ply.Stamina > 30 then
				ply.sprintrecharge = false
			end
		
			if(ply:KeyDown(IN_SPEED) and PlayerIsMoving and ply.Stamina <= 0) then
				ply:ConCommand("-speed")
				ply.sprintrecharge = true
			end
		
			if (ply:KeyDown(IN_SPEED) and PlayerIsMoving and ply.sprintrecharge == true and ply.Stamina <= 30) then
				ply:ConCommand("-speed")
			end
		end

		if tonumber(ply.Stamina) > 0 or ply:WaterLevel() != 3 then
			if timer.Exists("DrownTimer"..ply:EntIndex()) then
				timer.Destroy("DrownTimer"..ply:EntIndex())
			end
		end

		tea_NetUpdateStats(ply)
	end
end

function GM:InitPostEntity()
	RunConsoleCommand("mp_falldamage", "1")
	RunConsoleCommand("M9KDefaultClip", "0") --it's set to 0 so the users don't abuse use and drop commands on m9k weapons over and over again
	RunConsoleCommand("M9KDisablePenetration", "1") --they are op with penetration, time to nerf them again (unless you want them to remain the same, remove or exclude this line)
	RunConsoleCommand("sv_defaultdeployspeed", "1") --so that users don't just switch weapons too quickly

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

function GM:PlayerDisconnected(ply)
	tea_SystemBroadcast(ply:Nick().." has left the server", Color(255,255,155,255), false)

	if ply.Bounty >= 5 then
		local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
		local bountyloss = ply.Bounty - cashloss
		print(ply:Nick() .." has left the server with "..ply.Bounty.." bounty and dropped money worth of "..math.floor(cashloss).." "..self.Config["Currency"].."s!")

		local EntDrop = ents.Create("ate_cash")
		EntDrop:SetPos(ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles(Angle(0, 0, 0))
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()
	end
	
	tea_SavePlayer(ply)
	tea_SavePlayerInventory(ply)
	tea_SavePlayerVault(ply)
	for k,v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
		if v.BossMonster and v.DamagedBy[ply] then v.DamagedBy[ply] = nil end
	end

	if ply:Team() != 1 then
		local plyfaction = team.GetName(ply:Team())
		if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
			timer.Simple(0.4, function() --this time it should work properly
				SelectRandomLeader(plyfaction)
			end)
		elseif team.NumPlayers(ply:Team()) <= 1 then
			AutoDisbandFaction(plyfaction)
		end
	end -- don't bother disbanding or switching faction leader if they are a loner
end


function GM:PlayerConnect(name, ip)
	for k, ply in pairs(player.GetAll()) do
		SystemMessage(ply, translate.ClientFormat(ply, "pljoined", name), Color(255,255,155,255), false)
	end
end

local function CheckForDerp()
	local chance = 0
	for k, v in pairs(GAMEMODE.Config["ZombieClasses"]) do
		chance = chance + v.SpawnChance
	end
	if chance > 100 then 
		ErrorNoHalt("\n\n------=== CONFIGURATION ERROR ===------ \nThe total zombie spawn chance of this server has exceeded 100% (Currently "..chance.."%)!\nSome zombie types may not be able to spawn, see theeternalapocalypse/gamemode/sh_config.lua for more info\n\n")
	elseif chance < 100 then MsgC(Color(255,127,127,255), "Check for zombie spawn chance... "..chance.."% (Not perfect)\n")
	else MsgC(Color(191,191,255,255), "Check for zombie spawn chance... "..chance.."% (OK)\n") end
end

function GM:Initialize()
	MsgC(Color(255,191,191,255), "\n==============================================\n\n")
	MsgC(Color(255,191,191,255), self.Name.." ("..self.AltName..") Gamemode Loaded Successfully\n\n")
	MsgC(Color(255,191,191,255), "Made by "..self.Author.."\n\n")
	MsgC(Color(255,191,191,255), "Original Creator: LegendofRobbo\n\n")
	MsgC(Color(255,191,191,255), "Version: "..self.Version.."\n\n")
	MsgC(Color(255,191,191,255), "Github: https://github.com/Uklejamini357/gmodtheeternalapocalypse \n\n")
	MsgC(Color(255,191,191,255), "Remember to check out github site for new updates\n\n")
	MsgC(Color(255,191,191,255), "==============================================\n\n")

	self.NextZombieSpawn = 0
	self.NextBossSpawn = 0
	self.ZombieSpawningEnabled = true
	self.CanSpawnBoss = false
	self.CanSpawnAirdrop = false

	self:LoadLoot()
	self:LoadAD()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	self.DebugLogs = {}
	CheckForDerp()

end

function GM:Tick() -- same as GM:Think but here it's used just for server and not used if convar sv_hibernate_think is disabled
	if CurTime() > tonumber(self.NextZombieSpawn) then
		self.NextZombieSpawn = CurTime() + tonumber(self.Config["ZombieSpawnRate"]) 
		self.SpawnZombies()
	end
	if CurTime() > tonumber(self.NextBossSpawn) then
		self.NextBossSpawn = CurTime() + tonumber(self.Config["BossSpawnRate"]) 
		SpawnBoss()
	end



	-- The Ultimate timer of Auto-Maintenance
	if !self.IsMaintenance and CurTime() >= tonumber(self.Config["AutoMaintenanceTime"]) * 3600 then
		tea_SystemBroadcast("[AUTO-MAINTENANCE SYSTEM]:", Color(255,255,255), false)
		self.MinutesBeforeMaintenance = tonumber(self.Config["AutoMaintenanceDelay"])
		tea_SystemBroadcast(Format("Attention! The server will automatically restart map in %d minutes! Please make sure you have salvaged all of your structures and cashed in your bounties before the server restarts.", self.MinutesBeforeMaintenance), Color(205,205,205), false)
		print(Format("Starting map restart sequence. ETA: %d minutes.", self.MinutesBeforeMaintenance))
		for _,v in pairs(player.GetAll()) do v:ConCommand("playgamesound common/warning.wav") end
		self.IsMaintenance = true
		timer.Create("tea_ChangingLevel", 60, 0, function()
			if self.MinutesBeforeMaintenance > 1 then
				self.MinutesBeforeMaintenance = self.MinutesBeforeMaintenance - 1
				tea_SystemBroadcast(Format("Due to maintenances, the server will restart in %d minutes.", self.MinutesBeforeMaintenance), Color(205,205,205), true)
			else
				tea_SystemBroadcast("WARNING! Server is restarting in:", Color(205,205,205), true)
				timer.Destroy("tea_ChangingLevel")
				self.AutoMaintenancePhase = 10
				timer.Create("tea_ChangingLevel_2", 1, 0, function()
					if self.AutoMaintenancePhase >= 1 then
						tea_SystemBroadcast(self.AutoMaintenancePhase.."...", Color(205,25.5*self.AutoMaintenancePhase,25.5*self.AutoMaintenancePhase), false)
						for _,ply in pairs(player.GetAll()) do ply:ConCommand("playgamesound buttons/button17.wav") end
						self.AutoMaintenancePhase = self.AutoMaintenancePhase - 1
					else
						if !self.RestartingLevel then
							tea_SystemBroadcast("Restarting server...", Color(205,205,205), true)
							self.RestartingLevel = true
							for _,ply in pairs(player.GetAll()) do ply:ConCommand("playgamesound buttons/button15.wav") end
						end
						timer.Simple(1, function()
							for k,o in pairs(GAMEMODE.Config["ZombieClasses"]) do
								for _, ent in pairs(ents.FindByClass(k)) do
									ent:Remove()
								end
							end
						end)
						timer.Simple(2, function()
							for k,o in pairs(GAMEMODE.Config["BossClasses"]) do
								for _, ent in pairs(ents.FindByClass(k)) do
									ent:Remove()
								end
							end
						end)
						timer.Simple(5, function()
							RunConsoleCommand('changelevel', game.GetMap())
						end)
					end
				end)
			end
		end)
	end
end


function GM:OnReloaded()
	timer.Simple(0.3, function()
		for k, v in pairs(player.GetAll()) do tea_FullyUpdatePlayer(v) end
	end)
	print("\n")

	self:LoadLoot()
	self:LoadAD()
	self:LoadZombies()
	self:LoadTraders()
	self:LoadPlayerSpawns()
	CheckForDerp()
end

function GM:PostCleanupMap()
	timer.Simple(0.5, function() self:SpawnTraders() end)
end


function GM:PlayerInitialSpawn(ply, transition)
	self.BaseClass:PlayerInitialSpawn(ply)
	ply:AllowFlashlight(true)
	
	-------- Normal Stats --------
	ply.SurvivalTime = math.floor(CurTime())
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Battery = 100
	ply.HPRegen = 0
	ply.ChosenModel = "models/player/kleiner.mdl"
	ply.Inventory = {} -- very important, the gamemode will not function properly without it!
	ply.XP = 0
	ply.Money = 0
	ply.Bounty = 0
	ply.Level = 1
	ply.Prestige = 0
	ply.StatPoints = 0
	ply.PropCount = 0
	ply.InvitedTo = {} -- stores faction invites
	ply.Achievements = {} -- stores gained achievements
	ply.AchProgress = {} -- stores achievement progresses
	ply.SelectedProp = "models/props_debris/wood_board04a.mdl"
	ply:SetPvPGuarded(0)
	ply.Territory = "none"
	ply.EquippedArmor = "none"
	ply.BestSurvivalTime = 0
	ply.ZKills = 0
	ply.playerskilled = 0
	ply.playerdeaths = 0
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
	ply.IsAlive = true	-- identified if player is alive before death
	ply.SpawnProtected = false
	ply.DropCashCDcount = 0
	ply.StatsPaused = false
	ply.HasNoTarget = false
	ply.CanUseItem = true
	ply.MeleeDamageDealt = 0
	ply.StatsReset = 0
	ply.InvalidInventory = {} -- saves invalid items here
	ply.MaxLevelTime = 0
	----------------

	-------- Other --------

	ply:SendLua(self.ZombieSpawningEnabled and "GAMEMODE.ZombieSpawningEnabled = true" or "GAMEMODE.ZombieSpawningEnabled = false")

	-------- Temporary --------
	ply:PrintMessage(HUD_PRINTTALK, "[The Eternal Apocalypse]: Please note, this is a beta version. Some things may not work as intended.")
	ply:PrintMessage(HUD_PRINTTALK, "If you do find those bugs, please report them to the developer.")
	ply:PrintMessage(HUD_PRINTTALK, "- Uklejamini [The Eternal Apocalypse Dev]")
	----------------


	for k, v in pairs(GAMEMODE.StatsListServer) do
		local TheStatPieces = string.Explode(";", v)
		local TheStatName = TheStatPieces[1]
		ply[TheStatName] = 0
	end
	
	for k,v in pairs(GAMEMODE.Achievements) do
		ply.Achievements[k] = 0
		ply.AchProgress[k] = 0
	end
	
	print("Loading datafiles for "..ply:Nick().."...\n")
	tea_LoadPlayer(ply)
	tea_LoadPlayerInventory(ply)
	tea_LoadPlayerVault(ply)

	ply:SetNWBool("pvp", false)
	ply:SetNWString("ArmorType", "none")
	ply:SetTeam(1)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
	tea_NetUpdateStatistics(ply)

	tea_SystemBroadcast(translate.Format("plspawned", ply:Nick()), Color(255,255,155,255), false)
	ForceEquipArmor(ply, ply.EquippedArmor)
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
	tea_RecalcPlayerModel(ply)

	for k, v in pairs(ents.FindByClass("bed")) do
		if v.Owner and v.Owner:IsValid() and v.Owner == ply then
			local bedspawnpoint = FindGoodSpawnPoint(v)
			if bedspawnpoint then ply:SetPos(bedspawnpoint) end
		end
	end

	if timer.Exists("pvpnominge_"..ply:UniqueID()) then timer.Destroy("pvpnominge_"..ply:UniqueID()) end

	local tea_server_spawnprotection = GetConVar("tea_server_spawnprotection"):GetInt() >= 1
	local tea_server_spawnprotection_duration = GetConVar("tea_server_spawnprotection_duration"):GetFloat()

	if tea_server_spawnprotection_duration > 0 and tea_server_spawnprotection then
		if !ply:Alive() then return end
		ply.SpawnProtected = true
		ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "plspawnprot_on", tea_server_spawnprotection_duration)
	end
	if tea_server_spawnprotection_duration > 0 and tea_server_spawnprotection then
		timer.Create("IsSpawnProtectionTimerEnabled"..ply:UniqueID(), tea_server_spawnprotection_duration, 1, function()
			if !ply:IsValid() or !ply:Alive() then return end
			ply.SpawnProtected = false
			ply:PrintTranslatedMessage(HUD_PRINTCONSOLE, "plspawnprot_off")
		end)
	end

	timer.Simple(0.2, function()
		tea_RecalcPlayerSpeed(ply)
		timer.Simple(3, function()
			tea_RecalcPlayerSpeed(ply) --shouldn't have that many timers but whatever
		end)
	end)

	ply:SetNWBool("pvp", false)
	ply:SetPvPGuarded(0)
	ply:SetPlayerColor(Vector(cl_playercolor))
	ply:SetMaxHealth(self:CalcMaxHealth(ply))
	ply:SetHealth(self:CalcMaxHealth(ply))
	ply:SetMaxArmor(self:CalcMaxArmor(ply))
	ply:SetJumpPower(self:CalcJumpPower(ply))
	tea_RecalcPlayerModel(ply)
	tea_PrepareStats(ply)
	tea_FullyUpdatePlayer(ply)

	-- give them a new gun if they are still levels under Rookie Level and are at prestige 0
	local newgun = self.Config["RookieWeapon"]
	if tonumber(ply.Level) <= tonumber(self.Config["RookieLevel"]) and tonumber(ply.Prestige) <= 0 and !ply.Inventory[newgun] then
		tea_SystemGiveItem(ply, newgun)
		tea_SendInventory(ply)
	end
end

function GM:PlayerLoadout(ply)
	ply:Give("tea_fists")
	ply:Give("tea_buildtool")

	ply:SelectWeapon("tea_fists")
end


function GM:PlayerSpawnedProp(userid, model, prop)
	prop.owner = userid
	prop.model = model
end

function GM:PlayerNoClip(ply, on)
	if AdminCheck(ply) or SuperAdminCheck(ply) or TEADevCheck(ply) or TEASVOwnerCheck(ply) then
		PrintMessage(HUD_PRINTCONSOLE, translate.Format(on and "x_turned_on_noclip" or "x_turned_off_noclip", ply:Name()))
		return true
	end

	if ply:GetMoveType(MOVETYPE_NOCLIP) then
		ply:SetMoveType(MOVETYPE_WALK)
	end
	return false
end

-- not like setplayermodel, just reads their model and colour settings and sets them to it
function tea_RecalcPlayerModel(ply)
	if ply:IsBot() then ply:SetModel("models/player/soldier_stripped.mdl") return end -- this only works for bots
	if !ply.ChosenModel then ply.ChosenModel = "models/player/kleiner.mdl" end
	if !ply.ChosenModelColor then ply.ChosenModelColor = Vector(0.25, 0, 0) end

	if type(ply.ChosenModelColor) == "string" then ply.ChosenModelColor = Vector(ply.ChosenModelColor) end
	ply:SetPlayerColor(ply.ChosenModelColor)

	if !GAMEMODE.ItemsList[ply.EquippedArmor] or GAMEMODE.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"] == nil then
		if !table.HasValue(DefaultModels, ply.ChosenModel) then
			ply.ChosenModel = table.Random(DefaultModels)
		end
		ply:SetModel(ply.ChosenModel)
		return false
	end

	local models = GAMEMODE.ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"]
	if !models[ply.ChosenModel] then ply.ChosenModel = table.Random(models) ply:SetModel(ply.ChosenModel) end
end

function tea_RecalcPlayerSpeed(ply)
	if !ply:IsValid() then return false end
	local armorspeed = 0
	local walkspeed = GAMEMODE.Config["WalkSpeed"]
	local runspeed = GAMEMODE.Config["RunSpeed"]
	local walkspeedbonus = ply.StatSpeed * 3.5
	local runspeedbonus = ply.StatSpeed * 7
	local plyarmor = ply:GetNWString("ArmorType")
	local slowdown = tonumber(ply.SlowDown or 0)
	
	if !ply:IsValid() then return end
	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorspeed = tonumber(armortype["ArmorStats"]["speedloss"])
	end
	
	GAMEMODE:SetPlayerSpeed(ply, math.max(1, ((walkspeed - (armorspeed / 2)) + walkspeedbonus) * (1 - slowdown)), math.max(1, ((runspeed - armorspeed) + runspeedbonus) * (1 - slowdown)))
	ply:SetSlowWalkSpeed(math.Clamp(((walkspeed - (armorspeed / 2)) + walkspeedbonus) * (0.75 * (1 - slowdown)), 1, 100))
end

-- ULX admin mod POSSIBLY overrides this and screws up our voice system... maybe it will be fixed or not
function GM:PlayerCanHearPlayersVoice(listener, talker)
	if listener:GetPos():Distance(talker:GetPos()) <= 1250 then
		return true, false
	else
		return false, false
	end
end

function GM:PlayerShouldTaunt(ply, actid)
	return true
end

function GM:AddResources()
-------- Gamemode Content Files --------

	for _, filename in pairs(file.Find("materials/arleitiss/riotshield/*.vmt", "GAME")) do
		resource.AddFile("materials/arleitiss/riotshield/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/arleitiss/riotshield/*.vtf", "GAME")) do
		resource.AddFile("materials/arleitiss/riotshield/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/entities/*.vtf", "GAME")) do
		resource.AddFile("materials/entities/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/environment maps/*.vtf", "GAME")) do
		resource.AddFile("materials/environment maps/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/weapons/v_wrench/*.vmt", "GAME")) do
		resource.AddFile("materials/models/weapons/v_wrench/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/weapons/v_wrench/*.vtf", "GAME")) do
		resource.AddFile("materials/models/weapons/v_wrench/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/weapons/w_wrench/*.vmt", "GAME")) do
		resource.AddFile("materials/models/weapons/w_wrench/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/rg/*.vmt", "GAME")) do
		resource.AddFile("materials/rg/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/rg/*.vtf", "GAME")) do
		resource.AddFile("materials/rg/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/scope/*.vmt", "GAME")) do
		resource.AddFile("materials/scope/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/scope/*.vtf", "GAME")) do
		resource.AddFile("materials/scope/*.vtf"..filename)
	end
	for _, filename in pairs(file.Find("materials/vgui/entities/*.vmt", "GAME")) do
		resource.AddFile("materials/vgui/entities/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/weapons/*.vmt", "GAME")) do
		resource.AddFile("materials/weapons/*.vmt"..filename)
	end
	for _, filename in pairs(file.Find("materials/weapons/*.vtf", "GAME")) do
		resource.AddFile("materials/weapons/*.vtf"..filename)
	end

	for _, filename in pairs(file.Find("models/items/*.mdl", "GAME")) do
		resource.AddFile("models/items/*.mdl"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.phy", "GAME")) do
		resource.AddFile("models/items/*.phy"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.vtx", "GAME")) do
		resource.AddFile("models/items/*.vtx"..filename)
	end
	for _, filename in pairs(file.Find("models/items/*.vvd", "GAME")) do
		resource.AddFile("models/items/*.vvd"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.mdl", "GAME")) do
		resource.AddFile("models/weapons/*.mdl"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.phy", "GAME")) do
		resource.AddFile("models/weapons/*.phy"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.vtx", "GAME")) do
		resource.AddFile("models/weapons/*.vtx"..filename)
	end
	for _, filename in pairs(file.Find("models/weapons/*.vvd", "GAME")) do
		resource.AddFile("models/weapons/*.vvd"..filename)
	end
	for _, filename in pairs(file.Find("models/*.phy", "GAME")) do
		resource.AddFile("models/*.phy"..filename)
	end

	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.wav", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.mp3", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.mp3"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.ogg", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.ogg"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/grenade/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/grenade/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/44k/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/44k/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/oicw/test/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/oicw/test/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/shared/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/shared/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/universal/*.wav", "GAME")) do
		resource.AddFile("sound/weapons/universal/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/*.mp3", "GAME")) do
		resource.AddFile("sound/weapons/*.mp3"..filename)
	end
	for _, filename in pairs(file.Find("sound/weapons/*.ogg", "GAME")) do
		resource.AddFile("sound/weapons/*.ogg"..filename)
	end
end



-------- Workshop addons --------

	resource.AddWorkshop("128089118") -- m9k assault rifles
	resource.AddWorkshop("128091208") -- m9k heavy weapons
	resource.AddWorkshop("128093075") -- m9k small arms pack
	resource.AddWorkshop("355101935") -- stalker playermodels
	resource.AddWorkshop("411284648") -- gamemode content pack
--	resource.AddWorkshop("448170926") -- ate swep pack (excluded because i copied and remade my own (no, the textures are not fixed yet because i don't know which textures were used by some weapons))
	resource.AddWorkshop("1270991543") -- armor models
	resource.AddWorkshop("1680884607") -- project stalker sounds 
	resource.AddWorkshop("2438451886") -- stalker item models pack
