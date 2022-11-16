pOptions = nil
pSVOptions = nil

-- i know this was copied from zs (once again) but i was still too lazy to make it myself
function MakeOptions()
	if IsValid(pOptions) and pOptions then
		if pSVOptions then
			pSVOptions:SetVisible(false)
		end
		pOptions:SetAlpha(0)
		pOptions:AlphaTo(255, 0.35, 0)
		pOptions:SetVisible(true)
		pOptions:MakePopup()
		return
	end

	local Window = vgui.Create("DFrame")
	local wide = math.min(ScrW(), 500)
	local tall = math.min(ScrH(), 600)
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle("")
	Window:SetDraggable(false)
	Window:SetDeleteOnClose(false)
	Window.Paint = function()
		draw.RoundedBox( 2, 0, 0, Window:GetWide(), Window:GetTall(), Color( 0, 0, 0, 200 ) )
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, Window:GetWide(), Window:GetTall())
	end
	pOptions = Window

	local y = 8

	local label = EasyLabel(Window, "Options", "TargetID", color_white)
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", pOptions)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 24, tall - y - 12)
	list:SetPos(12, y)
	list:SetPadding(8)
	list:SetSpacing(4)

	gamemode.Call("AddExtraOptions", list, Window)

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Death Sound Effect")
	check:SetConVar("tea_cl_deathsfx")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display HUD")
	check:SetConVar("tea_cl_hud")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Play boss stinger music")
	check:SetConVar("tea_cl_soundboss")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Play hitsounds on dealing damage")
	check:SetConVar("tea_cl_hitsounds")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Use decimal values on hud")
	check:SetToolTip("Example:\
	If Enabled: Hunger is displayed as 93.52%\
	If Disabled: Hunger is displayed as 94%")
	check:SetConVar("tea_cl_huddec")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Use reload key to pick up items")
	check:SetToolTip("If enabled, picking up some items requires reload key being held.")
	check:SetConVar("tea_cl_usereloadtopickup")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Disable earringing sound")
	check:SetToolTip("Disables earringing sound when taking an explosion")
	check:SetConVar("tea_cl_noearrings")
	check:SizeToContents()
	list:AddItem(check)
 
	local slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(4, 12)
	slider:SetConVar("tea_cl_deathnoticetime")
	slider:SetText("Deathnotice time (in seconds)")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(3)
	slider:SetMinMax(0, 1)
	slider:SetConVar("tea_cl_hitsounds_volnpc")
	slider:SetText("Hitsound Volume (on damage NPC)")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(3)
	slider:SetMinMax(0, 1)
	slider:SetConVar("tea_cl_hitsounds_vol")
	slider:SetText("Hitsound Volume (on damage player)")
	slider:SizeToContents()
	list:AddItem(slider)

	list:AddItem(EasyLabel(Window, "HUD Style", "Arial_2", color_white))
	local dropdown = vgui.Create("DComboBox", Window)
	dropdown:SetMouseInputEnabled(true)
	dropdown:AddChoice("Classic HUD Style")
	dropdown:AddChoice("After The End Style")
	dropdown.OnSelect = function(me, index, value, data)
		RunConsoleCommand("tea_cl_hudstyle", value == "Classic HUD Style" and 1 or 0)
	end
	dropdown:SetText(GetConVar("tea_cl_hudstyle"):GetInt() == 1 and "Classic HUD Style" or "After The End Style")
	dropdown:SetTextColor(color_black)
	list:AddItem(dropdown)

	list:AddItem(EasyLabel(Window, "Death sound", "Arial_2", color_white))
	local textentry = vgui.Create("DTextEntry", Window)
	textentry:SetConVar("tea_cl_deathsound")
	textentry:SetToolTip("The following sound is played on death\nTip: Use string '*#' at the start of a string to play the sound as music")
	textentry:SetEnterAllowed(true)
	list:AddItem(textentry)
	
	if AdminCheck(LocalPlayer()) then

		list:AddItem(EasyLabel(Window, "Admin Client Options", "TargetIDSmall", color_white))
		check = vgui.Create("DCheckBoxLabel", Window)
		check:SetText("First Person Death")
		check:SetConVar("tea_cl_admin_fpdeath")
		check:SizeToContents()
		list:AddItem(check)

		check = vgui.Create("DCheckBoxLabel", Window)
		check:SetText("No Vision Effects")
		check:SetToolTip("WORK IN PROGRESS!!")
		check:SetConVar("tea_cl_admin_noblur")
		check:SizeToContents()
		list:AddItem(check)

		local button = vgui.Create("DButton", Window)
		button:SetText("Server Options")
		button:SetFont("TargetIDSmall")
		button.DoClick = function()
			MakeServerOptions()
			Window:SetVisible(false)
		end
		list:AddItem(button)


	end

/*
	list:AddItem(EasyLabel(Window, "Health aura color - No health"))
	colpicker = vgui.Create("DColorMixer", Window)
	colpicker:SetAlphaBar(false)
	colpicker:SetPalette(false)
	colpicker:SetConVarR("zs_auracolor_empty_r")
	colpicker:SetConVarG("zs_auracolor_empty_g")
	colpicker:SetConVarB("zs_auracolor_empty_b")
	colpicker:SetTall(72)
	list:AddItem(colpicker)
*/
	Window:SetAlpha(0)
	Window:AlphaTo(255, 0.35, 0)
	Window:MakePopup()
end

function MakeServerOptions()
	if pSVOptions then
		pSVOptions:SetAlpha(0)
		pSVOptions:AlphaTo(255, 0.35, 0)
		pSVOptions:SetVisible(true)
		pSVOptions:MakePopup()
		return
	end

	local Window = vgui.Create("DFrame")
	local wide = math.min(ScrW(), 500)
	local tall = math.min(ScrH(), 600)
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle("")
	Window:SetDraggable(false)
	Window:SetDeleteOnClose(false)
	Window.Paint = function()
		draw.RoundedBox( 2, 0, 0, Window:GetWide(), Window:GetTall(), Color( 0, 0, 0, 200 ) )
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, Window:GetWide(), Window:GetTall())
	end
	pSVOptions = Window

	local y = 8

	local label = EasyLabel(Window, "Server Options", "TargetID", color_white)
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", pSVOptions)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 24, tall - y - 12)
	list:SetPos(12, y)
	list:SetPadding(8)
	list:SetSpacing(4)

	gamemode.Call("AddExtraOptions", list, Window)

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Database Saving")
	check:SetConVar("tea_server_dbsaving")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Spawn Protection")
	check:SetToolTip("Enable temporary protection from damage upon spawning")
	check:SetConVar("tea_server_spawnprotection")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Voluntary PvP")
	check:SetToolTip("Disabled = Forced PvP (100% PvP, players can kill each other freely as long as they don't have their pvp guarded)\nEnabled = PvP is voluntary (Players are free to toggle their PvP)\nNote: Factions don't have friendly fire")
	check:SetConVar("tea_server_voluntarypvp")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Bonus Perks for special players")
	check:SetToolTip("Should enable bonus XP and cash gaining depending on special player?\nIf enabled, uses functions from file server/player_data.lua to increase gaining rewards")
	check:SetConVar("tea_server_bonusperks")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Prop Spawning Cost")
	check:SetToolTip("Should spawning props cost money?\nNote: This also disables gaining cash from salvaging props if this option is disabled")
	check:SetConVar("tea_config_propcostenabled")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Faction Structure Spawning Cost")
	check:SetToolTip("Should spawning faction structures cost money?\nNote: This also disables gaining cash from salvaging faction structures if this option is disabled")
	check:SetConVar("tea_config_factionstructurecostenabled")
	check:SizeToContents()
	list:AddItem(check)

	check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Zombie Apocalypse mode")
	check:SetToolTip("Makes all zombies target players right away, no matter the distance.\nUseful for making events and minigames.\nWARNING!! IF MAP IS LARGE, IT MAY CAUSE SERVER LAG!!!!")
	check:SetConVar("tea_config_zombieapocalypse")
	check:SizeToContents()
	list:AddItem(check)

	local slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 2)
	slider:SetConVar("tea_server_debugging")
	slider:SetText("Debugging Mode")
	slider:SetToolTip("Values:\n\n0 = No debugging mode\n1 = Normal Debugging mode\n2 = Advanced Debugging mode")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(1)
	slider:SetMinMax(0, 60)
	slider:SetConVar("tea_server_respawntime")
	slider:SetText("Respawning Cooldown Time")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(0, 10)
	slider:SetConVar("tea_server_spawnprotection_duration")
	slider:SetText("Spawn Protection Duration")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(0.1, 10)
	slider:SetConVar("tea_server_xpreward")
	slider:SetText("XP Gain Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(0.1, 10)
	slider:SetConVar("tea_server_moneyreward")
	slider:SetText("Money Gain Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(0.2, 5)
	slider:SetConVar("tea_config_zombiehpmul")
	slider:SetText("Zombie Health Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(2)
	slider:SetMinMax(0.4, 3)
	slider:SetConVar("tea_config_zombiespeedmul")
	slider:SetText("Zombie Speed Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 10000)
	slider:SetConVar("tea_config_factioncost")
	slider:SetText("Creating Faction Cost")
	slider:SetToolTip("How much should creating a faction cost?")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 250)
	slider:SetConVar("tea_config_maxcaches")
	slider:SetText("Max amount of caches")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 500)
	slider:SetConVar("tea_config_maxprops")
	slider:SetText("Max amount of props per player")
	slider:SizeToContents()
	list:AddItem(slider)
	
	slider = vgui.Create("DNumSlider", Window)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 500)
	slider:SetConVar("tea_config_propspawndistance")
	slider:SetText("Prop Spawning exclusion distance")
	slider:SetToolTip("Minimum distance from traders where players cannot spawn their props")
	slider:SizeToContents()
	list:AddItem(slider)

	local button = vgui.Create("DButton", Window)
	button:SetText("Client Options")
	button:SetFont("TargetIDSmall")
	button.DoClick = function()
		pSVOptions:SetVisible(false)
		MakeOptions()
	end
	list:AddItem(button)

	Window:SetAlpha(0)
	Window:AlphaTo(255, 0.35, 0)
	Window:MakePopup()
end
