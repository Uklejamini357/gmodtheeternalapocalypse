local pOptions
local pSVOptions

local function CreateCheckLabel(panel, list, text, cvar)
	check = vgui.Create("DCheckBoxLabel", panel)
	check:SetText(text)
	check:SetConVar(cvar)
	check:SizeToContents()
	list:AddItem(check)

	return check
end

local function CreateSlider(panel, list, text, cvar)
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetConVar(cvar)
	cvar = GetConVar(cvar)
	slider:SetMinMax(cvar:GetMin(), cvar:GetMax())
	slider:SetText(text)
	slider:SizeToContents()
	list:AddItem(slider)

	return slider
end



function GM:MakeOptions()
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

	local pan = vgui.Create("DFrame")
	local wide = math.min(ScrW(), 500)
	local tall = math.min(ScrH(), 700)
	pan:SetSize(wide, tall)
	pan:Center()
	pan:SetTitle("")
	pan:SetDraggable(false)
	pan:SetDeleteOnClose(false)
	pan.Paint = function()
		draw.RoundedBox(2, 0, 0, pan:GetWide(), pan:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, pan:GetWide(), pan:GetTall())
	end
	pOptions = pan

	local y = 8

	local label = EasyLabel(pan, "Options", "TargetID", color_white)
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", pOptions)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 24, tall - y - 12)
	list:SetPos(12, y)
	list:SetPadding(8)
	list:SetSpacing(4)

--	gamemode.Call("AddExtraOptions", list, pan)


	local check = CreateCheckLabel(pan, list, "Death Sound Effect", "tea_cl_deathsfx")
	check = CreateCheckLabel(pan, list, "Display HUD", "tea_cl_hud")
	check = CreateCheckLabel(pan, list, "Play boss stinger music", "tea_cl_soundboss")
	check = CreateCheckLabel(pan, list, "Play hitsounds on dealing damage", "tea_cl_hitsounds")
	check = CreateCheckLabel(pan, list, "Use decimal values on hud", "tea_cl_huddec")
	check:SetToolTip("Example:\
	If Enabled: Hunger is displayed as 93.52%\
	If Disabled: Hunger is displayed as 94%")
	
	check = CreateCheckLabel(pan, list, "Use reload key to pick up items", "tea_cl_usereloadtopickup")
	check:SetToolTip("If enabled, picking up some items requires reload key being held.")
	
	check = CreateCheckLabel(pan, list, "Disable earringing sound", "tea_cl_noearrings")
	check:SetToolTip("Disables earringing sound when taking an explosion")

	check = CreateCheckLabel(pan, list, "Disable tips", "tea_cl_notips")
	check:SetToolTip("Disables tips being displayed in chat.")

	check = CreateCheckLabel(pan, list, "Draw zombie info", "tea_cl_drawzinfo")
	check:SetToolTip("Draws zombie information (Name, health and its' purpose (or what it is meant to do))")

	local slider = CreateSlider(pan, list, "Death sound effect volume", "tea_cl_deathsfx_vol")
	slider:SetDecimals(2)
	slider:SetToolTip("Death sound effect varies on game volume and this value.")
	
	slider = CreateSlider(pan, list, "Deathnotice time (in seconds)", "tea_cl_deathnoticetime")
	slider:SetDecimals(2)

	slider = CreateSlider(pan, list, "Hitsound Volume (on damage NPC)", "tea_cl_hitsounds_volnpc")
	slider:SetDecimals(3)

	slider = CreateSlider(pan, list, "Hitsound Volume (on damage player)", "tea_cl_hitsounds_vol")
	slider:SetDecimals(3)
	
	slider = CreateSlider(pan, list, "Damage number scale", "tea_cl_damagenumber_scale")
	slider:SetDecimals(2)
	
	slider = CreateSlider(pan, list, "Damage number speed", "tea_cl_damagenumber_speed")
	slider:SetDecimals(2)
	
	slider = CreateSlider(pan, list, "Damage number lifetime", "tea_cl_damagenumber_lifetime")
	slider:SetDecimals(2)

	list:AddItem(EasyLabel(pan, "HUD Style", "Arial_2", color_white))
	local dropdown = vgui.Create("DComboBox", pan)
	dropdown:SetMouseInputEnabled(true)
	dropdown:AddChoice("Classic HUD Style")
	dropdown:AddChoice("After The End Style")
	dropdown:AddChoice("The Eternal Apocalypse Style")
	dropdown.OnSelect = function(me, index, value, data)
		RunConsoleCommand("tea_cl_hudstyle", value == "The Eternal Apocalypse Style" and 2 or value == "Classic HUD Style" and 1 or 0)
	end
	local convarvalue = GetConVar("tea_cl_hudstyle"):GetInt()
	dropdown:SetText(convarvalue == 2 and "The Eternal Apocalypse Style" or convarvalue == 1 and "Classic HUD Style" or "After The End Style")
	dropdown:SetTextColor(color_black)
	list:AddItem(dropdown)

	list:AddItem(EasyLabel(pan, "Death sound", "Arial_2", color_white))
	local textentry = vgui.Create("DTextEntry", pan)
	textentry:SetConVar("tea_cl_deathsound")
	textentry:SetToolTip("The following sound is played on death\nTip: Use string '*#' at the start of a string to play the sound as music")
	textentry:SetEnterAllowed(true)
	list:AddItem(textentry)
	
	if AdminCheck(LocalPlayer()) then

		local button = vgui.Create("DButton", pan)
		button:SetText("Server Options")
		button:SetFont("TargetIDSmall")
		button.DoClick = function()
			MakeServerOptions()
			pan:SetVisible(false)
		end
		list:AddItem(button)


	end

/*
	list:AddItem(EasyLabel(pan, "Health aura color - No health"))
	colpicker = vgui.Create("DColorMixer", pan)
	colpicker:SetAlphaBar(false)
	colpicker:SetPalette(false)
	colpicker:SetConVarR("zs_auracolor_empty_r")
	colpicker:SetConVarG("zs_auracolor_empty_g")
	colpicker:SetConVarB("zs_auracolor_empty_b")
	colpicker:SetTall(72)
	list:AddItem(colpicker)
*/
	pan:SetAlpha(0)
	pan:AlphaTo(255, 0.35, 0)
	pan:MakePopup()
end

function MakeServerOptions()
	if pSVOptions then
		pSVOptions:SetAlpha(0)
		pSVOptions:AlphaTo(255, 0.35, 0)
		pSVOptions:SetVisible(true)
		pSVOptions:MakePopup()
		return
	end

	local pan = vgui.Create("DFrame")
	local wide = math.min(ScrW(), 500)
	local tall = math.min(ScrH(), 700)
	pan:SetSize(wide, tall)
	pan:Center()
	pan:SetTitle("")
	pan:SetDraggable(false)
	pan:SetDeleteOnClose(false)
	pan.Paint = function()
		draw.RoundedBox( 2, 0, 0, pan:GetWide(), pan:GetTall(), Color( 0, 0, 0, 200 ) )
		surface.SetDrawColor(150, 150, 0 ,255)
		surface.DrawOutlinedRect(0, 0, pan:GetWide(), pan:GetTall())
	end
	pSVOptions = pan

	local y = 8

	local label = EasyLabel(pan, "Server Options", "TargetID", color_white)
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", pSVOptions)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 24, tall - y - 12)
	list:SetPos(12, y)
	list:SetPadding(8)
	list:SetSpacing(4)

	gamemode.Call("AddExtraOptions", list, pan)

	local check = CreateCheckLabel(pan, list, "Enable Database Saving", "tea_server_dbsaving")
	check = CreateCheckLabel(pan, list, "Enable Spawn Protection", "tea_server_spawnprotection")
	check:SetToolTip("Enable temporary protection from damage upon spawning")
	
	check = CreateCheckLabel(pan, list, "Enable Voluntary PvP", "tea_server_voluntarypvp")
	check:SetToolTip("Disabled = Forced PvP (100% PvP, players can kill each other freely as long as they don't have their pvp guarded)\nEnabled = PvP is voluntary (Players are free to toggle their PvP)\nNote: Factions don't have friendly fire")
	
	check = CreateCheckLabel(pan, list, "Enable Bonus Perks for special players", "tea_server_bonusperks")
	check:SetToolTip("Should enable bonus XP and cash gaining depending on special player?\nIf enabled, uses functions from file server/player_data.lua to increase gaining rewards")
	
	check = CreateCheckLabel(pan, list, "Enable Prop Spawning Cost", "tea_config_propcostenabled")
	check:SetToolTip("Should spawning props cost money?\nNote: This also disables gaining cash from salvaging props if this option is disabled")
	
	check = CreateCheckLabel(pan, list, "Enable Faction Structure Spawning Cost", "tea_config_factionstructurecostenabled")
	check:SetToolTip("Should spawning faction structures cost money?\nNote: This also disables gaining cash from salvaging faction structures if this option is disabled")
	
	check = CreateCheckLabel(pan, list, "Enable Spawn Protection", "tea_server_spawnprotection")
	check:SetText("Enable Zombie Apocalypse mode")
	check:SetToolTip("Makes all zombies target players right away, no matter the distance.\nUseful for making events and minigames.\nWARNING!! IF MAP IS LARGE, IT MAY CAUSE SERVER LAG!!!!")
	check:SetConVar("tea_config_zombieapocalypse")

	local slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 4)
	slider:SetConVar("tea_server_debugging")
	slider:SetText("Debugging Mode")
	slider:SetToolTip("Values:\n\n0 = No debugging mode\n1 = Normal Debugging mode\n2 = Advanced Debugging mode")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(1)
	slider:SetMinMax(0, 60)
	slider:SetConVar("tea_server_respawntime")
	slider:SetText("Respawning Cooldown Time")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(2)
	slider:SetMinMax(0, 10)
	slider:SetConVar("tea_server_spawnprotection_duration")
	slider:SetText("Spawn Protection Duration")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(2)
	slider:SetMinMax(0.1, 10)
	slider:SetConVar("tea_server_xpreward")
	slider:SetText("XP Gain Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(2)
	slider:SetMinMax(0.1, 10)
	slider:SetConVar("tea_server_moneyreward")
	slider:SetText("Money Gain Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(2)
	slider:SetMinMax(0.2, 5)
	slider:SetConVar("tea_config_zombiehpmul")
	slider:SetText("Zombie Health Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(2)
	slider:SetMinMax(0.4, 3)
	slider:SetConVar("tea_config_zombiespeedmul")
	slider:SetText("Zombie Speed Multiplier")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 10000)
	slider:SetConVar("tea_config_factioncost")
	slider:SetText("Creating Faction Cost")
	slider:SetToolTip("How much should creating a faction cost?")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 250)
	slider:SetConVar("tea_config_maxcaches")
	slider:SetText("Max amount of caches")
	slider:SizeToContents()
	list:AddItem(slider)

	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 500)
	slider:SetConVar("tea_config_maxprops")
	slider:SetText("Max amount of props per player")
	slider:SizeToContents()
	list:AddItem(slider)
	
	slider = vgui.Create("DNumSlider", pan)
	slider:SetDecimals(0)
	slider:SetMinMax(0, 500)
	slider:SetConVar("tea_config_propspawndistance")
	slider:SetText("Prop Spawning exclusion distance")
	slider:SetToolTip("Minimum distance from traders where players cannot spawn their props")
	slider:SizeToContents()
	list:AddItem(slider)

	local button = vgui.Create("DButton", pan)
	button:SetText("Client Options")
	button:SetFont("TargetIDSmall")
	button.DoClick = function()
		pSVOptions:SetVisible(false)
		gamemode.Call("MakeOptions")
	end
	list:AddItem(button)

	pan:SetAlpha(0)
	pan:AlphaTo(255, 0.35, 0)
	pan:MakePopup()
end
