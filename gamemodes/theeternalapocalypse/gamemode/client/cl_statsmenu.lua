-------- STATISTICS --------

GM.PlayerStatsCache = {}

local RefreshStats = function() end

net.Receive("UpdateTargetStats", function(length)
    GAMEMODE.PlayerStatsCache[GAMEMODE.PlayerStatsSelectedPlr] = {}
    local tbl = GAMEMODE.PlayerStatsCache[GAMEMODE.PlayerStatsSelectedPlr]
    for stat,value in pairs(net.ReadTable()) do
        tbl[stat] = value
    end
    tbl.MMeleeXP = net.ReadFloat()
    tbl.MMeleeLvl = net.ReadFloat()
    tbl.MMeleeReqXP = net.ReadFloat()
    tbl.MPvPXP = net.ReadFloat()
    tbl.MPvPLvl = net.ReadFloat()
    tbl.MPvPReqXP = net.ReadFloat()

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
    {"CashSpentByPerkResets", "Cash spent by buying items"},
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
    {},
}

function StatsMenu(ent)
    if not IsValid(ent) then return end
    GAMEMODE.PlayerStatsSelectedPlr = ent

    local StatsFrame = vgui.Create("DFrame")
    StatsFrame:SetSize(700, 400)
    StatsFrame:Center()
    StatsFrame:SetTitle(ent:GetName().."'s stats")
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

    local loadtext = vgui.Create("DLabel", StatsFrame)
	loadtext:SetFont("TEA.HUDFontSmall")
	loadtext:SetColor(Color(205,205,205))
	loadtext:SetText("Loading...")
	loadtext:SetPos(20, 50)

	RefreshStats = function() -- I'm a "bit of coder"... no?
        if !StatsFrame:IsValid() then return end
        loadtext:SetVisible(false)

        local lasttxt
        for _,val in ipairs(statstoshow) do
            if lasttxt and #val == 0 then
                lasttxt:DockMargin(0, 0, 0, 28)
                continue
            end
            local value = GAMEMODE.PlayerStatsCache[ent][val[1]] or 0

            local txt = vgui.Create("DLabel")
            lasttxt = txt
            list:AddItem(txt)
            txt:Dock(TOP)
            txt:SetText(val[2]..": "..(val[3] and val[3](value) or value))
            txt:SetFont("TEA.HUDFont")
            txt:SetWrap(true)
            txt:DockMargin(0, 0, 0, 4)
        end
    end

    if GAMEMODE.PlayerStatsCache[ent] then
        RefreshStats()
    end
end