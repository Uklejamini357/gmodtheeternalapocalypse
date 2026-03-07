HUD.Name = "The Eternal Apocalypse"

local draw_DrawText = draw.DrawText
local draw_SimpleText = draw.SimpleText
local draw_RoundedBox = draw.RoundedBox
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
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
    draw_SimpleText(string.upper(translate.Format("health", hp, mhp)), "TEA.HUDFontSmall", 21, h - 96, Color(255,255,255), 0, 1)
    draw_SimpleText(string.upper(translate.Format("armor", ap, map)), "TEA.HUDFontSmall", 21, h - 80, Color(255,255,255), 0, 1)

    draw_SimpleText(translate.Format("prestige", math.floor(pl:GetTEAPrestige())), "TEA.HUDFontSmall", 21, h - 60, Color(255,255,255), 0, 1)
    draw_SimpleText(translate.Format("level", math.floor(pl:GetTEALevel())), "TEA.HUDFontSmall", 21, h - 44, Color(255,255,255), 0, 1)
    draw_SimpleText(translate.Format("money", math.floor(MyMoney)), "TEA.HUDFontSmall", 21, h - 28, Color(255,255,255), 0, 1)

    surface_DrawRectColor(216, h - 108, 192, 100, Color(255,255,255,65))
    surface_DrawRectColor(w - 208, h - 108, 192, 100, Color(255,255,255,65))
    draw_SimpleText(translate.Format("stamina", math.Round(pl.Stamina, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 100, Color(255,255,255), 0, 1)
    draw_SimpleText(translate.Format("thirst", math.Round(pl.Thirst / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 84, Color(255, 205, 255, 255), 0, 1)
    draw_SimpleText(translate.Format("hunger", math.Round(pl.Hunger / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 68, Color(155,155,255,255), 0, 1)
    draw_SimpleText(translate.Format("fatigue", math.Round(pl.Fatigue / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 52, Color(205,205,255,255), 0, 1)
    draw_SimpleText(translate.Format("infection", math.Round(pl.Infection / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, h - 36, Color(205, 105, 105, 255), 0, 1)
end


function HUD:DrawDead(pl, w, h, Spawn)
    local a = 205

    local message
    draw_DrawText("You died", "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 - 40, Color(230,115,115,a), TEXT_ALIGN_CENTER)
    draw_DrawText("Cause of death: "..GAMEMODE.DeathMessage, "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 - 180, Color(230,230,230,a), TEXT_ALIGN_CENTER)

    local survtime,bsurvtime = math.floor(GAMEMODE.MyLastSurvivalStats.SurvivalTime), math.floor(GAMEMODE.MyLastSurvivalStats.BestSurvivalTime)

    draw_DrawText(Format(bsurvtime < survtime and "Survival Time: %s (Previous Best: %s, +%s)" or "Survival Time: %s", util.ToMinutesSeconds(survtime), util.ToMinutesSeconds(bsurvtime), util.ToMinutesSeconds(survtime - bsurvtime)),
    "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 20, Color(230,230,230,a), TEXT_ALIGN_CENTER)
    draw_DrawText(Format("Zombies killed: %d", GAMEMODE.MyLastSurvivalStats.ZombieKills), "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 44, Color(230,230,230,a), TEXT_ALIGN_CENTER)
    draw_DrawText(Format("Players killed: %d", GAMEMODE.MyLastSurvivalStats.PlayerKills), "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 68, Color(230,230,230,a), TEXT_ALIGN_CENTER)

    message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
    draw_DrawText(message, "TEA.HUDFont", ScrW() / 2, ScrH() / 2 - 200, Color(255,255,255), TEXT_ALIGN_CENTER)
end
