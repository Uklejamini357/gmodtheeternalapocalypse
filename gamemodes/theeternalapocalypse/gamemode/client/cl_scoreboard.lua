---------------- Scoreboard ----------------

local pScoreBoard
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
	me.StatScavenging = net.ReadFloat()
end)


net.Receive("RecvFactions", function(length, client)
	local data = net.ReadTable()

	table.Empty(LocalFactions)

	-- put the loner faction back in since it can never be deleted
	LocalFactions["Loner"] = {
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


function GM:CreateScoreboardInv()
	local me = LocalPlayer()

	local wide, tall = 1000, 700
	pScoreBoard = vgui.Create("DFrame")
	pScoreBoard:SetSize(wide, tall)
	pScoreBoard:Center()
	pScoreBoard:SetTitle("")
	pScoreBoard:SetDraggable(false)
	pScoreBoard:SetVisible(true)
	pScoreBoard:ShowCloseButton(false)
	pScoreBoard:MakePopup()
	pScoreBoard:SetKeyBoardInputEnabled(false)
	pScoreBoard.Paint = function(panel)
		Derma_DrawBackgroundBlur(pScoreBoard, SysTime())

		draw.RoundedBox(2, 0, 0, panel:GetWide(), panel:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
		surface.SetDrawColor(0, 0, 0 ,155)
	end
	pScoreBoard.SysTimeCreated = SysTime()
	self.ScoreboardFrame = pScoreBoard
	
	
-----------------------------------------Main Sheet---------------------------------------------------------------
	local PropertySheet = vgui.Create("DPropertySheet")
	PropertySheet:SetParent(pScoreBoard)
	PropertySheet:SetPos(0, 0)
	PropertySheet:SetSize(wide, tall)
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

	local Scores = vgui.Create("DPanelList", PropertySheet)
	Scores:SetSize(wide, tall - 20)
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
			plypanel:SetSize(wide - 20, 60)
			plypanel.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
				surface.SetDrawColor(150, 75, 75 ,255)
				surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
			end

			local plyname = vgui.Create("DLabel", plypanel)
			plyname:SetPos(62, 22)
			plyname:SetFont("TEA.HUDFontSmall")
			plyname:SetColor(Color(255,255,255))
			plyname:SetText(v:Nick())
			plyname:SizeToContents()

			local plyname2 = vgui.Create("DLabel", plypanel)
			plyname2:SetPos(240, 12)
			plyname2:SetFont("TEA.HUDFontSmall")
			plyname2:SetColor(team.GetColor(v:Team()))
			plyname2:SetText(translate.Format("faction", team.GetName(v:Team())))
			plyname2:SetSize(180, 15)

			local plylvl = vgui.Create("DLabel", plypanel)
			plylvl:SetPos(430, 12)
			plylvl:SetFont("TEA.HUDFontSmall")
			plylvl:SetColor(Color(255,255,255))
			plylvl:SetText("Lvl: "..v:GetNWInt("PlyLevel", 1))
			plylvl:SizeToContents()

			local plyping = vgui.Create("DLabel", plypanel)
			plyping:SetPos(510, 12)
			plyping:SetFont("TEA.HUDFontSmall")
			plyping:SetColor(Color(255,math.Clamp(255 - (0.5 * v:Ping()), 0, 255),math.Clamp(255 - (0.5 * v:Ping()), 0, 255),255))
			plyping:SetText(translate.Format("ping", v:Ping()))
			plyping:SizeToContents()

			local plyprestige = vgui.Create("DLabel", plypanel)
			plyprestige:SetPos(240, 32)
			plyprestige:SetFont("TEA.HUDFontSmall")
			plyprestige:SetColor(Color(255,127,255,255))
			plyprestige:SetText(translate.Format("prestige", v:GetNWInt("PlyPrestige", 0)))
			plyprestige:SizeToContents()

			local plykills = vgui.Create("DLabel", plypanel)
			plykills:SetPos(430, 32)
			plykills:SetFont("TEA.HUDFontSmall")
			plykills:SetColor(Color(255,255,255))
			plykills:SetText(translate.Format("frags", v:Frags()))
			plykills:SizeToContents()

			local plydeaths = vgui.Create("DLabel", plypanel)
			plydeaths:SetPos(510, 32)
			plydeaths:SetFont("TEA.HUDFontSmall")
			plydeaths:SetColor(Color(255,255,255))
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

			local plypanelAction = vgui.Create("DButton", plypanel)
			plypanelAction:SetSize(plypanel:GetWide(), plypanel:GetTall())
			plypanelAction:SetText("")
			plypanelAction.Paint = function(panel, w, h)
				if panel:IsHovered() then
					surface.SetDrawColor(255, 255, 255, 100)
					surface.DrawOutlinedRect(0, 0, w, h)
					surface.SetDrawColor(255, 255, 255, 20)
					surface.DrawRect(0, 0, w, h)
				end
			end
			plypanelAction.OnMousePressed = function(this, mc)
				if mc == MOUSE_LEFT then
					local menu = DermaMenu()
					menu:AddOption("Check Player's Stats", function()
						if v:IsValid() then
							net.Start("UpdateTargetStats")
							net.WriteEntity(v)
							net.SendToServer()
							StatsMenu(v)
						else
							chat.AddText(Color(255,205,205,255), translate.Get("this_player_doesnt_exist"))
						end
						surface.PlaySound("buttons/button9.wav")
					end)
					menu:AddOption("Player Profile", function()
						if v:IsValid() then
							v:ShowProfile()
						else
							chat.AddText(Color(255,205,205,255), translate.Get("this_player_doesnt_exist"))
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

				return true
			end


			local mutechat = vgui.Create("DButton", plypanel)
			mutechat:SetSize(wide*0.05, 23)
			mutechat:SetPos(wide*0.91, 7)
			mutechat:SetText(translate.Get("mute"))
			mutechat:SetTextColor(Color(255, 255, 255, 255))
			mutechat.Paint = function(panel)
				if v:IsValid() and v:IsMuted() then
					surface.SetDrawColor(150, 0, 0 ,255)
					surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					surface.SetDrawColor(100, 0, 0 ,155)
					surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					mutechat:SetToolTip(translate.Get("player_muted"))
				elseif v:IsValid() then
					surface.SetDrawColor(125, 125, 125 ,255)
					surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					surface.SetDrawColor(25, 25, 25 ,155)
					surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
					mutechat:SetToolTip(translate.Get("player_not_muted"))
				end
			end
			mutechat.DoClick = function()
				if v:IsValid() then
					v:SetMuted(!v:IsMuted())
				else
					chat.AddText(Color(255,205,205,255), translate.Get("this_player_doesnt_exist"))
				end
				surface.PlaySound("buttons/button9.wav")
			end

			local pvp = vgui.Create("DPanel", plypanel)
			pvp:SetSize(wide*0.05, 24)
			pvp:SetPos(wide*0.85, 7)
			pvp.Paint = function() -- Paint function
				surface.SetDrawColor(150, 0, 0 ,255)
				surface.DrawOutlinedRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
				surface.SetDrawColor(100, 0, 0 ,105)
				if v:IsValid() then
					if v:Team() == TEAM_LONER and not v:GetNWBool("pvp") then
						draw.DrawText(translate.Get("pvp"), "DermaDefault", 12, 5, Color(55,55,55))
						pvp:SetToolTip(translate.Get("pvp_disabled"))
					else
						draw.DrawText(translate.Get("pvp"), "DermaDefault", 12, 5, Color(255,255,255))
						surface.DrawRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
						pvp:SetToolTip(translate.Get("pvp_enabled"))
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

	local sFactions = vgui.Create("DPanelList", PropertySheet)
	sFactions:SetSize(wide - 20, tall - 80)
	sFactions:SetPadding(5)
	sFactions:SetSpacing(5)
	sFactions:EnableHorizontal(false)
	sFactions:EnableVerticalScrollbar(true)
	sFactions:SetPos(10, 80)
	sFactions:SetName("")

	local psFaction = vgui.Create("DPanel", sFactions)
	psFaction:SetPos(0, 0)
	psFaction:SetSize(570, 40)
	psFaction.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,psFaction:GetWide(),psFaction:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(1, 1, psFaction:GetWide() - 1 , psFaction:GetTall() - 1)
	end

	local pCreateFaction = vgui.Create("DButton", psFaction)
	pCreateFaction:SetSize(wide*0.25, 25)
	pCreateFaction:SetPos(wide*0.05, 8)
	pCreateFaction:SetText(translate.Get("createfaction"))
	pCreateFaction:SetTextColor(Color(255, 255, 255, 255))
	pCreateFaction.Paint = function(panel)
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, pCreateFaction:GetWide(), pCreateFaction:GetTall())
		surface.SetDrawColor(50, 50, 0 ,155)
		surface.DrawRect(0, 0, pCreateFaction:GetWide(), pCreateFaction:GetTall())
	end
	pCreateFaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_createfaction")
		self:ScoreboardHide()
	end

	local pManageFaction = vgui.Create("DButton", psFaction)
	pManageFaction:SetSize(wide*0.25, 25)
	pManageFaction:SetPos(wide*0.35, 8)
	pManageFaction:SetText(translate.Get("managefaction"))
	pManageFaction:SetTextColor(Color(255, 255, 255, 255))
	pManageFaction.Paint = function(panel)
		surface.SetDrawColor(150, 50, 150 ,255)
		surface.DrawOutlinedRect(0, 0, pManageFaction:GetWide(), pManageFaction:GetTall())
		surface.SetDrawColor(50, 25, 50 ,155)
		surface.DrawRect(0, 0, pManageFaction:GetWide(), pManageFaction:GetTall())
	end
	pManageFaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_managecaction")
		self:ScoreboardHide()
	end

	local pLeaveFaction = vgui.Create("DButton", psFaction)
	pLeaveFaction:SetSize(wide*0.25, 25)
	pLeaveFaction:SetPos(wide*0.65, 8)
	pLeaveFaction:SetText(translate.Get("leavefaction"))
	pLeaveFaction:SetTextColor(Color(255, 255, 255, 255))
	pLeaveFaction.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, pLeaveFaction:GetWide(), pLeaveFaction:GetTall())
		surface.SetDrawColor(50, 0, 0 ,155)
		surface.DrawRect(0, 0, pLeaveFaction:GetWide(), pLeaveFaction:GetTall())
	end
	pLeaveFaction.DoClick = function()
		surface.PlaySound("buttons/button9.wav")
		RunConsoleCommand("tea_leavefaction")
		self:ScoreboardHide()
	end

	sFactions:AddItem(psFaction)

	for k, v in pairs(LocalFactions) do
		if team.NumPlayers(v.index) == 0 then continue end -- ignore empty teams

		local pFaction = vgui.Create("DPanel", sFactions)
		pFaction:SetPos(0, 0)
		pFaction:SetSize(570, 40)
		pFaction.Paint = function() -- Paint function
			draw.RoundedBoxEx(8,1,1,pFaction:GetWide(),pFaction:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
			surface.SetDrawColor(150, 150, 0 ,255)
			surface.DrawOutlinedRect(1, 1, pFaction:GetWide() - 1 , pFaction:GetTall() - 1)
			surface.SetDrawColor(0,0,0,255)
			surface.DrawOutlinedRect(4, 4, 32, 32)
		end

		local fIcon = vgui.Create("DButton", pFaction)
		fIcon:SetSize(30, 30)
		fIcon:SetPos(5, 5)
		fIcon:SetText("")
		fIcon.Paint = function(this)
			surface.SetDrawColor(team.GetColor(v.index))
			surface.DrawRect(0, 0, 30, 30)
		end
		fIcon.DoClick = function(this)
		end

		local fName = vgui.Create("DLabel", pFaction)
		fName:SetPos(45, 12)
		fName:SetFont("TEA.HUDFontSmall")
		fName:SetColor(Color(255,255,255))
		fName:SetText(k)
		fName:SetSize(180, 15)

		local fLeader = vgui.Create("DLabel", pFaction)
		fLeader:SetPos(220, 12)
		fLeader:SetFont("TEA.HUDFontSmall")
		fLeader:SetColor(Color(255,255,255))
		if v.leader and v.leader:IsValid() then
			fLeader:SetText(translate.Get("leader")..": "..v.leader:Nick() or "N/A")
		else
			fLeader:SetText(translate.Get("leader")..": N/A")
		end
		fLeader:SetSize(200, 15)

		local fMembers = vgui.Create("DLabel", pFaction)
		fMembers:SetPos(400, 12)
		fMembers:SetFont("TEA.HUDFontSmall")
		fMembers:SetColor(Color(255,255,255))
		fMembers:SetText(translate.Get("members")..": "..team.NumPlayers(v.index))
		fMembers:SizeToContents()

		local fPublic = vgui.Create("DLabel", pFaction)
		fPublic:SetPos(500, 12)
		fPublic:SetFont("TEA.HUDFontSmall")
		fPublic:SetColor(Color(255,255,255))
		fPublic:SetText(translate.Get(v.public and "faction_public" or "faction_public_no"))
		fPublic:SizeToContents()

		local fJoin = vgui.Create("DButton", pFaction)
		fJoin:SetSize(wide*0.15, 25)
		fJoin:SetPos(10+wide*0.8, 8)
		fJoin:SetText(translate.Get("joinfaction"))
		fJoin:SetTextColor(Color(255, 255, 255, 255))
		fJoin.Paint = function(panel)
			surface.SetDrawColor(150, 0, 150 ,255)
			surface.DrawOutlinedRect(0, 0, fJoin:GetWide(), fJoin:GetTall())
			surface.SetDrawColor(50, 0, 150 ,155)
			surface.DrawRect(0, 0, fJoin:GetWide(), fJoin:GetTall())
		end
		fJoin.DoClick = function()
			surface.PlaySound("buttons/button9.wav")
			net.Start("JoinFaction")
			net.WriteString(k)
			net.SendToServer()
		end
		sFactions:AddItem(pFaction)
	end
	
--------------------------Help Form------------------------------------

	local HelpForm = vgui.Create("DPanel", PropertySheet)
	HelpForm:SetSize(wide, tall)
	HelpForm.Paint = function(self, w, h)
		draw.SimpleText("All help and info about this gamemode is at help panel.", "TEA.HUDFontSmall", 15, 10, Color(255,255,255))
		draw.SimpleText("Press F1 to open help panel.", "TEA.HUDFontSmall", 15, 30, Color(255,255,255))
		draw.SimpleText("You are playing on "..GetHostName(), "TEA.HUDFont", 15, 75, Color(255,255,255))
		draw.SimpleText("Enjoy your stay and good hunting!", "TEA.HUDFont", 15, 95, Color(205,255,205))
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
	PropertySheet:AddSheet(translate.Get("sb_sheet3"), Scores, "icon16/group.png", false, false, translate.Get("sb_sheet3_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet2"), sFactions, "icon16/user_red.png", false, false, translate.Get("sb_sheet2_d"))
	PropertySheet:AddSheet(translate.Get("sb_sheet4"), HelpForm, "icon16/note.png", false, false, translate.Get("sb_sheet4_d"))
--	PropertySheet:AddSheet(translate.Get("sb_sheet7"), AchsForm, "icon16/award_star_silver_3.png", false, false, translate.Get("sb_sheet7_d"))


	return pScoreBoard
end

function GM:CreateScoreboard()
	return false
end

local handler = "TEA.ScoreBoardRemove"
function GM:ScoreboardShow()
	local pScoreBoard = self.ScoreboardFrame

	local alpha = 0
	local time = 0.2
	if IsValid(pScoreBoard) then
		timer.Remove(handler)
		alpha = pScoreBoard:GetAlpha()
		time = 0.2 - 0.2*alpha/255

		pScoreBoard:Remove()
	end

	pScoreBoard = self:CreateScoreboardInv()
	pScoreBoard:SetVisible(true)
	pScoreBoard:SetAlpha(alpha)
	pScoreBoard:AlphaTo(255, time, 0)
end

function GM:ScoreboardHide()
	local pScoreBoard = self.ScoreboardFrame
	if !IsValid(pScoreBoard) then return end
	local alpha = pScoreBoard:GetAlpha()
	local time = 0.2*alpha/255
	timer.Create(handler, time, 1, function()
		pScoreBoard:Remove()
	end)

	pScoreBoard:SetKeyBoardInputEnabled(false)
	pScoreBoard:SetMouseInputEnabled(false)
	pScoreBoard:AlphaTo(0, time, 0)
end
