
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sh_translate.lua" )
AddCSLuaFile( "sh_items.lua" )
AddCSLuaFile( "sh_loot.lua" )
AddCSLuaFile( "sh_spawnables.lua" )
AddCSLuaFile( "sh_config.lua" )
AddCSLuaFile( "client/cl_scoreboard.lua" )
AddCSLuaFile( "client/cl_hud.lua" )
AddCSLuaFile( "client/cl_createfaction.lua" )
AddCSLuaFile( "client/cl_modelsmenu.lua" )
AddCSLuaFile( "client/cl_contextmenu.lua" )
AddCSLuaFile( "client/cl_customdeathnotice.lua" )
AddCSLuaFile( "client/cl_spawnmenu.lua" )
AddCSLuaFile( "client/cl_tradermenu.lua" )
AddCSLuaFile( "client/cl_dermahooks.lua" )
AddCSLuaFile( "client/cl_lootmenu.lua" )
AddCSLuaFile( "client/cl_adminmenu.lua" )
AddCSLuaFile( "client/cl_deathscreen.lua" )
AddCSLuaFile( "client/cl_net.lua" )



include( "shared.lua" )
include( "sh_items.lua" )
include( "sh_loot.lua" )
include( "sh_spawnables.lua" )
include( "sh_config.lua" )
include( "server/netstuff.lua" )
include( "server/server_util.lua" )
include( "server/config.lua" )
include( "server/commands.lua" )
include( "server/admincmd.lua" )
include( "server/player_data.lua" )
include( "server/player_inventory.lua" )
include( "server/player_props.lua" )
include( "server/player_vault.lua" )
include( "server/npcspawns.lua" )
include( "server/traders.lua" )
include( "server/airdrops.lua" )
include( "server/factions.lua" )
include( "server/loot_system.lua" )
include( "server/debug.lua" )
include( "server/weather_events.lua" )
include( "server/specialstuff.lua" )
include( "server/spawnpoints.lua" )
include( "server/nodeathsound.lua" )

resource.AddWorkshop("128089118") -- m9k assault rifles
resource.AddWorkshop("128091208") -- m9k heavy weapons
resource.AddWorkshop("128093075") -- m9k small arms pack
resource.AddWorkshop("355101935") -- stalker playermodels
resource.AddWorkshop("411284648") -- gamemode content pack
resource.AddWorkshop("448170926") -- swep pack
resource.AddWorkshop("1270991543") -- armor models
resource.AddWorkshop("1680884607") -- project stalker sounds 
resource.AddWorkshop("2438451886") -- stalker item models pack


--include("time_weather.lua")


Factions = Factions or {}

DEBUG = false


function GM:ShowHelp( ply )

	ply:SendLua( "hook.Run( 'StartSearch' )" )

end

function GM:ShowTeam( ply )

	if !SuperAdminCheck(ply) then return false end
	ply:SendLua( "AdminMenu()" )
	ply:ConCommand( "playgamesound buttons/button24.wav" )

end

function GM:ShowSpare1( ply )

	ply:SendLua( "DropGoldMenu()" )

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

function GM:OnPlayerHitGround( ply, inWater, onFloater, speed )

    if speed > (400 + (2 * ply.StatAgility)) then
        ply:ViewPunch(Angle(5, 0, 0))
        ply.Stamina = math.Clamp( ply.Stamina - (15 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045)) ), 0, 100 )
    elseif speed > (140 + (2 * ply.StatAgility)) then
		ply:ViewPunch(Angle(math.random(1, 1.2), 0, math.random(-0.2, 0.2)))
		ply.Stamina = math.Clamp( ply.Stamina - (7.5 * (1 - (ply.StatAgility * 0.01) - (ply.StatEndurance * 0.045)) ), 0, 100 )
    end
end

--You will no longer be able to regenerate your health when having either 40%< Hunger, 35%< Thirst, >65% Fatigue or >40% Infection (dependent on "Immunity" and "Survivor" skills' values)
function HealthRegen()
	for k, ply in pairs( player.GetAll() ) do
		if ply:Alive() and ply.Thirst >= (3000 - (125 * ply.StatSurvivor)) and ply.Hunger >= (3000 - (150 * ply.StatSurvivor)) and ply.Fatigue <= (7000 + (150 * ply.StatSurvivor)) and ply.Infection <= (5000 - (100 * ply.StatImmunity)) then
			ply:SetHealth( math.Clamp( ply:Health() + 1 + (ply.StatMedSkill * 0.1), 5, ply:GetMaxHealth() ) )
		end
	end
end
timer.Create( "HealthRegen", 10, 0, HealthRegen )


function GM:Think()

	for k, ply in pairs( player.GetAll() ) do
	if !ply:IsValid() then continue end

	local endurance = ((ply.StatEndurance - (0.15 * ply.StatSpeed)) / 500)
	-- hunger, thirst, fatigue, infection
	ply.Hunger = math.Clamp( ply.Hunger - (0.065 * (1 - (ply.StatSurvivor * 0.04)) ), 0, 10000 )
	ply.Thirst = math.Clamp( ply.Thirst - (0.0782 * (1 - (ply.StatSurvivor * 0.0425)) ), 0, 10000 )

	if !timer.Exists("DyingFromStats"..ply:UniqueID()) and (ply.Thirst <= 0 or ply.Hunger <= 0 or ply.Fatigue >= 10000 or ply.Infection >= 10000) and ply:Alive() then
		timer.Create("DyingFromStats"..ply:UniqueID(), 15, 1, function()
			if ply:Alive() then ply:Kill() end
		end)
	elseif (timer.Exists("DyingFromStats"..ply:UniqueID()) and (ply.Thirst >= 1 and ply.Hunger >= 1 and ply.Fatigue <= 9999 and ply.Infection <= 9999)) or !ply:Alive() then
		timer.Destroy("DyingFromStats"..ply:UniqueID())
	end

	ply.Fatigue = math.Clamp( ply.Fatigue + (0.045 * (1 - (ply.StatSurvivor * 0.035)) ), 0, 10000 )

	--random chance of getting infected per tick is extremely rare, but has chance if survived for more than 20 minutes, can decrease chance by increasing immunity skill level
	local infectionchance = math.random(0, 2000000 + (100000 * ply.StatImmunity) - (CurTime() - ply.SurvivalTime))
	if (infectionchance <= 0 and math.floor(CurTime() - ply.SurvivalTime) >= 600) and ply.Infection <= 0 and ply:Alive() then
	print(ply:Nick().." has caught infection randomly!")
	SendChat(ply, "You have caught infection randomly!")
	end
	if (ply.Infection > 0 or (infectionchance <= 0 and math.floor(CurTime() - ply.SurvivalTime) >= 600)) and ply:Alive() then
	ply.Infection = math.Clamp( ply.Infection + (0.1176 * (1 - (ply.StatImmunity * 0.04)) ), 0, 10000 )
	end

	if ply:GetMoveType() == MOVETYPE_NOCLIP then if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
	elseif ply:GetMoveType() != MOVETYPE_NOCLIP then
		if ( ply:KeyDown( IN_FORWARD ) or ply:KeyDown( IN_BACK ) or ply:KeyDown( IN_MOVELEFT ) or ply:KeyDown( IN_MOVERIGHT ) ) then
			PlayerIsMoving = true
		else
			PlayerIsMoving = false
		end

/*		if ply:KeyPressed( IN_JUMP ) then
			ply.Stamina = ply.Stamina - 5
		end
*/ -- Trying to find function that drains stamina on jumping, but this one doesn't really work

		if ply:WaterLevel() == 3 and ply:Alive() then
			ply.Thirst = math.Clamp( ply.Thirst + 0.243 , 0, 10000)
			if tonumber(ply.Stamina) <= 0 then
				if !timer.Exists("DrownTimer"..ply:UniqueID()) then
					timer.Create("DrownTimer"..ply:UniqueID(), 7, 1, function()
						if ply:Alive() then ply:Kill() end
					end)
				end

			else
				ply.Stamina = math.Clamp( ply.Stamina - (0.12 - endurance), 0, 100 )
				if timer.Exists("DrownTimer"..ply:UniqueID()) then timer.Destroy("DrownTimer"..ply:UniqueID()) end
			end
		elseif ( ply:KeyDown( IN_SPEED ) and PlayerIsMoving and not ply:KeyDown(IN_DUCK) ) then
			ply.Stamina = math.Clamp( ply.Stamina - (0.0655 - endurance), 0, 100 )
		elseif PlayerIsMoving and ply:KeyDown( IN_DUCK ) then
			ply.Stamina = math.Clamp( ply.Stamina + 0.0057, 0, 100 )
		elseif PlayerIsMoving then
			ply.Stamina = math.Clamp( ply.Stamina + 0.00251, 0, 100 )
		elseif ply:KeyDown( IN_DUCK ) then
			ply.Stamina = math.Clamp( ply.Stamina + 0.02, 0, 100 )
		else
			ply.Stamina = math.Clamp( ply.Stamina + 0.023, 0, 100 )
		end
		
		if ply.Stamina > 30 then
			ply.sprintrecharge = false
		end
		
		if( ply:KeyDown( IN_SPEED ) and PlayerIsMoving and ply.Stamina <= 0) then
			ply:ConCommand( "-speed" )
			ply.sprintrecharge = true
		end
		
		if( ply:KeyDown( IN_SPEED ) and PlayerIsMoving and ply.sprintrecharge == true and ply.Stamina <= 30) then
			ply:ConCommand( "-speed" )
		end
	end

		net.Start("UpdateStats")
		net.WriteFloat( math.Round(ply.Stamina) )
		net.WriteFloat( math.Round(ply.Hunger) )
		net.WriteFloat( math.Round(ply.Thirst) )
		net.WriteFloat( math.Round(ply.Fatigue) )
		net.WriteFloat( math.Round(ply.Infection) )
		net.WriteFloat( math.Round(ply.SurvivalTime) )
		net.Send( ply )

	end
end

function GM:InitPostEntity( )
	RunConsoleCommand( "mp_falldamage", "1" )
	RunConsoleCommand( "sbox_godmode", "0" )
	RunConsoleCommand( "sbox_plpldamage", "0" )
	RunConsoleCommand( "M9KDefaultClip", "0" ) --it's set to 0 so the users don't abuse use and drop commands on m9k weapons over and over again
/*--Don't disable this function unless you want to have some fun
	for k, v in pairs( ents.FindByClass( "npc_*" ) ) do
		v:Remove()
	end
	for k, v in pairs( ents.FindByClass( "weapon_*" ) ) do
		v:Remove()
	end
	for k, v in pairs( ents.FindByClass( "item_*" ) ) do
		v:Remove()
	end
	for k, v in pairs( ents.FindByClass( "prop_physics" ) ) do
		v.maxhealth = 2000
		v:SetHealth( 2000 )
	end
*/
end

function GM:PlayerDisconnected( ply )

	SystemBroadcast(ply:Nick().." has left the server", Color(255,255,155,255), false)

	if ply.Bounty >= 5 then
	local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
	local bountyloss = ply.Bounty - cashloss
	print( "".. ply:Nick() .." has left the server with "..ply.Bounty.." bounty and dropped money worth of "..math.floor(cashloss).." "..Config[ "Currency" ].."s!" )

	local EntDrop = ents.Create( "ate_cash" )
		EntDrop:SetPos( ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles( Angle( 0, 0, 0 ) )
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()
	end

	SavePlayer( ply )
	SavePlayerInventory( ply )
	SavePlayerVault( ply )
	for k, v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end
	/*
	for k, v in pairs(ents.FindByClass("prop_flimsy")) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end

	for k, v in pairs(ents.FindByClass("prop_strong")) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end
	*/

	if ply:Team() == 1 then return false end -- don't bother disbanding or switching faction leader if they are a loner

	local plyfaction = team.GetName(ply:Team())
	if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
		SelectRandomLeader(plyfaction)
	elseif team.NumPlayers(ply:Team()) <= 1 then
		AutoDisbandFaction( plyfaction )
	end


end


function GM:PlayerConnect( name, ip )
--	SendAll( name .. " has joined the server." )
SystemBroadcast(name.." has joined the server", Color(255,255,155,255), false)
end

function GM:OnReloaded()
timer.Simple(1, function()
for k, v in pairs(player.GetAll()) do
	FullyUpdatePlayer( v )
end
end)

end


function GM:PlayerInitialSpawn( ply )

	self.BaseClass:PlayerInitialSpawn( ply )

	ply:AllowFlashlight( true )

	------------------

	ply.SurvivalTime = math.floor(CurTime())
	ply.Stamina = 100
	ply.Hunger = 10000
	ply.Thirst = 10000
	ply.Fatigue = 0
	ply.Infection = 0
	ply.Battery = 0
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
	ply:SetPvPGuarded( 0 )
	ply.Territory = "none"
	ply.Bounty = 0
	ply.EquippedArmor = "none"
	ply.Inventory = {}
	------------------
	
	LoadPlayer( ply )
	LoadPlayerInventory( ply )
	LoadPlayerVault( ply )
	print("loading datafiles for "..ply:Nick())
	
--	ply.PvP = false
	ply:SetNWBool("pvp", false)
	ply:SetNWString("ArmorType", "none")
	ply:SetTeam( 1 )

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Send(ply)
	
	SystemBroadcast(ply:Nick().." has spawned into the game", Color(255,255,155,255), false)
	ForceEquipArmor(ply, ply.EquippedArmor)

end

local function IsPosBlocked( pos )
local tr = {
	start = pos,
	endpos = pos,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 71 ),
	mask = MASK_SOLID,
}
local trc = util.TraceHull( tr )
if ( trc.Hit ) then
	return true
end
return false
end

local function FindGoodSpawnPoint( e )
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
		if !IsPosBlocked( v ) then goodspawn = v break end
	end
	return goodspawn
end

function GM:PlayerSpawn( ply )
	self.BaseClass:PlayerSpawn( ply )
	player_manager.SetPlayerClass( ply, "player_ate" )

	RecalcPlayerModel( ply )

	for k, v in pairs(ents.FindByClass( "bed") ) do
		if v.Owner and v.Owner:IsValid() and v.Owner == ply then
			local piss = FindGoodSpawnPoint( v )
			if piss then ply:SetPos( piss ) end
		end
	end

	if timer.Exists("pvpnominge_"..ply:UniqueID()) then timer.Destroy("pvpnominge_"..ply:UniqueID()) end

	local tea_server_spawnprotection = GetConVar( "tea_server_spawnprotection" )
	local tea_server_spawnprotection_duration = GetConVar( "tea_server_spawnprotection_duration" )

	if tea_server_spawnprotection_duration:GetInt() > 0 and tea_server_spawnprotection:GetInt() >= 1 then
		if !ply:Alive() then return end
		ply:GodEnable()
		ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection enabled for "..tea_server_spawnprotection_duration:GetString().." second(s)")
	end
	if tea_server_spawnprotection_duration:GetInt() > 0 and tea_server_spawnprotection:GetInt() > 0 then
		timer.Create("IsSpawnProtectionTimerEnabled"..ply:UniqueID(), tea_server_spawnprotection_duration:GetString(), 1, function()
		if !ply:Alive() then return end
		ply:GodDisable()
		ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection expired")
		timer.Destroy("IsSpawnProtectionTimerEnabled"..ply:UniqueID())
		end)
	end

	timer.Simple(0.2, function()
	RecalcPlayerSpeed(ply)
	end)

	timer.Simple(3, function()
	RecalcPlayerSpeed(ply)
	end)

	ply:SetNWBool("pvp", false)
	ply:SetPvPGuarded( 0 )
	ply:SetPlayerColor( Vector(cl_playercolor) )
	CalculateStartingHealth( ply )
	CalculateMaxArmor(ply)
	CalculateJumpPower(ply)
	ply:ConCommand( "play common/null.wav" )
	RecalcPlayerModel( ply )
	PrepareStats(ply)
	FullyUpdatePlayer(ply)

	-- give them a new noob cannon if they are still levels under Rookie Level and are at prestige 0
	local newgun = Config[ "RookieWeapon" ]
	if tonumber(ply.Level) <= tonumber(Config[ "RookieLevel" ]) and tonumber(ply.Prestige) <= 0 and !ply.Inventory[newgun] then
	SystemGiveItem( ply, newgun )
	SendInventory(ply)
	end
end



-- not like setplayermodel, just reads their model and colour settings and sets them to it
function RecalcPlayerModel( ply )
if ply:IsBot() then ply:SetModel( "models/player/kleiner.mdl" ) return end

if !ply.ChosenModel then ply.ChosenModel = "models/player/kleiner.mdl" end
if !ply.ChosenModelColor then ply.ChosenModelColor = Vector( 0.25, 0, 0) end

if type(ply.ChosenModelColor) == "string" then ply.ChosenModelColor = Vector(ply.ChosenModelColor) end
ply:SetPlayerColor(ply.ChosenModelColor)

if !ItemsList[ply.EquippedArmor] or ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"] == nil then
	if !table.HasValue(DefaultModels, ply.ChosenModel) then
		ply.ChosenModel = table.Random(DefaultModels)
	end

	ply:SetModel( ply.ChosenModel )
	return false
end


local models = ItemsList[ply.EquippedArmor]["ArmorStats"]["allowmodels"]

if !models[ply.ChosenModel] then ply.ChosenModel = table.Random(models) ply:SetModel( ply.ChosenModel ) end

end

function GM:PlayerLoadout( ply )
	ply:Give( "ate_fists" )
	ply:Give( "ate_buildtool" )
	if SuperAdminCheck(ply) then -- Superadmins are given physgun on their spawn
		ply:Give("weapon_physgun")
	end
	
	ply:SelectWeapon( "ate_fists" )
end

-- not really used but left in for debug functions eg. testzombies
function GM:PlayerSpawnedProp( userid, model, prop )
	prop.owner = userid
	prop.model = model
end

function GM:PlayerNoClip( ply )
	if ply:IsAdmin() or ply:IsSuperAdmin() or ply:SteamID64() == "76561198274314803" or ply:SteamID64() == "76561198028288732" then
		return true
	end

	if ply:GetMoveType(MOVETYPE_NOCLIP) then
		ply:SetMoveType(MOVETYPE_WALK)
	end
	return false
end

function RecalcPlayerSpeed(ply)
local armorspeed = 0
local plyarmor = ply:GetNWString("ArmorType")
local tea_server_walkspeed = GetConVar("tea_server_walkspeed")
local tea_server_runspeed = GetConVar("tea_server_runspeed")

if !ply:IsValid() then return end
if plyarmor and plyarmor != "none" then
local armortype = ItemsList[plyarmor]
armorspeed = tonumber(armortype["ArmorStats"]["speedloss"])
end

GAMEMODE:SetPlayerSpeed( ply, (tea_server_walkspeed:GetInt() - (armorspeed / 2)) + ply.StatSpeed * 3.5, (tea_server_runspeed:GetInt() - armorspeed) + ply.StatSpeed * 7 )

end

-- ULX overrides this and screws up our voice system... maybe it will be fixed or not
function GM:PlayerCanHearPlayersVoice( listener, talker )
if listener:GetPos():Distance(talker:GetPos()) <= 1500 then
return true, false
else
return false, false
end

end


function GM:PlayerShouldTaunt( ply, actid )
	return true

end

local function CheckForDerp()
local chance = 0
	for k, v in pairs( Config[ "ZombieClasses" ] ) do
		chance = chance + v.SpawnChance
	end
	if chance > 100 then ErrorNoHalt("Configuration Error! the total zombie spawn chance of this server has exceeded 100% ( Currently "..chance.."% )! some zombie types may not be able to spawn, see theeverlastingapocalypse/gamemode/sh_config.lua for more info\n") end
end
CheckForDerp()


print( "\n==============================================\n" )
print( GM.Name.." ("..GM.AltName..") Gamemode Loaded Successfully\n" )
print( "Made by "..GM.Author.."\n" )
print( "Original Creator: LegendofRobbo\n" )
print( "Version: "..GM.Version.."\n")
print( "Github: https://github.com/Uklejamini357/gmodtheeternalapocalypse\n" )
print( "Be sure to check out github site for new updates\n" )
print( "==============================================\n" )