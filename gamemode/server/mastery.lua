-- Mastery (? ? ?)

local meta = FindMetaTable("Player")

function meta:GainMasteryXP(amount, type)
    if type == "Melee" then
        self.MasteryMeleeXP = self.MasteryMeleeXP + amount
        if self.MasteryMeleeXP >= GetReqMasteryMeleeXP(self) then self:GainMasteryLevel("Melee") end
    elseif type == "PvP" then
        self.MasteryPvPXP = self.MasteryPvPXP + amount
        if self.MasteryPvPXP >= GetReqMasteryPvPXP(self) then self:GainMasteryLevel("PvP") end
    else return
    end
    tea_NetUpdateStatistics(self)
    net.Start("GainMasteryProgress")
    net.WriteString(type)
    net.WriteFloat(amount)
    net.Send(self)
end

function meta:GainMasteryLevel(type)
    if type == "Melee" and self.MasteryMeleeXP >= GetReqMasteryMeleeXP(self) then
        self.MasteryMeleeXP = self.MasteryMeleeXP - GetReqMasteryMeleeXP(self)
        local newlevel = self.MasteryMeleeLevel + 1
        local cashreward = math.floor(269 + (69 * newlevel) ^ 1.1869)
        self.MasteryMeleeLevel = newlevel
        self.Money = self.Money + cashreward
        SystemMessage(self, "[Mastery System] Your Mastery Melee Level is now "..newlevel.."! Gained "..cashreward.." cash.", Color(130, 255, 130, 255), false)
    elseif type == "PvP" and self.MasteryPvPXP >= GetReqMasteryPvPXP(self) then
        self.MasteryPvPXP = self.MasteryPvPXP - GetReqMasteryPvPXP(self)
        local newlevel = self.MasteryPvPLevel + 1
        local cashreward = math.floor(312 + (76 * newlevel) ^ 1.2232)
        self.MasteryPvPLevel = newlevel
        self.Money = self.Money + cashreward
        SystemMessage(self, "[Mastery System] Your Mastery PvP Level is now "..newlevel.."! Gained "..cashreward.." cash.", Color(130, 255, 130, 255), false)
    else return end
    tea_NetUpdateStatistics(self)
    tea_NetUpdatePeriodicStats(self)
end
