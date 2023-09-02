--DeriveGamemode("sandbox") --no, that will screw up the gamemode.

GM.Name		= "The Eternal Apocalypse"
GM.AltName	= "After The End Reborn"
GM.Author	= "Uklejamini"
GM.Email	= "[You may not view this information.]"
GM.Website	= "https://github.com/Uklejamini357/gmodtheeternalapocalypse"
GM.Version	= "0.11.1a"
GM.DateVer	= "02.09.2023"


include("sh_globals.lua") -- globals
include("sh_translate.lua") -- translation file
include("sh_convars.lua")

include("sh_player.lua") -- function for player
include("sh_items.lua") -- items for inventory
include("sh_loot.lua") -- for loots
include("sh_spawnables.lua") -- spawnable props with build tool
include("sh_config.lua") -- gamemode config
include("sh_crafting.lua") -- list for craftable items
include("sh_achievements.lua") -- achievements
include("sh_deathsounds.lua") -- death sounds used for various player models
include("sh_taskslist.lua")

include("minigames/shared.lua")

include("player_class/player_ate.lua")
include("mad/mad_shared.lua") -- ????

function GM:CreateTeams()
	team.SetUp(TEAM_LONER, "Loner", Color(100, 50, 50, 255))
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
		tooltip = "Bot\n\nJust a bot"
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

		if ply.SpawnProtected then
			return false
		end

		if ply:Team() == attacker:Team() and attacker != ply and ply:Team() != 1 then
			return false
		else
			return true
		end
	end
	return true
end

function GM:GetReqXP(ply)
	local basexpreq = 712
	local addxpperlevel = 103
	local addxpperlevel2 = 1.1236

	local plyprestige = SERVER and ply.Prestige or MyPrestige
	local plylevel = SERVER and ply.Level or MyLvl

	return math.floor((basexpreq + (plylevel  * addxpperlevel) * (1 + (plyprestige * (0.0072 + math.min(20, plyprestige) * 0.0003)))) ^ addxpperlevel2)
end

function GetReqMasteryMeleeXP(ply)
	local xpreq = 984
	local addexpperlevel = 165
	local addexpperlevel2 = 1.161

	local mlvl = SERVER and ply.MasteryMeleeLevel or MyMMeleelvl

	return math.floor(xpreq + (mlvl * addexpperlevel) ^ addexpperlevel2)
end

function GetReqMasteryPvPXP(ply)
	local expreq = 593
	local addxpprlevel = 85
	local addexpperlevel2 = 1.153

	local mlvl = SERVER and ply.MasteryPvPLevel or MyMPvplvl

	return math.floor(expreq + (mlvl * addxpprlevel) ^ addexpperlevel2)
end

function GetPerk(perk)
	return GAMEMODE.StatConfigs[perk]
end

function GM:CheckItemRarity(rarity)
	local tbl = {}

	if rarity == 0 then
		tbl.col = Color(155,155,155,255)
		tbl.text = "Trash"
	elseif rarity == 1 then
		tbl.col = Color(205,205,205,255)
		tbl.text = "Junk"
	elseif rarity == 2 then
		tbl.col = Color(230,230,230,255)
		tbl.text = "Common"
	elseif rarity == 3 then
		tbl.col = Color(205,255,205,255)
		tbl.text = "Uncommon"
	elseif rarity == 4 then
		tbl.col = Color(155,155,255,255)
		tbl.text = "Rare"
	elseif rarity == 5 then
		tbl.col = Color(255,205,0,255)
		tbl.text = "Super Rare"
	elseif rarity == 6 then
		tbl.col = Color(255,155,255,255)
		tbl.text = "Epic"
	elseif rarity == 7 then
		tbl.col = Color(255,105,105,255)
		tbl.text = "Mythic"
	elseif rarity == 8 then
		tbl.col = Color(255,105,255,255)
		tbl.text = "Legendary"
	elseif rarity == 9 then
		tbl.col = Color(math.abs(math.sin(SysTime()))*255,0,155,255)
		tbl.text = "Godly"
		tbl.keeprefresh = true
	elseif rarity == 10 then
		tbl.col = Color(55,55,155+math.abs(math.sin(SysTime()))*100,255)
		tbl.text = "Event"
		tbl.keeprefresh = true
	elseif rarity == 11 then
		tbl.col = Color(255,255,255,255)
		tbl.text = "Unobtainable"
	else
		tbl.col = Color(96,96,96,255)
		tbl.text = "Uncategorized"
	end

	return tbl
end

function GM:StartCommand(ply, cmd)

--	if cmd == "+jump" then
--	end
--	cmd:ClearMovement()
--	cmd:ClearButtons()
end

function util.ToMinutesSeconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	return string.format("%02d:%02d", minutes, math.floor(seconds))
end

-- More appropriate for count downs. Timer will display 00:01 if less than a second remains and never display 00:00.
function util.ToMinutesSecondsCD(seconds)
	seconds = math.ceil(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	return string.format("%02d:%02d", minutes, seconds)
end

function util.ToMinutesSecondsDeciseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local deciseconds = math.floor(seconds % 1 * 10)

	return string.format("%02d:%02d.%01d", minutes, math.floor(seconds), deciseconds)
end

function util.ToMinutesSecondsMilliseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local milliseconds = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d.%02d", minutes, math.floor(seconds), milliseconds)
end

function util.ReturnTimeLeft(seconds)
	local years = math.floor(seconds / TIME_YEAR)
	if years > 0 then
		seconds = seconds - (years * TIME_YEAR)
	end
	local weeks = math.floor(seconds / TIME_WEEK)
	if weeks > 0 then
		seconds = seconds - (weeks * TIME_WEEK)
	end
	local days = math.floor(seconds / TIME_DAY)
	if days > 0 then
		seconds = seconds - (days * TIME_DAY)
	end
	local hours = math.floor(seconds / TIME_HOUR)
	if hours > 0 then
		seconds = seconds - (hours * TIME_HOUR)
	end
	local minutes = math.floor(seconds / TIME_MINUTE)
	if minutes > 0 then
		seconds = seconds - (minutes * TIME_MINUTE)
	end

	return "not yet"
end


function GM:GetInfectionLevel(bypass)
	if not bypass and !self.InfectionLevelEnabled then return 0 end
	return tonumber(GetGlobalFloat("tea_infectionlevel", 0))
end

function GM:SetInfectionLevel(value, bypass)
	if value and self.InfectionLevelEnabled then
		return SetGlobalFloat("tea_infectionlevel", value)
	end
end

function GM:GetInfectionMul(value, bypass)
	if not bypass and !self.InfectionLevelEnabled then return 0 end
	value = value or 1
	return tonumber(1-value + (1 + (self:GetInfectionLevel() * 0.01)) * value)
--	return tonumber((1 * value) + (self:GetInfectionLevel() * (0.01 / value)))
end

function GM:GetDebug()
	return SERVER and self.DebuggingMode or CLIENT and self.DebuggingModeClient or 0
end

-- Work in progress
function GM:GetMinigame()
	return GetGlobalString("tea_current_gamemode_minigame", "none")
end

function GM:SetSeasonalEvent(value)
	SetGlobalInt("TEA_seasonal_event", value)
end

function GM:GetCurrentSeasonalEvent()
	return GetGlobalInt("TEA_seasonal_event", 0)
end

function GM:SetServerRestartTime(time)
	SetGlobalFloat("TEA_Server_Restart_Time", time)
end

function GM:GetServerRestartTime()
	GetGlobalFloat("TEA_Server_Restart_Time")
end

