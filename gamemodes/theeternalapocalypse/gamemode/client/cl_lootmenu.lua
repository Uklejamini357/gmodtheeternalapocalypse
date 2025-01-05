-------------------------------- Loot Menu --------------------------------

local loottable = {}
local currentcrate = game.GetWorld()

local function GenerateLootTable(raw)
	loottable = {}
	for k, v in pairs(raw) do
		if !GAMEMODE.ItemsList[k] then continue end
		local ref = GAMEMODE.ItemsList[k]

		loottable[k] = {
			["Model"] = ref.Model,
			["Weight"] = ref.Weight,
			["Rarity"] = ref.Rarity,
			["Qty"] = v,
		}
	end
end


local function DoLootPanel(canstore)
	local canstore = canstore or false
	if lootpanel and lootpanel:IsVisible() then return end

	surface.PlaySound("items/ammocrate_open.wav")

	local lootpanel = vgui.Create( "DFrame" )
	lootpanel:SetSize(600, 600)
	lootpanel:Center()
	lootpanel:SetTitle("Airdrop Loot")
	lootpanel:SetDraggable(false)
	lootpanel:SetVisible(true)
	lootpanel:SetAlpha(0)
	lootpanel:AlphaTo(255, 0.25, 0)
	lootpanel:ShowCloseButton(true)
	lootpanel:MakePopup()
	lootpanel.Paint = function(panel, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local PropertySheet = vgui.Create("DPropertySheet", lootpanel)
	PropertySheet:SetPos(10, 20)
	PropertySheet:SetSize(580, lootpanel:GetTall() - 35)
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

	local InvForm = vgui.Create( "DForm", PropertySheet )
	InvForm:SetSize(575, 500)
	InvForm:SetPadding(4)
	InvForm:SetName("")
	InvForm.Paint = function()
		draw.RoundedBox(2, 0, 0, InvForm:GetWide(), InvForm:GetTall(), Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, InvForm:GetWide(), InvForm:GetTall())
	end

	local TheListPanel = vgui.Create( "DPanelList", InvForm )
	TheListPanel:SetTall(495)
	TheListPanel:SetWide(580)
	TheListPanel:SetPos(5, 5)
	TheListPanel:EnableVerticalScrollbar(true)
	TheListPanel:EnableHorizontal(true)
   	TheListPanel:SetSpacing(5)

	if canstore then
		local StoreForm = vgui.Create("DForm", PropertySheet)
		StoreForm:SetSize(575, 500)
		StoreForm:SetPadding(4)
		StoreForm:SetName("")
		StoreForm.Paint = function()
			draw.RoundedBox(2, 0, 0, StoreForm:GetWide(), StoreForm:GetTall(), Color(0, 0, 0, 100))
			surface.SetDrawColor(150, 150, 0 ,255)
			surface.DrawOutlinedRect(0, 0, StoreForm:GetWide(), StoreForm:GetTall())
		end
	end

	local weightlabel = vgui.Create( "DLabel", lootpanel )
	weightlabel:SetPos(20, 560)
	weightlabel:SetFont("TargetIDSmall")
	weightlabel:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
	weightlabel:SizeToContents()


	local function uwotm8(tab, parent)
		for k, v in SortedPairsByMemberValue(tab, "Weight", true) do

			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
			local ItemBackground = vgui.Create("DPanel")
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(550, 65)
			ItemBackground.Paint = function( panel, w, h)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
				surface.SetDrawColor(0, 0, 0 ,200)
				surface.DrawRect(0, 0, w, h)
				-- local canpick = (LocalPlayer():CalculateWeight() + v.Weight) <= LocalPlayer():CalculateMaxWeight()
				-- if !canpick then
				-- 	draw.DrawText(Format("Not enough weight (need %skg space)", math.Round((LocalPlayer():CalculateWeight() + v.Weight) - LocalPlayer():CalculateMaxWeight(), 2)), "TargetIDSmall", ItemBackground:GetWide() - 20, 45, Color(255,205,205), TEXT_ALIGN_RIGHT)
				-- end
			end

			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(5, 5)
			ItemDisplay:SetModel(v.Model)
			ItemDisplay:SetToolTip(GAMEMODE:GetItemDescription(k))
			ItemDisplay:SetSize(56,56)
			ItemDisplay.PaintOver = function()
			end
			ItemDisplay.OnMousePressed = function()
				return false
			end

			local ItemName = vgui.Create( "DLabel", ItemBackground )
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
			ItemQty:SetPos(500, 10)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SizeToContents()

			local TakeButton = vgui.Create("DButton", ItemBackground)
			TakeButton:SetSize(80, 20)
			TakeButton:SetPos(80, 35)
			TakeButton:SetText(translate.Get("take"))
			TakeButton:SetTextColor(Color(255, 255, 255, 255))
			TakeButton.Paint = function(panel, w, h)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
			end
			TakeButton.DoClick = function()
				if currentcrate:IsValid() then
					-- this distance check exists on the server too so don't even try being a smartarse with net messages m8
					if !LocalPlayer():Alive() or LocalPlayer():GetPos():Distance(currentcrate:GetPos()) > 120 then chat.AddText(Color(255,200,200), "You have moved too far away from this crate!") lootpanel:Remove() return end
					-- if (LocalPlayer():CalculateWeight() + v.Weight) > LocalPlayer():CalculateMaxWeight() then chat.AddText(Color(255,200,200), "You don't have enough free space to carry that! (Need "..math.Round((LocalPlayer():CalculateWeight() + v.Weight) - LocalPlayer():CalculateMaxWeight(), 2).."kg space)") return end
					net.Start("UseCrate")
					net.WriteEntity(currentcrate)
					net.WriteString(k)
					net.WriteBool(false)
					net.SendToServer()

					if v.Qty > 1 then v.Qty = v.Qty - 1 else tab[k] = nil end

					timer.Simple(0.1, function()
						if TheListPanel:IsValid() then
							TheListPanel:Clear()
							uwotm8(tab, parent)
						end
						weightlabel:SetText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT))
						weightlabel:SizeToContents()
					end)
				end
			end
			parent:AddItem(ItemBackground)
		end
	end
	uwotm8(loottable, TheListPanel)


	PropertySheet:AddSheet(translate.Get("takeitems"), InvForm, "icon16/basket_remove.png", false, false, "The stuff that is in this crate")
--	if canstore then --excluded because there's no function to store items into containers yet
--		PropertySheet:AddSheet(translate.Get("storeitems"), StoreForm, "icon16/basket_put.png", false, false, "Put your stuff into the container")
--	end
end


net.Receive("SendCrateItems", function()
	local crate = net.ReadEntity()
	local tab = net.ReadTable()
	local canstore = net.ReadBool()
	if !crate:IsValid() then return end

	currentcrate = crate
	GenerateLootTable(tab)
	DoLootPanel(canstore)
end)
