function GM:OnPlayerHitGround(ply, inWater, onFloater, speed)
	if not SERVER then return end

	if speed > 150 then
		local mul = math.sqrt(speed/10)
		ply:ViewPunch(Angle(math.Rand(0.9,1)*mul, 0, math.Rand(-0.3, 0.3)*mul))
	end
end

function GM:OnPlayerJump(ply, speed)
	ply:ViewPunch(Angle(-math.Rand(2, 2.2), 0, math.Rand(-0.2, 0.2)))
	if SERVER and !ply.StatsPaused then
		ply.Stamina = math.Clamp(ply.Stamina - (6 * (1 - (ply.StatEndurance * 0.045)))*ply:GetStaminaDrainWeightMul(), 0, 100)
	end
end

function GM:PlayerSwitchFlashlight(ply, on)
	if ply.Battery <= 0 and not on then return true end
	if ply.Battery < 10 and on then return false end
	if (ply:IsSleeping() or ply:IsUsingItem()) then return false end

	return true
end

function GM:PlayerSwitchWeapon(ply, old, new)
	if (ply:IsSleeping() or ply:IsUsingItem()) and new:GetClass() ~= "tea_fists" then return true end

	return false
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
	return self.UnlockedPerks and self.UnlockedPerks[perk] or CLIENT and GAMEMODE.LocalPerks[perk]
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

	local plyprestige = SERVER and self.Prestige or self:GetTEAPrestige()
	local plylevel = SERVER and self.Level or self:GetTEALevel()

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
	local lvl, xp = SERVER and self.Level or CLIENT and self:GetTEALevel() or 0
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
		if not self.LastCalculateWeightCount and (not self.LastCalculateWeightUpdate or self.LastCalculateWeightUpdate + 5 < CurTime()) then
			totalweight = self:RecalculateCurrentWeight()
		else
			totalweight = self.LastCalculateWeightCount
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

	local baseweight = GAMEMODE.Config["MaxCarryWeight"]
	local perksweight = (self:HasPerk("weightboost") and 1.5 or 0) + (self:HasPerk("weightboost2") and 2.5 or 0) + (self:HasPerk("weightboost3") and 3.5 or 0)
	-- if SERVER then
		if self.StatsPaused then return math.huge end

		return (baseweight + perksweight + ((self.StatStrength or 0) * 1.53) + (self:GetNWString("ArmorType") ~= "none" and armortype["ArmorStats"]["carryweight"] or 0)) *
		(GAMEMODE.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL and 0.9 or GAMEMODE.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE and 0.75 or 1)
	-- else
		-- local skillsweight = (Perks.Strength or 0) * 1.53
		-- local additionalarmorweight = armorstr ~= "none" and armortype["ArmorStats"]["carryweight"] or 0
		-- return math.Round(baseweight + perksweight + skillsweight + additionalarmorweight, 2)
	-- end
end

function meta:RecalculateCurrentWeight()
	local totalweight = 0

	for k, v in pairs(self.Inventory) do
		local ref = GAMEMODE.ItemsList[k]
		if !ref then ErrorNoHalt("CalculateWeight error on "..self:Nick().."! They must have a corrupt inventory (file) or something\n") continue end
		totalweight = totalweight + (ref.Weight * v)
	end

	self.LastCalculateWeightUpdate = CurTime()
	self.LastCalculateWeightCount = totalweight

	-- print(totalweight)
	return totalweight
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

function meta:GetEnduranceStaminaDrainMul()
	return 1 - self.StatEndurance*0.045
end

function meta:GetEnduranceStaminaJumpDrainMul()
	return 1 - self.StatEndurance*0.045
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

function meta:SetIsSleeping(arg)
	return self:SetNWBool("TEA.IsSleeping", arg)
end

function meta:IsSleeping()
	return self:GetNWBool("TEA.IsSleeping")
end

function meta:IsUsingItem()
	return self.UsingItemTime + self.UsingItemDuration >= CurTime()
end

function meta:IsDying()
	if GAMEMODE.GameplayDifficulty == DIFFICULTY_GAMEPLAY_HELL and self.Infection > 5000 or GAMEMODE.GameplayDifficulty == DIFFICULTY_GAMEPLAY_IMPOSSIBLE and self.Infection > 1000 then
		return true
	end

	return (self.Thirst <= 0 or self.Hunger <= 0 or self.Fatigue >= 10000 and self.Stamina <= 0 or self.Infection >= 10000)
end

function meta:GetArmorProtection(defense)
	local armorvalue = 0
	local plyarmor = self:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"].reduction) / 100)
	end

	if defense then
		armorvalue = armorvalue + (self.StatDefense*0.02) * (1 - armorvalue)
	end

	return armorvalue
end

function meta:GetArmorEnvProtection(defense)
	local armorvalue = 0
	local plyarmor = self:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"].env_reduction) / 100)
	end

	if defense then
		armorvalue = armorvalue + (self.StatDefense*0.015) *  (1 - armorvalue)
	end

	return armorvalue
end

function meta:GetArmorDamageMultiplier()
	return 1 - self:GetArmorProtection(true)
end

function meta:GetArmorEnvDamageMultiplier()
	return 1 - self:GetArmorEnvProtection(true)
end

function meta:GetArmorSpeedMultiplier()
	local speedmul = 1
	local armorstr = self:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]
	if armortype["ArmorStats"]["speedloss_percent"] then
		speedmul = 100 - armortype["ArmorStats"]["speedloss_percent"]
	end

	return speedmul
end

function meta:GetArmorCarryWeight()
	local weightbonus = 0
	local armorstr = self:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]

	if armortype and armortype["ArmorStats"].carryweight then
		weightbonus = armortype["ArmorStats"].carryweight
	end

	return weightbonus
end

function meta:GetStaminaDrainWeightMul()
	local mul = 1
	local weight = self:CalculateWeight()
	local overload = weight > self:CalculateMaxWeight()

	mul = mul + weight*0.01
	if weight < 10 then
		mul = mul * 0.9
	end

	if overload then
		mul = mul * 1.2
	end

	return mul
end

function meta:GetItemBuyCostMul(item)
	local itemtbl
	
	if isstring(item) then
		itemtbl = GAMEMODE.ItemsList[item]
	else
		itemtbl = item
	end

	if itemtbl.IgnoreCostModifiers then return 1 end

	local mul = 1 - ((self.StatBarter or 0) * 0.015)
	mul = mul * (1 + GAMEMODE:GetInflationBuyCostMul())
	mul = mul * GAMEMODE:GetEconomyDiffBuyCostMul()

	return itemtbl.IgnoreBuyCostMulLimit and mul or math.max(GAMEMODE.MinBuyCostMul, mul)
end

function meta:GetItemSellCostMul(item)
	local itemtbl
	
	if isstring(item) then
		itemtbl = GAMEMODE.ItemsList[item]
	else
		itemtbl = item
	end

	if itemtbl.IgnoreCostModifiers then return 0.2 end

	local mul = 0.2 + ((self.StatBarter or 0) * 0.005)
	mul = mul * (1 + GAMEMODE:GetInflationSellCostMul())
	mul = mul * GAMEMODE:GetEconomyDiffSellCostMul()

	return itemtbl.IgnoreSellCostMulLimit and mul or math.max(GAMEMODE.MaxSellCostMul, mul)
end

function meta:AddStatisticPoints(var, value)
	if not self.Statistics[var] then self.Statistics[var] = 0 end
	self.Statistics[var] = self.Statistics[var] + value
end

function meta:SetStatisticPoint(var, value)
	self.Statistics[var] = value
end

function meta:GetStatisticPoints(var, value)
	return self.Statistics[var] or 0
end

function meta:AddLifeStatisticPoints(var, value)
	if not self.LifeStats[var] then self.LifeStats[var] = 0 end
	self.LifeStats[var] = self.LifeStats[var] + value
end

function meta:SetLifeStatisticPoint(var, value)
	self.LifeStats[var] = value
end

function meta:GetLifeStatisticPoints(var, value)
	return self.LifeStats[var] or 0
end

function meta:GetMaxBattery()
	local armorstr = self:GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]

	return 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0)
end

-- maybe i should also do it for entity meta table
local meta_entity = FindMetaTable("Entity")

function meta_entity:SetEliteVariant(value)
	self:SetNWInt("TEA_ELITE_VARIANT", value)
end

function meta_entity:GetEliteVariant()
	return self:GetNWInt("TEA_ELITE_VARIANT", 0)
end

function meta_entity:SetZombieLevel(int)
	self:SetNWInt("TEA.Zlvl", math.floor(int))
end

function meta_entity:GetZombieLevel()
	return self:GetNWInt("TEA.Zlvl", 10)
end


