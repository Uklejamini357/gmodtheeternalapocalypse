GM.Panels = GM.Panels or {}

include("shared.lua")

include("client/cl_scoreboard.lua")
include("client/cl_hud.lua")
include("client/cl_modelsmenu.lua")
include("client/cl_createfaction.lua")
include("client/cl_contextmenu.lua")
include("client/cl_customdeathnotice.lua")
include("client/cl_spawnmenu.lua")
include("client/cl_tradermenu.lua")
include("client/cl_tasksmenu.lua")
include("client/cl_dermahooks.lua")
include("client/cl_lootmenu.lua")
include("client/cl_adminmenu.lua")
include("client/cl_deathscreen.lua")
include("client/cl_statsmenu.lua")
include("client/cl_helpmenu.lua")
include("client/cl_bosspanel.lua")
include("client/cl_options.lua")
include("client/cl_changelogs.lua")
include("client/cl_mainmenu.lua")
include("client/cl_perksmenu.lua")

include("client/cl_net.lua")
include("cl_killicons.lua")

include("minigames/cl_init.lua")



local death_sound_volume = 0
local death_sound_volume_s = 0
local death_sound_current
SelectedProp = SelectedProp or "models/props_debris/wood_board04a.mdl" -- need to set this to something here to avoid a massive error spew

function ChooseProp(mdl)
	SelectedProp = mdl
	net.Start("ChangeProp")
	net.WriteString(mdl)
	net.SendToServer()
end

function ChooseStructure( struc )
	SelectedProp = SpecialSpawns[struc]["Model"]
	net.Start("ChangeProp")
	net.WriteString(struc)
	net.SendToServer()
end

function BetterScreenScale()
	return math.max(ScrH() / 1080, 0.851)
end

function GM:LocalPlayerDeath(attacker)
	local me = LocalPlayer()

	death_sound_volume = tonumber(self.DeathSoundEffectVolume)
	death_sound_volume_s = 0.015 * death_sound_volume
--	death_sound_current = Sound(GetConVar("tea_cl_deathsound"):GetString())
	death_sound_current = CreateSound(me, Sound(self.DeathSound))
	if self.DeathSoundEffectEnabled then
		death_sound_current:Play()
	end

	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0

	self.MyLastSurvivalStats.SurvivalTime = CurTime() - MySurvivaltime
	self.MyLastSurvivalStats.BestSurvivalTime = MyBestsurvtime
	self.MyLastSurvivalStats.ZombiesKilled = me.LifeZKills
	self.MyLastSurvivalStats.PlayersKilled = me.LifePlayerKills
end

function GM:Think()
	local me = LocalPlayer()
	if !me:IsValid() then return end
	local function FrameCalc(number) -- there's a function because possibly when having low framerate, these value updates are less frequent...
		local n = number * (math.max(1 / 66.6, FrameTime()) * 66.6)
		return n
	end

	if me:Alive() then
		self.LastAliveTime = CurTime()
	end

	if self.WraithAlpha > 220 then
		self.WraithAlpha = self.WraithAlpha - (RealFrameTime() * 4.95)
	elseif self.WraithAlpha > 0 then
		self.WraithAlpha = self.WraithAlpha - (RealFrameTime() * 30)
	end

	if self.DeathSoundEffectEnabled and death_sound_current and death_sound_current:IsPlaying() then
		if me:Alive() then
			if death_sound_volume > 0 then
				death_sound_current:ChangeVolume(death_sound_volume)
			else
				death_sound_current:Stop()
			end
		end
	elseif not self.DeathSoundEffectEnabled and death_sound_current then
		death_sound_volume = 0
		death_sound_current:Stop()
	end

	if me:Alive() then
		death_sound_volume = death_sound_volume - FrameCalc(death_sound_volume_s)
		self.tea_screenfadeout = math.Clamp(self.tea_screenfadeout - FrameCalc(3 * 1.175), 0, 255)
		self.tea_deathtext_a = math.Clamp(self.tea_deathtext_a - FrameCalc(5 * 1.175), 0, 255)
		self.tea_survivalstats_a = math.Clamp(self.tea_survivalstats_a - FrameCalc(5 * 1.175), 0, 255)
	else
		self.tea_screenfadeout = self.tea_screenfadeout + FrameCalc(2.5 * 1.175)
		if 0 < tonumber(self.tea_screenfadeout) - 300 then
			self.tea_deathtext_a = self.tea_deathtext_a + FrameCalc(2 * 1.175)
		end
		if 0 < tonumber(self.tea_screenfadeout) - 620 then
			self.tea_survivalstats_a = self.tea_survivalstats_a + FrameCalc(2 * 1.175)
		end
	end

	if RealTime() > (self.NextTip or 0) then
		self.NextTip = RealTime() + 360

		if !self.DisableTips then
			local tea_Tips = {
				{Color(255, 127, 143), translate.Get("Tip1")},
				{Color(127, 127, 255), translate.Get("Tip2")},
				{Color(159, 127, 223), translate.Get("Tip3")},
				{Color(95, 223, 95), translate.Get("Tip4")},
				{Color(159, 159, 159), translate.Get("Tip5")},
				{Color(191, 95, 191), translate.Get("Tip6")},
				{Color(127, 159, 127), translate.Get("Tip7")},
				{Color(223, 127, 159), translate.Get("Tip8")},
				{Color(143, 159, 223), translate.Get("Tip9")},
				{Color(191, 127, 159), translate.Get("Tip10")},
				{Color(63, 255, 223), translate.Get("Tip11")},
				{Color(165, 223, 209), translate.Get("Tip12")},
				{Color(239, 223, 223), translate.Get("Tip13")},
				{Color(207, 191, 255), translate.Get("Tip14")},
				{Color(0, 223, 255), translate.Get("Tip15")},
				{Color(31, 223, 223), translate.Get("Tip16")},
				{Color(31, 223, 223), translate.Get("Tip17")},
				{Color(63, 255, 191), "Press ESCAPE button while having trader panel open to quickly close it!"},
				{Color(91, 111, 159), "Keep an eye on infection level. Zombies become more dangerous, but more rewarding as it goes up..."},
			}

			local tip = table.Random(tea_Tips)
			chat.AddText(Color(255,255,255), "[", Color(255,223,223), "Tips", Color(255,255,255), "]", Color(223,223,223), ": ", tip[1], tip[2])
		end
	end
end

function GM:Tick()
end

local function CreateLegacyFont(name, font, size, weight, antialias, additive, shadow, outline, blursize, scanlines)
	return surface.CreateFont(name, {font = font, size = size, weight = weight, antialias = antialias, additive = additive, shadow = shadow, outline = outline, blursize = blursize, scanlines = scanlines})
--	return surface.CreateFont("DefaultFontSmall", {font = "tahoma", size = 11, weight = 0, blursize = 0, scanlines = 0, antialias = false})
end

function GM:SetupFonts()
	CreateLegacyFont("DefaultFontSmall", "tahoma", 11, 0, false, false, false, 0, 0, 0)
	CreateLegacyFont("AmmoText", "arial", 30, 700, true, false, false, 0, 0, 0)
	CreateLegacyFont("QtyFont", "Trebuchet MS", 24, 500, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont", "Trebuchet MS", 56, 600, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont_2", "Trebuchet MS", 28, 300, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont_3", "Trebuchet MS", 32, 450, false, false, false, 0, 0, 0)
	CreateLegacyFont("OtherText", "Trebuchet MS", 15, 700, true, false, false, 0, 0, 0)
	CreateLegacyFont("DamageFloaterFont", "Trebuchet MS", 144, 650, false, false, false, 0, 0, 6)
	CreateLegacyFont("CSSTextFont", "csd", 38, 400, true, false, false, 0, 0, 0)

	local font = "tahoma"
	local weight = 600
	local antialias = false

	-- These are not used.
/*
	CreateLegacyFont("TEAHUDFontLargest", font, 40, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontLarger", font, 32, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontLarge", font, 28, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFont", font, 24, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontSmall", font, 22, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontSmaller", font, 20, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontSmallest", font, 18, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontTiny", font, 16, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontTinier", font, 14, weight, antialias, false, false, 0, 0, 0)
	CreateLegacyFont("TEAHUDFontTiniest", font, 12, weight, antialias, false, false, 0, 0, 0)
*/


	surface.CreateFont( "Arial_2", {
		font = "Arial",
		size = 14,
		weight = 400,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	
	surface.CreateFont( "TargetIDTiny", {
		font = "Trebuchet MS",
		size = 17,
		weight = 600,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
end

function GM:PreGamemodeLoaded()

end

function GM:Initialize()
	self.BaseClass:Initialize()

	self:SetupFonts()

	MyStamina = 0
	MyHunger = 0
	MyThirst = 0
	MyFatigue = 0
	MyInfection = 0
	MySurvivaltime = 0
	MyBattery = 0
	MyLvl = 0
	MyPrestige = 0
	MyMoney = 0
	MyXP = 0
	MySP = 0
	MyBounty = 0

	MyBestsurvtime = 0
	MyZmbskilled = 0
	MyPlyskilled = 0
	MyPlydeaths = 0
	MyMMeleexp = 0
	MyMMeleelvl = 0
	MyMPvpxp = 0
	MyMPvplvl = 0
	
	LocalInventory = {}
	LocalVault = {}
	InventoryItems = {}
	InventoryWeapons = {}
	Perks = {}
	Perksdesc = {}

	self.WraithAlpha = 0
	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0
	self.NextTip = RealTime() + 360
	self.DeathMessage = ""
	self.LastAliveTime = 0

	self.MyLastSurvivalStats = {}
	self.MyLastSurvivalStats.SurvivalTime = 0
	self.MyLastSurvivalStats.BestSurvivalTime = 0
	self.MyLastSurvivalStats.PlayersKilled = 0
	self.MyLastSurvivalStats.ZombiesKilled = 0
	
	RunConsoleCommand("refresh_inventory")
end

function GM:InitPostEntity()
	net.Start("PlayerIsReady")
	net.SendToServer()

	local me = LocalPlayer()

	death_sound_current = CreateSound(me, Sound(self.DeathSound))

	me.LifeZKills = 0
	me.LifePlayerKills = 0

	self.HasInitialized = true
	self:LoadMainMenu()
end


function GM:OnReloaded()
	timer.Simple(1, function()
		RunConsoleCommand("refresh_inventory")
	end)
	death_sound_current = CreateSound(LocalPlayer(), Sound(self.DeathSound))
	print(self.Name.." gamemode files reloaded")
end

function GM:ShutDown()
end

function GM:PostProcessPermitted(name)
	return false
end

function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function EasyButton(parent, text, xpadding, ypadding)
	local dpanel = vgui.Create("DButton", parent)
	if textcolor then
		dpanel:SetFGColor(textcolor or color_white)
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()

	if xpadding then
		dpanel:SetWide(dpanel:GetWide() + xpadding * 2)
	end

	if ypadding then
		dpanel:SetTall(dpanel:GetTall() + ypadding * 2)
	end

	return dpanel
end

ChosenModel = ""

function DeathView(pl, origin, angles, fov)
	local View

	if !pl:Alive() then
		local rag = pl:GetRagdollEntity()

		if rag:IsValid() and pl:GetObserverMode() == OBS_MODE_NONE then
			local Eyes = rag:GetAttachment(rag:LookupAttachment("Eyes"))
			if Eyes then
				View = {origin = Eyes.Pos, angles = Eyes.Ang, fov = 90}
				return View
			end
		else
			View = {origin = pl:GetPos()}
			return View
		end
	end
end
hook.Add("CalcView", "DeathView", DeathView, HOOK_LOW)

function GM:OnUndo(name, str)
	-- this is still needed by the test zombies function
	notification.AddLegacy("Undone "..name, 2, 3)
	surface.PlaySound("buttons/button15.wav")
end

function GM:SpawnMenuEnabled()
	return true
end

function GM:SpawnMenuOpen()
	return true
end

function GM:ContextMenuOpen()
	return true
end




/* -- i guess this one is a bit buggy
function GM:OnPlayerChat(ply, text, team, dead)
	local tab = {}
	if dead or (IsValid(ply) and ply:Team() == TEAM_DEAD) then
		table.insert(tab, Color(191, 30, 40))
		table.insert(tab, "*Dead* ")
	end

	if team then
		table.insert(tab, Color(30, 160, 40))
		table.insert(tab, "(Team) ")
	end

	if IsValid(ply) then
		local col = Color(160,160,160)
		if ply:SteamID64() == "76561198274314803" then
			table.insert(tab, col)
			table.insert(tab, "[")
			table.insert(tab, Color(224,224,160))
			table.insert(tab, "Gamemode Author")
			table.insert(tab, col)
			table.insert(tab, "] ")
		elseif TEASVOwnerCheck(ply) then
			table.insert(tab, col)
			table.insert(tab, "[")
			table.insert(tab, Color(160,0,0))
			table.insert(tab, "Server Owner")
			table.insert(tab, col)
			table.insert(tab, "] ")	
		elseif TEADevCheck(ply) then
			table.insert(tab, col)
			table.insert(tab, "[")
			table.insert(tab, Color(160,160,192))
			table.insert(tab, "Dev")
			table.insert(tab, col)
			table.insert(tab, "] ")
		elseif SuperAdminCheck(ply) then
			table.insert(tab, col)
			table.insert(tab, "[")
			table.insert(tab, Color(96,96,160))
			table.insert(tab, "Superadmin")
			table.insert(tab, col)
			table.insert(tab, "] ")
		elseif AdminCheck(ply) then
			table.insert(tab, col)
			table.insert(tab, "[")
			table.insert(tab, Color(160,128,160))
			table.insert(tab, "Admin")
			table.insert(tab, col)
			table.insert(tab, "] ")
		end

		table.insert(tab, ply)
	else
		table.insert(tab, "Console")
	end

	table.insert(tab, Color(255,255,255))
	table.insert(tab, ": "..text)

	chat.AddText(unpack(tab))
	return true
end
*/
function GM:PlayerBindPress(pl, key, wasin)
--	local str1, str2 = string.find("+forward", bind)
--	print(bind, str1, str2)
--	if str1 and str2 then return true end

	if key == "gm_showhelp" then
		self:HelpMenu()
	elseif key == "gm_showteam" then
		if !SuperAdminCheck(pl) then return false end
		gamemode.Call("AdminMenu")
	-- elseif key == "gm_showspare1" then -- Disabled, I will make something better with it
		-- gamemode.Call("DropGoldMenu")
	elseif key == "gm_showspare2" then
		gamemode.Call("MakeOptions")
	elseif key == "+menu_context" then
	elseif key == "+menu" then
	end
end

function GM:KeyRelease(pl, key)
	if key == input.LookupBinding("+menu_context") then
		if !IsValid(ContextMenu) then return end
		ContextMenu:SetVisible(false)
		ContextMenu:Remove()
	elseif key == input.LookupBinding("+menu") then
		if IsValid(PropsFrame) then
			PropsFrame:Close()
		end
	end
end



/*
	surface.CreateFont("DefaultFontSmall", {
		font = "tahoma",
		size = 11,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = false
	})
	surface.CreateFont("AmmoText", {
		font	= "arial",
		size	= 30,
		weight	= 700,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("QtyFont", {
		font = "Trebuchet MS",
		size = 24,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
	})

	surface.CreateFont("DeathScreenText", {
		font	= "Trebuchet MS",
		size	= 56,
		weight	= 600,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DeathScreenText_2", {
		font	= "Trebuchet MS",
		size	= 28,
		weight	= 300,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DeathScreenText_3", {
		font	= "arial",
		size	= 32,
		weight	= 450,
		blursize	= 0,
		scanlines	= 0,
		antialias	= false,
	})
	
	surface.CreateFont("OtherText", {
		font	= "arial",
		size	= 15,
		weight	= 700,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DamageFloaterFont", {
		font	= "arial",
		size	= 144,
		weight	= 650,
		blursize	= 0,
		scanlines	= 6,
		antialias	= false,
	})

	surface.CreateFont("CSSTextFont", {
	    font	= "csd",
	    size	= 38,
	    weight	= 400,
	    antialias	= true,
	    shadow	= false
	})
*/
