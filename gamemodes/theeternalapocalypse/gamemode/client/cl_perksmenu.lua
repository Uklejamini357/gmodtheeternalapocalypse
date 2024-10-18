-- Yes.

GM.LocalPerks = GM.LocalPerks or {}

local perksvgui
local perkresetconfirm

local function PrettySureYouDontWannaDoThis()
	local costpoints = 0
	local points = MyPerkPoints

	for perk,_ in pairs(GAMEMODE.LocalPerks) do
		local perkinfo = GAMEMODE.PerksList[perk]

		costpoints = costpoints + perkinfo.Cost
		points = points + perkinfo.Cost
	end
	
	local finalcost = 2000 * costpoints + (costpoints * 500*((costpoints-1)/2))

	if finalcost <= 0 then return end

	if IsValid(perkresetconfirm) then perkresetconfirm:Remove() end
	perkresetconfirm = vgui.Create("DFrame")
	perkresetconfirm:SetSize(600, 350)
	perkresetconfirm:Center()
	perkresetconfirm:SetTitle("About to reset your perks")
	perkresetconfirm:SetDraggable(false)
	perkresetconfirm:SetVisible(true)
	perkresetconfirm:SetAlpha(0)
	perkresetconfirm:AlphaTo(255, 1, 0)
	perkresetconfirm:ShowCloseButton(true)
	perkresetconfirm:MakePopup()
	perkresetconfirm.Paint = function(this)
		draw.RoundedBox(2, 0, 0, this:GetWide(), this:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, this:GetWide(), this:GetTall())
	end
	perkresetconfirm.Think = function(this)
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				this:Remove()
			end)
			gui.HideGameUI()
		end
	end


	local txt = vgui.Create("DLabel", perkresetconfirm)
	txt:SetFont("TargetIDSmall")
	txt:SetPos(10, 33)
	txt:SetText("This will reset your perks, but will also refund your perk points.")
	txt:SizeToContents()

	local txt2 = vgui.Create("DLabel", perkresetconfirm)
	txt2:SetFont("TargetIDSmall")
	txt2:SetPos(10, 55)
	txt2:SetText("However, you will need at least "..finalcost.." "..GAMEMODE.Config["Currency"].."s to do this.")
	txt2:SizeToContents()

	local txt3 = vgui.Create("DLabel", perkresetconfirm)
	txt3:SetFont("TargetIDSmall")
	txt3:SetPos(10, 77)
	txt3:SetText("However, there is no cooldown for resetting perks.")
	txt3:SizeToContents()

	local txt4 = vgui.Create("DLabel", perkresetconfirm)
	txt4:SetFont("TargetIDSmall")
	txt4:SetPos(10, 99)
	txt4:SetText("Are you sure you want to do this?")
	txt4:SizeToContents()

	local reset = vgui.Create("DButton", perkresetconfirm)
	reset:SetSize(150, 25)
	reset:Center()
	local _x,_y = reset:GetPos()
	reset:SetPos(_x,_y + 100)
	reset:SetText("Confirm")
	reset:SetTextColor(Color(255,155,0,255))
	reset.Paint = function(panel)
		surface.SetDrawColor(0, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
	end
	reset.DoClick = function(this)
		perkresetconfirm:Close()
		net.Start("tea_perksreset")
		net.SendToServer()
	end
end


function GM:CallPerksMenu()
	if IsValid(perksvgui) then perksvgui:Remove() end
	perksvgui = vgui.Create("DFrame")
	perksvgui:SetSize(900, 660)
	perksvgui:Center()
	perksvgui:SetTitle("")
	perksvgui:SetDraggable(false)
	perksvgui:SetVisible(true)
	perksvgui:SetAlpha(0)
	perksvgui:AlphaTo(255, 1, 0)
	perksvgui:ShowCloseButton(true)
	perksvgui:MakePopup()
	perksvgui.Paint = function(this)
		draw.RoundedBox(2, 0, 0, this:GetWide(), this:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, this:GetWide(), this:GetTall())
	end
	perksvgui.Think = function(this)
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				this:Remove()
			end)
			gui.HideGameUI()
		end
	end

	local sheet = vgui.Create("DPropertySheet", perksvgui)
	sheet:SetPos(5, 25)
	sheet:SetSize(875, perksvgui:GetTall() - 35)
	sheet.Paint = function(panel)
		for k, v in pairs(panel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(this,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local perklist = vgui.Create("DPanelList")
	perklist:SetSize(850, perksvgui:GetTall() - 25)
	perklist:SetPos(5, 25)
	perklist:EnableVerticalScrollbar(true)
	perklist:EnableHorizontal(true)
	perklist:SetSpacing(10)


	local LWeight = vgui.Create("DLabel", perksvgui)
	LWeight:SetFont("TargetIDSmall")
	LWeight:SetPos(10, 3)
	LWeight:SetText("Perk points: "..MyPerkPoints)
	LWeight:SizeToContents()
	local x,y = LWeight:GetSize()
	LWeight:SetSize(math.min(x, 350), 25)
	LWeight:SetColor(Color(255,255,255,255))
	LWeight:SetMouseInputEnabled(true)
	LWeight:SetToolTip("Perk points are required to unlock perk!\nThey can be gained by prestiging")
	LWeight.Think = function(panel)
		local txt = "Perk points: "..MyPerkPoints
		if panel:GetText() == txt then return end
		panel:SetText(txt)
		LWeight:SizeToContents()
		local x,y = LWeight:GetSize()
		LWeight:SetSize(math.min(x, 350), 25)
	end

	local ResetPerks = vgui.Create("DButton", perksvgui)
	ResetPerks:SetSize(150, 25)
	ResetPerks:SetPos(perksvgui:GetWide()-ResetPerks:GetWide()-100, 5)
	ResetPerks:SetText("Reset your perks")
	ResetPerks:SetTextColor(Color(255,255,0,255))
	ResetPerks:SetMouseInputEnabled(true)
	ResetPerks:SetToolTip("Reset your perks at the cost of money")
	ResetPerks.Paint = function(panel)
		surface.SetDrawColor(0, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
	end
	ResetPerks.DoClick = function(this)
		perksvgui:Close()
		PrettySureYouDontWannaDoThis()
	end




	--------------------------------------------supplies-------------------------------------------------------------
	

	local hoverdesc = vgui.Create("DLabel", perksvgui)
	hoverdesc:SetFont("TargetIDSmall")
	hoverdesc:SetPos(120, 0)
	hoverdesc:SetText("Note: Hover your cursor over perks' description with white color for more info")
	hoverdesc:SizeToContents()
	local x,y = hoverdesc:GetSize()
	hoverdesc:SetSize(810, 30)

	for k, v in SortedPairsByMemberValue(GAMEMODE.PerksList, "PrestigeReq") do
		local perkpanel = vgui.Create("DPanel")
		perkpanel:SetPos(5, 5)
        local size_x,size_y = 400,150
		perkpanel:SetSize(size_x, size_y)
		perkpanel.Paint = function(panel) -- Paint function
			draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2, self.LocalPerks[k] and Color(40, 200, 40, 25) or v.PrestigeReq > MyPrestige and Color(75, 75, 75, 50) or Color(200, 40, 40, 25), false, false, false, false)
			surface.SetDrawColor(50, 50, 50, 255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		end

		local perkname = vgui.Create("DLabel", perkpanel)
		perkname:SetFont("TargetID")
		perkname:SetPos(0, 10)
		perkname:SetText(v.Name)
		if v.GetTextColor then
			perkname:SetTextColor(v.GetTextColor())
		end
		perkname.Think = function(panel)
			if v.KeepUpdatingColor and v.GetTextColor then
				panel:SetTextColor(v.GetTextColor())
			end
		end
		perkname:SizeToContents()
        local x,y = perkname:GetSize()
		perkname:SetSize(math.min(size_x - 20, x), y)
		perkname:CenterHorizontal()

		local perkdesc = vgui.Create("DLabel", perkpanel)
		perkdesc:SetFont("TargetIDSmall")
		perkdesc:SetPos(0, 35)
		perkdesc:SetText(v.Description)
		perkdesc:SetMouseInputEnabled(true)
		if v.AddDescription then
			perkdesc:SetTextColor(Color(255,255,255))
			perkdesc:SetToolTip(v.AddDescription)
		else
			perkdesc:SetTextColor(Color(155,155,155))
		end
		perkdesc:SizeToContents()
        local x,y = perkdesc:GetSize()
		perkdesc:SetSize(math.min(size_x - 20, x), 35)
		perkdesc:SetWrap(true)
		perkdesc:CenterHorizontal()

		local perkcost = vgui.Create("DLabel", perkpanel)
		perkcost:SetFont("TargetIDSmall")
		perkcost:SetText("Points cost: "..v.Cost)
        perkcost:SetPos(10, 72)
		perkcost:SetSize(size_x - 20, 15)
		perkcost:SetWrap(true)
		perkcost:SetColor(Color(155,155,255,255))

		local perkprestige = vgui.Create("DLabel", perkpanel)
		perkprestige:SetFont("TargetIDSmall")
		perkprestige:SetPos(10, 89)
		perkprestige:SetSize(size_x - 20, 15)
		perkprestige:SetText("Prestige need: "..v.PrestigeReq)
		perkprestige:SetWrap(true)
		perkprestige:SetColor(Color(255,155,155,255))


		local perkapply = vgui.Create("DButton", perkpanel)
		perkapply:SetSize(size_x - 20, 30)
		perkapply:SetPos(10, size_y - 35)
		perkapply:SetText(self.LocalPerks[k] and "Unlocked" or v.PrestigeReq > MyPrestige and "Not enough prestige" or "Unlock")
		perkapply.Think = function(panel)
			local txt = self.LocalPerks[k] and "Unlocked" or v.PrestigeReq > MyPrestige and "Not enough prestige" or "Unlock"
			if panel:GetText() == txt then return end
			panel:SetText(txt)	
		end
		perkapply:SetTextColor(Color(255, 255, 255, 255))
		perkapply.Paint = function(panel)
			surface.SetDrawColor(0, 150, 0, 255)
			surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), v.PrestigeReq > MyPrestige and Color(75, 75, 75, 130) or Color(0, 50, 0, 130))
		end
		perkapply.DoClick = function(panel)
			net.Start("tea_perksunlock")
			net.WriteString(k)
			net.SendToServer()
		end
		perklist:AddItem(perkpanel)
	end



	sheet:AddSheet("Perks", perklist, "icon16/star.png", false, false, "Perks are additional buffs provided in survival\nChoose which perk you should unlock first!\n\nNote: Perk choices are permanent and can't be reset!")
end
