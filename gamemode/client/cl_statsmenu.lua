MsgC("Why?\n")

TNick = 0
TBestSurvivalTime = 0
TZKills = 0
TPlyKills = 0
TPlyDeaths = 0
TMMeleeXP = 0
TMMeleeLvl = 0
TMPvPXP = 0
TMPvPLvl = 0

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

    TNick = t1
    TBestSurvivalTime = t2
    TZKills = t3
    TPlyKills = t4
    TPlyDeaths = t5
    TMMeleeXP = t6
    TMMeleeLvl = t7
    TMMeleeReqXP = t8
    TMPvPXP = t9
    TMPvPLvl = t10
    TMPvPReqXP = t11
end)

function StatsMenu()
    local StatsFrame = vgui.Create("DFrame")
    StatsFrame:SetSize(700, 400)
    StatsFrame:Center()
    StatsFrame:SetTitle("Stats Panel")
    StatsFrame:SetDraggable(false)
    StatsFrame:SetVisible(true)
    StatsFrame:SetAlpha(0)
    StatsFrame:AlphaTo(255, 0.5, 0)
    StatsFrame:ShowCloseButton(true)
    StatsFrame:MakePopup()
    StatsFrame.Paint = function()
        draw.RoundedBox(2, 0, 0, StatsFrame:GetWide(), StatsFrame:GetTall(), Color(0, 0, 0, 200))
        surface.SetDrawColor(150, 0, 0 ,255)
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
    
	timer.Simple(math.Rand(0.5,1), function()
        if !StatsFrame:IsValid() then return end
        loadtext:SetText("")
        StatsFrame:SetTitle(TNick.."'s Stats")
        stats1:SetText("Best Survival Time: "..TBestSurvivalTime.."s")
        stats1:SizeToContents()
        stats2:SetText("Zombies killed in total: "..TZKills)
        stats2:SizeToContents()
        stats3:SetText("Total players killed on this server: "..TPlyKills)
	    stats3:SizeToContents()
        stats4:SetText("Total deaths on this server: "..TPlyDeaths)
	    stats4:SizeToContents()
        stats5:SetText("Mastery Melee XP: "..math.floor(TMMeleeXP).." / "..TMMeleeReqXP.." (Level "..TMMeleeLvl..")")
	    stats5:SizeToContents()
        stats6:SetText("Mastery PvP XP: "..math.floor(TMPvPXP).." / "..TMPvPReqXP.." (Level "..TMPvPLvl..")")
	    stats6:SizeToContents()
    end)
end