HUD.Name = "After The End"

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
    draw_RoundedBox(1, 10, h - 110, 180, 100, Color(0, 0, 0, 175))
    surface_SetDrawColor(90, 0, 0, 255)
    surface_DrawOutlinedRect(10, h - 110, 180, 100)
    draw_SimpleText(translate.Format("health", hp, mhp), "TEA.HUDFontSmall", 21, h - 96, Color(math.Clamp(255 * (hp / mhp), 127, 255),48,48,255), 0, 1)
    draw_RoundedBox(2, 20, h - 86, 160, 20, Color(50, 0, 0, 160))
    if hp > 0 then
        local hpbarclamp = math.Clamp(160 * (hp / mhp), 0, 160)
        draw_RoundedBox(4, 20, h - 86, hpbarclamp, 20, Color(150, 0, 0, 160))
        draw_RoundedBox(4, 20, h - 86, hpbarclamp, 10, Color(150, 0, 0, 100))
    end

---------------- ARMOR ----------------
    draw_SimpleText(translate.Format("armor", ap, map), "TEA.HUDFontSmall", 21, h - 50, Color(48,48,math.Clamp(255 * (ap / map), 127, 255),255), 0, 1)
    draw_RoundedBox(2, 20, h - 36, 160, 20, Color(0, 0, 50, 160))
    if ap > 0 then
        local armorbarclamp = math.Clamp(160 * (ap / map),0,160)
        draw_RoundedBox(4,20, h - 36, armorbarclamp,20,Color(0,0,150,160))
        draw_RoundedBox(4,20, h - 36, armorbarclamp,10,Color(0,0,150,160))
    end

    surface_DrawRectColor(58, h - 36,4,20, Color(0,0,0,255))
    surface_DrawRectColor(98, h - 36,4,20, Color(0,0,0,255))
    surface_DrawRectColor(138, h - 36,4,20, Color(0,0,0,255))
    surface_DrawOutlinedRect(20, h - 36,160,20)
    surface_DrawOutlinedRect(19, h - 37,162,22)


-------------- EXperience --------------

    draw_RoundedBox(1, w - 270, h - 60, 250, 50, Color(0, 0, 0, 175))
    surface_SetDrawColor(90, 90, 0, 255)
    surface_DrawOutlinedRect(w - 270, h - 60, 250, 50)

    draw_SimpleText(Format("XP: %s/%s (%s%%)", math.floor(MyXP), pl:GetReqXP(), math.Round(math.floor(MyXP) * 100 / pl:GetReqXP())), "TEA.HUDFontSmall", w - 259, h - 48, Color(255, 255, 255, 255), 0, 1)
    draw_RoundedBox(2, w - 250, h - 36, 210, 20, Color(50, 0, 0, 160))
    draw_RoundedBox(4, w - 250, h - 36, math.Clamp(210 * (MyXP / pl:GetReqXP()), 0, 210), 20, Color(150, 0, 0, 160))

    draw_RoundedBox(1, 200, h - 200, 180, 190, Color(0, 0, 0, 175))
    surface_SetDrawColor(125, 125, 55, 255)
    surface_DrawOutlinedRect(200, h - 200, 180, 190)

-------------- Stamina --------------
    draw_SimpleText(translate.Format("stamina", math.Round(pl.Stamina, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, h - 186, !cansprint and Color(255, 155, 105) or Color(205, 255, 205), 0, 1)
    draw_RoundedBox(2, 210, h - 176, 160, 15, Color((!cansprint and 200 or 50), 50, 0, 100))
    if pl.Stamina > 0 then
        local staminabarclamp = math.Clamp(pl.Stamina * 1.6, 0, 160)
        draw_RoundedBox(4, 210, h - 176, staminabarclamp, 15, Color(!cansprint and 200 or 100, 150, 0, 160))
        draw_RoundedBox(4, 210, h - 176, staminabarclamp, 8, Color(!cansprint and 200 or 100, 150, 0, 160))
    end

-------------- Hunger --------------
    draw_SimpleText(translate.Format("hunger", math.Round(pl.Hunger / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, h - 150, Color(255, 205, 255, 255), 0, 1)
    draw_RoundedBox(2, 210, h - 140, 160, 15, Color(50, 0, 50, 100))
    if (pl.Hunger / 100) > 0 then
        local hungerbarclamp = math.Clamp((pl.Hunger / 100) * 1.6, 0, 160)
        draw_RoundedBox(4, 210, h - 140, hungerbarclamp, 15, Color(90, 0, 120, 160))
        draw_RoundedBox(4, 210, h - 140, hungerbarclamp, 8, Color(120, 0, 120, 80))
    end

-------------- Thirst --------------
    draw_SimpleText(translate.Format("thirst", math.Round(pl.Thirst / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, h - 114, Color(155,155,255,255), 0, 1)
    draw_RoundedBox(2, 210, h - 104, 160, 15, Color(45, 45, 75, 100))
    if (pl.Thirst / 100) > 0 then
        local thirstbarclamp = math.Clamp((pl.Thirst / 100) * 1.6, 0, 160)
        draw_RoundedBox(4, 210, h - 104, thirstbarclamp, 15, Color(155,155,255,255))
        draw_RoundedBox(4, 210, h - 104, thirstbarclamp, 8, Color(155,155,255,255))
    end

-------------- Fatigue --------------
    draw_SimpleText(translate.Format("fatigue", math.Round(pl.Fatigue / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, h - 78, Color(205,205,255,255), 0, 1)
    draw_RoundedBox(2, 210, h - 68, 160, 15, Color(0, 50, 50, 100))
    if (pl.Fatigue / 100) > 0 then
        local fatiguebarclamp = math.Clamp((pl.Fatigue / 100) * 1.6, 0, 160)
        draw_RoundedBox(4, 210, h - 68, fatiguebarclamp, 15, Color(0, 80, 80, 160))
        draw_RoundedBox(4, 210, h - 68, fatiguebarclamp, 8, Color(0, 100, 100, 80))
    end

-------------- Infection --------------
    draw_SimpleText(translate.Format("infection", math.Round(pl.Infection / 100, GAMEMODE.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, h - 42, Color(205, 105, 105, 255), 0, 1)
    draw_RoundedBox(2, 210, h - 32, 160, 15, Color(80, 0, 0, 100))
    if (pl.Infection / 100) > 0 then
        local infectionbarclamp = math.Clamp((pl.Infection / 100) * 1.6, 0, 160)
        draw_RoundedBox(4, 210, h - 32, infectionbarclamp, 15, Color(250, 0, 0, 160))
        draw_RoundedBox(4, 210, h - 32, infectionbarclamp, 8, Color(50, 0, 0, 100))
    end

----------------Levels, cash & prestige----------------

    draw_RoundedBox(1, 10, h - 200, 180, 85, Color(0, 0, 0, 175))
    surface_SetDrawColor(55, 55, 155, 255)
    surface_DrawOutlinedRect(10, h - 200, 180, 85)
    draw_SimpleText(translate.Format("bounty", math.floor(MyBounty)), "TEA.HUDFontSmall", 20, h - 187, Color(155, math.Clamp(127 - (MyBounty / 60), 0, 255), math.Clamp(255 - (MyBounty / 30), 0, 255)), 0, 1)
    draw_SimpleText(translate.Format("prestige", math.floor(pl:GetTEAPrestige())), "TEA.HUDFontSmall", 20, h - 168, Color(205,155,255), 0, 1)
    draw_SimpleText(translate.Format("level", math.floor(pl:GetTEALevel())), "TEA.HUDFontSmall", 20, h - 149, Color(200,200,200), 0, 1)
    draw_SimpleText(translate.Format("money", math.floor(MyMoney)), "TEA.HUDFontSmall", 20, h - 130, Color(0,255,255), 0, 1)
end

function HUD:DrawSwep(pl, w, h, swep)
    if swep then
        if (swep.MaxAmmoType != 0 or swep.MaxAmmoType2 != 0 or swep.AmmoClip1 > 0 or swep.AmmoClip2 > 0) then
            IsAmmoBox = true
            --Ammo Box
            draw_RoundedBox(1, w - 270, h - 140, 250, 70, Color(0, 0, 0, 175))
            surface_SetDrawColor(200, 100, 0, 255)
            surface_DrawOutlinedRect(w - 270, h - 140, 250, 70)

            --Ammo Text
            if (swep.AmmoClip2 != -1) then
                draw_SimpleText("Ammo in Clip: ".. swep.AmmoClip1 .." / ".. swep.AmmoClip2, "TEA.HUDFontSmall", w - 259, h - 110, Color(255, 255, 255, 255), 0, 1)
            else
                draw_SimpleText("Ammo in Clip: ".. swep.AmmoClip1, "TEA.HUDFontSmall", w - 259, h - 110, Color(255, 255, 255, 255), 0, 1) 
            end

            --Ammo bar base
            draw_RoundedBox(2, w - 252, h - 98, 140, 20, Color(150, 100, 0, 100))

            --Second Clip Ammo Text
            draw_SimpleText("Ammo Remaining: ".. swep.MaxAmmoType, "TEA.HUDFontSmall", w - 259, h - 130, Color(255, 255, 255, 255), 0, 1)

            --Alt ammo Text
            draw_SimpleText("ALT: ".. swep.MaxAmmoType2, "TEA.HUDFontSmall", w - 89, h - 90, Color(255, 255, 255, 255), 0, 1)


            if swep.AmmoClip1 > 0 then
                --Ammo Bar
                draw_RoundedBox(4, w - 252, h - 98, math.min(140, 140 * (swep.AmmoClip1 / swep.MaxAmmoClip1)), 20, Color(200, 110, 0, 200))
                draw_RoundedBox(4, w - 252, h - 98, math.min(140, 140 * (swep.AmmoClip1 / swep.MaxAmmoClip1)), 10, Color(200, 150, 0, 50))
            end
        else
            IsAmmoBox = false
        end
    end

end

function HUD:DrawPVP(pl, state, w, h)
    if state == 4 or state == 5 then    
        surface_SetDrawColor(100,0,0,175)
    else
        surface_SetDrawColor(0,0,0,200)
    end
    surface_DrawRect(140, 80, 180, 27)
    surface_SetDrawColor(40,0,40)
    surface_DrawOutlinedRect(140, 80, 180, 27)

    draw_SimpleText("PvP: "..translate.Get("pvp_state"..state), "TEA.HUDFontSmall", 180, 86, Color(205,205,205), 0, 0)
    if state == 2 or state == 3 or state == 4 then
        draw_SimpleTextOutlined("C", "CSSTextFont", 135, 85, Color(255, 50, 0), 0, 0, 2, Color(50, 0, 0))
    elseif state == 1 then
        draw_SimpleTextOutlined("p", "CSSTextFont", 145, 83, Color(50, 250, 0), 0, 0, 2, Color(0, 50, 0))
    else
        draw_SimpleTextOutlined("C", "CSSTextFont", 135, 85, Color(50, 50, 50), 0, 0, 2, Color(20, 0, 0))
    end
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


    surface_SetDrawColor(255,255,0)
    surface_DrawOutlinedRect(ScrW() / 2 - 135,90,270,40)
    surface_SetDrawColor(0,0,0,200)
    surface_DrawRect(ScrW() / 2 - 135,90,270,40)
    message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()),0,2147483647),translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
    draw_DrawText(message, "TEA.HUDFontSmall", ScrW() / 2, 102, Color(255,255,255), TEXT_ALIGN_CENTER)
end
