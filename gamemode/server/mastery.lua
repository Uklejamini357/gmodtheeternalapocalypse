--Mastery levels in progress

function GainMasteryXP(ply, amount, type)
    if type == "Melee" then
        ply.MasteryMeleeXP = ply.MasteryMeleeXP + amount
    elseif type == "PvP" then
        ply.MasteryPvPXP = ply.MasteryPvPXP + amount
    end
end

function GainMasteryLevel(ply, type)
    if type == "Melee" then
        ply.MasteryMeleeLevel = ply.MasteryMeleeLevel + 1
    elseif type == "PvP" then
        ply.MasteryPvPLevel = ply.MasteryPvPLevel + 1
    end
end
