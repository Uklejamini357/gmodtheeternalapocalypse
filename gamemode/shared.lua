--DeriveGamemode( "sandbox" )

include( "player_class/player_ate.lua" )

GM.Name 	= "The Eternal Apocalypse"
GM.AltName	= "After The End Reborn"
GM.Author 	= "Uklejamini"
GM.Email 	= "[Insert Email here]"
GM.Website 	= "https://github.com/Uklejamini357/gmodtheeternalapocalypse"
GM.Version	= "0.10.4"

team.SetUp(1, "Loner", Color(100, 50, 50, 255)) --loner basic team

--feel free to edit these or add new cvars at any time, FCVAR_NOTIFY - notifies when convar is changed, FCVAR_REPLICATED - can only be changed by server operator to prevent some issues, FCVAR_ARCHIVE - saves convar values to server.vdf
local tea_server_respawntime = CreateConVar("tea_server_respawntime", 15, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies respawn time for players. Do not set it too high or players won't be able to respawn. Set to 0 for no respawn delay. Recommended values: 10 - 20. (Default: 15)", 0, 60)
local tea_server_moneyreward = CreateConVar("tea_server_moneyreward", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Money gain rewards for killing zombies. This convar is dynamic (affects all zombies) and does not affect XP rewards for destroying faction structures. Useful for making events or modifying difficulty. (Default: 1)", 0.5, 2.5)
local tea_server_xpreward = CreateConVar("tea_server_xpreward", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies XP gain multiplier for killing zombies. This convar is dynamic (affects all zombies) and does not affect Money rewards for destroying faction structures. Useful for making events or modifying difficulty. (Default: 1)", 0.5, 2.5)
local tea_server_spawnprotection = CreateConVar("tea_server_spawnprotection", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enable temporary god mode on spawning? Convar tea_server_spawnprotection_duration must be above 0 for it to work! 1 for true, 0 for false (Default: 1)", 0, 1)
local tea_server_spawnprotection_duration = CreateConVar("tea_server_spawnprotection_duration", 3, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How long should god mode after spawning last? (in seconds) Convar tea_server_spawnprotection is required for it to work! (Default: 1.5)", 0, 5)
local tea_server_debugging = CreateConVar("tea_server_debugging", 0, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables debugging features. YOU CAN ENABLE THIS FOR DEDICATED SERVER AS LONG AS YOU USE IT ONLY FOR TESTING PURPOSES. (Default: 0)", 0, 1)
local tea_server_voluntarypvp = CreateConVar("tea_server_voluntarypvp", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables whether players are free to pvp voluntarily or have forced PvP. (Default: 1)", 0, 1)
local tea_server_dbsaving = CreateConVar("tea_server_dbsaving", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Allow saving players' progress to database? Disabling it temporarily is only good when messing with something and don't want to affect anyone's stats. 1 for true, 0 for false (Default: 1)", 0, 1)
local tea_config_maxcaches = CreateConVar("tea_config_maxcaches", 10, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many caches should there be at any given time? (Default: 10)", 0, 100)
local tea_config_factioncost = CreateConVar("tea_config_factioncost", 1000, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How much creating the faction should cost? (Default: 1000)", 0, 10000)
local tea_config_maxprops = CreateConVar("tea_config_maxprops", 60, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many props can players create? (Default: 60)", 0, 1000)
local tea_config_zombiespawning = CreateConVar("tea_config_zombiespawning", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should zombies spawn at their zombie spawn? Consider disabling it if adding zombie spawns. (Default: 1)", 0, 1)

function GM:ShutDown()
	if SERVER then
		for k, v in pairs(player.GetAll()) do
			SavePlayer(v)
			SavePlayerInventory(v)
			SavePlayerVault(v)
		end
		print("WARNING! WARNING!! THE OBJECT IS GONE!!")
		ate_DebugLog("Server shutting down/changing map")
		SaveLog()
	end
end

function GM:IsSpecialPerson(ply, image)
	local img, tooltip
--i know this was copied from zombiesurvival gamemode but i was too lazy to make one by myself anyway
--you can add new special person table by yourself but you must keep the original ones and the new ones must be after steamid
	if ply:SteamID64() == "76561198274314803" then
		img = "icon16/award_star_gold_3.png"
		tooltip = "The Eternal Apocalypse Dev"
	elseif ply:SteamID64() == "76561198028288732" then
		img = "icon16/medal_gold_3.png"
		tooltip = "LegendofRobbo\nCreator of After The End"
	elseif ply:IsBot() then
		img = "icon16/plugin.png"
		tooltip = "BOT\nidk who he is anyway"
	elseif SuperAdminCheck(ply) then
		img = "icon16/shield_add.png"
		tooltip = "Super Admin"
	elseif AdminCheck(ply) then
		img = "icon16/shield.png"
		tooltip = "Admin"
	end

	if img then
		if CLIENT then
			image:SetImage(img)
			image:SetTooltip(tooltip)
		end
		return true
	end
	return false
end

function GM:PlayerShouldTakeDamage(ply, attacker)
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



function SendChat(ply, msg)
	if (!ply) then return end

	ply:PrintMessage(3, msg);
end


function GetReqXP(ply)
	return math.floor(749 + (ply.Level  * 113) ^ 1.1416)
end

/*
function GetReqXP(ply)
	local level = ply.Level
	return math.floor( 1000 * 1.12^(level - 1) )
end
*/

local playa = FindMetaTable("Player") --this one's best

-- 0 = no pvp guard, 1 = pvp guarded, 2 = pvp forced
function playa:SetPvPGuarded(int)
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
