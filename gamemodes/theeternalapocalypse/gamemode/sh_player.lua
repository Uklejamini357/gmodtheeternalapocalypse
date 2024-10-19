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

	gamemode.Call("RecalcPlayerSpeed", self)
	timer.Create("tea_SLOWDOWN_"..self:EntIndex(), time, 1, function()
		if !self:IsValid() then return end
		self.SlowDown = 0
		gamemode.Call("RecalcPlayerSpeed", self)
	end)
end

function meta:SendChat(msg)
	if self == NULL then return end -- ?????
	if !SERVER or !self:IsPlayer() then return end
	self:PrintMessage(3, msg)
end

function meta:SystemMessage(msg, color, sys)
	net.Start("SystemMessage")
	net.WriteString(msg)
	net.WriteColor(color or Color(255,255,255))
	net.WriteBool(sys or false)
	net.Send(self)
end

function meta:IsNewbie()
	return tonumber(self:GetTEALevel()) < 10 and tonumber(self:GetTEAPrestige()) < 1
end

function meta:AddInfection(inf)
	self.Infection = math.Clamp((self.Infection or 0) + (inf * (1 - (self.StatImmunity or 0) * 0.03)), 0, 10000)
end

function meta:GetTEALevel()
	return self.Level or self:GetNWInt("PlyLevel", 1)
end

function meta:GetTEAPrestige()
	return self.Prestige or self:GetNWInt("PlyPrestige", 0)
end

function meta:GetMaxLevel()
	return math.min(100, GAMEMODE.MaxLevel + (self:GetTEAPrestige() * GAMEMODE.LevelsPerPrestige))
end

function meta:HasPerk(perk)
	return self.UnlockedPerks and self.UnlockedPerks[perk] or GAMEMODE.LocalPerks[perk]
end

function meta:HasCompletedTask()
	local task = self.CurrentTask or GAMEMODE.CurrentTask or ""
	local taskl = GAMEMODE.Tasks[task]

	if !taskl then return false end
	return taskl.GetCompleted and taskl.GetCompleted(self) or !taskl.GetCompleted and tonumber(self.CurrentTaskProgress or GAMEMODE.CurrentTaskProgress or 0) >= taskl.ReqProgress
end

function meta:GetReqXP()
	local basexpreq = 509
	local addxpperlevel = 97
	local addxpperlevel2 = 1.1329

	local plyprestige = SERVER and self.Prestige or MyPrestige
	local plylevel = SERVER and self.Level or MyLvl

	local xp = (basexpreq + (plylevel  * addxpperlevel) * (1 + (plyprestige * (0.0072 + math.min(20, plyprestige) * 0.0003)))) ^ addxpperlevel2
	return math.floor(xp * math.max(1, 1+(plylevel-30)*0.01))
end

function meta:GetReqMasteryMeleeXP(ply)
	local xpreq = 984
	local addexpperlevel = 165
	local addexpperlevel2 = 1.161

	local mlvl = SERVER and self.MasteryMeleeLevel or MyMMeleelvl

	return math.floor(xpreq + (mlvl * addexpperlevel) ^ addexpperlevel2)
end

function meta:GetReqMasteryPvPXP(ply)
	local expreq = 593
	local addxpprlevel = 85
	local addexpperlevel2 = 1.153

	local mlvl = SERVER and self.MasteryPvPLevel or MyMPvplvl

	return math.floor(expreq + (mlvl * addxpprlevel) ^ addexpperlevel2)
end

function meta:GetProgressToPrestige()
	local lvl, xp = SERVER and self.Level or CLIENT and MyLvl or 0
	local xp = math.min(self:GetReqXP(), SERVER and self.XP or CLIENT and MyXP or 0)

	return math.min(1, lvl >= self:GetMaxLevel() and 1 or (lvl - 1 + (xp / self:GetReqXP())) / (self:GetMaxLevel() - 1))
end


function meta:CalculateVaultWeight()
	local totalweight = 0
	for k, v in pairs(LocalVault) do
		totalweight = totalweight + (v.Weight * v.Qty)
	end
	return totalweight
end

function meta:CalculateWeight()
	local totalweight = 0
	if SERVER then
		for k, v in pairs(self.Inventory) do
			local ref = GAMEMODE.ItemsList[k]
			if !ref then ErrorNoHalt("CalculateWeight error on "..self:Nick().."! They must have a corrupt inventory (file) or something\n") continue end
			totalweight = totalweight + (ref.Weight * v)
		end
	else
		for k, v in pairs(LocalInventory) do
			totalweight = totalweight + (v.Weight * v.Qty)
		end
	end
	return totalweight
end

function meta:CalculateMaxWeight()
	local armorstr = self:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]

	if SERVER then
		if self.StatsPaused then return 1e300 end

		return GAMEMODE.Config["MaxCarryWeight"] + (self.UnlockedPerks["weightboost"] and 1.5 or 0) + (self.UnlockedPerks["weightboost2"] and 2.5 or 0) + (self.UnlockedPerks["weightboost3"] and 3.5 or 0)
			+ ((self.StatStrength or 0) * 1.53) + (self:GetNWString("ArmorType") ~= "none" and armortype["ArmorStats"]["carryweight"] or 0)
	else
		local baseweight = GAMEMODE.Config["MaxCarryWeight"]
		local perksweight = (GAMEMODE.LocalPerks["weightboost"] and 1.5 or 0) + (GAMEMODE.LocalPerks["weightboost2"] and 2.5 or 0) + (GAMEMODE.LocalPerks["weightboost3"] and 3.5 or 0)
		local skillsweight = (Perks.Strength or 0) * 1.53
		local additionalarmorweight = armorstr ~= "none" and armortype["ArmorStats"]["carryweight"] or 0
		return math.Round(baseweight + perksweight + skillsweight + additionalarmorweight, 2)
	end
end

function meta:CalculateMaxWalkWeight()
	return math.Round(self:CalculateMaxWeight() * 1.2, 2)
end

function meta:GetPlayerMoving()
	if self:GetMoveType() != MOVETYPE_NOCLIP or self:InVehicle() then
		if (self:KeyDown(IN_FORWARD) or self:KeyDown(IN_BACK) or self:KeyDown(IN_MOVELEFT) or self:KeyDown(IN_MOVERIGHT)) then
			return true
		else
			return false
		end
	end
end

function meta:SetCanSprint(cansprint)
	self:SetNWBool("cansprint", cansprint)
end

function meta:GetCanSprint()
	return self:GetNWBool("cansprint", true)
end

function meta:SkillsReset()
	if !SERVER then return false end

	local refund = 0 + self.StatPoints
	self.StatPoints = 0

	for statname, stat in pairs(GAMEMODE.StatConfigs) do
		local name = "Stat"..statname

		local statcnt = tonumber(self[name])
		local refunding = (statcnt * (stat.Cost or 1)) + (statcnt > stat.Max and (statcnt-stat.Max)*(stat.Cost or 1) or 0)
		refund = refund + refunding
		self[name] = 0
	end

	self.StatPoints = refund

	self:SetMaxHealth(GAMEMODE:CalcMaxHealth(self))
	self:SetMaxArmor(GAMEMODE:CalcMaxArmor(self))
	self:SetJumpPower(GAMEMODE:CalcJumpPower(self))
	gamemode.Call("RecalcPlayerSpeed", self)

	GAMEMODE:NetUpdatePeriodicStats(self)
	GAMEMODE:NetUpdatePerks(self)
	return true
end

-- maybe i should also do it for entity meta table
local meta_entity = FindMetaTable("Entity")

function meta_entity:SetEliteVariant(value)
	self:SetNWInt("TEA_ELITE_VARIANT", value)
end

function meta_entity:GetEliteVariant()
	return self:GetNWInt("TEA_ELITE_VARIANT", 0)
end


