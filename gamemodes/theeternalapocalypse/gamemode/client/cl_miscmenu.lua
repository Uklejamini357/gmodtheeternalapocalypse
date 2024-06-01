
local PrinterPanel

function GM:MakeMoneyPrinterPanel(ent)
	if IsValid(PrinterPanel) then PrinterPanel:Remove() end
	PrinterPanel = vgui.Create("DFrame")
	PrinterPanel:SetSize(500, 400)
	PrinterPanel:Center()
	PrinterPanel:SetTitle("Trader Menu")
	PrinterPanel:SetDraggable(false)
	PrinterPanel:SetVisible(true)
	PrinterPanel:ShowCloseButton(true)
	PrinterPanel:MakePopup()
	PrinterPanel.Paint = function()
		draw.RoundedBox(2, 0, 0, PrinterPanel:GetWide(), PrinterPanel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0, 255)
		surface.DrawOutlinedRect(0, 0, PrinterPanel:GetWide(), PrinterPanel:GetTall())
	end
	PrinterPanel.Think = function(this)
		if !ent or !ent:IsValid() then
			this:Remove()
		end
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				this:Remove()
			end)
			gui.HideGameUI()
		end
	end


	local text = vgui.Create("DLabel", PrinterPanel)
	text:SetText("Money Printer")
	text:SetSize(200, 55)
	text:SetPos(100, 30)
	text:SetTextColor(Color(255, 255, 255, 255))

	local TraderButton = vgui.Create("DButton", PrinterPanel)
	TraderButton:SetSize(200, 45)
	TraderButton:SetPos(100, 80)
	TraderButton:SetText("Collect money")
	TraderButton:SetTextColor(Color(255, 255, 255, 255))
	TraderButton.Paint = function(panel, w, h)
		surface.SetDrawColor(0, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 50, 0, 130))
	end
	TraderButton.DoClick = function()
		GAMEMODE:PrinterPanel()
		PrinterPanel:Remove()
	end

	local cash = vgui.Create("DLabel", PrinterPanel)
	cash:SetFont("TargetID")
	cash:SetPos(100, 190)
	cash:SetText("Printer money: "..ent:)
	cash:SetColor(Color(155,255,155,255))
	cash:SizeToContents()
	cash.Think = function()
		local txt = "My Wallet: "..math.floor(MyMoney).."\nMy bounty: "..math.floor(MyBounty)
		if cash:GetText() == txt then return end
		cash:SetText(txt)
	end

	local CastBounty = vgui.Create("DButton", PrinterPanel)
	CastBounty:SetSize(200, 45)
	CastBounty:SetPos(100, 130)
	CastBounty:SetText("Upgrade printer")
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

