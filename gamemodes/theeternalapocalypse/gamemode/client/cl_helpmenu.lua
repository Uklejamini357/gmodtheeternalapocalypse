---------------- HELP MENU, THAT'S TOO MUCH (Nope) ----------------


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
    HelpFrame.Paint = function(panel)
        draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 230))
        surface.SetDrawColor(255,255,255, 255)
        surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
    end

	local helpList = vgui.Create("DPropertySheet", HelpFrame)
	helpList:SetPos(10, 25)
	helpList:SetSize(HelpFrame:GetWide() - 20, HelpFrame:GetTall() - 35)
	helpList.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 40)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		for k, v in pairs(panel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25,205))
			end
		end
	end

    local htmlpanel = vgui.Create("DHTML", helpList)
    htmlpanel:StretchToParent(4, 4, 4, 24)
    htmlpanel:SetHTML([[<html>
    <head>
    <style type="text/css">
    body
    {
        font-family:tahoma;
        font-size:16px;
        color:white;
        background-color: #00000020;
        width:]].. htmlpanel:GetWide() - 48 ..[[px;
    }
    div p
    {
        margin:10px;
        padding:2px;
    }

    h1 {
        color: maroon
    }

    h2 {
        color: maroon
    }

    a {
        color: green
    }
    
    a:hover {
        color: yellow;
    }
    </style>
    </head>

    <body>
    <h1> Welcome to The Eternal Apocalypse!</h1>
<p>A gamemode based on a survival gamemode from 2015 made by LegendOfRobbo, with expanded ideas.<br>
</p>

<ul>
<li><a href="#Differences">Differences</a></li>
<li><a href="#How to play">How to play</a></li>
<li><a href="#Your character">Your character</a></li>
<li><a href="#Zombies">Zombies</a></li>
<li><a href="#Traders">Traders</a></li>
<li><a href="#Loot">Loot</a></li>
<li><a href="#Levels and Skills">Levels and Skills</a></li>
<li><a href="#Prestige and Perks">Prestige and Perks</a></li>
<li><a href="#Props and Barricading">Props and Barricading</a></li>
<li><a href="#PVP">PVP</a></li>
<li><a href="#Factions">Factions</a></li>
<li><a href="#Infection Level and Zombie levels">Infection Level and Zombie levels</a></li>
</ul>

<h2 id="Differences">Differences</h2>
<p>This gamemode is pretty much the same as the original. Survive, shoot zombies, find loot, level up, become stronger. However, many new mechanics that alter the gameplay have been introduced, such as:</p>
<ul>
<li>Thirst bar</li>
<li>Zombie Levels, Elite Variants and Minibosses</li>
<li>Reworked Inventory system</li>
<li>Tasks system</li>
<li>Prestige and Perks</li>
<li>Mastery system</li>
<li>New zombies</li>
<li>And many more. There's a lot to discover!</li>
</ul>

<h2 id="How to play">How to play</h2>
<p>This section is probably the most important. The gameplay at first may be confusing, however it's suprisingly easy to learn how to play!</p>
<p>Once you spawn in, your first priority is to get a weapon equipped so you have something you can defend yourself with. To do so, open your inventory by pressing Q, or any spawn menu key and clicking on the item. Weapons need ammo, and in order to get ammo, you can use the ammo items as well.</p>
<p>After that, you will want to shoot the zombies in order to gain cash and experience. You gain experience instantly, however the cash goes through bounty. You can cash in your bounty at traders in order to gain cash. However if you end up dying with the bounty on you, you end up dropping your bounty as cash, along with the rest of your bounty being lost forever.</p>
<p>Traders act as a shop where you can stop by to buy stronger equipment, or to refill your supplies. You also gain a slight damage resistance against zombies when you are near traders.</p>
<p>And that's pretty much it! The rest of the content can be discovered through gameplay. However, you may continue reading the rest of the sections below to have better understanding for this gamemode.</p>

<h2 id="Your character">Your character</h2>
<p>Just like in other survival games, you can't just survive without having any supplies. If you go long without supplies, you die.</p>
<p>There are several notable stats to keep track of:</p>
<ul>
<li>Health: Self-explanatory. If it reaches 0, you die.</li>
<li>Armor: Absorbs 80% of damage, some of the damage types is ignored.</li>
<li>Stamina: Determines your character's remaining strength. Regenrates constantly. Drained by movement and melee attacks. Lower stamina </li>
<li>Hunger: Determines if a character is well-fed. If it reaches 0%, you start losing health and then die.</li>
<li>Thirst: Defines if a character is hydrated. If it reaches 0%, you start dying.</li>
<li>Fatigue: Determines if character needs to sleep. Unless you are sleeping, fatigue gradually increases. If it reaches 100%, you start dying.</li>
<li>Infection: Determines if a character has infection and needs a cure. Only increases if you are infected. If it reaches 100%, you start dying.</li>
</ul>
<p>If you end up succumbing to zombies or dying, you will drop 30-40% of your bounty along with your currently held weapon.</p>

<h2 id="Zombies">Zombies</h2>
<p>As you play, you will discover different zombies with different abilities. These zombies can range from being weak and with almost no danger to being tough and very dangerous.</p>
<p>The list below is the list of the zombies you'll certainly encounter.</p>

<ol>
<li>Tier 1</li>
<ul>
<li>Shambler zombie: A normal zombie. Has no unique abilities.</li>
<li>Leaper zombie: A fast, but weak zombie. Can leap high up into air from the ground.</li>
<li>Wraith Zombie: A fast, but weakest zombie of all. Hard to see when not attacking and can temporarily blind survivors.</li>
</ul>
<li>Tier 2</li>
<ul>
<li>Tank Zombie: Tough, but slow zombie. Has no unique abilities.</li>
<li>Puker Zombie: Pukes poison at target. On death poisons nearby targets.</li>
</ul>
<li>Tier 3:</li>
<ul>
<li>Tormented Wraith: Same as Wraith zombie, but stronger. Gradually gains speed when seeing target.</li>
<li>Lord Zombie: The lord of zombies. Has high health, can knock targets far away. The zombie teleports randomly if it takes too much damage. The zombie can also grant buff nearby zombies in mid range.</li>
</ul>
<li>Tier 4 (Minibosses):</li>
<ul>
<li>Superlord Zombie: Same as Lord Zombie, but stronger! Enrages if it reaches low health, causing it to be more aggressive!</li>
<li>Heavy Tank Zombie: Very slow, but also very strong zombie. Its hits pack a hard punch. Can reflect melee damage back to its attacker.</li>
<li>Hunter Zombie: Very agile and highly dangerous zombie. Many survivors are lost by this zombie, don't let it hunt you!</li>
</ul>
<li>Bosses:</li>
<ul>
<li>The Tyrant: A highly dangerous and fast boss zombie. Has extremely high health, throws rocks that can damage nearby players, can cause shockwave that damages nearby survivors on ground. After reaching <30% health, the boss enrages, causing its attacks to be more aggressive.</li>
<li>Zombie Lord King: The lord of all the zombies. Has extremely high health. Its attacks knock back survivors far and slows them down. Teleports upon taking a significant damage. Can buff and randomly teleport nearby zombies. Upon reaching <30% health, the boss enrages, making it able to jump every several seconds, teleporting more often, inflicting stronger hits and slowing down even harder.</li>
</ul>
</ol>



<h2 id="Loot">Loot</h2>
<p>Around the map, you will find loot caches. Loot caches contain items, from commonly found supplies to rare weapons. Loot caches vary between their types, so each loot cache may be different.</p>
<p>First is the normal loot caches. They vary between 5 rarities, from Common to Legendary. Higher rarity loot means higher</p>
<p>Second type is the boss loot cache. They're dropped by the defeated bosses and contain very rare weapons that aren't found elsewhere.</p>
<p>And the last one is the faction loot cache. They only drop by destroying other faction's base cores.</p>

<h2 id="Traders">Traders</h2>
<p>Traders can be found across the map. They sell supplies to you for money, but they can also buy stuff from you.</p>
<p>You can also cash in your bounty at traders. Traders will pay you money from the bounty you had.</p>
<p>They also act as a PVP protection. When you are close to traders, your pvp is set to guarded. Therefore, any players near it cannot be damaged by other players in any circumstances.</p>
<p>Additionally, you take 10% less damage from zombies when you are near traders.</p>

<h2 id="Levels and Skills">Levels and Skills</h2>
<p>After reaching a certain amount of XP, you will level up and receive a new skill point!</p>
<p>Skill points can be assigned to skills to increase your stats and potentially.</p>
<p>After reaching level 30, you will start to gain 2 skill points for each level and after level 55, you gain 3 skill points per level.</p>
<p>Max level has a limit. Once you reach it, you cannot level up anymore and you must prestige to go further. Prestiging will also slightly increase max level.</p>

<h2 id="Prestige and Perks">Prestige and Perks</h2>
<p>Prestige is a "Reset" functionality that adds more progression to the gamemode. Prestiging is possible after reaching certain level.</p>
<p>Upon prestiging, you will lose all levels, skills, and skill points, but you will gain an extra perk point.</p>
<p>Prestiges have no limit, so try to reach as far as possible!</p>
<p>Perks are technically skills that grant unique buffs to your character. However, instead of skill points, they cost perk points instead.</p>
<p>For each perk, to be able to unlock it you need to reach certain prestige. Additionally, more powerful perks cost more perk points, so plan accordingly!</p>
<p>Perks can be reset, however you need to spend your cash in order to reset your perks. The cost is added for each perk point spent.</p>

<h2 id="Props and Barricading">Props and Barricading</h2>
<p>Sometimes, you might want to make a base so you can rest. Fortunately enough, you are able to build props!</p>
<p>All you need is some money and a builder's wrench. Then spawn in a prop with your build tool and swing with the wrench to build it!</p>
<p>And that's pretty much it! </p>
<p>Props can be found under 4th category "Props", found in the inventory menu.</p>
<p style="color:red">Warning: All built props disappear when you leave the game.</p>

<h2 id="PVP">PVP</h2>
<p>The Eternal Apocalypse is not only about PvE. PVP also exists!</p>

<h2 id="Factions">Factions</h2>
<p></p>

<h2 id="Infection Level and Zombie levels">Infection Level and Zombie levels</h2>
<p></p>

</body>
</html>]])

    helpList:AddSheet("Help", htmlpanel, nil, false, false, "Guide you might want to read if you're starting out.")

end

