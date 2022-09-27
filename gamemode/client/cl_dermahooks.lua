-------------------------------- Dermahooks --------------------------------


function DrawSleepOverlay()
 
	local LDFrame = vgui.Create( "DFrame" )  
	LDFrame:SetPos( ScrW() / 2 - 350,ScrH() / 2 -125)  
	LDFrame:SetSize( 700, 250 )  
	LDFrame:SetTitle( "Sleeping..." )  
	LDFrame:SetVisible( true )  
	LDFrame:SetDraggable( true )  
	LDFrame:ShowCloseButton( false ) 
	LDFrame:SetBackgroundBlur( true )  
	LDFrame:MakePopup()
	LDFrame.Paint = function()
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, LDFrame:GetWide(), LDFrame:GetTall())
		Derma_DrawBackgroundBlur( LDFrame, CurTime() )
	end


	local PaintPanel = vgui.Create( "DPanel", LDFrame )  
	local LastSleep = CurTime() + 25
  
	PaintPanel:SetPos( 15, 30 )  
	PaintPanel:SetSize( 670, 190 )  
	PaintPanel.Paint = function()  
		draw.RoundedBox(12, 0, 0, PaintPanel:GetWide(), PaintPanel:GetTall(), Color(30,30,30,150))
		draw.DrawText(translate.Format("WillWakeupIn", math.Clamp(math.floor((LastSleep - CurTime()) + 1), 0, 2147483647)), "TargetID", 205, 70, Color( 255,255,255,255 ), 0, 1 )
	end 

local Dlabel = vgui.Create("DLabel", PaintPanel); 
	Dlabel:SetText( translate.Get("SleepText") ) 
	Dlabel:SetSize(490, 30); 
	Dlabel:SetPos(150, 85); 


timer.Simple(25, function() if LDFrame:IsValid() then LDFrame:Close() end end)

timer.Create("Sleeping", 1, 25, function() if !LocalPlayer():Alive() and LDFrame:IsValid() then LDFrame:Close()
elseif !LDFrame:IsValid() then timer.Destroy("Sleeping") end end)

end 
usermessage.Hook("DrawSleepOverlay", DrawSleepOverlay)



net.Receive("UseDelay", function()
	local delay = net.ReadUInt(8)
	local remaining = CurTime() + delay

	local t = ScrW() / 2 - 100
	local s = ScrH() / 2 - 5

	local DelayFrame = vgui.Create( "DFrame" )  
	DelayFrame:SetPos(t, s + 50)  
	DelayFrame:SetSize(200, 50)  
	DelayFrame:SetTitle( "" )
	DelayFrame:SetVisible(true)  
	DelayFrame:SetDraggable(false)  
	DelayFrame:ShowCloseButton(false) 
	DelayFrame:SetBackgroundBlur(true)  
	DelayFrame:MakePopup()
--DelayFrame:Center()
	DelayFrame.Paint = function( self, w, h )
		local fraction = (remaining - CurTime()) / delay
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(100, 0, 0, 250)
		surface.DrawRect(10, h / 2, fraction * 180, 20)
		surface.SetDrawColor(110, 0, 0, 250)
		surface.DrawRect(10, h / 2, fraction * 180, 10)

		surface.SetDrawColor(150, 0, 0, 200)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawOutlinedRect(10, h / 2, w - 20, 20)
		draw.DrawText(translate.Format("Pleasewait", math.ceil(remaining - CurTime())), "TargetID", 100, 5, Color(250, 250, 250), TEXT_ALIGN_CENTER )
	end

	timer.Simple(delay, function()
		if DelayFrame and DelayFrame:IsValid() then
			DelayFrame:Remove()
		end
	end)
end)