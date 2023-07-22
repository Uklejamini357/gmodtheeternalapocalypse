-------- STATISTICS --------

local TargetStats = {}
TargetStats.Nick = 0
TargetStats.BestSurvivalTime = 0
TargetStats.ZKills = 0
TargetStats.PlyKills = 0
TargetStats.PlyDeaths = 0
TargetStats.MMeleeXP = 0
TargetStats.MMeleeLvl = 0
TargetStats.MPvPXP = 0
TargetStats.MPvPLvl = 0

local RefreshStats = function()
end

net.Receive("UpdateTargetStats", function(length)
    local t1 = net.ReadString()
    local t2 = net.ReadFloat()
    local t3 = net.ReadFloat()
    local t4 = net.ReadFloat()
    local t5 = net.ReadFloat()
    local t6 = net.ReadFloat()
    local t7 = net.ReadFloat()
    local t8 = net.ReadFloat()
    local t9 = net.ReadFloat()
    local t10 = net.ReadFloat()
    local t11 = net.ReadFloat()

    TargetStats.Nick = t1
    TargetStats.BestSurvivalTime = t2
    TargetStats.ZKills = t3
    TargetStats.PlyKills = t4
    TargetStats.PlyDeaths = t5
    TargetStats.MMeleeXP = t6
    TargetStats.MMeleeLvl = t7
    TargetStats.MMeleeReqXP = t8
    TargetStats.MPvPXP = t9
    TargetStats.MPvPLvl = t10
    TargetStats.MPvPReqXP = t11

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
	loadtext:SetFont("TargetIDSmall")
	loadtext:SetColor(Color(205,205,205,255))
	loadtext:SetText("Loading...")
	loadtext:SetPos(20, 50)

    local stats1 = vgui.Create("DLabel", StatsFrame)
	stats1:SetFont("TargetIDSmall")
	stats1:SetColor(Color(205,205,205,255))
	stats1:SetText("")
	stats1:SetPos(20, 50)
    
    local stats2 = vgui.Create("DLabel", StatsFrame)
	stats2:SetFont("TargetIDSmall")
	stats2:SetColor(Color(205,205,205,255))
	stats2:SetText("")
	stats2:SetPos(20, 75)
    
    local stats3 = vgui.Create("DLabel", StatsFrame)
	stats3:SetFont("TargetIDSmall")
	stats3:SetColor(Color(205,205,205,255))
	stats3:SetText("")
	stats3:SetPos(20, 100)
    
    local stats4 = vgui.Create("DLabel", StatsFrame)
	stats4:SetFont("TargetIDSmall")
	stats4:SetColor(Color(205,205,205,255))
	stats4:SetText("")
	stats4:SetPos(20, 125)

    local stats5 = vgui.Create("DLabel", StatsFrame)
	stats5:SetFont("TargetIDSmall")
	stats5:SetColor(Color(205,205,205,255))
	stats5:SetText("")
	stats5:SetPos(20, 150)

    local stats6 = vgui.Create("DLabel", StatsFrame)
	stats6:SetFont("TargetIDSmall")
	stats6:SetColor(Color(205,205,205,255))
	stats6:SetText("")
	stats6:SetPos(20, 175)
    
	RefreshStats = function() -- I'm a "bit of coder"... no?
        if !StatsFrame:IsValid() then return end
        loadtext:SetText("")
        stats1:SetText(translate.Format("besttimesurvived", util.ToMinutesSeconds(TargetStats.BestSurvivalTime)))
        stats1:SizeToContents()
        stats2:SetText(Format("Zombies killed in total: %s", TargetStats.ZKills))
        stats2:SizeToContents()
        stats3:SetText(Format("Total players killed on this server: %s", TargetStats.PlyKills))
	    stats3:SizeToContents()
        stats4:SetText(Format("Total deaths on this server: %s", TargetStats.PlyDeaths))
	    stats4:SizeToContents()
        stats5:SetText(Format("Mastery Melee XP: %s / %s (Level %s)", math.floor(TargetStats.MMeleeXP), TargetStats.MMeleeReqXP, TargetStats.MMeleeLvl))
	    stats5:SizeToContents()
        stats6:SetText(Format("Mastery PvP XP: %s / %s (Level %s)", math.floor(TargetStats.MPvPXP), TargetStats.MPvPReqXP, TargetStats.MPvPLvl))
	    stats6:SizeToContents()
    end
end