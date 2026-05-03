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
    mastery.Melee = mastery.Melee or {}
    mastery.Melee.XP = math.Round(net.ReadFloat(), 2)
    mastery.Melee.Level = net.ReadUInt(8)
    mastery.PvP = mastery.PvP or {}
    mastery.PvP.XP = math.Round(net.ReadFloat(), 2)
    mastery.PvP.Level = net.ReadUInt(8)

    RefreshStats()
end)

local statstoshow = {
    {"BestSurvivalTime", "Best survival time", function(val)
        return string.format("%d:%02d:%02d", math.floor(val/3600), math.floor((val/60)%60), math.floor(val%60))
    end},
    {"TimePlayed", "Total time played", function(val)
        return string.format("%d:%02d:%02d", math.floor(val/3600), math.floor((val/60)%60), math.floor(val%60))
    end},
    {"TimesJoined", "Times joined"},
    {"MapsTransitioned", "Maps transitioned"},
    {},
    {"ItemsUsedHeal", "Heal items used"},
    {"ItemsUsedDrink", "Drink items used"},
    {"ItemsUsedFood", "Food items used"},
    {"ItemsUsedAmmo", "Ammo items used"},
    {"ItemsUsedMisc", "Misc items used"},
    {},
    -- {"DistanceSpentByWalk", "Distance spent by walking"},
    -- {"DistanceSpentBySwim", "Distance spent by swimming"},
    -- {"DistanceSpentInAir", "Distance spent while in air"},
    -- {"DistanceSpentByVehicle", "Distnace spent by vehicle"},

    {"ZombieKills", "Zombie kills"},
    {"ZombieKillAssists", "Zombie kill assists"},
    {"BossKills", "Boss kills"},
    {"BossKillAssists", "Boss kill assists"},
    {"ZombieDamageDealt", "Damage dealt to zombies", FormatNumber},
    {},

    -- {"HumansKilled", "Humans killed"},
    -- {"HumansKillAssists", "Human kill assists"},
    -- {"HumansDamageDealt", "Damage dealt to humans"},

    {"LootFound", "Loot caches found"},
    {"LootCommonFound", "Common loot caches found"},
    {"LootUncommonFound", "Uncommon loot caches found"},
    {"LootRareFound", "Rare loot caches found"},
    {"LootEpicFound", "Epic loot caches found"},
    {"LootLegendaryFound", "Legendary loot caches found"},
    {"LootFactionFound", "Faction loot caches found"},
    {"LootBossFound", "Boss loot caches found"},
    {},

    {"PlayersKilled", "Players killed"},
    -- {"PlayersKillAssists", "Player kill assists"},
    -- {"PlayersDamageDealt", "Damage dealt to players"},
    {},

    {"CashGainedByItemSell", "Cash gained from selling items"},
    {"CashGainedByBounty", "Cash gained from bounties"},
    {"CashGainedByLvlup", "Cash gained from leveling up"},
    {"CashGainedByMastery", "Cash gained from masteries"},
    {},

    {"CashSpentByItemBuy", "Cash spent by buying items"},
    {"CashSpentByPerkResets", "Cash spent by resetting perks"},
    {},

    {"Deaths", "Deaths"},
    {"DeathsByThirst", "Deaths from thirst"},
    {"DeathsByHunger", "Deaths from hunger"},
    {"DeathsByFatigue", "Deaths from fatigue"},
    {"DeathsByInfection", "Deaths from infection"},
    {"DeathsByZombies", "Deaths from zombies"},
    {"DeathsByBoss", "Deaths from bosses"},
    {"DeathsByHuman", "Deaths from humans"},
    {"DeathsByPlayers", "Deaths from players"},
    {"DeathsBySuicide", "Deaths from suicide"},
    {"DeathsByFall", "Deaths from fall damage"},
}
local masteriestoshow = {
    "Melee",
    "PvP"
}

function GM:StatsMenu(ent)
    if not IsValid(ent) then return end
    GAMEMODE.PlayerStatsSelectedPlr = ent

    local StatsFrame = vgui.Create("DFrame")
    StatsFrame:SetSize(700, 400)
    StatsFrame:Center()
    StatsFrame:SetTitle(ent == LocalPlayer() and "Your statistics" or ent:GetName().."'s statistics")
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
            txt:SetText("Statistics")
            txt:SetFont("TEA.HUDFontLarge")
        end



        local lasttxt
        for id,val in ipairs(statstoshow) do
            if lasttxt and #val == 0 then
                lasttxt:DockMargin(0, 0, 0, 28)
                continue
            end
            local value = tbl[val[1]] or 0

            local existingtxt = list.Stats[val[1]]
            if existingtxt and IsValid(existingtxt) then
                lasttxt = existingtxt
                existingtxt:SetText(val[2]..": "..(val[3] and val[3](value) or value))
            else
                local txt = vgui.Create("DLabel", list)
                lasttxt = txt
                list.Stats[val[1]] = txt
                txt:Dock(TOP)
                txt:SetText(val[2]..": "..(val[3] and val[3](value) or value))
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
            txt:SetText("Masteries")
            txt:SetFont("TEA.HUDFontLarge")
        end

        local lastpanel
        for _,id in pairs(masteriestoshow) do
            local mastery = tbl.Mastery[id] or 0

            local existingpanel = list.MasterySkills["Mastery."..id]
            local reqxp = id == "Melee" and ent:GetReqMasteryMeleeXP(mastery.Level) or id == "PvP" and ent:GetReqMasteryPvPXP(mastery.Level) or 0
            if existingpanel and IsValid(existingpanel) then
                lastpanel = existingpanel
                existingpanel.XPText:SetText("XP: ".. mastery.XP.."/"..reqxp.."  //  Level: "..mastery.Level)
                existingpanel.XPBar.Fraction = math.min(1, mastery.XP/reqxp)
            else
                local panel = vgui.Create("Panel", list)
                panel.Paint = function() end
                lastpanel = panel
                list.MasterySkills["Mastery."..id] = panel
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
                txt:SetText("XP: ".. mastery.XP.."/"..reqxp.."  //  Level: "..mastery.Level)
                txt:SetFont("TEA.HUDFontSmall")
                txt:SetWrap(true)
                txt:DockMargin(0, 0, 0, 4)

                local bar = vgui.Create("Panel", panel)
                panel.XPBar = bar
                bar.Fraction = math.min(1, mastery.XP/reqxp)
                bar.Paint = function(this, w, h)
                    surface.SetDrawColor(255, 255, 255, 200)
                    surface.DrawRect(0, 0, w, h)
                    surface.SetDrawColor(255, 155, 155, 255)
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