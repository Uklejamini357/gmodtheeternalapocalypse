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
	frame.OnRemove = function(self)
		hook.Remove("OnPauseMenuShow", self)
	end
	hook.Add("OnPauseMenuShow", frame, function()
		if frame and frame:IsValid() and frame:IsVisible() then
			frame:Close()
			return false
		end
	end)
	AdmMenuFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, AdmMenuFrame:GetWide(), AdmMenuFrame:GetTall())
	end
	AdmMenuFrame.OnClose = function(this)
	end
	pAdmMenuFrame = AdmMenuFrame

	local PropertySheet = vgui.Create("DPropertySheet", AdmMenuFrame)
	PropertySheet:SetPos(5, 20)
	PropertySheet:SetSize(990, 680)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if !v.Tab then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

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
	end--SetColor(Color(0,0,0,255))
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
	PlayerListButton:SetTextColor(Color(255, 255, 255, 255))
	PlayerListButton.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 130))
	end
	PlayerListButton.DoClick = function()
		RefreshPanel()
	end

	
	local AdminCmds = vgui.Create("DPanel", PropertySheet)
	AdminCmds:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	AdminCmds.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(0, 0, 0, 0)
	end

	local text1 = vgui.Create("DLabel", AdminCmds)
	text1:SetFont("TEA.HUDFontSmall")
	text1:SetColor(Color(205,205,205,255))
	text1:SetText("Zombies")
	text1:SizeToContents()
	text1:SetPos(20, 20)

	local text2 = vgui.Create("DLabel", AdminCmds)
	text2:SetFont("TEA.HUDFontSmall")
	text2:SetColor(Color(205,205,205,255))
	text2:SetText("Spawn Boss/Airdrop")
	text2:SizeToContents()
	text2:SetPos(20, 90)

	local button1 = vgui.Create("DButton", AdminCmds)
	button1:SetSize(120, 30)
	button1:SetPos(20, 45)
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
	button2:SetSize(120, 30)
	button2:SetPos(150, 45)
	button2:SetText("Cleanup All Zombies")
	button2:SetTextColor(Color(255, 255, 255, 255))
	button2.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button2:GetWide(), button2:GetTall())
		draw.RoundedBox(2, 0, 0, button2:GetWide(), button2:GetTall(), Color(0, 0, 0, 130))
	end
	button2.DoClick = function()
		RunConsoleCommand("tea_admin_clearzombies", "force")
	end

	local button3 = vgui.Create("DButton", AdminCmds)
	button3:SetSize(120, 30)
	button3:SetPos(20, 115)
	button3:SetText("Spawn Boss")
	button3:SetTextColor(Color(255, 255, 255, 255))
	button3.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button3:GetWide(), button3:GetTall())
		draw.RoundedBox(2, 0, 0, button3:GetWide(), button3:GetTall(), Color(0, 0, 0, 130))
	end
	button3.DoClick = function()
		RunConsoleCommand("tea_admin_spawnboss")
	end

	local button4 = vgui.Create("DButton", AdminCmds)
	button4:SetSize(120, 30)
	button4:SetPos(150, 115)
	button4:SetText("Spawn Airdrop")
	button4:SetTextColor(Color(255, 255, 255, 255))
	button4.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, button4:GetWide(), button4:GetTall())
		draw.RoundedBox(2, 0, 0, button4:GetWide(), button4:GetTall(), Color(0, 0, 0, 130))
	end
	button4.DoClick = function()
		RunConsoleCommand("tea_admin_spawnairdrop")
	end


	local text3 = vgui.Create("DLabel", AdminCmds)
	text3:SetFont("TEA.HUDFontSmall")
	text3:SetColor(Color(205,205,205,255))
	text3:SetText("Misc")
	text3:SizeToContents()
	text3:SetPos(20, 150)

	local clearprops = vgui.Create("DButton", AdminCmds)
	clearprops:SetSize(120, 30)
	clearprops:SetPos(20, 175)
	clearprops:SetText("Cleanup All Props")
	clearprops:SetToolTip("WARNING!")
	clearprops:SetTextColor(Color(255, 255, 255, 255))
	clearprops.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, clearprops:GetWide(), clearprops:GetTall())
		draw.RoundedBox(2, 0, 0, clearprops:GetWide(), clearprops:GetTall(), Color(0, 0, 0, 130))
	end
	clearprops.DoClick = function()
		RunConsoleCommand("tea_sadmin_clearprops")
	end




	local SpawnMenu = vgui.Create("DPanelList", PropertySheet)
	SpawnMenu:SetTall(500)
	SpawnMenu:SetWide(690)
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
	SpawnMenuProperties.Paint = function()
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, SpawnMenuProperties:GetWide(), SpawnMenuProperties:GetTall())
		for k, v in pairs(SpawnMenuProperties.Items) do
			if !v.Tab then continue end
	
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local buypanel = {}
	for i=1,7 do
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
			ItemBackground.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
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
			ItemDisplay.OnMousePressed = function()
				return false
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
			GiveAmount:SetToolTip("Set the amount of items you want to give to yourself\nDOES NOT WORK FOR SPAWNING ITEM")

			local SpawnButton = vgui.Create("DButton", ItemBackground)
			SpawnButton:SetSize(60, 20)
			SpawnButton:SetPos(230, 30)
			SpawnButton:SetText(translate.Get("spawn"))
			SpawnButton:SetTextColor(Color(255, 255, 255, 255))
			SpawnButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, SpawnButton:GetWide(), SpawnButton:GetTall())
				draw.RoundedBox(2, 0, 0, SpawnButton:GetWide(), SpawnButton:GetTall(), Color(0, 50, 0, 130))
			end
			SpawnButton.DoClick = function()
				RunConsoleCommand("tea_sadmin_spawnitem", k)
			end
--			SpawnButton.DoDoubleClick = SpawnButton.DoClick

			local GiveButton = vgui.Create("DButton", ItemBackground)
			GiveButton:SetSize(60, 20)
			GiveButton:SetPos(230, 55)
			GiveButton:SetText(translate.Get("give"))
			GiveButton:SetTextColor(Color(255, 255, 255, 255))
			GiveButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, GiveButton:GetWide(), GiveButton:GetTall())
				draw.RoundedBox(2, 0, 0, GiveButton:GetWide(), GiveButton:GetTall(), Color(0, 50, 0, 130))
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
				EquipButton:SetTextColor(Color(255, 255, 255, 255))
				EquipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
					draw.RoundedBox(2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130))
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
				UnequipButton:SetTextColor(Color(255, 255, 255, 255))
				UnequipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0 ,255)
					surface.DrawOutlinedRect(0, 0, UnequipButton:GetWide(), UnequipButton:GetTall())
					draw.RoundedBox(2, 0, 0, UnequipButton:GetWide(), UnequipButton:GetTall(), Color(0, 50, 0, 130))
				end
				UnequipButton.DoClick = function()
					RunConsoleCommand("tea_dev_forceequiparmor")
				end
			end
		end
	end
	for i=1,7 do
		RefreshItemList(i, buypanel[i])
	end
	RefreshPanel()

	SpawnMenuProperties:AddSheet(translate.Get("items_category_1"), buypanel[1], "icon16/ammo_three.png", false, false, translate.Get("items_category_1_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_2"), buypanel[2], "icon16/box.png", false, false, translate.Get("items_category_2_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_3"), buypanel[3], "icon16/gun.png", false, false, translate.Get("items_category_3_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_4"), buypanel[4], "icon16/shield.png", false, false, translate.Get("items_category_4_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_5"), buypanel[5], "icon16/bin.png", false, false, translate.Get("items_category_5_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_6"), buypanel[6], "icon16/basket.png", false, false, translate.Get("items_category_6_d"))
	SpawnMenuProperties:AddSheet(translate.Get("items_category_7"), buypanel[7], "icon16/basket.png", false, false, translate.Get("items_category_7_d"))

	local MapConfig = vgui.Create("DPanel", PropertySheet)
	MapConfig:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	MapConfig.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local click = vgui.Create("DButton", MapConfig)
	click:SetText("Cleanup spawns...")
	click:Dock(TOP)
	click:DockMargin(20, 10, 20, 0)
	click.DoClick = function()
		local d = DermaMenu(true)
		d:AddOption("Zombies", functon() RunConsoleCommand("tea_clearzombiespawns") end)
		d:AddOption("Loot", functon() RunConsoleCommand("tea_clearlootspawns") end)
		d:AddOption("Traders", functon() RunConsoleCommand("tea_cleartraderpawns") end)
		d:AddOption("Airdrops", functon() RunConsoleCommand("tea_clearairdropspawns") end)
		d:AddOption("Player spawnpoints", functon() RunConsoleCommand("tea_clearplayerpawns") end)
		d:AddOption("TaskDealers", functon() RunConsoleCommand("tea_cleartaskdealerspawns") end)
		d:AddOption("Openworld transitions", functon()
			--Derma_Query("This may affect other maps transitions. Proceed?", "Warning", "Yes", function()
				--RunConsoleCommand("tea_clearzombiespawns")
			--end, "No")
		end)
		d:Open()
	end
	click.Paint = function(self,w,h)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	local OpenwManager = vgui.Create("DPanel", PropertySheet)
	OpenwManager:SetSize(AdmMenuFrame:GetWide() - 20, AdmMenuFrame:GetTall() - 20)
	OpenwManager.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	PropertySheet:AddSheet(translate.Get("admin_panel_tab_1"), PlayerList, "icon16/shield.png", false, false, translate.Get("admin_panel_tab_1_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_2"), AdminCmds, "icon16/shield.png", false, false, translate.Get("admin_panel_tab_2_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_3"), SpawnMenu, "icon16/table.png", false, false, translate.Get("admin_panel_tab_3_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_4"), MapConfig, "icon16/table.png", false, false, translate.Get("admin_panel_tab_4_d"))
	PropertySheet:AddSheet(translate.Get("admin_panel_tab_5"), OpenwManager, "icon16/table.png", false, false, translate.Get("admin_panel_tab_5_d"))
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
	atm.Categories.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,50)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	local sidepanel = vgui.Create("EditablePanel", atm.Categories)
	sidepanel:SetSize(400, 300)
	sidepanel.Paint = function(self, w, h)
		surface.SetDrawColor(0,0,0,100)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,200)
		surface.DrawOutlinedRect(0,0,w,h)

		surface.SetDrawColor(255,0,0,255)
		surface.DrawLine(0,0,0,h)
	end
	sidepanel:Dock(RIGHT)
	sidepanel:SetWide(ScrH()*0.15)

	do
		local b = vgui.Create("DButton", sidepanel)
		b:SetText("Remover")
		b:SetFont("TEA.HUDFont")
		b:SetTextColor(color_white)
		b:Dock(TOP)
		b:DockMargin(0, 10, 0, 0)
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
		b:SetLabel("Admin eyes")
		b:Dock(TOP)
		b:DockMargin(0, 10, 0, 0)
		b:SetExpanded(false)
		b.Paint = function(self, w, h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		for k,v in pairs(self.AdminMapSpawnables) do
			if v.GetAdminEyes then
				local check = vgui.Create("DCheckBoxLabel", b)
				check:SetText(k)
				check:SetChecked(tobool(wep.AdminEyes and wep.AdminEyes[k]))
				check.OnChange = function(self, val)
					wep.AdminEyes = wep.AdminEyes or {}
					wep.AdminEyes[k] = val
					GAMEMODE.AdminEyesEnabled[k] = val

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

	atm.panel = vgui.Create("EditablePanel", atm.Categories)
	atm.panel:Dock(FILL)
	local shtbl = atm.Categories:AddSheet("Zombies", atm.panel)
	shtbl.Button.Paint = atm.Categories.Paint
	shtbl.Button:SetTextColor(color_white)
	shtbl.Button:SetTooltip(shtbl.Button:GetText())

	atm.panel.Text = vgui.Create("DLabel", atm.panel)
	atm.panel.Text:Dock(TOP)
	atm.panel.Text:SetText("Normal Zombies")
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(self.Config["ZombieClasses"]) do
		local button = vgui.Create("DButton", atm.panel)
		button:SetContentAlignment(4)
		button:SetText(tbl.Name or scripted_ents.Get(class) and scripted_ents.Get(class).PrintName or "[NAME NOT FOUND]")
		button:SetTextColor(color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(30)
		button:Dock(TOP)
		button:DockMargin(0, 10, 0, 0)
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		button.DoClick = btnspawning
		button.SpawningID = class
	end

	atm.panel.Text = vgui.Create("DLabel", atm.panel)
	atm.panel.Text:Dock(TOP)
	atm.panel.Text:SetText("Boss Zombies")
	atm.panel.Text:SetFont("TEA.HUDFont")
	atm.panel.Text:SizeToContents()

	for class,tbl in SortedPairs(self.Config["BossClasses"]) do
		local button = vgui.Create("DButton", atm.panel)
		button:SetContentAlignment(4)
		button:SetText(tbl.Name or scripted_ents.Get(class) and scripted_ents.Get(class).PrintName or "[NAME NOT FOUND]")
		button:SetTextColor(color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(30)
		button:Dock(TOP)
		button:DockMargin(0, 10, 0, 0)
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		button.DoClick = btnspawning
		button.SpawningID = class
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
	atm.panel.Text:SetText("Flimsy props")
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
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
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
	atm.panel.Text:SetText("Strong props")
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
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
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
	atm.panel.Text:SetText("Faction Structures")
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
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
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
		button:SetText(tbl.Name or class)
		button:SetTextColor(color_white)
		button:SetFont("TEA.HUDFont")
		button:SizeToContents()
		button:SetTall(30)
		button:Dock(TOP)
		button:DockMargin(0, 10, 0, 0)
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
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
		button:DockMargin(0, 10, 0, 0)
		button.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
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



	do
		local b2 = vgui.Create("DLabel", atm)
		b2:SetText("Cash gain")
		b2:Dock(TOP)
		b2:SizeToContents()

		local b1 = vgui.Create("DTextEntry", atm)
		b1:SetTooltip("Set to an empty value to make it default.")
		b1:SetText(optionstbl["CashReward"] or 0)
		b1:SetUpdateOnType(true)
		b1:Dock(TOP)
		b1:DockMargin(0, 10, 0, 0)
		b1.OnValueChange = function(self, newvalue)
			optionstbl["CashReward"] = tonumber(newvalue)
			updateoptions(optionstbl)
		end
	end

	do
		local b2 = vgui.Create("DLabel", atm)
		b2:SetText("XP gain")
		b2:Dock(TOP)
		b2:SizeToContents()

		local b1 = vgui.Create("DTextEntry", atm)
		b1:SetText(optionstbl["XPReward"] or 0)
		b1:SetTooltip("Set to an empty value to make it default.")
		b1:SetUpdateOnType(true)
		b1:Dock(TOP)
		b1:DockMargin(0, 10, 0, 0)
		b1.OnValueChange = function(self, newvalue)
			optionstbl["XPReward"] = tonumber(newvalue)
			updateoptions(optionstbl)
		end
	end

	do
		local b2 = vgui.Create("DLabel", atm)
		b2:SetText("Infection level gainrate")
		b2:Dock(TOP)
		b2:SizeToContents()

		local b1 = vgui.Create("DTextEntry", atm)
		b1:SetText(optionstbl["InfectionRate"] or 0)
		b1:SetTooltip("Set to an empty value to make it default.")
		b1:SetUpdateOnType(true)
		b1:Dock(TOP)
		b1:DockMargin(0, 10, 0, 0)
		b1.OnValueChange = function(self, newvalue)
			optionstbl["InfectionRate"] = tonumber(newvalue)
			updateoptions(optionstbl)
		end
	end

	do
		local b1 = vgui.Create("DCheckBoxLabel", atm)
		b1:SetText("Boss zombie")
		b1:Dock(TOP)
		b1:DockMargin(5,0,0,0)
		b1.Paint = function(self,w,h)
			surface.SetDrawColor(0,0,0,100)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		b1.OnChange = function(self, val)
			optionstbl["BossZombie"] = val
			updateoptions(optionstbl)
		end
	end
end

local atm
function GM:CreateOpenworldTransition(spawnpos, pos1, pos2)
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
	mapname:DockMargin(0, 10, 0, 0)

	local map = vgui.Create("DLabel", atm)
	map:SetText("Map: "..game.GetMap())
	map:Dock(TOP)
	map:SetContentAlignment(4)

	local spawnpostext = vgui.Create("DLabel", atm)
	spawnpostext:SetText("Spawn pos: "..spawnpos.x.." "..spawnpos.y.." "..spawnpos.z)
	spawnpostext:Dock(TOP)
	spawnpostext:SetContentAlignment(4)

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
		net.WriteVector(spawnpos)
		net.WriteVector(pos1)
		net.WriteVector(pos2)
		net.SendToServer()
		
		chat.AddText("placeholder")

		atm:Remove()
	end
end
