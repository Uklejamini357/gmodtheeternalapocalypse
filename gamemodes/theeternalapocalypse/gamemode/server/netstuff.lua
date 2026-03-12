--util.AddNetworkString("MakeProp")
util.AddNetworkString("ChangeModel")
util.AddNetworkString("ChangeProp")
util.AddNetworkString("CashBounty")
util.AddNetworkString("AddVault")
util.AddNetworkString("WithdrawVault")

util.AddNetworkString("tea_updatestamina") -- no functions for this in this file, see player_data.lua and cl_hud.lua
util.AddNetworkString("UpdateStats")
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
util.AddNetworkString("DestroyItem") -- For destroying an item
util.AddNetworkString("BuyItem")
util.AddNetworkString("SellItem")
util.AddNetworkString("OpenTraderMenu") -- see cl_tradermenu.lua
util.AddNetworkString("CraftItem") -- see server/crafting.lua
util.AddNetworkString("CraftSpecialItem") -- see server/crafting.lua
util.AddNetworkString("SystemMessage")
util.AddNetworkString("RadioMessage")
util.AddNetworkString("tea_itemuse") -- delays on using items

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
util.AddNetworkString("tea_perksupdate")
util.AddNetworkString("tea_perksunlock")
util.AddNetworkString("tea_perksreset")

-- Misc network strings
util.AddNetworkString("tea_plyevent_vaultupdate")
util.AddNetworkString("tea_player_sendcharacters")
util.AddNetworkString("tea_openworld_level")


util.AddNetworkString("tea_admin_sendspawns")
util.AddNetworkString("tea_admin_safezone")
util.AddNetworkString("tea_admin_tool")


--util.AddNetworkString("Respawn")

function GM:NetUpdateStats(ply)
	net.Start("UpdateStats")
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
	net.WriteFloat(ply.Money)
	net.WriteFloat(ply.XP)
	net.WriteFloat(ply.StatPoints)
	net.WriteFloat(ply.PerkPoints)
	net.WriteFloat(ply.Bounty)
	net.Send(ply)
end

function GM:NetUpdatePerks(ply)
	net.Start("UpdatePerks")
	for statname, _ in SortedPairs(self.StatConfigs) do
		net.WriteUInt(ply["Stat"..statname], 32)
	end
	net.Send(ply)
end


function GM:NetUpdateStatistics(ply)
	net.Start("UpdateStatistics")
	net.WriteTable(ply.Statistics)
	net.WriteFloat(ply.MasteryMeleeXP)
	net.WriteFloat(ply.MasteryMeleeLevel)
	net.WriteFloat(ply.MasteryPvPXP)
	net.WriteFloat(ply.MasteryPvPLevel)
	net.Send(ply)
end

function GM:NetUpdatePlayerStatistics(ply, target)
	net.Start("UpdateTargetStats")
	net.WriteString(target:Nick())
	net.WriteTable(target.Statistics)
	net.WriteFloat(target.MasteryMeleeXP)
	net.WriteFloat(target.MasteryMeleeLevel)
	net.WriteFloat(target:GetReqMasteryMeleeXP())
	net.WriteFloat(target.MasteryPvPXP)
	net.WriteFloat(target.MasteryPvPLevel)
	net.WriteFloat(target:GetReqMasteryPvPXP())
	net.Send(ply)
end

function GM:SendPlayerSurvivalStats(ply)
	net.Start("tea_survivalstatsupdate")
	net.WriteTable(ply.LifeStats)
	net.Send(ply)
end

function GM:SendPlayerPerksUnlocked(ply)
	net.Start("tea_perksupdate")
	net.WriteTable(ply.UnlockedPerks)
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

	ply.NxtModelChange = CurTime() + 60
	local success = gamemode.Call("RecalcPlayerModel", ply)
	if success then
		ply:PrintTranslatedMessage(3, "playermodel_changed")
	end
end)


net.Receive("UpgradePerk", function(len, ply)
	local perk = net.ReadString()
	local amount = math.max(1, net.ReadUInt(16))

	local perk2 = "Stat"..perk
	local skill = GAMEMODE.StatConfigs[perk]
	local curskillamt = tonumber(ply[perk2])
	local mul = 1--(skill.Cost or 1) * (curskillamt >= skill.Max and 2 or 1)
	local max = skill.Max + (ply:HasPerk("empowered_skills") and skill.PerkMaxIncrease or 0)
	amt = math.min(amount, math.max(1, ply.StatPoints), max - curskillamt)
	local new = curskillamt + amt
	local cost = (amt * mul) + math.max(0, new - math.max(curskillamt, skill.Max))
	amt = math.min(amt, math.floor(ply.StatPoints-(cost-amt)), max - curskillamt)

	if tonumber(ply.StatPoints) < cost then
		ply:SendChat(translate.ClientGet(ply, "you_need_sp_to_upgrade_skill"))
		return false
	end

	if amt < mul then return end
	if max < curskillamt and (tonumber(curskillamt) >= max) then
		ply:SendChat(translate.ClientGet(ply, "reached_max_skill_level"))
		return false
	end

	ply[perk2] = new
	ply.StatPoints = ply.StatPoints - cost
	ply:SetMaxHealth(GAMEMODE:CalcMaxHealth(ply))
	ply:SetMaxArmor(GAMEMODE:CalcMaxArmor(ply))
	ply:SetJumpPower(GAMEMODE:CalcJumpPower(ply))
	if GAMEMODE:GetDebug() >= DEBUGGING_ADVANCED then print(ply:Nick().." used "..amt * mul.." skill point(s) on "..perk.." skill ("..tonumber(ply.StatPoints).." skill points remaining)") end
	ply:SendChat(translate.ClientFormat(ply, "perkincreased", perk, amt))
	GAMEMODE:RecalcPlayerSpeed(ply)
	GAMEMODE:FullyUpdatePlayer(ply)
end)


net.Receive("CashBounty", function(len, ply)
	if !ply:IsValid() or !ply:Alive() then return false end

	local trader = false
	local plycheck = ents.FindInSphere(ply:GetPos(), 150)

	for k, v in pairs(plycheck) do
		if v:GetClass() == "tea_trader" then trader = true break end
	end
	if !trader then ply:SystemMessage("You are not in a trader area!", Color(255,205,205), true) return false end
	if ply.Bounty <= 0 then ply:SystemMessage("You don't have any bounty to cash in!", Color(255,205,205), true) return false end

	ply.Money = tonumber(ply.Money) + tonumber(ply.Bounty)
	if GAMEMODE:GetDebug() >= DEBUGGING_NORMAL then print(ply:Nick().." cashed in their bounty and received "..tonumber(math.floor(ply.Bounty)).." "..GAMEMODE.Config["Currency"].."s") end
	ply:SystemMessage(Format("You cashed in your bounty and received %s %ss!", tonumber(math.floor(ply.Bounty)), GAMEMODE.Config["Currency"]), Color(205,255,205), true)
	ply.Bounty = 0
	ply:SetNWInt("PlyBounty", ply.Bounty)

	GAMEMODE:NetUpdatePeriodicStats(ply)
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

	if !ply:Alive() and !ply.HasSpawnedReady then
		GAMEMODE:SystemBroadcast(translate.Format("plspawned", ply:Nick()), Color(255,255,155,255), false)
		ply.HasSpawnedReady = true
		ply:Spawn()
	end
	ply:LoadLastSession()
end)

net.Receive("tea_perksunlock", function(len, pl)
	local perk = net.ReadString()

	local perkl = GAMEMODE.PerksList[perk]
	if !perkl then return end
	local cost = GAMEMODE.PerksList[perk].Cost

	if pl.UnlockedPerks[perk] then
		pl:SendChat(translate.ClientGet(pl, "perk_already_unlocked"))
		return false
	end

	if tonumber(pl.PerkPoints) < cost then
		pl:SendChat(translate.ClientFormat(pl, "perk_need_points_to_unlock", cost))
		return false
	end

	if tonumber(pl.Prestige) < perkl.PrestigeReq then
		pl:SendChat(translate.ClientFormat(pl, "perk_need_prestige_to_unlock", perkl.PrestigeReq))
		return false
	end

	pl.UnlockedPerks[perk] = true
	pl.PerkPoints = pl.PerkPoints - cost

	if perkl.OnUnlock then
		perkl.OnUnlock(pl)
	end


	pl:SetMaxHealth(GAMEMODE:CalcMaxHealth(pl))
	pl:SetMaxArmor(GAMEMODE:CalcMaxArmor(pl))
	pl:SetJumpPower(GAMEMODE:CalcJumpPower(pl))
--	if GAMEMODE:GetDebug() >= DEBUGGING_ADVANCED then print(pl:Nick().." used "..amt * mul.." skill point(s) on "..perk.." skill ("..tonumber(pl.StatPoints).." skill points remaining)") end
	pl:SendChat(translate.ClientFormat(pl, "perk_unlocked", perkl.Name))
	GAMEMODE:RecalcPlayerSpeed(pl)
	GAMEMODE:SendPlayerPerksUnlocked(pl)
	GAMEMODE:NetUpdatePeriodicStats(pl)
end)

net.Receive("tea_perksreset", function(len, pl)
	local costpoints = 0
	local points = pl.PerkPoints

	for perk,_ in pairs(pl.UnlockedPerks) do
		local perkinfo = GAMEMODE.PerksList[perk]

		costpoints = costpoints + perkinfo.Cost
		points = points + perkinfo.Cost

		if perkinfo.OnReset then
			perkinfo.OnReset(pl)
		end
	end
	
	local finalcost = 2000 * costpoints + (costpoints * 500*((costpoints-1)/2))

	if finalcost <= 0 then return end
	if pl.Money < finalcost then
		pl:SystemMessage("You do not have enough money to reset your perks!", Color(255,0,0), true)
		return
	end


	pl.PerkPoints = points
	pl.Money = pl.Money - finalcost
	pl.UnlockedPerks = {}
	pl:SystemMessage("Reset all your perks and refunded perk points for "..finalcost.." "..GAMEMODE.Config["Currency"].."s!")

	pl:SetMaxHealth(GAMEMODE:CalcMaxHealth(pl))
	pl:SetMaxArmor(GAMEMODE:CalcMaxArmor(pl))
	pl:SetJumpPower(GAMEMODE:CalcJumpPower(pl))
	GAMEMODE:RecalcPlayerSpeed(pl)
	GAMEMODE:SendPlayerPerksUnlocked(pl)
	GAMEMODE:NetUpdatePeriodicStats(pl)
end)


function GM:SendSpawnsToPlayer(pl, spawn)
end

net.Receive("tea_admin_tool", function(len, pl)
	if !SuperAdminCheck(pl) then return end
	local t = net.ReadString()
	
	if t == "createopenworldtransition" then
		local start = net.ReadVector()
		local min = net.ReadVector()
		local max = net.ReadVector()
		local name = net.ReadString()

		PrintMessage(3, "new transition has been made.")
		gamemode.Call("CreateMapTransition", name, game.GetMap(), start, min, max)
		gamemode.Call("SaveTransitionsData")
		gamemode.Call("SpawnLevelTransitions")
	elseif t == "admineyes" then
		local m = net.ReadString()
		local v = net.ReadBool()


		local spawnables = GAMEMODE.AdminMapSpawnables[m]
		if spawnables.GetAdminEyes then
			net.Start("tea_admin_tool")
			net.WriteString("admineyes")
			net.WriteString(m)
			net.WriteTable(spawnables.GetAdminEyes(pl))
			net.Send(pl)
		end
	end

	local wep = pl:GetWeapon("tea_admintool")
	if !IsValid(wep) then return end

	if t == "selectspawner" then
		local spawning = net.ReadString()

		if GAMEMODE.Config["ZombieClasses"][spawning] or GAMEMODE.Config["BossClasses"][spawning] then
			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_ZOMBIE)
		elseif GAMEMODE.FlimsyProps[spawning] then
			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_PROPSFLIMSY)
		elseif GAMEMODE.ToughProps[spawning] then
			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_PROPSSTRONG)
		elseif GAMEMODE.SpecialStructureSpawns[spawning] then
			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_FACSTRUCTURES)
		elseif GAMEMODE.AdminMapSpawnables[spawning] then
			local ams = GAMEMODE.AdminMapSpawnables[spawning]

			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_MAPSPAWNS)

			if ams.OnSelect then
				ams.OnSelect(pl, wep)
			end
		elseif GAMEMODE.AdminTools[spawning] then
			local at = GAMEMODE.AdminTools[spawning]

			wep:SetSpawningType(ADMINTOOL_SPAWNTYPE_TOOL)

			if at.OnSelect then
				at.OnSelect(owner, wep)
			end
		end
		wep:SetSpawning(spawning)

	elseif t == "setoptions" then
		local tbl = net.ReadTable()
		table.Merge(wep.SetOptions, tbl)
	elseif t == "toggleremover" then
		wep:SetMode(net.ReadUInt(4))
	end
end)


function GM:SendAllSpawnsToPlayer(pl)
	self:SendSpawnsToPlayer(pl, "zombies")
	self:SendSpawnsToPlayer(pl, "loots")
	self:SendSpawnsToPlayer(pl, "traders")
	self:SendSpawnsToPlayer(pl, "taskdealers")
	self:SendSpawnsToPlayer(pl, "airdrops")
	self:SendSpawnsToPlayer(pl, "playerspawns")
end

local meta = FindMetaTable("Player")
if not meta then return end

function meta:SendUseDelay(delay, text, shouldtranslate, canmove, noforceholsterweapon)
	if !self:IsValid() or !self:Alive() or (tonumber(delay) or 0) < 0 then return end
	self.UsingItemDuration = delay
	self.UsingItemTime = CurTime()
	self.UsingItemCanMove = canmove

	if not noforceholsterweapon then
		self:ActivityForceHolsterWeapon()
	end

	net.Start("tea_itemuse")
	net.WriteFloat(delay)
	net.WriteString(text)
	net.WriteBool(shouldtranslate)
	net.WriteBool(canmove)
	net.Send(self)
end

function meta:NWSendStamina()
	net.Start("tea_updatestamina")
	net.WriteFloat(self.Stamina)
	net.WriteFloat(math.Round(self.Oxygen))
	net.Send(self)
end

function meta:GoSleep()
	if not self:CheckCanSleep() then return end
	self:SetIsSleeping(true)

	self:ActivityForceHolsterWeapon()
	self:SendChat(translate.ClientGet(self, "sleep_now_sleeping"))
	self:SetNoDraw(true)
	self:CreateRagdoll()
end

function meta:WakeUp()
	if not self:IsSleeping() then return end
	self:SetIsSleeping(false)
	self.NextSleepDelay = CurTime() + 10

	self:SetNoDraw(false)
	if self:Alive() then
		self:GetRagdollEntity():Remove()
	end
end

function meta:CheckCanSleep()
	if not self:Alive() or self:IsSleeping() then return false end
	if self.Fatigue <= 2000 then self:SendChat(translate.Get("sleep_not_tired")) return false end
	if self.Hunger <= 3000 then self:SendChat(translate.Get("sleep_hungry")) return false end
	if self.Thirst <= 3000 then self:SendChat(translate.Get("sleep_thirsty")) return false end
	if self.Infection >= 8000 then self:SendChat(translate.Get("sleep_infected")) return false end
	if self:WaterLevel() >= 1 then self:SendChat("You literally cannot sleep if you are in water right now.") return false end
	if self.NextSleepDelay and self.NextSleepDelay > CurTime() then self:SendChat("You can't sleep right now. Try again in "..math.ceil(self.NextSleepDelay - CurTime()).." seconds!") return false end

	return true
end

function meta:ActivityForceHolsterWeapon()
	local activewep = self:GetActiveWeapon()
	if not self:GetWeapon("tea_fists"):IsValid() then
		self:Give("tea_fists")
	end
	self:SelectWeapon("tea_fists")

	if activewep:IsValid() then
		self.UsingItemSwitchWeapon = activewep:GetClass()
	end
end
