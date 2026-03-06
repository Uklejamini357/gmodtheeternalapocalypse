-------------------------------- Models Menu --------------------------------
local pModel

function GM:ModelMenu()
	local pl = LocalPlayer()
	local plymodel = pl:GetModel()
	local plycolor = pl:GetPlayerColor()

	local pModel = vgui.Create("DFrame")
	pModel:SetSize(600, 740)
	pModel:Center()
	pModel:SetTitle("")
	pModel:SetDraggable(false)
	pModel:SetVisible(true)
	pModel:SetAlpha(0)
	pModel:AlphaTo(255, 0.25, 0)
	pModel:ShowCloseButton(true)
	pModel:MakePopup()
	pModel.Paint = function()
		draw.RoundedBox(2, 0, 0, pModel:GetWide(), pModel:GetTall(), Color(0,0,0,200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, pModel:GetWide(), pModel:GetTall())
		surface.DrawOutlinedRect(25, 25, 300, 300)
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(25, 350, 550, 300)
	end

	local function refreshmodel()
		local tcolor = vgui.Create("DColorMixer", pModel)
		tcolor:SetSize(225, 225)
		tcolor:SetPos(350, 25)
		tcolor:SetColor(Color(plycolor.x, plycolor.y, plycolor.r))
		tcolor.ValueChanged = function(Mixer, color)
			plycolor = tcolor:GetVector()
		end

		local mInfo = vgui.Create("DModelPanel", pModel)
		mInfo:SetSize(300,300)
		mInfo:SetPos(25,25)
		mInfo:SetModel(plymodel)
		mInfo:SetAnimSpeed(1)
		mInfo:SetAnimated(true)
		mInfo:SetAmbientLight(Color(50,50,50))
		mInfo:SetDirectionalLight(BOX_TOP, Color(255,255,255))
		mInfo:SetDirectionalLight(BOX_FRONT, Color(255,255,255))
		mInfo:SetCamPos(Vector(60,0,50))
		mInfo:SetLookAt(Vector(0,0,40))
		mInfo:SetFOV(75)
		function mInfo.Entity:GetPlayerColor() return plycolor end

		local mList = vgui.Create("DPanelList", pModel)
		mList:EnableHorizontal(true)
		mList:EnableVerticalScrollbar(true)
		mList:SetSize(550,300)
		mList:SetPos(25,350)
--ModelForm:AddItem( mList )

		local tab = GAMEMODE.DefaultModels
		if pl:GetNWString("ArmorType") != "none" then
			local armor = pl:GetNWString("ArmorType")
			if GAMEMODE.ItemsList[armor]["ArmorStats"]["allowmodels"] != nil then
				tab = GAMEMODE.ItemsList[armor]["ArmorStats"]["allowmodels"]
			end
		end

		for n = 1, table.getn(tab) do
			local mIcon = vgui.Create("SpawnIcon")
			mIcon:SetPos(x,y)
			mIcon:SetSize(64,64)
			mIcon:SetModel(tab[n])

			mIcon.DoClick = function()
				mInfo:SetModel(tab[n])
				plymodel = tab[n]
			end
			mList:AddItem(mIcon)
		end
	end
	refreshmodel()

	local mButton = vgui.Create("DButton")
	mButton:SetParent(pModel)
	mButton:SetPos(215,680)
	mButton:SetTextColor(Color(255,255,255,255))
	mButton:SetSize(150,30)
	mButton.Paint = function(panel)
		surface.SetDrawColor(0, 0, 0 ,200)
		panel:SetText(translate.Get("acceptmodelchange"))
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
	end
	mButton.DoClick = function()
		net.Start("ChangeModel")
		net.WriteString(plymodel)
		net.WriteVector(plycolor)
		net.SendToServer()
		pModel:Remove()
	end
end
concommand.Add("tea_changemodel", function()
	GAMEMODE:ModelMenu()
end)
