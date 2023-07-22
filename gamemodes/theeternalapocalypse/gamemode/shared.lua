--DeriveGamemode("sandbox") --no, that will screw up the gamemode.

include("player_class/player_ate.lua")
include("mad/mad_shared.lua")


GM.Name		= "The Eternal Apocalypse"
GM.AltName	= "After The End Reborn"
GM.Author	= "Uklejamini"
GM.Email	= "N/A"
GM.Website	= "https://github.com/Uklejamini357/gmodtheeternalapocalypse"
GM.Version	= "0.11.0 [Beta C]"

team.SetUp(1, "Loner", Color(100, 50, 50, 255)) --loner basic team

--feel free to edit these or add new cvars at any time, FCVAR_NOTIFY - notifies when convar is changed (there's new messaging function now, when convar is changed), FCVAR_REPLICATED - can only be changed by server operator to prevent some issues, FCVAR_ARCHIVE - saves convar values to server.vdf, see gmod wiki for more info
CreateConVar("tea_server_respawntime", 15, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies respawn time for players. Warning: Do not set it too high or players won't be able to respawn. Set to 0 for no respawn delay. Recommended values: 10 - 20.", 0, 60)
CreateConVar("tea_server_moneyreward", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Money gain rewards for killing zombies. This convar is dynamic (affects all zombies) and does not affect XP rewards for destroying faction structures.\
Useful for making events or modifying difficulty.", 0.1, 10)
CreateConVar("tea_server_xpreward", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies XP gain multiplier for killing zombies. This convar is dynamic (affects all zombies) and does not affect Money rewards for destroying faction structures.\
Useful for making events or modifying difficulty.", 0.1, 10)
CreateConVar("tea_server_spawnprotection", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should give players temporary damage invulnerability on spawn? Convar tea_server_spawnprotection_duration must be above 0 for it to work!", 0, 1)
CreateConVar("tea_server_spawnprotection_duration", 5, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How long should god mode after spawning last? (in seconds) Convar tea_server_spawnprotection is required for it to work!", 0, 10)
CreateConVar("tea_server_debugging", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables debugging features. Use value '2' for advanced debug mode. WARNING: YOU CAN ENABLE THIS FOR DEDICATED SERVER AS LONG AS YOU USE IT ONLY FOR TESTING PURPOSES.", 0, 4)
CreateConVar("tea_server_voluntarypvp", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables whether players are free to pvp voluntarily or have forced PvP. If disabled, players will have forced PvP at any time. (Note: Factions don't have friendly fire)", 0, 1)
CreateConVar("tea_server_dbsaving", 1, {FCVAR_REPLICATED}, "Allow saving players' progress to database? It is recommended to keep this enabled, unless when testing something.", 0, 1)
CreateConVar("tea_server_bonusperks", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should bonus XP and bonus Cash perks for special players be enabled?", 0, 1)
CreateConVar("tea_config_maxcaches", 10, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many caches should there be at any given time?", 0, 250)
CreateConVar("tea_config_factioncost", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How much creating the faction should cost?", 0, 10000)
CreateConVar("tea_config_maxprops", 60, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "How many props can players create? Note: It's recommended to keep this on middle-low values, such as 75-125.", 0, 500)
CreateConVar("tea_config_propcostenabled", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enable prop spawning cost money? Recommended to keep this on. Good for making events that needs props.", 0, 1)
CreateConVar("tea_config_factionstructurecostenabled", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enables whether spawning faction structures should cost money or not. Recommended to keep this on. Good for making events that needs faction structures.\
Note: ", 0, 1)
CreateConVar("tea_config_zombieapocalypse", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Should zombies closest to players see them anywhere? WARNING: THIS ONLY WORKS FOR ZOMBIES MADE IN THE GAMEMODE AND MAY CAUSE LAG ON VERY LARGE MAPS!! Good for making event or mini-game like zombie survival or something.", 0, 1) --Be sure to have good navmesh so zombies can navigate through the map!
CreateConVar("tea_config_zombiehpmul", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Zombie Health for future spawned zombies. Best use with this is to increase XP and Cash gain multiplier as the convar value is higher. Useful for events or modifying difficulty.", 0.2, 5)
CreateConVar("tea_config_zombiespeedmul", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Modifies Zombies' speed, whether they should move faster or slower. NOTE: THIS ONLY WORKS WITH ZOMBIES THAT ARE MADE FOR THIS GAMEMDOE AND NOT MADE OUTSIDE OF THE GAMEMODE! Useful for events or modifying difficulty.", 0.4, 3)
CreateConVar("tea_config_propspawndistance", 250, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how close can players spawn props from nearest trader", 0, 500)


if SERVER then
	local function ConVar_Changed(cvar, old, new)
		PrintMessage(HUD_PRINTTALK, Format("ConVar '%s' value is changed from '%s' to '%s'", cvar, old, new))
		print(Format("ConVar '%s' value is changed from '%s' to '%s'", cvar, old, new))
	end

	cvars.AddChangeCallback("tea_server_respawntime", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_respawntime")
	cvars.AddChangeCallback("tea_server_moneyreward", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_moneyreward")
	cvars.AddChangeCallback("tea_server_xpreward", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_xpreward")
	cvars.AddChangeCallback("tea_server_spawnprotection", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_spawnprotection")
	cvars.AddChangeCallback("tea_server_spawnprotection_duration", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_spawnprotection_duration")
	cvars.AddChangeCallback("tea_server_debugging", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_debugging")
	cvars.AddChangeCallback("tea_server_voluntarypvp", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_voluntarypvp")
	cvars.AddChangeCallback("tea_server_dbsaving", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_dbsaving")
	cvars.AddChangeCallback("tea_server_bonusperks", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_server_bonusperks")
	cvars.AddChangeCallback("tea_config_maxcaches", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_maxcaches")
	cvars.AddChangeCallback("tea_config_factioncost", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_factioncost")
	cvars.AddChangeCallback("tea_config_maxprops", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_maxprops")
	cvars.AddChangeCallback("tea_config_propcostenabled", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_propcostenabled")
	cvars.AddChangeCallback("tea_config_factionstructurecostenabled", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_factionstructurecostenabled")
	cvars.AddChangeCallback("tea_config_zombieapocalypse", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombieapocalypse")
	cvars.AddChangeCallback("tea_config_zombiehpmul", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombiehpmul")
	cvars.AddChangeCallback("tea_config_zombiespeedmul", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_zombiespeedmul")
	cvars.AddChangeCallback("tea_config_propspawndistance", ConVar_Changed, "TEA_GAMEMODE.ConVarsChangeCallbacks.tea_config_propspawndistance")
end

function GM:ShutDown()
	if SERVER then
		for k, v in pairs(player.GetAll()) do
			tea_SavePlayer(v)
			tea_SavePlayerInventory(v)
			tea_SavePlayerVault(v)
		end
		print("WARNING! WARNING!! THE OBJECT IS GONE!!")
		tea_DebugLog("Server shutting down/changing map")
		tea_SaveLog()
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
	if !ply:IsPlayer() then return end
	ply:PrintMessage(3, msg);
end

function GetReqXP(ply)
	local basexpreq = 712
	local addxpperlevel = 103
	local noideawhatthisis = 1.1236
	local prestigebonus = 8
	if SERVER then
		return math.floor(basexpreq + (ply.Prestige * prestigebonus) + (ply.Level  * addxpperlevel) ^ noideawhatthisis)
	else
		return math.floor(basexpreq + (MyPrestige * prestigebonus) + (MyLvl  * addxpperlevel) ^ noideawhatthisis)
	end
end

function GetReqMasteryMeleeXP(ply)
	local xpreq = 984
	local addexpperlevel = 165
	local probnothing_idk = 1.161
	if SERVER then
		return math.floor(xpreq + ((ply.MasteryMeleeLevel * addexpperlevel) ^ probnothing_idk))
	else
		return math.floor(xpreq + (MyMMeleelvl * addexpperlevel) ^ probnothing_idk)
	end
end

function GetReqMasteryPvPXP(ply)
	local expreq = 593
	local addxpprlevel = 85
	local whatisthat = 1.153
	if SERVER then
		return math.floor(expreq + (ply.MasteryPvPLevel * addxpprlevel) ^ whatisthat)
	else
		return math.floor(expreq + (MyMPvplvl  * addxpprlevel) ^ whatisthat)
	end
end

function tea_CheckItemRarity(rarity)
	local rarecol
	local raretext

	if rarity == 0 then
		rarecol = Color(155,155,155,255)
		raretext = "Trash"
	elseif rarity == 1 then
		rarecol = Color(205,205,205,255)
		raretext = "Junk"
	elseif rarity == 2 then
		rarecol = Color(230,230,230,255)
		raretext = "Common"
	elseif rarity == 3 then
		rarecol = Color(205,255,205,255)
		raretext = "Uncommon"
	elseif rarity == 4 then
		rarecol = Color(155,155,255,255)
		raretext = "Rare"
	elseif rarity == 5 then
		rarecol = Color(255,205,0,255)
		raretext = "Super Rare"
	elseif rarity == 6 then
		rarecol = Color(255,155,255,255)
		raretext = "Epic"
	elseif rarity == 7 then
		rarecol = Color(255,105,105,255)
		raretext = "Mythic"
	elseif rarity == 8 then
		rarecol = Color(205,55,205,255)
		raretext = "Legendary"
	elseif rarity == 9 then
		rarecol = Color(255,0,155,255)
		raretext = "Godly"
	elseif rarity == 10 then
		rarecol = Color(55,55,255,255)
		raretext = "Event"
	elseif
		rarity == 11 then rarecol = Color(255,255,255,255)
		raretext = "Unobtainable"
	else
		rarecol = Color(96,96,96,255)
		raretext = "Uncategorized"
	end

	return raretext, rarecol
end

local meta = FindMetaTable("Player")

-- 0 = no pvp guard, 1 = pvp guarded, 2 = pvp forced
function meta:SetPvPGuarded(int)
	if !SERVER then return end
	self:SetNWInt("PvPGuard", math.Clamp(int, 0, 2) )
end

function meta:IsPvPGuarded()
	if self:GetNWInt("PvPGuard") == 1 then return true
	else return false end
end

function meta:IsPvPForced()
	if self:GetNWInt("PvPGuard") == 2 then return true
	else return false end
end

function meta:SlowPlayerDown(value, time)
	
	self.SlowDown = math.max(value, self.SlowDown)

	tea_RecalcPlayerSpeed(self)
	timer.Create("tea_SLOWDOWN_"..self:EntIndex(), time, 1, function()
		if !self:IsValid() then return end
		self.SlowDown = 0
		tea_RecalcPlayerSpeed(self)
	end)
end

function GM.ProcessToTime_HHMMSS(value) -- this is still work in progress (bugs: can display as 1:54:5 instead of 1:54:05)
	local hours = math.floor(value / 3600)
	local minutes = math.floor((value / 60) - (hours * 60))
	local seconds = value - ((hours * 3600) + (minutes * 60))

	return hours, minutes, seconds
end

-- the default models aka what poor players look like before they buy armor
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
