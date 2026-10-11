-- metatables time...
local t = {}
local meta = {}
meta.__index = t
meta.__tostring = function(t)
    return t:FormatText()
end

function t:Create(n)
    local base = {}
    base = setmetatable(base, meta)

    return base
end

GM.StatusEffectsTable = {}

function GM:AddStatusEffect(id, name, desc, tbl)
    self.StatusEffectsTable[id] = t:Create()

    table.Merge(self.StatusEffectsTable[id], tbl)
end


-- arg#1: id for the status, arg#2: name for it, arg#3: description, arg#4: table
GM:AddStatusEffect("bleeding", "Bleeding", "Drains health over time. The longer the expected duration, the more negative effects this can have.", {
    BarColor = Color(255,0,0), -- Color for the bar on HUD
    BGColor = Color(220,0,0), -- Background color
    TextColor = Color(255,255,255), -- Text color for status
    Icon = nil, -- If nil, does not display any icon by the bar
    IconColor = Color(255,60,60), -- No effect if the above is nil
    Percentage = false, -- Determines if the status effect is based on percentage instead of duration. If true, status effect remains permanent until certain functionality removes it.
    Max = 120, -- Expected max duration of the status effect (can always go above it either way)
    PersistAfterDeath = false, -- Whether or not should the effect be used
    OnGet = function(ent, duration) -- Called when an entity gets a status effect
    end,
    OnRemove = function(ent, expired) -- When an effect expires or gets removed
    end,
    Tick = function(ent) -- Ticks every second.
    end,
    Think = function(ent) -- Same as above, but for every server tick instead.
    end,
    GetStrength = function(ent)
        return 1
    end
})

GM:AddStatusEffect("poison", "Poisoned", "Drains health over time. ", {
    BarColor = Color(0,255,0),
    BGColor = Color(60,255,0),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(120,255,60),
    Percentage = false,
    Max = 120,
    PersistAfterDeath = false,
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})



-- Air quality and stats


GM:AddStatusEffect("goodair", "Fresh Air", "The good ol' outdoor air before the virus outbreak even started...\n+10% to stamina regeneration and -6% stamina drain", {
    BarColor = Color(110,220,255),
    BGColor = Color(60,120,255),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(255,255,255),
    Max = 0, -- 0 means can't expire
    StatsAffect = {
        Stamina = {},
    },
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})

GM:AddStatusEffect("badair", "Toxic Air", "It's getting harder to breathe... A gas mask or closed-cycle respiration module can negate this effects.\n0.1dmg/s taken\n+25% stamina drain", {
    BarColor = Color(255,0,0),
    BGColor = Color(220,0,0),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(255,60,60),
    Max = 0,
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})

GM:AddStatusEffect("undergroundair", "Underground Air", "In a damp, enclosed environment. The air contains dust, making breathing uncomfortable.\nA gas mask or closed-cycle respiration module can negate this effects.\n-15% stamina regeneration", {
    BarColor = Color(255,0,0),
    BGColor = Color(220,0,0),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(255,60,60),
    Max = 0,
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})

GM:AddStatusEffect("winds", "Winds", "Exposed to strong winds.\n", {
    BarColor = Color(255,0,0),
    BGColor = Color(220,0,0),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(255,60,60),
    Max = 0,
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})

--[[
GM:AddStatusEffect("wet", "Wet", "", {
    BarColor = Color(0,0,255),
    BGColor = Color(40,40,255),
    TextColor = Color(255,255,255),
    Icon = nil,
    IconColor = Color(80,80,255),
    Max = 0,
    OnGet = function(ent, duration)
    end,
    OnRemove = function(ent, expired)
    end,
    Tick = function(ent)
    end,
    Think = function(ent)
    end,
    GetStrength = function(ent)
        return 1
    end
})
]]
