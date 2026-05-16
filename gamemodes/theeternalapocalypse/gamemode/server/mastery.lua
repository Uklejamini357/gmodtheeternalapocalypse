-- Mastery (? ? ?)

local meta = FindMetaTable("Player")

function meta:GainMasteryXP(amount, mType)
    if !self.MasterySkills[mType] then return end
    if !amount then return end

    self.MasterySkills[mType].XP = (self.MasterySkills[mType].XP or 0) + amount
    if self.MasterySkills[mType].XP >= self:GetReqMasteryXP(mType) then
        self:GainMasteryLevel(mType)
    end

    net.Start("GainMasteryProgress")
    net.WriteString(mType)
    net.WriteFloat(amount)
    net.Send(self)
end

function meta:GainMasteryLevel(mType)
    local mtbl = GAMEMODE.MasterySkillStats[mType]
    if !mtbl then return end

    if self.MasterySkills[mType].XP < self:GetReqMasteryXP(mType) then return end
    self.MasterySkills[mType].XP = self.MasterySkills[mType].XP - self:GetReqMasteryXP(mType)
    
    local oldlevel = self.MasterySkills[mType].Level
    local newlevel = oldlevel + 1
    local cashreward = mtbl.CashGain and mtbl:CashGain(self, newlevel) or 0

    self.MasterySkills[mType].Level = newlevel
    self.Money = self.Money + cashreward

    mtbl:OnLevelup(self, oldlevel, newlevel)

    self:AddStatisticPoints("CashGainedByMastery", cashreward)

    GAMEMODE:NetUpdatePeriodicStats(self)
end
