---------------- HELP MENU, THAT'S TOO MUCH ----------------
/*
function GM:HelpMenu()
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

        helptext2:SetText([[You have viewed the help menu. Press a button to select a helpmenu category.
WARNING: ONLY ENGLISH IS SUPPORTED HERE CURRENTLY AND IS
CURRENTLY WORK IN PROGRESS!!]])
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
            helptext1:SetText(Format([[Gamemode made by %s, version %s.
PvE-Based Survival gamemode, with RPG elements, leveling, prestige and much more.
Remade from After The End, original creator: LegendofRobbo

General Help:
When you spawn in, you get fists and build tool. You can never lose these items. However, you
can lose some weapons, if you hold them in your hands and die. The goal is to survive with your
friends, not to get killed by zombies, find loot, level up and prestige in order to gain more
rewards. By killing zombies, you gain XP immidiately, but cash goes into your Bounty, so you have
to cash in your bounty at traders to get money. The more XP you gain, the more levels you can get
to. By the time you level up, you get a skill point and some money. Use your skill points in order
to gain more advantage in surviving this post-apocalyptic world.]], GAMEMODE.Author, GAMEMODE.Version))
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
            helptext1:SetText([[Loot Help:

In some places, a loot cache may occasionally spawn.
However, it has a low chance of spawning as a loot cache that contains a weapon.
And rarely, one may find a rare cache, containing loot in-between weapon and boss loot.
Bosses can also drop their loot cache, containing special and unique items.
Airdrop caches may also have same loot as boss caches, as well as additional items.
This includes junk items that are completely useless. Even weak weapons.

Once you pick up ANY of the loot mentioned above, including the airdrop caches being opened,
a message will be broadcasted in chat.]])
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
            helptext1:SetText([[Stats Help:

Stats are the core of this gamemode.
- Health is very important. If you health reaches 0, you die.
- Armor is half important as health. It protects 80% from some of the damage you take,
just like HL2 Armor Some damage types is NOT absorbed by armor.
- Stamina is important when running, jumping and swimming underwater, as it will cause it to go
down, depending on your Endurance level. However, moving around will reduce stamina
regeneration, even when not moving, but crouching. Landing onto ground may drain some of
your stamina. Depending on how hard you fell, sometimes your stamina is drained more.
- Both Hunger and Thirst are also important. If you do not eat, you will succumb to starvation
and die. Hunger can be countered by eating food. However, if you do not drink, you will as well
die from thirst. Thirst can be countered by drinking drinks.


Additional info:
- If your stamina is depleted, you won't be able to sprint until you get your stamina to at least 30%.]])
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

*/


function GM:HelpMenu()
    if IsValid(HelpFrame) then HelpFrame:Remove() end
    HelpFrame = vgui.Create("DFrame")
    HelpFrame:SetSize(930, 630)
    HelpFrame:SetTitle("Help Panel")
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

	local PropertySheet = vgui.Create("DPropertySheet", HelpFrame)
	PropertySheet:SetPos(10, 25)
	PropertySheet:SetSize(HelpFrame:GetWide() - 20, HelpFrame:GetTall() - 35)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 40)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25,205))
			end
		end
	end

    local function MakeList(panel)
        local list = vgui.Create("DPanelList", panel)
        list:EnableVerticalScrollbar()
        list:EnableHorizontal(false)
        list:SetSize(panel:GetWide() - 10, panel:GetTall() - 10)
        list:SetPos(12, 32)
        list:SetPadding(8)
        list:SetSpacing(4)
        return list    
    end

    local H1List = MakeList(HelpFrame)
    local H2List = MakeList(HelpFrame)
    local H3List = MakeList(HelpFrame)
    local H4List = MakeList(HelpFrame)
    local H5List = MakeList(HelpFrame)
    local H6List = MakeList(HelpFrame)
    local H7List = MakeList(HelpFrame)
    local H8List = MakeList(HelpFrame)
    
    local function MakeText(panel, text, font)
        local lab = EasyLabel(panel, text, font)
        return lab
    end

    H1List:AddItem(MakeText(HelpFrame, "Welcome to "..self.Name..". Also known as After The End Reborn.", "TargetID"))
    H1List:AddItem(MakeText(HelpFrame, Format("Gamemode made by %s, version %s.\n", self.Author, self.Version), "TargetID"))
    H1List:AddItem(MakeText(HelpFrame, "PvE-Based Survival gamemode, with RPG elements, leveling, prestige and much more.\
Remade from After The End, original creator: LegendofRobbo\n", "Trebuchet18"))
    H1List:AddItem(MakeText(HelpFrame, "This gamemode is a more difficult version of After the End (Zombie Survival RPG), bringing new functions.", "Trebuchet18"))
    H1List:AddItem(MakeText(HelpFrame, "F1 (gm_showhelp): Show help\
F2 (gm_showteam): Open Administration Panel (admin only)\
F3 (gm_showspare1): Open Drop Money Panel\
F4 (gm_showspare2): Open Options Menu panel\n\n", "TargetIDSmall"))




/*
- You can change your HUD Style you like with client ConVar tea_cl_hudstyle"
- Gamemode works the same as ZsRPG and AtE, but most of its' functions are changed"
- SELECTING BUILD TOOL FOR FIRST TIME IN SESSION HAS A CHANCE TO CRASH YOUR GAME!!"
(Couldn't fix, but more likely to happen later, so equip that weapon on joining)"
- If you encounter any problem, error, or any kind of mistranslation, report it to the dev."
Good hunting. (this panel may be changed every update)
*/

    H1List:AddItem(MakeText(HelpFrame, "General Help:\n", "Trebuchet24"))
    H1List:AddItem(MakeText(HelpFrame, "When you spawn in, you get fists and build tool. The goal is to survive with your\
friends, not to get killed by zombies, find loot, level up and prestige in order to gain more\
rewards. By killing zombies, you gain XP in an instant, but cash goes into your Bounty, so you have\
to cash in your bounty at traders to get money. The more XP you gain, the more levels you can get\
to. By the time you level up, you get a skill point and some money. Use your skill points strategically,\
in order to gain more advantage in surviving this post-apocalyptic world.\n", "TargetIDSmall"))
    H1List:AddItem(MakeText(HelpFrame, "Note: If you are new to the server and are below level 10 and prestige 0,\
you gain following buffs to get started:\
• -10% damage taken from zombies\
• +15% damage dealt to zombies", "TargetIDSmall"))


    H2List:AddItem(MakeText(HelpFrame, "Press and hold TAB (scoreboard key) to open your inventory\
You will find starting items for your survival here.", "TargetIDSmall"))
    H2List:AddItem(MakeText(HelpFrame, "Factions system is a feature to the gamemode, being able to make team.", "TargetIDSmall"))
    
    H3List:AddItem(MakeText(HelpFrame, "There are around 7 types of normal zombies. Each of them have unique abilities.", "TargetIDSmall"))
    H3List:AddItem(MakeText(HelpFrame, "Killing them gives XP and cash. You gain XP in an instant, but cash goes through bounty. To receive cash,\
go to trader and cash your bounty in. Otherwise, you will die with 30-40% of your bounty pool.", "TargetIDSmall"))
    H3List:AddItem(MakeText(HelpFrame, "There are also 2 bosses. Killing a boss grants you Cash and XP, whatever amount of damage you did to the boss.\
Dealing higher damage can grant you more cash and XP, when also dealt highest amount of damage,\
grants you being able to pickup the boss loot.\n", "TargetIDSmall"))
    H3List:AddItem(MakeText(HelpFrame, "Beware of the zombies! If you die to a zombie, you will lose 1% of your XP, or 0.4% if it's a boss zombie, this only\
happens if you have less than level 10 and prestige 0.\
Max possible value of losing XP is 250. This feature is currently "..(self.PlayerLoseXPOnDeath and "enabled" or "disabled")..".\
Note that infection level doesn't decrease when new players are killed by zombies!", "TargetIDSmall"))

    H4List:AddItem(MakeText(HelpFrame, "Factions system is a feature to the gamemode, being able to make team.", "TargetIDSmall"))
    H4List:AddItem(MakeText(HelpFrame, "Creating a faction is not that hard. Open scoreboard (TAB key), navigate to factions\
category, then Create faction.", "TargetIDSmall"))
    H4List:AddItem(MakeText(HelpFrame, "Note, that some money to create a faction.", "TargetIDSmall"))

    H5List:AddItem(MakeText(HelpFrame, "Want to fight for loot? Make competition? Toggle PVP and annihilate your enemies!", "TargetIDSmall"))
    H5List:AddItem(MakeText(HelpFrame, "PVP is a feature in this gamemode where you fight against other survivors. Beware,\
if you die while holding a weapon, you drop it. This does not count for some weapons. When you get damaged by, or damage a\
player, you will not be able to disable your PVP for certain amount of time. (Base: 60 seconds)", "TargetIDSmall"))

    H6List:AddItem(MakeText(HelpFrame, "New feature in this gamemode, crafting.", "TargetIDSmall"))
    H6List:AddItem(MakeText(HelpFrame, "(This section is still in progress.)", "TargetIDSmall"))

    H7List:AddItem(MakeText(HelpFrame, "New feature: Infection Level", "TargetID"))
    H7List:AddItem(MakeText(HelpFrame, "Infection Level is also known as dynamic difficulty scaling. As Infection Level goes up, some things change.", "TargetIDSmall"))
    H7List:AddItem(MakeText(HelpFrame, "- More XP gained from killing zombies\
- More Cash gained from killing zombies, but 50% less effects than XP\
- Zombies take less damage\
- Zombies deal more damage to players and barricades", "TargetIDSmall"))
    H7List:AddItem(MakeText(HelpFrame, "\nNormal Difficulty scaling: (Difficulty: Low, Medium, Hard, etc.)\
- Will be added in future update.", "TargetIDSmall"))

    H8List:AddItem(MakeText(HelpFrame, "(WORK IN PROGRESS) Seasonal Events:", "TargetID"))
    H8List:AddItem(MakeText(HelpFrame, "[Halloween Event] 25th October (25/10) -- 3rd November (3/11)\
- All zombies give 25% more XP\
- There is a higher chance of elite zombies making an appearance!\
Lasts for 10 days", "TargetIDSmall"))
    H8List:AddItem(MakeText(HelpFrame, "[Christmas Event] 19th December (19/12) -- 3rd January (3/1)\
- All zombies give 15% more XP\
- Zombies have chance to spawn gift when killed (2% chance), Elite Zombies have higher chance to drop gifts, 10% chance!\
Bosses have 33.3% chance to drop gift (33.3% chance), gifts from bosses have much higher quality loot from gift!\
Gifts from Elite Boss Zombies are 100%!\
Lasts for 15 days", "TargetIDSmall"))
    H8List:AddItem(MakeText(HelpFrame, "idk", "TargetIDSmall"))

    PropertySheet:AddSheet("About this gamemode", H1List, nil, false, false, "Section to let you know and what to do in this gamemode\
Along with survival basics in the post-apocalyptic world")
    PropertySheet:AddSheet("Inventory and Traders", H2List, nil, false, false, "How to manage your inventory and how traders work")
    PropertySheet:AddSheet("Zombies", H3List, nil, false, false, "What zombies do and what they give when you kill them")
    PropertySheet:AddSheet("Factions", H4List, nil, false, false, "Creating a faction, managing it and its' functions")
    PropertySheet:AddSheet("PvP", H5List, nil, false, false, "Learn tactics of fighting against players and how it works")
    PropertySheet:AddSheet("Crafting", H6List, nil, false, false, "How crafting works")
    PropertySheet:AddSheet("Infection Level", H7List, nil, false, false, "Learn about Infection Level. How to increase it and how it works.")
    PropertySheet:AddSheet("Other", H8List, nil, false, false, "Anything else.")

end

