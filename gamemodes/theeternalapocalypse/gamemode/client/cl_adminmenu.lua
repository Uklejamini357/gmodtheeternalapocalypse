--if you find this text, congratulations
pAdmMenuFrame = nil

function AdminMenu()
	surface.PlaySound("buttons/button24.wav")
	if IsValid(AdmMenuFrame) and pAdmMenuFrame then
		AdmMenuFrame:SetAlpha(0)
		AdmMenuFrame:AlphaTo(255, 0.5, 0)
		AdmMenuFrame:SetVisible(true)
		AdmMenuFrame:MakePopup()
		return
	end
	
	AdmMenuFrame = vgui.Create("DFrame")
	AdmMenuFrame:SetSize(1000, 700)
	AdmMenuFrame:Center()
	AdmMenuFrame:SetTitle("Administration Panel")
	AdmMenuFrame:SetDraggable(false)
	AdmMenuFrame:SetVisible(true)
	AdmMenuFrame:SetAlpha(0)
	AdmMenuFrame:AlphaTo(255, 0.5, 0)
	AdmMenuFrame:ShowCloseButton(true)
	AdmMenuFrame:SetDeleteOnClose(false)
	AdmMenuFrame:MakePopup()
	AdmMenuFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall())
	end
	pAdmMenuFrame = AdmMenuFrame

	local PropertySheet = vgui.Create( "DPropertySheet", AdmMenuFrame )
	PropertySheet:SetPos(5, 20)
	PropertySheet:SetSize(990, 680)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
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

	local button1 = vgui.Create("DButton", AdminCmds)
	button1:SetSize( 120, 30 )
	button1:SetPos( 20, 45)
	button1:SetText("Cleanup Zombies")
	button1:SetTextColor(Color(255, 255, 255, 255))
	button1.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button1:GetWide(), button1:GetTall())
		draw.RoundedBox(2, 0, 0, button1:GetWide(), button1:GetTall(), Color(0, 0, 0, 130))
	end
		button1.DoClick = function()
		RunConsoleCommand("tea_admin_clearzombies")
	end

	local button2 = vgui.Create("DButton", AdminCmds)
	button2:SetSize( 120, 30 )
	button2:SetPos( 150, 45)
	button2:SetText("Cleanup All Zombies")
	button2:SetTextColor(Color(255, 255, 255, 255))
	button2.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button2:GetWide(), button2:GetTall())
		draw.RoundedBox( 2, 0, 0, button2:GetWide(), button2:GetTall(), Color(0, 0, 0, 130) )
	end
	button2.DoClick = function()
		RunConsoleCommand("tea_admin_clearzombies", "force")
	end

	local button3 = vgui.Create("DButton", AdminCmds)
	button3:SetSize( 120, 30 )
	button3:SetPos( 20, 115)
	button3:SetText("Spawn Boss")
	button3:SetTextColor(Color(255, 255, 255, 255))
	button3.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button3:GetWide(), button3:GetTall())
		draw.RoundedBox( 2, 0, 0, button3:GetWide(), button3:GetTall(), Color(0, 0, 0, 130) )
	end
	button3.DoClick = function()
		RunConsoleCommand("tea_admin_spawnboss")
	end

	local button4 = vgui.Create("DButton", AdminCmds)
	button4:SetSize( 120, 30 )
	button4:SetPos( 150, 115)
	button4:SetText("Spawn Airdrop")
	button4:SetTextColor(Color(255, 255, 255, 255))
	button4.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button4:GetWide(), button4:GetTall())
		draw.RoundedBox( 2, 0, 0, button4:GetWide(), button4:GetTall(), Color(0, 0, 0, 130) )
	end
	button4.DoClick = function()
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
	
	local sbutton1 = vgui.Create("DButton", SAdminCmds)
	sbutton1:SetSize( 120, 30 )
	sbutton1:SetPos( 20, 45)
	sbutton1:SetText("Add airdrop spawnpoint")
	sbutton1:SetTextColor(Color(255, 255, 255, 255))
	sbutton1.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton1:GetWide(), sbutton1:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton1:GetWide(), sbutton1:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton1.DoClick = function()
		RunConsoleCommand("tea_addairdropspawn")
	end

	local sbutton2 = vgui.Create("DButton", SAdminCmds)
	sbutton2:SetSize( 120, 30 )
	sbutton2:SetPos( 150, 45)
	sbutton2:SetText("Clear airdrop spawns")
	sbutton2:SetTextColor(Color(255, 255, 255, 255))
	sbutton2.Paint = function(panel)
	surface.SetDrawColor(150, 150, 0 ,255)
	surface.DrawOutlinedRect(0, 0, sbutton2:GetWide(), sbutton2:GetTall())
	draw.RoundedBox( 2, 0, 0, sbutton2:GetWide(), sbutton2:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton2.DoClick = function()
	RunConsoleCommand("tea_clearairdropspawns")
	end
	
	local stext2 = vgui.Create("DLabel", SAdminCmds)
	stext2:SetFont("TargetIDSmall")
	stext2:SetColor(Color(205,205,205,255))
	stext2:SetText("Loot Spawns")
	stext2:SizeToContents()
	stext2:SetPos(20, 100)

	local sbutton3 = vgui.Create("DButton", SAdminCmds)
	sbutton3:SetSize( 120, 30 )
	sbutton3:SetPos( 20, 125)
	sbutton3:SetText("Add loot spawnpoint")
	sbutton3:SetTextColor(Color(255, 255, 255, 255))
	sbutton3.Paint = function(panel)
	surface.SetDrawColor(150, 150, 0 ,255)
	surface.DrawOutlinedRect(0, 0, sbutton3:GetWide(), sbutton3:GetTall())
	draw.RoundedBox( 2, 0, 0, sbutton3:GetWide(), sbutton3:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton3.DoClick = function()
	RunConsoleCommand("tea_addlootspawn")
	end

	local sbutton4 = vgui.Create("DButton", SAdminCmds)
	sbutton4:SetSize( 120, 30 )
	sbutton4:SetPos( 150, 125)
	sbutton4:SetText("Clear loot spawns")
	sbutton4:SetTextColor(Color(255, 255, 255, 255))
	sbutton4.Paint = function(panel)
	surface.SetDrawColor(150, 150, 0 ,255)
	surface.DrawOutlinedRect(0, 0, sbutton4:GetWide(), sbutton4:GetTall())
	draw.RoundedBox( 2, 0, 0, sbutton4:GetWide(), sbutton4:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton4.DoClick = function()
	RunConsoleCommand("tea_clearlootspawns")
	end

	local stext3 = vgui.Create("DLabel", SAdminCmds)
	stext3:SetFont("TargetIDSmall")
	stext3:SetColor(Color(205,205,205,255))
	stext3:SetText("Player Spawnpoints")
	stext3:SizeToContents()
	stext3:SetPos(20, 180)

	local sbutton5 = vgui.Create("DButton", SAdminCmds)
	sbutton5:SetSize( 120, 30 )
	sbutton5:SetPos( 20, 205)
	sbutton5:SetText("Add player spawnpoint")
	sbutton5:SetTextColor(Color(255, 255, 255, 255))
	sbutton5.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton5:GetWide(), sbutton5:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton5:GetWide(), sbutton5:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton5.DoClick = function()
		RunConsoleCommand("tea_addplayerspawnpoint", "Spawnpoint_name")
	end

	local sbutton6 = vgui.Create("DButton", SAdminCmds)
	sbutton6:SetSize( 120, 30 )
	sbutton6:SetPos( 150, 205)
	sbutton6:SetText("Clear player spawnponts")
	sbutton6:SetTextColor(Color(255, 255, 255, 255))
	sbutton6.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton6:GetWide(), sbutton6:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton6:GetWide(), sbutton6:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton6.DoClick = function()
		RunConsoleCommand("tea_clearplayerspawnpoints", "No name")
	end

	local stext4 = vgui.Create("DLabel", SAdminCmds)
	stext4:SetFont("TargetIDSmall")
	stext4:SetColor(Color(205,205,205,255))
	stext4:SetText("Trader Spawns")
	stext4:SizeToContents()
	stext4:SetPos(20, 260)

	local sbutton7 = vgui.Create("DButton", SAdminCmds)
	sbutton7:SetSize( 120, 30 )
	sbutton7:SetPos( 20, 285)
	sbutton7:SetText("Add trader spawnpoint")
	sbutton7:SetTextColor(Color(255, 255, 255, 255))
	sbutton7.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton7:GetWide(), sbutton7:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton7:GetWide(), sbutton7:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton7.DoClick = function()
		RunConsoleCommand("tea_addtrader")
	end

	local sbutton8 = vgui.Create("DButton", SAdminCmds)
	sbutton8:SetSize( 120, 30 )
	sbutton8:SetPos( 150, 285)
	sbutton8:SetText("Clear Trader spawns")
	sbutton8:SetTextColor(Color(255, 255, 255, 255))
	sbutton8.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton8:GetWide(), sbutton8:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton8:GetWide(), sbutton8:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton8.DoClick = function()
		RunConsoleCommand("tea_cleartraderspawns")
	end

	local stext5 = vgui.Create("DLabel", SAdminCmds)
	stext5:SetFont("TargetIDSmall")
	stext5:SetColor(Color(205,205,205,255))
	stext5:SetText("Zombie Spawns")
	stext5:SizeToContents()
	stext5:SetPos(20, 340)

	local sbutton9 = vgui.Create("DButton", SAdminCmds)
	sbutton9:SetSize( 120, 30 )
	sbutton9:SetPos( 20, 365)
	sbutton9:SetText("Add zombie spawnpoint")
	sbutton9:SetTextColor(Color(255, 255, 255, 255))
	sbutton9.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton9:GetWide(), sbutton9:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton9:GetWide(), sbutton9:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton9.DoClick = function()
		RunConsoleCommand("tea_addzombiespawn")
	end

	local sbutton10 = vgui.Create("DButton", SAdminCmds)
	sbutton10:SetSize( 120, 30 )
	sbutton10:SetPos( 150, 365)
	sbutton10:SetText("Clear zombie spawns")
	sbutton10:SetTextColor(Color(255, 255, 255, 255))
	sbutton10.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, sbutton10:GetWide(), sbutton10:GetTall())
		draw.RoundedBox( 2, 0, 0, sbutton10:GetWide(), sbutton10:GetTall(), Color(0, 0, 0, 130) )
	end
	sbutton10.DoClick = function()
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
		surface.SetDrawColor(150, 150, 0 ,255)
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
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local CheckWeight = vgui.Create( "DLabel", SpawnMenu )
	CheckWeight:SetPos(400, 5)
	CheckWeight:SetColor( Color(205,205,205,255) )
	CheckWeight:SetFont("TargetIDSmall")
	CheckWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).."    "..translate.Format("weight_2", CalculateMaxWeightClient()))
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
		for k,v in SortedPairsByMemberValue(GAMEMODE.ItemsList, "Cost") do
			if v.Category != cat or v.IsSecret then continue end

			local raretext, rarecol = tea_CheckItemRarity(v.Rarity)
			local ItemBackground = vgui.Create( "DPanel", SpawnMenuProperties )
			ItemBackground:SetPos( 5, 5 )
			ItemBackground:SetSize( 300, 80 )
			ItemBackground.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end
		
			local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
			ItemDisplay:SetPos(10, 10)
			ItemDisplay:SetModel(v.Model)
			ItemDisplay:SetToolTip(translate.Format("item_descr_1", translate.Get(k.."_d"), k, v.Cost, GAMEMODE.Config["Currency"], raretext))
			ItemDisplay:SetSize(60,60)
			ItemDisplay.PaintOver = function()
				return
			end
			ItemDisplay.OnMousePressed = function()
				return false
			end
		
			local ItemName = vgui.Create( "DLabel", ItemBackground )
			ItemName:SetPos(80, 10)
			ItemName:SetSize(180, 15)
			ItemName:SetColor(rarecol)
			ItemName:SetText(translate.Get(k.."_n"))
		
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
					CheckWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).."    "..translate.Format("weight_2", CalculateMaxWeightClient()))
					CheckWeight:SizeToContents()
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
		if TEADevCheck(LocalPlayer()) then
			if TEADevCheck(LocalPlayer()) and cat == 4 then
				local UnequipButton = vgui.Create("DButton", SpawnMenuProperties)
				UnequipButton:SetSize(100, 20)
				UnequipButton:SetPos(860, 5)
				UnequipButton:SetText("Unequip Armor")
				UnequipButton:SetToolTip("THIS WORKS ONLY FOR DEVS!!")
				UnequipButton:SetTextColor(Color(255, 255, 255, 255))
				UnequipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, UnequipButton:GetWide(), UnequipButton:GetTall())
					draw.RoundedBox( 2, 0, 0, UnequipButton:GetWide(), UnequipButton:GetTall(), Color(0, 50, 0, 130) )
				end
				UnequipButton.DoClick = function()
					RunConsoleCommand("tea_dev_forceequiparmor")
				end
			end
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
