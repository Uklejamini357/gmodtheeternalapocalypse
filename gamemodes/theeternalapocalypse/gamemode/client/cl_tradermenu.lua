-------------------------------- Trader Menu --------------------------------
net.Receive("OpenTraderMenu", function()
	GAMEMODE:OpenTraderMenu()
end)

local TraderMenu
local TraderFrame
local DoTraderList
local DoSellPanel
local DoVaultPanel

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
	
	local SellPanel = vgui.Create("DPanelList")
	SellPanel:SetTall(635)
	SellPanel:SetWide(890)
	SellPanel:SetPos(5, 25)
	SellPanel:EnableVerticalScrollbar(true)
	SellPanel:EnableHorizontal(true)
	SellPanel:SetSpacing(10)
	
	local ArmorPanel = vgui.Create("DPanelList")
	ArmorPanel:SetTall(635)
	ArmorPanel:SetWide(890)
	ArmorPanel:SetPos(5, 25)
	ArmorPanel:EnableVerticalScrollbar(true)
	ArmorPanel:EnableHorizontal(true)
	ArmorPanel:SetSpacing(10)
	
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
	LWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).." / "..CalculateMaxWeightClient().."kg")

	local LMoney = vgui.Create("DLabel", TraderFrame)
	LMoney:SetFont("TargetID")
	LMoney:SetPos(350, TraderFrame:GetTall() - 50)
	LMoney:SetSize(350, 41)
	LMoney:SetColor(Color(155,255,155,255))
	LMoney:SetText("My Wallet: "..math.floor(MyMoney))
	LMoney.Think = function()
		local txt = "My Wallet: "..math.floor(MyMoney)
		if LMoney:GetText() == txt then return end
		LMoney:SetText(txt)
		LMoney:SizeToContents()
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
	LVaultWeight:SetText("Vault Capacity: "..CalculateVaultClient().."kg / "..GAMEMODE.Config["VaultSize"].."kg")
	LVaultWeight:SizeToContents()
	LVaultWeight:SetPos(TraderFrame:GetWide() - LVaultWeight:GetWide() - 200, TraderFrame:GetTall() - 38)
	LVaultWeight.Think = function(this)
		local txt = "Vault Capacity: "..CalculateVaultClient().."kg / "..GAMEMODE.Config["VaultSize"].."kg"
		if this:GetText() == txt then return end
		this:SetText(txt)
		this:SizeToContents()
	end
	
	local backbutton = vgui.Create("DButton", TraderFrame)
	backbutton:SetSize(120, 45)
	backbutton:SetText("Back")
	backbutton:SetPos(TraderFrame:GetWide() - backbutton:GetWide() - 50, TraderFrame:GetTall() - 52)
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
			ItemDisplay:SetToolTip(translate.Get(k.."_d")..(v["ArmorStats"] and "\n"..translate.Format("item_armor_descr", v.ArmorStats["reduction"] or 0, v.ArmorStats["env_reduction"] or 0, (-v.ArmorStats["speedloss"] or 0) / 10, v.ArmorStats["slots"] or 0, v.ArmorStats["battery"] or 0, v.ArmorStats["carryweight"] or 0) or "").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
--			ItemDisplay:SetToolTip(translate.Get(k.."_d").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
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
			ItemName:SetText(translate.Get(k.."_n"))

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
				timer.Simple(0.3, function()
					LWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).." / "..CalculateMaxWeightClient().."kg")
--					LMoney:SetText("My Wallet: "..math.floor(MyMoney))
					DoSellPanel()
				end)
			end
--		end
			parent:AddItem(ItemBackground)
		end
	end
	DoTraderList(ITEMCATEGORY_AMMO, SupplyPanel)
	DoTraderList(ITEMCATEGORY_SUPPLIES, AmmoPanel)
	DoTraderList(ITEMCATEGORY_WEAPONS, GunPanel)
	DoTraderList(ITEMCATEGORY_ARMOR, ArmorPanel)


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
			ItemDisplay:SetToolTip(translate.Get(k.."_d")..(v["ArmorStats"] and "\n"..translate.Format("item_armor_descr", v.ArmorStats["reduction"] or 0, v.ArmorStats["env_reduction"] or 0, (-v.ArmorStats["speedloss"] or 0) / 10, v.ArmorStats["slots"] or 0, v.ArmorStats["battery"] or 0, v.ArmorStats["carryweight"] or 0) or "").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
--			ItemDisplay:SetToolTip(translate.Get(k.."_d").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
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
			ItemName:SetText(translate.Get(k.."_n").." ("..v.Weight.."kg)")
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
				EquipButton.DoClick = function()
					net.Start("SellItem")
					net.WriteString(k)
					net.SendToServer()
					timer.Simple(0.3, function()
						LWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).." / "..CalculateMaxWeightClient().."kg")
--						LMoney:SetText("My Wallet: "..math.floor(MyMoney))
					end)
						timer.Simple(0.25, function() 
							if IsValid(SellPanel) then
								DoSellPanel()
							end
						end)
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
				VaultButton.DoClick = function()
					net.Start("AddVault")
					net.WriteString(k)
					net.SendToServer()
					timer.Simple(0.4, function()
						LWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).." / "..CalculateMaxWeightClient().."kg")
--						LMoney:SetText("My Wallet: "..math.floor(MyMoney))
					end)
					timer.Simple(0.4, function() 
						if IsValid(SellPanel) then
							DoSellPanel()
						end
						if IsValid(VaultPanel) then
							DoVaultPanel()
						end
					end)
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
			ItemDisplay:SetToolTip(translate.Get(k.."_d")..(v["ArmorStats"] and "\n"..translate.Format("item_armor_descr", v.ArmorStats["reduction"] or 0, v.ArmorStats["env_reduction"] or 0, (-v.ArmorStats["speedloss"] or 0) / 10, v.ArmorStats["slots"] or 0, v.ArmorStats["battery"] or 0, v.ArmorStats["carryweight"] or 0) or "").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
--			ItemDisplay:SetToolTip(translate.Get(k.."_d").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
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
			ItemName:SetText(translate.Get(k.."_n").." ("..v.Weight.."kg)")
			ItemName:SizeToContents()

			local ItemQty = vgui.Create("DLabel", ItemBackground)
			ItemQty:SetPos(300, 10)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SizeToContents()

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
				net.Start("WithdrawVault")
				net.WriteString(k)
				net.SendToServer()
				timer.Simple(0.4, function()
					LWeight:SetText(translate.Format("weight_1", CalculateWeightClient()).." / "..CalculateMaxWeightClient().."kg")
--					LMoney:SetText("My Wallet: "..math.floor(MyMoney))
				end)
				timer.Simple(0.4, function() 
					if IsValid(VaultPanel) then DoVaultPanel() end
					if IsValid(SellPanel) then DoSellPanel() end
				end)
			end
			VaultPanel:AddItem(ItemBackground)
		end
	end
	DoVaultPanel()



	PropertySheet:AddSheet("Ammunition", AmmoPanel, "icon16/briefcase.png", false, false, "Ammunition needed for your guns to shoot")
	PropertySheet:AddSheet("Supplies", SupplyPanel, "icon16/box.png", false, false, "Food, Medical Supplies, Misc items, for survival")
	PropertySheet:AddSheet("Weapons", GunPanel, "icon16/bomb.png", false, false, "Good guns that cost a lot and uses ammo, but also melee that cost less.")
	PropertySheet:AddSheet("Armor", ArmorPanel, "icon16/shield.png", false, false, "Protective Armor to protect yourself from any sort of danger")
	PropertySheet:AddSheet("My Items", SellPanel, "icon16/money_dollar.png", false, false, "Sell your items that you don't need for cash")
	PropertySheet:AddSheet("Item Vault", VaultPanel, "icon16/building.png", false, false, "Store your stuff that you don't need")
/*
	PropertySheet:AddSheet("Special Functions", Specials, "icon16/star.png", false, false, "Use this menu to trade in your bounty and speak to the trader about various issues")
*/

end