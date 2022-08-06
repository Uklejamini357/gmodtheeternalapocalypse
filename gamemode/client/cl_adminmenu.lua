function AdminMenu()
local AdmMenuFrame = vgui.Create( "DFrame" )
	AdmMenuFrame:SetSize( 700, 400 )
	AdmMenuFrame:Center()
	AdmMenuFrame:SetTitle ( "(Unfinished) Admin Panel" )
	AdmMenuFrame:SetDraggable( false )
	AdmMenuFrame:SetVisible( true )
	AdmMenuFrame:ShowCloseButton( true )
	AdmMenuFrame:MakePopup()
	AdmMenuFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall())
	end

	local admcommands = vgui.Create( "DLabel", AdmMenuFrame )
	admcommands:SetFont( "TargetIDSmall" )
	admcommands:SetColor( Color(205,205,205,255) )
	admcommands:SetText( "Admin Commands" )
	admcommands:SizeToContents()
	admcommands:SetPos( 10, 25)

	local sadmcommands = vgui.Create( "DLabel", AdmMenuFrame )
	sadmcommands:SetFont( "TargetIDSmall" )
	sadmcommands:SetColor( Color(205,205,205,255) )
	sadmcommands:SetText( "Superadmin Commands" )
	sadmcommands:SizeToContents()
	sadmcommands:SetPos( 400, 25)


	local clearzeds = vgui.Create("DButton", AdmMenuFrame)
	clearzeds:SetSize( 120, 30 )
	clearzeds:SetPos( 20, 50)
	clearzeds:SetText("Cleanup Zombies")
	clearzeds:SetTextColor(Color(255, 255, 255, 255))
	clearzeds.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearzeds:GetWide(), clearzeds:GetTall())
	draw.RoundedBox( 2, 0, 0, clearzeds:GetWide(), clearzeds:GetTall(), Color(0, 0, 0, 130) )
	end
	clearzeds.DoClick = function()
	RunConsoleCommand("ate_admin_clearzombies")
	end

	local forceclearzeds = vgui.Create("DButton", AdmMenuFrame)
	forceclearzeds:SetSize( 120, 30 )
	forceclearzeds:SetPos( 20, 90)
	forceclearzeds:SetText("Cleanup All Zombies")
	forceclearzeds:SetTextColor(Color(255, 255, 255, 255))
	forceclearzeds.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, forceclearzeds:GetWide(), forceclearzeds:GetTall())
	draw.RoundedBox( 2, 0, 0, forceclearzeds:GetWide(), forceclearzeds:GetTall(), Color(0, 0, 0, 130) )
	end
	forceclearzeds.DoClick = function()
	RunConsoleCommand("ate_admin_clearzombies", "force")
	end

	local spawnboss = vgui.Create("DButton", AdmMenuFrame)
	spawnboss:SetSize( 120, 30 )
	spawnboss:SetPos( 20, 130)
	spawnboss:SetText("Spawn Boss")
	spawnboss:SetTextColor(Color(255, 255, 255, 255))
	spawnboss.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, spawnboss:GetWide(), spawnboss:GetTall())
	draw.RoundedBox( 2, 0, 0, spawnboss:GetWide(), spawnboss:GetTall(), Color(0, 0, 0, 130) )
	end
	spawnboss.DoClick = function()
	RunConsoleCommand("ate_admin_spawnboss")
	end

	local spawnairdrop = vgui.Create("DButton", AdmMenuFrame)
	spawnairdrop:SetSize( 120, 30 )
	spawnairdrop:SetPos( 20, 170)
	spawnairdrop:SetText("Spawn Airdrop")
	spawnairdrop:SetTextColor(Color(255, 255, 255, 255))
	spawnairdrop.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, spawnairdrop:GetWide(), spawnairdrop:GetTall())
	draw.RoundedBox( 2, 0, 0, spawnairdrop:GetWide(), spawnairdrop:GetTall(), Color(0, 0, 0, 130) )
	end
	spawnairdrop.DoClick = function()
	RunConsoleCommand("ate_admin_spawnairdrop")
	end

	local addadspawn = vgui.Create("DButton", AdmMenuFrame)
	addadspawn:SetSize( 120, 30 )
	addadspawn:SetPos( 170, 50)
	addadspawn:SetText("Add airdrop spawnpoint")
	addadspawn:SetTextColor(Color(255, 255, 255, 255))
	addadspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addadspawn:GetWide(), addadspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addadspawn:GetWide(), addadspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addadspawn.DoClick = function()
	RunConsoleCommand("ate_addairdropspawn")
	end

	local addlootspawn = vgui.Create("DButton", AdmMenuFrame)
	addlootspawn:SetSize( 120, 30 )
	addlootspawn:SetPos( 170, 90)
	addlootspawn:SetText("Add loot spawnpoint")
	addlootspawn:SetTextColor(Color(255, 255, 255, 255))
	addlootspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addlootspawn:GetWide(), addlootspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addlootspawn:GetWide(), addlootspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addlootspawn.DoClick = function()
	RunConsoleCommand("ate_addlootspawn")
	end

	local addplyspawn = vgui.Create("DButton", AdmMenuFrame)
	addplyspawn:SetSize( 120, 30 )
	addplyspawn:SetPos( 170, 130)
	addplyspawn:SetText("Add player spawnpoint")
	addplyspawn:SetTextColor(Color(255, 255, 255, 255))
	addplyspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addplyspawn:GetWide(), addplyspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addplyspawn:GetWide(), addplyspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addplyspawn.DoClick = function()
	RunConsoleCommand("ate_addplayerspawnpoint", "Spawnpoint_name")
	end

	local addtraderspawn = vgui.Create("DButton", AdmMenuFrame)
	addtraderspawn:SetSize( 120, 30 )
	addtraderspawn:SetPos( 170, 170)
	addtraderspawn:SetText("Add trader spawnpoint")
	addtraderspawn:SetTextColor(Color(255, 255, 255, 255))
	addtraderspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addtraderspawn:GetWide(), addtraderspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addtraderspawn:GetWide(), addtraderspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addtraderspawn.DoClick = function()
	RunConsoleCommand("ate_addtrader")
	end

	local addzombiespawn = vgui.Create("DButton", AdmMenuFrame)
	addzombiespawn:SetSize( 120, 30 )
	addzombiespawn:SetPos( 170, 210)
	addzombiespawn:SetText("Add zombie spawnpoint")
	addzombiespawn:SetTextColor(Color(255, 255, 255, 255))
	addzombiespawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addzombiespawn:GetWide(), addzombiespawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addzombiespawn:GetWide(), addzombiespawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addzombiespawn.DoClick = function()
	RunConsoleCommand("ate_addzombiespawn")
	end

	local clearadspawns = vgui.Create("DButton", AdmMenuFrame)
	clearadspawns:SetSize( 120, 30 )
	clearadspawns:SetPos( 320, 50)
	clearadspawns:SetText("Clear airdrop spawns")
	clearadspawns:SetTextColor(Color(255, 255, 255, 255))
	clearadspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearadspawns:GetWide(), clearadspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearadspawns:GetWide(), clearadspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearadspawns.DoClick = function()
	RunConsoleCommand("ate_clearairdropspawns")
	end

	local clearlootspawns = vgui.Create("DButton", AdmMenuFrame)
	clearlootspawns:SetSize( 120, 30 )
	clearlootspawns:SetPos( 320, 90)
	clearlootspawns:SetText("Clear loot spawns")
	clearlootspawns:SetTextColor(Color(255, 255, 255, 255))
	clearlootspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearlootspawns:GetWide(), clearlootspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearlootspawns:GetWide(), clearlootspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearlootspawns.DoClick = function()
	RunConsoleCommand("ate_clearlootspawns")
	end

	local clearplyspawns = vgui.Create("DButton", AdmMenuFrame)
	clearplyspawns:SetSize( 120, 30 )
	clearplyspawns:SetPos( 320, 130)
	clearplyspawns:SetText("Clear player spawnponts")
	clearplyspawns:SetTextColor(Color(255, 255, 255, 255))
	clearplyspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearplyspawns:GetWide(), clearplyspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearplyspawns:GetWide(), clearplyspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearplyspawns.DoClick = function()
	RunConsoleCommand("ate_clearplayerspawnpoints", "No name")
	end

	local cleartraderspawns = vgui.Create("DButton", AdmMenuFrame)
	cleartraderspawns:SetSize( 120, 30 )
	cleartraderspawns:SetPos( 320, 170)
	cleartraderspawns:SetText("Clear Trader spawns")
	cleartraderspawns:SetTextColor(Color(255, 255, 255, 255))
	cleartraderspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, cleartraderspawns:GetWide(), cleartraderspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, cleartraderspawns:GetWide(), cleartraderspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	cleartraderspawns.DoClick = function()
	RunConsoleCommand("ate_cleartraderspawns")
	end

	local clearzombiespawns = vgui.Create("DButton", AdmMenuFrame)
	clearzombiespawns:SetSize( 120, 30 )
	clearzombiespawns:SetPos( 320, 210)
	clearzombiespawns:SetText("Clear zombie spawns")
	clearzombiespawns:SetTextColor(Color(255, 255, 255, 255))
	clearzombiespawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearzombiespawns:GetWide(), clearzombiespawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearzombiespawns:GetWide(), clearzombiespawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearzombiespawns.DoClick = function()
	RunConsoleCommand("ate_clearzombiespawns")
	end


end