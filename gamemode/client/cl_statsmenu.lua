print("Why?")

TNick = 0
TBestSurvivalTime = 0
TZKills = 0
TPlyKills = 0
TPlyDeaths = 0

net.Receive("UpdateTargetStats", function(length)
    local tnick = net.ReadString()
    local tbestsurvtim = net.ReadFloat()
    local tzkills = net.ReadFloat()
    local tplykills = net.ReadFloat()
    local tplydeaths = net.ReadFloat()

    TNick = tnick
    TBestSurvivalTime = tbestsurvtim
    TZKills = tzkills
    TPlyKills = tplykills
    TPlyDeaths = tplydeaths
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
    end)
end