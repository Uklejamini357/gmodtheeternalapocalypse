AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_translate.lua")
AddCSLuaFile("sh_items.lua")
AddCSLuaFile("sh_loot.lua")
AddCSLuaFile("sh_spawnables.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_crafting.lua")
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
AddCSLuaFile("client/cl_deathscreen.lua")
AddCSLuaFile("client/cl_statsmenu.lua")



include("shared.lua")
include("sh_translate.lua")
include("sh_items.lua")
include("sh_loot.lua")
include("sh_spawnables.lua")
include("sh_config.lua")
include("sh_crafting.lua")
include("server/netstuff.lua")
include("server/server_util.lua")
include("server/config.lua")
include("server/commands.lua")
include("server/admincmd.lua")
include("server/devcmds.lua")
include("server/player_data.lua")
include("server/player_inventory.lua")
include("server/player_props.lua")
include("server/player_vault.lua")
include("server/npcspawns.lua")
include("server/traders.lua")
include("server/airdrops.lua")
include("server/factions.lua")
include("server/loot_system.lua")
include("server/debug.lua")
include("server/weather_events.lua")
include("server/specialstuff.lua")
include("server/spawnpoints.lua")
include("server/crafting.lua")


--include("time_weather.lua")


Factions = Factions or {}
DEBUG = false

function GM:ShowHelp(ply)

	ply:SendLua("hook.Run('StartSearch')")

end

function GM:ShowTeam(ply)
	if !SuperAdminCheck(ply) then return false end
	ply:SendLua("AdminMenu()")
end

function GM:ShowSpare1(ply)
	ply:SendLua("DropGoldMenu()")
end

function CalculateStartingHealth(ply)
if tonumber(ply.Prestige) >= 2 then
	ply:SetHealth(105 + (5 * ply.StatHealth))
	ply:SetMaxHealth(105 + (5 * ply.StatHealth))
else
	ply:SetHealth(100 + (5 * ply.StatHealth))
	ply:SetMaxHealth(100 + (5 * ply.StatHealth))
end
end

function CalculateMaxHealth(ply)
if tonumber(ply.Prestige) >= 2 then
	ply:SetMaxHealth(105 + (5 * ply.StatHealth))
else
	ply:SetMaxHealth(100 + (5 * ply.StatHealth))
end
end

function CalculateMaxArmor(ply)
if tonumber(ply.Prestige) >= 5 then
	ply:SetMaxArmor(105 + (2 * ply.StatEngineer))
else
	ply:SetMaxArmor(100 + (2 * ply.StatEngineer))
end
end

function CalculateJumpPower(ply)
	if tonumber(ply.Prestige) >= 4 then
		ply:SetJumpPower(170 + (2 * ply.StatAgility))
	else
		ply:SetJumpPower(160 + (2 * ply.StatAgility))
	end
end

function GM:OnPlayerHitGround(ply, inWater, onFloater, speed)
    if speed > (400 + (2 * ply.StatAgility)) then
        ply:ViewPunch(Angle(5, 0, 0))
		if !ply.StatsPaused then
        ply.Stamina = math.Clamp(ply.Stamina - (15 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    elseif speed > (140 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(math.random(1, 1.2), 0, math.random(-0.2, 0.2)))
		if !ply.StatsPaused then
			ply.Stamina = math.Clamp(ply.Stamina - (7.5 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045))), 0, 100)
		end
    end
end

--You will no longer be able to regenerate your health when having either 40%< Hunger, 35%< Thirst, >65% Fatigue or >40% Infection (dependent on "Immunity" and "Survivor" skills' values)
function HealthRegen()
	for k, ply in pairs(player.GetAll()) do
		local hp = ply.HPRegen
		if hp == nil or hp < 1 or !(ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity))) then continue end
		ply:SetHealth(math.Clamp(ply:Health() + math.floor(hp), 5, ply:GetMaxHealth()))
		ply.HPRegen = ply.HPRegen - math.floor(ply.HPRegen)
	end
end
timer.Create("HealthRegen", 2, 0, HealthRegen)


function GM:Think()

	for k, ply in pairs(player.GetAll()) do
		if !ply:IsValid() or !ply:Alive() then continue end
		if ply.StatsPaused then TEANetUpdateStats(ply) continue end

		local endurance = ((ply.StatEndurance - (0.15 * ply.StatSpeed)) / 500)

		-- hunger, thirst, fatigue, infection
		ply.Hunger = math.Clamp(ply.Hunger - (0.065 * (1 - (ply.StatSurvivor * 0.04))), 0, 10000)
		ply.Thirst = math.Clamp(ply.Thirst - (0.0782 * (1 - (ply.StatSurvivor * 0.0425))), 0, 10000)

		if !timer.Exists("DyingFromStats"..ply:UniqueID()) and (ply.Thirst <= 0 or ply.Hunger <= 0 or ply.Fatigue >= 10000 or ply.Infection >= 10000) and ply:Alive() then
			timer.Create("DyingFromStats"..ply:UniqueID(), 30, 1, function()
				if ply:Alive() then ply:Kill() end
			end)
		elseif (timer.Exists("DyingFromStats"..ply:UniqueID()) and (ply.Thirst >= 1 and ply.Hunger >= 1 and ply.Fatigue <= 9999 and ply.Infection <= 9999)) or !ply:Alive() then
			timer.Destroy("DyingFromStats"..ply:UniqueID())
		end

		ply.Fatigue = math.Clamp(ply.Fatigue + (0.045 * (1 - (ply.StatSurvivor * 0.035))), 0, 10000)
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = ItemsList[armorstr]
		if ply:FlashlightIsOn() then
			if ply.Battery <= 0 then
				ply:Flashlight(false)
				ply:AllowFlashlight(false)
				ply.CanUseFlashlight = false
			else
				if armorstr and armortype then
					ply.Battery = math.Clamp(ply.Battery - 0.07, 0, 100 + armortype["ArmorStats"]["battery"])
				else
					ply.Battery = math.Clamp(ply.Battery - 0.07, 0, 100)
				end
			end
		else
			if armorstr and armortype then
				ply.Battery = math.Clamp(ply.Battery + 0.0155, 0, 100 + armortype["ArmorStats"]["battery"])
			else
				ply.Battery = math.Clamp(ply.Battery + 0.0155, 0, 100)
			end
			if ply.Battery >= 15 then
				ply:AllowFlashlight(true)
				ply.CanUseFlashlight = true
			end
		end

		if ply:Health() < ply:GetMaxHealth() and ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity)) then
			ply.HPRegen = math.Clamp(ply.HPRegen + 0.0015 + (ply.StatMedSkill * 0.0001), 0, ply:GetMaxHealth())
		elseif ply.HPRegen > 0 then
			ply.HPRegen = 0
		end

		--random chance of getting infected per tick is extremely rare, but has chance if survived for more than 10 minutes, can decrease chance of this happening by increasing immunity skill level
		local infectionchance = math.random(0, 2000000 + (100000 * ply.StatImmunity) - (CurTime() - ply.SurvivalTime))
		if (infectionchance <= 0 and math.floor(CurTime() - ply.SurvivalTime) >= 600) and ply.Infection <= 0 and ply:Alive() then
			print(ply:Nick().." has caught infection!")
			SendChat(ply, translate.ClientGet(ply, "PlyCaughtInfection"))
		end
		if (ply.Infection > 0 or (infectionchance <= 0 and math.floor(CurTime() - ply.SurvivalTime) >= 600)) and ply:Alive() then
			ply.Infection = math.Clamp(ply.Infection + (0.1176 * (1 - (ply.StatImmunity * 0.04))), 0, 10000)
		end

		if ply:GetMoveType() == MOVETYPE_NOCLIP then if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
		elseif ply:GetMoveType() != MOVETYPE_NOCLIP then
			if (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)) then
				PlayerIsMoving = true
			else
				PlayerIsMoving = false
			end

/*		if ply:KeyPressed(IN_JUMP) then
			ply.Stamina = ply.Stamina - 5
		end
*/ -- Trying to find function that drains stamina on jumping, but this one doesn't really work

			if ply:WaterLevel() == 3 and ply:Alive() then
				ply.Thirst = math.Clamp(ply.Thirst + 0.243 , 0, 10000)
				if tonumber(ply.Stamina) <= 0 then
					if !timer.Exists("DrownTimer"..ply:UniqueID()) then
						timer.Create("DrownTimer"..ply:UniqueID(), 10, 1, function()
							if ply:Alive() then ply:Kill() end
						end)
					end
				else
					ply.Stamina = math.Clamp(ply.Stamina - (0.12 - endurance), 0, 100)
					if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
				end
			elseif (ply:KeyDown(IN_SPEED) and PlayerIsMoving and not ply:KeyDown(IN_DUCK)) then
				ply.Stamina = math.Clamp(ply.Stamina - (0.0655 - endurance), 0, 100)
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			elseif PlayerIsMoving and ply:KeyDown(IN_DUCK) then
				ply.Stamina = math.Clamp(ply.Stamina + 0.00597, 0, 100)
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			elseif PlayerIsMoving then
				ply.Stamina = math.Clamp(ply.Stamina + 0.00291, 0, 100)
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			elseif ply:KeyDown(IN_DUCK) then
				ply.Stamina = math.Clamp(ply.Stamina + 0.024, 0, 100)
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			else
				ply.Stamina = math.Clamp(ply.Stamina + 0.027, 0, 100)
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			end
		
			if ply.Stamina > 30 then
				ply.sprintrecharge = false
			end
		
			if(ply:KeyDown(IN_SPEED) and PlayerIsMoving and ply.Stamina <= 0) then
				ply:ConCommand("-speed")
				ply.sprintrecharge = true
			end
		
			if(ply:KeyDown(IN_SPEED) and PlayerIsMoving and ply.sprintrecharge == true and ply.Stamina <= 30) then
				ply:ConCommand("-speed")
			end
		end

		TEANetUpdateStats(ply)
	end
end

function GM:InitPostEntity()
	RunConsoleCommand("mp_falldamage", "1")
	RunConsoleCommand("M9KDefaultClip", "0") --it's set to 0 so the users don't abuse use and drop commands on m9k weapons over and over again
	RunConsoleCommand("M9KDisablePenetration", "1") --they were op, time to nerf them again (unless you want them to remain the same, remove or exclude this string)
	RunConsoleCommand("sv_defaultdeployspeed", "1") --so that users don't just switch weapons too quickly
--Don't disable this function below, unless you want to have some fun
	for k, v in pairs(ents.FindByClass("npc_*")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("weapon_*")) do
		v:Remove()
	end
	for k, v in pairs(ents.FindByClass("item_*")) do
		v:Remove()
	end

	for k, v in pairs(ents.FindByClass("prop_physics")) do
		v.maxhealth = 2000
		v:SetHealth(2000)
	end
end

function GM:PlayerDisconnected(ply)

	SystemBroadcast(ply:Nick().." has left the server", Color(255,255,155,255), false)

	if ply.Bounty >= 5 then
	local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
	local bountyloss = ply.Bounty - cashloss
	print(ply:Nick() .." has left the server with "..ply.Bounty.." bounty and dropped money worth of "..math.floor(cashloss).." "..Config["Currency"].."s!")

	local EntDrop = ents.Create("ate_cash")
		EntDrop:SetPos(ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles(Angle(0, 0, 0))
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()
	end

	SavePlayer(ply)
	SavePlayerInventory(ply)
	SavePlayerVault(ply)
	for k, v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end


	if ply:Team() == 1 then return false end -- don't bother disbanding or switching faction leader if they are a loner

	local plyfaction = team.GetName(ply:Team())
	if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
		timer.Simple(0.4, function() --this time it should work properly
		SelectRandomLeader(plyfaction)
		end)
	elseif team.NumPlayers(ply:Team()) <= 1 then
		AutoDisbandFaction(plyfaction)
	end


end


function GM:PlayerConnect(name, ip)
	for k, ply in pairs(player.GetAll()) do
		SystemMessage(ply, translate.ClientFormat(ply, "PlayerHasJoined", name), Color(255,255,155,255), false)
	end
end

function GM:OnReloaded()
	timer.Simple(0.4, function()
		for k, v in pairs(player.GetAll()) do
			FullyUpdatePlayer(v)
		end
		print("Gamemode reloaded")
	end)
end


function GM:PlayerInitialSpawn(ply)
	self.BaseClass:PlayerInitialSpawn(ply)
	ply:AllowFlashlight(true)
	ply.CanUseFlashlight = true

	------------------
	ply.SurvivalTime = math.floor(CurTime())
	ply.BestSurvivalTime = 0
	ply.ZKills = 0
	ply.playerskilled = 0
	ply.playerdeaths = 0
	ply.SlowDown = 0
	ply.IsAlive = 1
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Battery = 100
	ply.ChosenModel = "models/player/kleiner.mdl"
	ply.XP = 0 
	ply.Level = 1
	ply.Prestige = 0
	ply.Money = 0
	ply.StatPoints = 0
	ply.PropCount = 0
	ply.CanUseItem = true
	ply.InvitedTo = {} -- stores faction invites
	ply.SelectedProp = "models/props_debris/wood_board04a.mdl"
	ply:SetPvPGuarded(0)
	ply.Territory = "none"
	ply.Bounty = 0
	ply.EquippedArmor = "none"
	ply.StatsPaused = false
	ply.Inventory = {}
	ply.HPRegen = 0
	------------------
	
	LoadPlayer(ply)
	LoadPlayerInventory(ply)
	LoadPlayerVault(ply)
	print("loading datafiles for "..ply:Nick())

	ply:SetNWBool("pvp", false)
	ply:SetNWString("ArmorType", "none")
	ply:SetTeam(1)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
	
	TEANetUpdateStatistics(ply)

	SystemBroadcast(translate.Format("PlayerHasSpawned", ply:Nick()), Color(255,255,155,255), false)
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

	ply.SlowDown = 0
	ply.IsAlive = 1
	RecalcPlayerModel(ply)

	for k, v in pairs(ents.FindByClass("bed")) do
		if v.Owner and v.Owner:IsValid() and v.Owner == ply then
			local bedspawnpoint = FindGoodSpawnPoint(v)
			if bedspawnpoint then ply:SetPos(bedspawnpoint) end
		end
	end

	if timer.Exists("pvpnominge_"..ply:UniqueID()) then timer.Destroy("pvpnominge_"..ply:UniqueID()) end

	local tea_server_spawnprotection = GetConVar("tea_server_spawnprotection")
	local tea_server_spawnprotection_duration = GetConVar("tea_server_spawnprotection_duration")

	if tea_server_spawnprotection_duration:GetFloat() > 0 and tea_server_spawnprotection:GetInt() >= 1 then
		if !ply:Alive() then return end
		ply:GodEnable()
		ply:PrintMessage(HUD_PRINTCENTER, translate.ClientFormat(ply, "PlySpawnProtEnabled", tea_server_spawnprotection_duration:GetFloat()))
	end
	if tea_server_spawnprotection_duration:GetFloat() > 0 and tea_server_spawnprotection:GetInt() > 0 then
		timer.Create("IsSpawnProtectionTimerEnabled"..ply:UniqueID(), tea_server_spawnprotection_duration:GetFloat(), 1, function()
			if !ply:IsValid() or !ply:Alive() then return end
			ply:GodDisable()
			ply:PrintMessage(HUD_PRINTCENTER, translate.ClientGet(ply, "PlySpawnProtExpired"))
			timer.Destroy("IsSpawnProtectionTimerEnabled"..ply:UniqueID())
		end)
	end

	timer.Simple(0.2, function()
		RecalcPlayerSpeed(ply)
		timer.Simple(3, function()
			RecalcPlayerSpeed(ply) --shouldn't have that many timers but whatever
		end)
	end)

	ply:SetNWBool("pvp", false)
	ply:SetPvPGuarded(0)
	ply:SetPlayerColor(Vector(cl_playercolor))
	CalculateStartingHealth(ply)
	CalculateMaxArmor(ply)
	CalculateJumpPower(ply)
	ply:ConCommand("play common/null.wav")
	RecalcPlayerModel(ply)
	PrepareStats(ply)
	FullyUpdatePlayer(ply)

	-- give them a new noob cannon if they are still levels under Rookie Level and are at prestige 0
	local newgun = Config["RookieWeapon"]
	if tonumber(ply.Level) <= tonumber(Config["RookieLevel"]) and tonumber(ply.Prestige) <= 0 and !ply.Inventory[newgun] then
	SystemGiveItem(ply, newgun)
	SendInventory(ply)
	end
end



-- not like setplayermodel, just reads their model and colour settings and sets them to it
function RecalcPlayerModel(ply)
if ply:IsBot() then ply:SetModel("models/player/soldier_stripped.mdl") return end

if !ply.ChosenModel then ply.ChosenModel = "models/player/kleiner.mdl" end
if !ply.ChosenModelColor then ply.ChosenModelColor = Vector(0.25, 0, 0) end

if type(ply.ChosenModelColor) == "string" then ply.ChosenModelColor = Vector(ply.ChosenModelColor) end
ply:SetPlayerColor(ply.ChosenModelColor)

if !ItemsList[ply.EquippedArmor] or ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"] == nil then
	if !table.HasValue(DefaultModels, ply.ChosenModel) then
		ply.ChosenModel = table.Random(DefaultModels)
	end

	ply:SetModel(ply.ChosenModel)
	return false
end


local models = ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"]

if !models[ply.ChosenModel] then ply.ChosenModel = table.Random(models) ply:SetModel(ply.ChosenModel) end

end

function GM:PlayerLoadout(ply)
	ply:Give("ate_fists")
	ply:Give("ate_buildtool")
	if SuperAdminCheck(ply) then -- Superadmins are given physgun on their spawn
		ply:Give("weapon_physgun")
	end
	
	ply:SelectWeapon("ate_fists")
end


function GM:PlayerSpawnedProp(userid, model, prop)
	prop.owner = userid
	prop.model = model
end

function GM:PlayerNoClip(ply, on)
	if AdminCheck(ply) or SuperAdminCheck(ply) or TEADevCheck(ply) then
		PrintMessage(HUD_PRINTCONSOLE, translate.Format(on and "x_turned_on_noclip" or "x_turned_off_noclip", ply:Name()))
		return true
	end

	if ply:GetMoveType(MOVETYPE_NOCLIP) then
		ply:SetMoveType(MOVETYPE_WALK)
	end
	return false
end

function RecalcPlayerSpeed(ply)
local armorspeed = 0
local walkspeed = Config["WalkSpeed"]
local runspeed = Config["RunSpeed"]
local plyarmor = ply:GetNWString("ArmorType")


if !ply:IsValid() then return end
if plyarmor and plyarmor != "none" then
local armortype = ItemsList[plyarmor]
armorspeed = tonumber(armortype["ArmorStats"]["speedloss"])
end

--maybe i'll get to reworking it so when user's walkspeed is around like 133% of slow walk speed they will have slow walk speed set to 75% of their walk speed
if ply.SlowDown == 1 then
	GAMEMODE:SetPlayerSpeed(ply, ((walkspeed - (armorspeed / 2)) + ply.StatSpeed * 3.5) * 0.6, ((runspeed - armorspeed) + ply.StatSpeed * 7) * 0.6)
	ply:SetSlowWalkSpeed(60)
else
	GAMEMODE:SetPlayerSpeed(ply, (walkspeed - (armorspeed / 2)) + ply.StatSpeed * 3.5, (runspeed - armorspeed) + ply.StatSpeed * 7)
	ply:SetSlowWalkSpeed(100)
end
end

-- ULX overrides this and screws up our voice system... maybe it will be fixed or not
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

local function CheckForDerp()
	local chance = 0
	for k, v in pairs(Config["ZombieClasses"]) do
		chance = chance + v.SpawnChance
	end
	if chance > 100 then ErrorNoHalt("Configuration Error! The total zombie spawn chance of this server has exceeded 100% (Currently "..chance.."%)! Some zombie types may not be able to spawn, see theeternalapocalypse/gamemode/sh_config.lua for more info\n")
	elseif chance < 100 then print("Current zombie spawn chance: "..chance.."% (Not perfect)")
	else print("Current zombie spawn chance: "..chance.."% (OK)") end
end
CheckForDerp()

function GM:AddResources()
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.wav", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.wav"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.mp3", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.mp3"..filename)
	end
	for _, filename in pairs(file.Find("sound/theeternalapocalypse/*.ogg", "GAME")) do
		resource.AddFile("sound/theeternalapocalypse/*.ogg"..filename)
	end
	resource.AddWorkshop("128089118") -- m9k assault rifles
	resource.AddWorkshop("128091208") -- m9k heavy weapons
	resource.AddWorkshop("128093075") -- m9k small arms pack
	resource.AddWorkshop("355101935") -- stalker playermodels
	resource.AddWorkshop("411284648") -- gamemode content pack
	resource.AddWorkshop("448170926") -- swep pack
	resource.AddWorkshop("1270991543") -- armor models
	resource.AddWorkshop("1680884607") -- project stalker sounds 
	resource.AddWorkshop("2438451886") -- stalker item models pack
end

print("\n==============================================\n")
print(GM.Name.." ("..GM.AltName..") Gamemode Loaded Successfully\n")
print("Made by "..GM.Author.."\n")
print("Original Creator: LegendofRobbo\n")
print("Version: "..GM.Version.."\n")
print("Github: https://github.com/Uklejamini357/gmodtheeternalapocalypse \n")
print("Be sure to check out github site for new updates\n")
print("==============================================\n")