---------------- Scoreboard ----------------

function CalculateMaxWeightClient()
	local maxweight = 0
	local defaultcarryweight = GAMEMODE.Config["MaxCarryWeight"]
	local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]
	if LocalPlayer():GetNWString("ArmorType") == "none" then
		maxweight = defaultcarryweight + (tonumber(MyPrestige) >= 6 and 5 or tonumber(MyPrestige) >= 3 and 2 or 0) + ((Perks.Strength or 0) * 1.53)
	else
		maxweight = defaultcarryweight + (tonumber(MyPrestige) >= 6 and 5 or tonumber(MyPrestige) >= 3 and 2 or 0) + ((Perks.Strength or 0) * 1.53) + armortype["ArmorStats"]["carryweight"]
	end
	return maxweight
end

	
function CalculateVaultClient()
	local totalweight = 0
	for k, v in pairs(LocalVault) do
		totalweight = totalweight + (v.Weight * v.Qty)
	end
	return totalweight
end
	
	
surface.CreateFont("QtyFont", {
	font = "Trebuchet MS",
	size = 24,
	weight = 500,
	antialias = true,
})


LocalFactions = LocalFactions or {}

if !LocalFactions["Loner"] then LocalFactions["Loner"] = 
	{
		["index"] = 1,
		["color"] = Color(100, 50, 50, 255),
		["public"] = true,
		["leader"] = nil
	}
end


net.Receive("UpdateStatistics", function(length)
	local st1 = net.ReadFloat()
	local st2 = net.ReadFloat()
	local st3 = net.ReadFloat()
	local st4 = net.ReadFloat()
	local st5 = net.ReadFloat()
	local st6 = net.ReadFloat()
	local st7 = net.ReadFloat()
	local st8 = net.ReadFloat()

	MyBestsurvtime = st1
	MyZmbskilled = st2
	MyPlyskilled = st3
	MyPlydeaths = st4
	MyMMeleexp = st5
	MyMMeleelvl = st6
	MyMPvpxp = st7
	MyMPvplvl = st8
end)

net.Receive("UpdatePerks", function(length)
	local s1 = net.ReadFloat()
	local s2 = net.ReadFloat()
	local s3 = net.ReadFloat()
	local s4 = net.ReadFloat()
	local s5 = net.ReadFloat()
	local s6 = net.ReadFloat()
	local s7 = net.ReadFloat()
	local s8 = net.ReadFloat()
	local s9 = net.ReadFloat()
	local s10 = net.ReadFloat()
	local s11 = net.ReadFloat()
	local s12 = net.ReadFloat()
	local s13 = net.ReadFloat()
	local s14 = net.ReadFloat()

	Perks.Defense = s1
	Perks.Damage = s2
	Perks.Speed = s3
	Perks.Vitality = s4
	Perks.Knowledge = s5
	Perks.MedSkill = s6
	Perks.Strength = s7
	Perks.Endurance = s8
	Perks.Salvage = s9
	Perks.Barter = s10
	Perks.Engineer = s11
	Perks.Immunity = s12
	Perks.Survivor = s13
	Perks.Agility = s14
end)


net.Receive("UpdateInventory", function(length)
	local data = net.ReadTable()
	table.Empty(LocalInventory)

	for k, v in pairs(data) do
		if !GAMEMODE.ItemsList[k] then continue end
		local ref = GAMEMODE.ItemsList[k]

		LocalInventory[k] = {
			["Name"] = ref.Name,
			["Cost"] = ref.Cost,
			["Model"] = ref.Model,
			["Description"] = ref.Description,
			["Weight"] = ref.Weight,
			["Rarity"] = ref.Rarity,
			["Qty"] = v,
		}
	end
end)

net.Receive("UpdateVault", function(length)
	local data = net.ReadTable()
	table.Empty(LocalVault)

	for k, v in pairs(data) do
		if !GAMEMODE.ItemsList[k] then continue end
		local ref = GAMEMODE.ItemsList[k]

		LocalVault[k] = {
			["Name"] = ref.Name,
			["Cost"] = ref.Cost,
			["Model"] = ref.Model,
			["Description"] = ref.Description,
			["Weight"] = ref.Weight,
			["Rarity"] = ref.Rarity,
			["Qty"] = v,
		}
	end
end)

net.Receive("RecvFactions", function(length, client)
	local data = net.ReadTable()

	table.Empty(LocalFactions)
-- put the loner faction back in since it can never be deleted
	LocalFactions["Loner"] = 
		{
			["index"] = 1,
			["color"] = Color(100, 50, 50, 255),
			["public"] = true,
			["leader"] = nil
		}
	table.Merge(LocalFactions, data)
	for k, v in pairs(LocalFactions) do
		team.SetUp(v.index, k, v.color, v.public)
	end
end)


function CalculateWeightClient()
	local totalweight = 0 
	for k, v in pairs(LocalInventory) do
		totalweight = totalweight + (v.Weight * v.Qty)
	end
	return totalweight
end


ScoreBoard = {}

function ScoreBoard:Create()
	ScoreBoardFrame = vgui.Create("DFrame")
	ScoreBoardFrame:SetSize(1000, 700)
	ScoreBoardFrame:Center()
	ScoreBoardFrame:SetTitle ("")
	ScoreBoardFrame:SetDraggable(false)
	ScoreBoardFrame:SetVisible(true)
	ScoreBoardFrame:ShowCloseButton(false)
	ScoreBoardFrame:MakePopup()
	ScoreBoardFrame.Paint = function()
		draw.RoundedBox(2, 0, 0, ScoreBoardFrame:GetWide(), ScoreBoardFrame:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, ScoreBoardFrame:GetWide(), ScoreBoardFrame:GetTall())
		surface.DrawOutlinedRect(ScoreBoardFrame:GetWide() - 260, 25, 250, 201)
		surface.DrawOutlinedRect(ScoreBoardFrame:GetWide() - 260, 230, 250, 100)
		surface.SetDrawColor(0, 0, 0 ,155)
		surface.DrawRect(ScoreBoardFrame:GetWide() - 260, 25, 250, 205)
		surface.DrawRect(ScoreBoardFrame:GetWide() - 260, 230, 250, 100)
		local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
		local armortype = GAMEMODE.ItemsList[armorstr]
		if armorstr and armortype then
			draw.SimpleText(translate.Format("cur_armor", translate.Get(armorstr.."_n")), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", armortype["ArmorStats"]["reduction"], armortype["ArmorStats"]["reduction"] + ((Perks.Defense or 0) * 1.5)), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", armortype["ArmorStats"]["env_reduction"], armortype["ArmorStats"]["env_reduction"] + ((Perks.Defense or 0) * 1)), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(armortype["ArmorStats"]["speedloss"] < 0 and translate.Get("armorspeed")..": Increased ("..-(armortype["ArmorStats"]["speedloss"] / 10)..")" or armortype["ArmorStats"]["speedloss"] == 0 and translate.Get("armorspeed")..": None" or translate.Get("armorspeed")..": Decreased (-"..(armortype["ArmorStats"]["speedloss"] / 10)..")", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(armortype["ArmorStats"]["carryweight"] > 0 and translate.Format("armormaxweight", "+", armortype["ArmorStats"]["carryweight"]) or armortype["ArmorStats"]["carryweight"] >= 0 and translate.Format("armormaxweight", "+", armortype["ArmorStats"]["carryweight"]) or translate.Format("armormaxweight", "", armortype["ArmorStats"]["carryweight"]), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 295, Color(255,255,175,255))
		else
			draw.SimpleText(translate.Get("noarmor"), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", 0, (Perks.Defense or 0) * 1.5), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", 0, (Perks.Defense or 0) * 1), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(translate.Get("armorspeed")..": None", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(translate.Format("armormaxweight", "+", "0"), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 295, Color(255,235,205,255))
		end
		draw.SimpleText( translate.Format("pts", math.floor(MySP)), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 310, Color(205, 205, 205, 255))
	end
	
	
-----------------------------------------Main Sheet---------------------------------------------------------------
	local PropertySheet = vgui.Create("DPropertySheet")
	PropertySheet:SetParent(ScoreBoardFrame)
	PropertySheet:SetPos(0, 0)
	PropertySheet:SetSize(730, ScoreBoardFrame:GetTall())
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25,205))
			end
		end
	end
	


	
-----------------------------------------Inventory---------------------------------------------------------------

	local InvForm = vgui.Create("DForm", PropertySheet)
	InvForm:SetSize(675, 700)
	InvForm:SetPadding(4)
	InvForm:SetName("Items")
	InvForm.Paint = function()
		draw.RoundedBox(2, 0, 0, InvForm:GetWide(), InvForm:GetTall(), Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, InvForm:GetWide(), InvForm:GetTall())
	end

	local TheListPanel = vgui.Create("DPanelList", InvForm)
	TheListPanel:SetTall(635)
	TheListPanel:SetWide(980)
	TheListPanel:SetPos(5, 25)
	TheListPanel:EnableVerticalScrollbar(true)
	TheListPanel:EnableHorizontal(true)
   	TheListPanel:SetSpacing(5)


	local function DoInvPanel()
		InvForm:SetName(translate.Format("weight_1", CalculateWeightClient()).."    "..translate.Format("weight_2", CalculateMaxWeightClient()))
		for k, v in SortedPairsByMemberValue(LocalInventory, "Weight", true) do
			local raretext,rarecol = tea_CheckItemRarity(v.Rarity)
			local ItemBackground = vgui.Create("DPanel")
			ItemBackground:SetPos(5, 5)
			ItemBackground:SetSize(350, 65)
			ItemBackground.Paint = function() -- Paint function
				surface.SetDrawColor(75, 75, 75 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
				surface.SetDrawColor(0, 0, 0 ,200)
				surface.DrawRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
			end

			local ItemDisplay = vgui.Create("SpawnIcon", ItemBackground)
			ItemDisplay:SetPos(5, 5)
			ItemDisplay:SetModel(v.Model)
			ItemDisplay:SetToolTip(translate.Format("item_descr_1", translate.Get(k.."_d"), k, v.Cost, GAMEMODE.Config["Currency"], raretext))
			ItemDisplay:SetSize(60,60)
			ItemDisplay.PaintOver = function() return end
			ItemDisplay.OnMousePressed = function() return false end
			
			local ItemName = vgui.Create("DLabel", ItemBackground)
			ItemName:SetPos(80, 10)
			ItemName:SetFont("TargetIDSmall")
			ItemName:SetColor(rarecol)
			ItemName:SetText(translate.Get(k.."_n").." ("..v.Weight.."kg)")
			ItemName:SizeToContents()

			local ItemQty = vgui.Create("DLabel", ItemBackground)
			ItemQty:SetPos(300, 25)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SizeToContents()

			local EquipButton = vgui.Create("DButton", ItemBackground)
			EquipButton:SetSize(80, 20)
			EquipButton:SetPos(80, 35)
			EquipButton:SetText(translate.Get("use"))
			EquipButton:SetTextColor(Color(255, 255, 255, 255))
			EquipButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
				draw.RoundedBox(2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130))
			end
			EquipButton.DoClick = function()
				net.Start("UseItem")
				net.WriteString(k)
				net.WriteBool(true)
				net.SendToServer()
				timer.Simple(0.3, function() 
					if TheListPanel:IsValid() then
						TheListPanel:Clear()
						DoInvPanel()
					end
				end)
			end

			local DropButton = vgui.Create("DButton", ItemBackground)
			DropButton:SetSize(80, 20)
			DropButton:SetPos(170, 35)
			DropButton:SetText(translate.Get("drop"))
			DropButton:SetTextColor(Color(255, 255, 255, 255))
			DropButton.Paint = function(panel)
				surface.SetDrawColor(150, 75, 0 ,255)
				surface.DrawOutlinedRect(0, 0, DropButton:GetWide(), DropButton:GetTall())
				draw.RoundedBox(2, 0, 0, DropButton:GetWide(), DropButton:GetTall(), Color(50, 25, 0, 130))
			end
			DropButton.DoClick = function()
				net.Start("UseItem")
				net.WriteString(k)
				net.WriteBool(false)
				net.SendToServer()
				timer.Simple(0.3, function() 
					if TheListPanel:IsValid() then
						TheListPanel:Clear()
						DoInvPanel()
					end
				end)
			end
			TheListPanel:AddItem(ItemBackground)
		end
	end
	DoInvPanel()


	local Scores = vgui.Create("DPanelList", PropertySheet)
	Scores:SetSize(650, 400)
	Scores:SetPadding(5)
	Scores:SetSpacing(5)
	Scores:EnableHorizontal(false)
	Scores:EnableVerticalScrollbar(true)
	Scores:SetPos(10, 30)
	Scores:SetName("")

	local function SetUpScoreBoard()
		for k, v in pairs(player.GetAll()) do
			local plypanel = vgui.Create("DPanel", Scores)
			plypanel:SetPos(0, 100)
			plypanel:SetSize(570, 60)
			plypanel.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
				surface.SetDrawColor(150, 75, 75 ,255)
				surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
			end

			local plyname = vgui.Create("DLabel", plypanel)
			plyname:SetPos(62, 22)
			plyname:SetFont("TargetIDSmall")
			plyname:SetColor(Color(255,255,255,255))
			plyname:SetText(v:Nick())
			plyname:SizeToContents()

			local plyname2 = vgui.Create("DLabel", plypanel)
			plyname2:SetPos(240, 12)
			plyname2:SetFont("TargetIDSmall")
			plyname2:SetColor(team.GetColor(v:Team()))
			plyname2:SetText(translate.Format("faction", team.GetName(v:Team())))
			plyname2:SetSize(180, 15)

			local plylvl = vgui.Create("DLabel", plypanel)
			plylvl:SetPos(430, 12)
			plylvl:SetFont("TargetIDSmall")
			plylvl:SetColor(Color(255,255,255,255))
			plylvl:SetText("Lvl: "..v:GetNWInt("PlyLevel", 1))
			plylvl:SizeToContents()

			local plyping = vgui.Create("DLabel", plypanel)
			plyping:SetPos(510, 12)
			plyping:SetFont("TargetIDSmall")
			plyping:SetColor(Color(255,math.Clamp(255 - (0.5 * v:Ping()), 0, 255),math.Clamp(255 - (0.5 * v:Ping()), 0, 255),255))
			plyping:SetText(translate.Format("ping", v:Ping()))
			plyping:SizeToContents()

			local plyprestige = vgui.Create("DLabel", plypanel)
			plyprestige:SetPos(240, 32)
			plyprestige:SetFont("TargetIDSmall")
			plyprestige:SetColor(Color(255,127,255,255))
			plyprestige:SetText(translate.Format("prestige", v:GetNWInt("PlyPrestige", 0)))
			plyprestige:SizeToContents()

			local plykills = vgui.Create("DLabel", plypanel)
			plykills:SetPos(430, 32)
			plykills:SetFont("TargetIDSmall")
			plykills:SetColor(Color(255,255,255,255))
			plykills:SetText(translate.Format("frags", v:Frags()))
			plykills:SizeToContents()

			local plydeaths = vgui.Create("DLabel", plypanel)
			plydeaths:SetPos(510, 32)
			plydeaths:SetFont("TargetIDSmall")
			plydeaths:SetColor(Color(255,255,255,255))
			plydeaths:SetText(translate.Format("deaths", v:Deaths()))
			plydeaths:SizeToContents()


			local av = vgui.Create("AvatarImage", plypanel)
			av:SetPos(17,11)
			av:SetSize(40, 40)
			av:SetPlayer(v)
		
			plypanel.m_img = vgui.Create("DImage", plypanel)
			plypanel.m_img:SetPos(1, 22)
			plypanel.m_img:SetSize(16, 16)
			plypanel.m_img:SetMouseInputEnabled(true)
			plypanel.m_img:SetVisible(false)
			if gamemode.Call("IsSpecialPerson", v, plypanel.m_img) then
				plypanel.m_img:SetVisible(true)
			else
				plypanel.m_img:SetTooltip()
				plypanel.m_img:SetVisible(false)
			end


			local mutechat = vgui.Create("DButton", plypanel)
			mutechat:SetSize(45, 23)
			mutechat:SetPos(655, 7)
			mutechat:SetText(translate.Get("mute"))
			mutechat:SetTextColor(Color(255, 255, 255, 255))
			mutechat.Paint = function(panel)
				if v:IsValid() and v:IsMuted() then
					surface.SetDrawColor(150, 0, 0 ,255)
					surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					surface.SetDrawColor(100, 0, 0 ,155)
					surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					mutechat:SetToolTip("Player is muted")
				elseif v:IsValid() then
					surface.SetDrawColor(125, 125, 125 ,255)
					surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					surface.SetDrawColor(25, 25, 25 ,155)
					surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					mutechat:SetToolTip("Player is not muted")
				end
			end
			mutechat.DoClick = function()
				if v:IsValid() then
					v:SetMuted(!v:IsMuted())
				else
					chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
				end
				surface.PlaySound("buttons/button9.wav")
			end
			
			local profile = vgui.Create("DButton", plypanel)
			profile:SetSize(45, 23)
			profile:SetPos(655, 32)
			profile:SetText(translate.Get("profile"))
			profile:SetToolTip("See their profile")
			profile:SetTextColor(Color(255, 255, 255, 255))
			profile.Paint = function(panel)
				surface.SetDrawColor(0, 0, 100 ,255)
				surface.DrawOutlinedRect(0, 0, profile:GetWide(), profile:GetTall())
				surface.SetDrawColor(0, 0, 50 ,155)
				surface.DrawRect(0, 0, profile:GetWide(), profile:GetTall())
			end
			profile.DoClick = function()
				if v:IsValid() then
					v:ShowProfile()
				else
					chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
				end
				surface.PlaySound("buttons/button7.wav")
			end

			local checkstats = vgui.Create("DButton", plypanel)
			checkstats:SetSize(40, 22)
			checkstats:SetPos(610, 33)
			checkstats:SetText("Stats")
			checkstats:SetToolTip("See the statistics of a player")
			checkstats:SetTextColor(Color(55, 255, 255, 255))
			checkstats.Paint = function(panel)
				surface.SetDrawColor(0, 100, 100 ,255)
				surface.DrawOutlinedRect(0, 0, checkstats:GetWide(), checkstats:GetTall())
				surface.SetDrawColor(0, 50, 50 ,155)
				surface.DrawRect(0, 0, checkstats:GetWide(), checkstats:GetTall())
			end
			checkstats.DoClick = function()
				if v:IsValid() then
					if ButtonCD then return end
					net.Start("UpdateTargetStats")
					net.WriteEntity(v)
					net.SendToServer()
					StatsMenu()
					ButtonCD = true
					timer.Simple(1, function() ButtonCD = false end) 
				else
					chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
				end
				surface.PlaySound("buttons/button9.wav")
			end

	
			local pvp = vgui.Create("DPanel", plypanel)
			pvp:SetPos(610, 7)
			pvp:SetSize(40, 24)
			pvp.Paint = function() -- Paint function
				surface.SetDrawColor(150, 0, 0 ,255)
				surface.DrawOutlinedRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
				surface.SetDrawColor(100, 0, 0 ,105)
				if v:IsValid() then
					if v:Team() == 1 and v:GetNWBool("pvp") == false then
						draw.DrawText(translate.Get("pvp"), "DermaDefault", 12, 5, Color(55,55,55))
						pvp:SetToolTip("PVP DISABLED")
					else
						draw.DrawText(translate.Get("pvp"), "DermaDefault", 12, 5, Color(255,255,255))
						surface.DrawRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
						pvp:SetToolTip("PVP ENABLED")
					end
				end
			end
			Scores:AddItem(plypanel)	
		end
	end
	SetUpScoreBoard()
	local function RefreshScores() 
		timer.Simple(2, function()
			if !IsValid(Scores) then return end
			Scores:Clear()
			SetUpScoreBoard()
			RefreshScores()
		end)
	end
	RefreshScores()


---------------- Join Faction ----------------

	local FactionList = vgui.Create("DPanelList", PropertySheet)
	FactionList:SetSize(650, 250)
	FactionList:SetPadding(5)
	FactionList:SetSpacing(5)
	FactionList:EnableHorizontal(false)
	FactionList:EnableVerticalScrollbar(true)
	FactionList:SetPos(10, 80)
	FactionList:SetName("")

	local plypanel2 = vgui.Create("DPanel", FactionList)
	plypanel2:SetPos(0, 0)
	plypanel2:SetSize(570, 40)
	plypanel2.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel2:GetWide(),plypanel2:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel2:GetWide() - 1 , plypanel2:GetTall() - 1)
	end

	local createfaction = vgui.Create("DButton", plypanel2)
	createfaction:SetSize(160, 25)
	createfaction:SetPos(70, 8)
	createfaction:SetText(translate.Get("createfaction"))
	createfaction:SetTextColor(Color(255, 255, 255, 255))
	createfaction.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, createfaction:GetWide(), createfaction:GetTall())
		surface.SetDrawColor(50, 50, 0 ,155)
		surface.DrawRect(0, 0, createfaction:GetWide(), createfaction:GetTall())
	end
	createfaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_createfaction")
		RunConsoleCommand("-score")
	end

	local managefaction = vgui.Create("DButton", plypanel2)
	managefaction:SetSize(160, 25)
	managefaction:SetPos(270, 8)
	managefaction:SetText(translate.Get("managefaction"))
	managefaction:SetTextColor(Color(255, 255, 255, 255))
	managefaction.Paint = function(panel)
		surface.SetDrawColor(150, 50, 150 ,255)
		surface.DrawOutlinedRect(0, 0, managefaction:GetWide(), managefaction:GetTall())
		surface.SetDrawColor(50, 25, 50 ,155)
		surface.DrawRect(0, 0, managefaction:GetWide(), managefaction:GetTall())
	end
	managefaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_managefaction")
		RunConsoleCommand("-score")
	end

	local leavefaction = vgui.Create("DButton", plypanel2)
	leavefaction:SetSize(160, 25)
	leavefaction:SetPos(470, 8)
	leavefaction:SetText(translate.Get("leavefaction"))
	leavefaction:SetTextColor(Color(255, 255, 255, 255))
	leavefaction.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, leavefaction:GetWide(), leavefaction:GetTall())
		surface.SetDrawColor(50, 0, 0 ,155)
		surface.DrawRect(0, 0, leavefaction:GetWide(), leavefaction:GetTall())
	end
	leavefaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_leavefaction")
		RunConsoleCommand("-score")	
	end

	FactionList:AddItem(plypanel2)

	for k, v in pairs(LocalFactions) do
		if team.NumPlayers(v.index) == 0 then continue end -- ignore empty teams

		local plypanel = vgui.Create("DPanel", FactionList)
		plypanel:SetPos(0, 0)
		plypanel:SetSize(570, 40)
		plypanel.Paint = function() -- Paint function
			draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
			surface.SetDrawColor(150, 150, 0 ,255)
			surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
			surface.SetDrawColor(team.GetColor(v.index))
			surface.DrawRect(5, 5,30,30)
			surface.SetDrawColor(0,0,0,255)
			surface.DrawOutlinedRect(4, 4, 32, 32)
		end

		local plyname = vgui.Create("DLabel", plypanel)
		plyname:SetPos(45, 12)
		plyname:SetFont("TargetIDSmall")
		plyname:SetColor(Color(255,255,255,255))
		plyname:SetText(k)
		plyname:SetSize(180, 15)

		local facleader = vgui.Create("DLabel", plypanel)
		facleader:SetPos(220, 12)
		facleader:SetFont("TargetIDSmall")
		facleader:SetColor(Color(255,255,255,255))
		if v.leader and v.leader:IsValid() then
			facleader:SetText(translate.Get("leader")..": "..v.leader:Nick() or "N/A")
		else
			facleader:SetText(translate.Get("leader")..": N/A")
		end
		facleader:SetSize(200, 15)

		local members = vgui.Create("DLabel", plypanel)
		members:SetPos(400, 12)
		members:SetFont("TargetIDSmall")
		members:SetColor(Color(255,255,255,255))
		members:SetText(translate.Get("members")..": "..team.NumPlayers(v.index))
		members:SizeToContents()

		local public = vgui.Create("DLabel", plypanel)
		public:SetPos(500, 12)
		public:SetFont("TargetIDSmall")
		public:SetColor(Color(255,255,255,255))
		public:SetText(v.public and "Public: Yes" or "Public: No")
		public:SizeToContents()

		local joinfaction = vgui.Create("DButton", plypanel)
		joinfaction:SetSize(80, 25)
		joinfaction:SetPos(610, 8)
		joinfaction:SetText(translate.Get("joinfaction"))
		joinfaction:SetTextColor(Color(255, 255, 255, 255))
		joinfaction.Paint = function(panel)
			surface.SetDrawColor(150, 0, 0 ,255)
			surface.DrawOutlinedRect(0, 0, joinfaction:GetWide(), joinfaction:GetTall())
			surface.SetDrawColor(50, 0, 0 ,155)
			surface.DrawRect(0, 0, joinfaction:GetWide(), joinfaction:GetTall())
		end
		joinfaction.DoClick = function()
			surface.PlaySound("buttons/button9.wav")
			net.Start("JoinFaction")
			net.WriteString(k)
			net.SendToServer()
		end
		FactionList:AddItem(plypanel)
	end
	
--------------------------Help Form------------------------------------

	local HelpForm = vgui.Create("DPanel", PropertySheet)
	HelpForm:SetSize(675, 700)
	HelpForm.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleText("Welcome to The Eternal Apocalypse. Also known as After The End Reborn.", "TargetIDSmall", 10, 10, Color(255,255,255,255))
		draw.SimpleText(Format("Server name: %s | Players: %s / %s", GetHostName(), player.GetCount(), game.MaxPlayers()), "TargetIDSmall", 10, 28, Color(255,255,255))
		draw.SimpleText("In this gamemode:", "TargetIDSmall", 10, 60, Color(155,155,155,255))
		draw.SimpleText("Most zombies are buffed, new weapons are added. Unused/Cut items are added.", "TargetIDSmall", 10, 90, Color(155,155,155,255))
		draw.SimpleText("Health Regen function has also been reworked. But it regenerates less health,", "TargetIDSmall", 10, 110, Color(155,155,155,255))
		draw.SimpleText("so you gotta carry more meds. Same thing applies for Weight system. 36.72 kg (by default)", "TargetIDSmall", 10, 130, Color(155,155,155,255))
		draw.SimpleText("as carry weight, +1.53kg per Strength skill (by default). The way how you play this", "TargetIDSmall", 10, 150, Color(155,155,155,255))
		draw.SimpleText("gamemode is also the same like in After The End/Zombie Survival RPG. Barter skill", "TargetIDSmall", 10, 170, Color(155,155,155,255))
		draw.SimpleText("is nerfed, you get less cash for selling items to traders. Bounty loss on death is", "TargetIDSmall", 10, 190, Color(155,155,155,255))
		draw.SimpleText("more than in vanilla, most likely you drop cash between of 30-40% bounty. Also,", "TargetIDSmall", 10, 210, Color(155,155,155,255))
		draw.SimpleText("minimum amount of players required for boss is reduced to 2 and for airdrop", "TargetIDSmall", 10, 230, Color(155,155,155,255))
		draw.SimpleText("is increased to 5. In addition, Prestiging system is added. For more info about prestige", "TargetIDSmall", 10, 250, Color(155,155,155,255))
		draw.SimpleText("hold C and press 'Prestige'.", "TargetIDSmall", 10, 270, Color(155,155,155,255))
		draw.SimpleText("F1 (gm_showhelp): [Function Not Implemented]", "TargetIDSmall", 10, 380, Color(155,255,255,255))
		draw.SimpleText("F2 (gm_showteam): Open Administration Panel (works for admins only)", "TargetIDSmall", 10, 400, Color(155,255,255,255))
		draw.SimpleText("F3 (gm_showspare1): Open Drop Money Panel", "TargetIDSmall", 10, 420, Color(155,255,255,255))
		draw.SimpleText("F4 (gm_showspare2): Open Options Menu panel", "TargetIDSmall", 10, 440, Color(155,255,255,255))
		draw.SimpleText("Just a few more notes:", "TargetIDSmall", 10, 480, Color(155,255,155,255))
		draw.SimpleText("- You can change your HUD Style you like with client ConVar tea_cl_hudstyle", "TargetIDSmall", 10, 530, Color(205,205,205,255))
		draw.SimpleText("- Gamemode works the same as ZsRPG and AtE, but most of its' functions are changed", "TargetIDSmall", 10, 550, Color(255,255,155,255))
		draw.SimpleText("- SELECTING BUILD TOOL FOR FIRST TIME IN SESSION HAS A CHANCE TO CRASH YOUR GAME!!", "TargetIDSmall", 10, 570, Color(255,55,55,255))
		draw.SimpleText("(Couldn't fix, but more likely to happen later, so equip that weapon on joining)", "TargetIDSmall", 10, 590, Color(255,55,55,255))
		draw.SimpleText("- If you encounter any problem, error, or any kind of mistranslation, report it to the dev.", "TargetIDSmall", 10, 610, Color(255,155,155,255))
		draw.SimpleText("Good hunting. (this panel may be changed every update)", "TargetIDSmall", 10, 635, Color(155,255,155,255))
	end

-----------------Craft Form (not finished and not included)-----------------------


	local CraftForm = vgui.Create("DPanel", PropertySheet)
	CraftForm:SetSize(675, 700)
	CraftForm.Paint = function(self,w,h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0,100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local CraftablesPanel = vgui.Create("DPanelList", CraftForm)
	CraftablesPanel:SetTall(635)
	CraftablesPanel:SetWide(755)
	CraftablesPanel:SetPos(5, 10)
	CraftablesPanel:EnableVerticalScrollbar(true)
	CraftablesPanel:EnableHorizontal(true)
   	CraftablesPanel:SetSpacing(5)

	local function DoCraftablesList()
		for k,v in SortedPairs(GAMEMODE.CraftableList) do
			if !GAMEMODE.ItemsList[k] then continue end
			local raretext,rarecol = tea_CheckItemRarity(GAMEMODE.ItemsList[k]["Rarity"])

			local ItemBG = vgui.Create("DPanel", CraftablesPanel)
			ItemBG:SetPos(5, 5)
			ItemBG:SetSize(345, 80)
			ItemBG.Paint = function() -- Paint function
				draw.RoundedBoxEx(8, 1, 1, ItemBG:GetWide() - 2, ItemBG:GetTall() - 2, Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBG:GetWide(), ItemBG:GetTall())
			end
	
			local ItemDisplay = vgui.Create("SpawnIcon", ItemBG)
			ItemDisplay:SetPos(8, 8)
			ItemDisplay:SetModel(v.Model)
			ItemDisplay:SetToolTip(translate.Format("item_descr_3", translate.Get(k.."_d"), translate.Get("itemid"), raretext))
			ItemDisplay:SetSize(64,64)
			ItemDisplay.PaintOver = function() return end
			ItemDisplay.OnMousePressed = function() return false end

			local ItemName = vgui.Create("DLabel", ItemBG)
			ItemName:SetPos(85, 10)
			ItemName:SetSize(180, 15)
			ItemName:SetColor(rarecol)
			ItemName:SetText(translate.Get(k.."_n"))

			local ItemWeight = vgui.Create("DLabel", ItemBG)
			ItemWeight:SetFont("TargetIDSmall")
			ItemWeight:SetPos(85, 26)
			ItemWeight:SetSize(170, 15)
			ItemWeight:SetColor(Color(155,155,255,255))
			ItemWeight:SetText("Weight: ".. GAMEMODE.ItemsList[k]["Weight"].."kg")

			local XPCraft = vgui.Create("DLabel", ItemBG)
			XPCraft:SetFont("TargetIDSmall")
			XPCraft:SetPos(85, 42)
			XPCraft:SetSize(170, 15)
			XPCraft:SetColor(Color(155,255,255,255))
			XPCraft:SetText("XP: "..v.XP)

			local TimeCraft = vgui.Create("DLabel", ItemBG)
			TimeCraft:SetFont("TargetIDSmall")
			TimeCraft:SetPos(85, 58)
			TimeCraft:SetSize(170, 15)
			TimeCraft:SetColor(Color(255,255,155,255))
			TimeCraft:SetText("Craft Time: "..v.CraftTime.."s")

			local ReqButton = vgui.Create("DButton", ItemBG)
			ReqButton:SetSize(100, 20)
			ReqButton:SetPos(235, 20)
			ReqButton:SetText("Requirements")
			ReqButton:SetToolTip("Gets list of required items to craft this item")
			ReqButton:SetTextColor(Color(255, 255, 255, 255))
			ReqButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, ReqButton:GetWide(), ReqButton:GetTall())
				draw.RoundedBox(2, 0, 0, ReqButton:GetWide(), ReqButton:GetTall(), Color(0, 50, 0, 130))
			end
			ReqButton.DoClick = function()
				chat.AddText(Color(0,192,192), "Required Items to craft item '"..translate.Get(k.."_n").."':")
				for r,q in pairs(GAMEMODE.CraftableList[k]["Requirements"]) do
					chat.AddText(Color(0,192,255), "	"..q.."x "..translate.Get(r.."_n"))
				end
			end

			local CraftButton = vgui.Create("DButton", ItemBG)
			CraftButton:SetSize(100, 20)
			CraftButton:SetPos(235, 50)
			CraftButton:SetText("Craft!")
			CraftButton:SetToolTip("Begin crafting an item. Crafting takes time and may give XP if craft is successful.\nNote: Knowledge skill applies to gaining XP by crafting an item.")
			CraftButton:SetTextColor(Color(255, 255, 255, 255))
			CraftButton.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, CraftButton:GetWide(), CraftButton:GetTall())
				draw.RoundedBox(2, 0, 0, CraftButton:GetWide(), CraftButton:GetTall(), Color(0, 50, 0, 130))
			end
			CraftButton.DoClick = function()
				net.Start("CraftItem")
				net.WriteString(k)
				net.SendToServer()
			end
			CraftablesPanel:AddItem(ItemBG)
		end
	end
	DoCraftablesList()


---------------Statistics Form------------------

	local StatisticsForm = vgui.Create("DPanel", PropertySheet)
	StatisticsForm:SetSize(675, 700)
	StatisticsForm.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleText(translate.Format("timesurvived", math.floor(CurTime() - MySurvivaltime)), "TargetID", 15, 10, Color(255,255,255,255))
		draw.SimpleText("Best Survival Time: "..MyBestsurvtime.."s", "TargetID", 15, 35, Color(255,255,255,255))
		draw.SimpleText("Zombies Killed in Total: "..MyZmbskilled, "TargetID", 15, 60, Color(255,255,255,255))
		draw.SimpleText("Players killed in Total: "..MyPlyskilled, "TargetID", 15, 85, Color(255,255,255,255))
		draw.SimpleText("Your Deaths in Total: "..MyPlydeaths, "TargetID", 15, 110, Color(255,255,255,255))

		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 165, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 165, 200, 8)
	
		local bar1 = math.Clamp( 200 * (MyMMeleexp / GetReqMasteryMeleeXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 165, bar1, 8)

		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 210, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 210, 200, 8)
	
		local bar2 = math.Clamp( 200 * (MyMPvpxp / GetReqMasteryPvPXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 210, bar2, 8 )
	end

	local sttext1 = vgui.Create("DLabel", StatisticsForm)
	sttext1:SetFont("TargetID")
	sttext1:SetTextColor(Color(205,205,205,255))
	sttext1:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")")
	sttext1:SetToolTip("Increases melee damage by 0.5% per level, increases when doing melee damage to zombies. \nGain rate is DECREASED when damaging players with melee weapons.")
	sttext1:SetMouseInputEnabled(true)
	sttext1:SizeToContents()
	sttext1:SetPos(15, 140)

	local sttext2 = vgui.Create("DLabel", StatisticsForm)
	sttext2:SetFont("TargetID")
	sttext2:SetTextColor(Color(205,205,205,255))
	sttext2:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")")
	sttext2:SetToolTip("Gained from killing players. (no other benefits other than money gain on level up)\nGain rate increased when they have higher level and prestige.")
	sttext2:SetMouseInputEnabled(true)
	sttext2:SizeToContents()
	sttext2:SetPos(15, 185)

	timer.Create("UpdateStatisticsScoreBoard", 0, 0, function()
		if IsValid(ScoreBoardFrame) then
			sttext1:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")") sttext1:SizeToContents()
			sttext2:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")") sttext2:SizeToContents()
		else
			timer.Destroy("UpdateStatisticsScoreBoard")
		end
	end)



---------------Achievements Form------------------
/*
	local AchsForm = vgui.Create("DPanel", PropertySheet)
	AchsForm:SetSize(675, 700)
	AchsForm.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.SimpleText("NO!", "TargetID", 15, 10, Color(255,192,0,255))
	end
*/
------------------------------------Sheets----------------------------------------
	PropertySheet:AddSheet(translate.Get("sb_sheet1"), InvForm, "icon16/basket.png", false, false, translate.Get("sb_sheet1_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet2"), FactionList, "icon16/user_red.png", false, false, translate.Get("sb_sheet2_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet3"), Scores, "icon16/group.png", false, false, translate.Get("sb_sheet3_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet4"), HelpForm, "icon16/note.png", false, false, translate.Get("sb_sheet4_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet5"), CraftForm, "icon16/wrench_orange.png", false, false, translate.Get("sb_sheet5_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet6"), StatisticsForm, "icon16/user.png", false, false, translate.Get("sb_sheet6_d"))
--	PropertySheet:AddSheet(translate.Get("sb_sheet7"), AchsForm, "icon16/award_star_silver_3.png", false, false, translate.Get("sb_sheet7_d"))



-----------------------------------------Stats Sheet---------------------------------------------------------------
	SecondarySheet = vgui.Create("DPropertySheet")
	SecondarySheet:SetParent(ScoreBoardFrame)
	SecondarySheet:SetPos(ScoreBoardFrame:GetWide() - 260, 330)
	SecondarySheet:SetSize(250, ScoreBoardFrame:GetTall() - 335)
	SecondarySheet.Paint = function()
		draw.RoundedBox(2, 0, 0, SecondarySheet:GetWide(), SecondarySheet:GetTall(), Color(0, 0, 0, 100))
		for k, v in pairs(SecondarySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	
-----------------------------------------Stats Form---------------------------------------------------------------
	local StatsForm = vgui.Create("DPanelList", ScoreBoardFrame)
	StatsForm:SetSize(675, 600)
	StatsForm:SetPos(0, 0)
	StatsForm:EnableVerticalScrollbar(true)
	StatsForm:SetSpacing(10)
	StatsForm.Paint = function()
		surface.SetDrawColor(0, 0, 0 ,100)
		surface.DrawRect(0, 0, StatsForm:GetWide(), StatsForm:GetTall())
	end
	StatsForm.VBar.Paint = function()
		draw.RoundedBox(2, 0, 0, StatsForm.VBar:GetWide(), StatsForm.VBar:GetTall(), Color(30, 30, 30, 50))
	end
	StatsForm.VBar.btnGrip.Paint = function()
		draw.RoundedBox(2, 0, 0, StatsForm.VBar.btnGrip:GetWide(), StatsForm.VBar.btnGrip:GetTall(), Color(40, 40, 0, 50))
	end
	
	local ModelInfo = vgui.Create("DModelPanel", ScoreBoardFrame)
	ModelInfo:SetSize(200, 200)
	ModelInfo:SetPos(ScoreBoardFrame:GetWide() - 240, 25)
	ModelInfo:SetModel(LocalPlayer():GetModel())
	ModelInfo:SetAnimSpeed(1)
	ModelInfo:SetAnimated(true)
	ModelInfo:SetAmbientLight(Color(50, 50, 50))
	ModelInfo:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	ModelInfo:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
	ModelInfo:SetCamPos(Vector(50, 0, 50))
	ModelInfo:SetLookAt(Vector(0, 0, 40))
	ModelInfo:SetFOV(80)
	function ModelInfo.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end

	local ModelButton = vgui.Create("DButton", ScoreBoardFrame)
	ModelButton:SetSize(90, 20)
	ModelButton:SetPos(ScoreBoardFrame:GetWide() - 100, 25)
	ModelButton:SetText(translate.Get("changemodel"))
	ModelButton:SetToolTip("Change your look")
	ModelButton:SetTextColor(Color(255, 255, 255, 255))
	ModelButton.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, ModelButton:GetWide(), ModelButton:GetTall())
		draw.RoundedBox(2, 0, 0, ModelButton:GetWide(), ModelButton:GetTall(), Color(50, 50, 0, 130))
	end
	ModelButton.DoClick = function()
		RunConsoleCommand("tea_changemodel")
		RunConsoleCommand("-score")
	end

	function ModelInfo.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end
	local function DoStatsList()
		for k, v in SortedPairs(Perks) do
			local LabelDefense = vgui.Create("DLabel")
			LabelDefense:SetPos(50, 50)
			LabelDefense:SetText(translate.Get(k).." : "..v)
			LabelDefense:SetToolTip(translate.Get(k.."_d"))
			LabelDefense:SizeToContents()
			StatsForm:AddItem(LabelDefense)

			local Button = vgui.Create("DButton")
			Button:SetPos(50, 100)
			Button:SetSize(10, 20)
			Button:SetTextColor(Color(255, 255, 255, 255))
			Button:SetText(translate.Format("inc1stat", translate.Get(k)))
			Button:SetToolTip(translate.Get(k.."_d"))
			Button.DoClick = function(Button)
				net.Start("UpgradePerk")
				net.WriteString(k)
				net.SendToServer()
				timer.Simple(0.3, function()
					if StatsForm:IsValid() then
						StatsForm:Clear()
						DoStatsList()
					end
				end)
			end
			Button.Paint = function()
				local derp = v
				draw.RoundedBox(0, 0, 0, Button:GetWide(), Button:GetTall(), Color(30, 30, 30, 50))
				draw.RoundedBox(0, 0, 0, derp * 22.5, Button:GetTall(), Color(100, 100, 0, 150))
				surface.SetDrawColor(100, 100, 0 ,255)
				surface.DrawOutlinedRect(0, 0, Button:GetWide(), Button:GetTall())
			end
			StatsForm:AddItem(Button)
		end
	end
	DoStatsList()
	
/*-----------------------------------------PlayerModelSelect---------------------------------------------------------------
	local ArmorForm = vgui.Create("DForm", ScoreBoardFrame)
	ArmorForm:SetSize(675, 617)
	ArmorForm:SetPadding(4)
	ArmorForm:SetName("")


*/
-----------------------------------------Sheet List---------------------------------------------------------------
	SecondarySheet:AddSheet(translate.Get("sb_sheet1_1"), StatsForm, "icon16/heart.png", false, false, translate.Get("sb_sheet1_1_d"))
--	SecondarySheet:AddSheet("Armor and Attachments", ArmorForm, "icon16/shield.png", false, false, "NO")
end

function GM:CreateScoreboard()
	return false
end

function GM:ScoreboardShow()
	if IsValid(ScoreBoardFrame) then ScoreBoardFrame:Remove() end
	ScoreBoard:Create()
	ScoreBoardFrame:SetVisible(true)
	gui.EnableScreenClicker(true)
	ScoreBoardFrame:SetAlpha(0)
	ScoreBoardFrame:AlphaTo(255, 0.2, 0)
end

function GM:ScoreboardHide()
	if !IsValid(ScoreBoardFrame) then return end
	ScoreBoardFrame:SetVisible(false)
	ScoreBoardFrame:Remove()
	gui.EnableScreenClicker(false)
end
