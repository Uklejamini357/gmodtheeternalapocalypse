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
		itPanel.Paint = function(panel) -- Paint function
			surface.SetDrawColor(75, 75, 75 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			surface.SetDrawColor(0, 0, 0 ,200)
			surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		end

		local itIcon = vgui.Create("SpawnIcon", itPanel)
		itIcon:SetPos(5, 5)
		itIcon:SetModel(v.Model)
		if v.ModelColor then
			itIcon:SetColor(v.ModelColor)
		end
		itIcon:SetSize(60,60)
		itIcon.PaintOver = function() return end
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
					for _,ply in pairs(ents.FindInSphere(ply:GetPos(), 500)) do
						local add = item.ItemType == ITEMTYPE_MED and " ["..pl:Health().."/"..pl:GetMaxHealth().."]" or ""
						if ply:IsPlayer() and ply ~= me then
							sub:AddOption(pl:Nick()..add, function()
								UseItem(ply, k)
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


--[[
		local EquipButton = vgui.Create("DButton", itPanel)
		EquipButton:SetSize(80, 20)
		EquipButton:SetPos(80, 35)
		EquipButton:SetText(translate.Get("use"))
		EquipButton:SetTextColor(Color(255, 255, 255, 255))
		EquipButton.Paint = function(panel)
			surface.SetDrawColor(0, 150, 0 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
		end
		EquipButton.DoClick = function()
			net.Start("UseItem")
			net.WriteString(k)
			net.WriteBool(true)
			net.SendToServer()
		end
		EquipButton.DoDoubleClick = EquipButton.DoClick

		local DropButton = vgui.Create("DButton", itPanel)
		DropButton:SetSize(80, 20)
		DropButton:SetPos(170, 35)
		DropButton:SetText(translate.Get("drop"))
		DropButton:SetTextColor(Color(255, 255, 255, 255))
		DropButton.Paint = function(panel)
			surface.SetDrawColor(150, 75, 0 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(50, 25, 0, 130))
		end
		DropButton.DoClick = function()
			net.Start("UseItem")
			net.WriteString(k)
			net.WriteBool(false)
			net.SendToServer()
		end
		DropButton.DoDoubleClick = DropButton.DoClick
]]
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



function GM:InvMenu()
	if pInvPanel and pInvPanel:IsValid() then
		pInvPanel:SetAlpha(0)
		pInvPanel:AlphaTo(255, 0.2, 0)
		pInvPanel:SetVisible(true)
		return
	end

	local ply = LocalPlayer()
	local wide, tall = 1000, 700

	pInvPanel = vgui.Create("DFrame")
	pInvPanel:SetSize(wide, tall)
	pInvPanel:Center()
	pInvPanel:SetAlpha(0)
	pInvPanel:AlphaTo(255, 0.2, 0)
	pInvPanel:SetTitle("")
	pInvPanel:SetDraggable(false)
	pInvPanel:ShowCloseButton(false)
	pInvPanel.Paint = function(panel)
		Derma_DrawBackgroundBlur(pInvPanel, SysTime()-0.2)

		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.DrawOutlinedRect(panel:GetWide() - 260, 25, 250, 200)
		surface.DrawOutlinedRect(panel:GetWide() - 260, 230, 250, 100)
		surface.SetDrawColor(0, 0, 0 ,155)
		surface.DrawRect(panel:GetWide() - 260, 25, 250, 205)
		surface.DrawRect(panel:GetWide() - 260, 230, 250, 100)
		local armorstr = ply:GetNWString("ArmorType") or "none"
		local armortype = GAMEMODE.ItemsList[armorstr]

		local prot, protdef = math.Round(ply:GetArmorProtection(false)*100, 1), math.Round(ply:GetArmorProtection(true)*100, 1)
		local env_prot, env_protdef = math.Round(ply:GetArmorEnvProtection(false)*100, 1), math.Round(ply:GetArmorEnvProtection(true)*100, 1)
		local armorcarryweight = math.Round(ply:GetArmorCarryWeight(), 2)
		if armorstr and armortype then
			draw.SimpleText(translate.Format("cur_armor", GAMEMODE:GetItemName(armorstr)), "TEA.HUDFontSmall", panel:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", prot, protdef), "TEA.HUDFontSmall", panel:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", env_prot, env_protdef), "TEA.HUDFontSmall", panel:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(translate.Get("armorspeed")..": "..ply:GetArmorSpeedMultiplier().."%", "TEA.HUDFontSmall", panel:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(armorcarryweight >= 0 and translate.Format("armormaxweight", "+", armorcarryweight) or translate.Format("armormaxweight", "", armorcarryweight), "TEA.HUDFontSmall", panel:GetWide() - 255, 295, Color(255,255,175,255))
		else
			draw.SimpleText(translate.Get("noarmor"), "TEA.HUDFontSmall", panel:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", 0, protdef), "TEA.HUDFontSmall", panel:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", 0, env_protdef), "TEA.HUDFontSmall", panel:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(translate.Get("armorspeed")..": None", "TEA.HUDFontSmall", panel:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(translate.Format("armormaxweight", "+", "0"), "TEA.HUDFontSmall", panel:GetWide() - 255, 295, Color(255,235,205,255))
		end
		draw.SimpleText( translate.Format("skillpoints", math.floor(MySP)), "TEA.HUDFontSmall", panel:GetWide() - 255, 310, Color(205, 205, 205, 255))
	end
	pInvPanel.Think = function()
	end
	pInvPanel:MakePopup()
	pInvPanel:SetKeyboardInputEnabled(false)

	self.InvMenuPanel = pInvPanel

	local tea_config_propcostenabled = self.PropCostEnabled
	local InvSheet1 = vgui.Create("DPropertySheet", pInvPanel)
	InvSheet1:SetPos(5, 5)
	InvSheet1:SetSize(wide - 275, tall - 10)
	InvSheet1.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		if not tea_config_propcostenabled then
			local text1 = vgui.Create("DLabel", pInvPanel)
			text1:SetFont("TEA.HUDFontSmall")
			text1:SetText("Prop spawning cost disabled (excluding faction structures)")
			text1:SetColor(Color(205,205,205,255))
			text1:SetPos(400, 10)
			text1:SizeToContents()
		end
		for k, v in pairs(InvSheet1.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end


-----------------------------------------Inventory---------------------------------------------------------------


	local InvForm = vgui.Create("DPanel", InvSheet1)
	InvForm:SetSize(wide-325, tall)
	InvForm:SetName("Items")
	InvForm.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 100))
	end

	local InvWeightText = vgui.Create("DLabel", InvForm)
	InvWeightText:SizeToContents()
	InvWeightText:SetPos(5, 5)
	InvWeightText.Think = function(this)
		local changetxt = translate.Format("inv_weight", ply:CalculateWeight(), WEIGHT_UNIT, ply:CalculateMaxWeight(), WEIGHT_UNIT, ply:CalculateMaxWalkWeight(), WEIGHT_UNIT)
		if changetxt == this:GetText() then return end
		this:SetText(changetxt)
		this:SizeToContents()
		this:SetTextColor(ply:CalculateWeight() >= ply:CalculateMaxWalkWeight() and Color(255,0,0) or ply:CalculateWeight() >= ply:CalculateMaxWeight() and Color(255,255,0) or Color(255,255,255))
	end
	InvWeightText:Think()
--	InvWeightText:SetFont()

	pInvPanel.InvList = vgui.Create("DPanelList", InvForm)
	pInvPanel.InvList:SetSize(wide-20, tall-65)
	pInvPanel.InvList:SetPos(5, 25)
	pInvPanel.InvList:EnableVerticalScrollbar(true)
	pInvPanel.InvList:EnableHorizontal(true)
	pInvPanel.InvList:SetSpacing(5)

	DoInvPanel()




-----------------Craft Form-----------------------


	local CraftForm = vgui.Create("DPanel", InvSheet1)
	CraftForm:SetSize(675, 700)
	CraftForm.Paint = function(self,w,h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0,100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local pCraftables = vgui.Create("DPanelList", CraftForm)
	pCraftables:SetTall(635)
	pCraftables:SetWide(755)
	pCraftables:SetPos(5, 10)
	pCraftables:EnableVerticalScrollbar(true)
	pCraftables:EnableHorizontal(true)
	pCraftables:SetSpacing(5)

	local function DoCraftablesList()
		for k,v in SortedPairs(GAMEMODE.ItemsList) do
			if !GAMEMODE.CraftableList[k] then continue end
			local raretbl = gamemode.Call("CheckItemRarity", v["Rarity"])

			local itBackground = vgui.Create("DPanel", pCraftables)
			itBackground:SetPos(5, 5)
			itBackground:SetSize(345, 80)
			itBackground.Paint = function(panel) -- Paint function
				draw.RoundedBoxEx(8, 1, 1, panel:GetWide() - 2, panel:GetTall() - 2, Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			end

			local itIcon = vgui.Create("SpawnIcon", itBackground)
			itIcon:SetPos(8, 8)
			itIcon:SetModel(v.Model)
			itIcon:SetToolTip(GAMEMODE:GetItemDescription(k))
			itIcon:SetSize(64,64)
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
			itXP:SetText("XP: "..GAMEMODE.CraftableList[k].XP)

			local itTime = vgui.Create("DLabel", itBackground)
			itTime:SetFont("TEA.HUDFontSmall")
			itTime:SetPos(85, 58)
			itTime:SetSize(170, 15)
			itTime:SetColor(Color(255,255,155,255))
			itTime:SetText(translate.Get("craft_time")..": "..GAMEMODE.CraftableList[k].CraftTime.."s")

			local itRequirements = vgui.Create("DButton", itBackground)
			itRequirements:SetSize(100, 20)
			itRequirements:SetPos(235, 20)
			itRequirements:SetText(translate.Get("requirements"))
			itRequirements:SetToolTip(translate.Get("requirements_d"))
			itRequirements:SetTextColor(Color(255, 255, 255, 255))
			itRequirements.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
				draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
			end
			itRequirements.DoClick = function()
				chat.AddText(Color(0,192,192), translate.Format("required_items_to_craft", GAMEMODE:GetItemName(k)))
				for r,q in pairs(GAMEMODE.CraftableList[k]["Requirements"]) do
					chat.AddText(Color(0,192,255), "\t"..q.."x "..GAMEMODE:GetItemName(r))
				end
			end

			local itCraft = vgui.Create("DButton", itBackground)
			itCraft:SetSize(100, 20)
			itCraft:SetPos(235, 50)
			itCraft:SetText(translate.Get("craft_item"))
			itCraft:SetToolTip(translate.Get("craft_item_d"))
			itCraft:SetTextColor(Color(255, 255, 255, 255))
			itCraft.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
				draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
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


---------------Statistics Form------------------

	local y = 10

	local StatisticsForm = vgui.Create("DPanel", InvSheet1)
	StatisticsForm:SetSize(675, 700)
	StatisticsForm.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)


		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 165, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 165, 200, 8)

		local bar1 = math.Clamp( 200 * (MyMMeleexp / ply:GetReqMasteryMeleeXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 165, bar1, 8)

		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 210, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 210, 200, 8)

		local bar2 = math.Clamp( 200 * (MyMPvpxp / ply:GetReqMasteryPvPXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 210, bar2, 8 )
	end

	local texts = {}
	local stats = ply.Statistics

	texts.SurvivalTime = vgui.Create("DLabel", StatisticsForm)
	texts.SurvivalTime:SetFont("TEA.HUDFont")
	texts.SurvivalTime:SetTextColor(Color(255,255,255))
	texts.SurvivalTime:SetText(translate.Format("timesurvived", util.ToMinutesSeconds(CurTime() - MySurvivaltime)))
	texts.SurvivalTime:SetMouseInputEnabled(true)
	texts.SurvivalTime:SizeToContents()
	texts.SurvivalTime:SetPos(15, y)
	texts.SurvivalTime.Think = function(panel)
		panel:SetText(translate.Format("timesurvived", util.ToMinutesSeconds(CurTime() - MySurvivaltime)))
		panel:SizeToContents()
	end
	y = y + 25

	texts.BestSurvivalTime = vgui.Create("DLabel", StatisticsForm)
	texts.BestSurvivalTime:SetFont("TEA.HUDFont")
	texts.BestSurvivalTime:SetTextColor(Color(255,255,255))
	texts.BestSurvivalTime:SetText(translate.Format("besttimesurvived", util.ToMinutesSeconds(ply.Statistics.BestSurvivalTime)))
	texts.BestSurvivalTime:SetMouseInputEnabled(true)
	texts.BestSurvivalTime:SizeToContents()
	texts.BestSurvivalTime:SetPos(15, y)
	texts.BestSurvivalTime.Think = function(panel)
		panel:SetText(translate.Format("besttimesurvived", util.ToMinutesSeconds(ply.Statistics.BestSurvivalTime)))
		panel:SizeToContents()
	end
	y = y + 25

	texts.ZombieKills = vgui.Create("DLabel", StatisticsForm)
	texts.ZombieKills:SetFont("TEA.HUDFont")
	texts.ZombieKills:SetTextColor(Color(255,255,255))
	texts.ZombieKills:SetText("Zombies Killed in Total: "..stats.ZombieKills)
	texts.ZombieKills:SetMouseInputEnabled(true)
	texts.ZombieKills:SizeToContents()
	texts.ZombieKills:SetPos(15, y)
	texts.ZombieKills.Think = function(panel)
		panel:SetText("Zombies Killed in Total: "..stats.ZombieKills)
		panel:SizeToContents()
	end
	y = y + 25

	texts.PlayerKills = vgui.Create("DLabel", StatisticsForm)
	texts.PlayerKills:SetFont("TEA.HUDFont")
	texts.PlayerKills:SetTextColor(Color(255,255,255))
	texts.PlayerKills:SetText("Players killed in Total: "..stats.PlayersKilled)
	texts.PlayerKills:SetMouseInputEnabled(true)
	texts.PlayerKills:SizeToContents()
	texts.PlayerKills:SetPos(15, y)
	texts.PlayerKills.Think = function(panel)
		panel:SetText("Players killed in Total: "..stats.PlayersKilled)
		panel:SizeToContents()
	end
	y = y + 25

	texts.TotalDeaths = vgui.Create("DLabel", StatisticsForm)
	texts.TotalDeaths:SetFont("TEA.HUDFont")
	texts.TotalDeaths:SetTextColor(Color(255,255,255))
	texts.TotalDeaths:SetText("Your Deaths in Total: "..stats.Deaths)
	texts.TotalDeaths:SetMouseInputEnabled(true)
	texts.TotalDeaths:SizeToContents()
	texts.TotalDeaths:SetPos(15, y)
	texts.TotalDeaths.Think = function(panel)
		panel:SetText("Your Deaths in Total: "..stats.Deaths)
		panel:SizeToContents()
	end
	y = y + 25

	texts.MasteryMeleeXP = vgui.Create("DLabel", StatisticsForm)
	texts.MasteryMeleeXP:SetFont("TEA.HUDFont")
	texts.MasteryMeleeXP:SetTextColor(Color(205,205,205))
	texts.MasteryMeleeXP:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. ply:GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")")
	texts.MasteryMeleeXP:SetToolTip("Increases melee damage by 0.5% per level, increases when doing melee damage to zombies. \nGain rate is DECREASED when damaging players with melee weapons.")
	texts.MasteryMeleeXP:SetMouseInputEnabled(true)
	texts.MasteryMeleeXP:SizeToContents()
	texts.MasteryMeleeXP:SetPos(15, 140)
	texts.MasteryMeleeXP.Think = function(panel)
		panel:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. ply:GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")")
		panel:SizeToContents()
	end

	texts.MasteryPVPXP = vgui.Create("DLabel", StatisticsForm)
	texts.MasteryPVPXP:SetFont("TEA.HUDFont")
	texts.MasteryPVPXP:SetTextColor(Color(205,205,205))
	texts.MasteryPVPXP:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. ply:GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")")
	texts.MasteryPVPXP:SetToolTip("Gained from killing players. (no other benefits other than money gain on level up)\nGain rate increased when they have higher level and prestige.")
	texts.MasteryPVPXP:SetMouseInputEnabled(true)
	texts.MasteryPVPXP:SizeToContents()
	texts.MasteryPVPXP:SetPos(15, 185)
	texts.MasteryPVPXP.Think = function(panel)
		panel:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. ply:GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")")
		panel:SizeToContents()
	end









-----------------------------------------Stats Sheet---------------------------------------------------------------
	InvSheet2 = vgui.Create("DPropertySheet")
	InvSheet2:SetParent(pInvPanel)
	InvSheet2:SetPos(pInvPanel:GetWide() - 260, 330)
	InvSheet2:SetSize(250, pInvPanel:GetTall() - 335)
	InvSheet2.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 100))
		for k, v in pairs(panel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end


-----------------------------------------Stats Form---------------------------------------------------------------
	local invStats = vgui.Create("DPanelList", pInvPanel)
	invStats:SetSize(675, 600)
	invStats:SetPos(0, 0)
	invStats:EnableVerticalScrollbar(true)
	invStats:SetSpacing(10)
	invStats.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
	end
	invStats.VBar.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(30, 30, 30, 50))
	end
	invStats.VBar.btnGrip.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(40, 40, 0, 50))
	end

	local mInfo = vgui.Create("DModelPanel", pInvPanel)
	mInfo:SetSize(200, 200)
	mInfo:SetPos(pInvPanel:GetWide() - 240, 25)
	mInfo:SetModel(ply:GetModel())
	mInfo:SetAnimSpeed(1)
	mInfo:SetAnimated(true)
	mInfo:SetAmbientLight(Color(50, 50, 50))
	mInfo:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	mInfo:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
	mInfo:SetCamPos(Vector(50, 0, 50))
	mInfo:SetLookAt(Vector(0, 0, 40))
	mInfo:SetFOV(80)

	local mButton = vgui.Create("DButton", pInvPanel)
	mButton:SetSize(90, 20)
	mButton:SetPos(pInvPanel:GetWide() - 100, 25)
	mButton:SetText(translate.Get("changemodel"))
	mButton:SetToolTip(translate.Get("changemodel_d"))
	mButton:SetTextColor(Color(255, 255, 255, 255))
	mButton.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(50, 50, 0, 130))
	end
	mButton.DoClick = function()
		RunConsoleCommand("tea_changemodel")
		self:CloseInvMenu()
	end

	-- local pInvArmorStats = vgui.Create("DPanel", pInvPanel)
	-- pInvArmorStats:SetSize(250, 200)
	-- pInvArmorStats:SetPos(wide - 260, 25)
	-- pInvArmorStats.Paint = function(panel, w, h)
	-- end


	local function DoStatsList()
		for k, v in SortedPairs(self.StatConfigs) do
			local descr = translate.Format("skill_descr", GAMEMODE:GetSkillDescription(k), v.Cost, v.Max, v.PerkMaxIncrease or 0)
			local LabelDefense = vgui.Create("DLabel")
			LabelDefense:SetPos(50, 50)
			LabelDefense:SetText(translate.Get(k)..": "..ply["Stat"..k])
			LabelDefense:SetToolTip(descr)
			LabelDefense:SizeToContents()
			invStats:AddItem(LabelDefense)

			local Button = vgui.Create("DButton")
			Button:SetPos(50, 100)
			Button:SetSize(10, 20)
			Button:SetTextColor(Color(255, 255, 255, 255))
			Button:SetText(translate.Format("inc1stat", translate.Get(k)))
			Button:SetToolTip(descr)

			local function applypoint(num)
				net.Start("UpgradePerk")
				net.WriteString(k)
				net.WriteUInt(num, 16)
				net.SendToServer()
				timer.Simple(0.3, function()
					if invStats:IsValid() then
						invStats:Clear()
						DoStatsList()
					end
				end)
			end

			Button.DoClick = function(Button)
				applypoint(1)
			end
			Button.DoDoubleClick = function(Button)
				applypoint(1)
			end
			Button.DoRightClick = function(Button)
				local d = DermaMenu()
				d:AddOption("Confirm", function()
					applypoint(math.Clamp(math.floor(MySP), 1, math.min(MySP, 65535)))
				end)
				d:Open()
			end
			Button.Paint = function(panel)
				draw.RoundedBox(0, 0, 0, panel:GetWide(), panel:GetTall(), Color(30, 30, 30, 50))
				draw.RoundedBox(0, 0, 0, ply["Stat"..k] * 225 / v.Max, panel:GetTall(), Color(100, 100, 0, 150))
				if ply["Stat"..k] > v.Max and v.PerkMaxIncrease then -- Empowered Skills
					draw.RoundedBox(0, 0, 0, (ply["Stat"..k]-v.Max) * 225 / (v.PerkMaxIncrease), panel:GetTall(), Color(200, 0, 0, 150))
				end
				surface.SetDrawColor(100, 100, 0 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			end
			invStats:AddItem(Button)
		end
	end
	DoStatsList()

	local props = vgui.Create("Panel", InvSheet1)
	props:SetSize(0,0)
	
	InvSheet1:AddSheet(translate.Get("sb_sheet1"), InvForm, "icon16/basket.png", false, false, translate.Get("sb_sheet1_d"))
	InvSheet1:AddSheet(translate.Get("sb_sheet5"), CraftForm, "icon16/wrench_orange.png", false, false, translate.Get("sb_sheet5_d"))
	InvSheet1:AddSheet(translate.Get("sb_sheet6"), StatisticsForm, "icon16/user.png", false, false, translate.Get("sb_sheet6_d"))
	local tab = InvSheet1:AddSheet("Props", props, "icon16/brick.png", false, false, "Props!")
	tab.Tab.DoClick = function()
		self:CloseInvMenu()
		self:OpenPropMenu()
	end



	InvSheet2:AddSheet(translate.Get("sb_sheet1_1"), invStats, "icon16/heart.png", false, false, translate.Get("sb_sheet1_1_d"))

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
	pPropPanel.Paint = function(panel)
		Derma_DrawBackgroundBlur(pPropPanel, SysTime()-0.2)

		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
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
	propSheet.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		if not tea_config_propcostenabled then
			local text1 = vgui.Create("DLabel", pPropPanel)
			text1:SetFont("TEA.HUDFontSmall")
			text1:SetText("Prop spawning cost disabled (excluding faction structures)")
			text1:SetColor(Color(205,205,205,255))
			text1:SetPos(400, 10)
			text1:SizeToContents()
		end
		for k, v in pairs(propSheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local propRefresh = vgui.Create("DButton", propSheet)
	propRefresh:SetText("Refresh Panel")
	propRefresh:SetTextColor(Color(255,255,230))
	propRefresh:SetToolTip("In case if something is wrong with this panel, click this button.\nIf this didn't work, report the problem to the author.")
	propRefresh:SetPos(800, 5)
	propRefresh:SetSize(120,20)
	propRefresh.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(50, 50, 0, 130))
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
		itPanel.Paint = function(panel) -- Paint function
			draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
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
		ItemClicker.Paint = function() -- Paint function
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
		itPanel.Paint = function(panel) -- Paint function
			draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
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
		ItemClicker.Paint = function() -- Paint function
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
		itPanel.Paint = function(panel) -- Paint function
			draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
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
		ItemClicker.Paint = function(panel) -- Paint function
			surface.SetDrawColor(20, 20, 60 ,200)
			surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
			surface.SetDrawColor(0, 0, 150 ,255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		end
		ItemClicker.DoClick = function()
			input.SelectWeapon(ply:GetWeapon("tea_buildtool"))
			surface.PlaySound("common/wpn_select.wav")
			ChooseStructure(k)
		end
	end

	propSheet:AddSheet(translate.Get("propsheet1"), FlimsyPanel, "icon16/bin.png", false, false, translate.Get("propsheet1_d"))
	propSheet:AddSheet(translate.Get("propsheet2"), StrongPanel, "icon16/shield.png", false, false, translate.Get("propsheet2_d"))
	propSheet:AddSheet(translate.Get("propsheet3"), SpecialPanel, "icon16/brick.png", false, false, translate.Get("propsheet3_d"))

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
	if IsValid(pInvPanel) then pInvPanel:Close() end
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
