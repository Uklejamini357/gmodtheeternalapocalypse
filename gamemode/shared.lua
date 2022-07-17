--DeriveGamemode( "sandbox" )

include( "player_class/player_ate.lua" )

GM.Name 	= "After the End"
GM.Author 	= "LegendofRobbo"
GM.Email 	= ""
GM.Website 	= ""

team.SetUp( 1, "Loner", Color( 100, 50, 50, 255 ) ) --loner basic team

function GM:ShutDown()
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
