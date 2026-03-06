-------- STATISTICS --------

local TargetStats = {}

local RefreshStats = function()
end

net.Receive("UpdateTargetStats", function(length)
    TargetStats.Nick = net.ReadString()
    for stat,value in pairs(net.ReadTable()) do
        TargetStats[stat] = value
    end
    TargetStats.MMeleeXP = net.ReadFloat()
    TargetStats.MMeleeLvl = net.ReadFloat()
    TargetStats.MMeleeReqXP = net.ReadFloat()
    TargetStats.MPvPXP = net.ReadFloat()
    TargetStats.MPvPLvl = net.ReadFloat()
    TargetStats.MPvPReqXP = net.ReadFloat()

    RefreshStats()
end)

function StatsMenu(ent)
    if not ent then return end
    local StatsFrame = vgui.Create("DFrame")
    StatsFrame:SetSize(700, 400)
    StatsFrame:Center()
    StatsFrame:SetTitle(ent:GetName())
    StatsFrame:SetDraggable(false)
    StatsFrame:SetVisible(true)
    StatsFrame:SetAlpha(0)
    StatsFrame:AlphaTo(255, 0.5, 0)
    StatsFrame:ShowCloseButton(true)
    StatsFrame:MakePopup()
    StatsFrame.Paint = function()
        draw.RoundedBox(2, 0, 0, StatsFrame:GetWide(), StatsFrame:GetTall(), Color(0, 0, 0, 200))
        surface.SetDrawColor(150, 150, 0 ,255)
        surface.DrawOutlinedRect(0, 0, StatsFrame:GetWide(), StatsFrame:GetTall())
    end

    local loadtext = vgui.Create("DLabel", StatsFrame)
	loadtext:SetFont("TEA.HUDFontSmall")
	loadtext:SetColor(Color(205,205,205,255))
	loadtext:SetText("Loading...")
	loadtext:SetPos(20, 50)

    local stats1 = vgui.Create("DLabel", StatsFrame)
	stats1:SetFont("TEA.HUDFontSmall")
	stats1:SetColor(Color(205,205,205,255))
	stats1:SetText("")
	stats1:SetPos(20, 50)
    
    local stats2 = vgui.Create("DLabel", StatsFrame)
	stats2:SetFont("TEA.HUDFontSmall")
	stats2:SetColor(Color(205,205,205,255))
	stats2:SetText("")
	stats2:SetPos(20, 75)
    
    local stats3 = vgui.Create("DLabel", StatsFrame)
	stats3:SetFont("TEA.HUDFontSmall")
	stats3:SetColor(Color(205,205,205,255))
	stats3:SetText("")
	stats3:SetPos(20, 100)
    
    local stats4 = vgui.Create("DLabel", StatsFrame)
	stats4:SetFont("TEA.HUDFontSmall")
	stats4:SetColor(Color(205,205,205,255))
	stats4:SetText("")
	stats4:SetPos(20, 125)

    local stats5 = vgui.Create("DLabel", StatsFrame)
	stats5:SetFont("TEA.HUDFontSmall")
	stats5:SetColor(Color(205,205,205,255))
	stats5:SetText("")
	stats5:SetPos(20, 150)

    local stats6 = vgui.Create("DLabel", StatsFrame)
	stats6:SetFont("TEA.HUDFontSmall")
	stats6:SetColor(Color(205,205,205,255))
	stats6:SetText("")
	stats6:SetPos(20, 175)
    
	RefreshStats = function() -- I'm a "bit of coder"... no?
        if !StatsFrame:IsValid() then return end
        loadtext:SetVisible(false)
        stats1:SetText(translate.Format("besttimesurvived", util.ToMinutesSeconds(TargetStats.BestSurvivalTime)))
        stats1:SizeToContents()
        stats2:SetText(Format("Zombies killed in total: %s", TargetStats.ZombieKills))
        stats2:SizeToContents()
        stats3:SetText(Format("Total players killed on this server: %s", TargetStats.PlayersKilled))
	    stats3:SizeToContents()
        stats4:SetText(Format("Total deaths on this server: %s", TargetStats.Deaths))
	    stats4:SizeToContents()
        stats5:SetText(Format("Mastery Melee XP: %s / %s (Level %s)", math.floor(TargetStats.MMeleeXP), TargetStats.MMeleeReqXP, TargetStats.MMeleeLvl))
	    stats5:SizeToContents()
        stats6:SetText(Format("Mastery PvP XP: %s / %s (Level %s)", math.floor(TargetStats.MPvPXP), TargetStats.MPvPReqXP, TargetStats.MPvPLvl))
	    stats6:SizeToContents()
    end
end