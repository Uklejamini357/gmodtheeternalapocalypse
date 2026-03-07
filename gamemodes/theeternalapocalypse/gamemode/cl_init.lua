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
include("client/cl_tooltip.lua")

GM.HUDs = {}
local files = file.Find(GM.FolderName.."/gamemode/client/hud/*.lua", "LUA")
for _,f in pairs(files) do
	HUD = {}
	HUD.ID = #GM.HUDs+1
	include("client/hud/"..f)
	GM.HUDs[HUD.ID] = HUD
	HUD = nil
end
if GAMEMODE then
	GAMEMODE.HUDs = GM.HUDs
end

include("client/cl_net.lua")
include("cl_killicons.lua")

include("minigames/cl_init.lua")



local death_sound_volume = 0
local death_sound_volume_s = 0
SelectedProp = SelectedProp or "models/props_debris/wood_board04a.mdl" -- need to set this to something here to avoid a massive error spew

function ChooseProp(mdl)
	SelectedProp = mdl
	net.Start("ChangeProp")
	net.WriteString(mdl)
	net.SendToServer()
end

function ChooseStructure( struc )
	SelectedProp = GAMEMODE.SpecialStructureSpawns[struc].Model
	net.Start("ChangeProp")
	net.WriteString(struc)
	net.SendToServer()
end

function BetterScreenScale()
	return math.max(ScrH() / 1080, 0.851)
end

function GM:LocalPlayerDeath(attacker)
	local me = LocalPlayer()

	me.PlayerDead = true

	if self.DeathSoundEffectEnabled then
		self.ActiveDeathSound = CreateSound(me, Sound(self.DeathSound))
		self.ActiveDeathSound:ChangeVolume(self.DeathSoundEffectVolume)
		self.ActiveDeathSound:Play()
	end

	if self.AmbientMusic and self.AmbientMusic:IsPlaying() then
		self.AmbientMusic:FadeOut(1)
		self.NextAmbientMusic = CurTime() + 5
	end

	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0

	self.MyLastSurvivalStats.SurvivalTime = CurTime() - MySurvivaltime
	self.MyLastSurvivalStats.BestSurvivalTime = me.Statistics.BestSurvivalTime
	for k,v in pairs(me.LifeStats) do
		self.MyLastSurvivalStats[k] = v
	end
end

local NextSecond = CurTime()
function GM:Think()
	local me = LocalPlayer()
	if !me:IsValid() then return end
	local frametime = RealFrameTime()

	if me:IsSleeping() then
		self.SleepVisionAffect = math.Approach(self.SleepVisionAffect, 1, 0.5*frametime)
	elseif me:Alive() then
		self.SleepVisionAffect = math.Approach(self.SleepVisionAffect, 0, 0.8*frametime)
	else
		self.SleepVisionAffect = 0
	end

	if self.WraithAlpha > 220 then
		self.WraithAlpha = self.WraithAlpha - (frametime * 4.95)
	elseif self.WraithAlpha > 0 then
		self.WraithAlpha = self.WraithAlpha - (frametime * 30)
	end

	if self.DeathSoundEffectEnabled and self.ActiveDeathSound and self.ActiveDeathSound:IsPlaying() then
		if !me.PlayerDead and me:Alive() then
			self.ActiveDeathSound:FadeOut(1)
			self.ActiveDeathSound = nil
			self.NextAmbientMusic = CurTime() + 15
		end
	end

	if me:Alive() then
		self.tea_screenfadeout = math.Clamp(self.tea_screenfadeout - frametime * (3 * 1.175), 0, 255)
		self.tea_deathtext_a = math.Clamp(self.tea_deathtext_a - frametime * (5 * 1.175), 0, 255)
		self.tea_survivalstats_a = math.Clamp(self.tea_survivalstats_a - frametime * (5 * 1.175), 0, 255)
	else
		self.tea_screenfadeout = self.tea_screenfadeout + frametime * (2.5 * 1.175)
		if 0 < tonumber(self.tea_screenfadeout) - 300 then
			self.tea_deathtext_a = self.tea_deathtext_a + frametime * (2 * 1.175)
		end
		if 0 < tonumber(self.tea_screenfadeout) - 620 then
			self.tea_survivalstats_a = self.tea_survivalstats_a + frametime * (2 * 1.175)
		end
	end

	if RealTime() > (self.NextTip or 0) then
		self.NextTip = RealTime() + 360

		if !self.DisableTips then
			local tea_Tips = {
				{Color(255, 127, 143), "Tip1"},
				{Color(127, 127, 255), "Tip2"},
				{Color(159, 127, 223), "Tip3"},
				{Color(95, 223, 95), "Tip4"},
				{Color(159, 159, 159), "Tip5"},
				{Color(191, 95, 191), "Tip6"},
				{Color(127, 159, 127), "Tip7"},
				{Color(223, 127, 159), "Tip8"},
				{Color(143, 159, 223), "Tip9"},
				{Color(191, 127, 159), "Tip10"},
				{Color(63, 255, 223), "Tip11"},
				{Color(165, 223, 209), "Tip12"},
				{Color(239, 223, 223), "Tip13"},
				{Color(207, 191, 255), "Tip14"},
				{Color(0, 223, 255), "Tip15"},
				{Color(31, 223, 223), "Tip16"},
				{Color(31, 223, 223), "Tip17"},
				{Color(63, 255, 191), "Tip18"},
				{Color(91, 111, 159), "Tip19"},
			}

			local tip = table.Random(tea_Tips)
			chat.AddText(Color(255,255,255), "[", Color(255,223,223), "Tips", Color(255,255,255), "]", Color(223,223,223), ": ", tip[1], translate.Get(tip[2]))
		end
	end

	if NextSecond < CurTime() then
		NextSecond = CurTime() + 1

		if self.AmbientMusicEnabled and me:Alive() and (!self.NextAmbientMusic or self.NextAmbientMusic < CurTime() or self.AmbientMusic and !self.AmbientMusic:IsPlaying())  then
			if self.AmbientMusic and self.AmbientMusic:IsPlaying() then
				self.AmbientMusic:Stop()
			end

			local files = file.Find("sound/music/ambient/*.mp3", "GAME")

			if self.LastAmbientMusic then -- tries not to repeat last music
				table.RemoveByValue(files, self.LastAmbientMusic)
			end

			local snd = table.Random(files)
			local sndfile = "music/ambient/"..snd
			self.AmbientMusic = CreateSound(me, "#"..sndfile)
			self.AmbientMusic:PlayEx(0.3, 100)

			self.LastAmbientMusic = snd
			if self:GetDebug() >= DEBUGGING_NORMAL then
				PrintTable(files)
				print("Playing "..snd..". Duration: "..SoundDuration(sndfile).."s")
			end

			self.NextAmbientMusic = CurTime() + SoundDuration(sndfile) + 15
		end
	end

	if me:Alive() then
		self.LastAliveTime = CurTime()
		me.PlayerDead = nil
	else
		me.PlayerDead = true
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
	-- CreateLegacyFont("AmmoText", "arial", 30, 700, true, false, false, 0, 0, 0)
	CreateLegacyFont("QtyFont", "Trebuchet MS", 24, 500, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont", "Trebuchet MS", 56, 600, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont_2", "Trebuchet MS", 28, 300, true, false, false, 0, 0, 0)
	CreateLegacyFont("DeathScreenFont_3", "Trebuchet MS", 32, 450, false, false, false, 0, 0, 0)
	-- CreateLegacyFont("OtherText", "Trebuchet MS", 15, 700, true, false, false, 0, 0, 0)
	CreateLegacyFont("DamageFloaterFont", "Trebuchet MS", 144, 650, false, false, false, 0, 0, 6)
	CreateLegacyFont("CSSTextFont", "csd", 38, 400, true, false, false, 0, 0, 0)

	local font = "tahoma"
	local antialias = true

	surface.CreateFont( "TargetIDTiny", {
		font = "Trebuchet MS",
		size = 16,
		weight = 600,
		blursize = 0,
		scanlines = 0,
		antialias = antialias,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont("TEA.HUDFont", {
		font = font,
		size = 20,
		weight = 600,
		blursize = 0,
		scanlines = 0,
		antialias = antialias,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true,
	} )

	surface.CreateFont("TEA.HUDFontSmall", {
		font = font,
		size = 14,
		weight = 600,
		blursize = 0,
		scanlines = 0,
		antialias = antialias,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont("TEA.HUDFontSmaller", {
		font = font,
		size = 12,
		weight = 600,
		blursize = 0,
		scanlines = 0,
		antialias = antialias,
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

	self.WraithAlpha = 0
	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0
	self.NextTip = RealTime() + 360
	self.DeathMessage = ""
	self.LastAliveTime = 0
	self.SleepVisionAffect = 0

	self.MyLastSurvivalStats = {}
	self.MyLastSurvivalStats.SurvivalTime = 0
	self.MyLastSurvivalStats.BestSurvivalTime = 0
	self.MyLastSurvivalStats.PlayerKills = 0
	self.MyLastSurvivalStats.ZombieKills = 0
	
	RunConsoleCommand("refresh_inventory")
end

function GM:InitPostEntity()
	net.Start("PlayerIsReady")
	net.SendToServer()

	local me = LocalPlayer()
	self:InitializeLocalPlayer()

	self.HasInitialized = true
	self:LoadMainMenu()
end

function GM:InitializeLocalPlayer()
	local pl = LocalPlayer()
	pl.Stamina = 0
	pl.Oxygen = 0
	pl.Hunger = 0
	pl.Thirst = 0
	pl.Fatigue = 0
	pl.Infection = 0
	MySurvivaltime = 0
	pl.Battery = 0
	MyMoney = 0
	MyXP = 0
	MySP = 0
	MyBounty = 0

	if not pl.Statistics then
		pl.Statistics = {}
	end
	pl.LifeZKills = 0
	pl.LifePlayerKills = 0
	pl.UsingItemTime = 0
	pl.UsingItemDuration = 0
end

function GM:OnReloaded()
	timer.Simple(1, function()
		RunConsoleCommand("refresh_inventory")
	end)

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

function GM:InputMouseApply(cmd, x, y, ang)
	local ply = LocalPlayer()
	if ply:IsValid() and (ply:IsUsingItem() and not ply.UsingItemCanMove or ply:IsSleeping()) then
		cmd:SetMouseX(0)
		cmd:SetMouseY(0)
		
		return true
	end
end

local ang
function GM:CreateMove(cmd)
	local ply = LocalPlayer()

	if (ply:IsUsingItem() and not ply.UsingItemCanMove) or ply:IsSleeping() and ang then
		cmd:SetViewAngles(ang)
	else
		ang = cmd:GetViewAngles()
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
