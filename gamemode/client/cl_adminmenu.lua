--if you find this text, congratulations

function AdminMenu()
	if IsValid(AdmMenuFrame) then AdmMenuFrame:Remove() end
	timer.Simple(0.2, function() surface.PlaySound("buttons/button24.wav") end)
	AdmMenuFrame = vgui.Create( "DFrame" )
	AdmMenuFrame:SetSize( 1000, 700 )
	AdmMenuFrame:Center()
	AdmMenuFrame:SetTitle ("Administration Panel")
	AdmMenuFrame:SetDraggable( false )
	AdmMenuFrame:SetVisible( true )
	AdmMenuFrame:SetAlpha(0)
	AdmMenuFrame:AlphaTo(255, 0.5, 0)
	AdmMenuFrame:ShowCloseButton( true )
	AdmMenuFrame:MakePopup()
	AdmMenuFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall())
	end

	local PropertySheet = vgui.Create( "DPropertySheet", AdmMenuFrame )
	PropertySheet:SetPos( 5, 20 )
	PropertySheet:SetSize( 990, 680 )
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
			end
		end
	end

	local AdminCmds = vgui.Create( "DPanel", PropertySheet )
	AdminCmds:SetSize(780, 500)
	AdminCmds.Paint = function( self, w, h )
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	local text1 = vgui.Create("DLabel", AdminCmds)
	text1:SetFont("TargetIDSmall")
	text1:SetColor(Color(205,205,205,255))
	text1:SetText("Zombies")
	text1:SizeToContents()
	text1:SetPos(20, 20)

	local text2 = vgui.Create("DLabel", AdminCmds)
	text2:SetFont("TargetIDSmall")
	text2:SetColor(Color(205,205,205,255))
	text2:SetText("Spawn Boss/Airdrop")
	text2:SizeToContents()
	text2:SetPos(20, 90)

	local clearzeds = vgui.Create("DButton", AdminCmds)
	clearzeds:SetSize( 120, 30 )
	clearzeds:SetPos( 20, 45)
	clearzeds:SetText("Cleanup Zombies")
	clearzeds:SetTextColor(Color(255, 255, 255, 255))
	clearzeds.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearzeds:GetWide(), clearzeds:GetTall())
	draw.RoundedBox( 2, 0, 0, clearzeds:GetWide(), clearzeds:GetTall(), Color(0, 0, 0, 130) )
	end
	clearzeds.DoClick = function()
	RunConsoleCommand("tea_admin_clearzombies")
	end

	local forceclearzeds = vgui.Create("DButton", AdminCmds)
	forceclearzeds:SetSize( 120, 30 )
	forceclearzeds:SetPos( 150, 45)
	forceclearzeds:SetText("Cleanup All Zombies")
	forceclearzeds:SetTextColor(Color(255, 255, 255, 255))
	forceclearzeds.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, forceclearzeds:GetWide(), forceclearzeds:GetTall())
	draw.RoundedBox( 2, 0, 0, forceclearzeds:GetWide(), forceclearzeds:GetTall(), Color(0, 0, 0, 130) )
	end
	forceclearzeds.DoClick = function()
	RunConsoleCommand("tea_admin_clearzombies", "force")
	end

	local spawnboss = vgui.Create("DButton", AdminCmds)
	spawnboss:SetSize( 120, 30 )
	spawnboss:SetPos( 20, 115)
	spawnboss:SetText("Spawn Boss")
	spawnboss:SetTextColor(Color(255, 255, 255, 255))
	spawnboss.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, spawnboss:GetWide(), spawnboss:GetTall())
	draw.RoundedBox( 2, 0, 0, spawnboss:GetWide(), spawnboss:GetTall(), Color(0, 0, 0, 130) )
	end
	spawnboss.DoClick = function()
	RunConsoleCommand("tea_admin_spawnboss")
	end

	local spawnairdrop = vgui.Create("DButton", AdminCmds)
	spawnairdrop:SetSize( 120, 30 )
	spawnairdrop:SetPos( 150, 115)
	spawnairdrop:SetText("Spawn Airdrop")
	spawnairdrop:SetTextColor(Color(255, 255, 255, 255))
	spawnairdrop.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, spawnairdrop:GetWide(), spawnairdrop:GetTall())
	draw.RoundedBox( 2, 0, 0, spawnairdrop:GetWide(), spawnairdrop:GetTall(), Color(0, 0, 0, 130) )
	end
	spawnairdrop.DoClick = function()
	RunConsoleCommand("tea_admin_spawnairdrop")
	end


	local SAdminCmds = vgui.Create( "DPanel", PropertySheet )
	SAdminCmds:SetSize(780, 500)
	SAdminCmds.Paint = function( self, w, h )
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end
	
	local stext1 = vgui.Create("DLabel", SAdminCmds)
	stext1:SetFont("TargetIDSmall")
	stext1:SetColor(Color(205,205,205,255))
	stext1:SetText("Airdrop Spawns")
	stext1:SizeToContents()
	stext1:SetPos(20, 20)
	
	local addadspawn = vgui.Create("DButton", SAdminCmds)
	addadspawn:SetSize( 120, 30 )
	addadspawn:SetPos( 20, 45)
	addadspawn:SetText("Add airdrop spawnpoint")
	addadspawn:SetTextColor(Color(255, 255, 255, 255))
	addadspawn.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, addadspawn:GetWide(), addadspawn:GetTall())
		draw.RoundedBox( 2, 0, 0, addadspawn:GetWide(), addadspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addadspawn.DoClick = function()
		RunConsoleCommand("tea_addairdropspawn")
	end

	local clearadspawns = vgui.Create("DButton", SAdminCmds)
	clearadspawns:SetSize( 120, 30 )
	clearadspawns:SetPos( 150, 45)
	clearadspawns:SetText("Clear airdrop spawns")
	clearadspawns:SetTextColor(Color(255, 255, 255, 255))
	clearadspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearadspawns:GetWide(), clearadspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearadspawns:GetWide(), clearadspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearadspawns.DoClick = function()
	RunConsoleCommand("tea_clearairdropspawns")
	end
	
	local stext2 = vgui.Create("DLabel", SAdminCmds)
	stext2:SetFont("TargetIDSmall")
	stext2:SetColor(Color(205,205,205,255))
	stext2:SetText("Loot Spawns")
	stext2:SizeToContents()
	stext2:SetPos(20, 100)

	local addlootspawn = vgui.Create("DButton", SAdminCmds)
	addlootspawn:SetSize( 120, 30 )
	addlootspawn:SetPos( 20, 125)
	addlootspawn:SetText("Add loot spawnpoint")
	addlootspawn:SetTextColor(Color(255, 255, 255, 255))
	addlootspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addlootspawn:GetWide(), addlootspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addlootspawn:GetWide(), addlootspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addlootspawn.DoClick = function()
	RunConsoleCommand("tea_addlootspawn")
	end

	local clearlootspawns = vgui.Create("DButton", SAdminCmds)
	clearlootspawns:SetSize( 120, 30 )
	clearlootspawns:SetPos( 150, 125)
	clearlootspawns:SetText("Clear loot spawns")
	clearlootspawns:SetTextColor(Color(255, 255, 255, 255))
	clearlootspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearlootspawns:GetWide(), clearlootspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearlootspawns:GetWide(), clearlootspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearlootspawns.DoClick = function()
	RunConsoleCommand("tea_clearlootspawns")
	end

	local stext3 = vgui.Create("DLabel", SAdminCmds)
	stext3:SetFont("TargetIDSmall")
	stext3:SetColor(Color(205,205,205,255))
	stext3:SetText("Player Spawnpoints")
	stext3:SizeToContents()
	stext3:SetPos(20, 180)

	local addplyspawn = vgui.Create("DButton", SAdminCmds)
	addplyspawn:SetSize( 120, 30 )
	addplyspawn:SetPos( 20, 205)
	addplyspawn:SetText("Add player spawnpoint")
	addplyspawn:SetTextColor(Color(255, 255, 255, 255))
	addplyspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addplyspawn:GetWide(), addplyspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addplyspawn:GetWide(), addplyspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addplyspawn.DoClick = function()
	RunConsoleCommand("tea_addplayerspawnpoint", "Spawnpoint_name")
	end

	local clearplyspawns = vgui.Create("DButton", SAdminCmds)
	clearplyspawns:SetSize( 120, 30 )
	clearplyspawns:SetPos( 150, 205)
	clearplyspawns:SetText("Clear player spawnponts")
	clearplyspawns:SetTextColor(Color(255, 255, 255, 255))
	clearplyspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearplyspawns:GetWide(), clearplyspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearplyspawns:GetWide(), clearplyspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearplyspawns.DoClick = function()
	RunConsoleCommand("tea_clearplayerspawnpoints", "No name")
	end

	local stext4 = vgui.Create("DLabel", SAdminCmds)
	stext4:SetFont("TargetIDSmall")
	stext4:SetColor(Color(205,205,205,255))
	stext4:SetText("Trader Spawns")
	stext4:SizeToContents()
	stext4:SetPos(20, 260)

	local addtraderspawn = vgui.Create("DButton", SAdminCmds)
	addtraderspawn:SetSize( 120, 30 )
	addtraderspawn:SetPos( 20, 285)
	addtraderspawn:SetText("Add trader spawnpoint")
	addtraderspawn:SetTextColor(Color(255, 255, 255, 255))
	addtraderspawn.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, addtraderspawn:GetWide(), addtraderspawn:GetTall())
	draw.RoundedBox( 2, 0, 0, addtraderspawn:GetWide(), addtraderspawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addtraderspawn.DoClick = function()
	RunConsoleCommand("tea_addtrader")
	end
	
	local cleartraderspawns = vgui.Create("DButton", SAdminCmds)
	cleartraderspawns:SetSize( 120, 30 )
	cleartraderspawns:SetPos( 150, 285)
	cleartraderspawns:SetText("Clear Trader spawns")
	cleartraderspawns:SetTextColor(Color(255, 255, 255, 255))
	cleartraderspawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, cleartraderspawns:GetWide(), cleartraderspawns:GetTall())
	draw.RoundedBox( 2, 0, 0, cleartraderspawns:GetWide(), cleartraderspawns:GetTall(), Color(0, 0, 0, 130) )
	end
	cleartraderspawns.DoClick = function()
	RunConsoleCommand("tea_cleartraderspawns")
	end

	local stext5 = vgui.Create("DLabel", SAdminCmds)
	stext5:SetFont("TargetIDSmall")
	stext5:SetColor(Color(205,205,205,255))
	stext5:SetText("Zombie Spawns")
	stext5:SizeToContents()
	stext5:SetPos(20, 340)

	local addzombiespawn = vgui.Create("DButton", SAdminCmds)
	addzombiespawn:SetSize( 120, 30 )
	addzombiespawn:SetPos( 20, 365)
	addzombiespawn:SetText("Add zombie spawnpoint")
	addzombiespawn:SetTextColor(Color(255, 255, 255, 255))
	addzombiespawn.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, addzombiespawn:GetWide(), addzombiespawn:GetTall())
		draw.RoundedBox( 2, 0, 0, addzombiespawn:GetWide(), addzombiespawn:GetTall(), Color(0, 0, 0, 130) )
	end
	addzombiespawn.DoClick = function()
		RunConsoleCommand("tea_addzombiespawn")
	end

	local clearzombiespawns = vgui.Create("DButton", SAdminCmds)
	clearzombiespawns:SetSize( 120, 30 )
	clearzombiespawns:SetPos( 150, 365)
	clearzombiespawns:SetText("Clear zombie spawns")
	clearzombiespawns:SetTextColor(Color(255, 255, 255, 255))
	clearzombiespawns.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, clearzombiespawns:GetWide(), clearzombiespawns:GetTall())
	draw.RoundedBox( 2, 0, 0, clearzombiespawns:GetWide(), clearzombiespawns:GetTall(), Color(0, 0, 0, 130) )
	end
	clearzombiespawns.DoClick = function()
	RunConsoleCommand("tea_clearzombiespawns")
	end
	
	local stext6 = vgui.Create("DLabel", SAdminCmds)
	stext6:SetFont("TargetIDSmall")
	stext6:SetColor(Color(205,205,205,255))
	stext6:SetText("Misc")
	stext6:SizeToContents()
	stext6:SetPos(20, 420)

	local clearprops = vgui.Create("DButton", SAdminCmds)
	clearprops:SetSize( 120, 30 )
	clearprops:SetPos( 20, 445)
	clearprops:SetText("Cleanup All Props")
	clearprops:SetToolTip("WARNING!")
	clearprops:SetTextColor(Color(255, 255, 255, 255))
	clearprops.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, clearprops:GetWide(), clearprops:GetTall())
		draw.RoundedBox( 2, 0, 0, clearprops:GetWide(), clearprops:GetTall(), Color(0, 0, 0, 130) )
	end
	clearprops.DoClick = function()
		RunConsoleCommand("tea_sadmin_clearprops")
	end




	local SpawnMenu = vgui.Create( "DPanelList", PropertySheet )
	SpawnMenu:SetTall( 500 )
	SpawnMenu:SetWide( 690 )
	SpawnMenu:SetPos( 5, 25 )
	SpawnMenu:EnableVerticalScrollbar( true )
	SpawnMenu:EnableHorizontal( true )
	SpawnMenu:SetSpacing( 10 )
	SpawnMenu.Paint = function( self, w, h )
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	local SpawnMenuProperties = vgui.Create( "DPropertySheet", SpawnMenu )
	SpawnMenuProperties:SetPos( 5, 0 )
	SpawnMenuProperties:SetSize( 990, 650 )
	SpawnMenuProperties.Paint = function()
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, SpawnMenuProperties:GetWide(), SpawnMenuProperties:GetTall())
		for k, v in pairs(SpawnMenuProperties.Items) do
			if (!v.Tab) then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
			end
		end
	end

	local CheckWeight = vgui.Create( "DLabel", SpawnMenu )
	CheckWeight:SetPos(400, 5)
	CheckWeight:SetColor( Color(205,205,205,255) )
	CheckWeight:SetFont("TargetIDSmall")
	CheckWeight:SetText(translate.Get("CurrentlyCarrying")..": "..CalculateWeightClient().."kg    "..translate.Get("MaxWeight")..": "..CalculateMaxWeightClient().."kg")
	CheckWeight:SizeToContents()
	
	local SpawnMenuSupplies = vgui.Create( "DPanelList" )
	SpawnMenuSupplies:SetTall( 635 )
	SpawnMenuSupplies:SetWide( 890 )
	SpawnMenuSupplies:SetPos( 5, 25 )
	SpawnMenuSupplies:EnableVerticalScrollbar( true )
	SpawnMenuSupplies:EnableHorizontal( true )
	SpawnMenuSupplies:SetSpacing( 10 )

	local SpawnMenuAmmo = vgui.Create( "DPanelList" )
	SpawnMenuAmmo:SetTall( 635 )
	SpawnMenuAmmo:SetWide( 890 )
	SpawnMenuAmmo:SetPos( 5, 25 )
	SpawnMenuAmmo:EnableVerticalScrollbar( true )
	SpawnMenuAmmo:EnableHorizontal( true )
	SpawnMenuAmmo:SetSpacing( 10 )

	local SpawnMenuGuns = vgui.Create( "DPanelList" )
	SpawnMenuGuns:SetTall( 635 )
	SpawnMenuGuns:SetWide( 890 )
	SpawnMenuGuns:SetPos( 5, 25 )
	SpawnMenuGuns:EnableVerticalScrollbar( true )
	SpawnMenuGuns:EnableHorizontal( true )
	SpawnMenuGuns:SetSpacing( 10 )

	local SpawnMenuArmor = vgui.Create( "DPanelList" )
	SpawnMenuArmor:SetTall( 635 )
	SpawnMenuArmor:SetWide( 890 )
	SpawnMenuArmor:SetPos( 5, 25 )
	SpawnMenuArmor:EnableVerticalScrollbar( true )
	SpawnMenuArmor:EnableHorizontal( true )
	SpawnMenuArmor:SetSpacing( 10 )

	local function RefreshItemList(cat, parent)
		for k,v in SortedPairsByMemberValue(ItemsList, "Cost") do
			if v.Category != cat then continue end	
			
			local ItemBackground = vgui.Create( "DPanel", SpawnMenuProperties )
			ItemBackground:SetPos( 5, 5 )
			ItemBackground:SetSize( 300, 80 )
			ItemBackground.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end
		
			local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
			ItemDisplay:SetPos( 10, 10 )
			ItemDisplay:SetModel( v.Model )
			ItemDisplay:SetToolTip(translate.Get(v.Description).."\n(Item ID: "..k..", Base Cost: "..v.Cost.." "..Config["Currency"].."s)")
			ItemDisplay:SetSize(60,60)
			ItemDisplay.PaintOver = function()
				return
			end
			ItemDisplay.OnMousePressed = function()
				return false
			end
		
			local ItemName = vgui.Create( "DLabel", ItemBackground )
			ItemName:SetPos( 80, 10)
			ItemName:SetSize( 180, 15)
			ItemName:SetColor( Color(205,205,205,255) )
			ItemName:SetText( translate.Get(v.Name) )
		
			local ItemCost = vgui.Create( "DLabel", ItemBackground )
			ItemCost:SetFont( "TargetIDSmall" )
			ItemCost:SetPos( 80, 25)
			ItemCost:SetSize( 170, 15)
			ItemCost:SetColor( Color(155,255,155,255) )
			ItemCost:SetText( "Cost: ".. math.floor(v.Cost) )

			local ItemWeight = vgui.Create( "DLabel", ItemBackground )
			ItemWeight:SetFont( "TargetIDSmall" )
			ItemWeight:SetPos( 80, 42)
			ItemWeight:SetSize( 170, 15)
			ItemWeight:SetColor( Color(155,155,255,255) )
			ItemWeight:SetText( "Weight: ".. v.Weight.."kg" )

			local GiveAmount = vgui.Create("DNumberWang", ItemBackground)
			GiveAmount:SetPos(230, 5)
			GiveAmount:SetSize(60, 20)
			GiveAmount:SetValue(1)
			GiveAmount:SetMin(1)
			GiveAmount:SetMax(50)
			GiveAmount:SetToolTip("Set the amount of items you want to give to yourself\nDOES NOT WORK FOR SPAWNING ITEM")

			local SpawnButton = vgui.Create("DButton", ItemBackground)
			SpawnButton:SetSize(60, 20)
			SpawnButton:SetPos(230, 30)
			SpawnButton:SetText("Spawn")
			SpawnButton:SetTextColor(Color(255, 255, 255, 255))
			SpawnButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, SpawnButton:GetWide(), SpawnButton:GetTall())
				draw.RoundedBox( 2, 0, 0, SpawnButton:GetWide(), SpawnButton:GetTall(), Color(0, 50, 0, 130) )
			end
			SpawnButton.DoClick = function()
				RunConsoleCommand("tea_sadmin_spawnitem", k)
			end

			local GiveButton = vgui.Create("DButton", ItemBackground)
			GiveButton:SetSize(60, 20)
			GiveButton:SetPos(230, 55)
			GiveButton:SetText("Give")
			GiveButton:SetTextColor(Color(255, 255, 255, 255))
			GiveButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, GiveButton:GetWide(), GiveButton:GetTall())
				draw.RoundedBox( 2, 0, 0, GiveButton:GetWide(), GiveButton:GetTall(), Color(0, 50, 0, 130) )
			end
			GiveButton.DoClick = function()
				RunConsoleCommand("tea_sadmin_giveitem", k, GiveAmount:GetInt())
				timer.Simple(0.5, function()
					CheckWeight:SetText(translate.Get("CurrentlyCarrying")..": "..CalculateWeightClient().."kg    "..translate.Get("MaxWeight")..": "..CalculateMaxWeightClient().."kg")
				end)
			end

			if TEADevCheck(LocalPlayer()) and cat == 4 then
				local EquipButton = vgui.Create("DButton", ItemBackground)
				EquipButton:SetSize(60, 15)
				EquipButton:SetPos(80, 60)
				EquipButton:SetText("Equip")
				EquipButton:SetToolTip("THIS WORKS ONLY FOR DEVS!!")
				EquipButton:SetTextColor(Color(255, 255, 255, 255))
				EquipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
					draw.RoundedBox( 2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130) )
				end
				EquipButton.DoClick = function()
					RunConsoleCommand("tea_dev_forceequiparmor", k)
				end
			end
		parent:AddItem(ItemBackground)
		end
	end
	RefreshItemList(1, SpawnMenuAmmo)
	RefreshItemList(2, SpawnMenuSupplies)
	RefreshItemList(3, SpawnMenuGuns)
	RefreshItemList(4, SpawnMenuArmor)

	SpawnMenuProperties:AddSheet("Ammunition", SpawnMenuSupplies, "icon16/briefcase.png", false, false, "Ammunition needed for your guns to shoot")
	SpawnMenuProperties:AddSheet("Supplies", SpawnMenuAmmo, "icon16/box.png", false, false, "Food, Medical Supplies, Misc items, for survival")
	SpawnMenuProperties:AddSheet("Weapons", SpawnMenuGuns, "icon16/bomb.png", false, false, "Good guns that cost a lot and uses ammo, but also melee that cost less.")
	SpawnMenuProperties:AddSheet("Armor", SpawnMenuArmor, "icon16/shield.png", false, false, "Protective Armor to protect yourself from any sort of danger\n(also includes option to equip armors which works only for devs)")
	
	PropertySheet:AddSheet("Admin Commands", AdminCmds, "icon16/shield.png", false, false, "Get a list of admin commands")
	PropertySheet:AddSheet("Superadmin Commands", SAdminCmds, "icon16/shield_add.png", false, false, "Use superadmin commands")
	PropertySheet:AddSheet("Spawn Menu", SpawnMenu, "icon16/table.png", false, false, "Spawn or give yourself some stuff\n(SUPERADMIN ONLY)")

end