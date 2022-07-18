-------------------------------- Context Menu --------------------------------


function GM:OnContextMenuOpen()

    gui.EnableScreenClicker( true )
    CMenu()
    ContextMenu:SetVisible( true )
end

function GM:OnContextMenuClose()
if ContextMenu:IsValid() then
    ContextMenu:SetVisible( false )
    ContextMenu:Remove()
    gui.EnableScreenClicker( false )
end
end


function CMenu()
    ContextMenu = vgui.Create( "DFrame" )
    ContextMenu:SetSize( 600, 600 )
    ContextMenu:Center()
    ContextMenu:SetTitle ( "" )
    ContextMenu:SetDraggable( false )
    ContextMenu:SetVisible( true )
    ContextMenu:ShowCloseButton( false )
    ContextMenu:MakePopup()
    ContextMenu.Paint = function()
 --   draw.RoundedBox( 2,  0,  0, ContextMenu:GetWide(), ContextMenu:GetTall(), Color( 0, 0, 0, 200 ) )
--    surface.SetDrawColor(150, 0, 0 ,255)
--    surface.DrawOutlinedRect(0, 0, ContextMenu:GetWide(), ContextMenu:GetTall())
--    surface.SetDrawColor(100, 100, 100 ,205)
    surface.DrawCircle(ContextMenu:GetWide() / 2, ContextMenu:GetTall() / 2, 150, Color(100, 100, 100 ,205))
    surface.DrawCircle(ContextMenu:GetWide() / 2, ContextMenu:GetTall() / 2, 140, Color(100, 100, 100 ,205))
    end


    local NukeButton = vgui.Create("DButton", ContextMenu)
    NukeButton:SetSize( 120, 40 )
    NukeButton:Center()
    local x,y = NukeButton:GetPos()
    NukeButton:SetPos( x - 150, y - 160)
    NukeButton:SetText("Clear my Props")
    NukeButton:SetTextColor(Color(255, 255, 255, 255))
    NukeButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, NukeButton:GetWide(), NukeButton:GetTall())
    draw.RoundedBox( 2, 0, 0, NukeButton:GetWide(), NukeButton:GetTall(), Color(0, 0, 0, 130) )
    end
    NukeButton.DoClick = function()
    RunConsoleCommand("-menu_context")
    ConfirmPropDestroy()
    end

    local PrestigeButton = vgui.Create("DButton", ContextMenu)
    PrestigeButton:SetSize( 120, 40 )
    PrestigeButton:Center()
    local x,y = PrestigeButton:GetPos()
    PrestigeButton:SetPos( x + 150, y - 160)
    PrestigeButton:SetText("Prestige")
    PrestigeButton:SetTextColor(Color(255, 255, 0, 255))
    PrestigeButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, PrestigeButton:GetWide(), PrestigeButton:GetTall())
    draw.RoundedBox( 2, 0, 0, PrestigeButton:GetWide(), PrestigeButton:GetTall(), Color(0, 0, 0, 130) )
    end
    PrestigeButton.DoClick = function()
    RunConsoleCommand("-menu_context")
    ConfirmPrestige()
    end

    local SuicideButton = vgui.Create("DButton", ContextMenu)
    SuicideButton:SetSize( 120, 40 )
    SuicideButton:Center()
    local x,y = SuicideButton:GetPos()
    SuicideButton:SetPos( x + 200, y + 100)
    SuicideButton:SetText("End your misery")
    SuicideButton:SetTextColor(Color(191, 0, 0, 255))
    SuicideButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, SuicideButton:GetWide(), SuicideButton:GetTall())
    draw.RoundedBox( 2, 0, 0, SuicideButton:GetWide(), SuicideButton:GetTall(), Color(0, 0, 0, 130) )
    end
    SuicideButton.DoClick = function()
    RunConsoleCommand("-menu_context")
    RunConsoleCommand("kill")
    end

    local RefreshInvButton = vgui.Create("DButton", ContextMenu)
    RefreshInvButton:SetSize( 120, 40 )
    RefreshInvButton:Center()
    local x,y = RefreshInvButton:GetPos()
    RefreshInvButton:SetPos( x - 200, y + 100)
    RefreshInvButton:SetText("Refresh inventory")
    RefreshInvButton:SetTextColor(Color(255, 255, 255, 255))
    RefreshInvButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, RefreshInvButton:GetWide(), RefreshInvButton:GetTall())
    draw.RoundedBox( 2, 0, 0, RefreshInvButton:GetWide(), RefreshInvButton:GetTall(), Color(0, 0, 0, 130) )
    end
    RefreshInvButton.DoClick = function()
    RunConsoleCommand("-menu_context")
    RunConsoleCommand("refresh_inventory")
    end

    local CashButton = vgui.Create("DButton", ContextMenu)
    CashButton:SetSize( 120, 40 )
    CashButton:Center()
    local x,y = CashButton:GetPos()
    CashButton:SetPos( x + 220, y)
    CashButton:SetText("Drop Money")
    CashButton:SetTextColor(Color(255, 255, 255, 255))
    CashButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, CashButton:GetWide(), CashButton:GetTall())
    draw.RoundedBox( 2, 0, 0, CashButton:GetWide(), CashButton:GetTall(), Color(0, 0, 0, 130) )
    end
    CashButton.DoClick = function()
    DropGoldMenu()
    RunConsoleCommand("-menu_context")
    end


    local PVPButton = vgui.Create("DButton", ContextMenu)
    PVPButton:SetSize( 120, 40 )
    PVPButton:Center()
    local x,y = PVPButton:GetPos()
    PVPButton:SetPos( x , y + 180)
    PVPButton:SetText("Toggle PVP")
    PVPButton:SetTextColor(Color(255, 255, 255, 255))
    PVPButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, PVPButton:GetWide(), PVPButton:GetTall())
    draw.RoundedBox( 2, 0, 0, PVPButton:GetWide(), PVPButton:GetTall(), Color(0, 0, 0, 130) )
    end
    PVPButton.DoClick = function()
    RunConsoleCommand("ate_togglepvp")
    RunConsoleCommand("-menu_context")
    end

    local EmoButton = vgui.Create("DButton", ContextMenu)
    EmoButton:SetSize( 120, 40 )
    EmoButton:Center()
    local x,y = EmoButton:GetPos()
    EmoButton:SetPos( x - 220, y)
    EmoButton:SetText("Emotes")
    EmoButton:SetTextColor(Color(255, 255, 255, 255))
    EmoButton.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, EmoButton:GetWide(), EmoButton:GetTall())
    draw.RoundedBox( 2, 0, 0, EmoButton:GetWide(), EmoButton:GetTall(), Color(0, 0, 0, 130) )
    end
    EmoButton.DoClick = function()
    RunConsoleCommand("-menu_context")
    Emotes()
    end

end


function ConfirmPropDestroy()
local ConfirmFrame = vgui.Create( "DFrame" )
    ConfirmFrame:SetSize( 300, 200 )
    ConfirmFrame:Center()
    ConfirmFrame:SetTitle ( "Clearing Props..." )
    ConfirmFrame:SetDraggable( false )
    ConfirmFrame:SetVisible( true )
    ConfirmFrame:ShowCloseButton( true )
    ConfirmFrame:MakePopup()
    ConfirmFrame.Paint = function()
    draw.RoundedBox( 2,  0,  0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall(), Color( 0, 0, 0, 200 ) )
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall())
    end

    local derptext = vgui.Create( "DLabel", ConfirmFrame )
    derptext:SetFont( "TargetIDSmall" )
    derptext:SetColor( Color(205,205,205,255) )
    derptext:SetText( "Are you sure?\nThis will delete all your active props and\nyou will not be refunded for them!\nIf you want to be refunded you will need\nto salvage your props by pressing R with\nbuild tool" )
    derptext:SizeToContents()
    derptext:SetPos( 10, 30)

    local doitfaggot = vgui.Create("DButton", ConfirmFrame)
    doitfaggot:SetSize( 120, 40 )
    doitfaggot:SetPos( 90 , 140)
    doitfaggot:SetText("Do It!")
    doitfaggot:SetTextColor(Color(255, 255, 255, 255))
    doitfaggot.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, doitfaggot:GetWide(), doitfaggot:GetTall())
    draw.RoundedBox( 2, 0, 0, doitfaggot:GetWide(), doitfaggot:GetTall(), Color(0, 0, 0, 130) )
    end
    doitfaggot.DoClick = function()
    RunConsoleCommand("ate_clearmyprops")
    ConfirmFrame:Remove()
    end

end


function ConfirmPrestige()
local ConfirmFrame = vgui.Create( "DFrame" )
    ConfirmFrame:SetSize( 300, 200 )
    ConfirmFrame:Center()
    ConfirmFrame:SetTitle ( "Prestiging to another level..." )
    ConfirmFrame:SetDraggable( false )
    ConfirmFrame:SetVisible( true )
    ConfirmFrame:ShowCloseButton( true )
    ConfirmFrame:MakePopup()
    ConfirmFrame.Paint = function()
    draw.RoundedBox( 2,  0,  0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall(), Color( 0, 0, 0, 200 ) )
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall())
    end

    local prestigetext = vgui.Create( "DLabel", ConfirmFrame )
    prestigetext:SetFont( "TargetIDSmall" )
    prestigetext:SetColor( Color(205,205,205,255) )
    prestigetext:SetText( "This function doesn't work yet\nIt may or may not be implemented\nin next update\nPressing the button will kill you" )
    prestigetext:SizeToContents()
    prestigetext:SetPos( 10, 30)

    local doprestige = vgui.Create("DButton", ConfirmFrame)
    doprestige:SetSize( 120, 40 )
    doprestige:SetPos( 90 , 140)
    doprestige:SetText("Confirm Prestige")
    doprestige:SetTextColor(Color(255, 255, 255, 255))
    doprestige.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, doprestige:GetWide(), doprestige:GetTall())
    draw.RoundedBox( 2, 0, 0, doprestige:GetWide(), doprestige:GetTall(), Color(0, 0, 0, 130) )
    end
    doprestige.DoClick = function()
    RunConsoleCommand("kill")
    ConfirmFrame:Remove()
    end

end


function DropGoldMenu()
local AdarFrame = vgui.Create( "DFrame" )
    AdarFrame:SetSize( 300, 200 )
    AdarFrame:Center()
    AdarFrame:SetTitle ( "Dropping Money..." )
    AdarFrame:SetDraggable( false )
    AdarFrame:SetVisible( true )
    AdarFrame:ShowCloseButton( true )
    AdarFrame:MakePopup()
    AdarFrame.Paint = function()
    draw.RoundedBox( 2,  0,  0, AdarFrame:GetWide(), AdarFrame:GetTall(), Color( 0, 0, 0, 200 ) )
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, AdarFrame:GetWide(), AdarFrame:GetTall())
    end

    local derptext = vgui.Create( "DLabel", AdarFrame )
    derptext:SetFont( "TargetIDSmall" )
    derptext:SetColor( Color(205,205,205,255) )
    derptext:SetText( "How much cash do you want to drop?" )
    derptext:SizeToContents()
    derptext:SetPos( 10, 30)

    local derptext2 = vgui.Create( "DLabel", AdarFrame )
    derptext2:SetFont( "TargetIDSmall" )
    derptext2:SetColor( Color(205,255,205,255) )
    derptext2:SetText( "Current Cash: "..Mymoney )
    derptext2:SizeToContents()
    derptext2:SetPos( 10, 50)

    local Cash = vgui.Create( "DNumberWang", AdarFrame )
    Cash:SetPos( 10, 70 )
    Cash:SetSize( 150, 30 )
    Cash:SetMin(0)
    Cash:SetMax(99999999)
    Cash:SetToolTip( "" )

    local doitfaggot = vgui.Create("DButton", AdarFrame)
    doitfaggot:SetSize( 120, 40 )
    doitfaggot:SetPos( 90 , 140)
    doitfaggot:SetText("Drop Cash")
    doitfaggot:SetTextColor(Color(255, 255, 255, 255))
    doitfaggot.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, doitfaggot:GetWide(), doitfaggot:GetTall())
    draw.RoundedBox( 2, 0, 0, doitfaggot:GetWide(), doitfaggot:GetTall(), Color(0, 0, 0, 130) )
    end
    doitfaggot.DoClick = function()
    RunConsoleCommand("ate_dropcash", Cash:GetValue())
    AdarFrame:Remove()
    end

end


function Emotes()
local EmoteFrame = vgui.Create( "DFrame" )
    EmoteFrame:SetSize( 300, 400 )
    EmoteFrame:Center()
    EmoteFrame:SetTitle ( "Emotes" )
    EmoteFrame:SetDraggable( false )
    EmoteFrame:SetVisible( true )
    EmoteFrame:ShowCloseButton( true )
    EmoteFrame:MakePopup()
    EmoteFrame.Paint = function()
    draw.RoundedBox( 2,  0,  0, EmoteFrame:GetWide(), EmoteFrame:GetTall(), Color( 0, 0, 0, 200 ) )
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, EmoteFrame:GetWide(), EmoteFrame:GetTall())
    end

    local derptext = vgui.Create( "DLabel", EmoteFrame )
    derptext:SetFont( "TargetIDSmall" )
    derptext:SetColor( Color(205,205,205,255) )
    derptext:SetText( "Expressive Emotes" )
    derptext:SizeToContents()
    derptext:SetPos( 10, 20)

    local derptext = vgui.Create( "DLabel", EmoteFrame )
    derptext:SetFont( "TargetIDSmall" )
    derptext:SetColor( Color(205,205,205,255) )
    derptext:SetText( "Goofy Emotes" )
    derptext:SizeToContents()
    derptext:SetPos( 160, 20)

    local derptext = vgui.Create( "DLabel", EmoteFrame )
    derptext:SetFont( "TargetIDSmall" )
    derptext:SetColor( Color(205,205,205,255) )
    derptext:SetText( "RP Emotes" )
    derptext:SizeToContents()
    derptext:SetPos( 10, 250)

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 40)
    butthole:SetText("Greeting")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "wave")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 75)
    butthole:SetText("Cheer")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "cheer")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 110)
    butthole:SetText("Laugh")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "laugh")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 145)
    butthole:SetText("Tumbs up")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "agree")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 180)
    butthole:SetText("Disagree")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "disagree")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 215)
    butthole:SetText("Bow")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "bow")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 270)
    butthole:SetText("Halt!")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "halt")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 305)
    butthole:SetText("Forward")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "forward")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 10 , 340)
    butthole:SetText("Regroup")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "group")
    EmoteFrame:Remove()
    end


    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 40)
    butthole:SetText("Robot Dance")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "robot")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 75)
    butthole:SetText("Sexy Dance")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "muscle")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 110)
    butthole:SetText("Zombie Impersonation")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "zombie")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 145)
    butthole:SetText("Boogie")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "dance")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 180)
    butthole:SetText("Kung Fu")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "pers")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 215)
    butthole:SetText("Come Get Some")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "becon")
    EmoteFrame:Remove()
    end

    local butthole = vgui.Create("DButton", EmoteFrame)
    butthole:SetSize( 120, 30 )
    butthole:SetPos( 160 , 250)
    butthole:SetText("Salute")
    butthole:SetTextColor(Color(255, 255, 255, 255))
    butthole.Paint = function(panel)
    surface.SetDrawColor(150, 0, 0 ,255)
    surface.DrawOutlinedRect(0, 0, butthole:GetWide(), butthole:GetTall())
    draw.RoundedBox( 2, 0, 0, butthole:GetWide(), butthole:GetTall(), Color(0, 0, 0, 130) )
    end
    butthole.DoClick = function()
    RunConsoleCommand("act", "salute")
    EmoteFrame:Remove()
    end

end