-------- STATISTICS --------

GM.PlayerStatsCache = {}

local RefreshStats = function() end

net.Receive("UpdateTargetStats", function(length)
    GAMEMODE.PlayerStatsCache[GAMEMODE.PlayerStatsSelectedPlr] = {}
    local tbl = GAMEMODE.PlayerStatsCache[GAMEMODE.PlayerStatsSelectedPlr]
    for stat,value in pairs(net.ReadTable()) do
        tbl[stat] = value
    end

    local mastery = {}
    tbl.Mastery = mastery

	for mType in SortedPairs(GAMEMODE.MasterySkillStats) do
		mastery[mType] = mastery[mType] or {}
        mastery[mType].XP = math.Round(net.ReadFloat(), 2)
		mastery[mType].Level = net.ReadUInt(8)
	end

    RefreshStats()
end)

local statstoshow = {
    {"BestSurvivalTime", function(val)
        return string.format("%d:%02d:%02d", math.floor(val/3600), math.floor((val/60)%60), math.floor(val%60))
    end},
    {"TimePlayed", function(val)
        return string.format("%d:%02d:%02d", math.floor(val/3600), math.floor((val/60)%60), math.floor(val%60))
    end},
    {"TimesJoined"},
    {"MapsTransitioned"},
    {},
    {"ItemsUsedHeal"},
    {"ItemsUsedDrink"},
    {"ItemsUsedFood"},
    {"ItemsUsedAmmo"},
    {"ItemsUsedMisc"},
    {},
    -- {"DistanceSpentByWalk", "Distance spent by walking"},
    -- {"DistanceSpentBySwim", "Distance spent by swimming"},
    -- {"DistanceSpentInAir", "Distance spent while in air"},
    -- {"DistanceSpentByVehicle", "Distnace spent by vehicle"},

    {"ZombieKills"},
    {"ZombieKillAssists"},
    {"BossKills"},
    {"BossKillAssists"},
    {"ZombieDamageDealt", FormatNumber},
    {},

    -- {"HumansKilled", "Humans killed"},
    -- {"HumansKillAssists", "Human kill assists"},
    -- {"HumansDamageDealt", "Damage dealt to humans"},

    {"LootFound"},
    {"LootCommonFound"},
    {"LootUncommonFound"},
    {"LootRareFound"},
    {"LootEpicFound",},
    {"LootLegendaryFound"},
    {"LootFactionFound"},
    {"LootBossFound"},
    {},

    {"PlayersKilled"},
    -- {"PlayersKillAssists", "Player kill assists"},
    -- {"PlayersDamageDealt", "Damage dealt to players"},
    {},

    {"CashGainedByItemSell"},
    {"CashGainedByBounty"},
    {"CashGainedByLvlup"},
    {"CashGainedByMastery"},
    {},

    {"CashSpentByItemBuy"},
    {"CashSpentByPerkResets"},
    {},

    {"Deaths"},
    -- {"DeathsByThirst", "Deaths from thirst"},
    -- {"DeathsByHunger", "Deaths from hunger"},
    -- {"DeathsByFatigue", "Deaths from fatigue"},
    -- {"DeathsByInfection", "Deaths from infection"},
    -- {"DeathsByZombies", "Deaths from zombies"},
    -- {"DeathsByBoss", "Deaths from bosses"},
    -- {"DeathsByHuman", "Deaths from humans"},
    -- {"DeathsByPlayers", "Deaths from players"},
    -- {"DeathsBySuicide", "Deaths from suicide"},
    -- {"DeathsByFall", "Deaths from fall damage"},
}
local masteriestoshow = {
    "Melee",
    "PvP",
    "Survivor",
    "Gunnery",
    "Medic",
}

function GM:StatsMenu(ent)
    if not IsValid(ent) then return end
    GAMEMODE.PlayerStatsSelectedPlr = ent

    local StatsFrame = vgui.Create("DFrame")
    StatsFrame:SetSize(700, 400)
    StatsFrame:Center()
    StatsFrame:SetTitle(ent == LocalPlayer() and translate.Get("your_statistics") or translate.Format("plr_statistics", ent:GetName()))
    StatsFrame:SetDraggable(false)
    StatsFrame:SetVisible(true)
    StatsFrame:SetAlpha(0)
    StatsFrame:AlphaTo(255, 0.5, 0)
    StatsFrame:ShowCloseButton(true)
    StatsFrame:MakePopup()
    StatsFrame.Paint = function(panel)
        draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
        surface.SetDrawColor(255, 255, 255 ,255)
        surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
    end
    StatsFrame.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", StatsFrame, function()
		if StatsFrame and StatsFrame:IsValid() and StatsFrame:IsVisible() then
			StatsFrame:Close()
			return false
		end
	end)

    local list = vgui.Create("DScrollPanel", StatsFrame)
    list:Dock(FILL)
    list.Stats = {}
    list.MasterySkills = {}

    local loadtext = vgui.Create("DLabel", StatsFrame)
	loadtext:SetFont("TEA.HUDFontSmall")
	loadtext:SetColor(Color(205,205,205))
	loadtext:SetText("Loading...")
	loadtext:SetPos(20, 50)

	RefreshStats = function() -- I'm a "bit of coder"... no?
        if !StatsFrame:IsValid() then return end
        loadtext:SetVisible(false)

        local tbl = GAMEMODE.PlayerStatsCache[ent]

        if !list.StatisticsHeader then
            local txt = vgui.Create("DLabel", list)
            list.StatisticsHeader = txt
            txt:Dock(TOP)
            txt:DockMargin(0, 0, 0, 28)
            txt:SetText(translate.Get("statistics"))
            txt:SetFont("TEA.HUDFontLarge")
        end



        local lasttxt
        for id,val in ipairs(statstoshow) do
            if lasttxt and #val == 0 then
                lasttxt:DockMargin(0, 0, 0, 28)
                continue
            end
            local value = tbl[val[1]] or 0
            local name = translate.Get("Stats_"..val[1])

            local existingtxt = list.Stats[val[1]]
            if existingtxt and IsValid(existingtxt) then
                lasttxt = existingtxt
                existingtxt:SetText(name..": "..(val[2] and val[2](value) or value))
            else
                local txt = vgui.Create("DLabel", list)
                lasttxt = txt
                list.Stats[val[1]] = txt
                txt:Dock(TOP)
                txt:SetText(name..": "..(val[2] and val[2](value) or value))
                txt:SetFont("TEA.HUDFont")
                txt:SetWrap(true)
                txt:DockMargin(0, 0, 0, 4)
            end

            if id == #statstoshow then
                lasttxt:DockMargin(0, 0, 0, 40)
            end
        end

        if !list.MasteryHeader then
            local txt = vgui.Create("DLabel", list)
            list.MasteryHeader = txt
            txt:Dock(TOP)
            txt:DockMargin(0, 0, 0, 28)
            txt:SetText(translate.Get("masteries"))
            txt:SetFont("TEA.HUDFontLarge")
        end

        local lastpanel
        for id,gm_mastery_skill in pairs(GAMEMODE.MasterySkillStats) do
            local mastery = tbl.Mastery[id] or 0

            local existingpanel = list.MasterySkills["Mastery."..id]
            local reqxp = ent:GetReqMasteryXP(id, mastery.Level) or 0

            local colprogress = HSVToColor(math.Clamp(120 * mastery.XP/reqxp, 0, 120), 1, 1)
            if existingpanel and IsValid(existingpanel) then
                lastpanel = existingpanel
                existingpanel.XPText:SetText(translate.Format("xp", mastery.XP.."/"..reqxp).."  //  "..translate.Format("level", mastery.Level))
                existingpanel.XPPercentText:SetText("("..math.Round(100*mastery.XP/reqxp).."%)")
                existingpanel.XPPercentText:SetTextColor(colprogress)
                existingpanel.XPBar.Fraction = math.min(1, mastery.XP/reqxp)
            else
                local panel = vgui.Create("Panel", list)
                panel.Paint = function() end
                lastpanel = panel
                list.MasterySkills["Mastery."..id] = panel
                panel:SetMouseInputEnabled(true)
                panel:SetTooltip(
                    (gm_mastery_skill.Name and gm_mastery_skill.Name or translate.Get("StatsM_"..id))..":\n"..
                    (gm_mastery_skill.Description and gm_mastery_skill.Description or translate.Get("StatsM_"..id.."_Desc")).."\n\n"..
                    (gm_mastery_skill.GainHelpDesc and gm_mastery_skill.GainHelpDesc or translate.Get("StatsM_"..id.."_GainHelpDesc")).."\n\n"..
                    (gm_mastery_skill.RewardDesc and gm_mastery_skill.RewardDesc or translate.Get("StatsM_"..id.."_RewardDesc")).."\n\n"..
                    string.format(gm_mastery_skill.EffRewardDesc and gm_mastery_skill.EffRewardDesc or translate.Get("StatsM_"..id.."_EffRewardDesc"), gm_mastery_skill:GetStatEffectiveVal(ent, mastery.Level) * 100)
                )
                panel:Dock(TOP)
                panel:SetTall(75)
                panel:DockMargin(0, 0, 0, 8)


                local txt = vgui.Create("DLabel", panel)
                txt:Dock(TOP)
                txt:DockMargin(0, 0, 0, 4)
                txt:SetText(id)
                txt:SetFont("TEA.HUDFont")

                local txt = vgui.Create("DLabel", panel)
                panel.XPText = txt
                txt:Dock(TOP)
                txt:SetText(translate.Format("xp", mastery.XP.."/"..reqxp).."  //  "..translate.Format("level", mastery.Level))
                txt:SetFont("TEA.HUDFontSmall")
                txt:SetWrap(true)
                txt:DockMargin(0, 0, 0, 4)

                local txt = vgui.Create("DLabel", panel)
                panel.XPPercentText = txt
                txt:MoveBelow(panel.XPText, 4)
                txt:MoveRightOf(panel.XPText, 160)
                txt:SetText("("..math.Round(100*mastery.XP/reqxp).."%)")
                txt:SetTextColor(colprogress)
                txt:SetFont("TEA.HUDFontSmall")
                txt:SetWrap(true)
                txt:DockMargin(0, 0, 0, 4)

                colprogress = HSVToColor(math.Clamp(120 * mastery.XP/reqxp, 0, 120), 0.4, 1)
                local bar = vgui.Create("Panel", panel)
                panel.XPBar = bar
                bar.Fraction = math.min(1, mastery.XP/reqxp)
                bar.Paint = function(this, w, h)
                    surface.SetDrawColor(255, 255, 255, 200)
                    surface.DrawRect(0, 0, w, h)
                    surface.SetDrawColor(colprogress.r, colprogress.g, colprogress.b, 255)
                    surface.DrawRect(1, 1, (w-2)*(this.Fraction), h-2)
                end
                bar:Dock(TOP)
                bar:DockMargin(0, 0, 0, 20)
            end
        end


    end

    if GAMEMODE.PlayerStatsCache[ent] then
        RefreshStats()
    end
end