---------------- HUD ----------------

local Spawn = 0


-- Cache commonly found values in this code (because trust me it's faster if done that way)
local draw_DrawText = draw.DrawText
local draw_RoundedBox = draw.RoundedBox
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize


net.Receive("tea_updatestamina", function(len) -- this net message is received once per frame
	local pl = LocalPlayer()

	if not pl:IsValid() then return end
	pl.Stamina = net.ReadFloat()
	pl.Oxygen = net.ReadFloat()
end)

net.Receive("UpdateStats", function(len) -- this net message is received once every second
	local pl = LocalPlayer()

	if not pl:IsValid() then return end
	pl.Hunger = net.ReadFloat()
	pl.Thirst = net.ReadFloat()
	pl.Fatigue = net.ReadFloat()
	pl.Infection = net.ReadFloat()
	MySurvivaltime = net.ReadFloat()
	pl.Battery = net.ReadFloat()
end)

net.Receive("UpdatePeriodicStats", function(len) -- this net message is only received when one of these values need to be updated
	local pl = LocalPlayer()

	if not pl:IsValid() then return end
	pl.Money = net.ReadFloat()
	MyXP = net.ReadFloat()
	MySP = net.ReadFloat()
	MyPerkPoints = net.ReadFloat()
	MyBounty = net.ReadFloat()
end)



local XPColor = Color(255, 255, 255, 0)
local XPGained = 0
local TotalXPGained = 0
local MoneyColor = Color(255, 255, 255, 0)
local MoneyGained = 0
local TotalMoneyGained = 0
local MasteryType = 0
local MasteryXPGained = 0
local MasteryColor = Color(205, 205, 205, 0)

function GM:HUDDrawTargetID()
	return false
end

net.Receive("Payout", function(length)
	local xpgain = net.ReadFloat()
	local moneygain = net.ReadFloat()

	XPGained = xpgain
	MoneyGained = moneygain

	TotalXPGained = TotalXPGained + xpgain
	TotalMoneyGained = TotalMoneyGained + moneygain

	if XPGained != 0 then
		XPColor = Color(255,255,255,155)
	end
	if MoneyGained != 0 then
		MoneyColor = Color(255,255,255,155)
	end
	timer.Create("payout_timer", 2.75, 1, function()
		XPColor = Color(255, 255, 255, 0)
		TotalXPGained = 0
		MoneyColor = Color(255, 255, 255, 0)
		TotalMoneyGained = 0
	end)
end)

net.Receive("GainMasteryProgress", function(length)
	local masterytype = net.ReadString()
	local masteryxpgain = net.ReadFloat()

	MasteryType = masterytype
	MasteryXPGained = masteryxpgain
	if MasteryXPGained != 0 then MasteryColor = Color(205, 205, 205, 255) end
	timer.Create("gainmasteryprogress_timer", 3.35, 1, function() MasteryColor = Color(205, 205, 205, 0) end)
end)

net.Receive("UpdateRespawnTimer", function(length)
	Spawn = net.ReadFloat()
end)

local function GetMyPvP(pl)
	if LocalPlayer():IsPvPGuarded() then return 2 end
	if !GAMEMODE.VoluntaryPvP then return 5 end
	if LocalPlayer():Team() == TEAM_LONER and LocalPlayer():GetNWBool("pvp") then return 3 end
	if LocalPlayer():Team() ~= TEAM_LONER then return 3 end
	if LocalPlayer():IsPvPForced() then return 4 end
	return 1
end

local lastent
local lastdraw = 0

function GM:DrawNames()
	local me = LocalPlayer()
	local trace = {}

	trace.start = me:EyePos()
	trace.endpos = trace.start + me:GetAimVector() * 1500
	trace.filter = me
	
	local tr = util.TraceLine(trace)
	local ent = tr.Entity
	local npcent = lastdraw + 1 > CurTime() and (IsValid(lastent) and lastent) or ent or NULL

	if ent:IsValid() and ent:IsPlayer() and ent != me and ent:Alive() then
		local headPos = (ent:GetShootPos() + Vector(0,0,18)):ToScreen()
		surface_SetFont("TEA.HUDFont")

		
		local message = ent:Nick()
		local wo, ho = surface_GetTextSize(message)
		
		surface_SetFont("TEA.HUDFontSmall")
		local stats = {}
		stats[1] = ent:Health()
		stats[2] = ent:GetMaxHealth()
		stats[3] = ent:Armor()
		stats[4] = ent:GetMaxArmor()
		stats[5] = ent:GetNWInt("PlyLevel", 1)
		stats[6] = tonumber(ent:GetNWInt("PlyPrestige", 0))
		stats[7] = math.floor(ent:GetNWInt("PlyBounty", 0))
		stats[8] = team.GetName(ent:Team())

		local message2 = translate.Format("health", stats[1], stats[2])
		local wo2, ho2 = surface_GetTextSize(message2)

		local message3 = translate.Format("armor", stats[3], stats[4])
		local wo3, ho3 = surface_GetTextSize(message3)
 
		local message4 = translate.Format("level_prestige", stats[5], stats[6])
		local wo4, ho4 = surface_GetTextSize(message4)
 
		local message5 = translate.Format("bounty", stats[7])
		local wo5, ho5 = surface_GetTextSize(message5)
	
		local message6 = translate.Format("faction", stats[8])
		local wo6, ho6 = surface_GetTextSize(message6)

		if ent:IsPvPGuarded() then
			draw.SimpleTextOutlined("p", "CSSTextFont", headPos.x - 15, headPos.y - 62, Color(50, 250, 0, 255), 0, 0, 2, Color(0, 50, 0, 255))
		elseif ent:IsPvPForced() or (ent:Team() == TEAM_LONER and ent:GetNWBool("pvp") == true) or ((ent:Team() != TEAM_LONER and ent:Team() != me:Team()) or (ent:Team() == TEAM_LONER and !self.VoluntaryPvP)) then
			draw.SimpleTextOutlined("C", "CSSTextFont", headPos.x - 25, headPos.y - 60, Color(255, 50, 0, 255), 0, 0, 2, Color(50, 0, 0, 255))
		end

		draw.SimpleTextOutlined(ent:Nick(), "TEA.HUDFont", headPos.x - (wo /2), headPos.y - 40, Color(255, 255, 255, 255), 0, 0, 2, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("health", stats[1], stats[2]), "TEA.HUDFontSmall", headPos.x - (wo2 / 2), headPos.y - 20, Color(255, math.Clamp(((ent:Health() * 100) / ent:GetMaxHealth()) * 2.5, 0, 255), math.Clamp(((ent:Health() * 100) / ent:GetMaxHealth()) * 2.5, 0, 255), 255), 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("armor", stats[3], stats[4]), "TEA.HUDFontSmall", headPos.x - (wo3 / 2), headPos.y - 7, Color(math.Clamp((50 + (ent:Armor() * 100) / ent:GetMaxArmor()), 0, 255), math.Clamp((50 + (ent:Armor() * 100) / ent:GetMaxArmor()), 0, 255), 255, 255), 0, 0, 1, Color(0, 0, 0, 255))
		local prestige_color = stats[6] >= 100 and HSVToColor(CurTime() * math.min(stats[6] * 0.4, 100) % 360, 0.5, 1) or Color(255, 205, 255, 255)
		draw.SimpleTextOutlined(translate.Format("level_prestige", stats[5], stats[6]), "TEA.HUDFontSmall", headPos.x - (wo4 / 2) - 2, headPos.y + 7, prestige_color, 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("bounty", stats[7]), "TEA.HUDFontSmall", headPos.x - (wo5 / 2) - 2, headPos.y + 20, Color(255, 64, 64, 255), 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("faction", stats[8]), "TEA.HUDFontSmall", headPos.x - (wo6 / 2) - 2, headPos.y + 33, team.GetColor(ent:Team()), 0, 0, 1, Color(0, 0, 0, 255))

	end

	if npcent and npcent:IsValid() and (npcent:IsNPC() or npcent:IsNextBot()) and (self.Config["ZombieClasses"][npcent:GetClass()] or self.Config["BossClasses"][npcent:GetClass()]) and self.DrawZombiesInfo and self:GetDebug() >= DEBUGGING_ADVANCED then
		if ent and ent:IsValid() and (ent:IsNPC() or ent:IsNextBot()) and (self.Config["ZombieClasses"][ent:GetClass()] or self.Config["BossClasses"][ent:GetClass()]) then
			lastent = ent
			lastdraw = CurTime()
		end
		local colormult = lastdraw + 1 - CurTime()

		draw_RoundedBox(1, (ScrW() / 2) - 170, 210, 340, 75, Color(0, 0, 0, colormult * 175))
		surface_SetDrawColor(90,0,0,colormult * 155)
		surface_DrawOutlinedRect((ScrW() / 2) - 170, 210, 340, 75)

		local class = self.Config["ZombieClasses"][npcent:GetClass()] or self.Config["BossClasses"][npcent:GetClass()]
		draw.SimpleText(class.Name..(npcent:GetEliteVariant() ~= 0 and " (Elite variant: "..(self.VariantNames[npcent:GetEliteVariant()] or "N/A")..")" or ""), "TEA.HUDFontSmall", (ScrW() / 2) - 160, 224, Color(108,108,108,colormult * 255), 0, 1)
		draw.SimpleText(translate.Format("health", npcent:Health(), npcent:GetMaxHealth()), "TEA.HUDFontSmall", (ScrW() / 2) - 160, 242, Color(math.Clamp(255 * (npcent:Health() / npcent:GetMaxHealth()), 127, 255),48,48,colormult * 255), 0, 1)
		draw.SimpleText("Level: "..npcent:GetZombieLevel(), "TEA.HUDFontSmall", (ScrW() / 2) - 160, 260, Color(255, 127, 255, colormult * 255), 0, 1)
		draw.SimpleText(tostring(npcent.Purpose), "DefaultFontSmall", (ScrW() / 2) - 160, 276, Color(148,148,148,colormult * 255), 0, 1)
	end
end

function surface.DrawRectColor(x, y, w, h, col)
	surface_SetDrawColor(col or color_white)
	surface_DrawRect(x,y,w,h)
end

--	local HealthTexture = surface.GetTextureID("gui/silkicons/heart")
--	local ArmorTexture = surface.GetTextureID("gui/silkicons/shield")

local cl_drawhud = GetConVar("cl_drawhud")
function GM:DrawVitals()
	local me = LocalPlayer()
	local pl = me
	local wep = me:GetActiveWeapon()
	if !me:IsValid() or !me:Alive() or !self.HUDEnabled or cl_drawhud:GetInt() < 1 or me:GetObserverMode() ~= OBS_MODE_NONE or wep:IsValid() and wep:GetClass() == "gmod_camera" then return end
	local scrw = ScrW()
	local scrh = ScrH()

	local Health = me:Health()
	local MaxHealth = me:GetMaxHealth()
	local Armor = me:Armor()
	local MaxArmor = me:GetMaxArmor()

	local SWEP
	local weapon = me:GetActiveWeapon()
	if weapon != NULL then
		SWEP = {}
		SWEP.Class = weapon:GetClass()
		SWEP.AmmoClip1 = weapon:Clip1()
		SWEP.AmmoClip2 = weapon:Clip2()
		SWEP.MaxAmmoClip1 = weapon:GetMaxClip1()
		SWEP.MaxAmmoClip2 = weapon:GetMaxClip2()
		SWEP.MaxAmmoType = me:GetAmmoCount(weapon:GetPrimaryAmmoType())
		SWEP.MaxAmmoType2 = me:GetAmmoCount(weapon:GetSecondaryAmmoType())
	end

	local cansprint = me:GetCanSprint()
	-- local DGradientCenter = surface.GetTextureID("gui/center_gradient")

	local glow = math.abs(math.sin(CurTime() * 1.7) * 255)
	local y = 300

	if me.Infection > 9000 then
		draw.SimpleText(translate.Get("infection_high"), "TEA.HUDFont", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if me.Fatigue > 9000 then
		draw.SimpleText(translate.Get("fatigue_high"), "TEA.HUDFont", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if me.Thirst < 1000 then
		draw.SimpleText(translate.Get("thirst_low"), "TEA.HUDFont", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if me.Hunger < 1000 then
		draw.SimpleText(translate.Get("hunger_low"), "TEA.HUDFont", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
	end


	local hud = self.HUDs[self.HUDStyle] or self.HUDs[1]
	if hud and hud.DrawHealth then
		hud:DrawHealth(pl, scrw, scrh)
	end
	if hud and hud.DrawStats then
		hud:DrawStats(pl, scrw, scrh)
	end
	if hud and hud.DrawSwep then
		hud:DrawSwep(pl, scrw, scrh, SWEP)
	end

	--Max Weight
	local weight = LocalPlayer():CalculateWeight()
	local maxweight = LocalPlayer():CalculateMaxWeight()
	local maxwalkweight = LocalPlayer():CalculateMaxWalkWeight()

	local _y = 155
	if not self.NoInvWeightHUDDisplay then
		draw.SimpleText(translate.Format("inv_weight", weight, WEIGHT_UNIT, maxweight, WEIGHT_UNIT, maxwalkweight, WEIGHT_UNIT), "TEA.HUDFontSmall", 20, _y, Color(205, 205, 205, 255), 0, 1)
		_y = _y + 20
	end
	if weight >= maxwalkweight then
		draw.SimpleText("Carrying too much, cannot move!", "TEA.HUDFontSmall", 20, _y, Color(205, 55, 55), 0, 1)
	elseif weight >= maxweight then
		draw.SimpleText("Carrying too much, speed penalty x"..math.Round(math.Clamp(0.2 + ((maxwalkweight - maxweight) - (weight - maxweight)) / ((maxwalkweight - maxweight)/0.6), 0.2, 0.8), 2).."!", "TEA.HUDFontSmall", 20, _y, Color(205, 205, 55, 205), 0, 1)
	end


	if me.Oxygen < 100 then
		draw.SimpleText(Format("Oxygen: %d%%", math.Round(me.Oxygen)), "TargetIDTiny", ScrW()/2, 186, Color(205, 205, 255), TEXT_ALIGN_CENTER, 0)
		-- surface_SetDrawColor()
		draw_RoundedBox(2, 210, scrh - 176, 160, 15, Color(50, 50, 0, 100))
		if me.Stamina > 0 then
			local staminabarclamp = math.Clamp(me.Stamina * 1.6, 0, 160)
			draw_RoundedBox(4, 210, scrh - 176, staminabarclamp, 15, Color(100, 150, 0, 160))
			draw_RoundedBox(4, 210, scrh - 176, staminabarclamp, 8, Color(100, 150, 0, 160))
		end
	end



--	draw.SimpleText("Height difference: "..math.Round(me:GetPos().z - me:GetEyeTrace().HitPos.z), "TEA.HUDFontSmall", ScrW() / 2, 255, Color(205, 205, 205, 255), 1, 1)

	local tr = me:GetEyeTrace()
	local y = 172
	if self:GetDebug() >= DEBUGGING_NORMAL then
		draw.SimpleText(translate.Get(GetGlobalBool("GM.ZombieSpawning") and "zspawnon" or "zspawnoff"), "TEA.HUDFontSmall", 20, y, Color(255, 255, 205), 0, 1)
		y = y + 16
	end
	if self:GetDebug() >= DEBUGGING_ADVANCED then
		draw.SimpleText("Curtime: "..math.Round(CurTime(), 3), "TEA.HUDFontSmall", 20, y, Color(205,255,205), 0, 1)
		y = y + 8

		draw.SimpleText("Trace Entity: "..tostring(tr.Entity), "TEA.HUDFontSmall", 20, y, Color(205,205,255), 0, 0)
		y = y + 22
		if tr.Entity and tr.Entity:IsValid() and tr.Entity:Health() > 0 then
			y = y - 8
			draw.SimpleText("Ent HP: "..tr.Entity:Health().."/"..tr.Entity:GetMaxHealth(), "TEA.HUDFontSmall", 20, y, Color(205,205,255), 0, 0)
			y = y + 22
		end

		draw.SimpleText("Held weapon: "..tostring(weapon), "TEA.HUDFontSmall", 20, y, Color(205,205,255), 0, 1)
		y = y + 22
	end

	if self:GetServerRestartTime() ~= 0 then
		draw_DrawText(translate.Format("server_restart_in", util.ToMinutesSeconds(math.max(0, self:GetServerRestartTime() - CurTime()))), "TEA.HUDFont", ScrW()/2, 180, Color(255,255,255), TEXT_ALIGN_CENTER)
	end

	if self:GetEventTimer() ~= -1 and self:GetEvent() ~= EVENT_NONE then
		local events = {
			[EVENT_ZOMBIEAPOCALYPSE] = translate.Get("event_zs"),
		}

		if events[self:GetEvent()] then
			draw_DrawText(translate.Get("current_event", events[self:GetEvent()]), "TEA.HUDFontSmall", ScrW()/2, 210, Color(255,215,155), TEXT_ALIGN_CENTER)
		end

		local str = translate.Get("event_timer")..": "
		local s = self:GetEventTimer() - CurTime() < 60 and math.sin(CurTime()*2.1)*100 or 0
		draw_DrawText(str..util.ToMinutesSeconds(math.max(0, self:GetEventTimer() - CurTime())), "TEA.HUDFontSmall", ScrW()/2, 230, Color(255,155+s,155+s), TEXT_ALIGN_CENTER)
	end


-- Compass

	local angles = tostring(math.Round(-me:GetAngles().y + 180))
	local nang = math.rad(angles - 90)
	local eang = math.rad(angles - 180)
	local sang = math.rad(angles - 270)
	local wang = math.rad(angles)

	local nx = 40*math.cos(-nang) + 80
	local ny = 40*math.sin(-nang) + 90
	local ex = 40*math.cos(-eang) + 80
	local ey = 40*math.sin(-eang) + 90
	local sx = 40*math.cos(-sang) + 80
	local sy = 40*math.sin(-sang) + 90
	local wx = 40*math.cos(-wang) + 80
	local wy = 40*math.sin(-wang) + 90

	surface.DrawCircle(80,90, 30, Color(155,155,155,55))
	surface.DrawCircle(80,90, 5, Color(155,155,155,55))
	surface_SetDrawColor(155,155,155)
	surface.DrawLine(80, 90, 80, 70)

	-- add 5 to x and 10 to y, i dont know why it puts them in the wrong position but whatever
	draw.SimpleText("N", "TEA.HUDFont", nx - 5, ny - 10, Color(205,205,205), 0, 0)
	draw.SimpleText("E", "TEA.HUDFont", ex - 5, ey - 10, Color(205,205,205), 0, 0)
	draw.SimpleText("S", "TEA.HUDFont", sx - 5, sy - 10, Color(205,205,205), 0, 0)
	draw.SimpleText("W", "TEA.HUDFont", wx - 5, wy - 10, Color(205,205,205), 0, 0)
--[[
-- Threat level (How about Infection level?)

	local i = 0
	
	for _,ent in pairs(ents.FindInSphere(me:GetPos(), 1150)) do
		if self.Config["ZombieClasses"][ent:GetClass()] then
			i = i + 1
--			if i >= 6 then break end
		end
	end
/*	-- early concept
	local threats = {
		[0] = "None",
		[1] = "Minimal",
		[2] = "Low",
		[3] = "Moderate",
		[4] = "High",
		[5] = "Very high",
		[6] = "Hell on Earth",
	}
*/
	local text = "Zombies nearby: "..i
--	surface_SetFont("TEA.HUDFont")
--	local txx, txy = surface_GetTextSize("Threat level: "..threats[i])
--	local txx, txy = surface_GetTextSize(text)
	surface_SetDrawColor(0,0,0,200)
	surface_DrawRect(140, 115, 160, 25)
	surface_SetDrawColor(90,90,0)
	surface_DrawOutlinedRect(140, 115, 160, 25)
	draw.SimpleText(text, "TEA.HUDFontSmall", 145, 120, Color(205 + (math.sin(RealTime() * math.pi * (1.2 + i * 0.07)) * i * 10),205 - (i * 10),205 - (i * 10)), 0, 0)
--	draw.SimpleText("Threat level: "..threats[i], "TEA.HUDFont", 140, 40, Color(205,205,205), 0, 0)
]]


-- draw pvp status

	local state = GetMyPvP(pl)

	if hud and hud.DrawPVP then
		hud:DrawPVP(pl, state, scrw, scrh)
	end

	for _, ent in pairs (ents.FindByClass("tea_trader")) do
		if ent:GetPos():DistToSqr(me:GetPos()) < 14400 then
			draw_RoundedBox(2, scrw / 2 - 230, 20, 460, 75, Color(0, 0, 0, 175))
			surface_SetDrawColor(155, 155, 0, 255)
			surface_DrawOutlinedRect(scrw / 2 - 230, 20, 460, 75)

			draw_DrawText("You are in a trader protection zone", "TEA.HUDFont", scrw / 2, 30, Color(230, 255, 230, 255), TEXT_ALIGN_CENTER)
			draw_DrawText("You cannot hurt other players or be hurt by them while in this area", "TEA.HUDFontSmall", scrw / 2, 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			draw_DrawText("You take 10% less damage from all sources while in trader area", "TEA.HUDFontSmall", scrw / 2, 70, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end
end


/*
	timer.Simple(3, function() mouthbreather = CreateSound(LocalPlayer(), "player/breathe1.wav") end)
	local dingus = Material("overlays/scope_lens")
	local dingus2 = Material("sprites/scope_arc")
	local function GasMaskOverlay()
	surface_SetDrawColor(Color(0,0,0,205))
	surface.SetMaterial(dingus)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	surface_SetDrawColor(Color(0,0,0,105))
	surface.SetMaterial(dingus2)
	surface.DrawTexturedRectRotated(ScrW() - 250, ScrH() - 250, 600, 600, 0)
	surface.DrawTexturedRectRotated(ScrW() - 250, 250, 600, 600, 90)
	surface.DrawTexturedRectRotated(250, 250, 600, 600, 180)
	surface.DrawTexturedRectRotated(250, ScrH() - 250, 600, 600, 270)

	if !mouthbreather:IsPlaying() then mouthbreather:Play() end
end

local gasmask = false
concommand.Add("gastest", function() surface.PlaySound("npc/combine_soldier/gear3.wav") gasmask = !gasmask end)
*/

function GM:HUDPaint()
/* -- No.
	if gasmask then 
		GasMaskOverlay() 
	else
		mouthbreather:Stop()
	end
*/
	local pl = LocalPlayer()

	self.BaseClass:HUDPaint()

	self:DrawVitals()
	self:DrawNames()
	if LocalPlayer():Alive() then
		self:DrawMiscThings()
	end

	if !self.DisableHints and self.SysTimeStarted and self.SysTimeStarted+30 > SysTime() then
		local col = Color(255,255,255,255*(self.SysTimeStarted+30-SysTime())/1.5)
		local tbl = {
			{"Open Inventory", "+menu"},
			{"Scoreboard and Factions", "+showscores"},
			{"Actions menu", "+menu_context"},
			{"Help", "gm_showhelp"},
			{"Admin Menu", "gm_showteam"},
			{"Options", "gm_showspare2"},
		}

		local y = ScrH()/2.5
		
		draw.SimpleText("Keybinds:", "TEA.HUDFontLarge", 10, y, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		for _,t in ipairs(tbl) do
			if !AdminCheck(pl) and t[2] == "gm_showteam" then continue end
			y = y + 34
			draw.SimpleText((t[2] and string.upper(input.LookupBinding(t[2]) or "[NOT BOUND]").." - "..t[1]) or t[1], "TEA.HUDFontLarge", 10, y, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end

	if self.ShowInfectionLevelHUD then
		local text, col = self:GetInfectionTextColor(self:GetInfectionLevel())
		draw.SimpleText(Format("%s%%%s", math.Round(self:GetInfectionLevel(), 2), self.ShowInfectionLevelHUDText and " ("..text..")" or ""), "TEA.HUDFontSmall", ScrW()/2, ScrH()/3.5, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

function GM:PostDrawHUD()
	local me = LocalPlayer()

	local hud = self.HUDs[self.HUDStyle] or self.HUDs[1]


	--XP, Money & Mastery gain texts
	cam.Start2D()
	draw.SimpleText(translate.Format("masteryxpgained", MasteryXPGained, MasteryType), "TEA.HUDFontSmall", self.HUDStyle == HUDSTYLE_ATE and 330 or 140, 40, MasteryColor, 0, 1)

	if !me:Alive() and self:GetEvent() == EVENT_NONE then
		if hud and hud.DrawDead then
			hud:DrawDead(me, ScrW(), ScrH(), Spawn)
		end
	end

	if me:IsUsingItem() then
		local perc = (CurTime() - me.UsingItemTime) / me.UsingItemDuration
		local text1 = me.UsingItemText
		local text2 = math.Round(perc*100).."%"
		surface_SetFont("TEA.HUDFontSmall")
		local x1,y1 = surface_GetTextSize(text1)

		if x1 then
			x1 = math.max(100, x1 + 20)
		end

		surface_SetDrawColor(30, 30, 30, 120)
		surface_DrawRect(ScrW()/2 - x1/2, ScrH()/2 - 20, x1, 20*2)

		surface_SetDrawColor(230, 230, 30, 200)
		surface_DrawRect(ScrW()/2 - x1/2, ScrH()/2, x1*perc, 19)

		draw.SimpleText(text1, "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 - 10, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(text2, "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 9, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	if me:IsSleeping() then
		draw.SimpleText("You are now sleeping.", "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 - 20, Color(255,255,255,205), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("You will not be able to move during your sleep.", "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 10, Color(255,255,255,205), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("You might be forced to wake up if you get too thirsty, hungry or the infection is about to kill you.", "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 40, Color(255,255,255,205), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Estimated time until fatigue is replenished: "..math.Round(me.Fatigue/200).."s", "TEA.HUDFontSmall", ScrW() / 2, ScrH() / 2 + 80, Color(255,255,255,205), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	draw.SimpleText(translate.Format("xpgained", XPGained, TotalXPGained), "TEA.HUDFont", ScrW() / 2 + 10, ScrH() / 2, XPColor, 0, 1)
	draw.SimpleText(translate.Format("cashgained", MoneyGained, TotalMoneyGained), "TEA.HUDFont", ScrW() / 2 + 10, ScrH() / 2 + 18, MoneyColor, 0, 1)

	if self.DrawVersionOnHUD then
		local glow = 127 + math.abs(math.sin(CurTime() * 0.74) * 128)
		local dbgmode = self:GetDebug()
		draw.SimpleText(dbgmode >= DEBUGGING_ADVANCED and translate.Format("ver_3", self.Version)
		or dbgmode >= DEBUGGING_NORMAL and translate.Format("ver_2", self.Version)
		or translate.Format("ver_1", self.Version), "TEA.HUDFontSmall", 2, 1, Color(191, 191, glow, 45), 0, 0)
	end

	cam.End2D()
end

function GM:HUDShouldDraw(name)
	local me = LocalPlayer()
	local donotdraw = 
	{"CHudHealth", "CHudAmmo", "CHudSecondaryAmmo", "CHudBattery", "CHudSuitPower"}

	for k, v in pairs(donotdraw) do
		if (name == v) then return false end
	end
	if me:IsValid() and (me:GetObserverMode() ~= OBS_MODE_NONE or !me:Alive()) and name == "CHudDamageIndicator" then return false end 
	return true
end

function GM:RenderScreenspaceEffects()
	local ply = LocalPlayer()
	if ply:GetObserverMode() ~= OBS_MODE_NONE then return end

	local modify = {}
	local color = 1
	local contrast = 1
	local hp = (((ply:GetMaxHealth() * 0.4) - ply:Health()) * (1 / (ply:GetMaxHealth() * 0.4)))
	
	if (ply:Health() < ply:GetMaxHealth() * 0.4) then
		if (ply:Alive()) then
			color = math.min(color - hp, color)
		else
			color = 0
		end

		DrawMotionBlur(math.Clamp(1 - hp, 0.15, 1), 1, 0)
	end

	if self.SleepVisionAffect ~= 0 then
		color = color * (1 - self.SleepVisionAffect*0.15)
		contrast = contrast * (1 - self.SleepVisionAffect*0.98)
	end


	if GAMEMODE.WraithAlpha > 220 then DrawMotionBlur(0.4, 0.8, 0.01) end


	local horror = false

	modify["$pp_colour_addr"] = 0
	modify["$pp_colour_addg"] = 0
	modify["$pp_colour_addb"] = 0
	modify["$pp_colour_brightness"] = horror and -0.045 or 0
	modify["$pp_colour_contrast"] = contrast * (horror and 1.15 or 1) * (!ply:Alive() and math.Clamp(1 + (self.LastAliveTime + 5 - CurTime()) * 0.2, 0.05, 1) or 1)
	modify["$pp_colour_colour"] = horror and math.max(0, color - 0.725) or color
	modify["$pp_colour_mulr"] = 0
	modify["$pp_colour_mulg"] = 0
	modify["$pp_colour_mulb"] = 0
	
	DrawColorModify(modify)
end

function GM:DrawMiscThings()
	local me = LocalPlayer()
	for _, ent in ipairs(ents.FindByClass("structure_base_core")) do
		if ent:GetPos():DistToSqr(me:GetPos()) < 810000 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then --900^2
			local t2 = ScrW() / 2 - 175
			local s2 = 85
			local facmsg = "Faction: "..team.GetName(ent:GetNWEntity("owner"):Team())
			if self.HUDStyle == HUDSTYLE_ATE then
				surface_SetDrawColor(255, 255, 0)
				surface_DrawOutlinedRect(t2, s2, 350, 45)
				surface_SetDrawColor(0, 0, 0, 200)
				surface_DrawRect(t2, s2, 350, 45)
			end
--			local xz, xy = surface_GetTextSize(facmsg)
			if ent:GetNWEntity("owner"):Team() == me:Team() then
				draw_DrawText("You are in friendly territory", "TEA.HUDFont", ScrW()/2, s2 + 4, Color(205, 255, 205), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw_DrawText("You are in another factions territory!", "TEA.HUDFont", ScrW()/2, s2 + 4, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			draw_DrawText(facmsg, "TEA.HUDFont", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end


	for _, ent in ipairs(ents.FindByClass("airdrop_cache")) do
		if ent:GetPos():DistToSqr(me:GetPos()) > 1440000 or !ent:GetNWBool("ADActive") then continue end --1200^2
		local t2 = ScrW() / 2 - 175
		local s2 = 25
		surface_SetDrawColor(255, 255, 0)
		surface_DrawOutlinedRect(t2, s2, 350, 45)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(t2, s2, 350, 45)
		draw_DrawText("You are in an active airdrop zone!", "TEA.HUDFont", t2 + 42, s2 + 4, Color(255, 205, 205))
		draw_DrawText("PvP is forced, beware of other survivors!", "TEA.HUDFont", t2 + 15, s2 + 22, Color(255, 205, 205))
	end


	local CurTargetEnt = nil
	local TargetText = {}
	local trace = {}


	trace.start = me:EyePos()
	trace.endpos = trace.start + me:GetAimVector() * 120
	trace.filter = me
	
	local tr = util.TraceLine(trace)
	local ent = tr.Entity
	if !ent:IsValid() then return false end

	local class = ent:GetClass()


	if class == "prop_flimsy" or class == "prop_strong" or self.SpecialStructureSpawns[class] then 
		local owner = ent:GetNWEntity("owner")
		if !owner or !owner:IsValid() then return false end
		local t = ScrW() / 2 - 175
		local s = ScrH() - 100
		surface_SetDrawColor(255, 255, 0)
		surface_DrawOutlinedRect(t, s, 350, 65)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(t, s, 350, 65)
		draw_DrawText(ent.PrintName, "TEA.HUDFont", t + 5, s + 4, Color(255, 255, 255))
		draw_DrawText("Owner: ".. owner:Nick(), "TEA.HUDFont", t + 5, s + 22, Color(255, 255, 255))
		draw_DrawText("Faction:", "TEA.HUDFont", t + 5, s + 40, Color(255, 255, 255))
		draw_DrawText(team.GetName(owner:Team()), "TEA.HUDFont", t + 72, s + 40, team.GetColor(owner:Team()))


		local shp = ent:GetStructureHealth()
		local smaxhp = ent:GetStructureMaxHealth()
		if shp <= 0 or smaxhp <= 0 then return end
		local dix = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
		local fraction = shp / smaxhp
		surface_SetDrawColor(0, 0, 0, 100)
		surface_DrawRect(dix.x - 75, dix.y, 150, 25)

		surface_SetDrawColor(100, 0, 0, 190)
		surface_DrawRect(dix.x - 75, dix.y, fraction * 150, 25)
		surface_SetDrawColor(110, 0, 0, 190)
		surface_DrawRect(dix.x - 75, dix.y, fraction * 150, 12)

		surface_SetDrawColor(150, 0, 0, 200)
		surface_DrawOutlinedRect(dix.x - 75, dix.y, 150, 25)
		draw_DrawText(math.Round(fraction * 10000) / 100 .."%", "TEA.HUDFont", dix.x, dix.y + 4, Color(255, 255, 255, 155), 1)
	elseif class == "ate_droppeditem" then 
		local name = ent:GetNWString("ItemClass")

		if !name then return false end
		local itemtable = self.ItemsList[name]
		if !itemtable then return false end
		local rarity = itemtable.Rarity

		local raretbl = gamemode.Call("CheckItemRarity", rarity)
		
		local t = ScrW() / 2 - 100
		local s = ScrH() / 2 + 100
		surface_SetDrawColor(255, 255, 0, 255)
		surface_DrawOutlinedRect(t, s, 200, 65)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(t, s, 200, 65)
		draw_DrawText(GAMEMODE:GetItemName(name), "TEA.HUDFont", t + 5, s + 4, Color(255, 255, 255))
		draw_DrawText(itemtable.Weight.."kg", "TEA.HUDFont", t + 5, s + 22, Color(255, 255, 155))
		draw_DrawText("Rarity: "..raretbl.text, "TEA.HUDFont", t + 5, s + 40, raretbl.col)
	elseif class == "loot_cache" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface_SetDrawColor(255, 255, 0, 255)
		surface_DrawOutlinedRect(t, s, 150, 45)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(t, s, 150, 45)

		local lrarity = math.floor(ent:GetNWFloat("lootrarity") + (me.StatScavenging or 0)*0.01)
		local pickup = ent:GetNWEntity("pickup")

		local typ = ent:GetNWInt("loottype")
		if !typ or typ == 0 then return end
		local col = typ == LOOTTYPE_BOSS and Color(125,23,23) or typ == LOOTTYPE_FACTION and Color(240,120,172) or self:GetLootRarityColor(lrarity)
		local name = self:GetLootRarityName(lrarity)
		local canpick = !pickup or !pickup:IsValid() or !pickup:IsPlayer() or pickup == me

		draw_DrawText(self:GetLootTypeName(typ), "TEA.HUDFont", t + 5, s + 4, col, TEXT_ALIGN_LEFT)
		-- if typ == LOOTTYPE_NORMAL then
			-- draw_DrawText(name, "TEA.HUDFontSmaller", t + 145, s + 4, col, TEXT_ALIGN_RIGHT)
		-- end
		draw_DrawText(canpick and "Press E to pick up" or "Can't pick up", "TEA.HUDFont", t + 5, s + 22, color_white)
	elseif class == "ate_cash" then
		if !ent:GetNWInt("CashAmount") then return false end
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface_SetDrawColor(255, 255, 0, 255)
		surface_DrawOutlinedRect(t, s, 150, 45)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(t, s, 150, 45)
		draw_DrawText(ent:GetNWInt("CashAmount").." "..self.Config["Currency"].."(s)", "TEA.HUDFont", t + 5, s + 4, Color(255, 255, 255))
		draw_DrawText("Press E to pick up", "TEA.HUDFont", t + 5, s + 22, Color(255, 255, 255))
	end
end



function GM.ScreenEffects()
	local me = LocalPlayer()
	if me:GetObserverMode() ~= OBS_MODE_NONE then return end
	if me:Alive() then
		if GAMEMODE.WraithAlpha <= 0 then return end

		surface_SetDrawColor(0, 0, 0, math.Round(GAMEMODE.WraithAlpha * (me:IsNewbie() and 0.8 or 1)))
		surface_DrawRect(-1, -1, ScrW() + 1, ScrH() + 1)
	else
		GAMEMODE.WraithAlpha = 0
	end
end
hook.Add("RenderScreenspaceEffects", "tea_VariousEffects", GM.ScreenEffects)

net.Receive("PrestigeEffect", function()
	local pralpha = 263
	local pl = LocalPlayer()

	hook.Add("RenderScreenspaceEffects", "PrestigeEffect", function()
		if pl:GetObserverMode() ~= OBS_MODE_NONE then return end
		if pralpha > 0 then pralpha = math.Clamp(pralpha - 3, 0, 263)
		else hook.Remove("RenderScreenspaceEffects", "PrestigeEffect") return end

		surface_SetDrawColor(255, 255, 255, math.Round(math.Clamp(pralpha, 0, 255)))
		surface_DrawRect(-1, -1, ScrW() + 1, ScrH() + 1)
	end)
end)


hook.Add("PostDrawOpaqueRenderables", "circle", function()
	for _, ent in pairs (ents.FindByClass("structure_base_core")) do
		if ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 4000000 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then --2000^2
			local Pos = ent:GetPos()
			local Ang = ent:GetAngles()
			local owner = ent:GetNWEntity("owner")
			if !owner:IsValid() then continue end
			local ownercol = team.GetColor(owner:Team()) or Color(0, 0, 0, 0)
			cam.Start3D2D(Pos + ent:GetUp() * 10, Ang, 0.6)
			local TexturedQuadStructure =
			{
				texture	= surface.GetTextureID('particle/particle_ring_sharp'),
				color	= ownercol,
				x	= -1500,
				y	= -1500,
				w	= 3000,
				h	= 3000
			}
			draw.TexturedQuad(TexturedQuadStructure)
			cam.End3D2D()
		end
	end

	for _, ent in pairs (ents.FindByClass("airdrop_cache")) do
		if ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 4000000 and ent:GetNWBool("ADActive") then -- 2000^2
			local Pos = ent:GetPos()
			local Ang = Angle(0,0,0)
			cam.Start3D2D(Pos + ent:GetUp() * 10, Ang, 0.6)
			local TexturedQuadStructure =
			{
				texture = surface.GetTextureID('particle/particle_ring_blur'),
				color   = Color(255,0,0),
				x 	= -2000,
				y 	= -2000,
				w 	= 4000,
				h 	= 4000,
			}
			draw.TexturedQuad(TexturedQuadStructure)	
			cam.End3D2D()
		end
	end
end)


hook.Add("PostDrawTranslucentRenderables", "GM.Transitions", function(bDrawingDepth, bDrawingSkybox, isDraw3DSkybox)
	if bDrawingSkybox or isDraw3DSkybox then return end
	local pl = LocalPlayer()

	if IsValid(pl:GetActiveWeapon()) and pl:GetActiveWeapon():GetClass() == "tea_admintool" then return end
	cam.IgnoreZ(true)
	local ownang = pl:EyeAngles()
	for id,v in pairs(GAMEMODE.OpenworldTransitions) do
		local dist = pl:GetPos():Distance(v.Pos)
		if dist > 2000 then continue end
		local a = ((2000-dist)/2000)*255
		cam.Start3D2D(v.Pos+Vector(0,0,20), Angle(0, ownang.yaw - 90, 90 - ownang.Pitch), math.Clamp(dist/800, 0.4, 2.5))
		draw.DrawText("Map transition", "TEA.HUDFontSmall", 0, -40, Color(119,173,236,a), TEXT_ALIGN_CENTER)
		draw.DrawText(math.Round(HammerUnitsToMeters(dist), 1).."m", "TEA.HUDFontSmall", 0, -20, Color(119,173,236,a), TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
	cam.IgnoreZ(false)
end)



