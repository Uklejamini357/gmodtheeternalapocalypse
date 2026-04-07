--if you find this text, congratulations
pAdmMenuFrame = nil

GM.AdminEyes = {}
GM.AdminEyesEnabled = {}

local PlayerListView
local last_cursor_x,last_cursor_y

function GM:AdminMenu()
	surface.PlaySound("buttons/button24.wav")
	local pl = LocalPlayer()

	local function RefreshPanel()
		if not (PlayerListView and PlayerListView:IsValid()) then return end
		for id, line in ipairs(PlayerListView:GetLines()) do
			PlayerListView:RemoveLine(id)
		end
		
		for k,v in pairs(player.GetAll()) do
			local pos = v:GetPos()
			pos.x = math.Round(pos.x)
			pos.y = math.Round(pos.y)
			pos.z = math.Round(pos.z)
			local line = PlayerListView:AddLine(v:EntIndex(), v:Nick(), v:SteamID(), pos.x.."  "..pos.y.."  "..pos.z, math.Round(pl:GetPos():Distance(v:GetPos())), v:GetUserGroup(), team.GetName(v:Team()), v:GetTEALevel(), v:GetTEAPrestige())
			line.OnRightClick = function()
				local derma = DermaMenu()
				derma:AddOption("In progress!!", function() end)
				derma:Open()
			end
		end
	end

	if IsValid(AdmMenuFrame) and pAdmMenuFrame then
		AdmMenuFrame:SetAlpha(0)
		AdmMenuFrame:AlphaTo(255, 0.5, 0)
		AdmMenuFrame:SetVisible(true)
		AdmMenuFrame:MakePopup()

		if last_cursor_x and last_cursor_y then
			gui.SetMousePos(last_cursor_x, last_cursor_y)
		end

		RefreshPanel()
		return
	end
	
	local wide, tall = 1000, 700

	AdmMenuFrame = vgui.Create("DFrame")
	AdmMenuFrame:SetSize(wide, tall)
	AdmMenuFrame:Center()
	AdmMenuFrame:SetTitle(translate.Get("admin_panel"))
	AdmMenuFrame:SetDraggable(false)
	AdmMenuFrame:SetAlpha(0)
	AdmMenuFrame:AlphaTo(255, 0.5, 0)
	AdmMenuFrame:ShowCloseButton(true)
	AdmMenuFrame:SetDeleteOnClose(false)
	AdmMenuFrame:MakePopup()
	local frame = AdmMenuFrame
	self.AdminFrame = frame
	frame.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", frame, function()
		if frame and frame:IsValid() and frame:IsVisible() then
			frame:Close()
			return false
		end
	end)
	AdmMenuFrame.Paint = function(panel)
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end
	AdmMenuFrame.OnClose = function(this)
	end
	pAdmMenuFrame = AdmMenuFrame

	local PropertySheet = vgui.Create("DPropertySheet", AdmMenuFrame)
	PropertySheet:SetPos(5, 20)
	PropertySheet:SetSize(990, 680)
	PropertySheet:SetFadeTime(0)
	PropertySheet.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		for k, v in pairs(panel.Items) do
			if !v.Tab then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end
--[[
	local PlayerList = vgui.Create("DPanel", PropertySheet)
	PlayerList:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	PlayerList.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	PlayerListView = vgui.Create("DListView", PlayerList)
	PlayerListView:SetSize(PlayerList:GetWide(), PlayerList:GetTall() - 80)
	PlayerListView.Paint = function(this)
		surface.SetDrawColor(85,85,85,255)
		surface.DrawRect(0,0,this:GetWide(), this:GetTall())
	end
	local column = PlayerListView:AddColumn("Ent Index")
	column:SetMaxWidth(70)
	column = PlayerListView:AddColumn("Player")
	column = PlayerListView:AddColumn("SteamID")
	column = PlayerListView:AddColumn("Player Pos")
	column = PlayerListView:AddColumn("Distance")
	column = PlayerListView:AddColumn("Rank")
	column = PlayerListView:AddColumn("Faction")
	column = PlayerListView:AddColumn("Level")
	column:SetMaxWidth(70)
	column = PlayerListView:AddColumn("Prestige")
	column:SetMaxWidth(70)

	local PlayerListButton = vgui.Create("DButton", PlayerList)
	PlayerListButton:SetSize(120, 30)
	PlayerListButton:SetPos(20, PlayerList:GetTall() - 70)
	PlayerListButton:SetText(translate.Get("refresh_player_list"))
	PlayerListButton:SetTextColor(Color(255, 255, 255))
	PlayerListButton.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	PlayerListButton.DoClick = function()
		RefreshPanel()
	end
]]

	
	local AdminCmds = vgui.Create("DPanel", PropertySheet)
	AdminCmds:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	AdminCmds.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	local text1 = vgui.Create("DLabel", AdminCmds)
	text1:SetFont("TEA.HUDFontSmall")
	text1:SetColor(Color(205,205,205,255))
	text1:SetText(translate.Get("admin"))
	text1:SizeToContents()
	text1:SetPos(20, 20)

	local text2 = vgui.Create("DLabel", AdminCmds)
	text2:SetFont("TEA.HUDFontSmall")
	text2:SetColor(Color(205,205,205,255))
	text2:SetText(translate.Get("actions"))
	text2:SizeToContents()
	text2:SetPos(20, 90)

	local button1 = vgui.Create("DButton", AdminCmds)
	button1:SetSize(120, 30)
	button1:SetPos(20, 45)
	button1:SetText(translate.Get("toggle_admin_mode"))
	button1:SetTextColor(Color(255, 255, 255))
	button1.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
		button1.DoClick = function()
		RunConsoleCommand("tea_sadmin_adminmode")
	end

	local button2 = vgui.Create("DButton", AdminCmds)
	button2:SetSize(120, 30)
	button2:SetPos(20, 115)
	button2:SetText(translate.Get("spawn_boss"))
	button2:SetTextColor(Color(255, 255, 255))
	button2.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	button2.DoClick = function()
		RunConsoleCommand("tea_admin_spawnboss")
	end

	local button3 = vgui.Create("DButton", AdminCmds)
	button3:SetSize(120, 30)
	button3:SetPos(150, 115)
	button3:SetText(translate.Get("spawn_airdrop"))
	button3:SetTextColor(Color(255, 255, 255))
	button3.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	button3.DoClick = function()
		RunConsoleCommand("tea_admin_spawnairdrop")
	end

	local clearzeds1 = vgui.Create("DButton", AdminCmds)
	clearzeds1:SetSize(120, 30)
	clearzeds1:SetPos(20, 155)
	clearzeds1:SetText(translate.Get("cleanup_zombies"))
	clearzeds1:SetTextColor(Color(255, 255, 255))
	clearzeds1.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	clearzeds1.DoClick = function()
		RunConsoleCommand("tea_admin_clearzombies")
	end

	local clearzeds2 = vgui.Create("DButton", AdminCmds)
	clearzeds2:SetSize(120, 30)
	clearzeds2:SetPos(150, 155)
	clearzeds2:SetText(translate.Get("cleanup_zombies_all"))
	clearzeds2:SetTextColor(Color(255, 255, 255))
	clearzeds2.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	clearzeds2.DoClick = function()
		RunConsoleCommand("tea_admin_clearzombies", "force")
	end

	local togglezmspawns = vgui.Create("DButton", AdminCmds)
	togglezmspawns:SetSize(250, 30)
	togglezmspawns:SetPos(20, 195)
	togglezmspawns:SetText(translate.Get("toggle_zspawns"))
	togglezmspawns:SetTextColor(Color(255, 255, 255))
	togglezmspawns.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	togglezmspawns.DoClick = function()
		RunConsoleCommand("tea_sadmin_togglezspawning")
	end

	local clearprops = vgui.Create("DButton", AdminCmds)
	clearprops:SetSize(120, 30)
	clearprops:SetPos(20, 235)
	clearprops:SetText(translate.Get("cleanup_props"))
	clearprops:SetTextColor(Color(255, 255, 255))
	clearprops.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	clearprops.DoClick = function()
		RunConsoleCommand("tea_sadmin_clearprops")
	end




	local SpawnMenu = vgui.Create("DPanelList", PropertySheet)
	SpawnMenu:SetSize(690, 500)
	SpawnMenu:SetPos(5, 25)
	SpawnMenu:EnableVerticalScrollbar(true)
	SpawnMenu:EnableHorizontal(true)
	SpawnMenu:SetSpacing(10)
	SpawnMenu.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	local SpawnMenuProperties = vgui.Create("DPropertySheet", SpawnMenu)
	SpawnMenuProperties:SetPos(5, 0)
	SpawnMenuProperties:SetSize(990, 650)
	SpawnMenuProperties.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		for k, v in pairs(panel.Items) do
			if !v.Tab then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local buypanel = {}
	for i=1,6 do
		buypanel[i] = vgui.Create("DPanelList")
		buypanel[i]:SetSize(wide-110, tall-65)
		buypanel[i]:SetPos(5, 25)
		buypanel[i]:EnableVerticalScrollbar(true)
		buypanel[i]:EnableHorizontal(true)
		buypanel[i]:SetSpacing(10)
	end


	local function RefreshItemList(cat, parent)
		for k,v in SortedPairsByMemberValue(GAMEMODE.ItemsList, "Cost") do
			if v.Category != cat or v.IsSecret then continue end

			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
			local ItemBackground = vgui.Create("DPanel", SpawnMenuProperties)
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(300, 80)
			ItemBackground.Paint = function(panel) -- Paint function
				draw.RoundedBoxEx(8,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
			end
		
			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(10, 10)
			ItemDisplay:SetModel(v.Model)
			if v.ModelColor then
				ItemDisplay:SetColor(v.ModelColor)
			end
			ItemDisplay:SetToolTip(GAMEMODE:GetItemDescription(k))
			ItemDisplay:SetSize(60,60)
			ItemDisplay.PaintOver = function()
				return
			end
			ItemDisplay.OnMousePressed = function(self, mc)
				if mc == MOUSE_RIGHT then
					local d = DermaMenu()
					d:AddOption("Copy item ID", function() SetClipboardText(k) end)
					d:Open()
				end
			end
		
			local ItemName = vgui.Create("DLabel", ItemBackground)
			ItemName:SetPos(80, 10)
			ItemName:SetSize(180, 15)
			ItemName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				ItemName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					ItemName:SetTextColor(tbl_rarity.col)
				end
			end
			ItemName:SetText(GAMEMODE:GetItemName(k))
		
			local ItemCost = vgui.Create("DLabel", ItemBackground)
			ItemCost:SetFont("TEA.HUDFontSmall")
			ItemCost:SetPos(80, 25)
			ItemCost:SetSize(170, 15)
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText("Cost: ".. math.floor(v.Cost))

			local ItemWeight = vgui.Create("DLabel", ItemBackground)
			ItemWeight:SetFont("TEA.HUDFontSmall")
			ItemWeight:SetPos(80, 42)
			ItemWeight:SetSize(170, 15)
			ItemWeight:SetColor(Color(155,155,255,255))
			ItemWeight:SetText("Weight: ".. v.Weight.."kg")

			local GiveAmount = vgui.Create("DNumberWang", ItemBackground)
			GiveAmount:SetPos(230, 5)
			GiveAmount:SetSize(60, 20)
			GiveAmount:SetValue(1)
			GiveAmount:SetMin(1)
			GiveAmount:SetMax(50)
			GiveAmount:SetToolTip("Set the amount of items you want to give to yourself\nOnly works when giving the items to yourself.")

			local SpawnButton = vgui.Create("DButton", ItemBackground)
			SpawnButton:SetSize(60, 20)
			SpawnButton:SetPos(230, 30)
			SpawnButton:SetText(translate.Get("spawn"))
			SpawnButton:SetTextColor(Color(255, 255, 255))
			SpawnButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
				draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
			end
			SpawnButton.DoClick = function()
				RunConsoleCommand("tea_sadmin_spawnitem", k)
			end
--			SpawnButton.DoDoubleClick = SpawnButton.DoClick

			local GiveButton = vgui.Create("DButton", ItemBackground)
			GiveButton:SetSize(60, 20)
			GiveButton:SetPos(230, 55)
			GiveButton:SetText(translate.Get("give"))
			GiveButton:SetTextColor(Color(255, 255, 255))
			GiveButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
				draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
			end
			GiveButton.DoClick = function()
				RunConsoleCommand("tea_sadmin_giveitem", k, GiveAmount:GetInt())
			end
--			GiveButton.DoDoubleClick = GiveButton.DoClick

			if TEADevCheck(pl) and cat == ITEMCATEGORY_ARMOR then
				local EquipButton = vgui.Create("DButton", ItemBackground)
				EquipButton:SetSize(60, 15)
				EquipButton:SetPos(80, 60)
				EquipButton:SetText(translate.Get("equip"))
				EquipButton:SetToolTip("THIS WORKS ONLY FOR DEVS!!")
				EquipButton:SetTextColor(Color(255, 255, 255))
				EquipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
					draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
				end
				EquipButton.DoClick = function()
					RunConsoleCommand("tea_dev_forceequiparmor", k)
				end
			end
			parent:AddItem(ItemBackground)
		end
		if TEADevCheck(pl) then
			if TEADevCheck(pl) and cat == ITEMCATEGORY_ARMOR then
				local UnequipButton = vgui.Create("DButton", SpawnMenuProperties)
				UnequipButton:SetSize(100, 20)
				UnequipButton:SetPos(860, 5)
				UnequipButton:SetText(translate.Get("unequip_armor"))
				UnequipButton:SetToolTip("THIS WORKS ONLY FOR DEVS!!")
				UnequipButton:SetTextColor(Color(255, 255, 255))
				UnequipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
					draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 50, 0, 130))
				end
				UnequipButton.DoClick = function()
					RunConsoleCommand("tea_dev_forceequiparmor")
				end
			end
		end
	end
	for i=1,6 do
		RefreshItemList(i, buypanel[i])
	end
	RefreshPanel()

	SpawnMenuProperties:AddSheet(translate.Get("items_category_1"), buypanel[1], "icon16/ammo_three.png", false, false, translate.Get("items_category_1_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_2"), buypanel[2], "icon16/box.png", false, false, translate.Get("items_category_2_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_3"), buypanel[3], "icon16/gun.png", false, false, translate.Get("items_category_3_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_4"), buypanel[4], "icon16/shield.png", false, false, translate.Get("items_category_4_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_5"), buypanel[5], "icon16/bin.png", false, false, translate.Get("items_category_5_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_6"), buypanel[6], "icon16/basket.png", false, false, translate.Get("items_category_6_d"))
	-- SpawnMenuProperties:AddSheet(translate.Get("items_category_7"), buypanel[7], "icon16/basket.png", false, false, translate.Get("items_category_7_d"))

	local MapConfig = vgui.Create("DPanel", PropertySheet)
	MapConfig:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	MapConfig.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local text = vgui.Create("DLabel", MapConfig)
	text:SetText(translate.Get("admin_cleanup_warning"))
	text:SetFont("TEA.HUDFontSmall")
	text:SetContentAlignment(5)
	text:Dock(TOP)
	text:DockMargin(5, 10, 50, 0)

	local click = vgui.Create("DButton", MapConfig)
	click:SetText(translate.Get("admin_cleanup_spawnpoints"))
	click:SetFont("TEA.HUDFont")
	click:Dock(TOP)
	click:DockMargin(20, 10, 20, 0)
	click.DoClick = function()
		local d = DermaMenu(true)
		d:AddOption(translate.Get("zombies"), function() RunConsoleCommand("tea_clearspawns", "zombies", "all") end)
		d:AddOption(translate.Get("loot"), function() RunConsoleCommand("tea_clearspawns", "loot", "all") end)
		d:AddOption(translate.Get("traders"), function() RunConsoleCommand("tea_clearspawns", "traders", "all") end)
		d:AddOption(translate.Get("airdrops"), function() RunConsoleCommand("tea_clearspawns", "airdrops", "all") end)
		d:AddOption(translate.Get("player_spawnpoints"), function() RunConsoleCommand("tea_clearspawns", "playerspawns", "all") end)
		d:AddOption(translate.Get("taskdealers"), function() RunConsoleCommand("tea_clearspawns", "taskdealers", "all") end)
		d:AddOption(translate.Get("safezones"), function() RunConsoleCommand("tea_clearspawns", "safezones", "all") end)
		d:Open()
	end
	click.Paint = function(self,w,h)
		surface.SetDrawColor(0,0,0,50)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	local click2 = vgui.Create("DButton", MapConfig)
	click2:SetText(translate.Get("admin_remove_spawnpoint"))
	click2:SetFont("TEA.HUDFont")
	click2:Dock(TOP)
	click2:DockMargin(20, 10, 20, 0)
	click2.DoClick = function()
		local d = DermaMenu(true)
		d:AddOption(translate.Get("zombies"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_zmid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "zombies", id)
			end)
		end)
		d:AddOption(translate.Get("loot"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_lootid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "loot", id)
			end)
		end)
		d:AddOption(translate.Get("traders"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_traderid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "traders", id)
			end)
		end)
		d:AddOption(translate.Get("airdrops"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_adid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "airdrops", id)
			end)
		end)
		d:AddOption(translate.Get("player_spawnpoints"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_plrid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "playerspawns", id)
			end)
		end)
		d:AddOption(translate.Get("taskdealers"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_taskdealerid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "taskdealers", id)
			end)
		end)
		d:AddOption(translate.Get("safezones"), function()
			Derma_StringRequest(translate.Get("warning"), translate.Get("select_safezoneid_remove"), "", function(id)
				RunConsoleCommand("tea_clearspawns", "safezones", id)
			end)
		end)
		d:Open()
	end
	click2.Paint = function(self,w,h)
		surface.SetDrawColor(0,0,0,50)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	local OpenwManager = vgui.Create("DPanel", PropertySheet)
	OpenwManager:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	OpenwManager.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	TransitionsView = vgui.Create("DListView", OpenwManager)
	TransitionsView:SetSize(OpenwManager:GetWide(), OpenwManager:GetTall() - 80)
	TransitionsView.Paint = function(this)
		surface.SetDrawColor(85,85,85,255)
		surface.DrawRect(0,0,this:GetWide(), this:GetTall())
	end
	local column = TransitionsView:AddColumn("ID")
	column:SetMaxWidth(25)
	column = TransitionsView:AddColumn(translate.Get("ow_linkedto"))
	column:SetMaxWidth(70)
	column = TransitionsView:AddColumn(translate.Get("ow_map"))
	column = TransitionsView:AddColumn(translate.Get("ow_linkedmap"))
	column = TransitionsView:AddColumn(translate.Get("ow_name"))
	column = TransitionsView:AddColumn("AreaMin")
	column = TransitionsView:AddColumn("AreaMax")
	column = TransitionsView:AddColumn("StartPos")
	column = TransitionsView:AddColumn("StartAng")

	local OpenwManagerButton = vgui.Create("DButton", OpenwManager)
	OpenwManagerButton:SetSize(120, 30)
	OpenwManagerButton:SetPos(20, OpenwManager:GetTall() - 70)
	OpenwManagerButton:SetText(translate.Get("ow_refreshdata"))
	OpenwManagerButton:SetTextColor(Color(255, 255, 255))
	OpenwManagerButton.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.SetDrawColor(255,255,255, 200)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end
	OpenwManagerButton.DoClick = function()
		net.Start("tea_openworld_level")
		net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
		net.SendToServer()
	end

	-- PropertySheet:AddSheet(translate.Get("admin_panel_tab_1"), PlayerList, "icon16/shield.png", false, false, translate.Get("admin_panel_tab_1_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_2"), AdminCmds, "icon16/shield.png", false, false, translate.Get("admin_panel_tab_2_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_3"), SpawnMenu, "icon16/table.png", false, false, translate.Get("admin_panel_tab_3_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_4"), MapConfig, "icon16/map_edit.png", false, false, translate.Get("admin_panel_tab_4_d"))
	local pan = PropertySheet:AddSheet(translate.Get("admin_panel_tab_5"), OpenwManager, "icon16/map.png", false, false, translate.Get("admin_panel_tab_5_d"))
	pan.Tab.DoClick = function(this)
		PropertySheet:SetActiveTab(this)

		net.Start("tea_openworld_level")
		net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
		net.SendToServer()
	end

	frame.OnReceiveTransitionsData = function(self, tbl)
		for id, line in ipairs(TransitionsView:GetLines()) do
			TransitionsView:RemoveLine(id)
		end
		
		for id,v in pairs(tbl) do
			local line = TransitionsView:AddLine(id, v.LinkedTo, v.Map, v.LinkedTo and tbl[v.LinkedTo] and tbl[v.LinkedTo].Map or "", v.Name, v.AreaMin, v.AreaMax, v.StartPos, v.StartAng)
			line.OnRightClick = function()
				local derma = DermaMenu()
				if v.LinkedTo then
					derma:AddOption(translate.Get("ow_unlink_transition"), function()
						Derma_Query(translate.Format("ow_delete_link", id), translate.Get("warning"), translate.Get("yes"), function(str)
							net.Start("tea_openworld_level")
							net.WriteUInt(OPENWORLD_NETTYPE_EDITTRANSITION, 4)
							net.WriteUInt(id, 8)
							net.WriteString("LinkedTo")
							net.WriteUInt(0, 8)
							net.SendToServer()

							net.Start("tea_openworld_level")
							net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
							net.SendToServer()
						end, translate.Get("no"))
					end)
				else
					derma:AddOption(translate.Get("ow_linkto"), function()
						Derma_StringRequest(translate.Get("ow_linktransition"), translate.Get("ow_linktransition_inputid"), "", function(str)
							if str == "" then return end
							net.Start("tea_openworld_level")
							net.WriteUInt(OPENWORLD_NETTYPE_EDITTRANSITION, 4)
							net.WriteUInt(id, 8)
							net.WriteString("LinkedTo")
							net.WriteUInt(tonumber(str), 8)
							net.SendToServer()

							net.Start("tea_openworld_level")
							net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
							net.SendToServer()
						end)
					end)
				end

				derma:AddOption(translate.Get("rename"), function()
					Derma_StringRequest(translate.Get("ow_renametransition"), translate.Format("ow_renametransition_prompt", id), var.Name, function(str)
						if str == "" or str == var.Name then return end
						net.Start("tea_openworld_level")
						net.WriteUInt(OPENWORLD_NETTYPE_EDITTRANSITION, 4)
						net.WriteUInt(id, 8)
						net.WriteString("LinkedTo")
						net.WriteUInt(tonumber(str), 8)
						net.SendToServer()

						net.Start("tea_openworld_level")
						net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
						net.SendToServer()
					end)
				end)

				-- derma:AddOption("Edit...", function()
				-- 	Derma_StringRequest("blah","sub","", function(str)
				-- 		if str == "" then return end
				-- 		net.Start("tea_openworld_level")
				-- 		net.WriteUInt(OPENWORLD_NETTYPE_EDITTRANSITION, 4)
				-- 		net.WriteUInt(id, 8)
				-- 		net.WriteString("LinkedTo")
				-- 		net.WriteUInt(tonumber(str), 8)
				-- 		net.SendToServer()

				-- 		net.Start("tea_openworld_level")
				-- 		net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
				-- 		net.SendToServer()
				-- 	end)
				-- end)

				derma:AddOption(translate.Get("ow_deletetransition"), function()
					Derma_Query(translate.Get("ow_deletetransition_prompt"), translate.Get("warning"), translate.Get("yes"), function()
						net.Start("tea_openworld_level")
						net.WriteUInt(OPENWORLD_NETTYPE_DELTRANSITION, 4)
						net.WriteUInt(id, 8)
						net.SendToServer()

						net.Start("tea_openworld_level")
						net.WriteUInt(OPENWORLD_NETTYPE_GETTRANSITIONSINFO, 4)
						net.SendToServer()
					end, translate.Get("no"))
				end)

				derma:Open()
			end
		end
	end
end

local atm
local optionstbl = {}
local function btnspawning(self)
	net.Start("tea_admin_tool")
	net.WriteString("selectspawner")
	net.WriteString(self.SpawningID)
	net.SendToServer()
end
local function updateoptions(tbl)
	net.Start("tea_admin_tool")
	net.WriteString("setoptions")
	net.WriteTable(tbl)
	net.SendToServer()
end
local function paint(self, w, h)
	surface.SetDrawColor(0,0,0,50)
	surface.DrawRect(0,0,w,h)
	surface.SetDrawColor(255,255,255,200)
	surface.DrawOutlinedRect(0,0,w,h)
end
function GM:OpenAdminToolMenu(wep)
	if atm and IsValid(atm) then
		if atm:IsVisible() then
			atm:SetVisible(false)
			return
		end
		atm.LastOpened = SysTime()

		atm:SetVisible(true)
		atm:MakePopup()
		atm:SetKeyboardInputEnabled(false)
		atm:SetAlpha(0)
		atm:AlphaTo(255, 0.5, 0)
		atm.Wep = wep

		return
	end

	atm = vgui.Create("EditablePanel")
	atm:SetSize(ScrW(), ScrH())
	atm:Center()
	atm.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,160)
		surface.DrawRect(0,0,w,h)
	end
	atm.Think = function(self)
		if atm.LastOpened+0.6<SysTime() and input.IsKeyDown(input.GetKeyCode(input.LookupBinding("+reload"))) then
			self:SetVisible(false)
			if atm.Wep and atm.Wep:IsValid() then
				atm.Wep.NextReload = CurTime() + 0.6
			end
		end
	end
	atm.LastOpened = SysTime()
	atm.Wep = wep
	local pan = atm
	pan.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", pan, function()
		if pan and pan:IsValid() and pan:IsVisible() then
			pan:Remove()
			return false
		end
	end)

	atm:SetAlpha(0)
	atm:AlphaTo(255, 0.5, 0)
	atm:MakePopup()
	atm:SetKeyboardInputEnabled(false)

	atm.Button = vgui.Create("DButton", atm)
	atm.Button:SetSize(64, 64)
	atm.Button:SetPos(atm:GetWide()-atm.Button:GetWide(), 0)
	atm.Button:SetText(" X ")
	atm.Button:SetFont("Trebuchet24")
	atm.Button.DoClick = function()
		if input.IsShiftDown() then
			atm:Remove()
		else
			atm:SetVisible(false)
		end
	end
	atm.Button.Paint = function(self, w, h)
		if self:IsHovered() then
			surface.SetDrawColor(200,100,100,150)
		else
			surface.SetDrawColor(200,0,0,150)
		end
		surface.DrawRect(0,0,w,h)
	end


	atm.Categories = vgui.Create("DColumnSheet", atm)
	atm.Categories:SetWide(ScrW())
	atm.Categories:SetTall(ScrH()-72)
	atm.Categories:SetPos(0, 72)
	atm.Categories.Paint = paint

	local sidepanel = vgui.Create("EditablePanel", atm.Categories)
	sidepanel.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)

		surface.SetDrawColor(255,0,0,255)
		surface.DrawLine(0,0,0,h)
	end
	sidepanel:Dock(RIGHT)
	sidepanel:SetWide(math.max(200, ScrH()*0.15))

	do
		local b = vgui.Create("DButton", sidepanel)
		b:SetText(translate.Get("remover"))
		b:SetFont("TEA.HUDFont")
		b:SetTextColor(color_white)
		b:Dock(TOP)
		b:DockMargin(5, 10, 5, 0)
		b.DoClick = function()
			net.Start("tea_admin_tool")
			net.WriteString("toggleremover")
			net.WriteUInt(atm.Wep:GetMode()==ADMINTOOL_MODE_SPAWNER and ADMINTOOL_MODE_DELETE or ADMINTOOL_MODE_SPAWNER, 4)
			net.SendToServer()
		end
		b.DoRightClick = function()
			net.Start("tea_admin_tool")
			net.WriteString("toggleremover")
			net.WriteUInt(atm.Wep:GetMode()~=ADMINTOOL_MODE_DELETEUNSAFE and ADMINTOOL_MODE_DELETEUNSAFE or ADMINTOOL_MODE_SPAWNER, 4)
			net.SendToServer()
		end
		b.Paint = function(self,w,h)
			surface.SetDrawColor(atm.Wep:GetMode()~=ADMINTOOL_MODE_SPAWNER and 200 or 0,0,0,atm.Wep:GetMode()==ADMINTOOL_MODE_DELETEUNSAFE and 255 or 50)
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
	end

	do
		local b = vgui.Create("DForm", sidepanel)
		b:SetLabel(translate.Get("admineyes"))
		b:Dock(TOP)
		b:DockMargin(5, 10, 5, 0)
		b:SetExpanded(false)
		b.Paint = function(self, w, h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		for k,v in pairs(self.AdminMapSpawnables) do
			if v.GetAdminEyes then
				local check = vgui.Create("DCheckBoxLabel", b)
				check:SetText(translate.Get(v.Name or k))
				check:SetChecked(tobool(self.AdminEyesEnabled and self.AdminEyesEnabled[k]))
				check.OnChange = function(this, val)
					self.AdminEyesEnabled[k] = val

					net.Start("tea_admin_tool")
					net.WriteString("admineyes")
					net.WriteString(k)
					net.WriteBool(val)
					net.SendToServer()
				end
				b:AddItem(check)
			end
		end
		b:AddItem()
	end

	do
		local b = vgui.Create("DCheckBoxLabel", sidepanel)
		b:SetText("AdminTool hud")
		b:SetChecked(!self.DisableAdminToolHUD)
		b:Dock(TOP)
		b:DockMargin(5, 10, 5, 0)
		b.OnChange = function(this, val)
			self.DisableAdminToolHUD = !val
		end
	end

	do
		local b = vgui.Create("DCheckBoxLabel", sidepanel)
		b:SetText("Draw Sphere")
		b:SetChecked(!self.DisableAdminToolDrawSphere)
		b:Dock(TOP)
		b:DockMargin(5, 10, 5, 0)
		b.OnChange = function(this, val)
			self.DisableAdminToolDrawSphere = !val
		end
	end

	atm.panel = vgui.Create("EditablePanel", atm.Categories)
	atm.panel:Dock(FILL)
	local shtbl = atm.Categories:AddSheet(translate.Get("zombies"), atm.panel)
	shtbl.Button.Paint = atm.Categories.Paint
	shtbl.Button:SetTextColor(color_white)
	shtbl.Button:SetTooltip(shtbl.Button:GetText())

	local function makezmpanel(class, tbl, boss)
		local button = vgui.Create("DButton", atm.panel)
		button:SetContentAlignment(4)
		button:SetText(tbl.Name or scripted_ents.Get(class) and scripted_ents.Get(class).PrintName or "[NAME NOT FOUND]")
		button:SetTextColor(boss and Color(255,120,120) or tbl.Miniboss and Color(204,144,254) or color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(32)
		button:Dock(TOP)
		button:DockMargin(5, 10, 5, 0)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = class
	end

	atm.panel.Text = vgui.Create("DLabel", atm.panel)
	atm.panel.Text:Dock(TOP)
	atm.panel.Text:SetText(translate.Get("zombies_n"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairsByMemberValue(self.Config["ZombieClasses"], "Tier") do
		if tbl.Miniboss then continue end
		makezmpanel(class, tbl)
	end

	atm.panel.Text = vgui.Create("DLabel", atm.panel)
	atm.panel.Text:Dock(TOP)
	atm.panel.Text:SetText(translate.Get("zombies_mb"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(self.Config["ZombieClasses"]) do
		if !tbl.Miniboss then continue end
		makezmpanel(class, tbl)
	end

	atm.panel.Text = vgui.Create("DLabel", atm.panel)
	atm.panel.Text:Dock(TOP)
	atm.panel.Text:SetText(translate.Get("zombies_b"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(self.Config["BossClasses"]) do
		makezmpanel(class, tbl, true)
	end


	atm.panel = vgui.Create("DIconLayout", atm.Categories)
	atm.panel:Dock(FILL)
	local shtbl = atm.Categories:AddSheet("Props & Structures", atm.panel)
	shtbl.Button.Paint = atm.Categories.Paint
	shtbl.Button:SetTextColor(color_white)
	shtbl.Button:SetTooltip(shtbl.Button:GetText())

	atm.panel.Text = atm.panel:Add("DLabel")
	atm.panel.Text.OwnLine = true
	atm.panel.Text:SetWide(atm.panel:GetWide())
	atm.panel.Text:SetText(translate.Get("flimsy_props"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for model,tbl in SortedPairs(GAMEMODE.FlimsyProps) do
		local button = atm.panel:Add("DButton")
		button:SetContentAlignment(2)
		button:SetText(tbl.Name or "")
		button:SetTextColor(color_white)
		button:SetTooltip((tbl.Name or "").."\nToughness: ".. tbl.Toughness*500 .."hp")
		button:SetFont("TEA.HUDFont")
		button:SetSize(128, 128)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = model

		local icon = vgui.Create("SpawnIcon", button)
		icon:SetModel(model)
		icon:SetSize(button:GetSize())
		icon.PaintOver = function() return end
		icon.OnMousePressed = function() return false end
		icon:SetMouseInputEnabled(false)
	end

	atm.panel.Text = atm.panel:Add("DLabel")
	atm.panel.Text.OwnLine = true
	atm.panel.Text:SetWide(atm.panel:GetWide())
	atm.panel.Text:SetText(translate.Get("strong_props"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(GAMEMODE.ToughProps) do
		local button = atm.panel:Add("DButton")
		button:SetContentAlignment(2)
		button:SetText(tbl.Name or "")
		button:SetTextColor(color_white)
		button:SetTooltip((tbl.Name or "").."\nToughness: ".. tbl.Toughness*500 .."hp")
		button:SetFont("TEA.HUDFont")
		button:SetSize(128, 128)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = class

		local icon = vgui.Create("SpawnIcon", button)
		icon:SetModel(class)
		icon:SetSize(button:GetSize())
		icon.PaintOver = function() return end
		icon.OnMousePressed = function() return false end
		icon:SetMouseInputEnabled(false)
	end

	atm.panel.Text = atm.panel:Add("DLabel")
	atm.panel.Text.OwnLine = true
	atm.panel.Text:SetWide(atm.panel:GetWide())
	atm.panel.Text:SetText(translate.Get("faction_structures"))
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(GAMEMODE.SpecialStructureSpawns) do
		local button = atm.panel:Add("DButton")
		button:SetContentAlignment(2)
		button:SetText(tbl.Name or "")
		button:SetTextColor(color_white)
		button:SetTooltip((tbl.Name or "").."\nDescription: ".. tbl.Description .."hp")
		button:SetFont("TEA.HUDFont")
		button:SetSize(128, 128)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = class

		local icon = vgui.Create("SpawnIcon", button)
		icon:SetModel(tbl.Model)
		icon:SetSize(button:GetSize())
		icon.PaintOver = function() return end
		icon.OnMousePressed = function() return false end
		icon:SetMouseInputEnabled(false)
	end

	atm.panel = vgui.Create("Panel", atm.Categories)
	atm.panel:Dock(FILL)
	local shtbl = atm.Categories:AddSheet("Spawns", atm.panel)
	shtbl.Button.Paint = atm.Categories.Paint
	shtbl.Button:SetTextColor(color_white)
	shtbl.Button:SetTooltip(shtbl.Button:GetText())

	for class,tbl in SortedPairs(self.AdminMapSpawnables) do
		local button = vgui.Create("DButton", atm.panel)
		button:SetContentAlignment(4)
		button:SetText(translate.Get(tbl.Name or class))
		button:SetTextColor(color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(30)
		button:Dock(TOP)
		button:DockMargin(5, 10, 5, 0)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = class
	end

	atm.panel = vgui.Create("Panel", atm.Categories)
	atm.panel:Dock(FILL)
	local shtbl = atm.Categories:AddSheet("Tools", atm.panel)
	shtbl.Button.Paint = atm.Categories.Paint
	shtbl.Button:SetTextColor(color_white)
	shtbl.Button:SetTooltip(shtbl.Button:GetText())

	
	for class,tbl in SortedPairs(self.AdminTools) do
		local button = vgui.Create("DButton", atm.panel)
		button:SetContentAlignment(4)
		button:SetText(tbl.Name or class)
		button:SetTextColor(color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(30)
		button:Dock(TOP)
		button:DockMargin(5, 10, 5, 0)
		button.Paint = paint
		button.DoClick = btnspawning
		button.SpawningID = class
	end
end

local atm
function GM:OpenAdminToolMenuOptions(wep)
	atm = vgui.Create("EditablePanel")
	atm:SetSize(400, 300)
	atm.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	atm.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", atm, function()
		if atm and atm:IsValid() then
			atm:Remove()
			return false
		end
	end)
	atm:Center()
	atm:MakePopup()



	local tbl = {}
	if wep:GetSpawningType() == ADMINTOOL_SPAWNTYPE_ZOMBIE then
		tbl = {
			CashReward = {
				Name = "Cash gain",
				Type = "number"
			},
			XPReward = {
				Name = "XP gain",
				Type = "number"
			},
			InfectionRate = {
				Name = "Infection level gainrate",
				Type = "number"
			},
			ForceLevel = {
				Name = "Force level",
				Type = "number"
			},
			BossZombie = {
				Name = "Boss zombie",
				Type = "bool"
			},
		}
	elseif wep:GetSpawningType() == ADMINTOOL_SPAWNTYPE_MAPSPAWNS then
		tbl = GAMEMODE.AdminMapSpawnables[wep:GetSpawning()].Options
	end


	local function thing(id, v)
		if v.Type == "number" then
			local b2 = vgui.Create("DLabel", atm)
			b2:SetText(v.Name or id)
			b2:Dock(TOP)
			b2:SizeToContents()

			local b1 = vgui.Create("DTextEntry", atm)
			b1:SetTooltip("Set to an empty value to make it default.")
			b1:SetText(optionstbl[id] or "")
			b1:SetUpdateOnType(true)
			b1:Dock(TOP)
			b1:DockMargin(5, 10, 5, 0)
			b1.OnValueChange = function(self, newvalue)
				optionstbl[id] = tonumber(newvalue)
				updateoptions(optionstbl)
			end
		elseif v.Type == "bool" then
			local b1 = vgui.Create("DCheckBoxLabel", atm)
			b1:SetText(v.Name or id)
			b1:Dock(TOP)
			b1:DockMargin(5,0,0,0)
			b1.Paint = function(self,w,h)
				surface.SetDrawColor(0,0,0,100)
				surface.DrawRect(0,0,w,h)
				surface.SetDrawColor(255,255,255,200)
				surface.DrawOutlinedRect(0,0,w,h)
			end
			b1.OnChange = function(self, val)
				optionstbl[id] = val
				updateoptions(optionstbl)
			end
		end
	end

	if !tbl or table.Count(tbl) == 0 then
		local b1 = vgui.Create("DLabel", atm)
		b1:SetText("No options found!")
		b1:Dock(TOP)
		b1:DockMargin(5,0,0,0)
	else
		for id,v in pairs(tbl) do
			if v.Type ~= "number" then continue end
			thing(id, v)
		end
		for id,v in pairs(tbl) do
			if v.Type ~= "bool" then continue end
			thing(id, v)
		end
	end
end

local atm
function GM:CreateOpenworldTransition(startpos, startang, pos1, pos2)
	atm = vgui.Create("EditablePanel")
	atm:SetSize(400, 300)
	atm.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	atm.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", atm, function()
		if atm and atm:IsValid() then
			atm:Remove()
			return false
		end
	end)
	atm:Center()
	atm:MakePopup()

	local textname = vgui.Create("DLabel", atm)
	textname:SetText("Give it a name... or leave it empty")
	textname:Dock(TOP)
	textname:SetContentAlignment(4)

	local mapname = vgui.Create("DTextEntry", atm)
	mapname:SetText("")
	mapname:SetTextColor(color_black)
	mapname:Dock(TOP)
	mapname:DockMargin(5, 10, 5, 0)

	local map = vgui.Create("DLabel", atm)
	map:SetText("Map: "..game.GetMap())
	map:Dock(TOP)
	map:SetContentAlignment(4)

	local startpostext = vgui.Create("DLabel", atm)
	startpostext:SetText("Spawn pos: "..startpos.x.." "..startpos.y.." "..startpos.z)
	startpostext:Dock(TOP)
	startpostext:SetContentAlignment(4)

	local startangtext = vgui.Create("DLabel", atm)
	startangtext:SetText("Spawn ang: "..startang.pitch.." "..startang.yaw.." "..startang.roll)
	startangtext:Dock(TOP)
	startangtext:SetContentAlignment(4)

	local pos1text = vgui.Create("DLabel", atm)
	pos1text:SetText("Area start: "..pos1.x.." "..pos1.y.." "..pos1.z)
	pos1text:Dock(TOP)
	pos1text:SetContentAlignment(4)

	local pos2text = vgui.Create("DLabel", atm)
	pos2text:SetText("Area end: "..pos2.x.." "..pos2.y.." "..pos2.z)
	pos2text:Dock(TOP)
	pos2text:SetContentAlignment(4)

	local btn = vgui.Create("DButton", atm)
	btn:Dock(TOP)
	btn:DockMargin(0, 20, 0, 0)
	btn:SetText("Make new transition!")
	btn.DoClick = function()
		net.Start("tea_admin_tool")
		net.WriteString("createopenworldtransition")
		net.WriteVector(startpos)
		net.WriteAngle(startang)
		net.WriteVector(pos1)
		net.WriteVector(pos2)
		net.WriteString(mapname:GetText())
		net.SendToServer()
		
		chat.AddText("Creating a new transition...")

		atm:Remove()
	end
end

local atm
function GM:CreateSafezoneArea(pos1, pos2)
	atm = vgui.Create("EditablePanel")
	atm:SetSize(400, 300)
	atm.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	atm.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", atm, function()
		if atm and atm:IsValid() then
			atm:Remove()
			return false
		end
	end)
	atm:Center()
	atm:MakePopup()

	local textname = vgui.Create("DLabel", atm)
	textname:SetText("Give it a name... or leave it empty")
	textname:Dock(TOP)
	textname:SetContentAlignment(4)

	local szname = vgui.Create("DTextEntry", atm)
	szname:SetText("")
	szname:SetTextColor(color_black)
	szname:Dock(TOP)
	szname:DockMargin(5, 10, 5, 0)

	local pos1text = vgui.Create("DLabel", atm)
	pos1text:SetText("Area start: "..pos1.x.." "..pos1.y.." "..pos1.z)
	pos1text:Dock(TOP)
	pos1text:SetContentAlignment(4)

	local pos2text = vgui.Create("DLabel", atm)
	pos2text:SetText("Area end: "..pos2.x.." "..pos2.y.." "..pos2.z)
	pos2text:Dock(TOP)
	pos2text:SetContentAlignment(4)

	local btn = vgui.Create("DButton", atm)
	btn:Dock(TOP)
	btn:DockMargin(0, 20, 0, 0)
	btn:SetText("Make new transition!")
	btn.DoClick = function()
		net.Start("tea_admin_tool")
		net.WriteString("createsafezonearea")
		net.WriteString(szname:GetText())
		net.WriteVector(pos1)
		net.WriteVector(pos2)
		net.SendToServer()

		chat.AddText("Creating a new safezone area...")

		atm:Remove()
	end
end
