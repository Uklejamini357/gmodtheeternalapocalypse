-- it's invalid

GM.Panels.DeathScreen = {}

function GM:DoDeathPanel()
	if frame then

	end
		
	local frame = vgui.Create("DFrame")
	timer.Simple(10, function()
		frame:Remove()
	end)
	frame:SetSize(wid, hei)
	frame:Center()
	frame:ShowCloseButton(false)
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame.Paint = function() end
end
