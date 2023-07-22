-------------------------------- Dermahooks --------------------------------
--this is just too messed up
local sleeptime = 25

function GM:DrawSleepOverlay()
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
		Derma_DrawBackgroundBlur(LDFrame, LDFrame.Created)
		Derma_DrawBackgroundBlur(LDFrame, LDFrame.Created)
	end
	LDFrame.Think = function()
		if !LocalPlayer():Alive() and LDFrame and LDFrame:IsValid() then
			LDFrame:Close()
		end

		if LDFrame and LDFrame:IsValid() and LDFrame.CreateTime + sleeptime < CurTime() then
			LDFrame:Close()
		end
	end
	LDFrame.Created = SysTime()
	LDFrame.CreateTime = CurTime()

	local PaintPanel = vgui.Create("DPanel", LDFrame)
	PaintPanel:SetPos(15, 30)
	PaintPanel:SetSize(670, 190)
	PaintPanel.Paint = function()
		surface.SetFont("TargetID")
		local msg = translate.Format("sleep_1", math.max(math.floor((LDFrame.CreateTime + sleeptime - CurTime()) + 1), 0))
		draw.RoundedBox(12, 0, 0, PaintPanel:GetWide(), PaintPanel:GetTall(), Color(30,30,30,150))
		draw.DrawText(msg, "TargetID", PaintPanel:GetWide() / 2, 70, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local Dlabel = vgui.Create("DLabel", PaintPanel)
	surface.SetFont("Default")
	local msg2 = translate.Get("sleep_2")
	local w2,h2 = surface.GetTextSize(msg2)
	Dlabel:SetText(msg2)
	Dlabel:SizeToContents()
	Dlabel:SetPos((PaintPanel:GetWide() / 2) - (w2 / 2), 105)

end 
usermessage.Hook("DrawSleepOverlay", function()
	gamemode.Call("DrawSleepOverlay")
end)



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
	DelayFrame.Think = function()
		if DelayFrame and DelayFrame:IsValid() and remaining < CurTime() then
			DelayFrame:Remove()
		end
	end

	timer.Simple(delay, function()
		if DelayFrame and DelayFrame:IsValid() then
			DelayFrame:Remove()
		end
	end)
end)
