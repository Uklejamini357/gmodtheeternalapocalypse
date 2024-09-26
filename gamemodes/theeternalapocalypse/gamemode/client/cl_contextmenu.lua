-------------------------------- Context Menu --------------------------------


local function ContextMenuOpen(self)
	if ( !hook.Call( "ContextMenuOpen", self ) ) then return end

	if ( IsValid( g_ContextMenu ) && !g_ContextMenu:IsVisible() ) then
		g_ContextMenu:Open()
		menubar.ParentTo( g_ContextMenu )
	end
	
	hook.Call( "ContextMenuOpened", self )
end

local function ContextMenuClose(self)
	if ( IsValid( g_ContextMenu ) ) then g_ContextMenu:Close() end
	hook.Call( "ContextMenuClosed", self )
end

function GM:OnContextMenuOpen()
	if IsValid(ContextMenu) then return end
	if SuperAdminCheck(LocalPlayer()) and input.IsShiftDown() then
		ContextMenuOpen(self)
		return true
	end

	self:CMenu()
	ContextMenu:SetVisible(true)
end

function GM:OnContextMenuClose()
	if g_ContextMenu:IsVisible() then
		ContextMenuClose(self)
	end

	if !IsValid(ContextMenu) then return end
	ContextMenu:SetVisible(false)
	ContextMenu:Remove()
end

local dynprogress = 0
function GM:CMenu()
	local scw = ScrW()
	local sch = ScrH()

	ContextMenu = vgui.Create("DFrame")
	ContextMenu:SetSize(scw, sch)
	ContextMenu:Center()
	ContextMenu:SetTitle("")
	ContextMenu:SetDraggable(false)
	ContextMenu:SetVisible(true)
	ContextMenu:ShowCloseButton(false)
	ContextMenu.Paint = function(panel)
		local wep = LocalPlayer():GetActiveWeapon()
		if wep:IsValid() then

			local raretbl = {}
			if self.ItemsList[wep:GetClass()] then
				raretbl = gamemode.Call("CheckItemRarity", self.ItemsList[wep:GetClass()].Rarity)
			end
			raretbl.col = raretbl.col or color_white

			surface.SetDrawColor(0, 0, 0, 105)
			surface.DrawRect(200, sch / 2 - 150, 400, 300)
			surface.SetDrawColor(150, 150, 0, 105)
			surface.DrawOutlinedRect(200, sch / 2 - 150, 400, 300)

			local name = wep.PrintName or wep:GetClass()
			local y = 145
			draw.DrawText(translate.Format("wep_name", name), "TargetID", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
			if name ~= wep:GetClass() then
				y = y - 20
				draw.DrawText(translate.Format("wep_class", wep:GetClass()), "TargetID", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			y = y - 25

			if wep.Primary then
				local wep_prim = wep.Primary
				local class = wep:GetClass()
				local delay = math.Round(wep_prim.Delay or 1 / ((wep_prim.RPM or 0) / 60) or 1, 3)

				local usemulshots = wep_prim.NumShots and wep_prim.NumShots ~= 0 and wep_prim.NumShots ~= 1
				draw.DrawText(Format("Damage: %s (Max DPS: %s)",
					usemulshots and wep_prim.Damage.." x ".. wep_prim.NumShots or wep_prim.Damage, math.Round((usemulshots and wep_prim.Damage * wep_prim.NumShots or wep_prim.Damage or 0) / (delay), 2)
				), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15

				draw.DrawText(Format("Attack Delay: %s", delay), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15
				if wep_prim.ClipSize ~= -1 then
					draw.DrawText(Format("Clip size: %s", wep_prim.ClipSize), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					y = y - 15
				end
				draw.DrawText(Format("Recoil: %s", wep_prim.Recoil), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15
				if wep.HitDistance then
					draw.DrawText(Format("Hit distance: %s", wep.HitDistance), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15
				end
				draw.DrawText(Format("Is automatic: %s", wep_prim.Automatic), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15

				local dmgvszms = wep.DamageVsZombiesMul or self.WeaponDamageVsZombiesMul[class]
				if dmgvszms then
					draw.DrawText(Format("Damage against zombies: %sx", dmgvszms), "TargetIDSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					y = y - 15
				end
			end
		end


		local y2 = 155

		local tasktbl = self.Tasks[self.CurrentTask]
		if tasktbl then
			surface.SetDrawColor(0, 0, 0, 105)
			surface.DrawRect(scw/2 - 160, 150, 320, 100)
			surface.SetDrawColor(150, 150, 0, 105)
			surface.DrawOutlinedRect(scw/2 - 160, 150, 320, 100)

			draw.DrawText(Format("Current Task: %s", tasktbl.Name), "TargetIDSmall", scw/2 - 155, y2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			y2 = y2 + 15

			draw.DrawText(Format("Progress: %s/%s", self.CurrentTaskProgress, tasktbl.ReqProgress), "TargetIDSmall", scw/2 - 155, y2, LocalPlayer():HasCompletedTask() and Color(155,255,155) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			y2 = y2 + 15

		end

		if self.InfectionLevelEnabled then
			surface.SetDrawColor(0, 0, 0, 105)
			surface.DrawRect(scw - 600, sch / 2 - 150, 400, 300)
			surface.SetDrawColor(150, 150, 0, 105)
			surface.DrawOutlinedRect(scw - 600, sch / 2 - 150, 400, 300)
/*
			surface.SetDrawColor(0, 0, 0, 200)
			surface.DrawRect(140, 115, 180, 25)
			surface.SetDrawColor(90, 90, 0, 255)
			surface.DrawOutlinedRect(140, 115, 180, 25)
*/
			local infection = math.Round(self:GetInfectionLevel(), 2)
			local text,color

			if infection >= 200 then
				text,color = "Chaotic", Color(91,31,31)
			elseif infection >= 150 then
				text,color = "Nightmare", Color(127,31,31)
			elseif infection >= 125 then
				text,color = "Horror", Color(191,31,31)
			elseif infection >= 100 then
				text,color = "Maximal", Color(255,0,0)
			elseif infection >= 90 then
				text,color = "Infected", Color(255,63,63)
			elseif infection >= 75 then
				text,color = "Very hard", Color(255,127,127)
			elseif infection >= 55 then
				text,color = "Hard", Color(191,127,127)
			elseif infection >= 25 then
				text,color = "Normal", Color(191,191,127)
			elseif infection >= 10 then
				text,color = "Average", Color(127,255,127)
			else
				text,color = "Easy", Color(127,255,255)
			end


			draw.SimpleText(Format("Infection level: %s%%", infection), "TargetID", scw - 590, sch / 2 - 145, color, 0, 0)

			draw.SimpleText(Format("Difficulty level: %s", text), "TargetIDSmall", scw - 590, sch / 2 - 120, color, 0, 0)
			draw.SimpleText(Format("Zombies take: %s%% damage", math.Round(1 / self:GetInfectionMul()*100, 2)), "TargetIDSmall", scw - 590, sch / 2 - 105, color, 0, 0)
			draw.SimpleText(Format("Zombies deal: %s%% damage", math.Round(self:GetInfectionMul(0.5)*100, 2)), "TargetIDSmall", scw - 590, sch / 2 - 90, color, 0, 0)
			draw.SimpleText(Format("Zombie cash reward: %s%%", math.Round(self:GetInfectionMul(0.5)*100, 2)), "TargetIDSmall", scw - 590, sch / 2 - 75, color, 0, 0)
			draw.SimpleText(Format("Zombie xp reward: %s%%", math.Round(self:GetInfectionMul()*100, 2)), "TargetIDSmall", scw - 590, sch / 2 - 60, color, 0, 0)
			draw.SimpleText(Format("Zombie speed: %s%%", math.Round(math.Clamp(self:GetInfectionMul(0.5)-0.25, 1, 1.25)*100, 2)), "TargetIDSmall", scw - 590, sch / 2 - 45, color, 0, 0)
			draw.SimpleText(Format("Elite variant spawn chance: %s%%", math.Round(self:GetEliveVariantSpawnChance(false), 2)), "TargetIDSmall", scw - 590, sch / 2 - 25, color, 0, 0)
			draw.SimpleText(Format("Elite variant Boss spawn chance: %s%%", math.Round(self:GetEliveVariantSpawnChance(true), 2)), "TargetIDSmall", scw - 590, sch / 2 - 10, color, 0, 0)
			
			
			draw.SimpleText("Infection Level gain decreases at 50% and 75%.", "TargetIDSmall", scw - 590, sch / 2 + 95, Color(225,225,225), 0, 0)
			draw.SimpleText("Above 100% the gain decreases even further.", "TargetIDSmall", scw - 590, sch / 2 + 110, Color(225,225,225), 0, 0)
			draw.SimpleText(Format("Infection Level gain from killing zombies: %s%%", math.Round((self:GetInfectionLevel() >= 100 and 0.25/(self:GetInfectionMul()-1) or
				self:GetInfectionLevel() >= 75 and 0.5 or
				self:GetInfectionLevel() >= 50 and 0.75 or
			1.00)*100, 2)), "TargetIDSmall", scw - 590, sch / 2 + 130, Color(255,155,155), 0, 0)
		end

		surface.DrawCircle(panel:GetWide() / 2, panel:GetTall() / 2, 150, Color(100, 100, 100, 205))
		surface.DrawCircle(panel:GetWide() / 2, panel:GetTall() / 2, 140, Color(100, 100, 100, 205))

	
	end
	ContextMenu.Think = function()
	end
	ContextMenu:MakePopup()
	ContextMenu:SetKeyboardInputEnabled(false)


	local ContextMenu2 = vgui.Create("DFrame", ContextMenu)
	ContextMenu2:SetSize(scw * 0.6, 30)
	ContextMenu2:SetPos(scw * 0.2, 70)
	ContextMenu2:SetTitle("")
	ContextMenu2:SetToolTip("Progress to Prestige")
	ContextMenu2:SetDraggable(false)
	ContextMenu2:ShowCloseButton(false)
	ContextMenu2.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 105)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.SetDrawColor(150, 150, 0, 105)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())

		local progress = LocalPlayer():GetProgressToPrestige()
		dynprogress = math.Approach(dynprogress, progress, math.Round((progress - dynprogress) * 0.04, 6))

		surface.SetDrawColor(50, 150, 150, 205)
		surface.DrawRect(0, 0, dynprogress * panel:GetWide(), panel:GetTall())

		draw.SimpleText(string.format("%s%%", math.Round(dynprogress * 100, 2)), "TargetID", dynprogress * panel:GetWide() * 0.5, panel:GetTall() * 0.5, Color(80, 255, 255, 205), dynprogress > 0.5 and TEXT_ALIGN_CENTER or TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end



	local buttonsize_x, buttonsize_y = 120, 40
	local clearprops = vgui.Create("DButton", ContextMenu)
	clearprops:SetSize(buttonsize_x, buttonsize_y)
	clearprops:Center()
	local x,y = clearprops:GetPos()
	clearprops:SetPos(x - 175, y - 125)
	clearprops:SetText(translate.Get("clearprops"))
	clearprops:SetTextColor(Color(255,155,155,255))
	clearprops.Paint = function(panel)
		surface.SetDrawColor(250, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	clearprops.DoClick = function()
		RunConsoleCommand("-menu_context")
		gamemode.Call("ConfirmPropDestroy")
	end

	local prestige = vgui.Create("DButton", ContextMenu)
	prestige:SetSize(buttonsize_x, buttonsize_y)
	prestige:Center()
	x,y = prestige:GetPos()
	prestige:SetPos(x + 175, y - 125)
	prestige:SetText(translate.Get("doprestige1"))
	prestige:SetTextColor(Color(255, 255, 0, 255))
	prestige.Paint = function(panel)
		surface.SetDrawColor(150, 150, 200, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	prestige.DoClick = function()
		RunConsoleCommand("-menu_context")
		self:WantToPrestige()
	end

	local perks = vgui.Create("DButton", ContextMenu)
	perks:SetSize(buttonsize_x, buttonsize_y)
	perks:Center()
	x,y = perks:GetPos()
	perks:SetPos(x + 175, y + 125)
	perks:SetText("Perks")
	perks:SetTextColor(Color(255, 255, 255, 255))
	perks.Paint = function(panel)
		surface.SetDrawColor(150, 250, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	perks.DoClick = function()
		RunConsoleCommand("-menu_context")
		gamemode.Call("CallPerksMenu")
	end

	local refreshinv = vgui.Create("DButton", ContextMenu)
	refreshinv:SetSize(buttonsize_x, buttonsize_y)
	refreshinv:Center()
	x,y = refreshinv:GetPos()
	refreshinv:SetPos(x - 175, y + 125)
	refreshinv:SetText(translate.Get("refreshinv"))
	refreshinv:SetTextColor(Color(75, 150, 225, 255))
	refreshinv.Paint = function(panel)
		surface.SetDrawColor(0, 100, 150, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	refreshinv.DoClick = function()
		RunConsoleCommand("-menu_context")
		RunConsoleCommand("refresh_inventory")
	end

	local ver = vgui.Create("DButton", ContextMenu)
	ver:SetSize(buttonsize_x, buttonsize_y)
	ver:Center()
	x,y = ver:GetPos()
	ver:SetPos(x, y - 180)
	ver:SetText("IN PROGRESS")
	ver:SetToolTip("Will have: Other commands (as a panel)")
	ver:SetTextColor(Color(255, 255, 0, 255))
	ver.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	ver.DoClick = function() end

	local cash = vgui.Create("DButton", ContextMenu)
	cash:SetSize(buttonsize_x, buttonsize_y)
	cash:Center()
	x,y = cash:GetPos()
	cash:SetPos(x + 220, y)
	cash:SetText(translate.Get("dropcash"))
	cash:SetTextColor(Color(255, 255, 255, 255))
	cash.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	cash.DoClick = function()
		gamemode.Call("DropGoldMenu")
		RunConsoleCommand("-menu_context")
	end


	local pvp = vgui.Create("DButton", ContextMenu)
	pvp:SetSize(buttonsize_x, buttonsize_y)
	pvp:Center()
	x,y = pvp:GetPos()
	pvp:SetPos(x, y + 180)
	pvp:SetText(translate.Get("togglepvp"))
	pvp:SetTextColor(Color(255, 255, 255, 255))
	pvp.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	pvp.DoClick = function()
		RunConsoleCommand("tea_togglepvp")
		RunConsoleCommand("-menu_context")
	end

	local emotes = vgui.Create("DButton", ContextMenu)
	emotes:SetSize(buttonsize_x, buttonsize_y)
	emotes:Center()
	x,y = emotes:GetPos()
	emotes:SetPos(x - 220, y)
	emotes:SetText(translate.Get("emotes"))
	emotes:SetTextColor(Color(255, 255, 255, 255))
	emotes.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emotes.DoClick = function()
		RunConsoleCommand("-menu_context")
		gamemode.Call("Emotes")
	end

end


function GM:ConfirmPropDestroy()
	local ConfirmFrame = vgui.Create("DFrame")
	ConfirmFrame:SetSize(300, 200)
	ConfirmFrame:Center()
	ConfirmFrame:SetTitle(translate.Get("clearingprops"))
	ConfirmFrame:SetDraggable(false)
	ConfirmFrame:SetVisible(true)
	ConfirmFrame:SetAlpha(0)
	ConfirmFrame:AlphaTo(255, 0.3, 0)
	ConfirmFrame:ShowCloseButton(true)
	ConfirmFrame:MakePopup()
	ConfirmFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, ConfirmFrame:GetWide(), ConfirmFrame:GetTall())
	end

	local derptext = vgui.Create("DLabel", ConfirmFrame)
	derptext:SetFont("TargetIDSmall")
	derptext:SetColor(Color(205,205,205,255))
	derptext:SetText("Are you sure?\nThis will delete all your active props and\nyou will not be refunded for them!\nIf you want to be refunded you will need\nto salvage your props by pressing R with\nbuild tool")
	derptext:SizeToContents()
	derptext:SetPos(10, 30)

	local doclear = vgui.Create("DButton", ConfirmFrame)
	doclear:SetSize(120, 40)
	doclear:SetPos(90, 140)
	doclear:SetText(translate.Get("doit"))
	doclear:SetTextColor(Color(255, 255, 255, 255))
	doclear.Paint = function(panel)
		surface.SetDrawColor(150,150,0,255)
		surface.DrawOutlinedRect(0,0, doclear:GetWide(), doclear:GetTall())
		draw.RoundedBox(2,0,0, doclear:GetWide(), doclear:GetTall(), Color(0,0,0,130))
	end
	doclear.DoClick = function()
		RunConsoleCommand("tea_clearmyprops")
		ConfirmFrame:Remove()
	end

end


function GM:WantToPrestige()
	local pframe = vgui.Create("DFrame")
	pframe:SetSize(560,340)
	pframe:Center()
	pframe:SetTitle("Prestiging information panel")
	pframe:SetDraggable(false)
	pframe:SetVisible(true)
	pframe:SetAlpha(0)
	pframe:AlphaTo(255, 0.5, 0)
	pframe:ShowCloseButton(true)
	pframe:MakePopup()
	pframe.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150,150,0,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end

	local prestigetext = vgui.Create("DLabel", pframe)
	prestigetext:SetFont("TargetIDSmall")
	prestigetext:SetColor(Color(205,205,205,255))
	prestigetext:SetWrap(true)
	prestigetext:SetText("Prestiging allows you to gain more levels depending on your Prestige level. You will also be given some cash and a perk point if you prestige. You need to be at least level "..LocalPlayer():GetMaxLevel().." ("..self.MaxLevel.." plus "..self.LevelsPerPrestige.." depending on prestige) in order to prestige.")
	prestigetext:SetSize(540, 60)
	prestigetext:SetPos(10,30)

	local prestigetext2 = vgui.Create("DLabel", pframe)
	prestigetext2:SetFont("TargetIDSmall")
	prestigetext2:SetColor(Color(205,205,205,255))
	prestigetext2:SetWrap(true)
	prestigetext2:SetText(Format("You may %sprestige.", MyLvl >= LocalPlayer():GetMaxLevel() and "" or "not "))
	prestigetext2:SetSize(540, 240)
	prestigetext2:SetPos(10,30)


	local shouldprestige
	local doprestige = vgui.Create("DButton", pframe)
	doprestige:SetSize(120, 40)
	doprestige:SetPos(220, 280)
	doprestige:SetText(translate.Get("doprestige2"))
	doprestige:SetTextColor(Color(255, 255, 255, 255))
	doprestige.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, doprestige:GetWide(), doprestige:GetTall())
		draw.RoundedBox(2, 0, 0, doprestige:GetWide(), doprestige:GetTall(), Color(0, 0, 0, 130))
	end
	doprestige.DoClick = function(panel)
		local levelrequiredforprestige = LocalPlayer():GetMaxLevel()
		if shouldprestige then
			pframe:Remove()
--			gamemode.Call("ConfirmPrestige")
			net.Start("Prestige")
			net.SendToServer()
		elseif MyLvl >= levelrequiredforprestige then
			panel:SetText("ARE YOU SURE?")
			prestigetext:SetText("WARNING: Once you prestige, there is no return! Your levels and skills will be reset and skill points will not be refunded! Are you really sure you want to prestige??")
			prestigetext2:SetVisible(false)
			shouldprestige = true
		else
			pframe:Remove()
			chat.AddText(Color(255,255,255,255), "[System] ", Color(255,155,155,255), "You must be at least level "..levelrequiredforprestige.." to prestige!")
			surface.PlaySound("buttons/button10.wav")
		end
	end
end


function GM:DropGoldMenu()
	if IsValid(AdarFrame) then AdarFrame:Remove() end
	AdarFrame = vgui.Create("DFrame")
	AdarFrame:SetSize(300, 200)
	AdarFrame:Center()
	AdarFrame:SetTitle("Dropping Money...")
	AdarFrame:SetDraggable(false)
	AdarFrame:SetVisible(true)
	AdarFrame:SetAlpha(0)
	AdarFrame:AlphaTo(255, 0.3, 0)
	AdarFrame:ShowCloseButton(true)
	AdarFrame:MakePopup()
	AdarFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, AdarFrame:GetWide(), AdarFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, AdarFrame:GetWide(), AdarFrame:GetTall())
	end

	local derptext = vgui.Create("DLabel", AdarFrame)
	derptext:SetFont("TargetIDSmall")
	derptext:SetColor(Color(205,205,205,255))
	derptext:SetText("How much cash do you want to drop?")
	derptext:SizeToContents()
	derptext:SetPos(10, 30)

	local derptext2 = vgui.Create("DLabel", AdarFrame)
	derptext2:SetFont("TargetIDSmall")
	derptext2:SetColor(Color(205,255,205,255))
	derptext2:SetText("Cash: "..math.floor(MyMoney))
	derptext2:SizeToContents()
	derptext2:SetPos(10, 50)

	local Cash = vgui.Create("DNumberWang", AdarFrame)
	Cash:SetPos(10, 70)
	Cash:SetSize(150, 30)
	Cash:SetValue(1)
	Cash:SetMin(1)
	Cash:SetMax(99999999)

	local dodropcash = vgui.Create("DButton", AdarFrame)
	dodropcash:SetSize(120, 40)
	dodropcash:SetPos(90, 140)
	dodropcash:SetText("Drop Cash")
	dodropcash:SetTextColor(Color(255, 255, 255, 255))
	dodropcash.Paint = function(panel)
		surface.SetDrawColor(150,150,0,255)
		surface.DrawOutlinedRect(0, 0, dodropcash:GetWide(), dodropcash:GetTall())
		draw.RoundedBox(2, 0, 0, dodropcash:GetWide(), dodropcash:GetTall(), Color(0, 0, 0, 130))
	end
	dodropcash.DoClick = function()
		RunConsoleCommand("tea_dropcash", Cash:GetValue())
		AdarFrame:Remove()
	end
end


function GM:Emotes()
	local EmoteFrame = vgui.Create("DFrame")
	EmoteFrame:SetSize(300, 400)
	EmoteFrame:Center()
	EmoteFrame:SetTitle("Emotes")
	EmoteFrame:SetDraggable(false)
	EmoteFrame:SetVisible(true)
	EmoteFrame:SetAlpha(0)
	EmoteFrame:AlphaTo(255, 0.3, 0)
	EmoteFrame:ShowCloseButton(true)
	EmoteFrame:MakePopup()
	EmoteFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, EmoteFrame:GetWide(), EmoteFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, EmoteFrame:GetWide(), EmoteFrame:GetTall())
	end

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TargetIDSmall")
	derptext:SetColor(Color(205,205,205,255))
	derptext:SetText("Expressive Emotes")
	derptext:SizeToContents()
	derptext:SetPos(10, 20)

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TargetIDSmall")
	derptext:SetColor(Color(205,205,205,255))
	derptext:SetText("Goofy Emotes")
	derptext:SizeToContents()
	derptext:SetPos(160, 20)

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TargetIDSmall")
	derptext:SetColor(Color(205,205,205,255))
	derptext:SetText("RP Emotes")
	derptext:SizeToContents()
	derptext:SetPos(10, 250)

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 40)
	emtb:SetText("Greeting")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "wave")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 75)
	emtb:SetText("Cheer")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "cheer")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 110)
	emtb:SetText("Laugh")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "laugh")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 145)
	emtb:SetText("Tumbs up")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "agree")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 180)
	emtb:SetText("Disagree")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "disagree")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 215)
	emtb:SetText("Bow")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "bow")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 270)
	emtb:SetText("Halt!")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "halt")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 305)
	emtb:SetText("Forward")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "forward")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 340)
	emtb:SetText("Regroup")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "group")
		EmoteFrame:Remove()
	end


	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 40)
	emtb:SetText("Robot Dance")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "robot")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 75)
	emtb:SetText("Sexy Dance")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "muscle")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 110)
	emtb:SetText("Zombie Impersonation")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "zombie")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 145)
	emtb:SetText("Boogie")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "dance")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 180)
	emtb:SetText("Kung Fu")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "pers")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 215)
	emtb:SetText("Come Get Some")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "becon")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 250)
	emtb:SetText("Salute")
	emtb:SetTextColor(Color(255, 255, 255, 255))
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, emtb:GetWide(), emtb:GetTall())
		draw.RoundedBox(2, 0, 0, emtb:GetWide(), emtb:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "salute")
		EmoteFrame:Remove()
	end

end