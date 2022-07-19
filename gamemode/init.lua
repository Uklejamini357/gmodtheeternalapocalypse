
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
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
include( "lua/includes/modules/player_manager.lua" )
include( "lua/autorun/nodeathsound.lua" )

resource.AddWorkshop("411284648") -- content pack
resource.AddWorkshop("247962324") -- armor models
resource.AddWorkshop("448170926") -- swep pack

--include("time_weather.lua")

local tea_server_respawntime = CreateConVar( "tea_server_respawntime", 15, {FCVAR_NOTIFY}, "Modifies respawn time for players. Do not set it too high or players won't be able to respawn. Recommended values: 10 - 20" )
local tea_server_moneyreward = CreateConVar( "tea_server_moneyreward", 1, {FCVAR_NOTIFY}, "Modifies Money gain rewards for killing zombies. This convar is dynamic (affects all zombies) and does not affect XP rewards for destroying faction structures. Useful for making events." )
local tea_server_xpreward = CreateConVar( "tea_server_xpreward", 1, {FCVAR_NOTIFY}, "Modifies XP gain multiplier for killing zombies. This convar is dynamic (affects all zombies) and does not affect Money rewards for destroying faction structures. Useful for making events." )
local tea_server_spawnprotection = CreateConVar( "tea_server_spawnprotection", 1, {FCVAR_NOTIFY}, "Enable god mode on spawning? 1 for true, 0 for false" )
local tea_server_spawnprotection_duration = CreateConVar( "tea_server_spawnprotection_duration", 1, {FCVAR_NOTIFY}, "How long should god mode after spawning last? (in seconds)" )

Factions = Factions or {}

DEBUG = false

function GM:ShowHelp( ply )

	ply:SendLua( "hook.Run( 'StartSearch' )" )

end

function GM:OnPlayerHitGround( ply, inWater, onFloater, speed )

    if speed > 500 then
        ply:ViewPunch(Angle(5, 0, 0))
        ply.Stamina = math.Clamp( ply.Stamina - (20 * (1 - (ply.StatEndurance * 0.04)) ), 0, 100 )
    elseif speed > 150 then
		ply:ViewPunch(Angle(math.random(1, 1.2), 0, math.random(-0.2, 0.2)))
		ply.Stamina = math.Clamp( ply.Stamina - (10 * (1 - (ply.StatEndurance * 0.04)) ), 0, 100 )
    end
end

function HealthRegen()
	for k, ply in pairs( player.GetAll() ) do
		if ply:Alive() then
			ply:SetHealth( math.Clamp( ply:Health() + 1 + (ply.StatMedSkill * 0.1), 5, ply:GetMaxHealth() ) )
		end
	end
end
timer.Create( "HealthRegen", 10, 0, HealthRegen )


function GM:Think()

	for k, ply in pairs( player.GetAll() ) do
	if !ply:IsValid() then continue end

	local endurance = (ply.StatEndurance / 500)
	-- hunger, fatigue, infection
	ply.Hunger = math.Clamp( ply.Hunger - (0.065 * (1 - (ply.StatSurvivor * 0.04)) ), 0, 10000 )

	if ply.Hunger <= 0 or ply.Fatigue >= 10000 or ply.Infection >= 10000 then
	local d = DamageInfo()
	d:SetDamage( 0.1 )
	d:SetDamageType( DMG_POISON ) -- tried other damage types that don't affect armor but screw it

	ply:TakeDamageInfo( d )
	end

	ply.Fatigue = math.Clamp( ply.Fatigue + (0.045 * (1 - (ply.StatSurvivor * 0.035)) ), 0, 10000 )

	if ply.Infection > 1 then
	ply.Infection = math.Clamp( ply.Infection + (0.12 * (1 - (ply.StatImmunity * 0.05)) ), 0, 10000 )
	end

	if ply:GetMoveType() != MOVETYPE_NOCLIP then
		if( ply:KeyDown( IN_FORWARD ) or ply:KeyDown( IN_BACK ) or ply:KeyDown( IN_MOVELEFT ) or ply:KeyDown( IN_MOVERIGHT ) ) then
			PlayerIsMoving = true
		else
			PlayerIsMoving = false
		end

		if ply:WaterLevel() == 3 then
			if ply.Stamina <= 0 then
				local drown = DamageInfo()
				drown:SetDamage( 0.25 )
				drown:SetDamageType( DMG_POISON ) -- same goes here
				ply:TakeDamageInfo( drown )
				else
				ply.Stamina = math.Clamp( ply.Stamina - (0.12 - endurance), 0, 100 )
			end
		elseif ( ply:KeyDown( IN_SPEED ) and PlayerIsMoving and not ply:KeyDown(IN_DUCK) ) then
			ply.Stamina = math.Clamp( ply.Stamina - (0.08 - endurance), 0, 100 )
		elseif PlayerIsMoving then
			ply.Stamina = math.Clamp( ply.Stamina + 0.0024, 0, 100 )
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
		net.WriteFloat( math.Round(ply.Fatigue) )
		net.WriteFloat( math.Round(ply.Infection) )
		net.Send( ply )

	end
end

function GM:InitPostEntity( )
	RunConsoleCommand( "mp_falldamage", "1" )
	RunConsoleCommand( "sbox_godmode", "0" )
	RunConsoleCommand( "sbox_plpldamage", "0" )
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
end

function GM:PlayerDisconnected( ply )

	SystemBroadcast(ply:Nick().." has left the server", Color(255,255,155,255), false)

	if ply.Bounty >= 5 then
	local cashloss = ply.Bounty * 0.35

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
	--need to define all this shit on initialspawn or lua goes boom, this all gets overwritten by the loadplayer function anyway

	ply.Stamina = 100
	ply.Hunger = 10000
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
	UseFunc_EquipArmor(ply, ply.EquippedArmor)

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
	if tea_server_spawnprotection:GetInt() >= 1 then
	ply:GodEnable()
	ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection for "..tea_server_spawnprotection_duration:GetInt().." second(s)")
	end

	if tea_server_spawnprotection:GetInt() >= 1 then
	timer.Simple(tea_server_spawnprotection_duration:GetInt(), function()
	ply:GodDisable()
	ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection expired")
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
	ply:SetHealth( 100 + ( ply.StatHealth * 5 ) )
	ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
	ply:SetMaxArmor( 100 + (ply.StatEngineer * 2 ) )
	ply:ConCommand( "play common/null.wav" )
	RecalcPlayerModel( ply )
	PrepareStats( ply )

	-- give them a new noob cannon if they are still a noob
	local noobgun = Config[ "NoobWeapon" ]
	if tonumber(ply.Level) <= tonumber(Config[ "NoobLevel" ]) and !ply.Inventory[noobgun] then
	SystemGiveItem( ply, noobgun )
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

if !ply:IsValid() then return end
if plyarmor and plyarmor != "none" then
local armortype = ItemsList[plyarmor]
armorspeed = tonumber(armortype["ArmorStats"]["speedloss"])
end

GAMEMODE:SetPlayerSpeed( ply, (Config[ "WalkSpeed" ] - (armorspeed / 2)) + ply.StatSpeed * 3.5, (Config[ "RunSpeed" ] - armorspeed) + ply.StatSpeed * 7 )

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

function GM:ShowSpare1( ply )

	ply:SendLua( "DropGoldMenu()" )

end




print( "==============================================\n" )
print( "The Eternal Apocalypse (After The End Reborn) Gamemode Loaded Successfully\n" )
print( "Original Creator: LegendofRobbo\n" )
print( "Edited by ???\n" )
print( "Github: https://github.com/Uklejamini357/gmodtheeternalapocalypse\n" )
print( "Be sure to check out github site for new updates\n" )
print( "==============================================\n" )