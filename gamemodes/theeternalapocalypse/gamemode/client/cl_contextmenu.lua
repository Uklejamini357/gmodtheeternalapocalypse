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
			draw.DrawText(translate.Format("wep_name", language.GetPhrase(name)), "TEA.HUDFont", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
			if name ~= wep:GetClass() then
				y = y - 20
				draw.DrawText(translate.Format("wep_class", wep:GetClass()), "TEA.HUDFont", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			y = y - 25

			if wep.Primary then
				local wep_prim = wep.Primary
				local class = wep:GetClass()
				local delay = math.Round(wep_prim.Delay or 1 / ((wep.RPM or wep_prim.RPM or 1) / 60) or 1, 3)

				local usemulshots = wep_prim.NumShots and wep_prim.NumShots ~= 0 and wep_prim.NumShots ~= 1
				local dmg,dmgmin = wep.DamageMax or wep_prim.Damage, wep.DamageMin
				draw.DrawText(translate.Format("wep_damage",
					usemulshots and (dmgmin and math.Round(dmgmin, 2).."~"..math.Round(dmg, 2) or math.Round(dmg, 2).." x ".. wep_prim.NumShots) or 
					dmgmin and math.Round(dmgmin, 2).."~"..math.Round(dmg, 2) or math.Round(dmg, 2), math.Round((usemulshots and dmg * wep_prim.NumShots or dmg or 0) / (delay), 2)
				), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15

				draw.DrawText(translate.Format("wep_delay", delay), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15
				if wep_prim.ClipSize ~= -1 then
					draw.DrawText(translate.Format("wep_clipsize", wep.ClipSize or wep_prim.ClipSize), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					y = y - 15
				end
				draw.DrawText(translate.Format("wep_recoil", wep.Recoil or wep_prim.Recoil), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				y = y - 15
				if wep.HitDistance then
					draw.DrawText(translate.Format("wep_range", wep.RangeMax or wep.HitDistance), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					y = y - 15
				end
				if wep.Firemodes then
					draw.DrawText("Fire modes: "..#wep.Firemodes, "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.DrawText(translate.Format("wep_automatic", wep_prim.Automatic and translate.Get("yes") or translate.Get("no")), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				y = y - 15

				local dmgvszms = wep.DamageVsZombiesMul or self.WeaponDamageVsZombiesMul[class]
				if dmgvszms then
					draw.DrawText(translate.Format("wep_vszombiedmg", dmgvszms), "TEA.HUDFontSmall", 205, sch / 2 - y, raretbl.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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

			draw.DrawText(translate.Format("current_task", tasktbl.Name), "TEA.HUDFontSmall", scw/2 - 155, y2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			y2 = y2 + 15

			draw.DrawText(translate.Format("task_progress", self.CurrentTaskProgress, tasktbl.ReqProgress), "TEA.HUDFontSmall", scw/2 - 155, y2, LocalPlayer():HasCompletedTask() and Color(155,255,155) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			y2 = y2 + 15

		end

		if self.InfectionLevelEnabled then
			surface.SetDrawColor(0, 0, 0, 105)
			surface.DrawRect(scw - 600, sch / 2 - 150, 400, 300)
			surface.SetDrawColor(150, 150, 0, 105)
			surface.DrawOutlinedRect(scw - 600, sch / 2 - 150, 400, 300)

			local infection = math.Round(self:GetInfectionLevel(), 2)
			local effective = math.Round(self:GetEffectiveInfectionLevel(), 2)

			local text,color = self:GetInfectionTextColor(infection)

			if effective == infection then
				draw.SimpleText(translate.Format("infection_level", infection), "TEA.HUDFont", scw - 590, sch / 2 - 145, color, 0, 0)
			else
				draw.SimpleText(translate.Format("infection_level", infection).." ("..translate.Format("infection_level_effective", effective)..")", "TEA.HUDFont", scw - 590, sch / 2 - 145, color, 0, 0)
			end

			draw.SimpleText(text, "TEA.HUDFontSmall", scw - 590, sch / 2 - 125, color, 0, 0)

			local minlvl = self:GetZombieLvlMin()
			local maxlvl = self:GetZombieLvlMax()
			local y = sch / 2 - 105
			draw.SimpleText(translate.Format("zm_lvl", minlvl, maxlvl), "TEA.HUDFont", scw - 590, y, color, 0, 0)
			y = y + 20

			draw.SimpleText(translate.Format("zm_health", 100*math.Round(0.75+minlvl*0.025, 4), 100*math.Round(0.75+maxlvl*0.025, 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 15
			draw.SimpleText(translate.Format("zm_dmgdealt", 100*math.Round(0.85+minlvl*0.015, 4), 100*math.Round(0.85+maxlvl*0.015, 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 15
			draw.SimpleText(translate.Format("zm_cashreward", 100*math.Round(0.85+minlvl*0.015, 4), 100*math.Round(0.85+maxlvl*0.015, 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 15
			draw.SimpleText(translate.Format("zm_xpreward", 100*math.Round(0.75+minlvl*0.025, 4), 100*math.Round(0.75+maxlvl*0.025, 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 15
			draw.SimpleText(translate.Format("zm_speed", math.Round(100*math.Clamp(1 + (minlvl-20)*0.01, 1, 1.25), 2), math.Round(100*math.Clamp(1 + (maxlvl-20), 1, 1.25), 2)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 20
			draw.SimpleText(translate.Format("zm_ev_spawn_chance", math.Round(self:GetEliteVariantSpawnChance(false), 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)
			y = y + 15
			draw.SimpleText(translate.Format("zm_boss_ev_spawn_chance", math.Round(self:GetEliteVariantSpawnChance(true), 4)), "TEA.HUDFontSmall", scw - 590, y, color, 0, 0)

			y = sch / 2 + 65

			draw.SimpleText(translate.Get("iflvl_factors_info_1"), "TEA.HUDFontSmall", scw - 590, y, Color(225,225,225), 0, 0)
			y = y + 15
			draw.SimpleText(translate.Get("iflvl_factors_info_2"), "TEA.HUDFontSmall", scw - 590, y, Color(225,225,225), 0, 0)
			y = y + 20

			local infectionlevel = self:GetInfectionLevel() >= 100 and 0.4/(self:GetInfectionMul()-1) or
				self:GetInfectionLevel() >= 75 and 0.5 or
				self:GetInfectionLevel() >= 50 and 0.75 or
			1.00
			local plycount = 1 / (1 + ((player.GetCount() - 1) * (2 / 9)))
			local mul = self.InfectionLevelGainMul
			local gain = infectionlevel * plycount * mul
			local alwaysshowmults = self.AlwaysShowInfLvlMults
			local showmults = alwaysshowmults or infectionlevel ~= 1 or plycount ~= 1 or mul ~= 1

			draw.SimpleText(translate.Format("iflvl_gain", math.Round(gain*100, 2)), "TEA.HUDFontSmall", scw - 590, y, Color(255,155,155), 0, 0)
			y = y + 15
			if showmults then
				draw.SimpleText(translate.Get("multipliers"), "TEA.HUDFontSmall", scw - 590, y, Color(255,225,155), 0, 0)
				y = y + 15
				local x = scw - 590
				if alwaysshowmults or infectionlevel ~= 1 then
					draw.SimpleText(Format("I. lvl: %s%%", math.Round(infectionlevel*100)), "TEA.HUDFontSmall", x, y, Color(255,225,155), 0, 0)
					x = x + 125
				end
				if alwaysshowmults or plycount ~= 1 then
					draw.SimpleText(Format("Players: %s%%", math.Round(plycount*100)), "TEA.HUDFontSmall", x, y, Color(255,225,155), 0, 0)
					x = x + 125
				end
				if alwaysshowmults or mul ~= 1 then
					draw.SimpleText(Format("Config: %s%%", math.Round(mul*100)), "TEA.HUDFontSmall", x, y, Color(255,225,155), 0, 0)
				end
			end
		end

		surface.DrawCircle(panel:GetWide() / 2, panel:GetTall() / 2, 150, Color(100, 100, 100, 205))
		surface.DrawCircle(panel:GetWide() / 2, panel:GetTall() / 2, 140, Color(100, 100, 100, 205))
	end
	ContextMenu.Think = function()
	end
	ContextMenu:MakePopup()
	ContextMenu:SetKeyboardInputEnabled(false)


	local prestigeprogress = vgui.Create("Panel", ContextMenu)
	prestigeprogress:SetSize(scw * 0.6, 30)
	prestigeprogress:SetPos(scw * 0.2, 70)
	prestigeprogress:SetToolTip(translate.Get("progress_to_prestige"))
	prestigeprogress.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 105)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.SetDrawColor(150, 150, 0, 105)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())

		local progress = LocalPlayer():GetProgressToPrestige()
		dynprogress = math.Approach(dynprogress, progress, math.Round((progress - dynprogress) * 0.04, 6))

		surface.SetDrawColor(50, 150, 150, 205)
		surface.DrawRect(0, 0, dynprogress * panel:GetWide(), panel:GetTall())

		draw.SimpleText(string.format("%s%%", math.Round(dynprogress * 100, 2)), "TEA.HUDFont", dynprogress * panel:GetWide() * 0.5, panel:GetTall() * 0.5, Color(80, 255, 255, 205), dynprogress > 0.5 and TEXT_ALIGN_CENTER or TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end



	local buttonsize_x, buttonsize_y = 120, 40
	local clearprops = vgui.Create("DButton", ContextMenu)
	clearprops:SetSize(buttonsize_x, buttonsize_y)
	clearprops:Center()
	local x,y = clearprops:GetPos()
	clearprops:SetPos(x - 175, y - 125)
	clearprops:SetText(translate.Get("clearprops"))
	clearprops:SetTextColor(Color(255,155,155))
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
	perks:SetText(translate.Get("perks"))
	perks:SetTextColor(color_white)
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
/*
	local ver = vgui.Create("DButton", ContextMenu)
	ver:SetSize(buttonsize_x, buttonsize_y)
	ver:Center()
	x,y = ver:GetPos()
	ver:SetPos(x, y - 180)
	ver:SetText("Thirdperson")
	ver:SetTextColor(Color(255, 255, 0, 255))
	ver.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	ver.DoClick = function() end
*/
	local cash = vgui.Create("DButton", ContextMenu)
	cash:SetSize(buttonsize_x, buttonsize_y)
	cash:Center()
	x,y = cash:GetPos()
	cash:SetPos(x + 220, y)
	cash:SetText(translate.Get("dropcash"))
	cash:SetTextColor(color_white)
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
	pvp:SetTextColor(color_white)
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
	emotes:SetTextColor(color_white)
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
	ConfirmFrame.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end

	local derptext = vgui.Create("DLabel", ConfirmFrame)
	derptext:SetFont("TEA.HUDFontSmall")
	derptext:SetColor(Color(205,205,205))
	derptext:SetText("Are you sure?\nThis will delete all your active props and\nyou will not be refunded for them!\nIf you want to be refunded you will need\nto salvage your props by pressing R with\nbuild tool")
	derptext:SizeToContents()
	derptext:SetPos(10, 30)

	local doclear = vgui.Create("DButton", ConfirmFrame)
	doclear:SetSize(120, 40)
	doclear:SetPos(90, 140)
	doclear:SetText(translate.Get("doit"))
	doclear:SetTextColor(color_white)
	doclear.Paint = function(panel)
		surface.SetDrawColor(150,150,0,255)
		surface.DrawOutlinedRect(0,0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2,0,0, panel:GetWide(), panel:GetTall(), Color(0,0,0,130))
	end
	doclear.DoClick = function()
		RunConsoleCommand("tea_clearmyprops")
		ConfirmFrame:Remove()
	end

end


function GM:WantToPrestige()
	local pl = LocalPlayer()

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
	prestigetext:SetFont("TEA.HUDFontSmall")
	prestigetext:SetColor(Color(205,205,205))
	prestigetext:SetWrap(true)
	prestigetext:SetText("Prestiging allows you to gain more levels depending on your Prestige level.\nYou will also be given some cash and a perk point if you prestige.\nYou need to be at least level "..pl:GetMaxLevel().." ("..self.MaxLevel.." plus "..self.LevelsPerPrestige.." depending on prestige) in order to prestige.")
	prestigetext:SetSize(540, 60)
	prestigetext:SetPos(10,30)

	local prestigetext2 = vgui.Create("DLabel", pframe)
	prestigetext2:SetFont("TEA.HUDFontSmall")
	prestigetext2:SetColor(Color(205,205,205))
	prestigetext2:SetWrap(true)
	prestigetext2:SetText(Format("You may %sprestige.", pl:GetTEALevel() >= pl:GetMaxLevel() and "" or "not "))
	prestigetext2:SetSize(540, 240)
	prestigetext2:SetPos(10,30)


	local shouldprestige
	local doprestige = vgui.Create("DButton", pframe)
	doprestige:SetSize(120, 40)
	doprestige:SetPos(220, 280)
	doprestige:SetText(translate.Get("doprestige2"))
	doprestige:SetTextColor(color_white)
	doprestige.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	doprestige.DoClick = function(panel)
		local levelrequiredforprestige = pl:GetMaxLevel()
		if shouldprestige then
			pframe:Remove()
--			gamemode.Call("ConfirmPrestige")
			net.Start("Prestige")
			net.SendToServer()
		elseif pl:GetTEALevel() >= levelrequiredforprestige then
			panel:SetText("")

			local t = "D O  I T"
			for i=1,string.len(t) do
				timer.Simple(i*0.2, function()
					if not panel:IsValid() then return end
					panel:SetText(string.sub(t, 1, i))
				end)
			end
			panel.Think = function(this)
				this:SetTextColor(HSVToColor((RealTime() * 160) % 360, 0.5, 1))
			end
			prestigetext:SetText("WARNING: Once you prestige, there is no return!\nYour levels and skills will be reset and your skill points will not be refunded!\nAre you really sure you want to prestige??")
			prestigetext2:SetVisible(false)
			shouldprestige = true
		else
			pframe:Remove()
			chat.AddText(color_white, "[System] ", Color(255,155,155), translate.Format("must_be_at_least_level_x_to_prestige", levelrequiredforprestige))
			surface.PlaySound("buttons/button10.wav")
		end
	end
end


function GM:DropGoldMenu()
	if IsValid(AdarFrame) then AdarFrame:Remove() end

	local pl = LocalPlayer()

	AdarFrame = vgui.Create("DFrame")
	AdarFrame:SetSize(300, 200)
	AdarFrame:Center()
	AdarFrame:SetTitle(translate.Get("dropping_cash"))
	AdarFrame:SetDraggable(false)
	AdarFrame:SetVisible(true)
	AdarFrame:SetAlpha(0)
	AdarFrame:AlphaTo(255, 0.3, 0)
	AdarFrame:ShowCloseButton(true)
	AdarFrame:MakePopup()
	AdarFrame.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end

	local derptext = vgui.Create("DLabel", AdarFrame)
	derptext:SetFont("TEA.HUDFontSmall")
	derptext:SetColor(Color(205,205,205))
	derptext:SetText(translate.Get("drop_cash_prompt"))
	derptext:SizeToContents()
	derptext:SetPos(10, 30)

	local derptext2 = vgui.Create("DLabel", AdarFrame)
	derptext2:SetFont("TEA.HUDFontSmall")
	derptext2:SetColor(Color(205,255,205))
	derptext2:SetText("Cash: "..math.floor(pl.Money))
	derptext2:SizeToContents()
	derptext2:SetPos(10, 50)

	local Cash = vgui.Create("DNumberWang", AdarFrame)
	Cash:SetPos(10, 70)
	Cash:SetSize(150, 30)
	Cash:SetValue(1)
	Cash:SetMin(1)
	Cash:SetMax(math.min(pl.Money, 99999999))

	local dodropcash = vgui.Create("DButton", AdarFrame)
	dodropcash:SetSize(120, 40)
	dodropcash:SetPos(90, 140)
	dodropcash:SetText("Drop Cash")
	dodropcash:SetTextColor(color_white)
	dodropcash.Paint = function(panel)
		surface.SetDrawColor(150,150,0)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
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
	EmoteFrame.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TEA.HUDFontSmall")
	derptext:SetColor(Color(205,205,205))
	derptext:SetText("Expressive Emotes")
	derptext:SizeToContents()
	derptext:SetPos(10, 20)

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TEA.HUDFontSmall")
	derptext:SetColor(Color(205,205,205))
	derptext:SetText("Goofy Emotes")
	derptext:SizeToContents()
	derptext:SetPos(160, 20)

	local derptext = vgui.Create("DLabel", EmoteFrame)
	derptext:SetFont("TEA.HUDFontSmall")
	derptext:SetColor(Color(205,205,205))
	derptext:SetText("RP Emotes")
	derptext:SizeToContents()
	derptext:SetPos(10, 250)

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 40)
	emtb:SetText("Greeting")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "wave")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 75)
	emtb:SetText("Cheer")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "cheer")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 110)
	emtb:SetText("Laugh")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "laugh")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 145)
	emtb:SetText("Tumbs up")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "agree")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 180)
	emtb:SetText("Disagree")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "disagree")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 215)
	emtb:SetText("Bow")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "bow")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 270)
	emtb:SetText("Halt!")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "halt")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 305)
	emtb:SetText("Forward")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "forward")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(10, 340)
	emtb:SetText("Regroup")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "group")
		EmoteFrame:Remove()
	end


	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 40)
	emtb:SetText("Robot Dance")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "robot")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 75)
	emtb:SetText("Sexy Dance")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "muscle")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 110)
	emtb:SetText("Zombie Impersonation")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "zombie")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 145)
	emtb:SetText("Boogie")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "dance")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 180)
	emtb:SetText("Kung Fu")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "pers")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 215)
	emtb:SetText("Come Get Some")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "becon")
		EmoteFrame:Remove()
	end

	local emtb = vgui.Create("DButton", EmoteFrame)
	emtb:SetSize(120, 30)
	emtb:SetPos(160, 250)
	emtb:SetText("Salute")
	emtb:SetTextColor(color_white)
	emtb.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	emtb.DoClick = function()
		RunConsoleCommand("act", "salute")
		EmoteFrame:Remove()
	end

end