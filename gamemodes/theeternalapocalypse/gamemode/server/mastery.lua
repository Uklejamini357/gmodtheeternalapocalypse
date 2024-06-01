-- Mastery (? ? ?)

local meta = FindMetaTable("Player")

function meta:GainMasteryXP(amount, type)
    if type == "Melee" then
        self.MasteryMeleeXP = self.MasteryMeleeXP + amount
        if self.MasteryMeleeXP >= self:GetReqMasteryMeleeXP() then self:GainMasteryLevel("Melee") end
    elseif type == "PvP" then
        self.MasteryPvPXP = self.MasteryPvPXP + amount
        if self.MasteryPvPXP >= self:GetReqMasteryPvPXP() then self:GainMasteryLevel("PvP") end
    else return
    end
    GAMEMODE:NetUpdateStatistics(self)
    net.Start("GainMasteryProgress")
    net.WriteString(type)
    net.WriteFloat(amount)
    net.Send(self)
end

function meta:GainMasteryLevel(type)
    if type == "Melee" and self.MasteryMeleeXP >= self:GetReqMasteryMeleeXP() then
        self.MasteryMeleeXP = self.MasteryMeleeXP - self:GetReqMasteryMeleeXP()
        local newlevel = self.MasteryMeleeLevel + 1
        local cashreward = math.floor(269 + (69 * newlevel) ^ 1.1869)
        self.MasteryMeleeLevel = newlevel
        self.Money = self.Money + cashreward
        self:SystemMessage("[Mastery System] Your Mastery Melee Level is now "..newlevel.."! Gained "..cashreward.." cash.", Color(130, 255, 130, 255), false)
    elseif type == "PvP" and self.MasteryPvPXP >= self:GetReqMasteryPvPXP() then
        self.MasteryPvPXP = self.MasteryPvPXP - self:GetReqMasteryPvPXP()
        local newlevel = self.MasteryPvPLevel + 1
        local cashreward = math.floor(312 + (76 * newlevel) ^ 1.2232)
        self.MasteryPvPLevel = newlevel
        self.Money = self.Money + cashreward
        self:SystemMessage("[Mastery System] Your Mastery PvP Level is now "..newlevel.."! Gained "..cashreward.." cash.", Color(130, 255, 130, 255), false)
    else return end
    GAMEMODE:NetUpdateStatistics(self)
    GAMEMODE:NetUpdatePeriodicStats(self)
end
