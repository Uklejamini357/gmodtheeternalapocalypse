---------------- HELP MENU, THAT'S TOO MUCH ----------------

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
        draw.RoundedBox(2, 0, 0, HelpFrame:GetWide(), HelpFrame:GetTall(), Color(0, 0, 0, 230))
        surface.SetDrawColor(150, 150, 0 ,255)
        surface.DrawOutlinedRect(0, 0, HelpFrame:GetWide(), HelpFrame:GetTall())
    end

    local helptext1 = vgui.Create("DLabel", HelpFrame)
    local helptext2 = vgui.Create("DLabel", HelpFrame)
    helptext2:SetFont("TargetIDSmall")
    helptext2:SetColor(Color(205,205,205,255))
    helptext2:SetPos(20, 30)

    local button1 = vgui.Create("DButton", HelpFrame)
    local button2 = vgui.Create("DButton", HelpFrame)
    local button3 = vgui.Create("DButton", HelpFrame)

    function DoBackButton()
        button1:SetPos(20, HelpFrame:GetTall() - 60)
        button1:SetText("Back")
        button1:SetToolTip()
        button2:SetVisible(false)
        button3:SetVisible(false)
        button1.Paint = function(panel)
            surface.SetDrawColor(150, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, button1:GetWide(), button1:GetTall())
            draw.RoundedBox(2, 0, 0, button1:GetWide(), button1:GetTall(), Color(0, 0, 0, 130))
        end
        button1.DoClick = function()
            DoHelpMenu()
        end
    end

    function DoHelpMenu()
        if !IsValid(HelpFrame) then return end
        HelpFrame:SetTitle("Help Menu - IN PROGRESS")
        helptext2:SetVisible(true)
        helptext1:SetFont("TargetIDSmall")
        helptext1:SetColor(Color(205,205,205,255))
        helptext1:SetText("")
        helptext1:SetPos(20, 30)
        helptext1:SizeToContents()

        helptext2:SetText("You have viewed the help menu. Press a button to select a helpmenu category.\
WARNING: ONLY ENGLISH IS SUPPORTED HERE CURRENTLY AND IS\
CURRENTLY WORK IN PROGRESS!!")
        helptext2:SizeToContents()

        button1:SetSize(120, 30)
        button1:SetPos(20, 155)
        button1:SetText("About This Gamemode")
        button1:SetToolTip("Shows general info about this gamemode and some help")
        button1:SetTextColor(Color(255,255,255,255))
        button1.Paint = function(panel)
            surface.SetDrawColor(150, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, button1:GetWide(), button1:GetTall())
            draw.RoundedBox(2, 0, 0, button1:GetWide(), button1:GetTall(), Color(0, 0, 0, 130))
        end
        button1.DoClick = function()
            ClearHelpMenu()
            HelpFrame:SetTitle("Help Menu (About This Gamemode)")
            helptext1:SetText("Gamemode made by "..GAMEMODE.Author..", version "..GAMEMODE.Version..".\
PvE-Based Survival gamemode, with RPG elements, leveling, prestige and much more.\
Remade from After The End, original creator: LegendofRobbo\
\
General Help:\
When you spawn in, you get fists and build tool. You can never lose these items. However, you\
can lose some weapons, if you hold them in your hands and die. The goal is to survive with your\
friends, not to get killed by zombies, find loot, level up and prestige in order to gain more\
rewards. By killing zombies, you gain XP immidiately, but cash goes into your Bounty, so you have\
to cash in your bounty at traders to get money. The more XP you gain, the more levels you can get\
to. By the time you level up, you get a skill point and some money. Use your skill points in order\
to gain more advantage in surviving this post-apocalyptic world.")
            helptext1:SizeToContents()
    
            DoBackButton()
        end

        button2:SetSize(120, 30)
        button2:SetPos(20, 195)
        button2:SetText("Loot Help")
        button2:SetTextColor(Color(255,255,255,255))
        button2:SetVisible(true)
        button2.Paint = function(panel)
            surface.SetDrawColor(150, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, button2:GetWide(), button2:GetTall())
            draw.RoundedBox(2, 0, 0, button2:GetWide(), button2:GetTall(), Color(0, 0, 0, 130))
        end
        button2.DoClick = function()
            ClearHelpMenu()
            HelpFrame:SetTitle("Help Menu (Loot)")
            helptext1:SetText("Loot Help:\
\
In some places, a loot cache may occasionally spawn.\
However, it has a low chance of spawning as a loot cache that contains a weapon.\
And rarely, one may find a rare loot cache, containing loot in-between weapon and boss loot.\
Bosses can also drop their loot cache, containing special and unique items.\
Airdrop caches may also have same loot as boss caches, as well as additional items.\
This includes junk items that are completely useless. Even weak weapons.\
\
Once you pick up ANY of the loot mentioned above, including the airdrop caches being opened,\
a message will be broadcasted in chat.")
            helptext1:SizeToContents()
    
            DoBackButton()
        end
        

        button3:SetSize(120, 30)
        button3:SetPos(20, 235)
        button3:SetText("Stats Help")
        button3:SetTextColor(Color(255,255,255,255))
        button3:SetVisible(true)
        button3.Paint = function(panel)
            surface.SetDrawColor(150, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, button3:GetWide(), button3:GetTall())
            draw.RoundedBox(2, 0, 0, button3:GetWide(), button3:GetTall(), Color(0, 0, 0, 130))
        end
        button3.DoClick = function()
            ClearHelpMenu()
            HelpFrame:SetTitle("Help Menu (Stats)")
            helptext1:SetText("Stats Help:\
\
Stats are the core of this gamemode.\
- Health is very important. If you health reaches 0, you die.\
- Armor is half important as health. It protects 80% from some of the damage you take,\
just like HL2 Armor Some damage types is NOT absorbed by armor.\
- Stamina is important when running, jumping and swimming underwater, as it will cause it to go\
down, depending on your Endurance level. However, moving around will reduce stamina\
regeneration, even when not moving, but crouching. Landing onto ground may drain some of\
your stamina. Depending on how hard you fell, sometimes your stamina is drained more.\
- Both Hunger and Thirst are also important. If you do not eat, you will succumb to starvation\
and die. Hunger can be countered by eating food. However, if you do not drink, you will as well\
die from thirst. Thirst can be countered by drinking drinks.\
\
\
Additional info:\
- If your stamina is depleted, you won't be able to sprint until you get your stamina to at least 30%.")
            helptext1:SizeToContents()
    
            DoBackButton()
        end
        

    end
    DoHelpMenu()

    function ClearHelpMenu()
        if !IsValid(HelpFrame) then return end
        helptext2:SetText("")
    end
end

