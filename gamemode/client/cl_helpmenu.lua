---------------- HELP MENU ----------------

function HelpMenu()
    if IsValid(HelpFrame) then HelpFrame:Remove() end
    HelpFrame = vgui.Create("DFrame")
    HelpFrame:SetSize(700, 500)
    HelpFrame:Center()
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

    local text1 = vgui.Create("DLabel", HelpFrame)
    local button1 = vgui.Create("DButton", HelpFrame)

    function DoHelpMenu()
        if !IsValid(HelpFrame) then return end
        HelpFrame:SetTitle("Help Menu - IN PROGRESS")
        text1:SetFont("TargetIDSmall")
        text1:SetColor(Color(205,205,205,255))
        text1:SetText("You have viewed the help menu. Press a button to select a helpmenu category.\nWARNING: ONLY ENGLISH IS SUPPORTED HERE CURRENTLY AND THIS IS \nCURRENTLY WORK IN PROGRESS!!")
        text1:SizeToContents()
        text1:SetPos(20, 30)

        button1:SetSize(120, 30)
        button1:SetPos(20, 155)
        button1:SetText("About This Gamemode")
        button1:SetTextColor(Color(255, 255, 255, 255))
        button1.Paint = function(panel)
            surface.SetDrawColor(150, 0, 0 ,255)
            surface.DrawOutlinedRect(0, 0, button1:GetWide(), button1:GetTall())
            draw.RoundedBox( 2, 0, 0, button1:GetWide(), button1:GetTall(), Color(0, 0, 0, 130) )
        end
        button1.DoClick = function()
            ClearHelpMenu()
            HelpFrame:SetTitle("Help Menu (About This Gamemode)")
            text1:SetText("hi")
            text1:SizeToContents()
    
            button1:SetPos(20, 75)
            button1:SetText("Back")
            button1.Paint = function(panel)
                surface.SetDrawColor(150, 0, 0 ,255)
                surface.DrawOutlinedRect(0, 0, button1:GetWide(), button1:GetTall())
                draw.RoundedBox( 2, 0, 0, button1:GetWide(), button1:GetTall(), Color(0, 0, 0, 130) )
            end
            button1.DoClick = function()
                DoHelpMenu()
            end
        end
    end
    DoHelpMenu()

    function ClearHelpMenu()
        if !IsValid(HelpFrame) then return end
        text1:SetText("")

        button1:SetText("")
    end
end

