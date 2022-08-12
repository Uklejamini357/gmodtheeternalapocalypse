--Unused (i changed my mind, but will still be working on it)
/*
function DeathSC()
local DeathSC = vgui.Create( "DFrame" )
	DeathSC:SetSize( 500, 300 )
	DeathSC:Center()
	DeathSC:SetTitle ( " " )
	DeathSC:SetDraggable( false )
	DeathSC:SetVisible( true )
	DeathSC:ShowCloseButton( true )
	DeathSC:MakePopup()
	DeathSC.Paint = function()
	draw.RoundedBox( 2,  0,  0, DeathSC:GetWide(), DeathSC:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, DeathSC:GetWide(), DeathSC:GetTall())
	end

	local forcerspwn = vgui.Create("DButton", DeathSC)
	forcerspwn:SetSize( 120, 30 )
	forcerspwn:SetPos( 25, 250)
	forcerspwn:SetText("(ADMIN) Forcerespawn")
	forcerspwn:SetTextColor(Color(255, 255, 255, 255))
	forcerspwn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, forcerspwn:GetWide(), forcerspwn:GetTall())
	draw.RoundedBox( 2, 0, 0, forcerspwn:GetWide(), forcerspwn:GetTall(), Color(0, 0, 0, 130) )
	end
	forcerspwn.DoClick = function()
		net.Start("Respawn")
		net.SendToServer()
		DeathSC:Remove()
	end

	local chatmessage = vgui.Create("DButton", DeathSC)
	chatmessage:SetSize( 120, 30 )
	chatmessage:SetPos( 175, 250)
	chatmessage:SetText("Message")
	chatmessage:SetTextColor(Color(255, 255, 255, 255))
	chatmessage.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, chatmessage:GetWide(), chatmessage:GetTall())
	draw.RoundedBox( 2, 0, 0, chatmessage:GetWide(), chatmessage:GetTall(), Color(0, 0, 0, 130) )
	end
	chatmessage.DoClick = function()
	RunConsoleCommand("messagemode")
	end

	timer.Simple( 5, function()
	local respawn = vgui.Create("DButton", DeathSC)
	respawn:SetSize( 120, 30 )
	respawn:SetPos( 325, 250)
	respawn:SetText("Respawn")
	respawn:SetTextColor(Color(255, 255, 255, 255))
	respawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, respawn:GetWide(), respawn:GetTall())
	draw.RoundedBox( 2, 0, 0, respawn:GetWide(), respawn:GetTall(), Color(0, 0, 0, 130) )
	end
	respawn.DoClick = function()
	net.Start("Respawn")
	net.SendToServer()
	DeathSC:Remove()
	end
	end )



end
*/