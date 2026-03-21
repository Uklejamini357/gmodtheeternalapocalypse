GM.Name		= "The Eternal Apocalypse" -- The Eternol Apocalypse
GM.AltName	= "After The End Reborn"
GM.Author	= "Uklejamini"
GM.Email	= ""
GM.Website	= "https://github.com/Uklejamini357/gmodtheeternalapocalypse"
GM.Version	= "0.12.0b8" -- very close to 0.12.0. now for reworking the loots, and writing all the changelog notes.
GM.DateVer	= "16.03.2026" -- Follows the DD.MM.YYYY format.
GM.Credits = {
	-- Assets
	{"GSC Game World",			"For all the S.T.A.L.K.E.R. content",										""},
	{"WickedRabbit",			"For porting the STALKER assets to gmod (and credits to his contributors)",	"https://steamcommunity.com/sharedfiles/filedetails/?id=2438451886"},
	{"Comrade Communist",		"S.T.A.L.K.E.R. sounds",													"https://steamcommunity.com/sharedfiles/filedetails/?id=1680884607"},

	-- Supporters
	{"LegendOfRobbo",			"After The End creator",													""}, -- 2015
	{"Commander Shepard",		"For hosting AtE (ZsRPG) back in the days",									""}, -- 2017-2020

	-- Contributors
	{"CLuaRainBob",				"T.E.A. Contributor",														""}, -- Reworked build tool, Added SFS save method

	-- Translators
	{"BlueBerryy",				"Russian Translator",														""},
	{"Sirtlan",					"Spanish Translator",														""},

	-- Other
	{"Anyone else I forgot",	"Various contributions",													""},
}

DeriveGamemode("sandbox")

hook.Add("CanProperty", "TEA.CanProperty", function(ply, property, ent)
	if not SuperAdminCheck(ply) then return false end
end)

hook.Add("CanArmDupe", "TEA.CanArmDupe", function(ply)
	if not SuperAdminCheck(ply) then return false end
end)

hook.Add("CanDrive", "TEA.CanDrive", function(ply, ent)
	if not SuperAdminCheck(ply) then return false end
end)

hook.Add("CanTool", "TEA.CanTool", function(ply, tr, toolname, tool, button)
	if not SuperAdminCheck(ply) then return false end
end)

if SERVER then

	hook.Add("PlayerSpawnEffect", "TEA.PlayerSpawnEffect", function(ply, model)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnNPC", "TEA.PlayerSpawnNPC", function(ply, npc_type, weapon)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnObject", "TEA.PlayerSpawnObject", function(ply, model, skin)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnProp", "TEA.PlayerSpawnProp", function(ply, model)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnRagdoll", "TEA.PlayerSpawnRagdoll", function(ply, model)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnSENT", "TEA.PlayerSpawnSENT", function(ply, class)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnSWEP", "TEA.PlayerSpawnSWEP", function(ply, weapon, swep)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnVehicle", "TEA.PlayerSpawnVehicle", function(ply, model, name, table)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerGiveSWEP", "TEA.PlayerGiveSWEP", function(ply, weapon, spawninfo)
		if not SuperAdminCheck(ply) then return false end
	end)

	hook.Add("PlayerSpawnedProp", "TEA.PlayerSpawnedProp", function(ply, model, ent)
		if ent:Health() != 0 then return end
		gamemode.Call("SetupProp", ent)
	end)
end

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
		for _, ent in pairs (ents.FindByClass("tea_trader")) do
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


function GetPerk(perk)
	return GAMEMODE.StatConfigs[perk]
end

function GM:CheckItemRarity(rarity)
	local tbl = {}

	if rarity == RARITY_GARBAGE then
		tbl.col = Color(155,155,155)
		tbl.text = translate.Get("garbage")
	elseif rarity == RARITY_JUNK then
		tbl.col = Color(205,205,205)
		tbl.text = translate.Get("junk")
	elseif rarity == RARITY_COMMON then
		tbl.col = Color(230,230,230)
		tbl.text = translate.Get("common")
	elseif rarity == RARITY_UNCOMMON then
		tbl.col = Color(205,255,205)
		tbl.text = translate.Get("uncommon")
	elseif rarity == RARITY_RARE then
		tbl.col = Color(155,155,255)
		tbl.text = translate.Get("rare")
	elseif rarity == RARITY_SUPERRARE then
		tbl.col = Color(255,205,0)
		tbl.text = translate.Get("super_rare")
	elseif rarity == RARITY_EPIC then
		tbl.col = Color(255,155,255)
		tbl.text = translate.Get("epic")
	elseif rarity == RARITY_LEGENDARY then
		tbl.col = Color(255,130,251)
		tbl.text = translate.Get("legendary")
	elseif rarity == RARITY_MYTHIC then
		tbl.col = Color(252,98,56)
		tbl.text = translate.Get("mythic")
	elseif rarity == RARITY_GODLY then
		tbl.col = Color(math.abs(math.sin(SysTime()))*255,0,155)
		tbl.text = translate.Get("godly")
		tbl.keeprefresh = true
	elseif rarity == RARITY_EVENT then
		tbl.col = Color(55,55,155+math.abs(math.sin(SysTime()))*100)
		tbl.text = translate.Get("event")
		tbl.keeprefresh = true
	elseif rarity == RARITY_UNOBTAINABLE then
		tbl.col = Color(255,255,255)
		tbl.text = translate.Get("unobtainable")
	else
		tbl.col = Color(96,96,96)
		tbl.text = translate.Get("uncategorized")
	end

	return tbl
end

function GM:StartCommand(ply, cmd)
	local keys = cmd:GetButtons()
	cmd:ClearButtons()

	if ply.Stamina > 20 and !ply:GetCanSprint() then
		ply:SetCanSprint(true)
	end

	if (ply:IsSprinting() and ply:GetPlayerMoving() and ply.Stamina <= 0) and ply:GetCanSprint() then
		-- ply:ConCommand("-speed")
		ply:SetCanSprint(false)
	end

	if ply:GetMoveType() != MOVETYPE_NOCLIP then
		if bit.band(IN_SPEED, keys) ~= 0 and !ply:GetCanSprint() then
			keys = keys - IN_SPEED
		end
		-- if bit.band(IN_JUMP, keys) ~= 0 and !ply:GetCanSprint() then
			-- keys = keys - IN_JUMP
		-- end
	end

	if (ply:IsUsingItem() and not ply.UsingItemCanMove) or ply:IsSleeping() then
		cmd:ClearButtons()
		cmd:ClearMovement()

		return true
	end

	cmd:SetButtons(keys)
end

function GM:Move(ply, mv)
	if ply.Stamina then
		if ply.Stamina <= 1 then
			mv:SetMaxSpeed(mv:GetMaxSpeed()*0.75)
		elseif ply.Stamina <= 10 then
			mv:SetMaxSpeed(mv:GetMaxSpeed()*0.9)
		end
	end
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

function GM:GetEffectiveInfectionLevel(bypass)
	if not bypass and !self.InfectionLevelEnabled then return 0 end
	return tonumber(GetGlobalFloat("tea_infectionlevel", 0))
end

function GM:SetInfectionLevel(value, bypass)
	if value and self.InfectionLevelEnabled then
		return SetGlobalFloat("tea_infectionlevel", value)
	end
end

function GM:GetInfectionMul(value, bypass, effective)
	if not bypass and !self.InfectionLevelEnabled then return 0 end
	value = value or 1
	return tonumber(1-value + (1 + ((effective and self:GetEffectiveInfectionLevel() or self:GetInfectionLevel()) * 0.01)) * value)
--	return tonumber((1 * value) + (self:GetInfectionLevel() * (0.01 / value)))
end

function GM:GetInfectionTextColor(infection)
	if not infection then infection = self:GetInfectionLevel() end
	if infection >= 250 then
		local count = math.floor(((infection-200)/50)^0.75)
		local mul = math.Clamp(1.5 - (CurTime()*(5 + count)/10)%1, 0.5, 1.5)
		return "Chaos+"..count, Color(127*mul,31*mul,31*mul)
	elseif infection >= 200 then
		return "Chaos", Color(127,31,31)
	elseif infection >= 150 then
		return "Nightmare", Color(159,31,31)
	elseif infection >= 125 then
		return "Horror", Color(191,31,31)
	elseif infection > 100 then
		return "Over-Infected", Color(223,31,31)
	elseif infection >= 90 then
		return "Maximal", Color(255,0,0)
	elseif infection >= 80 then
		return "Infected", Color(255,63,63)
	elseif infection >= 60 then
		return "High", Color(255,127,127)
	elseif infection >= 40 then
		return "Medium", Color(191,191,127)
	elseif infection >= 20 then
		return "Low", Color(127,255,191)
	elseif infection > 0 then
		return "Very Low", Color(127,255,239)
	else
		return "None", Color(127,255,255)
	end
end

function GM:GetEliteVariantSpawnChance(boss)
	local chance = self:GetCurrentSeasonalEvent() != SEASONAL_EVENT_HALLOWEEN and (boss and 10 or 1) or
	self:GetCurrentSeasonalEvent() == SEASONAL_EVENT_HALLOWEEN and (boss and 35 or 5)
	return chance
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
	return GetGlobalFloat("TEA_Server_Restart_Time")
end

function GM:SetEvent(event)
	SetGlobalInt("TEA_CURRENTEVENT", event)
end

function GM:GetEvent()
	return GetGlobalInt("TEA_CURRENTEVENT", EVENT_NONE)
end

function GM:SetEventTimer(time)
	SetGlobalFloat("TEA_Event_Timer", time)
end

function GM:GetEventTimer()
	return GetGlobalFloat("TEA_Event_Timer", -1)
end

function GM:GetItemName(id, ply) -- ply is for the server
	local item = self.ItemsList[id]
	local name = item.Name or ply and translate.ClientGet(ply, id.."_n") or translate.Get(id.."_n")

	return name
end

function GM:GetItemDescription(id, ply) -- ply is for the server
	local item = self.ItemsList[id]
	local desc = item.Description or ply and translate.ClientGet(ply, id.."_d") or translate.Get(id.."_d")
--[[
	if item.Thirst then
		desc = desc.."\n"..Format("Thirst: %s%%", tonumber(item.Thirst) > 0 and "+"..item.Thirst or item.Thirst)
	end
]]

	desc = desc.."\n"
	local itemtype = item.ItemType
	if itemtype and self.ItemTypes[itemtype] then
		desc = desc.."\nItem type: "..self.ItemTypes[itemtype]
	end

	local armorstats = item.ArmorStats
	if armorstats then
		if armorstats.reduction then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_prot", armorstats.reduction)
		end

		if armorstats.env_reduction then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_env_prot", armorstats.env_reduction)
		end

		if armorstats.speedloss_percent then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_speed", 100 - armorstats.speedloss_percent)
		end

		if armorstats.slots then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_att_slots", armorstats.slots)
		end

		if armorstats.battery then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_battery", armorstats.battery)
		end

		if armorstats.carryweight then
			desc = desc.."\n"..translate.ClientFormat(ply, "armor_max_weight", armorstats.carryweight >= 0 and "+" or "", armorstats.carryweight)
		end
	end

	local consum = item.ConsumableStats
	if consum then
		if consum.UseTime and consum.UseTime > 0 then
			desc = desc.."\nUse Time: "..consum.UseTime.."s"
		end
		desc = desc.."\n"

		desc = desc.."\nOn usage:"

		if consum.Health and consum.Health ~= 0 then
			local medskill
			if ply and ply:IsValid() and ply.StatMedSSkill ~= 0 then
				medskill = (consum.Health > 0 and "+"..math.Round(consum.Health * ply.StatMedSkill) or math.Round(consum.Health))
			end

			desc = desc.."\nHealth: "..(consum.Health > 0 and "+"..consum.Health or consum.Health).."%"..(medskill and "(Engineer: "..medskill.."% Health)" or "")
		end

		if consum.Armor and consum.Armor ~= 0 then
			local engineer
			if ply and ply:IsValid() and ply.StatEngineer ~= 0 then
				engineer = (consum.Armor > 0 and "+"..math.Round(consum.Armor * ply.StatEngineer) or math.Round(consum.Armor))
			end

			desc = desc.."\nArmor: "..(consum.Armor > 0 and "+"..consum.Armor or consum.Armor).."%"..(engineer and "(Engineer: "..engineer.."% Armor)" or "")
		end

		if consum.Battery and consum.Battery ~= 0 then
			desc = desc.."\nBattery: "..(consum.Battery > 0 and "+"..consum.Battery or consum.Battery).."%"
		end

		if consum.Infection and consum.Infection ~= 0 then
			desc = desc.."\nInfection: "..(consum.Infection > 0 and "+"..consum.Infection or consum.Infection).."%"
		end
		
		if consum.Stamina and consum.Stamina ~= 0 then
			desc = desc.."\nStamina: "..(consum.Stamina > 0 and "+"..consum.Stamina or consum.Stamina).."%"
		end

		if consum.Thirst and consum.Thirst ~= 0 then
			desc = desc.."\nThirst: "..(consum.Thirst > 0 and "+"..consum.Thirst or consum.Thirst).."%"
		end

		if consum.Hunger and consum.Hunger ~= 0 then
			desc = desc.."\nHunger: "..(consum.Hunger > 0 and "+"..consum.Hunger or consum.Hunger).."%"
		end

		if consum.Fatigue and consum.Fatigue ~= 0 then
			desc = desc.."\nFatigue: "..(consum.Fatigue > 0 and "+"..consum.Fatigue or consum.Fatigue).."%"
		end
	end

	if item.AddDesc then
		desc = desc.."\n"..item.AddDesc
	end

	return desc
end

function GM:GetSkillDescription(id, ply)
	local skill = self.StatConfigs[id]
	local desc = skill.Description or ply and translate.ClientGet(ply, id.."_d") or translate.Get(id.."_d")

	return desc
end

function GM:SetInflationMeter(val)
	return SetGlobalFloat("TEA.InflationMeter", val)
end

function GM:GetInflationMeter()
	return GetGlobalFloat("TEA.InflationMeter", 0)
end

-- Updates every 1 hour
function GM:CalcInflationMeter()
	local time = self.Config["InflationCycleTime"]*86400
	local val = ((os.time() - self.ServerInitOsTime)%time)/time

	if val > 0.05 and val <= 0.6 then
		return (val-0.05)/0.55
	elseif val > 0.6 and val < 1 then
		return (1-(val-0.6)/0.4)
	end

	return 0
end

function GM:GetInflationBuyCostMul()
	local val = 0
	local inflation = self:GetInflationMeter()

	if self.EconomyInflationMode == DIFFICULTY_INFLATION_OFF then
		return 0
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_LOW then
		val = 0.04
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_MEDIUM then
		val = 0.08
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_NORMAL then
		val = 0.15
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_INTERMEDIATE then
		val = 0.25
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_HIGH then
		val = 0.40
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_VERYHIGH then
		val = 0.65
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_WORLDCRISIS then
		val = 1.20
	end

	return val*inflation
end

function GM:GetInflationSellCostMul()
	local val = 0
	local inflation = self:GetInflationMeter()

	if self.EconomyInflationMode == DIFFICULTY_INFLATION_OFF then
		return 0
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_LOW then
		val = 0.01
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_MEDIUM then
		val = 0.02
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_NORMAL then
		val = 0.05
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_INTERMEDIATE then
		val = 0.08
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_HIGH then
		val = 0.15
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_VERYHIGH then
		val = 0.20
	elseif self.EconomyInflationMode == DIFFICULTY_INFLATION_WORLDCRISIS then
		val = 0.25
	end

	return val*inflation
end

function GM:GetEconomyDiffBuyCostMul()
	if self.EconomyDifficulty == DIFFICULTY_ECONOMY_EASY then
		return 0.85
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_STANDARD then
		return 1
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_DIFFICULT then
		return 1.20
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_COMPLEX then
		return 1.50
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HARSH then
		return 2.00
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HELLISH then
		return 2.50
	end

	return 1
end

function GM:GetEconomyDiffSellCostMul()
	if self.EconomyDifficulty == DIFFICULTY_ECONOMY_EASY then
		return 1.10
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_STANDARD then
		return 1
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_DIFFICULT then
		return 0.85
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_COMPLEX then
		return 0.75
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HARSH then
		return 0.60
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HELLISH then
		return 0.50
	end

	return 1
end

function GM:GetEconomyXPGainMul()
	if !self.EconomyDifficultyAffectsXPGain then return 1 end

	if self.EconomyDifficulty == DIFFICULTY_ECONOMY_EASY then
		return 0.95
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_STANDARD then
		return 1
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_DIFFICULT then
		return 1.05
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_COMPLEX then
		return 1.10
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HARSH then
		return 1.20
	elseif self.EconomyDifficulty == DIFFICULTY_ECONOMY_HELLISH then
		return 1.30
	end

	return 1
end

function GM:GetDiffZombieHealthMul()
	if self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_BASIC then
		return 0.8
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_NORMAL then
		return 1
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ADVANCED then
		return 1.15
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_CHALLENGING then
		return 1.40
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ULTIMATE then
		return 1.60
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL then
		return 2
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE then
		return 5
	end 
	return 1
end

function GM:GetDiffZombieDamageMul()
	if self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_BASIC then
		return 0.75
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_NORMAL then
		return 1
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ADVANCED then
		return 1.20
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_CHALLENGING then
		return 1.50
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ULTIMATE then
		return 1.75
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL then
		return 2.25
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE then
		return 3
	end 
	return 1
end

function GM:GetDiffXPMul()
	if self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_BASIC then
		return 0.85
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_NORMAL then
		return 1
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ADVANCED then
		return 1.20
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_CHALLENGING then
		return 1.30
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ULTIMATE then
		return 1.6
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL then
		return 2
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE then
		return 4
	end 
	return 1
end

function GM:GetDiffCashMul()
	if self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_BASIC then
		return 0.85
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_NORMAL then
		return 1
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ADVANCED then
		return 1.10
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_CHALLENGING then
		return 1.20
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_ULTIMATE then
		return 1.4
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL then
		return 1.75
	elseif self.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE then
		return 3.5
	end 
	return 1
end

function GM:GetZombieLvlMin()
	return math.floor(#player.GetAll()+self:GetInfectionLevel()/5)
end

function GM:GetZombieLvlMax()
	return math.floor(#player.GetAll()+9+self:GetInfectionLevel()/3)
end

function GM:GetLootTypeName(id)
	if id == LOOTTYPE_NORMAL then
		return "Loot cache"
	elseif id == LOOTTYPE_BOSS then
		return "Boss loot cache"
	elseif id == LOOTTYPE_FACTION then
		return "Faction loot cache"
	end
end

function GM:GetLootRarityColor(id)
	if id == LOOTRARITY_COMMON then
		return color_white
	elseif id == LOOTRARITY_UNCOMMON then
		return Color(188,237,168)
	elseif id == LOOTRARITY_RARE then
		return Color(120,203,236)
	elseif id == LOOTRARITY_EPIC then
		return Color(188,107,232)
	elseif id == LOOTRARITY_LEGENDARY then
		return Color(251,240,168)
	end
end

function GM:GetLootRarityName(id)
	if id == LOOTRARITY_COMMON then
		return "Common"
	elseif id == LOOTRARITY_UNCOMMON then
		return "Uncommon"
	elseif id == LOOTRARITY_RARE then
		return "Rare"
	elseif id == LOOTRARITY_EPIC then
		return "Epic"
	elseif id == LOOTRARITY_LEGENDARY then
		return "Legendary"
	end
end

function HammerUnitsToMeters(units)
	return units/52.46
end

local entmeta = FindMetaTable("Entity")

function entmeta:GetStructureHealth()
	return self:GetNWInt("ate_integrity", 0)
end

function entmeta:SetStructureHealth(val)
	return self:SetNWInt("ate_integrity", val)
end

function entmeta:GetStructureMaxHealth()
	return self:GetNWInt("ate_maxintegrity", 0)
end

function entmeta:SetStructureMaxHealth(val)
	return self:SetNWInt("ate_maxintegrity", val)
end

