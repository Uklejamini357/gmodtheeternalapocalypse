HUD.Name = "Classic"

local draw_DrawText = draw.DrawText
local draw_SimpleText = draw.SimpleText
local draw_RoundedBox = draw.RoundedBox
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawRectColor = surface.DrawRectColor
local surface_DrawOutlinedRect = surface.DrawOutlinedRect

function HUD:DrawHealth(pl, w, h, swep)
    local hp = pl:Health()
    local mhp = pl:GetMaxHealth()
    local ap = pl:Armor()
    local map = pl:GetMaxArmor()
    local cansprint = pl:GetCanSprint()

---------------- HEALTH ----------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 200, 200, 8)
    draw_SimpleText(translate.Format("health", hp, mhp), "TEA.HUDFontSmall", 21, h - 210, Color(205,205,205,255), 0, 1)

    surface_DrawRectColor(20, h - 200, 200, 8, Color(50,0,0,210))
    if hp > 0 then
        local hpbarclamp = math.Clamp(200 * (hp / mhp), 0, 200)
        surface_DrawRectColor(20, h - 200, hpbarclamp, 4, Color(150,0,0,210))
        surface_DrawRectColor(20, h - 196, hpbarclamp, 4, Color(150,0,0,150))
    end

---------------- ARMOR ----------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 170, 200, 8)
    draw_SimpleText(translate.Format("armor", ap, map), "TEA.HUDFontSmall", 21, h - 180, Color(205,205,205,255),0,1)
    surface_DrawRectColor(20, h - 170, 200, 8, Color(0,0,50,210))
    if ap > 0 then
        local armorbarclamp = math.Clamp(200 * (ap / map), 0, 200)
        surface_DrawRectColor(20, h - 170, armorbarclamp, 4, Color(0,0,150,210))
        surface_DrawRectColor(20, h - 166, armorbarclamp, 4, Color(0,0,150,150))
    end

---------------- AMMO ----------------
    if swep then
        if (swep.AmmoClip1 != -1 or swep.AmmoClip2 != -1) then
            IsAmmoBox = true
            --Ammo Text
            if (swep.AmmoClip2 != -1) then
                draw_SimpleText("Ammo in Clip: ".. swep.AmmoClip1 .." / ".. swep.AmmoClip2, "TEA.HUDFontSmall", 270, h - 210, Color(205,205,205,255), 0, 1) 
            else
                draw_SimpleText("Ammo in Clip: ".. swep.AmmoClip1, "TEA.HUDFontSmall", 270, h - 210, Color(205,205,205,255), 0, 1) 
            end
            --Second Clip Ammo Text
            draw_SimpleText("Ammo Remaining: ".. swep.MaxAmmoType, "TEA.HUDFontSmall", 270, h - 192, Color(205,205,205,255), 0, 1)
            --Alt ammo Text
            draw_SimpleText("ALT: ".. swep.MaxAmmoType2, "TEA.HUDFontSmall", 270, h - 174, Color(205,205,205,255), 0, 1)
        else IsAmmoBox = false end
    end
-------------- EXperience --------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(w - 250, h - 50, 200, 8)
    draw_SimpleText(Format("XP: %s/%s (%s%%)", math.floor(MyXP), pl:GetReqXP(), math.Round(math.floor(MyXP) * 100 / pl:GetReqXP())), "TEA.HUDFontSmall", w - 250, h - 60, Color(205, 205, 205, 255), 0, 1)
    surface_DrawRectColor(w - 250, h - 50, 200, 8, Color(50,0,0,75))

    local xpbarclamp = math.Clamp(200 * (MyXP / pl:GetReqXP()), 0, 200)
    surface_DrawRectColor(w - 250, h - 50, xpbarclamp, 8, Color(150,0,0,160))

-------------- Stamina -------------- 
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 140, 200, 8)
    draw_SimpleText(translate.Format("stamina", math.Round(pl.Stamina, GAMEMODE.HUDDecimalValues and 1 or 0)), "TEA.HUDFontSmall", 20, h - 150, Color(205,205,205,255), 0, 1)
    surface_DrawRectColor(20, h - 140, 200, 8, Color(50,50,0,75))
    if pl.Stamina > 0 then
        local staminabarclamp = math.Clamp(pl.Stamina * 2, 0, 200)
        surface_DrawRectColor(20, h - 140, staminabarclamp, 4, Color(250, 200, 0, 160))
        surface_DrawRectColor(20, h - 136, staminabarclamp, 4, Color(220, 170, 0, 160))
    end
-------------- Thirst --------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 110, 200, 8)
    draw_SimpleText(translate.Format("thirst", math.Round(pl.Thirst / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TEA.HUDFontSmall", 20, h - 120, Color(205,205,205,255), 0, 1)
    surface_DrawRectColor(20, h - 110, 200, 8, Color(50,75,100,75))
    if pl.Thirst > 0 then
        local thirstbarclamp = math.Clamp(pl.Thirst / 50, 0, 200)
        surface_DrawRectColor(20, h - 110, thirstbarclamp, 4, Color(100,150,200,160))
        surface_DrawRectColor(20, h - 106, thirstbarclamp, 4, Color(90,135,180,160))
    end

-------------- Hunger --------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 80, 200, 8)
    draw_SimpleText(translate.Format("hunger", math.Round(pl.Hunger / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TEA.HUDFontSmall", 20, h - 90, Color(205,205,205,255), 0, 1)
    surface_DrawRectColor(20, h - 80, 200, 8, Color(0,50,0,75))
    if pl.Hunger > 0 then
        local hungerbarclamp = math.Clamp(pl.Hunger / 50, 0, 200)
        surface_DrawRectColor(20, h - 80, hungerbarclamp, 4, Color(0,100,0,160))
        surface_DrawRectColor(20, h - 76, hungerbarclamp, 4, Color(0,100,0,160))
    end

-------------- Fatigue --------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 50, 200, 8)
    draw_SimpleText(translate.Format("fatigue", math.Round(pl.Fatigue / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TEA.HUDFontSmall", 20, h - 60, Color(205,205,205,255), 0, 1)
    surface_DrawRectColor(20, h - 50, 200, 8, Color(75,75,75,75))
    if pl.Fatigue > 0 then
        local fatiguebarclamp = math.Clamp(pl.Fatigue / 50, 0, 200)
        surface_DrawRectColor(20, h - 50, fatiguebarclamp, 4, Color(250,250,250,160))
        surface_DrawRectColor(20, h - 46, fatiguebarclamp, 4, Color(200,200,250,160))
    end

-------------- Infection --------------
    surface_SetDrawColor(0, 0, 0, 255)
    surface_DrawOutlinedRect(20, h - 20, 200, 8)
    draw_SimpleText(translate.Format("infection", math.Round(pl.Infection / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TEA.HUDFontSmall", 20, h - 30, Color(205,205,205,255), 0, 1)
    surface_DrawRectColor(20, h - 20, 200, 8, Color(75,0,0,75))
    if pl.Infection > 0 then
        local infectionbarclamp = math.Clamp(pl.Infection / 50, 0, 200)
        surface_DrawRectColor(20, h - 20, infectionbarclamp, 4, Color(200,100,100,160))
        surface_DrawRectColor(20, h - 16, infectionbarclamp, 4, Color(160,80,80,160))
    end

----------------Levels, cash, prestige & time survived----------------
    draw_SimpleText(translate.Format("prestige", math.floor(pl:GetTEAPrestige())), "TEA.HUDFontSmall", 270, h - 140, Color(205,205,205,255), 0, 1)
    draw_SimpleText(translate.Format("level", math.floor(pl:GetTEALevel())), "TEA.HUDFontSmall", 270, h - 122, Color(205,205,205,255), 0, 1)
    draw_SimpleText(translate.Format("money", math.floor(pl.Money)), "TEA.HUDFontSmall", 270, h - 104, Color(205,205,205,255), 0, 1)
    draw_SimpleText(translate.Format("bounty", math.floor(MyBounty)), "TEA.HUDFontSmall", 270, h - 86, Color(205, 205, 205, 255), 0, 1)
end

function HUD:DrawPVP(pl, state, w, h)
    draw_SimpleText("PvP: "..translate.Get("pvp_state"..state), "TEA.HUDFontSmall", 270, h - 30, Color(205,205,205), 0, 0)
end

function HUD:DrawDead(pl, w, h, Spawn)
    local a = 205

    local message
    draw_DrawText("You died", "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 - 40, Color(230,115,115,a), TEXT_ALIGN_CENTER)
    draw_DrawText("Cause of death: "..GAMEMODE.DeathMessage, "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 - 180, Color(230,230,230,a), TEXT_ALIGN_CENTER)

    local survtime,bsurvtime = math.floor(GAMEMODE.MyLastSurvivalStats.SurvivalTime), math.floor(GAMEMODE.MyLastSurvivalStats.BestSurvivalTime) 

    draw_DrawText(Format(bsurvtime < survtime and "Survival Time: %s (Previous Best: %s, +%s)" or "Survival Time: %s", util.ToMinutesSeconds(survtime), util.ToMinutesSeconds(bsurvtime), util.ToMinutesSeconds(survtime - bsurvtime)),
    "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 20, Color(230,230,230,a), TEXT_ALIGN_CENTER)
    draw_DrawText(Format("Zombies killed: %d", GAMEMODE.MyLastSurvivalStats.ZombieKills), "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 44, Color(230,230,230,a), TEXT_ALIGN_CENTER)
    draw_DrawText(Format("Players killed: %d", GAMEMODE.MyLastSurvivalStats.PlayerKills), "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 68, Color(230,230,230,a), TEXT_ALIGN_CENTER)

    message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
    draw_DrawText(message, "TEA.HUDFont", ScrW() / 2, ScrH() / 2 - 200, Color(255,255,255), TEXT_ALIGN_CENTER)
end
