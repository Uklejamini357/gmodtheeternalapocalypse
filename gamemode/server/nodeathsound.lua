hook.Add("PlayerDeathSound", "DeFlatline", function() return true end)
local noise = Sound("common/null.wav") --feel free to edit it
hook.Add("PlayerDeath", "NewSound", function(vic,unused1,unused2)
vic:EmitSound(noise)
end)
