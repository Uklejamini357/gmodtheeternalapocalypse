-------------------------------- InvMenu (spawnmenu) --------------------------------

local proppanelalpha

local function UseItem(pl, item)
	net.Start("UseItem")
	net.WriteString(item)
	net.WriteBool(true)
	net.WriteEntity(pl)
	net.SendToServer()
end

local function DropItem(item)
	net.Start("UseItem")
	net.WriteString(item)
	net.WriteBool(false)
	net.WriteEntity(me)
	net.SendToServer()
end

local function DestroyItem(item)
	net.Start("DestroyItem")
	net.WriteString(item)
	net.SendToServer()
end

local function DoInvPanel()
	if !pInvPanel:IsValid() then return end

	local ply = LocalPlayer()
	for k, v in SortedPairsByMemberValue(LocalInventory, "Weight", true) do
		local item = GAMEMODE.ItemsList[k]
		local item_name = GAMEMODE:GetItemName(k)
		local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)

		local itPanel = vgui.Create("DPanel", pInvPanel)
		itPanel:SetPos(5, 5)
		itPanel:SetSize(345, 65)
		itPanel.Paint = function(panel, w, h)
			surface.SetDrawColor(75, 75, 75 ,255)
			surface.DrawOutlinedRect(0, 0, w, h)
			surface.SetDrawColor(0, 0, 0 ,200)
			surface.DrawRect(0, 0, w, h)
		end

		local itIcon
		if item.Material then
			itIcon = vgui.Create("DImage", itPanel)
			itIcon:SetMaterial(GAMEMODE.LoadedMaterials[v.Material] or item.Material)
		else
			itIcon = vgui.Create("SpawnIcon", itPanel)
			itIcon:SetModel(item.Model)
		end
		itIcon:SetPos(5, 5)
		if item.ModelColor then
			itIcon:SetColor(item.ModelColor)
		end
		itIcon:SetSize(60,60)
		itIcon.PaintOver = function(self, w, h)
		end
		itIcon.OnMousePressed = function(this, mc) return false end

		local itName = vgui.Create("DLabel", itPanel)
		itName:SetPos(80, 5)
		itName:SetText(item_name)
		itName:SetSize(270, 20)
		itName:SetFont("TEA.HUDFontSmall")
		itName:SetTextColor(raretbl.col)
		if raretbl.keeprefresh then
			itName.Think = function()
				local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
				itName:SetTextColor(tbl_rarity.col)
			end
		end

		local itCount = vgui.Create("DLabel", itPanel)
		itCount:SetPos(290, 30)
		itCount:SetFont("QtyFont")
		itCount:SetColor(Color(255,255,255,255))
		itCount:SetText(v.Qty.."x")
		itCount:SizeToContents()

		local itWeight = vgui.Create("DLabel", itPanel)
		itWeight:SetFont("TEA.HUDFontSmall")
		itWeight:SetPos(80, 26)
		itWeight:SetSize(170, 15)
		itWeight:SetColor(Color(185,225,255,255))
		itWeight:SetText(translate.Get("weight")..": "..v.Weight.."kg"..(v.Qty ~= 1 and " ("..v.Weight*v.Qty.."kg)" or ""))

		local itRarity = vgui.Create("DLabel", itPanel)
		itRarity:SetFont("TEA.HUDFontSmall")
		itRarity:SetPos(80, 42)
		itRarity:SetSize(170, 15)
		itRarity:SetColor(Color(225,225,255,255))
		itRarity:SetText("")

		local itAction = vgui.Create("DButton", itPanel)
		itAction:SetSize(itPanel:GetWide(), itPanel:GetTall())
		itAction:SetText("")
		itAction:SetToolTip(item_name..":\n"..GAMEMODE:GetItemDescription(k))
		itAction.Paint = function(panel, w, h)
			if panel:IsHovered() then
				surface.SetDrawColor(255, 255, 255, 100)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		itAction.OnMousePressed = function(this, mc)
			if mc == MOUSE_LEFT or mc == MOUSE_RIGHT then
				if mc == MOUSE_LEFT then
					if input.IsShiftDown() then
						UseItem(me, k)
						return true
					elseif input.IsControlDown() then
						DropItem(k)
						return true
					end
				end


				local derma = DermaMenu()
				if item.CanUseOnOthers then
					local sub, parent = derma:AddSubMenu("Use", function()
						UseItem(me, k)
					end)
					parent:SetIcon("icon16/accept.png")
					for _,pl in pairs(ents.FindInSphere(ply:GetPos(), 500)) do
						local add = item.ItemType == ITEMTYPE_MED and " ["..pl:Health().."/"..pl:GetMaxHealth().."]" or ""
						if pl:IsPlayer() and ply ~= pl then
							sub:AddOption(pl:Nick()..add, function()
								UseItem(pl, k)
							end)
						end
					end
				else
					derma:AddOption("Use", function()
						UseItem(me, k)
					end):SetIcon("icon16/accept.png")
				end
				derma:AddOption("Drop", function()
					DropItem(k)
				end):SetIcon("icon16/package_go.png")
				derma:AddOption("Destroy Item", function()
					Derma_Query("Are you sure you want to destroy this item? This process cannot be undone!", "Destroy Item", "Yes", function()
						DestroyItem(k)
					end, "No")
				end):SetIcon("icon16/package_delete.png")
				derma:AddOption(GAMEMODE:GetItemName(k), function()
					chat.AddText(raretbl.col, GAMEMODE:GetItemName(k), Color(255,255,255), " - ", GAMEMODE:GetItemDescription(k))
				end)
				derma:Open()
			end

			return true
		end

		pInvPanel.InvList:AddItem(itPanel)
	end
end


net.Receive("UpdateInventory", function(length)
	local data = net.ReadTable()
	table.Empty(LocalInventory)

	for k, v in pairs(data) do
		if !GAMEMODE.ItemsList[k] then continue end
		local ref = GAMEMODE.ItemsList[k]

		LocalInventory[k] = {
			["Name"] = ref.Name,
			["Cost"] = ref.Cost,
			["Model"] = ref.Model,
			["Description"] = ref.Description,
			["Weight"] = ref.Weight,
			["Rarity"] = ref.Rarity,
			["Qty"] = v,
			["ArmorStats"] = ref.ArmorStats,
			["ModelColor"] = ref.ModelColor,
		}
	end

	if pInvPanel and pInvPanel.InvList and pInvPanel.InvList:IsValid() then
		pInvPanel.InvList:Clear()
		DoInvPanel()
	end
end)

net.Receive("UpdateVault", function(length)
	local data = net.ReadTable()
	table.Empty(LocalVault)

	for k, v in pairs(data) do
		if !GAMEMODE.ItemsList[k] then continue end
		local ref = GAMEMODE.ItemsList[k]

		LocalVault[k] = {
			["Name"] = ref.Name,
			["Cost"] = ref.Cost,
			["Model"] = ref.Model,
			["Description"] = ref.Description,
			["Weight"] = ref.Weight,
			["Rarity"] = ref.Rarity,
			["Qty"] = v,
			["ArmorStats"] = ref.ArmorStats,
			["ModelColor"] = ref.ModelColor,
		}
	end

	if pInvPanel and pInvPanel.InvList and pInvPanel.InvList:IsValid() then
		pInvPanel.InvList:Clear()
		DoInvPanel()
	end
end)



local function CreateLabel(parent, text)
	local lbl = vgui.Create("DLabel", parent)
	lbl:SetFont("TEA.HUDFontSmall")
	lbl:SetText(text)
	lbl:Dock(TOP)

	return lbl
end

local function UpdateEquippedArmor(p, item, refreshed)
	local self = GAMEMODE
	local ply = LocalPlayer()

	-- the way the model is determined is by prediction. There is no way to tell how, unless the selected playermodel from the armor is networked too. So it's a bit buggy.
	p.SidePanel.ModelPanel.PMPanelInfo:SetModel(refreshed and table.Random(self.ItemsList[item] and self.ItemsList[item].ArmorStats["allowmodels"] or self.DefaultModels) or ply:GetModel())
	p.SidePanel.ModelPanel.UnequipBtn:SetVisible(ply:GetEquippedArmor() ~= "none")
	p.SidePanel.ArmorPanel.curarmor:SetText(ply:GetEquippedArmor() ~= "none" and translate.Format("cur_armor", self:GetItemName(ply:GetEquippedArmor())) or translate.Get("noarmor"))
	p.SidePanel.ArmorPanel.curarmor:SetTooltip(p.SidePanel.ArmorPanel.curarmor:GetText())
	if GAMEMODE.ExpandedArmorProtTest then
		p.SidePanel.ArmorPanel.prot:SetText("Physical protection: "..math.Round(ply:GetArmorProtection()*100, 1).."%")
		p.SidePanel.ArmorPanel.burnprot:SetText("Burn protection: "..math.Round(ply:GetArmorEnvProtection()*100, 1).."%")
		p.SidePanel.ArmorPanel.shockprot:SetText("Shock protection: "..math.Round(ply:GetArmorEnvProtection()*100, 1).."%")
		p.SidePanel.ArmorPanel.chemprot:SetText("Chem protection: "..math.Round(ply:GetArmorEnvProtection()*100, 1).."%")
		p.SidePanel.ArmorPanel.radprot:SetText("Radiation protection: "..math.Round(ply:GetArmorEnvProtection()*100, 1).."%")
	else
		p.SidePanel.ArmorPanel.prot:SetText(translate.Format("armorprot", math.Round(ply:GetArmorProtection()*100, 1), math.Round(ply:GetTotalProtection()*100, 1)))
		p.SidePanel.ArmorPanel.envprot:SetText(translate.Format("armor_envprot", math.Round(ply:GetArmorEnvProtection()*100, 1), math.Round(ply:GetTotalEnvProtection()*100, 1)))
	end
	p.SidePanel.ArmorPanel.speed:SetText(translate.Get("armorspeed")..": ".. ply:GetArmorSpeedMultiplier() * 100 .."%")
	p.SidePanel.ArmorPanel.carryweight:SetText(translate.Format("armor_max_weight", ply:GetArmorCarryWeight() >= 0 and "+" or "", ply:GetArmorCarryWeight()))

end

function GM:InvMenu()
	if pInvPanel and pInvPanel:IsValid() then
		pInvPanel:SetAlpha(0)
		pInvPanel:AlphaTo(255, 0.2, 0)
		pInvPanel:SetVisible(true)
		return
	end

	local ply = LocalPlayer()
	local wide, tall = 1000, 700

	pInvPanel = vgui.Create("DPanel")
	pInvPanel:SetSize(wide, tall)
	pInvPanel:Center()
	pInvPanel:SetAlpha(0)
	pInvPanel:AlphaTo(255, 0.2, 0)
	pInvPanel.Paint = function(panel, w, h)
		Derma_DrawBackgroundBlur(pInvPanel, SysTime()-0.2)

		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)

	end
	pInvPanel.Think = function()
	end
	pInvPanel:MakePopup()
	pInvPanel:SetKeyboardInputEnabled(false)
	pInvPanel.UpdateEquippedArmor = UpdateEquippedArmor

	self.InvMenuPanel = pInvPanel

	local spnl = vgui.Create("Panel", pInvPanel)
	spnl:Dock(RIGHT)
	spnl:DockMargin(5, 25, 5, 5)
	spnl:SetWide(250)
	spnl.Paint = function(panel, w, h)
	end
	pInvPanel.SidePanel = spnl

	local modelpnl = vgui.Create("Panel", spnl)
	modelpnl:Dock(TOP)
	modelpnl:DockMargin(0, 0, 0, 0)
	modelpnl:SetTall(200)
	modelpnl.Paint = function(panel, w, h)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.SetDrawColor(0, 0, 0, 155)
		surface.DrawRect(0, 0, w, h)
	end
	spnl.ModelPanel = modelpnl

	local mInfo = vgui.Create("DModelPanel", modelpnl)
	modelpnl.PMPanelInfo = mInfo
	mInfo:SetSize(200, 200)
	mInfo:SetPos(25, 0)
	mInfo:SetAnimSpeed(1)
	mInfo:SetAnimated(true)
	mInfo:SetAmbientLight(Color(50, 50, 50))
	mInfo:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	mInfo:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
	mInfo:SetCamPos(Vector(50, 0, 50))
	mInfo:SetLookAt(Vector(0, 0, 40))
	mInfo:SetFOV(80)

	local mButton = vgui.Create("DButton", modelpnl)
	mButton:SetSize(90, 20)
	mButton:SetPos(spnl:GetWide()-mButton:GetWide(), 0)
	mButton:SetText(translate.Get("changemodel"))
	mButton:SetToolTip(translate.Get("changemodel_d"))
	mButton:SetTextColor(COLOR_WHITE)
	mButton.Paint = function(panel, w, h)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(50, 50, 0, 130))
	end
	mButton.DoClick = function()
		RunConsoleCommand("tea_changemodel")
		self:CloseInvMenu()
	end

	local unEqBtn = vgui.Create("DButton", modelpnl)
	modelpnl.UnequipBtn = unEqBtn
	unEqBtn:SetSize(90, 20)
	unEqBtn:SetPos(spnl:GetWide()-unEqBtn:GetWide(), 20)
	unEqBtn:SetText("Unequip armor")
	unEqBtn:SetTextColor(COLOR_WHITE)
	unEqBtn.Paint = function(panel, w, h)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(50, 50, 0, 130))
	end
	unEqBtn.DoClick = function()
		net.Start("tea_playerevent")
		net.WriteUInt(SVPLAYEREVENT_UNEQUIPARMOR, 4)
		net.SendToServer()
	end

	local y1, y2 = self.ExpandedArmorProtTest and 50 or 35, self.ExpandedArmorProtTest and 125 or 80

	local armorpnl = vgui.Create("Panel", spnl)
	spnl.ArmorPanel = armorpnl
	armorpnl:Dock(TOP)
	armorpnl:DockMargin(0, 5, 0, 0)
	armorpnl:SetTall(y1)
	armorpnl.Think = function(panel, w, h)
		if (panel:IsHovered() or panel:IsChildHovered()) and !panel.m_Hovered then
			panel:SizeTo(panel:GetWide(), y2, 0.6, 0, 0.3)
			panel.m_Hovered = true
		elseif !panel:IsHovered() and !panel:IsChildHovered() then
			panel:SizeTo(panel:GetWide(), y1, 0.6, 0, 0.7)
			panel.m_Hovered = false
		end
	end
	armorpnl.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0, 155)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, w, h)

		
		if panel:GetTall() ~= y2 then
			local y_add = math.floor(12 * (panel:GetTall() - y1)/(y2-y1))
			surface.SetDrawColor(0, 0, 0, 155)
			surface.DrawRect(0, h-12 + y_add, w, h)

			surface.SetDrawColor(255, 255, 255, 200)
			draw.NoTexture()
			surface.DrawPoly({
				{x = w/2 - 5, y = h - 10 + y_add},
				{x = w/2 + 5, y = h - 10 + y_add},
				{x = w/2, y = h - 1 + y_add},
			})
		end
	end

	armorpnl.curarmor = CreateLabel(armorpnl, "")
	armorpnl.curarmor:SetMouseInputEnabled(true)
	armorpnl.curarmor:SetTextColor(Color(255, 210, 114))
	armorpnl.curarmor:DockMargin(5, 0, 0, -5)

	if self.ExpandedArmorProtTest then
		armorpnl.prot = CreateLabel(armorpnl, "")
		armorpnl.prot:SetMouseInputEnabled(true)
		armorpnl.prot:SetTextColor(Color(93, 206, 255))
		armorpnl.prot:SetTooltip("Total: "..math.Round(ply:GetTotalProtection()*100, 1).."%")
		armorpnl.prot:DockMargin(5, 0, 0, -5)

		armorpnl.burnprot = CreateLabel(armorpnl, "")
		armorpnl.burnprot:SetMouseInputEnabled(true)
		armorpnl.burnprot:SetTooltip("Total: "..math.Round(ply:GetTotalEnvProtection()*100, 1).."%")
		armorpnl.burnprot:DockMargin(5, 0, 0, -5)

		armorpnl.shockprot = CreateLabel(armorpnl, "")
		armorpnl.shockprot:SetMouseInputEnabled(true)
		armorpnl.shockprot:SetTooltip("Total: "..math.Round(ply:GetTotalEnvProtection()*100, 1).."%")
		armorpnl.shockprot:DockMargin(5, 0, 0, -5)

		armorpnl.chemprot = CreateLabel(armorpnl, "")
		armorpnl.chemprot:SetMouseInputEnabled(true)
		armorpnl.chemprot:SetTooltip("Total: "..math.Round(ply:GetTotalEnvProtection()*100, 1).."%")
		armorpnl.chemprot:DockMargin(5, 0, 0, -5)

		armorpnl.radprot = CreateLabel(armorpnl, "")
		armorpnl.radprot:SetMouseInputEnabled(true)
		armorpnl.radprot:SetTooltip("Total: "..math.Round(ply:GetTotalEnvProtection()*100, 1).."%")
		armorpnl.radprot:DockMargin(5, 0, 0, -5)
	else
		armorpnl.prot = CreateLabel(armorpnl, "")
		armorpnl.prot:SetMouseInputEnabled(true)
		armorpnl.prot:SetTooltip("Protection from bullets, explosions, melee attacks, zombies, etc.")
		armorpnl.prot:SetFont("TEA.HUDFontSmall")
		armorpnl.prot:SetTextColor(Color(96, 206, 255))
		armorpnl.prot:Dock(TOP)
		armorpnl.prot:DockMargin(5, 0, 0, -5)

		armorpnl.envprot = CreateLabel(armorpnl, "")
		armorpnl.envprot:SetMouseInputEnabled(true)
		armorpnl.envprot:SetTooltip("Protection from environmental hazards.")
		armorpnl.envprot:SetFont("TEA.HUDFontSmall")
		armorpnl.envprot:SetTextColor(Color(166, 206, 255))
		armorpnl.envprot:Dock(TOP)
		armorpnl.envprot:DockMargin(5, 0, 0, -5)
	end


	armorpnl.speed = CreateLabel(armorpnl, "")
	armorpnl.speed:SetMouseInputEnabled(true)
	armorpnl.speed:SetTooltip("Movement speed from your armor.")
	armorpnl.speed:SetFont("TEA.HUDFontSmall")
	armorpnl.speed:SetTextColor(Color(186, 255, 76))
	armorpnl.speed:Dock(TOP)
	armorpnl.speed:DockMargin(5, 0, 0, -5)

	armorpnl.carryweight = CreateLabel(armorpnl, "")
	armorpnl.carryweight:SetMouseInputEnabled(true)
	armorpnl.carryweight:SetTooltip("Additional max inventory carry weight, allowing you to carry more items")
	armorpnl.carryweight:SetFont("TEA.HUDFontSmall")
	armorpnl.carryweight:SetTextColor(Color(255, 255, 200))
	armorpnl.carryweight:Dock(TOP)
	armorpnl.carryweight:DockMargin(5, 0, 0, -5)

	spnl.sp = vgui.Create("DLabel", spnl)
	spnl.sp:SetFont("TEA.HUDFontSmall")
	spnl.sp:SetText(translate.Format("skillpoints", math.floor(MySP)))
	spnl.sp.Think = function(panel)
		local tx = translate.Format("skillpoints", math.floor(MySP))
		if tx == panel:GetText() then return end
		panel:SetText(tx)
	end
	spnl.sp:Dock(TOP)
	spnl.sp:DockMargin(5, 0, 0, 10)

	UpdateEquippedArmor(pInvPanel, ply:GetEquippedArmor())


	-----------------------------------------Stats Sheet---------------------------------------------------------------
	InvSheet2 = vgui.Create("DPropertySheet", spnl)
	InvSheet2:Dock(FILL)
	InvSheet2.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		for k, v in pairs(panel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end


	local invSkills = vgui.Create("DScrollPanel", spnl)
	invSkills:Dock(FILL)
	invSkills.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(0, 0, w, h)
	end
	invSkills.VBar.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(30, 30, 30, 50))
	end
	invSkills.VBar.btnGrip.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 0, 50))
	end




	local function DoStatsList()
		for k, v in SortedPairs(self.StatConfigs) do
			local descr = translate.Format("skill_descr", GAMEMODE:GetSkillDescription(k), v.Cost, v.Max, v.PerkMaxIncrease or 0)

			local skpnl = vgui.Create("Panel", invSkills)
			skpnl:SetMouseInputEnabled(true)
			skpnl:SetToolTip(descr)
			skpnl:Dock(TOP)
			skpnl:SetTall(50)
			skpnl:DockMargin(5, 0, 5, 2)

			local txt = vgui.Create("DLabel", skpnl)
			txt:SetText(translate.Get(k)..": "..ply["Stat"..k])
			txt:Dock(TOP)
			txt:DockMargin(0, 0, 0, 2)

			local btn = vgui.Create("DButton", skpnl)
			btn:SetTextColor(COLOR_WHITE)
			btn:SetText(translate.Format("inc1stat", translate.Get(k)))
			btn:Dock(TOP)

			local function applypoint(num)
				net.Start("UpgradePerk")
				net.WriteString(k)
				net.WriteUInt(num, 16)
				net.SendToServer()
				timer.Simple(0.3, function()
					if invSkills:IsValid() then
						invSkills:Clear()
						DoStatsList()
					end
				end)
			end

			btn.DoClick = function(panel)
				applypoint(1)
			end
			btn.DoDoubleClick = function(panel)
				applypoint(1)
			end
			btn.DoRightClick = function(panel)
				local d = DermaMenu()
				d:AddOption("Confirm", function()
					applypoint(math.Clamp(math.floor(MySP), 1, math.min(MySP, 65535)))
				end)
				d:Open()
			end
			btn.Paint = function(panel, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 50))
				draw.RoundedBox(0, 0, 0, ply["Stat"..k] * 225 / v.Max, panel:GetTall(), Color(100, 100, 0, 150))
				if ply["Stat"..k] > v.Max and v.PerkMaxIncrease then -- Empowered Skills
					draw.RoundedBox(0, 0, 0, (ply["Stat"..k]-v.Max) * 225 / (v.PerkMaxIncrease), panel:GetTall(), Color(200, 0, 0, 150))
				end
				surface.SetDrawColor(100, 100, 0 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
	end
	DoStatsList()


-----------------------------------------Stats Form---------------------------------------------------------------
	local invStats = vgui.Create("DScrollPanel", InvSheet2)
	invStats:Dock(FILL)
	invStats.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(0, 0, w, h)
	end
	invStats.VBar.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(30, 30, 30, 50))
	end
	invStats.VBar.btnGrip.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 0, 50))
	end

	local txt = vgui.Create("DLabel", invStats)
	txt:Dock(TOP)
	txt:DockMargin(5, 5, 5, 0)
	txt:SetText("Survival Time: "..string.format("%d:%02d", ply:GetTimeSurvived()/60, ply:GetTimeSurvived()%60))
	txt:SetFont("TEA.HUDFontSmall")
	txt.Think = function(panel)
		panel:SetText("Survival Time: "..string.format("%d:%02d", ply:GetTimeSurvived()/60, ply:GetTimeSurvived()%60))
	end

	local txt = vgui.Create("DLabel", invStats)
	txt:Dock(TOP)
	txt:DockMargin(5, 5, 5, 0)
	txt:SetText("Battery: "..string.format("%d/%d", ply.Battery, ply:GetMaxBattery()))
	txt:SetFont("TEA.HUDFontSmall")
	txt.Think = function(panel)
		panel:SetText("Battery: "..string.format("%d/%d", ply.Battery, ply:GetMaxBattery()))
	end

	local txt = vgui.Create("DLabel", invStats)
	txt:Dock(TOP)
	txt:DockMargin(5, 5, 5, 0)
	txt:SetText("Walkspeed: "..math.Round(ply:GetWalkSpeed(), 2))
	txt:SetFont("TEA.HUDFontSmall")
	txt.Think = function(panel)
		panel:SetText("Walkspeed: "..math.Round(ply:GetWalkSpeed(), 2))
	end

	local txt = vgui.Create("DLabel", invStats)
	txt:Dock(TOP)
	txt:DockMargin(5, 5, 5, 0)
	txt:SetText("Runspeed: "..math.Round(ply:GetRunSpeed(), 2))
	txt:SetFont("TEA.HUDFontSmall")
	txt.Think = function(panel)
		panel:SetText("Runspeed: "..math.Round(ply:GetRunSpeed(), 2))
	end

-----------------------------------------Active tasks---------------------------------------------------------------
	local tasksList = vgui.Create("DScrollPanel", InvSheet2)
	tasksList:Dock(FILL)
	tasksList.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(0, 0, w, h)
	end
	tasksList.VBar.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(30, 30, 30, 50))
	end
	tasksList.VBar.btnGrip.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 0, 50))
	end

	for k,v in pairs(ply.CurrentTasks) do
		local tl = self.Tasks[k]
		if !tl then continue end
		local tpnl = vgui.Create("Panel", tasksList)
		tpnl:Dock(TOP)
		tpnl:SetTall(70)
		tpnl:DockMargin(5, 5, 5, 5)
		tpnl.Paint = function(panel, w, h)
			surface.SetDrawColor(100, 0, 0, 200)
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		tpnl.Task = k

		local tName = vgui.Create("DLabel", tpnl)
		tName:SetFont("TEA.HUDFont")
		tName:SetText(tl.Name)
		tName:Dock(TOP)

		local tName = vgui.Create("DLabel", tpnl)
		tName:SetFont("TEA.HUDFontSmall")
		tName:SetText("Progress: "..tostring(v).."/"..tl.ReqProgress)
		tName:Dock(TOP)

		local cancel = vgui.Create("DButton", tpnl)
		cancel:Dock(TOP)
		cancel:SetText(translate.Get("cancel"))
		cancel:SetTextColor(COLOR_WHITE)
		cancel.Paint = function(panel)
			surface.SetDrawColor(200, 0, 0, 255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(50, 0, 0, 130))
		end
		cancel.DoClick = function()
			Derma_Query(translate.Get("task_cancel_confirm1"), translate.Get("task_cancel_confirm2"), translate.Get("yes"), function()
				net.Start("tea_taskcancel")
				net.WriteString(tpnl.Task)
				net.SendToServer()

				tpnl:Remove()
			end, translate.Get("no"))
		end
	end

	InvSheet2:AddSheet(translate.Get("my_skills"), invSkills, "icon16/heart.png", false, false, translate.Get("my_skills_d"))
	InvSheet2:AddSheet("Stats", invStats, "icon16/user_red.png", false, false, "Your stats.")
	InvSheet2:AddSheet("Active Tasks", tasksList, "icon16/user.png", false, false, "Your current tasks.")



	local InvSheet1 = vgui.Create("DPropertySheet", pInvPanel)
	InvSheet1:Dock(FILL)
	InvSheet1:DockMargin(5, 5, 0, 5)
	InvSheet1:InvalidateParent()
	InvSheet1.Paint = function(panel, w, h)
		for k, v in pairs(InvSheet1.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end


-----------------------------------------Inventory---------------------------------------------------------------


	local InvForm = vgui.Create("Panel", InvSheet1)
	InvForm:Dock(FILL)
	InvForm.Paint = function(panel, w, h) end

	local InvWeightText = vgui.Create("DLabel", InvForm)
	InvWeightText:SizeToContents()
	InvWeightText:Dock(TOP)
	InvWeightText:DockMargin(5, 0, 5, 5)
	InvWeightText.Think = function(this)
		local changetxt = translate.Format("inv_weight", ply:CalculateWeight(), WEIGHT_UNIT, ply:CalculateMaxWeight(), WEIGHT_UNIT, ply:CalculateMaxWalkWeight(), WEIGHT_UNIT)
		if changetxt == this:GetText() then return end
		this:SetText(changetxt)
		this:SizeToContents()
		this:SetTextColor(ply:CalculateWeight() >= ply:CalculateMaxWalkWeight() and Color(255,0,0) or ply:CalculateWeight() >= ply:CalculateMaxWeight() and Color(255,255,0) or Color(255,255,255))
	end
	InvWeightText:Think()
	InvWeightText:SetFont("TEA.HUDFontSmall")

	pInvPanel.InvList = vgui.Create("DPanelList", InvForm)
	pInvPanel.InvList:Dock(FILL)
	pInvPanel.InvList:EnableVerticalScrollbar(true)
	pInvPanel.InvList:EnableHorizontal(true)
	pInvPanel.InvList:SetSpacing(5)
	pInvPanel.InvList:SetPadding(5)

	DoInvPanel()




-----------------Craft Form-----------------------



	local pCraftables = vgui.Create("DPanelList", InvSheet1)
	pCraftables:Dock(FILL)
	pCraftables:DockMargin(5,5,5,5)
	pCraftables:EnableVerticalScrollbar(true)
	pCraftables:EnableHorizontal(true)
	pCraftables:SetSpacing(5)
	pCraftables:SetPadding(5)
	pCraftables.Paint = function(_, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0,100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local function DoCraftablesList()
		for k,v in SortedPairs(GAMEMODE.ItemsList) do
			local craftable = GAMEMODE.CraftableList[k]
			if !craftable then continue end
			local raretbl = gamemode.Call("CheckItemRarity", v["Rarity"])

			local itBackground = vgui.Create("DPanel", pCraftables)
			itBackground:SetPos(5, 5)
			itBackground:SetSize(345, 80)
			itBackground.Paint = function(panel, w, h)
				draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local itIcon
			if v.Material then
				itIcon = vgui.Create("DImageButton", itBackground)
				itIcon:SetMaterial(self.LoadedMaterials[v.Material] or v.Material)
			else
				itIcon = vgui.Create("SpawnIcon", itBackground)
				itIcon:SetModel(v.Model)
			end
			itIcon:SetSize(64,64)
			itIcon:SetPos(8, 8)
			itIcon:SetToolTip(GAMEMODE:GetItemDescription(k))
			itIcon.PaintOver = function() return end
			itIcon.OnMousePressed = function() return false end

			local itName = vgui.Create("DLabel", itBackground)
			itName:SetPos(85, 10)
			itName:SetSize(180, 15)
			itName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				itName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					itName:SetTextColor(tbl_rarity.col)
				end
			end
			itName:SetText(GAMEMODE:GetItemName(k))

			local itWeight = vgui.Create("DLabel", itBackground)
			itWeight:SetFont("TEA.HUDFontSmall")
			itWeight:SetPos(85, 26)
			itWeight:SetSize(170, 15)
			itWeight:SetColor(Color(155,155,255,255))
			itWeight:SetText(translate.Get("weight")..": ".. v["Weight"].."kg")

			local itXP = vgui.Create("DLabel", itBackground)
			itXP:SetFont("TEA.HUDFontSmall")
			itXP:SetPos(85, 42)
			itXP:SetSize(170, 15)
			itXP:SetColor(Color(155,255,255,255))
			itXP:SetText("XP: "..craftable.XP)

			local itTime = vgui.Create("DLabel", itBackground)
			itTime:SetFont("TEA.HUDFontSmall")
			itTime:SetPos(85, 58)
			itTime:SetSize(170, 15)
			itTime:SetColor(Color(255,255,155,255))
			itTime:SetText(translate.Get("craft_time")..": "..craftable.CraftTime.."s")

			local itRequirements = vgui.Create("DButton", itBackground)
			itRequirements:SetSize(100, 20)
			itRequirements:SetPos(235, 20)
			itRequirements:SetText(translate.Get("requirements"))
			itRequirements:SetToolTip(translate.Get("requirements_d"))
			itRequirements:SetTextColor(COLOR_WHITE)
			itRequirements.Paint = function(panel, w, h)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
			end
			itRequirements.DoClick = function()
				chat.AddText(Color(0,192,192), translate.Format("required_items_to_craft", GAMEMODE:GetItemName(k)))
				for r,q in pairs(craftable["Requirements"]) do
					chat.AddText(Color(0,192,255), "\t"..q.."x "..GAMEMODE:GetItemName(r))
				end
			end

			local itCraft = vgui.Create("DButton", itBackground)
			itCraft:SetSize(100, 20)
			itCraft:SetPos(235, 50)
			itCraft:SetText(translate.Get("craft_item"))
			itCraft:SetToolTip(translate.Get("craft_item_d"))
			itCraft:SetTextColor(COLOR_WHITE)
			itCraft.Paint = function(panel, w, h)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
			end
			itCraft.DoClick = function()
				net.Start("CraftItem")
				net.WriteString(k)
				net.SendToServer()
			end
			pCraftables:AddItem(itBackground)
		end
	end
	DoCraftablesList()



	local stats = vgui.Create("Panel", InvSheet1)
	local props = vgui.Create("Panel", InvSheet1)
	
	InvSheet1:AddSheet(translate.Get("inventory"), InvForm, "icon16/basket.png", false, false, translate.Get("inventory_d"))
	InvSheet1:AddSheet(translate.Get("crafting"), pCraftables, "icon16/wrench_orange.png", false, false, translate.Get("crafting_d"))
	local tab = InvSheet1:AddSheet(translate.Get("statistics"), stats, "icon16/user.png", false, false, translate.Get("statistics_d"))
	tab.Tab.DoClick = function()
		self:CloseInvMenu()
		net.Start("UpdateTargetStats")
		net.WriteEntity(ply)
		net.SendToServer()
		gamemode.Call("StatsMenu", ply)
	end
	local tab = InvSheet1:AddSheet(translate.Get("props"), props, "icon16/brick.png", false, false, translate.Get("props_d"))
	tab.Tab.DoClick = function()
		self:CloseInvMenu()
		self:OpenPropMenu()
	end

	return pInvPanel
end

function GM:PropMenu()
	if pPropPanel and pPropPanel:IsValid() then
		pPropPanel:SetVisible(true)
		pPropPanel:SetMouseInputEnabled(true)
		return pPropPanel
	end

	local ply = LocalPlayer()
	local wide, tall = 1000, 700

	pPropPanel = vgui.Create("DFrame")
	pPropPanel:SetSize(wide, tall)
	pPropPanel:Center()
	pPropPanel:SetTitle("")
	pPropPanel:SetDraggable(false)
	pPropPanel:ShowCloseButton(false)
	pPropPanel:SetDeleteOnClose(false)
	pPropPanel.Paint = function(panel, w, h)
		Derma_DrawBackgroundBlur(pPropPanel, SysTime()-0.2)

		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	pPropPanel.Think = function()
	end
	pPropPanel:MakePopup()
	pPropPanel:SetKeyboardInputEnabled(false)

	self.PropMenuPanel = pPropPanel

	local tea_config_propcostenabled = self.PropCostEnabled

	local propSheet = vgui.Create("DPropertySheet", pPropPanel)
	propSheet:SetPos(5, 5)
	propSheet:SetSize(wide - 20, tall - 10)
	propSheet.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
		for k, v in pairs(propSheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	if not tea_config_propcostenabled then
		local text1 = vgui.Create("DLabel", pPropPanel)
		text1:SetFont("TEA.HUDFontSmall")
		text1:SetText("Prop spawning cost disabled (excluding faction structures)")
		text1:SetColor(Color(205,205,205,255))
		text1:SetPos(400, 10)
		text1:SizeToContents()
	end

	local propRefresh = vgui.Create("DButton", propSheet)
	propRefresh:SetText("Refresh Panel")
	propRefresh:SetTextColor(Color(255,255,230))
	propRefresh:SetToolTip("In case if something is wrong with this panel, click this button.\nIf this didn't work, report the problem to the author.")
	propRefresh:SetPos(800, 5)
	propRefresh:SetSize(120,20)
	propRefresh.Paint = function(panel, w, h)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(50, 50, 0, 130))
	end
	propRefresh.DoClick = function()
		proppanelalpha = pPropPanel:GetAlpha()
		pPropPanel:Remove()
		gamemode.Call("OpenPropMenu")
		surface.PlaySound("common/wpn_select.wav")
	end

	----------------------------------------------flimsy props-------------------------------------------------------
 
	local FlimsyPanel = vgui.Create("DPanelList")
	FlimsyPanel:SetSize(wide - 20, tall - 65)
	FlimsyPanel:SetPos(5, 25)
	FlimsyPanel:EnableVerticalScrollbar(true)
	FlimsyPanel:EnableHorizontal(true)
	FlimsyPanel:SetSpacing(5)

	local discount = 1 - ((ply.StatEngineer or 0) * 0.02)
	for k, v in SortedPairsByMemberValue(self.FlimsyProps, "Cost") do
		local itPanel = vgui.Create("DPanel")
		FlimsyPanel:AddItem(itPanel)
		itPanel:SetPos(5, 5)
		itPanel:SetSize(150, 150)
		itPanel:SetToolTip(Format("Prop health: %s HP", 500 * v.Toughness))
		itPanel.Paint = function(panel, w, h)
			draw.RoundedBoxEx(8,1,1,w-2,h-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local itIcon = vgui.Create("SpawnIcon", itPanel)
		itIcon:SetPos(35, 5)
		itIcon:SetModel(k)
		itIcon:SetToolTip(false)
		itIcon:SetSize(75,75)
		itIcon.PaintOver = function()
			return
		end
		itIcon.OnMousePressed = function()
			return false
		end

		local itName = vgui.Create("DLabel", itPanel)
		itName:SetFont("TEA.HUDFontSmall")
		itName:SetColor(Color(205,205,205,255))
		itName:SetText(v.Name)
		itName:SizeToContents()
		itName:Center()
		local x,y = itName:GetPos();
		itName:SetPos(x, y + 20)

		if tea_config_propcostenabled then
			local ItemCost = vgui.Create("DLabel", itPanel)
			ItemCost:SetFont("TEA.HUDFontSmall")
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText(translate.Get("cost")..": ".. math.floor(v.Cost * discount).." "..self.Config["Currency"].."s")
			ItemCost:SizeToContents()
			ItemCost:Center()
			local x,y = ItemCost:GetPos();
			ItemCost:SetPos(x, y + 40)
		end

		local ItemToughness = vgui.Create("DLabel", itPanel)
		ItemToughness:SetFont("TEA.HUDFontSmall")
		local text
		if v.Toughness >= 5 then
			text = "Maximal"
			ItemToughness:SetColor(Color(255,55,155,155))
		elseif v.Toughness >= 4 then
			text = "Very Strong"
			ItemToughness:SetColor(Color(255,105,155,155))
		elseif v.Toughness >= 3 then
			text = "Strong"
			ItemToughness:SetColor(Color(255,155,155,155))
		elseif v.Toughness >= 2 then
			text = "Medium"
			ItemToughness:SetColor(Color(255,205,155,155))
		elseif v.Toughness >= 1 then
			text = "Weak"
			ItemToughness:SetColor(Color(255,255,155,155))
		else
			text = "Very Weak"
			ItemToughness:SetColor(Color(155,155,155,155))
		end
		ItemToughness:SetText(Format("Strength: %s", text))
		ItemToughness:SizeToContents()
		ItemToughness:Center()
		local x,y = ItemToughness:GetPos();
		ItemToughness:SetPos(x, y + 60)

		local ItemClicker = vgui.Create("DButton", itPanel)
		ItemClicker:SetText("")
		ItemClicker:SetPos(0, 0)
		ItemClicker:SetSize(itPanel:GetWide(), itPanel:GetTall())
		ItemClicker.Paint = function()
			return false
		end
		ItemClicker.DoClick = function()
			input.SelectWeapon(ply:GetWeapon("tea_buildtool"))
			surface.PlaySound("common/wpn_select.wav")
			ChooseProp(tostring(k))
		end
	end



----------------------------------------------strong props-------------------------------------------------------

	local StrongPanel = vgui.Create("DPanelList")
	StrongPanel:SetSize(wide - 20, tall - 65)
	StrongPanel:SetPos(5, 25)
	StrongPanel:EnableVerticalScrollbar(true)
	StrongPanel:EnableHorizontal(true)
	StrongPanel:SetSpacing(5)

	for k, v in SortedPairsByMemberValue(self.ToughProps, "Cost") do
		local itPanel = vgui.Create("DPanel")
		StrongPanel:AddItem(itPanel)
		itPanel:SetPos(5, 5)
		itPanel:SetSize(150, 150)
		itPanel:SetToolTip(Format("Prop health: %s HP", 500 * v.Toughness))
		itPanel.Paint = function(panel, w, h)
			draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local itIcon = vgui.Create("SpawnIcon", itPanel)
		itIcon:SetPos(35, 5)
		itIcon:SetModel(k)
		itIcon:SetToolTip(false)
		itIcon:SetSize(75,75)
		itIcon.PaintOver = function()
			return
		end
		itIcon.OnMousePressed = function()
			return false
		end

		local itName = vgui.Create("DLabel", itPanel)
		itName:SetFont("TEA.HUDFontSmall")
		itName:SetColor(Color(205,205,205,255))
		itName:SetText(v.Name)
		itName:SizeToContents()
		itName:Center()
		local x,y = itName:GetPos();
		itName:SetPos(x, y + 20)

		if tea_config_propcostenabled then
			local ItemCost = vgui.Create("DLabel", itPanel)
			ItemCost:SetFont("TEA.HUDFontSmall")
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText(translate.Get("cost")..": "..math.floor(v.Cost * discount).." "..self.Config["Currency"].."s")
			ItemCost:SizeToContents()
			ItemCost:Center()
			local x,y = ItemCost:GetPos();
			ItemCost:SetPos(x, y + 40)
		end

		local ItemToughness = vgui.Create("DLabel", itPanel)
		ItemToughness:SetFont("TEA.HUDFontSmall")
		local text
		if v.Toughness >= 5 then
			text = "Maximal"
			ItemToughness:SetColor(Color(255,55,155,155))
		elseif v.Toughness >= 4 then
			text = "Very Strong"
			ItemToughness:SetColor(Color(255,105,155,155))
		elseif v.Toughness >= 3 then
			text = "Strong"
			ItemToughness:SetColor(Color(255,155,155,155))
		elseif v.Toughness >= 2 then
			text = "Medium"
			ItemToughness:SetColor(Color(255,205,155,155))
		elseif v.Toughness >= 1 then
			text = "Weak"
			ItemToughness:SetColor(Color(255,255,155,155))
		else
			text = "Very Weak"
			ItemToughness:SetColor(Color(155,155,155,155))
		end
		ItemToughness:SetText(Format("Strength: %s", text))
		ItemToughness:SizeToContents()
		ItemToughness:Center()
		local x,y = ItemToughness:GetPos();
		ItemToughness:SetPos(x, y + 60)


		local ItemClicker = vgui.Create("DButton", itPanel)
		ItemClicker:SetText("")
		ItemClicker:SetPos(0, 0)
		ItemClicker:SetSize(itPanel:GetWide(), itPanel:GetTall())
		ItemClicker.Paint = function()
			return false
		end
		ItemClicker.DoClick = function()
			input.SelectWeapon(ply:GetWeapon("tea_buildtool"))
			surface.PlaySound("common/wpn_select.wav")
			ChooseProp(tostring(k))
		end
	end

	local SpecialPanel = vgui.Create("DPanelList")
	SpecialPanel:SetSize(wide - 20, tall - 65)
	SpecialPanel:SetPos(5, 25)
	SpecialPanel:EnableVerticalScrollbar(true)
	SpecialPanel:EnableHorizontal(true)
	SpecialPanel:SetSpacing(5)


	for k, v in SortedPairsByMemberValue(self.SpecialStructureSpawns, "Cost") do
		local itPanel = vgui.Create("DPanel")
		SpecialPanel:AddItem(itPanel)
		itPanel:SetPos(5, 5)
		itPanel:SetSize(150, 150)
		itPanel.Paint = function(panel, w, h)
			draw.RoundedBoxEx(8,1,1,w-2,h-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local itIcon = vgui.Create("SpawnIcon", itPanel)
		itIcon:SetPos(35, 5)
		itIcon:SetModel(v.Model)
		itIcon:SetToolTip(v.Description)
		itIcon:SetSize(75,75)
		itIcon.PaintOver = function()
			return
		end
		itIcon.OnMousePressed = function()
			return false
		end

		local itName = vgui.Create("DLabel", itPanel)
		itName:SetFont("TEA.HUDFontSmall")
		itName:SetColor(Color(205,205,205,255))
		itName:SetText(v.Name)
		itName:SizeToContents()
		itName:Center()
		local x,y = itName:GetPos();
		itName:SetPos(x, y + 20)

		local ItemCost = vgui.Create("DLabel", itPanel)
		ItemCost:SetFont("TEA.HUDFontSmall")
		ItemCost:SetColor(Color(155,255,155,255))
		ItemCost:SetText(translate.Get("cost")..": ".. v.Cost.." "..self.Config["Currency"].."s")
		ItemCost:SizeToContents()
		ItemCost:Center()
		local x,y = ItemCost:GetPos();
		ItemCost:SetPos(x, y + 40)

		local ItemClicker = vgui.Create("DButton", itPanel)
		ItemClicker:SetText("")
		ItemClicker:SetPos(15, 125)
		ItemClicker:SetTextColor(Color(255,255,255,255))
		ItemClicker:SetText(translate.Get("placeblueprint"))
		ItemClicker:SetSize(120, 20)
		ItemClicker.Paint = function(panel, w, h)
			surface.SetDrawColor(20, 20, 60 ,200)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(0, 0, 150 ,255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		ItemClicker.DoClick = function()
			input.SelectWeapon(ply:GetWeapon("tea_buildtool"))
			surface.PlaySound("common/wpn_select.wav")
			ChooseStructure(k)
		end
	end

	propSheet:AddSheet(translate.Get("flimsy_props"), FlimsyPanel, "icon16/bin.png", false, false, translate.Get("flimsy_props_d"))
	propSheet:AddSheet(translate.Get("strong_props"), StrongPanel, "icon16/shield.png", false, false, translate.Get("strong_props_d"))
	propSheet:AddSheet(translate.Get("faction_structures"), SpecialPanel, "icon16/brick.png", false, false, translate.Get("faction_structures_d"))

	return pPropPanel
end


local function SpawnMenuOpen(self)
	if !hook.Call("SpawnMenuOpen", self) then return end

	if IsValid(g_SpawnMenu) then
		g_SpawnMenu:Open()
		menubar.ParentTo(g_SpawnMenu)
	end

	hook.Call("SpawnMenuOpened", self)
end

local function SpawnMenuClose(self)
	if IsValid(g_SpawnMenu) then g_SpawnMenu:Close() end
	hook.Call("SpawnMenuClosed", self)
end

local handler = "TEA.InvPanelRemove"

function GM:OnSpawnMenuOpen()
	---------------- Gmod spawnmenu ----------------
	if IsValid(pInvPanel) then pInvPanel:Remove() end
	if SuperAdminCheck(LocalPlayer()) and input.IsShiftDown() then
		SpawnMenuOpen(self)
		return true
	end

	self:OpenInvMenu()
end

function GM:OnSpawnMenuClose()
	---------------- Gmod spawnmenu ----------------
	if g_SpawnMenu:IsVisible() then
		SpawnMenuClose(self)
	end

	self:ClosePropMenu()
	self:CloseInvMenu()
end

function GM:OpenInvMenu()
	---------------- InvMenu ----------------

	local alpha = 0
	local time = 0.2
	if IsValid(self.InvMenuPanel) then
		timer.Remove(handler)
		alpha = self.InvMenuPanel:GetAlpha()
		time = 0.2 - 0.2*alpha/255

		self.InvMenuPanel:Remove()
	end

	local pInvPanel = self:InvMenu()
	pInvPanel:SetVisible(true)
	pInvPanel:SetAlpha(alpha)
	pInvPanel:AlphaTo(255, time, 0)
end

function GM:CloseInvMenu()
		---------------- InvMenu ----------------
	local pInvPanel = pInvPanel or self.InvMenuPanel
	if !IsValid(pInvPanel) then return end
	local alpha = pInvPanel:GetAlpha()
	local time = 0.2*alpha/255
	timer.Create(handler, time, 1, function()
		pInvPanel:Remove()
	end)

	pInvPanel:SetKeyBoardInputEnabled(false)
	pInvPanel:SetMouseInputEnabled(false)
	pInvPanel:AlphaTo(0, time, 0)
end

local handler = "TEA.PropPanelRemove"

function GM:OpenPropMenu()
	local alpha = 0
	local time = 0.2
	if IsValid(self.PropMenuPanel) then
		timer.Remove(handler)
		alpha = proppanelalpha or self.PropMenuPanel:GetAlpha()
		time = 0.2 - 0.2*alpha/255
		proppanelalpha = nil
	end

	local pPropPanel = self:PropMenu()
	pPropPanel:SetVisible(true)
	pPropPanel:SetAlpha(alpha)
	pPropPanel:AlphaTo(255, time, 0)
end

function GM:ClosePropMenu()
	local pPropPanel = pPropPanel or self.PropMenuPanel
	if !IsValid(pPropPanel) then return end
	local alpha = pPropPanel:GetAlpha()
	local time = 0.2*alpha/255
	timer.Create(handler, time, 1, function()
		pPropPanel:Close()
	end)

	pPropPanel:SetKeyBoardInputEnabled(false)
	pPropPanel:SetMouseInputEnabled(false)
	pPropPanel:AlphaTo(0, time, 0)
end
