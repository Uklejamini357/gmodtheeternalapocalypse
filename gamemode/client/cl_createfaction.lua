	-------------------------------- Faction Menu --------------------------------

function FactionMenu()

local FactionColor = Color(0,0,0,255)

FactionFrame = vgui.Create( "DFrame" )
FactionFrame:SetSize( 600, 440 )
FactionFrame:Center()
FactionFrame:SetTitle ( "" )
FactionFrame:SetDraggable( false )
FactionFrame:SetVisible( true )
FactionFrame:SetAlpha(0)
FactionFrame:AlphaTo(255, 0.25, 0)
FactionFrame:ShowCloseButton( true )
FactionFrame:MakePopup()
FactionFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, FactionFrame:GetWide(), FactionFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, FactionFrame:GetWide(), FactionFrame:GetTall())
end

	local title = vgui.Create("DLabel", FactionFrame)
		title:SetPos(25,10)
		title:SetFont( "TargetID" )
		title:SetText("Create a faction")
		title:SizeToContents()

	local desc = vgui.Create("DLabel", FactionFrame)
		desc:SetPos(25,30)
--		desc:SetFont( "TargetIDSmall" )
		desc:SetText("Note: creating a faction makes it so members of other factions can PVP you at all times.\nOn the upside it allows you to build using strong props (which cannot be damaged by most guns) and place \nfaction structures such as fridges, ammo crates, generators, storage vaults etc. \nWarning: Creating a faction will also cost some money. Your faction name cannot contain more than \n20 characters.")
		desc:SetTextColor(Color(250, 225, 200, 255))
		desc:SizeToContents()

	local tnamelabel = vgui.Create("DLabel", FactionFrame)
		tnamelabel:SetPos(25,100)
		tnamelabel:SetFont( "TargetIDSmall" )
		tnamelabel:SetText("Faction Name:")
		tnamelabel:SizeToContents()
		
	local tname = vgui.Create("DTextEntry",FactionFrame)
		tname:SetSize(FactionFrame:GetWide()-50, 30)
		tname:SetPos(25, 120)
		tname:SetEnterAllowed( false )

	local tnamelabel = vgui.Create("DLabel", FactionFrame)
		tnamelabel:SetPos(25,160)
		tnamelabel:SetFont( "TargetIDSmall" )
		tnamelabel:SetText("Faction Colour:")
		tnamelabel:SizeToContents()

	local tcolor = vgui.Create("DColorMixer",FactionFrame)
		tcolor:SetSize(FactionFrame:GetWide()-50, 150)
		tcolor:SetPos(25, 180)
	tcolor.ValueChanged = function(Mixer, color) 
	FactionColor = color
	end

	local pub = vgui.Create("DCheckBoxLabel",FactionFrame)
--		pub:SetSize(FactionFrame:GetWide()-10, 150)
		pub:SetPos(25, 350)
		pub:SetText("Is this faction public?")
		pub:SizeToContents()


	local createbutton = vgui.Create("DButton", FactionFrame)
		createbutton:SetSize( 550, 30 )
		createbutton:SetPos( 25, 390 )
		createbutton:SetFont("TargetIDSmall")
		createbutton:SetText("Create my faction!")
		createbutton:SetTextColor(Color(255, 255, 255, 255))
		createbutton.Paint = function(panel)
			surface.SetDrawColor(125, 125, 125 ,255)
			surface.DrawOutlinedRect(0, 0, createbutton:GetWide(), createbutton:GetTall())
			surface.SetDrawColor(25, 25, 25 ,155)
			surface.DrawRect(0, 0, createbutton:GetWide(), createbutton:GetTall())
		end
			createbutton.DoClick = function()
			net.Start("CreateFaction")
			net.WriteString(tname:GetText() or "")
			net.WriteTable(FactionColor or Color(0,0,0,255))
			net.WriteBool(pub:GetChecked() or false)
			net.SendToServer()
		end

end
concommand.Add("ate_createfaction", FactionMenu)


function ManageMenu()

if LocalPlayer():Team() == 1 then chat.AddText(Color(255,255,255,255), "[System] ", Color(255,205,205,255), "You are not in a faction!") return false end
--if LocalPlayer():Team() == 1 then chat.AddText(Color(255,255,255,255), "[System] ", Color(255,205,205,255), "You are not the leader of your faction!") return false end


ManageFrame = vgui.Create( "DFrame" )
ManageFrame:SetSize( 600, 500 )
ManageFrame:Center()
ManageFrame:SetTitle ( "" )
ManageFrame:SetDraggable( false )
ManageFrame:SetVisible( true )
ManageFrame:SetAlpha(0)
ManageFrame:AlphaTo(255, 0.25, 0)
ManageFrame:ShowCloseButton( true )
ManageFrame:MakePopup()
ManageFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, ManageFrame:GetWide(), ManageFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, ManageFrame:GetWide(), ManageFrame:GetTall())
	surface.DrawOutlinedRect(10, 50, 350, 370)
	surface.SetDrawColor(150, 50, 0 ,255)
	surface.DrawOutlinedRect(380, 50, 200, 370)
end

local txt = vgui.Create( "DLabel", ManageFrame )
txt:SetPos( 10, 28 )
txt:SetFont( "TargetIDSmall" )
txt:SetColor( Color(255,255,255,255) )
txt:SetText( "Members of your faction:" )
txt:SizeToContents()

local txt2 = vgui.Create( "DLabel", ManageFrame )
txt2:SetPos( 380, 28 )
txt2:SetFont( "TargetIDSmall" )
txt2:SetColor( Color(255,255,255,255) )
txt2:SetText( "Invite to faction:" )
txt2:SizeToContents()

local Plist = vgui.Create( "DPanelList", ManageFrame )
Plist:SetSize( 350, 370 )
Plist:SetPadding( 5 )
Plist:SetSpacing( 5 )
Plist:EnableHorizontal( false )
Plist:EnableVerticalScrollbar( true )
Plist:SetPos( 10, 50 )
Plist:SetName( "" )

	local disbandbutton = vgui.Create("DButton", ManageFrame)
		disbandbutton:SetSize( 200, 30 )
		disbandbutton:SetPos( 10, 450 )
--		disbandbutton:SetFont("TargetIDSmall")
		disbandbutton:SetText("Disband your faction")
		disbandbutton:SetTextColor(Color(255, 255, 255, 255))
		disbandbutton.Paint = function(panel)
			surface.SetDrawColor(155, 0, 0 ,255)
			surface.DrawOutlinedRect(0, 0, disbandbutton:GetWide(), disbandbutton:GetTall())
			surface.SetDrawColor(50, 0, 0 ,155)
			surface.DrawRect(0, 0, disbandbutton:GetWide(), disbandbutton:GetTall())
		end
			disbandbutton.DoClick = function()
			net.Start("DisbandFaction")
			net.SendToServer()
		end

for k, v in pairs( team.GetPlayers(LocalPlayer():Team()) ) do

	local plypanel = vgui.Create( "DPanel" )
	plypanel:SetPos( 0, 0 )
	plypanel:SetSize( 350, 30 )
	plypanel.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(50, 50, 50 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
	end

	local kickbutton = vgui.Create("DButton", plypanel)
		kickbutton:SetSize( 50, 20 )
		kickbutton:SetPos( 210, 6 )
--		kickbutton:SetFont("TargetIDSmall")
		kickbutton:SetText("Kick")
		kickbutton:SetTextColor(Color(255, 255, 255, 255))
		kickbutton.Paint = function(panel)
			surface.SetDrawColor(125, 75, 0 ,255)
			surface.DrawOutlinedRect(0, 0, kickbutton:GetWide(), kickbutton:GetTall())
			surface.SetDrawColor(55, 25, 0 ,155)
			surface.DrawRect(0, 0, kickbutton:GetWide(), kickbutton:GetTall())
		end
			kickbutton.DoClick = function()
			net.Start("KickFromFaction")
			net.WriteEntity(v)
			net.SendToServer()
		end

	local ldrbutton = vgui.Create("DButton", plypanel)
		ldrbutton:SetSize( 70, 20 )
		ldrbutton:SetPos( 265, 6 )
--	  ldrbutton:SetFont("TargetIDSmall")
		ldrbutton:SetText("Set Leader")
		ldrbutton:SetTextColor(Color(255, 255, 255, 255))
		ldrbutton.Paint = function(panel)
			surface.SetDrawColor(25, 125, 125 ,255)
			surface.DrawOutlinedRect(0, 0, ldrbutton:GetWide(), ldrbutton:GetTall())
			surface.SetDrawColor(5, 25, 25 ,155)
			surface.DrawRect(0, 0, ldrbutton:GetWide(), ldrbutton:GetTall())
		end
		ldrbutton.DoClick = function()
			net.Start("GiveLeader")
			net.WriteEntity(v)
			net.SendToServer()
		end

	local plyname = vgui.Create( "DLabel", plypanel )
	plyname:SetPos( 12, 8 )
	plyname:SetFont( "TargetIDSmall" )
	plyname:SetColor( Color(255,255,255,255) )
	plyname:SetText( v:Nick())
	plyname:SizeToContents()

	Plist:AddItem( plypanel )

end





local Plist2 = vgui.Create( "DPanelList", ManageFrame )
Plist2:SetSize( 200, 370 )
Plist2:SetPadding( 5 )
Plist2:SetSpacing( 5 )
Plist2:EnableHorizontal( false )
Plist2:EnableVerticalScrollbar( true )
Plist2:SetPos( 380, 50 )
Plist2:SetName( "" )

for k, v in pairs( player.GetAll() ) do
if v:Team() == LocalPlayer():Team() then continue end
/*
	local plypanel = vgui.Create( "DPanel" )
	plypanel:SetPos( 0, 0 )
	plypanel:SetSize( 250, 30 )
	plypanel.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(50, 50, 50 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
	end

	local plyname = vgui.Create( "DLabel", plypanel )
	plyname:SetPos( 12, 8 )
	plyname:SetFont( "TargetIDSmall" )
	plyname:SetColor( Color(255,255,255,255) )
	plyname:SetText( v:Nick())
	plyname:SizeToContents()
*/

	local clicker = vgui.Create("DButton")
		clicker:SetSize( 250, 30 )
		clicker:SetPos( 0, 0 )
		clicker:SetText(v:Nick())
		clicker:SetTextColor(Color(255, 255, 255, 255))
		clicker.Paint = function(panel)
			surface.SetDrawColor(0, 125, 0 ,255)
			surface.DrawOutlinedRect(0, 0, clicker:GetWide(), clicker:GetTall())
			surface.SetDrawColor(0, 45, 0 ,155)
			surface.DrawRect(0, 0, clicker:GetWide(), clicker:GetTall())
		end
			clicker.DoClick = function()
			net.Start("InviteFaction")
			net.WriteEntity(v)
			net.SendToServer()
		end

	Plist2:AddItem( clicker )

end

end
concommand.Add("ate_managefaction", ManageMenu)