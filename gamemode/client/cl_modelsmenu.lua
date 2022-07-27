-------------------------------- Models Menu --------------------------------

function ModelMenu()

local plymodel
local plycolor

plycolor = LocalPlayer():GetPlayerColor()
plymodel = LocalPlayer():GetModel()

ModelFrame = vgui.Create( "DFrame" )
ModelFrame:SetSize( 600, 740 )
ModelFrame:Center()
ModelFrame:SetTitle ( "" )
ModelFrame:SetDraggable( false )
ModelFrame:SetVisible( true )
ModelFrame:ShowCloseButton( true )
ModelFrame:MakePopup()
ModelFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, ModelFrame:GetWide(), ModelFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, ModelFrame:GetWide(), ModelFrame:GetTall())
	surface.DrawOutlinedRect(25, 25, 300, 300)
	surface.SetDrawColor(0, 0, 0 ,100)
	surface.DrawRect(25, 350, 550, 300)
end

local function refreshmodel()

local tcolor = vgui.Create("DColorMixer", ModelFrame)
tcolor:SetSize(225, 225)
tcolor:SetPos(350, 25)
tcolor:SetColor(Color(plycolor.x, plycolor.y, plycolor.r))
tcolor.ValueChanged = function(Mixer, color)
plycolor = tcolor:GetVector() end

local ModelInfo = vgui.Create( "DModelPanel", ModelFrame )
ModelInfo:SetSize( 300, 300 )
ModelInfo:SetPos( 25, 25 )
ModelInfo:SetModel( plymodel )
ModelInfo:SetAnimSpeed( 1 )
ModelInfo:SetAnimated( true )
ModelInfo:SetAmbientLight( Color( 50, 50, 50 ) )
ModelInfo:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
ModelInfo:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
ModelInfo:SetCamPos( Vector( 60, 0, 50 ) )
ModelInfo:SetLookAt( Vector( 0, 0, 40 ) )
ModelInfo:SetFOV( 70 )
function ModelInfo.Entity:GetPlayerColor() return plycolor end

local ModelList = vgui.Create( "DPanelList", ModelFrame )
ModelList:EnableHorizontal( true )
ModelList:EnableVerticalScrollbar( true )
ModelList:SetSize( 550, 300 )
ModelList:SetPos( 25, 350 )
--ModelForm:AddItem( ModelList )'

local tab = DefaultModels
if LocalPlayer():GetNWString("ArmorType") != "none" then
local armor = LocalPlayer():GetNWString("ArmorType")
if ItemsList[armor]["ArmorStats"]["allowmodels"] != nil then
tab = ItemsList[armor]["ArmorStats"]["allowmodels"]
end
end

	for n = 1, table.getn( tab ) do
		
		local SpawnIcon = vgui.Create( "SpawnIcon" )
		SpawnIcon:SetPos( x, y )
		SpawnIcon:SetSize( 64, 64 )
		SpawnIcon:SetModel( tab[n] )

		SpawnIcon.DoClick = function()
		ModelInfo:SetModel( tab[n] )
		plymodel = tab[n]
		end
		ModelList:AddItem( SpawnIcon )
	end
end
refreshmodel()



local CButton = vgui.Create( "DButton" )
CButton:SetParent( ModelFrame )  
CButton:SetPos( 215, 680 )
CButton:SetTextColor( Color(255, 255, 255, 255) )
CButton:SetSize( 150, 30 )
CButton.Paint = function()
surface.SetDrawColor(0, 0, 0 ,200)
CButton:SetText( "Accept Changes" )
surface.DrawRect( 0, 0, CButton:GetWide(), CButton:GetTall() )
surface.SetDrawColor(150, 0, 0 ,255)
surface.DrawOutlinedRect( 0, 0, CButton:GetWide(), CButton:GetTall() )
end
CButton.DoClick = function()
net.Start("ChangeModel")
net.WriteString(plymodel)
net.WriteVector(plycolor)
net.SendToServer()
ModelFrame:Remove()
end

end
concommand.Add("ate_changemodel", ModelMenu)