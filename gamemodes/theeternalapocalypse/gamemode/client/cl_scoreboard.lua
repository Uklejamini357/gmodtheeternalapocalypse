---------------- Scoreboard ----------------

local DoInvPanel
local TheListPanel

LocalFactions = LocalFactions or {}

if !LocalFactions["Loner"] then LocalFactions["Loner"] = 
	{
		["index"] = TEAM_LONER,
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
/*
	local me = LocalPlayer()
	me.StatDefense = net.ReadFloat()
	me.StatGunslinger = net.ReadFloat()
	me.StatSpeed = net.ReadFloat()
	me.StatVitality = net.ReadFloat()
	me.StatKnowledge = net.ReadFloat()
	me.StatMedSkill = net.ReadFloat()
	me.StatStrength = net.ReadFloat()
	me.StatEndurance = net.ReadFloat()
	me.StatSalvage = net.ReadFloat()
	me.StatBarter = net.ReadFloat()
	me.StatEngineer = net.ReadFloat()
	me.StatImmunity = net.ReadFloat()
	me.StatSurvivor = net.ReadFloat()
	me.StatAgility = net.ReadFloat()
*/

	Perks.Defense = net.ReadFloat()
	Perks.Gunslinger = net.ReadFloat()
	Perks.Speed = net.ReadFloat()
	Perks.Vitality = net.ReadFloat()
	Perks.Knowledge = net.ReadFloat()
	Perks.MedSkill = net.ReadFloat()
	Perks.Strength = net.ReadFloat()
	Perks.Endurance = net.ReadFloat()
	Perks.Salvage = net.ReadFloat()
	Perks.Barter = net.ReadFloat()
	Perks.Engineer = net.ReadFloat()
	Perks.Immunity = net.ReadFloat()
	Perks.Survivor = net.ReadFloat()
	Perks.Agility = net.ReadFloat()
	Perks.Scavenging = net.ReadFloat()
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
			["ArmorStats"] = ref.ArmorStats,
			["ModelColor"] = ref.ModelColor,
		}
	end

	if DoInvPanel and TheListPanel and TheListPanel:IsValid() then
		TheListPanel:Clear()
		DoInvPanel()
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
			["ArmorStats"] = ref.ArmorStats,
			["ModelColor"] = ref.ModelColor,
		}
	end

	if DoInvPanel and TheListPanel and TheListPanel:IsValid() then
		TheListPanel:Clear()
		DoInvPanel()
	end
end)

net.Receive("RecvFactions", function(length, client)
	local data = net.ReadTable()

	table.Empty(LocalFactions)
-- put the loner faction back in since it can never be deleted
	LocalFactions["Loner"] = 
		{
			["index"] = TEAM_LONER,
			["color"] = Color(100, 50, 50, 255),
			["public"] = true,
			["leader"] = nil
		}
	table.Merge(LocalFactions, data)
	for k, v in pairs(LocalFactions) do
		team.SetUp(v.index, k, v.color, v.public)
	end
end)
/*
function CalculateMaxWeightClient()
	local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]

	return GAMEMODE.Config["MaxCarryWeight"] + (GAMEMODE.LocalPerks["weightboost"] and 1.5 or 0) + (GAMEMODE.LocalPerks["weightboost2"] and 2.5 or 0) + (GAMEMODE.LocalPerks["weightboost3"] and 3.5 or 0)
	+ ((Perks.Strength or 0) * 1.53) + (LocalPlayer():GetNWString("ArmorType") ~= "none" and armortype["ArmorStats"]["carryweight"] or 0)
end

function CalculateMaxWalkWeightClient()
	local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
	local armortype = GAMEMODE.ItemsList[armorstr]

	return GAMEMODE.Config["MaxCarryWeight"] + (GAMEMODE.LocalPerks["weightboost"] and 1.5 or 0) + (GAMEMODE.LocalPerks["weightboost2"] and 2.5 or 0) + (GAMEMODE.LocalPerks["weightboost3"] and 3.5 or 0)
	+ ((Perks.Strength or 0) * 1.53) + (LocalPlayer():GetNWString("ArmorType") ~= "none" and armortype["ArmorStats"]["carryweight"] or 0)
end

function CalculateVaultClient()
	local totalweight = 0
	for k, v in pairs(LocalVault) do
		totalweight = totalweight + (v.Weight * v.Qty)
	end
	return totalweight
end

function CalculateWeightClient()
	local totalweight = 0 
	for k, v in pairs(LocalInventory) do
		totalweight = totalweight + (v.Weight * v.Qty)
	end
	return totalweight
end
*/


function GM:CreateScoreboardInv()
	local me = LocalPlayer()

	ScoreBoardFrame = vgui.Create("DFrame")
	ScoreBoardFrame:SetSize(1000, 700)
	ScoreBoardFrame:Center()
	ScoreBoardFrame:SetTitle("")
	ScoreBoardFrame:SetDraggable(false)
	ScoreBoardFrame:SetVisible(true)
	ScoreBoardFrame:ShowCloseButton(false)
	ScoreBoardFrame:MakePopup()
	ScoreBoardFrame.Paint = function(self)
		draw.RoundedBox(2, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
		surface.DrawOutlinedRect(self:GetWide() - 260, 25, 250, 201)
		surface.DrawOutlinedRect(self:GetWide() - 260, 230, 250, 100)
		surface.SetDrawColor(0, 0, 0 ,155)
		surface.DrawRect(self:GetWide() - 260, 25, 250, 205)
		surface.DrawRect(self:GetWide() - 260, 230, 250, 100)
		local armorstr = me:GetNWString("ArmorType") or "none"
		local armortype = GAMEMODE.ItemsList[armorstr]
		if armorstr and armortype then
			draw.SimpleText(translate.Format("cur_armor", translate.Get(armorstr.."_n")), "TargetIDSmall", self:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", armortype["ArmorStats"]["reduction"], armortype["ArmorStats"]["reduction"] + ((Perks.Defense or 0) * 1.5)), "TargetIDSmall", self:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", armortype["ArmorStats"]["env_reduction"], armortype["ArmorStats"]["env_reduction"] + ((Perks.Defense or 0) * 1)), "TargetIDSmall", self:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(armortype["ArmorStats"]["speedloss"] < 0 and translate.Get("armorspeed")..": Increased ("..-(armortype["ArmorStats"]["speedloss"] / 10)..")" or armortype["ArmorStats"]["speedloss"] == 0 and translate.Get("armorspeed")..": None" or translate.Get("armorspeed")..": Decreased (-"..(armortype["ArmorStats"]["speedloss"] / 10)..")", "TargetIDSmall", self:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(armortype["ArmorStats"]["carryweight"] > 0 and translate.Format("armormaxweight", "+", armortype["ArmorStats"]["carryweight"]) or armortype["ArmorStats"]["carryweight"] >= 0 and translate.Format("armormaxweight", "+", armortype["ArmorStats"]["carryweight"]) or translate.Format("armormaxweight", "", armortype["ArmorStats"]["carryweight"]), "TargetIDSmall", self:GetWide() - 255, 295, Color(255,255,175,255))
		else
			draw.SimpleText(translate.Get("noarmor"), "TargetIDSmall", self:GetWide() - 255, 235, Color(255,255,255,255))
			draw.SimpleText(translate.Format("armorprot", 0, (Perks.Defense or 0) * 1.5), "TargetIDSmall", self:GetWide() - 255, 250, Color(205,255,205,255))
			draw.SimpleText(translate.Format("armor_envprot", 0, (Perks.Defense or 0) * 1), "TargetIDSmall", self:GetWide() - 255, 265, Color(255,230,255,255))
			draw.SimpleText(translate.Get("armorspeed")..": None", "TargetIDSmall", self:GetWide() - 255, 280, Color(205,205,255,255))
			draw.SimpleText(translate.Format("armormaxweight", "+", "0"), "TargetIDSmall", self:GetWide() - 255, 295, Color(255,235,205,255))
		end
		draw.SimpleText( translate.Format("pts", math.floor(MySP)), "TargetIDSmall", self:GetWide() - 255, 310, Color(205, 205, 205, 255))
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

	local InvForm = vgui.Create("DPanel", PropertySheet)
	InvForm:SetSize(675, 700)
	InvForm:SetName("Items")
	InvForm.Paint = function()
		draw.RoundedBox(2, 0, 0, InvForm:GetWide(), InvForm:GetTall(), Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, InvForm:GetWide(), InvForm:GetTall())
	end

	local InvWeightText = vgui.Create("DLabel", InvForm)
	InvWeightText:SizeToContents()
	InvWeightText:SetPos(5, 5)
	InvWeightText.Think = function(this)
		local changetxt = translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT)
		if changetxt == this:GetText() then return end
		this:SetText(changetxt)
		this:SizeToContents()
		this:SetTextColor(me:CalculateWeight() >= me:CalculateMaxWalkWeight() and Color(255,0,0) or me:CalculateWeight() >= LocalPlayer():CalculateMaxWeight() and Color(255,255,0) or Color(255,255,255))
	end
	InvWeightText:Think()
--	InvWeightText:SetFont()

	TheListPanel = vgui.Create("DPanelList", InvForm)
	TheListPanel:SetTall(635)
	TheListPanel:SetWide(980)
	TheListPanel:SetPos(5, 25)
	TheListPanel:EnableVerticalScrollbar(true)
	TheListPanel:EnableHorizontal(true)
   	TheListPanel:SetSpacing(5)


	DoInvPanel = function()
		if !ScoreBoardFrame:IsValid() then return end
		for k, v in SortedPairsByMemberValue(LocalInventory, "Weight", true) do
			local item = GAMEMODE.ItemsList[k]
			local raretbl = gamemode.Call("CheckItemRarity", v.Rarity)
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
			if v.ModelColor then
				ItemDisplay:SetColor(v.ModelColor)
			end
			ItemDisplay:SetToolTip(translate.Get(k.."_d")..(v["ArmorStats"] and "\n"..translate.Format("item_armor_descr", v.ArmorStats["reduction"] or 0, v.ArmorStats["env_reduction"] or 0, (-v.ArmorStats["speedloss"] or 0) / 10, v.ArmorStats["slots"] or 0, v.ArmorStats["battery"] or 0, v.ArmorStats["carryweight"] or 0) or "").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
			ItemDisplay:SetSize(60,60)
			ItemDisplay.PaintOver = function() return end
			ItemDisplay.OnMousePressed = function(this, mc)
				if mc == MOUSE_LEFT then
					local derma = DermaMenu()
					derma:AddOption("Item: "..translate.Get(k.."_n"), function() end)
					if item.CanUseOnOthers then
						local sub = derma:AddSubMenu("Use", function()
							net.Start("UseItem")
							net.WriteString(k)
							net.WriteBool(true)
							net.WriteEntity(me)
							net.SendToServer()
						end)
						for _,ply in pairs(ents.FindInSphere(me:GetPos(), 500)) do
							if ply:IsPlayer() and ply ~= me then
								sub:AddOption(ply:Nick(), function()
									net.Start("UseItem")
									net.WriteString(k)
									net.WriteBool(true)
									net.WriteEntity(ply)
									net.SendToServer()
								end)
							end
						end
					else
						derma:AddOption("Use", function()
							net.Start("UseItem")
							net.WriteString(k)
							net.WriteBool(true)
							net.WriteEntity(LocalPlayer())
							net.SendToServer()
						end)
					end
					derma:AddOption("Drop", function()
						net.Start("UseItem")
						net.WriteString(k)
						net.WriteBool(false)
						net.WriteEntity(me)
						net.SendToServer()
					end)
					derma:Open()
				end
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
			ItemQty:SetPos(290, 30)
			ItemQty:SetFont("QtyFont")
			ItemQty:SetColor(Color(255,255,255,255))
			ItemQty:SetText(v.Qty.."x")
			ItemQty:SetToolTip(v.Qty)
			ItemQty:SetMouseInputEnabled(true)
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

			local avbutton = vgui.Create("DButton", av)
			avbutton:SetSize(40, 40)
			avbutton:SetText("")
			avbutton.Paint = function()
			end
			avbutton.DoClick = function()
				local menu = DermaMenu()
				menu:AddOption("Check Player's Stats", function()
					if v:IsValid() then
						net.Start("UpdateTargetStats")
						net.WriteEntity(v)
						net.SendToServer()
						StatsMenu(v)
					else
						chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
					end
					surface.PlaySound("buttons/button9.wav")
				end)
				menu:AddOption("Player Profile", function()
					if v:IsValid() then
						v:ShowProfile()
					else
						chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
					end
					surface.PlaySound("buttons/button7.wav")
				end)
				if me:Team() ~= TEAM_LONER then
					menu:AddOption("Invite player to your faction", function()
						net.Start("InviteFaction")
						net.WriteEntity(v)
						net.SendToServer()
					end)
				end
				menu:Open()
			end
		
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

			local pvp = vgui.Create("DPanel", plypanel)
			pvp:SetPos(610, 7)
			pvp:SetSize(40, 24)
			pvp.Paint = function() -- Paint function
				surface.SetDrawColor(150, 0, 0 ,255)
				surface.DrawOutlinedRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
				surface.SetDrawColor(100, 0, 0 ,105)
				if v:IsValid() then
					if v:Team() == TEAM_LONER and v:GetNWBool("pvp") == false then
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
			surface.SetDrawColor(0,0,0,255)
			surface.DrawOutlinedRect(4, 4, 32, 32)
		end

		local factionicon = vgui.Create("DButton", plypanel)
		factionicon:SetSize(30, 30)
		factionicon:SetPos(5, 5)
		factionicon:SetText("")
		factionicon.Paint = function(this)
			surface.SetDrawColor(team.GetColor(v.index))
			surface.DrawRect(0, 0, 30, 30)
		end
		factionicon.DoClick = function(this)
/*
			local menu = DermaMenu()
			menu:AddOption("Check Player's Stats", function()
				if v:IsValid() then

				else
					chat.AddText(Color(255,205,205,255), "This player doesn't exist!")
				end
				surface.PlaySound("buttons/button9.wav")
			end)
			menu:Open()
*/
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
		draw.RoundedBox(2, 0, 0, w, h, Color(0,0,0,100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleText("All help and info about this gamemode is at help panel.", "TargetIDSmall", 15, 10, Color(255,255,255,255))
		draw.SimpleText("Press F1 to open help panel.", "TargetIDSmall", 15, 30, Color(255,255,255,255))
		draw.SimpleText("You are playing on "..GetHostName(), "TargetID", 15, 75, Color(255,255,255,255))
		draw.SimpleText("Enjoy your stay and good hunting!", "TargetID", 15, 95, Color(205,255,205,255))
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
		for k,v in SortedPairs(GAMEMODE.ItemsList) do
			if !GAMEMODE.CraftableList[k] then continue end
			local raretbl = gamemode.Call("CheckItemRarity", v["Rarity"])

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
			ItemDisplay:SetToolTip(translate.Get(k.."_d")..(v["ArmorStats"] and "\n"..translate.Format("item_armor_descr", v.ArmorStats["reduction"] or 0, v.ArmorStats["env_reduction"] or 0, (-v.ArmorStats["speedloss"] or 0) / 10, v.ArmorStats["slots"] or 0, v.ArmorStats["battery"] or 0, v.ArmorStats["carryweight"] or 0) or "").."\n"..translate.Format("item_descr_1", k, v.Cost, raretbl.text))
			ItemDisplay:SetSize(64,64)
			ItemDisplay.PaintOver = function() return end
			ItemDisplay.OnMousePressed = function() return false end

			local ItemName = vgui.Create("DLabel", ItemBG)
			ItemName:SetPos(85, 10)
			ItemName:SetSize(180, 15)
			ItemName:SetTextColor(raretbl.col)
			if raretbl.keeprefresh then
				ItemName.Think = function()
					local tbl_rarity = gamemode.Call("CheckItemRarity", v.Rarity)
					ItemName:SetTextColor(tbl_rarity.col)
				end
			end
			ItemName:SetText(translate.Get(k.."_n"))

			local ItemWeight = vgui.Create("DLabel", ItemBG)
			ItemWeight:SetFont("TargetIDSmall")
			ItemWeight:SetPos(85, 26)
			ItemWeight:SetSize(170, 15)
			ItemWeight:SetColor(Color(155,155,255,255))
			ItemWeight:SetText("Weight: ".. v["Weight"].."kg")

			local XPCraft = vgui.Create("DLabel", ItemBG)
			XPCraft:SetFont("TargetIDSmall")
			XPCraft:SetPos(85, 42)
			XPCraft:SetSize(170, 15)
			XPCraft:SetColor(Color(155,255,255,255))
			XPCraft:SetText("XP: "..GAMEMODE.CraftableList[k].XP)

			local TimeCraft = vgui.Create("DLabel", ItemBG)
			TimeCraft:SetFont("TargetIDSmall")
			TimeCraft:SetPos(85, 58)
			TimeCraft:SetSize(170, 15)
			TimeCraft:SetColor(Color(255,255,155,255))
			TimeCraft:SetText("Craft Time: "..GAMEMODE.CraftableList[k].CraftTime.."s")

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
					chat.AddText(Color(0,192,255), "\t"..q.."x "..translate.Get(r.."_n"))
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

		draw.SimpleText(translate.Format("timesurvived", util.ToMinutesSeconds(CurTime() - MySurvivaltime)), "TargetID", 15, 10, Color(255,255,255,255))
		draw.SimpleText(translate.Format("besttimesurvived", util.ToMinutesSeconds(MyBestsurvtime)), "TargetID", 15, 35, Color(255,255,255,255))
		draw.SimpleText("Zombies Killed in Total: "..MyZmbskilled, "TargetID", 15, 60, Color(255,255,255,255))
		draw.SimpleText("Players killed in Total: "..MyPlyskilled, "TargetID", 15, 85, Color(255,255,255,255))
		draw.SimpleText("Your Deaths in Total: "..MyPlydeaths, "TargetID", 15, 110, Color(255,255,255,255))

		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 165, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 165, 200, 8)
	
		local bar1 = math.Clamp( 200 * (MyMMeleexp / me:GetReqMasteryMeleeXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 165, bar1, 8)

		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(15, 210, 200, 8)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect(15, 210, 200, 8)
	
		local bar2 = math.Clamp( 200 * (MyMPvpxp / me:GetReqMasteryPvPXP()), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(15, 210, bar2, 8 )
	end

	local sttext1 = vgui.Create("DLabel", StatisticsForm)
	sttext1:SetFont("TargetID")
	sttext1:SetTextColor(Color(205,205,205,255))
	sttext1:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. me:GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")")
	sttext1:SetToolTip("Increases melee damage by 0.5% per level, increases when doing melee damage to zombies. \nGain rate is DECREASED when damaging players with melee weapons.")
	sttext1:SetMouseInputEnabled(true)
	sttext1:SizeToContents()
	sttext1:SetPos(15, 140)
	sttext1.Think = function(self)
		self:SetText("Mastery Melee XP: ".. math.floor(MyMMeleexp) .."/".. me:GetReqMasteryMeleeXP().." (Level "..math.floor(MyMMeleelvl)..")")
		self:SizeToContents()
	end

	local sttext2 = vgui.Create("DLabel", StatisticsForm)
	sttext2:SetFont("TargetID")
	sttext2:SetTextColor(Color(205,205,205,255))
	sttext2:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. me:GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")")
	sttext2:SetToolTip("Gained from killing players. (no other benefits other than money gain on level up)\nGain rate increased when they have higher level and prestige.")
	sttext2:SetMouseInputEnabled(true)
	sttext2:SizeToContents()
	sttext2:SetPos(15, 185)
	sttext2.Think = function(self)
		self:SetText("Mastery PvP XP: ".. math.floor(MyMPvpxp) .."/".. me:GetReqMasteryPvPXP().." (Level "..math.floor(MyMPvplvl)..")")
		self:SizeToContents()
	end




---------------Achievements Form------------------
/*
	local AchsForm = vgui.Create("DPanel", PropertySheet)
	AchsForm:SetSize(675, 700)
	AchsForm.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 100))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local AchsPanel = vgui.Create("DPanelList", AchsForm)
	AchsPanel:SetTall(635)
	AchsPanel:SetWide(755)
	AchsPanel:SetPos(5, 10)
	AchsPanel:EnableVerticalScrollbar(true)
	AchsPanel:EnableHorizontal(true)
   	AchsPanel:SetSpacing(5)

	local function DoAchievementsList()
		for k,v in SortedPairs(GAMEMODE.Achievements) do
			if !GAMEMODE.ItemsList[k] then continue end

			local ItemBG = vgui.Create("DPanel", AchsPanel)
			ItemBG:SetPos(5, 5)
			ItemBG:SetSize(745, 120)
			ItemBG.Paint = function() -- Paint function
				draw.RoundedBoxEx(8, 1, 1, ItemBG:GetWide() - 2, ItemBG:GetTall() - 2, Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50 ,255)
				surface.DrawOutlinedRect(0, 0, ItemBG:GetWide(), ItemBG:GetTall())
			end

			local ItemName = vgui.Create("DLabel", ItemBG)
			ItemName:SetPos(85, 10)
			ItemName:SetSize(180, 15)
			ItemName:SetText(translate.Get("ach_"..k.."_n"))

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
			AchsPanel:AddItem(ItemBG)
		end
	end
	DoAchievementsList()
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
	ModelInfo:SetModel(me:GetModel())
	ModelInfo:SetAnimSpeed(1)
	ModelInfo:SetAnimated(true)
	ModelInfo:SetAmbientLight(Color(50, 50, 50))
	ModelInfo:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	ModelInfo:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
	ModelInfo:SetCamPos(Vector(50, 0, 50))
	ModelInfo:SetLookAt(Vector(0, 0, 40))
	ModelInfo:SetFOV(80)
	function ModelInfo.Entity:GetPlayerColor() return me:GetPlayerColor() end

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

	function ModelInfo.Entity:GetPlayerColor() return me:GetPlayerColor() end
	local function DoStatsList()
		for k, v in SortedPairs(self.StatConfigs) do
			local LabelDefense = vgui.Create("DLabel")
			LabelDefense:SetPos(50, 50)
			LabelDefense:SetText(translate.Get(k)..": "..Perks[k])
			LabelDefense:SetToolTip(translate.Get(k.."_d").."\n\nDouble-Click to apply all SP if possible.\nCost per point: "..v.Cost.."\nMax: "..v.Max)
			LabelDefense:SizeToContents()
			StatsForm:AddItem(LabelDefense)

			local Button = vgui.Create("DButton")
			Button:SetPos(50, 100)
			Button:SetSize(10, 20)
			Button:SetTextColor(Color(255, 255, 255, 255))
			Button:SetText(translate.Format("inc1stat", translate.Get(k)))
			Button:SetToolTip(translate.Get(k.."_d").."\n\nDouble-Click to apply all SP if possible.\nCost per point: "..v.Cost.."\nMax: "..v.Max)
			Button.DoClick = function(Button)
				timer.Remove("use_sp")
				timer.Create("use_sp", 0.15, 1, function()
					net.Start("UpgradePerk")
					net.WriteString(k)
					net.WriteUInt(1, 16)
					net.SendToServer()
					timer.Simple(0.3, function()
						if StatsForm:IsValid() then
							StatsForm:Clear()
							DoStatsList()
						end
					end)
				end)
			end
			Button.DoDoubleClick = function(Button)
				net.Start("UpgradePerk")
				net.WriteString(k)
				net.WriteUInt(math.Clamp(math.floor(MySP), 1, math.min(MySP, 65535)), 16)
				net.SendToServer()
				timer.Simple(0.3, function()
					if StatsForm:IsValid() then
						StatsForm:Clear()
						DoStatsList()
					end
				end)

				timer.Remove("use_sp")
			end
			Button.Paint = function()
				draw.RoundedBox(0, 0, 0, Button:GetWide(), Button:GetTall(), Color(30, 30, 30, 50))
				draw.RoundedBox(0, 0, 0, Perks[k] * 225 / v.Max, Button:GetTall(), Color(100, 100, 0, 150))
				if Perks[k] > v.Max then -- Empowered Skills
					draw.RoundedBox(0, 0, 0, (Perks[k]-v.Max) * 225 / (v.Max + v.PerkMaxIncrease), Button:GetTall(), Color(200, 0, 0, 150))
				end
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
	self:CreateScoreboardInv()
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
