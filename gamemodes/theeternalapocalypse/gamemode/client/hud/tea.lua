HUD.Name = "The Eternal Apocalypse"

local draw_DrawText = draw.DrawText
local draw_RoundedBox = draw.RoundedBox
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawRectColor = surface.DrawRectColor

function HUD:DrawHealth(pl, w, h, swep)
    local hp = pl:Health()
    local mhp = pl:GetMaxHealth()
    local ap = pl:Armor()
    local map = pl:GetMaxArmor()
    local cansprint = pl:GetCanSprint()

    surface_DrawRectColor(16, h - 108, 192, 100, Color(255,255,255,65))
    draw.SimpleText(string.upper(translate.Format("health", hp, mhp)), "TEA.HUDFontSmall", 21, h - 96, Color(255,255,255), 0, 1)
    draw.SimpleText(string.upper(translate.Format("armor", ap, map)), "TEA.HUDFontSmall", 21, h - 80, Color(255,255,255), 0, 1)

    draw.SimpleText(translate.Format("prestige", math.floor(pl:GetTEAPrestige())), "TEA.HUDFontSmall", 21, h - 60, Color(255,255,255), 0, 1)
    draw.SimpleText(translate.Format("level", math.floor(pl:GetTEALevel())), "TEA.HUDFontSmall", 21, h - 44, Color(255,255,255), 0, 1)
    draw.SimpleText(translate.Format("money", math.floor(MyMoney)), "TEA.HUDFontSmall", 21, h - 28, Color(255,255,255), 0, 1)

    surface_DrawRectColor(216, h - 108, 192, 100, Color(255,255,255,65))
    surface_DrawRectColor(w - 208, h - 108, 192, 100, Color(255,255,255,65))
    draw.SimpleText(translate.Format("stamina", math.Round(pl.Stamina, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 100, Color(255,255,255), 0, 1)
    draw.SimpleText(translate.Format("thirst", math.Round(pl.Thirst / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 84, Color(255, 205, 255, 255), 0, 1)
    draw.SimpleText(translate.Format("hunger", math.Round(pl.Hunger / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 68, Color(155,155,255,255), 0, 1)
    draw.SimpleText(translate.Format("fatigue", math.Round(pl.Fatigue / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 52, Color(205,205,255,255), 0, 1)
    draw.SimpleText(translate.Format("infection", math.Round(pl.Infection / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 36, Color(205, 105, 105, 255), 0, 1)
    draw.SimpleText(translate.Format("battery", math.Clamp(pl.Battery, 0, math.huge), pl:GetMaxBattery()), "TargetIDTiny", 224, h - 20, Color(5,5,255,255), 0, 1)
end

