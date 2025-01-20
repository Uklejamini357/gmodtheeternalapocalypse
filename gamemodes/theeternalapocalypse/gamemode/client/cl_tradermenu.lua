-------------------------------- Trader Menu --------------------------------
net.Receive("OpenTraderMenu", function()
	GAMEMODE:OpenTraderMenu()
end)

local TraderMenu
local TraderFrame
local DoTraderList
local DoSellPanel
local DoVaultPanel

net.Receive("tea_plyevent_vaultupdate", function()
	if DoSellPanel then
		DoSellPanel()
	end

	if DoVaultPanel then
		DoVaultPanel()
	end
end)

function GM:OpenTraderMenu()
	if IsValid(TraderMenu) then TraderMenu:Remove() end
	TraderMenu = vgui.Create("DFrame")
	TraderMenu:SetSize(400, 300)
	TraderMenu:Center()
	TraderMenu:SetTitle("Trader Menu")
	TraderMenu:SetDraggable(false)
	TraderMenu:SetVisible(true)
	TraderMenu:ShowCloseButton(true)
	TraderMenu:MakePopup()
	TraderMenu.Paint = function()
		draw.RoundedBox(2, 0, 0, TraderMenu:GetWide(), TraderMenu:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, TraderMenu:GetWide(), TraderMenu:GetTall())
	end
	TraderMenu.Think = function(this)
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				this:Remove()
			end)
			gui.HideGameUI()
		end
	end


	local text = vgui.Create("DLabel", TraderMenu)
	text:SetText("Hey! What can i do for you?")
	text:SetSize(200, 55)
	text:SetPos(100, 30)
	text:SetTextColor(Color(255, 255, 255, 255))

	local TraderButton = vgui.Create("DButton", TraderMenu)
	TraderButton:SetSize(200, 45)
	TraderButton:SetPos(100, 80)
	TraderButton:SetText("Trade")
	TraderButton:SetTextColor(Color(255, 255, 255, 255))
	TraderButton.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
	end
	TraderButton.DoClick = function()
		GAMEMODE:TraderMenu()
		TraderMenu:Remove()
	end

	local cash = vgui.Create("DLabel", TraderMenu)
	cash:SetFont("TargetID")
	cash:SetPos(100, 190)
	cash:SetText("My Wallet: "..math.floor(MyMoney).."\nMy bounty: "..math.floor(MyBounty))
	cash:SetColor(Color(155,255,155,255))
	cash:SizeToContents()
	cash.Think = function()
		local txt = "My Wallet: "..math.floor(MyMoney).."\nMy bounty: "..math.floor(MyBounty)
		if cash:GetText() == txt then return end
		cash:SetText(txt)
	end

	local CastBounty = vgui.Create("DButton", TraderMenu)
	CastBounty:SetSize(200, 45)
	CastBounty:SetPos(100, 130)
	CastBounty:SetText("Cash my bounty in")
	CastBounty:SetTextColor(Color(255, 255, 255, 255))
	CastBounty.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
	end
	CastBounty.DoClick = function()
		net.Start("CashBounty")
		net.SendToServer()
	end
end

function GM:TraderMenu()
	if IsValid(TraderFrame) then TraderFrame:Remove() end
	TraderFrame = vgui.Create("DFrame")
	TraderFrame:SetSize(1000, 700)
	TraderFrame:Center()
	TraderFrame:SetTitle("")
	TraderFrame:SetDraggable(false)
	TraderFrame:SetVisible(true)
	TraderFrame:SetAlpha(0)
	TraderFrame:AlphaTo(255, 1, 0)
	TraderFrame:ShowCloseButton(true)
	TraderFrame:MakePopup()
	TraderFrame.Paint = function(this)
		draw.RoundedBox(2, 0, 0, this:GetWide(), this:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, this:GetWide(), this:GetTall())
		surface.DrawLine(0, this:GetTall() - 60, this:GetWide(), this:GetTall() - 60)
	end
	TraderFrame.Think = function(this)
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				this:Remove()
			end)
			gui.HideGameUI()
		end
	end

	local PropertySheet = vgui.Create("DPropertySheet")
	PropertySheet:SetParent(TraderFrame)
	PropertySheet:SetPos(5, 5)
	PropertySheet:SetSize(900, TraderFrame:GetTall() - 65)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(this,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local SupplyPanel = vgui.Create("DPanelList")
	SupplyPanel:SetTall(635)
	SupplyPanel:SetWide(890)
	SupplyPanel:SetPos(5, 25)
	SupplyPanel:EnableVerticalScrollbar(true)
	SupplyPanel:EnableHorizontal(true)
	SupplyPanel:SetSpacing(10)
	
	local AmmoPanel = vgui.Create("DPanelList")
	AmmoPanel:SetTall(635)
	AmmoPanel:SetWide(890)
	AmmoPanel:SetPos(5, 25)
	AmmoPanel:EnableVerticalScrollbar(true)
	AmmoPanel:EnableHorizontal(true)
	AmmoPanel:SetSpacing(10)
	
	local GunPanel = vgui.Create("DPanelList")
	GunPanel:SetTall(635)
	GunPanel:SetWide(890)
	GunPanel:SetPos(5, 25)
	GunPanel:EnableVerticalScrollbar(true)
	GunPanel:EnableHorizontal(true)
	GunPanel:SetSpacing(10)
	
	local ArmorPanel = vgui.Create("DPanelList")
	ArmorPanel:SetTall(635)
	ArmorPanel:SetWide(890)
	ArmorPanel:SetPos(5, 25)
	ArmorPanel:EnableVerticalScrollbar(true)
	ArmorPanel:EnableHorizontal(true)
	ArmorPanel:SetSpacing(10)

	local JunkPanel = vgui.Create("DPanelList")
	JunkPanel:SetTall(635)
	JunkPanel:SetWide(890)
	JunkPanel:SetPos(5, 25)
	JunkPanel:EnableVerticalScrollbar(true)
	JunkPanel:EnableHorizontal(true)
	JunkPanel:SetSpacing(10)

	local MiscPanel = vgui.Create("DPanelList")
	MiscPanel:SetTall(635)
	MiscPanel:SetWide(890)
	MiscPanel:SetPos(5, 25)
	MiscPanel:EnableVerticalScrollbar(true)
	MiscPanel:EnableHorizontal(true)
	MiscPanel:SetSpacing(10)

	local SellPanel = vgui.Create("DPanelList")
	SellPanel:SetTall(635)
	SellPanel:SetWide(890)
	SellPanel:SetPos(5, 25)
	SellPanel:EnableVerticalScrollbar(true)
	SellPanel:EnableHorizontal(true)
	SellPanel:SetSpacing(10)

	local VaultPanel = vgui.Create("DPanelList")
	VaultPanel:SetTall(635)
	VaultPanel:SetWide(890)
	VaultPanel:SetPos(5, 25)
	VaultPanel:EnableVerticalScrollbar(true)
	VaultPanel:EnableHorizontal(true)
	VaultPanel:SetSpacing(10)
	
	local Specials = vgui.Create("DPanelList")
	Specials:SetTall(635)
	Specials:SetWide(890)
	Specials:SetPos(5, 25)
	
	local LWeight = vgui.Create("DLabel", TraderFrame)
	LWeight:SetFont("TargetIDSmall")
	LWeight:SetPos(10, TraderFrame:GetTall() - 42)
	LWeight:SetSize(350, 25)
	LWeight:SetColor(Color(255,255,255,255))
	LWeight:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
	LWeight.Think = function(this)
		local txt = translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT)
		if this:GetText() == txt then return end
		this:SetText(txt)
		this:SizeToContents()
	end

	local LMoney = vgui.Create("DLabel", TraderFrame)
	LMoney:SetFont("TargetID")
	LMoney:SetPos(400, TraderFrame:GetTall() - 38)
	LMoney:SetColor(Color(155,255,155,255))
	LMoney:SetText("My Wallet: "..math.floor(MyMoney))
	LMoney:SizeToContents()
	LMoney.Think = function(this)
		local txt = "My Wallet: "..math.floor(MyMoney)
		if this:GetText() == txt then return end
		this:SetText(txt)
		this:SizeToContents()
	end

/*
	local CastBounty = vgui.Create("DButton", TraderFrame)
	CastBounty:SetSize(120, 45)
	CastBounty:SetPos(540, TraderFrame:GetTall() - 52)
	CastBounty:SetText("Cash my bounty in!")
	CastBounty:SetTextColor(Color(255, 255, 255, 255))
	CastBounty.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
	end
	CastBounty.DoClick = function()
		net.Start("CashBounty")
		net.SendToServer()
		timer.Simple(0.3, function() LMoney:SetText("My Wallet: "..math.floor(MyMoney).."\nMy bounty: "..math.floor(MyBounty)) end)
	end
*/

	LVaultWeight = vgui.Create("DLabel", TraderFrame)
	LVaultWeight:SetFont("TargetIDSmall")
	LVaultWeight:SetColor(Color(255,255,255,255))
	LVaultWeight:SetText("Vault Capacity: "..LocalPlayer():CalculateVaultWeight().."kg / "..GAMEMODE.Config["VaultSize"].."kg")
	LVaultWeight:SizeToContents()
	LVaultWeight:SetPos(TraderFrame:GetWide() - LVaultWeight:GetWide() - 200, TraderFrame:GetTall() - 38)
	LVaultWeight.Think = function(this)
		local txt = "Vault Capacity: "..LocalPlayer():CalculateVaultWeight().."kg / "..GAMEMODE.Config["VaultSize"].."kg"
		if this:GetText() == txt then return end
		this:SetText(txt)
		this:SizeToContents()
	end
	
	local backbutton = vgui.Create("DButton", TraderFrame)
	backbutton:SetSize(120, 45)
	backbutton:SetText("Back")
	backbutton:SetPos(TraderFrame:GetWide() - backbutton:GetWide() - 30, TraderFrame:GetTall() - 52)
	backbutton:SetTextColor(Color(255, 255, 255, 255))
	backbutton.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
	end
	backbutton.DoClick = function()
		TraderFrame:Remove()
		GAMEMODE:OpenTraderMenu()
	end

	

	--------------------------------------------supplies-------------------------------------------------------------
	
	
	DoTraderList = function(cat, parent)
		for k, v in SortedPairsByMemberValue(GAMEMODE.ItemsList, "Cost") do
			if v.Supply <= -1 or v.Category != cat then continue end -- skip items with -1 supply or that are in the wrong category
--			if v.Category != cat then continue end --those are included so you can see new items you add if you exclude the above and include this one

			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
			local ItemBackground = vgui.Create("DPanel")
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(280, 80)
			ItemBackground.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end

			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(10, 10)
			ItemDisplay:SetModel(v.Model)
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
			ItemName:SetSize(170, 15)
			ItemName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				ItemName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					ItemName:SetTextColor(tbl_rarity.col)
				end
			end
			ItemName:SetText(GAMEMODE:GetItemName(k))

			local ItemCost = vgui.Create("DLabel", ItemBackground)
			ItemCost:SetFont("TargetIDSmall")
			ItemCost:SetPos(80, 25)
			ItemCost:SetSize(170, 15)
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText("Cost: ".. math.floor((v.Cost * (1 - ((Perks.Barter or 0) * 0.015)))))

			local ItemWeight = vgui.Create("DLabel", ItemBackground)
			ItemWeight:SetFont("TargetIDSmall")
			ItemWeight:SetPos(80, 42)
			ItemWeight:SetSize(170, 15)
			ItemWeight:SetColor(Color(155,155,255,255))
			ItemWeight:SetText("Weight: ".. v.Weight.."kg")

			local ItemSupply = vgui.Create("DLabel", ItemBackground)
			ItemSupply:SetFont("TargetIDSmall")
			ItemSupply:SetPos(80, 58)
			ItemSupply:SetText(v.Supply == 0 and "Supply: Unlimited" or v.Supply == -1 and "Supply: None" or "Supply: ".. v.Supply.." / "..v.Supply)
			ItemSupply:SetSize(170, 15)
			ItemSupply:SetColor(Color(255,155,155,255))


--	if v.Supply != -1 then
			local BuyButton = vgui.Create("DButton", ItemBackground)
			BuyButton:SetSize(60, 40)
			BuyButton:SetPos(210, 30)
			BuyButton:SetText("Buy")
			BuyButton:SetTextColor(Color(255, 255, 255, 255))
			BuyButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0,255)
				surface.DrawOutlinedRect(0, 0, BuyButton:GetWide(), BuyButton:GetTall())
				draw.RoundedBox(2, 0, 0, BuyButton:GetWide(), BuyButton:GetTall(), Color(0, 50, 0, 130))
			end
			BuyButton.DoClick = function()
				net.Start("BuyItem")
				net.WriteString(k)
				net.SendToServer()
			end
			BuyButton.DoDoubleClick = BuyButton.DoClick
--		end
			parent:AddItem(ItemBackground)
		end
	end
	DoTraderList(ITEMCATEGORY_SUPPLIES, SupplyPanel)
	DoTraderList(ITEMCATEGORY_AMMO, AmmoPanel)
	DoTraderList(ITEMCATEGORY_WEAPONS, GunPanel)
	DoTraderList(ITEMCATEGORY_ARMOR, ArmorPanel)
	DoTraderList(ITEMCATEGORY_JUNK, JunkPanel)
	DoTraderList(ITEMCATEGORY_MISCELLANEOUS, MiscPanel)


--------------------------------------------sell panel-------------------------------------------------------------



	DoSellPanel = function()
		if !IsValid(TraderFrame) then return end
		SellPanel:Clear()
		for k, v in SortedPairsByMemberValue(LocalInventory, "Weight", true) do
			if !GAMEMODE.ItemsList[k] then continue end -- ignore invalid shit
			local icost = ((GAMEMODE.ItemsList[k]["Cost"] or 0) * (0.2 + ((Perks.Barter or 0) * 0.005))) or 0
--			if icost < 1 then continue end -- dont sell items that are not worth anything

			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
			local ItemBackground = vgui.Create("DPanel")
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(350, 70)
			ItemBackground.Paint = function() -- Paint function
				surface.SetDrawColor(50, 50, 50,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
				surface.SetDrawColor(0, 0, 0,200)
				surface.DrawRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end

			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(5, 5)
			ItemDisplay:SetModel(v.Model)
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
			ItemName:SetFont("TargetIDSmall")
			ItemName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				ItemName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					ItemName:SetTextColor(tbl_rarity.col)
				end
			end
			ItemName:SetText(GAMEMODE:GetItemName(k).." ("..v.Weight.."kg)")
			ItemName:SizeToContents()

			if icost > 1 then
				local ItemCost = vgui.Create("DLabel", ItemBackground)
				ItemCost:SetPos(170, 43)
				ItemCost:SetFont("TargetIDSmall")
				ItemCost:SetColor(Color(155,255,155,255))
				ItemCost:SetText(tostring(math.floor(icost)))
				ItemCost:SizeToContents()
			end

			local ItemQty = vgui.Create("DLabel", ItemBackground)
			ItemQty:SetPos(300, 10)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SizeToContents()

			if icost >= 1 then
				local EquipButton = vgui.Create("DButton", ItemBackground)
				EquipButton:SetSize(80, 20)
				EquipButton:SetPos(80, 40)
				EquipButton:SetText("Sell For:")
				EquipButton:SetTextColor(Color(255, 255, 255, 255))
				EquipButton.Paint = function(panel)
					surface.SetDrawColor(0, 150, 0,255)
					surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
					draw.RoundedBox(2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130))
				end
				local function SellItems(amt)
--					surface.PlaySound("buttons/button15.wav")

					net.Start("SellItem")
					net.WriteString(k)
					net.WriteUInt(amt, 32)
					net.SendToServer()

					timer.Simple(0.3, function()
						LWeight:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
--						LMoney:SetText("My Wallet: "..math.floor(MyMoney))
					end)
				end

				EquipButton.DoClick = function()
					local menu = DermaMenu()
					menu:AddOption("Sell 1x", function() SellItems(1) end)
					if v.Qty >= 2 then menu:AddOption("Sell 2x", function() SellItems(2) end) end
					if v.Qty >= 3 then menu:AddOption("Sell 3x", function() SellItems(3) end) end
					if v.Qty >= 5 then menu:AddOption("Sell 5x", function() SellItems(5) end) end
					if v.Qty >= 7 then menu:AddOption("Sell 7x", function() SellItems(7) end) end
					if v.Qty >= 10 then menu:AddOption("Sell 10x", function() SellItems(10) end) end
					if v.Qty >= 15 then menu:AddOption("Sell 15x", function() SellItems(15) end) end
					menu:AddOption("Sell All", function() SellItems(v.Qty) end)
					menu:Open()
				end
				EquipButton.DoRightClick = function()
					SellItems(input.IsShiftDown() and v.Qty or 1)
				end
			end

				local VaultButton = vgui.Create("DButton", ItemBackground)
				VaultButton:SetSize(80, 20)
				VaultButton:SetPos(260, 40)
				VaultButton:SetText("Store in Vault")
				VaultButton:SetTextColor(Color(255, 255, 255, 255))
				VaultButton.Paint = function(panel)
					surface.SetDrawColor(150, 150, 0,255)
					surface.DrawOutlinedRect(0, 0, VaultButton:GetWide(), VaultButton:GetTall())
					draw.RoundedBox(2, 0, 0, VaultButton:GetWide(), VaultButton:GetTall(), Color(50, 50, 0, 130))
				end
				local function PlaceItemsInVault(amt)
--					surface.PlaySound("buttons/button15.wav")

					net.Start("AddVault")
					net.WriteString(k)
					net.WriteUInt(amt, 32)
					net.SendToServer()

					timer.Simple(0.4, function()
						LWeight:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
--						LMoney:SetText("My Wallet: "..math.floor(MyMoney))
					end)
				end

				VaultButton.DoClick = function()
					local menu = DermaMenu()
					menu:AddOption("Place 1x in vault", function() PlaceItemsInVault(1) end)
					if v.Qty >= 2 then menu:AddOption("Place 2x in vault", function() PlaceItemsInVault(2) end) end
					if v.Qty >= 3 then menu:AddOption("Place 3x in vault", function() PlaceItemsInVault(3) end) end
					if v.Qty >= 5 then menu:AddOption("Place 5x in vault", function() PlaceItemsInVault(5) end) end
					if v.Qty >= 7 then menu:AddOption("Place 7x in vault", function() PlaceItemsInVault(7) end) end
					if v.Qty >= 10 then menu:AddOption("Place 10x in vault", function() PlaceItemsInVault(10) end) end
					if v.Qty >= 15 then menu:AddOption("Place 15x in vault", function() PlaceItemsInVault(15) end) end
					menu:AddOption("Place All in vault", function() PlaceItemsInVault(v.Qty) end)
					menu:Open()
				end
				VaultButton.DoRightClick = function()
					PlaceItemsInVault(input.IsShiftDown() and v.Qty or 1)
				end
				SellPanel:AddItem(ItemBackground)
			end
		end
		DoSellPanel()






------------------------------------------vault panel-----------------------------------------------------------------



	DoVaultPanel = function()
		if !IsValid(TraderFrame) then return end
		VaultPanel:Clear()
		for k, v in SortedPairsByMemberValue(LocalVault, "Weight", true) do
			if !GAMEMODE.ItemsList[k] then continue end -- ignore invalid items
			
			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
			local ItemBackground = vgui.Create("DPanel")
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(350, 65)
			ItemBackground.Paint = function() -- Paint function
				surface.SetDrawColor(50, 50, 50,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
				surface.SetDrawColor(0, 0, 0,200)
				surface.DrawRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end

			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(5, 5)
			ItemDisplay:SetModel(v.Model)
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
			ItemName:SetFont("TargetIDSmall")
			ItemName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				ItemName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					ItemName:SetTextColor(tbl_rarity.col)
				end
			end
			ItemName:SetText(GAMEMODE:GetItemName(k).." ("..v.Weight.."kg)")
			ItemName:SizeToContents()

			local ItemQty = vgui.Create("DLabel", ItemBackground)
			ItemQty:SetPos(300, 10)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SizeToContents()


			local function WithdrawItemsFromVault(amt)
--				surface.PlaySound("buttons/button15.wav")

				net.Start("WithdrawVault")
				net.WriteString(k)
				net.WriteUInt(amt, 32)
				net.SendToServer()
				timer.Simple(0.4, function()
					LWeight:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
				end)
			end

			local EquipButton = vgui.Create("DButton", ItemBackground)
			EquipButton:SetSize(80, 20)
			EquipButton:SetPos(80, 35)
			EquipButton:SetText("Withdraw")
			EquipButton:SetTextColor(Color(255, 255, 255, 255))
			EquipButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0,255)
				surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
				draw.RoundedBox(2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130))
			end
			EquipButton.DoClick = function()
				local menu = DermaMenu()
				menu:AddOption("Withdraw 1x in vault", function() WithdrawItemsFromVault(1) end)
				if v.Qty >= 2 then menu:AddOption("Withdraw 2x in vault", function() WithdrawItemsFromVault(2) end) end
				if v.Qty >= 3 then menu:AddOption("Withdraw 3x in vault", function() WithdrawItemsFromVault(3) end) end
				if v.Qty >= 5 then menu:AddOption("Withdraw 5x in vault", function() WithdrawItemsFromVault(5) end) end
				if v.Qty >= 7 then menu:AddOption("Withdraw 7x in vault", function() WithdrawItemsFromVault(7) end) end
				if v.Qty >= 10 then menu:AddOption("Withdraw 10x in vault", function() WithdrawItemsFromVault(10) end) end
				if v.Qty >= 15 then menu:AddOption("Withdraw 15x in vault", function() WithdrawItemsFromVault(15) end) end
				menu:AddOption("Withdraw All in vault", function() WithdrawItemsFromVault(v.Qty) end)
				menu:Open()
			end
			EquipButton.DoRightClick = function()
				WithdrawItemsFromVault(input.IsShiftDown() and v.Qty or 1)
			end

			VaultPanel:AddItem(ItemBackground)
		end
	end
	DoVaultPanel()



	PropertySheet:AddSheet(translate.Get("items_category_1"), AmmoPanel, "icon16/ammo_three.png", false, false, translate.Get("items_category_1_d"))
	PropertySheet:AddSheet(translate.Get("items_category_2"), SupplyPanel, "icon16/box.png", false, false, translate.Get("items_category_2_d"))
	PropertySheet:AddSheet(translate.Get("items_category_3"), GunPanel, "icon16/gun.png", false, false, translate.Get("items_category_3_d"))
	PropertySheet:AddSheet(translate.Get("items_category_4"), ArmorPanel, "icon16/shield.png", false, false, translate.Get("items_category_4_d"))
	PropertySheet:AddSheet(translate.Get("items_category_5"), JunkPanel, "icon16/bin.png", false, false, translate.Get("items_category_5_d"))
	PropertySheet:AddSheet(translate.Get("items_category_6"), MiscPanel, "icon16/basket.png", false, false, translate.Get("items_category_6_d"))
	PropertySheet:AddSheet("My Items", SellPanel, "icon16/money_dollar.png", false, false, "Sell your items that you don't need for cash")
	PropertySheet:AddSheet("Item Vault", VaultPanel, "icon16/building.png", false, false, "Store your stuff that you don't need")
/*
	PropertySheet:AddSheet("Special Functions", Specials, "icon16/star.png", false, false, "Use this menu to trade in your bounty and speak to the trader about various issues")
*/

end