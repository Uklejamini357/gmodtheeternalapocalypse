-------------------------------- Scoreboard --------------------------------

function CalculateMaxWeightClient()
	local maxweight = 0
	local defaultcarryweight = Config[ "MaxCarryWeight" ]
	local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
	local armortype = ItemsList[armorstr]
	if LocalPlayer():GetNWString("ArmorType") == "none" then
		if Myprestige >= 10 then
			maxweight = defaultcarryweight + 5 + (Perks.Strength or 0) * 1.53
		elseif Myprestige >= 3 then
			maxweight = defaultcarryweight + 2 + (Perks.Strength or 0) * 1.53
		else
			maxweight = defaultcarryweight + (Perks.Strength or 0) * 1.53
		end
	else
		local addcarryweight = armortype["ArmorStats"]["carryweight"]
		if Myprestige >= 10 then
			maxweight = defaultcarryweight + 5 + (Perks.Strength or 0) * 1.53 + addcarryweight
		elseif Myprestige >= 3 then
			maxweight = defaultcarryweight + 2 + (Perks.Strength or 0) * 1.53 + addcarryweight
		else
			maxweight = defaultcarryweight + (Perks.Strength or 0) * 1.53 + addcarryweight
		end
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
	size = 28,
	weight = 650,
	antialias = true,
})

LocalInventory = {}
LocalVault = {}
InventoryItems = {}
InventoryWeapons = {}
Perks = {}



LocalFactions = LocalFactions or {}

if !LocalFactions[ "Loner" ] then LocalFactions[ "Loner" ] = 
	{
		["index"] = 1,
		["color"] = Color( 100, 50, 50, 255 ),
		["public"] = true,
		["leader"] = nil
	}
end

local bestsurvtim = 0

net.Receive("UpdateStatistics", function(length)
local besttimesurvived = net.ReadFloat()
local zkills = net.ReadFloat()
local playerskilled = net.ReadFloat()
local playerdeaths = net.ReadFloat()

bestsurvtim = besttimesurvived
zmbskilled = zkills
plyskilled = playerskilled
plydeaths = playerdeaths
end)
net.Receive( "UpdatePerks", function( length )

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
Perks.Health = s4
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

net.Receive( "UpdateInventory", function( length )
local data = net.ReadTable()
table.Empty( LocalInventory )

for k, v in pairs( data ) do
	if !ItemsList[k] then continue end
	local ref = ItemsList[k]

	LocalInventory[k] = {
		["Name"] = ref.Name,
		["Model"] = ref.Model,
		["Description"] = ref.Description,
		["Weight"] = ref.Weight,
		["Rarity"] = ref.Rarity,
		["Qty"] = v,
	}

end

--table.Merge(LocalInventory, data)

end)

net.Receive( "UpdateVault", function( length )
local data = net.ReadTable()
table.Empty( LocalVault )

for k, v in pairs( data ) do
	if !ItemsList[k] then continue end
	local ref = ItemsList[k]

	LocalVault[k] = {
		["Name"] = ref.Name,
		["Model"] = ref.Model,
		["Description"] = ref.Description,
		["Weight"] = ref.Weight,
		["Rarity"] = ref.Rarity,
		["Qty"] = v,
	}

end

--table.Merge(LocalVault, data)
end)

net.Receive( "RecvFactions", function( length, client )
local data = net.ReadTable()

table.Empty( LocalFactions )
-- put the loner faction back in since it can never be deleted
LocalFactions[ "Loner" ] = 
	{
		["index"] = 1,
		["color"] = Color( 100, 50, 50, 255 ),
		["public"] = true,
		["leader"] = nil
	}
table.Merge(LocalFactions, data)
for k, v in pairs(LocalFactions) do
	team.SetUp( v.index, k, v.color, v.public )
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
	ScoreBoardFrame = vgui.Create( "DFrame" )
	ScoreBoardFrame:SetSize( 1000, 700 )
	ScoreBoardFrame:Center()
	ScoreBoardFrame:SetTitle ( "" )
	ScoreBoardFrame:SetDraggable( false )
	ScoreBoardFrame:SetVisible( true )
	ScoreBoardFrame:ShowCloseButton( false )
	ScoreBoardFrame:MakePopup()
	ScoreBoardFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, ScoreBoardFrame:GetWide(), ScoreBoardFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, ScoreBoardFrame:GetWide(), ScoreBoardFrame:GetTall())
	surface.DrawOutlinedRect(ScoreBoardFrame:GetWide() - 260, 25, 250, 201)
	surface.DrawOutlinedRect(ScoreBoardFrame:GetWide() - 260, 230, 250, 70)
	surface.SetDrawColor(0, 0, 0 ,155)
	surface.DrawRect(ScoreBoardFrame:GetWide() - 260, 25, 250, 205)
	surface.DrawRect(ScoreBoardFrame:GetWide() - 260, 230, 250, 70)
	local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
	local armortype = ItemsList[armorstr]
	if armorstr and armortype then
		draw.SimpleText( translate.Get("Armor")..": "..translate.Get(armortype.Name), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 235, Color(255,255,255,255) )
		draw.SimpleText( translate.Get("ArmorProtection")..": "..armortype["ArmorStats"]["reduction"].."%  ("..armortype["ArmorStats"]["reduction"] + ((Perks.Defense or 0) * 1.5).."% total)", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 250, Color(205,255,205,255) )
		if armortype["ArmorStats"]["speedloss"] < 0 then
		draw.SimpleText( translate.Get("ArmorSpeed")..": Increased ("..-(armortype["ArmorStats"]["speedloss"] / 10)..")", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(205,205,255,255) )
		elseif armortype["ArmorStats"]["speedloss"] == 0 then
			draw.SimpleText( translate.Get("ArmorSpeed")..": None", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(205,205,255,255) )
		else
			draw.SimpleText( translate.Get("ArmorSpeed")..": Decreased (-"..(armortype["ArmorStats"]["speedloss"] / 10)..")", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(205,205,255,255) )
		end
		if armortype["ArmorStats"]["carryweight"] > 0 then
			draw.SimpleText( translate.Get("MaxWeight")..": +"..armortype["ArmorStats"]["carryweight"].."kg", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 280, Color(255,255,175,255) )
		else
			draw.SimpleText( translate.Get("MaxWeight")..": "..armortype["ArmorStats"]["carryweight"].."kg", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 280, Color(255,230,205,255) )
		end
		
	else
		draw.SimpleText( translate.Get("NoArmor"), "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 235, Color(255,255,255,255) )
		draw.SimpleText( translate.Get("ArmorProtection")..": 0% ("..( Perks.Defense or 0) * 1.5 .."% "..translate.Get("Total")..")", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 250, Color(205,255,205,255) )
		draw.SimpleText( translate.Get("ArmorSpeed")..": None", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 265, Color(205,205,255,255) )
		draw.SimpleText( translate.Get("MaxWeight")..": +0kg", "TargetIDSmall", ScoreBoardFrame:GetWide() - 255, 280, Color(255,235,205,255) )
	end

	end
	
	
-----------------------------------------Main Sheet---------------------------------------------------------------
	local PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent( ScoreBoardFrame )
	PropertySheet:SetPos( 0, 0 )
	PropertySheet:SetSize( 730, ScoreBoardFrame:GetTall() )
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
--		surface.SetDrawColor(255, 0, 0, 255)
--		surface.DrawOutlinedRect( 0, 0, PropertySheet:GetWide(), PropertySheet:GetTall() )
	for k, v in pairs(PropertySheet.Items) do
	if (!v.Tab) then continue end
	
	v.Tab.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
	end
	end
	end
	






	
-----------------------------------------Inventory---------------------------------------------------------------


	local InvForm = vgui.Create( "DForm", PropertySheet )
	InvForm:SetSize( 675, 700 )
	InvForm:SetPadding( 4 )
	InvForm:SetName( "Items" )
	InvForm.Paint = function()
	draw.RoundedBox( 2,  0,  0, InvForm:GetWide(), InvForm:GetTall(), Color( 0, 0, 0, 100 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, InvForm:GetWide(), InvForm:GetTall())
	end

	local TheListPanel = vgui.Create( "DPanelList", InvForm )
	TheListPanel:SetTall( 635 )
	TheListPanel:SetWide( 980 )
	TheListPanel:SetPos( 5, 25 )
	TheListPanel:EnableVerticalScrollbar( true )
	TheListPanel:EnableHorizontal( true )
   	TheListPanel:SetSpacing( 5 )


	local function DoInvPanel()
	InvForm:SetName(translate.Get("CurrentlyCarrying")..": "..CalculateWeightClient().."kg    "..translate.Get("MaxWeight")..": "..CalculateMaxWeightClient().."kg")

	for k, v in SortedPairsByMemberValue( LocalInventory, "Weight", true ) do

				
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
		ItemDisplay:SetToolTip(translate.Get(v.Description).."\n("..translate.Get("ItemID")..": "..k..")")
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
		ItemName:SetText( translate.Get(v.Name).." ("..v.Weight..""..translate.Get("kg")..")" )
		ItemName:SizeToContents()

		local ItemQty = vgui.Create( "DLabel", ItemBackground )
		ItemQty:SetPos( 300, 25 )
		ItemQty:SetFont( "QtyFont" )
		ItemQty:SetColor( Color(255,255,255,255) )
		ItemQty:SetText( v.Qty.."x" )
		ItemQty:SizeToContents()

		local EquipButton = vgui.Create("DButton", ItemBackground)
		EquipButton:SetSize( 80, 20 )
		EquipButton:SetPos( 80, 35 )
		EquipButton:SetText(translate.Get("Use"))
		EquipButton:SetTextColor(Color(255, 255, 255, 255))
		EquipButton.Paint = function(panel)
		surface.SetDrawColor(0, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, EquipButton:GetWide(), EquipButton:GetTall())
		draw.RoundedBox( 2, 0, 0, EquipButton:GetWide(), EquipButton:GetTall(), Color(0, 50, 0, 130) )
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
		DropButton:SetSize( 80, 20 )
		DropButton:SetPos( 170, 35 )
		DropButton:SetText(translate.Get("Drop"))
		DropButton:SetTextColor(Color(255, 255, 255, 255))
		DropButton.Paint = function(panel)
			surface.SetDrawColor(150, 75, 0 ,255)
			surface.DrawOutlinedRect(0, 0, DropButton:GetWide(), DropButton:GetTall())
			draw.RoundedBox( 2, 0, 0, DropButton:GetWide(), DropButton:GetTall(), Color(50, 25, 0, 130) )
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

			TheListPanel:AddItem( ItemBackground )
	end
end

DoInvPanel()





local Scores = vgui.Create( "DPanelList", PropertySheet )
Scores:SetSize( 650, 400 )
Scores:SetPadding( 5 )
Scores:SetSpacing( 5 )
Scores:EnableHorizontal( false )
Scores:EnableVerticalScrollbar( true )
Scores:SetPos( 10, 30 )
Scores:SetName( "" )


for k, v in pairs( player.GetAll() ) do

	local plypanel = vgui.Create( "DPanel", Scores )
	plypanel:SetPos( 0, 100 )
	plypanel:SetSize( 570, 60 )
	plypanel.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
	end

	
	local plyname = vgui.Create( "DLabel", plypanel )
	plyname:SetPos( 62, 22 )
	plyname:SetFont( "TargetIDSmall" )
	plyname:SetColor( Color(255,255,255,255) )
	plyname:SetText( v:Nick())
	plyname:SizeToContents()

	local plyname2 = vgui.Create( "DLabel", plypanel )
	plyname2:SetPos( 240, 12 )
	plyname2:SetFont( "TargetIDSmall" )
	plyname2:SetColor( team.GetColor(v:Team()) )
	plyname2:SetText( translate.Get("Faction")..": "..team.GetName(v:Team()))
--	plyname2:SizeToContents()
	plyname2:SetSize(200, 15)

	local plylvl = vgui.Create( "DLabel", plypanel )
	plylvl:SetPos( 430, 12 )
	plylvl:SetFont( "TargetIDSmall" )
	plylvl:SetColor( Color(255,255,255,255) )
	plylvl:SetText( "Lvl: " .. v:GetNWInt( "PlyLevel", 1 ))
	plylvl:SizeToContents()

	local plyping = vgui.Create( "DLabel", plypanel )
	plyping:SetPos( 510, 12 )
	plyping:SetFont( "TargetIDSmall" )
	plyping:SetColor( Color(255,math.Clamp(255 - (0.5 * v:Ping()), 0, 255),math.Clamp(255 - (0.5 * v:Ping()), 0, 255),255) )
	plyping:SetText( translate.Get("Ping")..": " .. v:Ping())
	plyping:SizeToContents()

	local plyprestige = vgui.Create( "DLabel", plypanel )
	plyprestige:SetPos( 240, 32 )
	plyprestige:SetFont( "TargetIDSmall" )
	plyprestige:SetColor( Color(255,127,255,255) )
	plyprestige:SetText( translate.Get("Prestige")..": " .. v:GetNWInt( "PlyPrestige", 0 ))
	plyprestige:SizeToContents()

	local plykills = vgui.Create( "DLabel", plypanel )
	plykills:SetPos( 430, 32 )
	plykills:SetFont( "TargetIDSmall" )
	plykills:SetColor( Color(255,255,255,255) )
	plykills:SetText( translate.Get("Frags")..": " .. v:Frags())
	plykills:SizeToContents()

	local plydeaths = vgui.Create( "DLabel", plypanel )
	plydeaths:SetPos( 510, 32 )
	plydeaths:SetFont( "TargetIDSmall" )
	plydeaths:SetColor( Color(255,255,255,255) )
	plydeaths:SetText( translate.Get("Deaths")..": " .. v:Deaths())
	plydeaths:SizeToContents()


	local av = vgui.Create("AvatarImage", plypanel)
	av:SetPos(17,11)
	av:SetSize(40, 40)
	av:SetPlayer( v )
		
	plypanel.m_SpecialImage = vgui.Create("DImage", plypanel)
	plypanel.m_SpecialImage:SetPos(1, 22)
	plypanel.m_SpecialImage:SetSize(16, 16)
	plypanel.m_SpecialImage:SetMouseInputEnabled(true)
	plypanel.m_SpecialImage:SetVisible(false)
	if gamemode.Call("IsSpecialPerson", v, plypanel.m_SpecialImage) then
		plypanel.m_SpecialImage:SetVisible(true)
	else
		plypanel.m_SpecialImage:SetTooltip()
		plypanel.m_SpecialImage:SetVisible(false)
	end
	

	timer.Create("UpdateScoreboard", 2, 0, function() --every 2 seconds, if scoreboard panel exists for client, the players' ping text on scoreboard will update
		if plyping:IsValid() and v:IsValid() then 
			plyping:SetColor( Color(255,math.Clamp(255 - (0.5 * v:Ping()), 0, 255),math.Clamp(255 - (0.5 * v:Ping()), 0, 255),255) )
			plyping:SetText( translate.Get("Ping")..": " .. v:Ping())
			plyping:SizeToContents()
		elseif !plyping:IsValid() then
			timer.Destroy("UpdateScoreboard")
		end
	end)

	local mutechat = vgui.Create("DButton", plypanel)
		mutechat:SetSize( 45, 24 )
		mutechat:SetPos( 655, 7 )
		mutechat:SetText(translate.Get("Mute"))
		mutechat:SetTextColor(Color(255, 255, 255, 255))
		mutechat.Paint = function(panel)
			if v:IsValid() and v:IsMuted() then
				surface.SetDrawColor(150, 0, 0 ,255)
				surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
				surface.SetDrawColor(100, 0, 0 ,155)
				surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
			elseif v:IsValid() then
				surface.SetDrawColor(125, 125, 125 ,255)
				surface.DrawOutlinedRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
				surface.SetDrawColor(25, 25, 25 ,155)
				surface.DrawRect(0, 0, mutechat:GetWide(), mutechat:GetTall())
			end

		end
			mutechat.DoClick = function()
			v:SetMuted( !v:IsMuted() )
			surface.PlaySound("buttons/button9.wav")
		end

	local invfaction = vgui.Create("DButton", plypanel)
		invfaction:SetSize( 45, 22 )
		invfaction:SetPos( 655, 33 )
		invfaction:SetText(translate.Get("Profile"))
		invfaction:SetTextColor(Color(255, 255, 255, 255))
		invfaction.Paint = function(panel)
				surface.SetDrawColor(0, 0, 100 ,255)
				surface.DrawOutlinedRect(0, 0, invfaction:GetWide(), invfaction:GetTall())
				surface.SetDrawColor(0, 0, 50 ,155)
				surface.DrawRect(0, 0, invfaction:GetWide(), invfaction:GetTall())
		end
			invfaction.DoClick = function()
			v:ShowProfile()
			surface.PlaySound("buttons/button7.wav")
		end


	local pvp = vgui.Create( "DPanel", plypanel )
	pvp:SetPos( 625, 7  )
	pvp:SetSize( 25, 24 )
	pvp.Paint = function() -- Paint function
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
		surface.SetDrawColor(100, 0, 0 ,105)
		if v:Team() == 1 and v:GetNWBool("pvp") == false then
		draw.DrawText( translate.Get("PvP"), "DermaDefault", 4, 7, Color(55,55,55) )
		else
		draw.DrawText( translate.Get("PvP"), "DermaDefault", 4, 7, Color(255,255,255) )
		surface.DrawRect(1, 1, pvp:GetWide() - 1 , pvp:GetTall() - 1)
		end

	end

	Scores:AddItem( plypanel )

end



-----------------------------------------Join Faction---------------------------------------------------------------


local FactionList = vgui.Create( "DPanelList", PropertySheet )
FactionList:SetSize( 650, 250 )
FactionList:SetPadding( 5 )
FactionList:SetSpacing( 5 )
FactionList:EnableHorizontal( false )
FactionList:EnableVerticalScrollbar( true )
FactionList:SetPos( 10, 80 )
FactionList:SetName( "" )


	local plypanel2 = vgui.Create( "DPanel", FactionList )
	plypanel2:SetPos( 0, 0 )
	plypanel2:SetSize( 570, 40 )
	plypanel2.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel2:GetWide(),plypanel2:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel2:GetWide() - 1 , plypanel2:GetTall() - 1)
	end

	FactionList:AddItem( plypanel2 )

for k, v in pairs( LocalFactions ) do
	if team.NumPlayers(v.index) == 0 then continue end -- ignore empty teams

	local plypanel = vgui.Create( "DPanel", FactionList )
	plypanel:SetPos( 0, 0 )
	plypanel:SetSize( 570, 40 )
	plypanel.Paint = function() -- Paint function
		draw.RoundedBoxEx(8,1,1,plypanel:GetWide(),plypanel:GetTall(),Color(0, 0, 0, 150), false, false, false, false)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(1, 1, plypanel:GetWide() - 1 , plypanel:GetTall() - 1)
		surface.SetDrawColor(team.GetColor(v.index))
		surface.DrawRect(5, 5,30 ,30)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect( 4, 4, 32, 32)
	end

	local createfaction = vgui.Create("DButton", plypanel2)
		createfaction:SetSize( 160, 25 )
		createfaction:SetPos( 70, 8 )
		createfaction:SetText(translate.Get("CreateFaction"))
--	   createfaction:SetFont( "TargetIDSmall" )
		createfaction:SetTextColor(Color(255, 255, 255, 255))
		createfaction.Paint = function(panel)
				surface.SetDrawColor(150, 150, 0 ,255)
				surface.DrawOutlinedRect(0, 0, createfaction:GetWide(), createfaction:GetTall())
				surface.SetDrawColor(50, 50, 0 ,155)
				surface.DrawRect(0, 0, createfaction:GetWide(), createfaction:GetTall())
		end
			createfaction.DoClick = function()
			surface.PlaySound("buttons/button9.wav")
			RunConsoleCommand("ate_createfaction")
			RunConsoleCommand("-score")
		end

	local managefaction = vgui.Create("DButton", plypanel2)
		managefaction:SetSize( 160, 25 )
		managefaction:SetPos( 270, 8 )
		managefaction:SetText(translate.Get("ManageFaction"))
--		managefaction:SetFont( "TargetIDSmall" )
		managefaction:SetTextColor(Color(255, 255, 255, 255))
		managefaction.Paint = function(panel)
				surface.SetDrawColor(150, 50, 150 ,255)
				surface.DrawOutlinedRect(0, 0, managefaction:GetWide(), managefaction:GetTall())
				surface.SetDrawColor(50, 25, 50 ,155)
				surface.DrawRect(0, 0, managefaction:GetWide(), managefaction:GetTall())
		end
			managefaction.DoClick = function()
			surface.PlaySound("buttons/button9.wav")
			RunConsoleCommand("ate_managefaction")
			RunConsoleCommand("-score")
		end

	local leavefaction = vgui.Create("DButton", plypanel2)
	leavefaction:SetSize( 160, 25 )
	leavefaction:SetPos( 470, 8 )
	leavefaction:SetText(translate.Get("LeaveFaction"))
--	   leavefaction:SetFont( "TargetIDSmall" )
	leavefaction:SetTextColor(Color(255, 255, 255, 255))
	leavefaction.Paint = function(panel)
		surface.SetDrawColor(150, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, leavefaction:GetWide(), leavefaction:GetTall())
		surface.SetDrawColor(50, 0, 0 ,155)
		surface.DrawRect(0, 0, leavefaction:GetWide(), leavefaction:GetTall())
	end
	leavefaction.DoClick = function()
	surface.PlaySound("buttons/button9.wav")
	RunConsoleCommand("ate_leavefaction")
	RunConsoleCommand("-score")	
end



	local plyname = vgui.Create( "DLabel", plypanel )
	plyname:SetPos( 45, 12 )
	plyname:SetFont( "TargetIDSmall" )
	plyname:SetColor( Color(255,255,255,255) )
	plyname:SetText( k )
	plyname:SetSize(180, 15)

	local facleader = vgui.Create( "DLabel", plypanel )
	facleader:SetPos( 220, 12 )
	facleader:SetFont( "TargetIDSmall" )
	facleader:SetColor( Color(255,255,255,255) )
	if v.leader and v.leader:IsValid() then
	facleader:SetText( translate.Get("Leader")..": "..v.leader:Nick() or "N/A" )
	else
	facleader:SetText( translate.Get("Leader")..": N/A" )
	end
	facleader:SetSize(200, 15)

	local members = vgui.Create( "DLabel", plypanel )
	members:SetPos( 420, 12 )
	members:SetFont( "TargetIDSmall" )
	members:SetColor( Color(255,255,255,255) )
	members:SetText( translate.Get("Members")..": "..team.NumPlayers( v.index ) )
	members:SizeToContents()

--	local base = vgui.Create( "DLabel", plypanel )
--	base:SetPos( 535, 12 )
--	base:SetFont( "TargetIDSmall" )
--	base:SetColor( Color(255,255,255,255) )
--	base:SetText( "Base: No" )
--	base:SizeToContents()

	local joinfaction = vgui.Create("DButton", plypanel)
		joinfaction:SetSize( 80, 25 )
		joinfaction:SetPos( 610, 8 )
		joinfaction:SetText(translate.Get("JoinFaction"))
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

	FactionList:AddItem( plypanel )
end
	
--------------------------Help Form------------------------------------

local HelpForm = vgui.Create( "DPanel", PropertySheet )
HelpForm:SetSize( 675, 700 )
--HelpForm:SetPadding( 4 )
--HelpForm:SetName( "Items" )
HelpForm.Paint = function( self, w, h )
draw.RoundedBox( 2,  0,  0, w, h, Color( 0, 0, 0, 100 ) )
surface.SetDrawColor(150, 0, 0 ,255)
surface.DrawOutlinedRect(0, 0, w, h)

draw.SimpleText( "(This isn't translated to rus, need a helper)", "TargetID", 15, 10, Color(255,255,255,255) )
draw.SimpleText( "Welcome to The Eternal Apocalypse. Also known as After The End Reborn.", "TargetID", 15, 30, Color(255,255,255,255) )
draw.SimpleText( "In this gamemode:", "TargetID", 15, 60, Color(155,155,155,255) )
draw.SimpleText( "Most zombies are buffed, new weapons are added. Unused/Cut items are added", "TargetID", 15, 90, Color(155,155,155,255) )
draw.SimpleText( "back. Health Regen function is also changed, it regenerates less hp. So you gotta carry", "TargetID", 15, 110, Color(155,155,155,255) )
draw.SimpleText( "more meds. Same thing applies for Weight system. 37.4 kg as carry weight, +1.53kg per", "TargetID", 15, 130, Color(155,155,155,255) )
draw.SimpleText( "Strength skill (by default). The way how you play this gamemode is also the same like in", "TargetID", 15, 150, Color(155,155,155,255) )
draw.SimpleText( "After The End. Barter skill is nerfed, you get less cash for selling items to traders.", "TargetID", 15, 170, Color(155,155,155,255) )
draw.SimpleText( "Bounty loss on death is more than in vanilla, most likely you drop cash between of", "TargetID", 15, 190, Color(155,155,155,255) )
draw.SimpleText( "30-40% bounty. Also, minimum amount of players required for boss is reduced to 2", "TargetID", 15, 210, Color(155,155,155,255) )
draw.SimpleText( "and for airdrop is increased to 5. In addition, Prestiging system is added.", "TargetID", 15, 230, Color(155,155,155,255) )
draw.SimpleText( "For more info about prestige, hold C and press 'Prestige'", "TargetID", 15, 250, Color(155,155,155,255) )
draw.SimpleText( "General help:", "TargetID", 15, 275, Color(155,155,255,255) )
draw.SimpleText( "By killing zombies, you gain XP and Bounty, go to trader and cash in your bounty. This", "TargetID", 15, 300, Color(155,155,255,255) )
draw.SimpleText( "way, you get money. The more XP you gain, the more levels you can get to. Leveling up", "TargetID", 15, 320, Color(155,155,255,255) )
draw.SimpleText( "grants 1 skill point and some money, depending on your level.", "TargetID", 15, 340, Color(155,155,255,255) )
draw.SimpleText( "F1 (gm_showhelp): [Function Not Implemented]", "TargetID", 15, 380, Color(155,255,255,255) )
draw.SimpleText( "F2 (gm_showteam): Open Admin Commands Panel", "TargetID", 15, 400, Color(155,255,255,255) )
draw.SimpleText( "F3 (gm_showspare1): Open Drop Money Panel", "TargetID", 15, 420, Color(155,255,255,255) )
draw.SimpleText( "F4 (gm_showspare2): [Function Not Implemented]", "TargetID", 15, 440, Color(155,255,255,255) )
draw.SimpleText( "Just a few more notes:", "TargetID", 15, 500, Color(155,255,155,255) )
draw.SimpleText( "- You can change your HUD Style you like with client ConVar tea_cl_hudstyle", "TargetID", 15, 530, Color(205,205,205,255) )
draw.SimpleText( "- Gamemode works the same as ZsRPG and AtE, but most of its' functions are changed", "TargetID", 15, 550, Color(255,255,155,255) )
draw.SimpleText( "- A map may change once per every while. This depends on server Owner's choice.", "TargetID", 15, 570, Color(255,255,155,255) )
draw.SimpleText( "- If you encounter any problem, error, or any kind of mistranslation, report it to the dev.", "TargetID", 15, 590, Color(255,155,155,255) )
draw.SimpleText( "Good hunting. (this panel may be changed every update)", "TargetID", 15, 630, Color(155,255,155,255) )
end

-----------------Craft Form (not finished and not included)-----------------------


local CraftForm = vgui.Create( "DPanel", PropertySheet )
CraftForm:SetSize( 675, 700 )
CraftForm.Paint = function( self, w, h )
draw.RoundedBox( 2,  0,  0, w, h, Color( 0, 0, 0, 100 ) )
surface.SetDrawColor(150, 0, 0 ,255)
surface.DrawOutlinedRect(0, 0, w, h)

draw.SimpleText( "This isn't present in the current version.", "TargetID", 15, 10, Color(255,255,255,255) )
draw.SimpleText( "This property will have Crafting Panel which you will be able to use.", "TargetID", 15, 30, Color(255,255,255,255) )
draw.SimpleText( "It may be added in next update.", "TargetID", 15, 50, Color(255,255,255,255) )
draw.SimpleText( "Check back later then", "TargetID", 15, 70, Color(205,205,205,255) )

end

---------------Statistics Form------------------

local StatisticsForm = vgui.Create( "DPanel", PropertySheet )
StatisticsForm:SetSize( 675, 700 )
StatisticsForm.Paint = function( self, w, h )
draw.RoundedBox( 2,  0,  0, w, h, Color( 0, 0, 0, 100 ) )
surface.SetDrawColor(150, 0, 0 ,255)
surface.DrawOutlinedRect(0, 0, w, h)

draw.SimpleText( "Best Survival Time: "..bestsurvtim.."s", "TargetID", 15, 10, Color(255,255,255,255) )
draw.SimpleText( "Zombies Killed in Total: "..zmbskilled, "TargetID", 15, 35, Color(255,255,255,255) )
draw.SimpleText( "Players killed in Total: "..plyskilled, "TargetID", 15, 60, Color(255,255,255,255) )
draw.SimpleText( "Your Deaths in Total: "..plydeaths, "TargetID", 15, 85, Color(255,255,255,255) )

end
------------------------------------Sheets----------------------------------------
PropertySheet:AddSheet( translate.Get("Inventory"), InvForm, "icon16/basket.png", false, false, translate.Get("Inventory_d") )
PropertySheet:AddSheet( translate.Get("Factions"), FactionList, "icon16/user_red.png", false, false, "Join factions" )
PropertySheet:AddSheet( translate.Get("Scoreboard"), Scores, "icon16/group.png", false, false, "See who is online and how many killed players they have" )
PropertySheet:AddSheet( translate.Get("Help"), HelpForm, "icon16/note.png", false, false, "Shows a bit of info about this gamemode" )
PropertySheet:AddSheet( "Crafting", CraftForm, "icon16/shield.png", false, false, "This feature is not present yet. It may be added in future version." )
PropertySheet:AddSheet( "Statistics", StatisticsForm, "icon16/user.png", false, false, "Here, you can view some of your statistics done on this server.\nSuch as how long you survived before getting killed." )














	

-----------------------------------------Stats Sheet---------------------------------------------------------------
	SecondarySheet = vgui.Create( "DPropertySheet" )
	SecondarySheet:SetParent( ScoreBoardFrame )
	SecondarySheet:SetPos( ScoreBoardFrame:GetWide() - 260, 300 )
	SecondarySheet:SetSize( 250, ScoreBoardFrame:GetTall() - 300)
	SecondarySheet.Paint = function()
	draw.RoundedBox( 2,  0,  0, SecondarySheet:GetWide(), SecondarySheet:GetTall(), Color( 0, 0, 0, 100 ) )
	for k, v in pairs(SecondarySheet.Items) do
	if (!v.Tab) then continue end
	
	v.Tab.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
	end
	end
	end

	
-----------------------------------------Stats Form---------------------------------------------------------------
	local StatsForm = vgui.Create( "DPanelList", ScoreBoardFrame )
	StatsForm:SetSize( 675, 600 )
	StatsForm:SetPos( 0, 0 )
	--StatsForm:EnableHorizontal( false )
	StatsForm:EnableVerticalScrollbar( true )
	StatsForm:SetSpacing( 10 ) 
	StatsForm:SetName( "" )
	StatsForm.Paint = function()
--	draw.RoundedBox( 12,  0,  0, StatsForm:GetWide(), StatsForm:GetTall(), Color( 0, 0, 0, 100 ) )
	surface.SetDrawColor(0, 0, 0 ,100)
	surface.DrawRect(0, 0, StatsForm:GetWide(), StatsForm:GetTall())
	end
	StatsForm.VBar.Paint = function()
	draw.RoundedBox( 2,  0,  0, StatsForm.VBar:GetWide(), StatsForm.VBar:GetTall(), Color( 30, 30, 30, 50 ) )
	end
	StatsForm.VBar.btnGrip.Paint = function()
	draw.RoundedBox( 2,  0,  0, StatsForm.VBar.btnGrip:GetWide(), StatsForm.VBar.btnGrip:GetTall(), Color( 40, 0, 0, 50 ) )
	end
	
	local ModelInfo = vgui.Create( "DModelPanel", ScoreBoardFrame )
	ModelInfo:SetSize( 200, 200 )
	ModelInfo:SetPos( ScoreBoardFrame:GetWide() - 240, 25 )
	ModelInfo:SetModel( LocalPlayer():GetModel() )
	ModelInfo:SetAnimSpeed( 1 )
	ModelInfo:SetAnimated( true )
	ModelInfo:SetAmbientLight( Color( 50, 50, 50 ) )
	ModelInfo:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	ModelInfo:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	ModelInfo:SetCamPos( Vector( 50, 0, 50 ) )
	ModelInfo:SetLookAt( Vector( 0, 0, 40 ) )
	ModelInfo:SetFOV( 70 )
	function ModelInfo.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end

	local ModelButton = vgui.Create("DButton", ScoreBoardFrame)
	ModelButton:SetSize( 90, 20 )
	ModelButton:SetPos( ScoreBoardFrame:GetWide() - 100, 25 )
	ModelButton:SetText(translate.Get("ChangeModel"))
	ModelButton:SetTextColor(Color(255, 255, 255, 255))
	ModelButton.Paint = function(panel)
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, ModelButton:GetWide(), ModelButton:GetTall())
	draw.RoundedBox( 2, 0, 0, ModelButton:GetWide(), ModelButton:GetTall(), Color(50, 0, 0, 130) )
			end
			ModelButton.DoClick = function()
			RunConsoleCommand("ate_changemodel")
			RunConsoleCommand("-score")
			end


	function ModelInfo.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end
--	StatsForm:AddItem( ModelInfo )

local function DoStatsList()

	for k, v in SortedPairs( Perks ) do
		
		local LabelDefense = vgui.Create( "DLabel" )
		LabelDefense:SetPos( 50, 50 )
		LabelDefense:SetText( translate.Get(k).." : "..v )
		LabelDefense:SizeToContents()
		StatsForm:AddItem( LabelDefense )
		
		local Button = vgui.Create( "DButton" )
		Button:SetPos( 50, 100 )
		Button:SetSize( 10, 20 )
		Button:SetTextColor( Color( 255, 255, 255, 255 ) )
		Button:SetText( translate.Get("Inc1Stat_1").." "..translate.Get(k).." ".. translate.Get("Inc1Stat_2") )
		Button.DoClick = function( Button )
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
		draw.RoundedBox( 0,  0,  0, Button:GetWide(), Button:GetTall(), Color( 30, 30, 30, 50 ) )
		draw.RoundedBox( 0,  0,  0, derp * 22.5, Button:GetTall(), Color( 100, 0, 0, 150 ) )
		surface.SetDrawColor(100, 0, 0 ,255)
		surface.DrawOutlinedRect(0, 0, Button:GetWide(), Button:GetTall())
		end
		StatsForm:AddItem( Button )
	end
end
DoStatsList()
	
/*-----------------------------------------PlayerModelSelect---------------------------------------------------------------
	local ArmorForm = vgui.Create( "DForm", ScoreBoardFrame )
	ArmorForm:SetSize( 675, 617 )
	ArmorForm:SetPadding( 4 )
	ArmorForm:SetName( "" )
 
	
*/	
-----------------------------------------Sheet List---------------------------------------------------------------
	SecondarySheet:AddSheet( translate.Get("MySkills"), StatsForm, "icon16/heart.png", false, false, translate.Get("MySkills_d") )
--	SecondarySheet:AddSheet( "Armor and Attachments", ArmorForm, "icon16/shield.png", false, false, "Change your model" )
end

function GM:CreateScoreboard()
	return false
end

function GM:ScoreboardShow()
	ScoreBoard:Create()
	ScoreBoardFrame:SetVisible( true )
	gui.EnableScreenClicker( true )
	ScoreBoardFrame:SetAlpha(0)
	ScoreBoardFrame:AlphaTo(255, 0.1, 0)
end

function GM:ScoreboardHide()
	if ScoreBoardFrame:IsValid() then
		ScoreBoardFrame:SetVisible( false )
		ScoreBoardFrame:Remove()
		gui.EnableScreenClicker( false )
	end
end