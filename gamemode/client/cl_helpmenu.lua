print("help")
IsFromHelpMenu = false

function HelpMenu()
    local HelpFrame = vgui.Create("DFrame")
    HelpFrame:SetSize(1000, 700)
    HelpFrame:Center()
    HelpFrame:SetTitle("Help Menu - IN PROGRESS")
    HelpFrame:SetDraggable(false)
    HelpFrame:SetVisible(true)
    HelpFrame:SetAlpha(0)
    HelpFrame:AlphaTo(255, 0.5, 0)
    HelpFrame:ShowCloseButton(true)
    HelpFrame:MakePopup()
    HelpFrame.Paint = function()
        draw.RoundedBox(2, 0, 0, HelpFrame:GetWide(), HelpFrame:GetTall(), Color(0, 0, 0, 200))
        surface.SetDrawColor(150, 0, 0 ,255)
        surface.DrawOutlinedRect(0, 0, HelpFrame:GetWide(), HelpFrame:GetTall())
    end
end
