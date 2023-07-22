-------------------------------- Propmenu (spawnmenu) --------------------------------

pPropsFrame = nil

function GM:OnSpawnMenuOpen()
	if IsValid(PropsFrame) then PropsFrame:Close() end
	self:PropMenu()
end

function GM:OnSpawnMenuClose()
	if IsValid(PropsFrame) then
		PropsFrame:Close()
	end
end


function GM:PropMenu()
	if IsValid(PropsFrame) and pPropsFrame then
		PropsFrame:SetAlpha(0)
		PropsFrame:AlphaTo(255, 0.2, 0)
		PropsFrame:SetVisible(true)
		return
	end
	
	PropsFrame = vgui.Create("DFrame")
	PropsFrame:SetSize(1000, 700)
	PropsFrame:Center()
	PropsFrame:SetAlpha(0)
	PropsFrame:AlphaTo(255, 0.2, 0)
	PropsFrame:SetTitle("")
	PropsFrame:SetDraggable(false)
	PropsFrame:ShowCloseButton(false)
	PropsFrame:SetDeleteOnClose(false)
	PropsFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, PropsFrame:GetWide(), PropsFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, PropsFrame:GetWide(), PropsFrame:GetTall())
	end
	PropsFrame.Think = function()
	end
	PropsFrame:MakePopup()
	PropsFrame:SetKeyboardInputEnabled(false)

	pPropsFrame = PropsFrame

	local tea_config_propcostenabled = self.PropCostEnabled
	local PropertySheet = vgui.Create("DPropertySheet", PropsFrame)
	PropertySheet:SetPos(5, 5)
	PropertySheet:SetSize(990, 690)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		if not tea_config_propcostenabled then
			local text1 = vgui.Create("DLabel", PropsFrame)
			text1:SetFont("TargetIDSmall")
			text1:SetText("Prop spawning cost disabled (excluding faction structures)")
			text1:SetColor(Color(205,205,205,255))
			text1:SetPos(400, 10)
			text1:SizeToContents()
		end
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end
	
	local RefreshButton = vgui.Create("DButton", PropertySheet)
	RefreshButton:SetText("Refresh Panel")
	RefreshButton:SetTextColor(Color(255,255,230))
	RefreshButton:SetToolTip("In case if something is wrong with this panel, click this button.\nIf this didn't work, report the problem to the author.")
	RefreshButton:SetPos(800, 5)
	RefreshButton:SetSize(120,20)
	RefreshButton.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, RefreshButton:GetWide(), RefreshButton:GetTall())
		draw.RoundedBox(2, 0, 0, RefreshButton:GetWide(), RefreshButton:GetTall(), Color(50, 50, 0, 130))
	end
	RefreshButton.DoClick = function()
		pPropsFrame = nil
		PropsFrame:Remove()
		gamemode.Call("OnSpawnMenuOpen")
		surface.PlaySound("common/wpn_select.wav")
	end

----------------------------------------------flimsy props-------------------------------------------------------
 
	local FlimsyPanel = vgui.Create("DPanelList")
	FlimsyPanel:SetTall(635)
	FlimsyPanel:SetWide(980)
	FlimsyPanel:SetPos(5, 25)
	FlimsyPanel:EnableVerticalScrollbar(true)
	FlimsyPanel:EnableHorizontal(true)
	FlimsyPanel:SetSpacing(5)

	local discount = 1 - ((Perks.Engineer or 0) * 0.02)
	for k, v in SortedPairsByMemberValue(FLIMSYPROPS, "COST") do

		local ItemBackground = vgui.Create("DPanel")
		ItemBackground:SetPos(5, 5)
		ItemBackground:SetSize(150, 150)
		ItemBackground:SetToolTip(Format("Prop health: %s HP", 500 * v.TOUGHNESS))
		ItemBackground.Paint = function() -- Paint function
			draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
		end

		local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
		ItemDisplay:SetPos(35, 5)
		ItemDisplay:SetModel(k)
		ItemDisplay:SetToolTip(false)
		ItemDisplay:SetSize(75,75)
		ItemDisplay.PaintOver = function()
			return
		end
		ItemDisplay.OnMousePressed = function()
			return false
		end

		local ItemName = vgui.Create("DLabel", ItemBackground)
		ItemName:SetFont("TargetIDSmall")
		ItemName:SetColor(Color(205,205,205,255))
		ItemName:SetText(v.NAME)
		ItemName:SizeToContents()
		ItemName:Center()
		local x,y = ItemName:GetPos();
		ItemName:SetPos(x, y + 20)

		if tea_config_propcostenabled then
			local ItemCost = vgui.Create("DLabel", ItemBackground)
			ItemCost:SetFont("TargetIDSmall")
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText(translate.Get("cost")..": ".. math.floor(v.COST * discount).." "..self.Config["Currency"].."s")
			ItemCost:SizeToContents()
			ItemCost:Center()
			local x,y = ItemCost:GetPos();
			ItemCost:SetPos(x, y + 40)
		end

		local ItemToughness = vgui.Create("DLabel", ItemBackground)
		ItemToughness:SetFont("TargetIDSmall")
		local text
		if v.TOUGHNESS >= 5 then
			text = "Maximal"
			ItemToughness:SetColor(Color(255,55,155,155))
		elseif v.TOUGHNESS >= 4 then
			text = "Very Strong"
			ItemToughness:SetColor(Color(255,105,155,155))
		elseif v.TOUGHNESS >= 3 then
			text = "Strong"
			ItemToughness:SetColor(Color(255,155,155,155))
		elseif v.TOUGHNESS >= 2 then
			text = "Medium"
			ItemToughness:SetColor(Color(255,205,155,155))
		elseif v.TOUGHNESS >= 1 then
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

		local ItemClicker = vgui.Create("DButton", ItemBackground)
		ItemClicker:SetText("")
		ItemClicker:SetPos(0, 0)
		ItemClicker:SetSize(ItemBackground:GetWide(), ItemBackground:GetTall())
		ItemClicker.Paint = function() -- Paint function
			return false
		end
		ItemClicker.DoClick = function() RunConsoleCommand("use","tea_buildtool")
			surface.PlaySound("common/wpn_select.wav")
			ChooseProp(tostring(k))
		end
		FlimsyPanel:AddItem(ItemBackground)
	end



----------------------------------------------strong props-------------------------------------------------------

	local StrongPanel = vgui.Create("DPanelList")
	StrongPanel:SetTall(635)
	StrongPanel:SetWide(980)
	StrongPanel:SetPos(5, 25)
	StrongPanel:EnableVerticalScrollbar(true)
	StrongPanel:EnableHorizontal(true)
	StrongPanel:SetSpacing(5)

	for k, v in SortedPairsByMemberValue(TOUGHPROPS, "COST") do
		local ItemBackground = vgui.Create("DPanel")
		ItemBackground:SetPos(5, 5)
		ItemBackground:SetSize(150, 150)
		ItemBackground:SetToolTip(Format("Prop health: %s HP", 500 * v.TOUGHNESS))
		ItemBackground.Paint = function() -- Paint function
			draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
		end

		local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
		ItemDisplay:SetPos(35, 5)
		ItemDisplay:SetModel(k)
		ItemDisplay:SetToolTip(false)
		ItemDisplay:SetSize(75,75)
		ItemDisplay.PaintOver = function()
			return
		end
		ItemDisplay.OnMousePressed = function()
			return false
		end

		local ItemName = vgui.Create("DLabel", ItemBackground)
		ItemName:SetFont("TargetIDSmall")
		ItemName:SetColor(Color(205,205,205,255))
		ItemName:SetText(v.NAME)
		ItemName:SizeToContents()
		ItemName:Center()
		local x,y = ItemName:GetPos();
		ItemName:SetPos(x, y + 20)

		if tea_config_propcostenabled then
			local ItemCost = vgui.Create("DLabel", ItemBackground)
			ItemCost:SetFont("TargetIDSmall")
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText(translate.Get("cost")..": "..math.floor(v.COST * discount).." "..self.Config["Currency"].."s")
			ItemCost:SizeToContents()
			ItemCost:Center()
			local x,y = ItemCost:GetPos();
			ItemCost:SetPos(x, y + 40)
		end

		local ItemToughness = vgui.Create("DLabel", ItemBackground)
		ItemToughness:SetFont("TargetIDSmall")
		local text
		if v.TOUGHNESS >= 5 then
			text = "Maximal"
			ItemToughness:SetColor(Color(255,55,155,155))
		elseif v.TOUGHNESS >= 4 then
			text = "Very Strong"
			ItemToughness:SetColor(Color(255,105,155,155))
		elseif v.TOUGHNESS >= 3 then
			text = "Strong"
			ItemToughness:SetColor(Color(255,155,155,155))
		elseif v.TOUGHNESS >= 2 then
			text = "Medium"
			ItemToughness:SetColor(Color(255,205,155,155))
		elseif v.TOUGHNESS >= 1 then
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


		local ItemClicker = vgui.Create("DButton", ItemBackground)
		ItemClicker:SetText("")
		ItemClicker:SetPos(0, 0)
		ItemClicker:SetSize(ItemBackground:GetWide(), ItemBackground:GetTall())
		ItemClicker.Paint = function() -- Paint function
			return false
		end
		ItemClicker.DoClick = function() RunConsoleCommand("use","tea_buildtool")
			surface.PlaySound("common/wpn_select.wav")
			ChooseProp(tostring(k))
		end
		StrongPanel:AddItem(ItemBackground)
	end

	local SpecialPanel = vgui.Create("DPanelList")
	SpecialPanel:SetTall(635)
	SpecialPanel:SetWide(980)
	SpecialPanel:SetPos(5, 25)
	SpecialPanel:EnableVerticalScrollbar(true)
	SpecialPanel:EnableHorizontal(true)
	SpecialPanel:SetSpacing(5)


	for k, v in SortedPairsByMemberValue(SpecialSpawns, "Cost") do
		local ItemBackground = vgui.Create("DPanel")
		ItemBackground:SetPos(5, 5)
		ItemBackground:SetSize(150, 150)
		ItemBackground.Paint = function() -- Paint function
			draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
			surface.SetDrawColor(50, 50, 50 ,255)
			surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
		end

		local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
		ItemDisplay:SetPos(35, 5)
		ItemDisplay:SetModel(v.Model)
		ItemDisplay:SetToolTip(v.Description)
		ItemDisplay:SetSize(75,75)
		ItemDisplay.PaintOver = function()
			return
		end
		ItemDisplay.OnMousePressed = function()
			return false
		end

		local ItemName = vgui.Create("DLabel", ItemBackground)
		ItemName:SetFont("TargetIDSmall")
		ItemName:SetColor(Color(205,205,205,255))
		ItemName:SetText(v.Name)
		ItemName:SizeToContents()
		ItemName:Center()
		local x,y = ItemName:GetPos();
		ItemName:SetPos(x, y + 20)

		local ItemCost = vgui.Create("DLabel", ItemBackground)
		ItemCost:SetFont("TargetIDSmall")
		ItemCost:SetColor(Color(155,255,155,255))
		ItemCost:SetText(translate.Get("cost")..": ".. v.Cost.." "..self.Config["Currency"].."s")
		ItemCost:SizeToContents()
		ItemCost:Center()
		local x,y = ItemCost:GetPos();
		ItemCost:SetPos(x, y + 40)

		local ItemClicker = vgui.Create("DButton", ItemBackground)
		ItemClicker:SetText("")
		ItemClicker:SetPos(15, 125)
		ItemClicker:SetTextColor(Color(255,255,255,255))
		ItemClicker:SetText(translate.Get("placeblueprint"))
		ItemClicker:SetSize(120, 20)
		ItemClicker.Paint = function() -- Paint function
			surface.SetDrawColor(20, 20, 60 ,200)
			surface.DrawRect(0, 0, ItemClicker:GetWide(), ItemClicker:GetTall())
			surface.SetDrawColor(0, 0, 150 ,255)
			surface.DrawOutlinedRect(0, 0, ItemClicker:GetWide(), ItemClicker:GetTall())
		end
		ItemClicker.DoClick = function() RunConsoleCommand("use","tea_buildtool")
			surface.PlaySound("common/wpn_select.wav")
			ChooseStructure(k)
		end
		SpecialPanel:AddItem(ItemBackground)
	end


	PropertySheet:AddSheet(translate.Get("propsheet1"), FlimsyPanel, "icon16/bin.png", false, false, translate.Get("propsheet1_d"))
	PropertySheet:AddSheet(translate.Get("propsheet2"), StrongPanel, "icon16/shield.png", false, false, translate.Get("propsheet2_d"))
	PropertySheet:AddSheet(translate.Get("propsheet3"), SpecialPanel, "icon16/brick.png", false, false, translate.Get("propsheet3_d"))
end
