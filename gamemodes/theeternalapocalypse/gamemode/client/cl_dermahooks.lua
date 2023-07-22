-------------------------------- Dermahooks --------------------------------
--this is just too messed up

function DrawSleepOverlay()
	local LDFrame = vgui.Create("DFrame")
	LDFrame:SetPos(ScrW() / 2 - 350,ScrH() / 2 - 125)
	LDFrame:SetSize(700, 250)
	LDFrame:SetTitle("Sleeping...")
	LDFrame:SetVisible(true)
	LDFrame:SetDraggable(true)
	LDFrame:ShowCloseButton(false)
	LDFrame:SetBackgroundBlur(true)
	LDFrame:MakePopup()
	LDFrame.Paint = function()
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, LDFrame:GetWide(), LDFrame:GetTall())
		Derma_DrawBackgroundBlur(LDFrame, CurTime())
	end

	timer.Simple(25, function()
		if LDFrame:IsValid() then
			LDFrame:Close()
		end
	end)

	timer.Create("Sleeping", 1, 25, function()
		if !LocalPlayer():Alive() and LDFrame:IsValid() then
			LDFrame:Close()
		elseif !LDFrame:IsValid() then
			timer.Destroy("Sleeping")
		end
	end)

	local PaintPanel = vgui.Create("DPanel", LDFrame)
	local LastSleep = CurTime() + 25
  
	PaintPanel:SetPos(15, 30)
	PaintPanel:SetSize(670, 190)
	PaintPanel.Paint = function()
		surface.SetFont("TargetID")
		local msg = translate.Format("sleep_1", math.max(math.floor((LastSleep - CurTime()) + 1), 0))
		local w,h = surface.GetTextSize(msg)
		draw.RoundedBox(12, 0, 0, PaintPanel:GetWide(), PaintPanel:GetTall(), Color(30,30,30,150))
		draw.DrawText(msg, "TargetID", (PaintPanel:GetWide() / 2) - (w / 2), 70, Color(255,255,255,255), 0, 1)
	end

	local Dlabel = vgui.Create("DLabel", PaintPanel)
	surface.SetFont("Arial_2")
	local msg2 = translate.Get("sleep_2")
	local w2,h2 = surface.GetTextSize(msg2)
	Dlabel:SetText(msg2)
	Dlabel:SizeToContents()
	Dlabel:SetPos((PaintPanel:GetWide() / 2) - (w2 / 2), 105)

end 
usermessage.Hook("DrawSleepOverlay", DrawSleepOverlay)



net.Receive("UseDelay", function()
	local delay = net.ReadUInt(8)
	local remaining = CurTime() + delay

	local t = ScrW() / 2 - 100
	local s = ScrH() / 2 - 5

	local DelayFrame = vgui.Create("DFrame")
	DelayFrame:SetPos(t, s + 50)
	DelayFrame:SetSize(200, 50)
	DelayFrame:SetTitle("")
	DelayFrame:SetVisible(true)
	DelayFrame:SetDraggable(false)
	DelayFrame:ShowCloseButton(false)
	DelayFrame:SetBackgroundBlur(true)
	DelayFrame:MakePopup()
--DelayFrame:Center()
	DelayFrame.Paint = function(self, w, h)
		local fraction = (remaining - CurTime()) / delay
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(200, 200, 200, 220)
		surface.DrawRect(10, h / 2, fraction * 180, 20)
		surface.SetDrawColor(220, 220, 220, 225)
		surface.DrawRect(10, h / 2, fraction * 180, 10)

		surface.SetDrawColor(120, 120, 0, 200)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawOutlinedRect(10, h / 2, w - 20, 20)
		draw.DrawText(translate.Format("wait", math.max(0, math.ceil((remaining - CurTime()) * 10) / 10)), "TargetID", 100, 5, Color(250, 250, 250), TEXT_ALIGN_CENTER)
	end

	timer.Simple(delay, function()
		if DelayFrame and DelayFrame:IsValid() then
			DelayFrame:Remove()
		end
	end)
end)
