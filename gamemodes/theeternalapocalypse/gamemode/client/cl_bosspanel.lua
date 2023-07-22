-- This is used when boss is defeated to display who dealed damage to bosses

BossDamagedByTable = {}

net.Receive("BossKilled", function(length)
    local bosstable = net.ReadTable()

    BossDamagedByTable = bosstable
    gamemode.Call("ShowBossPanel")
end)

function GM:ShowBossPanel()
    if IsValid(BossPanel) then BossPanel:Remove() end
    BossPanel = vgui.Create("DFrame")
    BossPanel:SetSize(400, 200)
    BossPanel:SetPos((ScrW() - BossPanel:GetWide()) / 2, 50)
    BossPanel:SetTitle("")
    BossPanel:SetDraggable(false)
    BossPanel:SetAlpha(0)
	BossPanel:AlphaTo(255, 1, 0)
    BossPanel:SetVisible(true)
    BossPanel:ShowCloseButton(false)
    BossPanel.Paint = function()
		draw.RoundedBox(2, 0, 0, BossPanel:GetWide(), BossPanel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, BossPanel:GetWide(), BossPanel:GetTall())
	end

    local ListPanel = vgui.Create("DPanelList", BossPanel)
	ListPanel:SetTall(190)
	ListPanel:SetWide(390)
	ListPanel:SetPos(30, 35)
	ListPanel:EnableVerticalScrollbar(true)
	ListPanel:EnableHorizontal(true)
   	ListPanel:SetSpacing(5)


	local function DoListPanel()
		local text = translate.Get("boss_defeated")
		local IBG = vgui.Create("DLabel", BossPanel)
		IBG:SetFont("TargetID")
		IBG:SetText(text)
		IBG:SetTextColor(Color(255,255,255,255))
		IBG:SizeToContents()
		IBG:SetPos((BossPanel:GetWide() / 2) - (IBG:GetWide() / 2), 10)

		local DMGBG = vgui.Create("DPanel", ListPanel)
		DMGBG:SetPos(5, 25)
		DMGBG:SetSize(380, 180)
		DMGBG.Paint = function() end

		if BossDamagedByTable and table.Count(BossDamagedByTable) > 0 then
			for k, v in SortedPairsByValue(BossDamagedByTable, true) do
				local DisplayDMG = vgui.Create("DLabel", DMGBG)
				DisplayDMG:SetText(Format("%s - %d", k:Nick(), math.Round(v)))
				DisplayDMG:SetSize(390, 15)
				DisplayDMG:SetFont("TargetIDSmall")
				ListPanel:AddItem(DisplayDMG)
			end
		else
			local DisplayDMG = vgui.Create("DLabel", DMGBG)
			DisplayDMG:SetText(translate.Get("no_one_damaged_boss"))
			DisplayDMG:SetSize(390, 15)
			DisplayDMG:SetFont("TargetIDSmall")
			ListPanel:AddItem(DisplayDMG)
		end
	end
	DoListPanel()

	if timer.Exists("BossPanelClose") then timer.Destroy("BossPanelClose") end
    timer.Create("BossPanelClosing", 9, 1, function()
        if !IsValid(BossPanel) then return end
        BossPanel:AlphaTo(0, 1, 0)
        timer.Create("BossPanelClose", 1, 1, function()
            BossPanel:Remove()
        end)
    end)
end
