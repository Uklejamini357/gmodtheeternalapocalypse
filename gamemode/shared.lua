--DeriveGamemode( "sandbox" )

include( "player_class/player_ate.lua" )

GM.Name 	= "The Eternal Apocalypse"
GM.Author 	= "Uklejamini"
GM.Email 	= "no"
GM.Website 	= "https://github.com/Uklejamini357/gmodtheeternalapocalypse"

team.SetUp( 1, "Loner", Color( 100, 50, 50, 255 ) ) --loner basic team

local tea_server_respawntime = CreateConVar( "tea_server_respawntime", 15, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "Modifies respawn time for players. Do not set it too high or players won't be able to respawn. Set to 0 for no respawn delay. Recommended values: 10 - 20. Default: 15" )
local tea_server_moneyreward = CreateConVar( "tea_server_moneyreward", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "Modifies Money gain rewards for killing zombies. This convar is dynamic (affects all zombies) and does not affect XP rewards for destroying faction structures. Useful for making events. Default: 1" )
local tea_server_xpreward = CreateConVar( "tea_server_xpreward", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "Modifies XP gain multiplier for killing zombies. This convar is dynamic (affects all zombies) and does not affect Money rewards for destroying faction structures. Useful for making events. Default: 1" )
local tea_server_spawnprotection = CreateConVar( "tea_server_spawnprotection", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable god mode on spawning? 1 for true, 0 for false Default: 1" )
local tea_server_spawnprotection_duration = CreateConVar( "tea_server_spawnprotection_duration", 1.5, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "How long should god mode after spawning last? (in seconds). Default: 1.5" )
local tea_server_debugging = CreateConVar( "tea_server_debugging", 0, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables debugging features. Default: 0" )
local tea_server_walkspeed = CreateConVar( "tea_server_walkspeed", 120, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 120" )
local tea_server_runspeed = CreateConVar( "tea_server_runspeed", 250, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 250" )
local tea_server_startmoney = CreateConVar( "tea_server_startmoney", 500, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 500" )
local tea_server_maxzombies = CreateConVar( "tea_server_maxzombies", 35, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 35" )
local tea_server_zombiespawnrate = CreateConVar( "tea_server_zombiespawnrate", 14, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 14" )
local tea_server_bossspawnrate = CreateConVar( "tea_server_bossspawnrate", 3000, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 3000" )
local tea_server_airdropspawnrate = CreateConVar( "tea_server_airdropspawnrate", 3750, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 3750" )
local tea_server_maxcaches = CreateConVar( "tea_server_maxcaches", 10, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 10" )
local tea_server_vaultsize = CreateConVar( "tea_server_vaultsize", 200, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 200" )
local tea_server_factioncost = CreateConVar( "tea_server_factioncost", 1000, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 1000" )
local tea_server_voluntarypvp = CreateConVar( "tea_server_voluntarypvp", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 1" )
local tea_server_maxprops = CreateConVar( "tea_server_maxprops", 60, {FCVAR_NOTIFY, FCVAR_REPLICATED}, "This does nothing for now, but it will in future update. Default: 60" )

function GM:ShutDown()
print("WARNING! WARNING! THE OBJECT IS GONE!!")
end


function GM:PlayerShouldTakeDamage( ply, attacker )
	if attacker:IsPlayer() then

	for _, ent in pairs (ents.FindByClass("trader")) do
		if attacker:IsPlayer() and (ent:GetPos():Distance(ply:GetPos()) < 120 or ent:GetPos():Distance(attacker:GetPos()) < 120) then
			return false
		end
	end

		if ply:Team() == attacker:Team() and attacker != ply and ply:Team() != 1 then
			return false
		else
			return true
		end
	end
return true
end



function SendChat( ply, msg )
	if( !ply ) then return end
	
	ply:PrintMessage( 3, msg );
end


function GetReqXP( ply )
	return math.floor( 576 + (ply.Level  * 133) ^ 1.036 )
end

/*
function GetReqXP( ply )
	local level = ply.Level
	return math.floor( 1000 * 1.12^(level - 1) )
end
*/

local playa = FindMetaTable( "Player" )

-- 0 = no pvp guard, 1 = pvp guarded, 2 = pvp forced
function playa:SetPvPGuarded( int )
if !SERVER then return end
self:SetNWInt("PvPGuard", math.Clamp(int, 0, 2) )
end

function playa:IsPvPGuarded()
if self:GetNWInt("PvPGuard") == 1 then return true else return false end
end

function playa:IsPvPForced()
if self:GetNWInt("PvPGuard") == 2 then return true else return false end
end


-- the default models aka what poorfags look like before they buy armor
DefaultModels = 
{
	"models/player/kleiner.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_06.mdl",
	"models/player/breen.mdl",
	"models/player/Eli.mdl",
	"models/player/mossman.mdl"
}
