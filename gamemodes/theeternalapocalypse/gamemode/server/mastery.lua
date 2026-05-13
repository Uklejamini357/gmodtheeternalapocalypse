-- Mastery (? ? ?)

local meta = FindMetaTable("Player")

function meta:GainMasteryXP(amount, mType)
    self.MasterySkills[mType].XP = self.MasterySkills[mType].XP + amount
    if self.MasterySkills[mType].XP >= self:GetReqMasteryXP(mType) then
        self:GainMasteryLevel(mType)
    end

    net.Start("GainMasteryProgress")
    net.WriteString(mType)
    net.WriteFloat(amount)
    net.Send(self)
end

function meta:GainMasteryLevel(mType)
    if self.MasterySkills[mType].XP < self:GetReqMasteryXP(mType) then return end
    self.MasterySkills[mType].XP = self.MasterySkills[mType].XP - self:GetReqMasteryXP(mType)
    
    local newlevel = self.MasterySkills[mType].Level + 1
    local cashreward = math.floor(269 + (69 * newlevel) ^ 1.1869)
    -- cashreward = math.floor(312 + (76 * newlevel) ^ 1.2232) -- PVP

    self.MasterySkills[mType].Level = newlevel
    self.Money = self.Money + cashreward
    self:SystemMessage("[Mastery System] Your Mastery Melee Level is now "..newlevel.."! Gained "..cashreward.." cash.", Color(130, 255, 130, 255), false)

    self:AddStatisticPoints("CashGainedByMastery", cashreward)

    GAMEMODE:NetUpdatePeriodicStats(self)
end
