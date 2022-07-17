/*-------------------------------------------------------------------------------------------------

 ▄▄▄        █████▒▄▄▄█████▓▓█████  ██▀███     ▄▄▄█████▓ ██░ ██ ▓█████    ▓█████  ███▄    █ ▓█████▄ 
▒████▄    ▓██   ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒   ▓  ██▒ ▓▒▓██░ ██▒▓█   ▀    ▓█   ▀  ██ ▀█   █ ▒██▀ ██▌
▒██  ▀█▄  ▒████ ░ ▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒   ▒ ▓██░ ▒░▒██▀▀██░▒███      ▒███   ▓██  ▀█ ██▒░██   █▌
░██▄▄▄▄██ ░▓█▒  ░ ░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄     ░ ▓██▓ ░ ░▓█ ░██ ▒▓█  ▄    ▒▓█  ▄ ▓██▒  ▐▌██▒░▓█▄   ▌
 ▓█   ▓██▒░▒█░      ▒██▒ ░ ░▒████▒░██▓ ▒██▒     ▒██▒ ░ ░▓█▒░██▓░▒████▒   ░▒████▒▒██░   ▓██░░▒████▓ 
 ▒▒   ▓▒█░ ▒ ░      ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░     ▒ ░░    ▒ ░░▒░▒░░ ▒░ ░   ░░ ▒░ ░░ ▒░   ▒ ▒  ▒▒▓  ▒ 
  ▒   ▒▒ ░ ░          ░     ░ ░  ░  ░▒ ░ ▒░       ░     ▒ ░▒░ ░ ░ ░  ░    ░ ░  ░░ ░░   ░ ▒░ ░ ▒  ▒ 
  ░   ▒    ░ ░      ░         ░     ░░   ░      ░       ░  ░░ ░   ░         ░      ░   ░ ░  ░ ░  ░ 
      ░  ░                    ░  ░   ░                  ░  ░  ░   ░  ░      ░  ░         ░    ░    
                                                                                            ░      


An apocalyptic RPG gamemode created by LegendofRobbo
Based on the ideas and concepts explored in Zombified World by Fizzadar and Chewgum

-------------------------------------------------------------------------------------------------*/

net.Receive("OpenTraderMenu", function() TraderMenu() end)

function TraderMenu()

TraderFrame = vgui.Create( "DFrame" )
TraderFrame:SetSize( 1000, 700 )
TraderFrame:Center()
TraderFrame:SetTitle ( "" )
TraderFrame:SetDraggable( false )
TraderFrame:SetVisible( true )
TraderFrame:ShowCloseButton( true )
TraderFrame:MakePopup()
TraderFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, TraderFrame:GetWide(), TraderFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, TraderFrame:GetWide(), TraderFrame:GetTall())
	surface.DrawLine(0, TraderFrame:GetTall() - 60, TraderFrame:GetWide(), TraderFrame:GetTall() - 60)
end

	local PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent( TraderFrame )
	PropertySheet:SetPos( 5, 5 )
	PropertySheet:SetSize( 900, TraderFrame:GetTall() - 65 )
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
	for k, v in pairs(PropertySheet.Items) do
	if (!v.Tab) then continue end
	
	v.Tab.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
	end
	end
	end

	local SupplyPanel = vgui.Create( "DPanelList" )
	SupplyPanel:SetTall( 635 )
	SupplyPanel:SetWide( 890 )
	SupplyPanel:SetPos( 5, 25 )
	SupplyPanel:EnableVerticalScrollbar( true )
	SupplyPanel:EnableHorizontal( true )
	SupplyPanel:SetSpacing( 10 )

    local AmmoPanel = vgui.Create( "DPanelList" )
    AmmoPanel:SetTall( 635 )
    AmmoPanel:SetWide( 890 )
    AmmoPanel:SetPos( 5, 25 )
    AmmoPanel:EnableVerticalScrollbar( true )
    AmmoPanel:EnableHorizontal( true )
    AmmoPanel:SetSpacing( 10 )

    local GunPanel = vgui.Create( "DPanelList" )
    GunPanel:SetTall( 635 )
    GunPanel:SetWide( 890 )
    GunPanel:SetPos( 5, 25 )
    GunPanel:EnableVerticalScrollbar( true )
    GunPanel:EnableHorizontal( true )
    GunPanel:SetSpacing( 10 )

    local SellPanel = vgui.Create( "DPanelList" )
    SellPanel:SetTall( 635 )
    SellPanel:SetWide( 890 )
    SellPanel:SetPos( 5, 25 )
    SellPanel:EnableVerticalScrollbar( true )
    SellPanel:EnableHorizontal( true )
    SellPanel:SetSpacing( 10 )

    local ArmorPanel = vgui.Create( "DPanelList" )
    ArmorPanel:SetTall( 635 )
    ArmorPanel:SetWide( 890 )
    ArmorPanel:SetPos( 5, 25 )
    ArmorPanel:EnableVerticalScrollbar( true )
    ArmorPanel:EnableHorizontal( true )
    ArmorPanel:SetSpacing( 10 )

    local VaultPanel = vgui.Create( "DPanelList" )
    VaultPanel:SetTall( 635 )
    VaultPanel:SetWide( 890 )
    VaultPanel:SetPos( 5, 25 )
    VaultPanel:EnableVerticalScrollbar( true )
    VaultPanel:EnableHorizontal( true )
    VaultPanel:SetSpacing( 10 )

    local Specials = vgui.Create( "DPanelList" )
    Specials:SetTall( 635 )
    Specials:SetWide( 890 )
    Specials:SetPos( 5, 25 )


    MyWeight = vgui.Create( "DLabel", TraderFrame )
    MyWeight:SetFont( "TargetID" )
    MyWeight:SetPos( 10, TraderFrame:GetTall() - 42)
    MyWeight:SetSize( 350, 25)
    MyWeight:SetColor( Color(255,255,255,255) )
    MyWeight:SetText("Currently Carrying: "..CalculateWeightClient().."kg / "..37.4 + ((Perks.Strength or 0) * 1.53).."kg")

    MyMoney = vgui.Create( "DLabel", TraderFrame )
    MyMoney:SetFont( "TargetID" )
    MyMoney:SetPos( 300, TraderFrame:GetTall() - 42)
    MyMoney:SetSize( 350, 25)
    MyMoney:SetColor( Color(155,255,155,255) )
    MyMoney:SetText("Cash: "..Mymoney.." Bounty: "..Mybounty )

    local CastBounty = vgui.Create("DButton", TraderFrame)
    CastBounty:SetSize( 120, 45 )
    CastBounty:SetPos( 540, TraderFrame:GetTall() - 52 )
    CastBounty:SetText("Cash my bounty in!")
    CastBounty:SetTextColor(Color(255, 255, 255, 255))
    CastBounty.Paint = function(panel, w, h)
    surface.SetDrawColor(0, 150, 0 ,255)
    surface.DrawOutlinedRect(0, 0, w, h)
    draw.RoundedBox( 2, 0, 0, w, h, Color(0, 50, 0, 130) )
    end
    CastBounty.DoClick = function()
    net.Start("CashBounty")
    net.SendToServer()
    end


    MyVaultWeight = vgui.Create( "DLabel", TraderFrame )
    MyVaultWeight:SetFont( "TargetID" )
    MyVaultWeight:SetPos( 740, TraderFrame:GetTall() - 42)
    MyVaultWeight:SetSize( 350, 25)
    MyVaultWeight:SetColor( Color(255,255,255,255) )
    MyVaultWeight:SetText("Vault Capacity: "..CalculateVaultClient().."kg / 200kg")



--------------------------------------------supplies-------------------------------------------------------------




function DoTraderList(cat, parent)
for k, v in SortedPairsByMemberValue( ItemsList, "Cost" ) do
	if v.Supply == -1 or v.Category != cat then continue end -- skip items with -1 supply or that are in the wrong category

    local ItemBackground = vgui.Create( "DPanel" )
    ItemBackground:SetPos( 5, 5 )
    ItemBackground:SetSize( 280, 80 )
    ItemBackground.Paint = function() -- Paint function
        draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
	surface.SetDrawColor(50, 50, 50 ,255)
	surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
    end

    local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
    ItemDisplay:SetPos( 10, 10 )
    ItemDisplay:SetModel( v.Model )
    ItemDisplay:SetToolTip(v.Description)
    ItemDisplay:SetSize(60,60)
    ItemDisplay.PaintOver = function()
        return
    end
    ItemDisplay.OnMousePressed = function()
        return false
    end

    local ItemName = vgui.Create( "DLabel", ItemBackground )
    ItemName:SetFont( "TargetIDSmall" )
    ItemName:SetPos( 80, 10)
    ItemName:SetSize( 170, 15)
    ItemName:SetColor( Color(205,205,205,255) )
    ItemName:SetText( v.Name )

    local ItemCost = vgui.Create( "DLabel", ItemBackground )
    ItemCost:SetFont( "TargetIDSmall" )
    ItemCost:SetPos( 80, 25)
    ItemCost:SetSize( 170, 15)
    ItemCost:SetColor( Color(155,255,155,255) )
    ItemCost:SetText( "Cost: ".. math.floor((v.Cost * (1 - ((Perks.Barter or 0) * 0.015)))) )

    local ItemWeight = vgui.Create( "DLabel", ItemBackground )
    ItemWeight:SetFont( "TargetIDSmall" )
    ItemWeight:SetPos( 80, 42)
    ItemWeight:SetSize( 170, 15)
    ItemWeight:SetColor( Color(155,155,255,255) )
    ItemWeight:SetText( "Weight: ".. v.Weight.."kg" )

    local ItemSupply = vgui.Create( "DLabel", ItemBackground )
    ItemSupply:SetFont( "TargetIDSmall" )
    ItemSupply:SetPos( 80, 58)
    ItemSupply:SetSize( 170, 15)
    ItemSupply:SetColor( Color(255,155,155,255) )
    if v.Supply == 0 then
    ItemSupply:SetText( "Supply: Unlimited" )
	else
    ItemSupply:SetText( "Supply: ".. v.Supply.." / "..v.Supply )
	end

            local BuyButton = vgui.Create("DButton", ItemBackground)
            BuyButton:SetSize( 60, 60 )
            BuyButton:SetPos( 210, 10 )
            BuyButton:SetText("Buy")
            BuyButton:SetTextColor(Color(255, 255, 255, 255))
            BuyButton.Paint = function(panel)
            surface.SetDrawColor(0, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, BuyButton:GetWide(), BuyButton:GetTall())
            draw.RoundedBox( 2, 0, 0, BuyButton:GetWide(), BuyButton:GetTall(), Color(0, 50, 0, 130) )
            end
            BuyButton.DoClick = function()
            net.Start("BuyItem")
            net.WriteString(k)
            net.SendToServer()
            timer.Simple(0.3, function() MyWeight:SetText("Currently Carrying: "..CalculateWeightClient().."kg / "..37.4 + ((Perks.Strength or 0) * 1.53).."kg") MyMoney:SetText("My Wallet: "..Mymoney) end)
            end


parent:AddItem( ItemBackground )

end
end
DoTraderList(1, SupplyPanel)
DoTraderList(2, AmmoPanel)
DoTraderList(3, GunPanel)
DoTraderList(4, ArmorPanel)


--------------------------------------------sell panel-------------------------------------------------------------



local function DoSellPanel()

    for k, v in SortedPairsByMemberValue( LocalInventory, "Weight", true ) do
            if ! ItemsList[k] then continue end -- ignore invalid shit
            local icost = ((ItemsList[k]["Cost"] or 0) * (0.2 + ((Perks.Barter or 0) * 0.005)) ) or 0
            if icost < 1 then continue end -- dont sell shit that isnt worth anything
                
            local ItemBackground = vgui.Create( "DPanel" )
            ItemBackground:SetPos( 5, 5 )
            ItemBackground:SetSize( 350, 70 )
            ItemBackground.Paint = function() -- Paint function
                surface.SetDrawColor(50, 50, 50 ,255)
                surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
                surface.SetDrawColor(0, 0, 0 ,200)
                surface.DrawRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
            end
                
            local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
            ItemDisplay:SetPos( 5, 5 )
            ItemDisplay:SetModel( v.Model )
            ItemDisplay:SetToolTip(v.Description)
            ItemDisplay:SetSize(60,60)
            ItemDisplay.PaintOver = function()
                return
            end
            ItemDisplay.OnMousePressed = function()
                return false
            end
            

            local ItemName = vgui.Create( "DLabel", ItemBackground )
            ItemName:SetPos( 80, 10 )
            ItemName:SetFont( "TargetIDSmall" )
            ItemName:SetColor( Color(255,255,255,255) )
            ItemName:SetText( v.Name.." ("..v.Weight.."kg)" )
            ItemName:SizeToContents()


            local ItemCost = vgui.Create( "DLabel", ItemBackground )
            ItemCost:SetPos( 170, 43 )
            ItemCost:SetFont( "TargetIDSmall" )
            ItemCost:SetColor( Color(155,255,155,255) )
            ItemCost:SetText( tostring(math.floor(icost)) )
            ItemCost:SizeToContents()

            local ItemQty = vgui.Create( "DLabel", ItemBackground )
            ItemQty:SetPos( 300, 10 )
            ItemQty:SetFont( "QtyFont" )
            ItemQty:SetColor( Color(255,255,255,255) )
            ItemQty:SetText( v.Qty.."x" )
            ItemQty:SizeToContents()

            local EquipButton = vgui.Create("DButton", ItemBackground)
            EquipButton:SetSize( 80, 20 )
            EquipButton:SetPos( 80, 40 )
            EquipButton:SetText("Sell For:")
            EquipButton:SetTextColor(Color(255, 255, 255, 255))
            EquipButton.Paint = function(panel)
            surface.SetDrawColor(0, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
            draw.RoundedBox( 2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130) )
            end
            EquipButton.DoClick = function()
                net.Start("SellItem")
                net.WriteString(k)
                net.SendToServer()
                timer.Simple(0.3, function() MyWeight:SetText("Currently Carrying: "..CalculateWeightClient().."kg / "..37.4 + ((Perks.Strength or 0) * 1.53).."kg") MyMoney:SetText("My Wallet: "..Mymoney) end)
                    timer.Simple(0.25, function() 
                        if SellPanel:IsValid() then
                            SellPanel:Clear()
                            DoSellPanel()
                        end
                    end)

            end

            local VaultButton = vgui.Create("DButton", ItemBackground)
            VaultButton:SetSize( 80, 20 )
            VaultButton:SetPos( 260, 40 )
            VaultButton:SetText("Place in Vault")
            VaultButton:SetTextColor(Color(255, 255, 255, 255))
            VaultButton.Paint = function(panel)
            surface.SetDrawColor(150, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, VaultButton:GetWide(), VaultButton:GetTall())
            draw.RoundedBox( 2, 0, 0, VaultButton:GetWide(), VaultButton:GetTall(), Color(50, 50, 0, 130) )
            end
            VaultButton.DoClick = function()
                net.Start("AddVault")
                net.WriteString(k)
                net.SendToServer()
                timer.Simple(0.3, function() MyWeight:SetText("Currently Carrying: "..CalculateWeightClient().."kg / "..40 + ((Perks.Strength or 0) * 2).."kg") MyMoney:SetText("My Wallet: "..Mymoney) end)
                    timer.Simple(0.3, function() 
                        if SellPanel:IsValid() then
                            SellPanel:Clear()
                            DoSellPanel()
                        end
                    end)

            end

            SellPanel:AddItem( ItemBackground )
end
end
DoSellPanel()











------------------------------------------vault panel-----------------------------------------------------------------



local function DoVaultPanel()

    for k, v in SortedPairsByMemberValue( LocalVault, "Weight", true ) do
            if ! ItemsList[k] then continue end -- ignore invalid shit
                
            local ItemBackground = vgui.Create( "DPanel" )
            ItemBackground:SetPos( 5, 5 )
            ItemBackground:SetSize( 350, 65 )
            ItemBackground.Paint = function() -- Paint function
                surface.SetDrawColor(50, 50, 50 ,255)
                surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
                surface.SetDrawColor(0, 0, 0 ,200)
                surface.DrawRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
            end
                
            local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
            ItemDisplay:SetPos( 5, 5 )
            ItemDisplay:SetModel( v.Model )
            ItemDisplay:SetToolTip(v.Description)
            ItemDisplay:SetSize(60,60)
            ItemDisplay.PaintOver = function()
                return
            end
            ItemDisplay.OnMousePressed = function()
                return false
            end

            local ItemName = vgui.Create( "DLabel", ItemBackground )
            ItemName:SetPos( 80, 10 )
            ItemName:SetFont( "TargetIDSmall" )
            ItemName:SetColor( Color(255,255,255,255) )
            ItemName:SetText( v.Name.." ("..v.Weight.."kg)" )
            ItemName:SizeToContents()

            local ItemQty = vgui.Create( "DLabel", ItemBackground )
            ItemQty:SetPos( 300, 10 )
            ItemQty:SetFont( "QtyFont" )
            ItemQty:SetColor( Color(255,255,255,255) )
            ItemQty:SetText( v.Qty.."x" )
            ItemQty:SizeToContents()

            local EquipButton = vgui.Create("DButton", ItemBackground)
            EquipButton:SetSize( 80, 20 )
            EquipButton:SetPos( 80, 35 )
            EquipButton:SetText("Withdraw")
            EquipButton:SetTextColor(Color(255, 255, 255, 255))
            EquipButton.Paint = function(panel)
            surface.SetDrawColor(0, 150, 0 ,255)
            surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
            draw.RoundedBox( 2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130) )
            end
            EquipButton.DoClick = function()
                net.Start("WithdrawVault")
                net.WriteString(k)
                net.SendToServer()
                timer.Simple(0.3, function() MyVaultWeight:SetText("Vault Capacity: "..CalculateVaultClient().."kg / 200kg") end)
                    timer.Simple(0.3, function() 
                        if VaultPanel:IsValid() then
                            VaultPanel:Clear()
                            DoVaultPanel()
                        end
                    end)

            end

            VaultPanel:AddItem( ItemBackground )
end
end
DoVaultPanel()










PropertySheet:AddSheet( "Ammunition", AmmoPanel, "icon16/briefcase.png", 
false, false, "Ammunition needed for your guns to shoot" )
PropertySheet:AddSheet( "Supplies", SupplyPanel, "icon16/box.png", 
false, false, "Food, Medical Supplies, Misc items, for survival" )
PropertySheet:AddSheet( "Weapons", GunPanel, "icon16/bomb.png", 
false, false, "Good guns that cost a lot and uses ammo, but also melee that cost less." )
PropertySheet:AddSheet( "Armor", ArmorPanel, "icon16/shield.png", 
false, false, "Protective Armor to protect yourself from any sort of danger" )
PropertySheet:AddSheet( "My Items", SellPanel, "icon16/money_dollar.png", 
false, false, "Sell your items that you don't need for cash" )
PropertySheet:AddSheet( "Item Vault", VaultPanel, "icon16/building.png", 
false, false, "Store your stuff that you don't need" )
/*
PropertySheet:AddSheet( "Special Functions", Specials, "icon16/star.png", 
false, false, "Use this menu to trade in your bounty and speak to the trader about various issues" )
*/

end