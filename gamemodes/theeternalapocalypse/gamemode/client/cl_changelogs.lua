function GM:MakeChangeLogs()
	surface.PlaySound("buttons/lightswitch2.wav")
	if IsValid(self.ChangeLogsFrame) then self.ChangeLogsFrame:Remove() end

	local wide,tall = 920,660
	self.ChangeLogsFrame = vgui.Create( "DFrame" )
	self.ChangeLogsFrame:SetSize(wide, tall)
	self.ChangeLogsFrame:Center()
	self.ChangeLogsFrame:SetTitle("")
	self.ChangeLogsFrame:SetDraggable(false)
	self.ChangeLogsFrame:SetVisible( true )
	self.ChangeLogsFrame:SetAlpha(0)
	self.ChangeLogsFrame:AlphaTo(255, 0.25, 0)
	self.ChangeLogsFrame:ShowCloseButton(true)
	self.ChangeLogsFrame:MakePopup()
	self.ChangeLogsFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, self.ChangeLogsFrame:GetWide(), self.ChangeLogsFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, self.ChangeLogsFrame:GetWide(), self.ChangeLogsFrame:GetTall())
	end

	local text = vgui.Create("DLabel", self.ChangeLogsFrame)
	text:SetPos(12, 4)
	text:SetFont("TargetID")
	text:SetText(Format("Newest update: %s", self.Version))
	text:SizeToContents()

	local list = vgui.Create("DPanelList", self.ChangeLogsFrame)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 20, tall - 40)
	list:SetPos(12, 32)
	list:SetPadding(8)
	list:SetSpacing(4)

	gamemode.Call("AddExtraOptions", list, self.ChangeLogsFrame)

	local function MakeText(panel, text, font, color)
		local txt = EasyLabel(panel, text, font, color or Color(205,205,205))
		-- txt:SetWrap(true)
		-- surface.SetFont(font)
		-- local x,y = surface.GetTextSize(text)
		-- txt:SetSize(x,y)
		return txt
	end

---- Help about changelogs info
---- No. there won't be any translations for changelogs.
	list:AddItem(MakeText(self.ChangeLogsFrame, "Help about changelogs: (Note: Some changes may not be accurate)", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ added", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "- removed", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+- added and something similar is removed", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; reworked", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ changed", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= balance change", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "* fixed", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? other unknown changes/fixes\n\n", "TargetIDSmall"))

	
	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.2, 31st December 2024\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "Since the Pre-0.11.2:", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added 3 new tasks", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added confirmation for clearing spawns data", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? More\n", "TargetIDSmall"))

	
	list:AddItem(MakeText(self.ChangeLogsFrame, "vPre-0.11.2, 1st June 2024\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Reworked the inventory weight system - you can now pick items up but carrying too much will result in movement speed penalty.\nAlso removed no longer needed text in some UI's.", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Infection Level now significantly affects zombie speed at 50-100+%", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Zombie Lord King can now jump if enraged", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New Miniboss Zombie: Hunter", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New perk: Speedy hands - Gives more props", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New perk: Enduring Endurance", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ A new option in Options (F4)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New task: Loot Finder", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Some weapons are now able to damage zombies more than usual", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Inventory tab now update every time the inventory is updated", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Changed how the task system works a bit, now progress now shows on C Menu", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Renamed Weight Boost III perk to Heavyweight which now also gives a slight melee damage boost", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? And More\n", "TargetIDSmall"))

	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.1b, 04 September 2023\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added confirmation for clearing spawns data", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New main menu option", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Auto-Maintenance system should now work properly", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased 'Antelope 7.62' damage 70 -> 74", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= 'Antelope 7.62' now does 2.5x increased headshot damage instead of 2x", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "* Tasks system should no longer be bugging now", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "* Bug fixes for faction structures when they're being destroyed", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? Also other changes which i couldn't log here, since it was a quick update\n", "TargetIDSmall"))


	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.1a, 02 September 2023\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Tasks system should be now functional (partly)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, [[? News: New currency will be added soon, being "Gold".
This is not a P2W element, as it will be obtainable within in-game mechanics!
Servers may make events that will obtain you gold.
]], "TargetIDSmall"))

	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.1, 27 August 2023\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added start main menu", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added tasks system (They still don't work!)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added perks system (If you joined the server from older version, you should get perk points depending on your prestige)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Added progress to pretige bar in C menu\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "- Removed perks gained from prestige, they are now re-added as perks as mentioned above", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Reworked aidrops: There now will be multiple airdrops, with increasing amount of items depending on player count!", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ You can now reach only a maximum of level 100. No, the max level with 0 prestige will remain the same, only on high prestige it is changed.", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "This makes it slightly easier to level up on higher prestige.", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased damage for AR2 Pulse Rifle 26 -> 31 and added its' bullet hit effects.", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased damage for AR2 Combine Pistol 17 -> 23 and added its' bullet hit effects.", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? Other changes and optimization", "TargetIDSmall"))


/*
	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.0 [BETA C], ?? November 2022\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New convar that allows to set death sound volume", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Changelogs panel\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Reworked death sound (sound now fades out on respawn)\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ WIP button in context menu to changelogs\n\n", "TargetIDSmall"))

	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.0 [BETA B], 17 November 2022\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New convar that allows to set death sound volume", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Changelogs panel\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Reworked death sound (sound now fades out on respawn)\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ WIP button in context menu to changelogs\n\n", "TargetIDSmall"))

	list:AddItem(MakeText(self.ChangeLogsFrame, "v0.11.0 [BETA A], 16 November 2022\n", "TargetID", Color(255,255,255)))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ ATE sweps pack into gamemode files", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ AR2 Combine Pistol & Rifle weapons", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ AWM the AWP and Steyr AUG A1 weapons from MAD Cows", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Back some ATE weapons", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New ConVars (no achievements yet)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New rarity text & color format (in inventory, trader, etc., colors vary on rarity)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Options Menu (F4)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ System can now forget the last attacker if target didn't take damage within last 15 seconds", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Function to add invalid items to invalid inventory and vice versa", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Environmental Protection (protects from environment damage)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Crafting System finally added (it is functional right?)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New Admin Command (no, this is JUST available to dev and the command can change convar values)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New Loot Type: Rare Loot Cache", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Death sounds", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New Auto-Maintenance system (server auto-restart if it's up for a long time)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ New Zombie Boss", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ More debug modes (WIP)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "+ Configurable door health\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "- Cocktail Molotov from items list (that thing can cause server crashes)\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Reworked zombie destroying doors (now they deal damage to them instead of destroying them instantly)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; Tyrant can now break doors and props", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "; New damage calculating functions\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Changed some panels to close instead of remove", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Tweaked Zombie Stats", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Zombie now damage props and doors more often", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Renamed Health skill to Vitality", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "/ Most of panels' outlines from red to yellow\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Nerfed Minigun accuracy", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Decreased The Fuckinator's damage (1000 => 800)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Decreased FN Scar firerate, increased Damage", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Decreased The Punisher damage (150 => 145)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased Bosch-Sterling B-60 damage (20 => 21)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased Blackhawk sniper damage (85 => 87)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Increased cooldown between usages for ammo pile (30sec => 40sec)", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Removed The Fuckinator from faction loot caches, airdrop faction LootTable and added to airdrop special LootTable", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "= Rebalanced M9K guns cost\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "* PvP Guarded mode giving players PvP toggling cooldown, if player with pvp enabled has damaged them\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "? And More changes i don't even know ?\n\n\n", "TargetIDSmall"))
	list:AddItem(MakeText(self.ChangeLogsFrame, "INFORMATION: I will add more changelogs soon, stay tuned.", "TargetIDSmall"))
*/

end
