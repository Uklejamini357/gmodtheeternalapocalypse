--util.AddNetworkString("MakeProp")
util.AddNetworkString("ChangeModel")
util.AddNetworkString("ChangeProp")
util.AddNetworkString("CashBounty")
util.AddNetworkString("AddVault")
util.AddNetworkString("WithdrawVault")

util.AddNetworkString("UpdateStats") -- no functions for this in this file, see player_data.lua and cl_hud.lua
util.AddNetworkString("UpdatePeriodicStats")
util.AddNetworkString("UpdateStatistics")
util.AddNetworkString("UpdatePerks")
util.AddNetworkString("UpdateInventory")
util.AddNetworkString("UpdateTargetStats")
util.AddNetworkString("UpgradePerk")
util.AddNetworkString("UpdateVault")
util.AddNetworkString("UpdateRespawnTimer")

util.AddNetworkString("PlayerIsReady") -- used when player has finished loading entities and has called a gamemode function InitPostEntity
util.AddNetworkString("tea_damagefloater")

util.AddNetworkString("UseItem") -- for the following 4 below, see player_inventory.lua
util.AddNetworkString("UseGun")
util.AddNetworkString("BuyItem")
util.AddNetworkString("SellItem")
util.AddNetworkString("OpenTraderMenu") -- see cl_tradermenu.lua
util.AddNetworkString("CraftItem") -- see server/crafting.lua
util.AddNetworkString("CraftSpecialItem") -- see server/crafting.lua
util.AddNetworkString("SystemMessage")
util.AddNetworkString("RadioMessage")
util.AddNetworkString("UseDelay") -- delays on using items

util.AddNetworkString("RecvFactions") -- see factions.lua and cl_scoreboard.lua
util.AddNetworkString("CreateFaction") -- see factions.lua for below until WraithBlind
util.AddNetworkString("JoinFaction")
util.AddNetworkString("GiveLeader")
util.AddNetworkString("InviteFaction")
util.AddNetworkString("KickFromFaction")
util.AddNetworkString("DisbandFaction")
util.AddNetworkString("WraithBlind") -- rape your vision when you get hit by a wraith
util.AddNetworkString("PrestigeEffect") -- blinding effect but with white screen when prestiged
util.AddNetworkString("Payout") -- see cl_hud and server/npcspawns.lua
util.AddNetworkString("GainMasteryProgress") -- see server/mastery.lua
util.AddNetworkString("Prestige") -- see player_data.lua
util.AddNetworkString("BossKilled") -- called when boss is killed

util.AddNetworkString("tea_opentasksmenu")
util.AddNetworkString("tea_taskassign")
util.AddNetworkString("tea_taskprogress")
util.AddNetworkString("tea_taskcancel")
util.AddNetworkString("tea_taskcomplete")
util.AddNetworkString("tea_taskfinish")

util.AddNetworkString("tea_survivalstatsupdate")
util.AddNetworkString("tea_taskstatsupdate")
util.AddNetworkString("tea_player_ready_spawn")
--util.AddNetworkString("Respawn")

function GM:NetUpdateStats(ply)
	net.Start("UpdateStats")
	net.WriteFloat(ply.Stamina)
	net.WriteFloat(math.Round(ply.Hunger))
	net.WriteFloat(math.Round(ply.Thirst))
	net.WriteFloat(math.Round(ply.Fatigue))
	net.WriteFloat(math.Round(ply.Infection))
	net.WriteFloat(ply.SurvivalTime)
	net.WriteFloat(math.Round(ply.Battery))
	net.Send(ply)
end

function GM:NetUpdatePeriodicStats(ply)
	net.Start("UpdatePeriodicStats")
	net.WriteFloat(ply.Level)
	net.WriteFloat(ply.Prestige)
	net.WriteFloat(ply.Money)
	net.WriteFloat(ply.XP)
	net.WriteFloat(ply.StatPoints)
	net.WriteFloat(ply.PerkPoints)
	net.WriteFloat(ply.Bounty)
	net.Send(ply)
end

function GM:NetUpdatePerks(ply)
	net.Start("UpdatePerks")
	net.WriteFloat(ply.StatDefense)
	net.WriteFloat(ply.StatGunslinger)
	net.WriteFloat(ply.StatSpeed)
	net.WriteFloat(ply.StatVitality)
	net.WriteFloat(ply.StatKnowledge)
	net.WriteFloat(ply.StatMedSkill)
	net.WriteFloat(ply.StatStrength)
	net.WriteFloat(ply.StatEndurance)
	net.WriteFloat(ply.StatSalvage)
	net.WriteFloat(ply.StatBarter)
	net.WriteFloat(ply.StatEngineer)
	net.WriteFloat(ply.StatImmunity)
	net.WriteFloat(ply.StatSurvivor)
	net.WriteFloat(ply.StatAgility)
	net.WriteFloat(ply.StatScavenging)
	net.Send(ply)
end


function GM:NetUpdateStatistics(ply)
	net.Start("UpdateStatistics")
	net.WriteFloat(ply.BestSurvivalTime)
	net.WriteFloat(ply.ZKills)
	net.WriteFloat(ply.playerskilled)
	net.WriteFloat(ply.playerdeaths)
	net.WriteFloat(ply.MasteryMeleeXP)
	net.WriteFloat(ply.MasteryMeleeLevel)
	net.WriteFloat(ply.MasteryPvPXP)
	net.WriteFloat(ply.MasteryPvPLevel)
	net.Send(ply)
end

function GM:NetUpdatePlayerStatistics(ply, target)
	net.Start("UpdateTargetStats")
	net.WriteString(target:Nick())
	net.WriteFloat(target.BestSurvivalTime)
	net.WriteFloat(target.ZKills)
	net.WriteFloat(target.playerskilled)
	net.WriteFloat(target.playerdeaths)
	net.WriteFloat(target.MasteryMeleeXP)
	net.WriteFloat(target.MasteryMeleeLevel)
	net.WriteFloat(GetReqMasteryMeleeXP(target))
	net.WriteFloat(target.MasteryPvPXP)
	net.WriteFloat(target.MasteryPvPLevel)
	net.WriteFloat(GetReqMasteryPvPXP(target))
	net.Send(ply)
end

function GM:SendPlayerSurvivalStats(ply)
	net.Start("tea_survivalstatsupdate")
	net.WriteFloat(ply.LifeZKills)
	net.WriteFloat(ply.LifePlayerKills)
	net.Send(ply)
end


function GM:SystemBroadcast(msg, color, sys) -- same as system message, just broadcasts it to everybody instead of accepting a ply argument
	for k, v in pairs(player.GetAll()) do
		net.Start("SystemMessage")
		net.WriteString(msg)
		net.WriteColor(color or Color(255,255,255))
		net.WriteBool(sys or false)
		net.Send(v)
	end
end

function GM:SystemTranslatedBroadcast(sys, color, msg, ...) -- same as system broadcast, except sends a translated string to everyone
	for k, v in pairs(player.GetAll()) do
		net.Start("SystemMessage")
		net.WriteString(translate.ClientFormat(v, msg, ...))
		net.WriteColor(color or Color(255,255,255))
		net.WriteBool(sys or false)
		net.Send(v)
	end
end

function GM:RadioBroadcast(time, msg, sender, rad)
	timer.Simple(time, function()
		for k, v in pairs(player.GetAll()) do
			net.Start("RadioMessage")
			net.WriteString(sender)
			net.WriteString(msg)
			net.WriteBool(rad)
			net.Send(v)
		end
	end)
end

function GM:RadioTranslatedBroadcast(time, sender, rad, msg, ...)
	timer.Simple(time, function(...)
		for k, v in pairs(player.GetAll()) do
			net.Start("RadioMessage")
			net.WriteString(sender)
			net.WriteString(translate.ClientFormat(v, msg, ...))
			net.WriteBool(rad)
			net.Send(v)
		end
	end)
end


net.Receive("ChangeProp", function(len, ply)
	if !ply:IsValid() or !ply:Alive() then return false end
	local model = net.ReadString()
	ply.SelectedProp = model
end)


net.Receive("ChangeModel", function(len, ply)
	if !ply:IsValid() or !ply:Alive() then return false end
	if (ply.NxtModelChange or 0) > CurTime() then
		ply:SystemMessage(Format("You can't change your playermodel now! Try again in %d seconds!", math.floor(ply.NxtModelChange - CurTime())), Color(255,155,155), true)
		return false
	end
	local model = net.ReadString()
	local col = net.ReadVector()
	ply.ChosenModel = model
	ply.ChosenModelColor = col

	ply:SendUseDelay(1)
	ply.NxtModelChange = CurTime() + 120
	timer.Simple(0.75, function()
		gamemode.Call("RecalcPlayerModel", ply)
	end)
end)


net.Receive("UpgradePerk", function(len, ply)
	local perk = net.ReadString()
	local amt = net.ReadUInt(16)

	local perk2 = "Stat"..perk
	local mul = GAMEMODE.StatConfigs[perk].Cost or 1
	amt = math.min(amt, ply.StatPoints, 10 - ply[perk2])

	if tonumber(ply.StatPoints) < amt * mul or tonumber(ply.StatPoints) < mul then
		ply:SendChat("You need skill points to upgrade skill!")
		return false
	end
	if amt < mul then return end
	if (tonumber(ply[perk2]) >= 10) then
		ply:SendChat("You have reached the maximum number of points for this skill")
		return false
	end

	ply[perk2] = ply[perk2] + (amt * mul)
	ply.StatPoints = ply.StatPoints - (amt * mul)
	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	if GAMEMODE:GetDebug() >= DEBUGGING_ADVANCED then print(ply:Nick().." used "..amt * mul.." skill point(s) on "..perk.." skill ("..tonumber(ply.StatPoints).." skill points remaining)") end
	ply:SendChat(translate.ClientFormat(ply, "perkincreased", perk, amt * mul))
	GAMEMODE:RecalcPlayerSpeed(ply)
	GAMEMODE:FullyUpdatePlayer(ply)
end)


net.Receive("CashBounty", function(len, ply)
	if !ply:IsValid() or !ply:Alive() then return false end

	local trader = false
	local plycheck = ents.FindInSphere(ply:GetPos(), 150)

	for k, v in pairs(plycheck) do
		if v:GetClass() == "trader" then trader = true break end
	end
	if !trader then ply:SystemMessage("You are not in a trader area!", Color(255,205,205), true) return false end
	if ply.Bounty <= 0 then ply:SystemMessage("You don't have any bounty to cash in!", Color(255,205,205), true) return false end

	ply.Money = tonumber(ply.Money) + tonumber(ply.Bounty)
	if GAMEMODE:GetDebug() >= DEBUGGING_NORMAL then print(ply:Nick().." cashed in their bounty and received "..tonumber(math.floor(ply.Bounty)).." "..GAMEMODE.Config["Currency"].."s") end
	ply:SystemMessage(Format("You cashed in your bounty and received %s %ss!", tonumber(math.floor(ply.Bounty)), GAMEMODE.Config["Currency"]), Color(205,255,205), true)
	ply.Bounty = 0
	ply:SetNWInt("PlyBounty", ply.Bounty)

	gamemode.Call("FullyUpdatePlayer", ply)
end)

net.Receive("UpdateTargetStats", function(len, ply)
	local target = net.ReadEntity()
	if !ply:IsValid() or !target:IsValid() then return false end
	
	GAMEMODE:NetUpdatePlayerStatistics(ply, target)
end)

net.Receive("PlayerIsReady", function(len, ply)
	if ply.IsReady then return end
	ply.IsReady = true
	gamemode.Call("PlayerReady", ply)
end)

net.Receive("tea_player_ready_spawn", function(len, ply)
	net.Start("tea_player_ready_spawn")
	net.WriteBool(tobool(ply.HasSpawnedReady))
	net.Send(ply)

	ply.HasSpawnedReady = true
	ply:Spawn()
end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:SendUseDelay(delay)
	if !self:IsValid() or !self:Alive() then return end
	net.Start("UseDelay")
	net.WriteUInt(delay, 8)
	net.Send(self)
end

