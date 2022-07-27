--Unused (i changed my mind)
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
	local clearzeds = vgui.Create("DButton", DeathSC)
	clearzeds:SetSize( 120, 30 )
	clearzeds:SetPos( 325, 250)
	clearzeds:SetText("Respawn")
	clearzeds:SetTextColor(Color(255, 255, 255, 255))
	clearzeds.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearzeds:GetWide(), clearzeds:GetTall())
	draw.RoundedBox( 2, 0, 0, clearzeds:GetWide(), clearzeds:GetTall(), Color(0, 0, 0, 130) )
	end
	clearzeds.DoClick = function()
	DeathSC:Remove()
	end
	end )



end
*/