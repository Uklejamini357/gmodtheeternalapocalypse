---------------- HUD ----------------

local pralpha = 0 -- wraith blind effect (but white and when prestiged)

local Spawn = 0


net.Receive("tea_updatestamina", function(len) -- this net message is received once per frame
	MyStamina = net.ReadFloat()
end)

net.Receive("UpdateStats", function(len) -- this net message is received once every second

	MyHunger = net.ReadFloat()
	MyThirst = net.ReadFloat()
	MyFatigue = net.ReadFloat()
	MyInfection = net.ReadFloat()
	MySurvivaltime = net.ReadFloat()
	MyBattery = net.ReadFloat()
	MyOxygen = net.ReadFloat()
end)

net.Receive("UpdatePeriodicStats", function(len) -- this net message is only received when one of these values need to be updated
	MyLvl = net.ReadFloat()
	MyPrestige = net.ReadFloat()
	MyMoney = net.ReadFloat()
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

local function GetMyPvP()
	if LocalPlayer():IsPvPGuarded() then return 1 end
	if !GAMEMODE.VoluntaryPvP then return 4 end
	if LocalPlayer():Team() == TEAM_LONER and LocalPlayer():GetNWBool("pvp") then return 2 end
	if LocalPlayer():Team() ~= TEAM_LONER then return 2 end
	if LocalPlayer():IsPvPForced() then return 3 end
	return 0
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
		surface.SetFont("TargetID")

		
		local message = ent:Nick()
		local wo, ho = surface.GetTextSize(message)
		
		surface.SetFont("TargetIDSmall")
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
		local wo2, ho2 = surface.GetTextSize(message2)

		local message3 = translate.Format("armor", stats[3], stats[4])
		local wo3, ho3 = surface.GetTextSize(message3)
 
		local message4 = translate.Format("level_prestige", stats[5], stats[6])
		local wo4, ho4 = surface.GetTextSize(message4)
 
		local message5 = translate.Format("bounty", stats[7])
		local wo5, ho5 = surface.GetTextSize(message5)
	
		local message6 = translate.Format("faction", stats[8])
		local wo6, ho6 = surface.GetTextSize(message6)

		if ent:IsPvPGuarded() then
			draw.SimpleTextOutlined("p", "CSSTextFont", headPos.x - 15, headPos.y - 62, Color(50, 250, 0, 255), 0, 0, 2, Color(0, 50, 0, 255))
		elseif ent:IsPvPForced() or (ent:Team() == TEAM_LONER and ent:GetNWBool("pvp") == true) or ((ent:Team() != TEAM_LONER and ent:Team() != me:Team()) or (ent:Team() == TEAM_LONER and !self.VoluntaryPvP)) then
			draw.SimpleTextOutlined("C", "CSSTextFont", headPos.x - 25, headPos.y - 60, Color(255, 50, 0, 255), 0, 0, 2, Color(50, 0, 0, 255))
		end

		draw.SimpleTextOutlined(ent:Nick(), "TargetID", headPos.x - (wo /2), headPos.y - 40, Color(255, 255, 255, 255), 0, 0, 2, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("health", stats[1], stats[2]), "TargetIDSmall", headPos.x - (wo2 / 2), headPos.y - 20, Color(255, math.Clamp(((ent:Health() * 100) / ent:GetMaxHealth()) * 2.5, 0, 255), math.Clamp(((ent:Health() * 100) / ent:GetMaxHealth()) * 2.5, 0, 255), 255), 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("armor", stats[3], stats[4]), "TargetIDSmall", headPos.x - (wo3 / 2), headPos.y - 7, Color(math.Clamp((50 + (ent:Armor() * 100) / ent:GetMaxArmor()), 0, 255), math.Clamp((50 + (ent:Armor() * 100) / ent:GetMaxArmor()), 0, 255), 255, 255), 0, 0, 1, Color(0, 0, 0, 255))
		local prestige_color = stats[6] >= 100 and HSVToColor(CurTime() * math.min(stats[6] * 0.4, 100) % 360, 0.5, 1) or Color(255, 205, 255, 255)
		draw.SimpleTextOutlined(translate.Format("level_prestige", stats[5], stats[6]), "TargetIDSmall", headPos.x - (wo4 / 2) - 2, headPos.y + 7, prestige_color, 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("bounty", stats[7]), "TargetIDSmall", headPos.x - (wo5 / 2) - 2, headPos.y + 20, Color(255, 64, 64, 255), 0, 0, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined(translate.Format("faction", stats[8]), "TargetIDSmall", headPos.x - (wo6 / 2) - 2, headPos.y + 33, team.GetColor(ent:Team()), 0, 0, 1, Color(0, 0, 0, 255))

	end

	if npcent and npcent:IsValid() and (npcent:IsNPC() or npcent:IsNextBot()) and (self.Config["ZombieClasses"][npcent:GetClass()] or self.Config["BossClasses"][npcent:GetClass()]) and self.DrawZombiesInfo and self:GetDebug() >= DEBUGGING_ADVANCED then
		if ent and ent:IsValid() and (ent:IsNPC() or ent:IsNextBot()) and (self.Config["ZombieClasses"][ent:GetClass()] or self.Config["BossClasses"][ent:GetClass()]) then
			lastent = ent
			lastdraw = CurTime()
		end
		local colormult = lastdraw + 1 - CurTime()

		draw.RoundedBox(1, (ScrW() / 2) - 170, 230, 340, 60, Color(0, 0, 0, colormult * 175))
		surface.SetDrawColor(90,0,0,colormult * 155)
		surface.DrawOutlinedRect((ScrW() / 2) - 170, 230, 340, 60)

		local class = self.Config["ZombieClasses"][npcent:GetClass()] or self.Config["BossClasses"][npcent:GetClass()]
		draw.SimpleText(class.Name..(npcent:GetEliteVariant() ~= 0 and " (Elite variant: "..(self.VariantNames[npcent:GetEliteVariant()] or "N/A")..")" or ""), "TargetIDSmall", (ScrW() / 2) - 160, 244, Color(108,108,108,colormult * 255), 0, 1)
		draw.SimpleText(translate.Format("health", npcent:Health(), npcent:GetMaxHealth()), "TargetIDSmall", (ScrW() / 2) - 160, 262, Color(math.Clamp(255 * (npcent:Health() / npcent:GetMaxHealth()), 127, 255),48,48,colormult * 255), 0, 1)
		draw.SimpleText(tostring(npcent.Purpose), "DefaultFontSmall", (ScrW() / 2) - 160, 280, Color(148,148,148,colormult * 255), 0, 1)
--		draw.RoundedBox(2, 20, ScrH() - 86, 160, 20, Color(50, 0, 0, 160))
		if npcent:Health() > 0 then
			local hpbarclamp = math.Clamp(160 * (npcent:Health() / npcent:GetMaxHealth()), 0, 160)
--			draw.RoundedBox(4, 20, ScrH() - 86, hpbarclamp, 20, Color(150, 0, 0, 160))
--			draw.RoundedBox(4, 20, ScrH() - 86, hpbarclamp, 10, Color(150, 0, 0, 100))
		end
	end
end

local hunger_a = 0
local thirst_a = 0
local fatigue_a = 0
local infection_a = 0

local function surface_DrawRectColor(x, y, w, h, col)
	surface.SetDrawColor(col or color_white)
	surface.DrawRect(x,y,w,h)
end


function GM:DrawVitals()
	local me = LocalPlayer()
	if !me:IsValid() or !me:Alive() or !self.HUDEnabled or GetConVar("cl_drawhud"):GetInt() < 1 or me:GetObserverMode() ~= OBS_MODE_NONE then return end
	local Health = me:Health()
	local MaxHealth = me:GetMaxHealth()
	local Armor = me:Armor()
	local MaxArmor = me:GetMaxArmor()
	local scrw = ScrW()
	local scrh = ScrH()
	local SWEP = {}
	local weapon = me:GetActiveWeapon()
	if weapon != NULL then
		SWEP.Class = weapon:GetClass()
		SWEP.AmmoClip1 = weapon:Clip1()
		SWEP.AmmoClip2 = weapon:Clip2()
		SWEP.MaxAmmoClip1 = weapon:GetMaxClip1()
		SWEP.MaxAmmoClip2 = weapon:GetMaxClip2()
		SWEP.MaxAmmoType = me:GetAmmoCount(weapon:GetPrimaryAmmoType())
		SWEP.MaxAmmoType2 = me:GetAmmoCount(weapon:GetSecondaryAmmoType())
	end
--	local HealthTexture = surface.GetTextureID("gui/silkicons/heart")
--	local ArmorTexture = surface.GetTextureID("gui/silkicons/shield")
	local DGradientCenter = surface.GetTextureID("gui/center_gradient")

	local glow = math.abs(math.sin(CurTime() * 1.7) * 255)
/*
	if MyHunger < 1000 then
		draw.SimpleText(translate.Get("hunger_low"), "TargetID", 21, scrh - 360, Color(255, glow, glow, hunger_a), 0, 1)
		hunger_a = math.Approach(hunger_a, 255, 3)
	else
		hunger_a = math.Approach(hunger_a, 0, 3)
	end

	if MyThirst < 1000 then
		draw.SimpleText(translate.Get("thirst_low"), "TargetID", 21, scrh - 340, Color(255, glow, glow, thirst_a), 0, 1)
		thirst_a = math.Approach(thirst_a, 255, 3)
	else
		thirst_a = math.Approach(thirst_a, 0, 3)
	end

	if MyFatigue > 9000 then
		draw.SimpleText(translate.Get("fatigue_high"), "TargetID", 21, scrh - 320, Color(255, glow, glow, fatigue_a), 0, 1)
		fatigue_a = math.Approach(fatigue_a, 255, 3)
	else
		fatigue_a = math.Approach(fatigue_a, 0, 3)
	end

	if MyInfection > 9000 then
		draw.SimpleText(translate.Get("infection_high"), "TargetID", 21, scrh - 300, Color(255, glow, glow, infection_a), 0, 1)
		infection_a = math.Approach(infection_a, 255, 3)
	else
		infection_a = math.Approach(infection_a, 0, 3)
	end
*/

	local y = 300

	if MyInfection > 9000 then
		draw.SimpleText(translate.Get("infection_high"), "TargetID", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if MyFatigue > 9000 then
		draw.SimpleText(translate.Get("fatigue_high"), "TargetID", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if MyThirst < 1000 then
		draw.SimpleText(translate.Get("thirst_low"), "TargetID", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
		y = y + 20
	end

	if MyHunger < 1000 then
		draw.SimpleText(translate.Get("hunger_low"), "TargetID", 21, scrh - y, Color(255, glow, glow, 230), 0, 1)
	end


	if self.HUDStyle == HUDSTYLE_ATE then
---------------- HEALTH ----------------
		draw.RoundedBox(1, 10, scrh - 110, 180, 100, Color(0, 0, 0, 175))
		surface.SetDrawColor(90, 0, 0 ,255)
		surface.DrawOutlinedRect(10, scrh - 110, 180, 100)
		draw.SimpleText(translate.Format("health", Health, MaxHealth), "TargetIDSmall", 21, scrh - 96, Color(math.Clamp(255 * (Health / MaxHealth), 127, 255),48,48,255), 0, 1)
		draw.RoundedBox(2, 20, scrh - 86, 160, 20, Color(50, 0, 0, 160))
		if Health > 0 then
			local hpbarclamp = math.Clamp(160 * (Health / MaxHealth), 0, 160)
			draw.RoundedBox(4, 20, scrh - 86, hpbarclamp, 20, Color(150, 0, 0, 160))
			draw.RoundedBox(4, 20, scrh - 86, hpbarclamp, 10, Color(150, 0, 0, 100))
		end

---------------- ARMOR ----------------
		draw.SimpleText(translate.Format("armor", Armor, MaxArmor), "TargetIDSmall", 21, scrh - 50, Color(48,48,math.Clamp(255 * (Armor / MaxArmor), 127, 255),255), 0, 1)
		draw.RoundedBox(2, 20, scrh - 36, 160, 20, Color(0, 0, 50, 160))
		if Armor > 0 then
			local armorbarclamp = math.Clamp(160 * (Armor / MaxArmor),0,160)
			draw.RoundedBox(4,20, scrh - 36, armorbarclamp,20,Color(0,0,150,160))
			draw.RoundedBox(4,20, scrh - 36, armorbarclamp,10,Color(0,0,150,160))
		end

		surface_DrawRectColor(58, scrh - 36,4,20, Color(0,0,0,255))
		surface_DrawRectColor(98, scrh - 36,4,20, Color(0,0,0,255))
		surface_DrawRectColor(138, scrh - 36,4,20, Color(0,0,0,255))
		surface.DrawOutlinedRect(20, scrh - 36,160,20)
		surface.DrawOutlinedRect(19, scrh - 37,162,22)

---------------- AMMO ----------------


		if weapon != NULL then
			if (SWEP.MaxAmmoType != 0 or SWEP.MaxAmmoType2 != 0 or SWEP.AmmoClip1 > 0 or SWEP.AmmoClip2 > 0) then
				IsAmmoBox = true
				--Ammo Box
				draw.RoundedBox(1, scrw - 270, scrh - 140, 250, 70, Color(0, 0, 0, 175))
				surface.SetDrawColor(200, 100, 0 ,255)
				surface.DrawOutlinedRect(scrw - 270, scrh - 140, 250, 70)
	
				--Ammo Text
				if (SWEP.AmmoClip2 != -1) then
					draw.SimpleText("Ammo in Clip: ".. SWEP.AmmoClip1 .." / ".. SWEP.AmmoClip2, "TargetIDSmall", scrw - 259, scrh - 110, Color(255, 255, 255, 255), 0, 1)
				else
					draw.SimpleText("Ammo in Clip: ".. SWEP.AmmoClip1, "TargetIDSmall", scrw - 259, scrh - 110, Color(255, 255, 255, 255), 0, 1) 
				end

				--Ammo bar base
				draw.RoundedBox(2, scrw - 252, scrh - 98, 140, 20, Color(150, 100, 0, 100))
	
				--Second Clip Ammo Text
				draw.SimpleText("Ammo Remaining: ".. SWEP.MaxAmmoType, "TargetIDSmall", scrw - 259, scrh - 130, Color(255, 255, 255, 255), 0, 1)
	
				--Alt ammo Text
				draw.SimpleText("ALT: ".. SWEP.MaxAmmoType2, "TargetIDSmall", scrw - 89, scrh - 90, Color(255, 255, 255, 255), 0, 1)

	
				if SWEP.AmmoClip1 > 0 then
					--Ammo Bar
					draw.RoundedBox(4, scrw - 252, scrh - 98, math.min(140, 140 * (SWEP.AmmoClip1 / SWEP.MaxAmmoClip1)), 20, Color(200, 110, 0, 200))
					draw.RoundedBox(4, scrw - 252, scrh - 98, math.min(140, 140 * (SWEP.AmmoClip1 / SWEP.MaxAmmoClip1)), 10, Color(200, 150, 0, 50))
				end
			else
				IsAmmoBox = false
			end
		end

-------------- EXperience --------------

		draw.RoundedBox(1, scrw - 270, scrh - 60, 250, 50, Color(0, 0, 0, 175))
		surface.SetDrawColor(90, 90, 0 ,255)
		surface.DrawOutlinedRect(scrw - 270, scrh - 60, 250, 50)

		draw.SimpleText(Format("XP: %s/%s (%s%%)", math.floor(MyXP), me:GetReqXP(), math.Round(math.floor(MyXP) * 100 / me:GetReqXP())), "TargetIDSmall", scrw - 259, scrh - 48, Color(255, 255, 255, 255), 0, 1)
		draw.RoundedBox(2, scrw - 250, scrh - 36, 210, 20, Color(50, 0, 0, 160))
		draw.RoundedBox(4, scrw - 250, scrh - 36, math.Clamp(210 * (MyXP / me:GetReqXP()), 0, 210), 20, Color(150, 0, 0, 160))

		draw.RoundedBox(1, 200, scrh - 200, 180, 190, Color(0, 0, 0, 175))
		surface.SetDrawColor(125, 125, 55 ,255)
		surface.DrawOutlinedRect(200, scrh - 200, 180, 190)

-------------- Stamina --------------
		draw.SimpleText(translate.Format("stamina", math.Round(MyStamina, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, scrh - 186, Color(205, 255, 205, 255), 0, 1)
		draw.RoundedBox(2, 210, scrh - 176, 160, 15, Color(50, 50, 0, 100))
		if MyStamina > 0 then
			local staminabarclamp = math.Clamp(MyStamina * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 176, staminabarclamp, 15, Color(100, 150, 0, 160))
			draw.RoundedBox(4, 210, scrh - 176, staminabarclamp, 8, Color(100, 150, 0, 160))
		end

-------------- Hunger --------------
		draw.SimpleText(translate.Format("hunger", math.Round(MyHunger / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, scrh - 150, Color(255, 205, 255, 255), 0, 1)
		draw.RoundedBox(2, 210, scrh - 140, 160, 15, Color(50, 0, 50, 100))
		if (MyHunger / 100) > 0 then
			local hungerbarclamp = math.Clamp((MyHunger / 100) * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 140, hungerbarclamp, 15, Color(90, 0, 120, 160))
			draw.RoundedBox(4, 210, scrh - 140, hungerbarclamp, 8, Color(120, 0, 120, 80))
		end

-------------- Thirst --------------
		draw.SimpleText(translate.Format("thirst", math.Round(MyThirst / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, scrh - 114, Color(155,155,255,255), 0, 1)
		draw.RoundedBox(2, 210, scrh - 104, 160, 15, Color(45, 45, 75, 100))
		if (MyThirst / 100) > 0 then
			local thirstbarclamp = math.Clamp((MyThirst / 100) * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 104, thirstbarclamp, 15, Color(155,155,255,255))
			draw.RoundedBox(4, 210, scrh - 104, thirstbarclamp, 8, Color(155,155,255,255))
		end

-------------- Fatigue --------------
		draw.SimpleText(translate.Format("fatigue", math.Round(MyFatigue / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, scrh - 78, Color(205,205,255,255), 0, 1)
		draw.RoundedBox(2, 210, scrh - 68, 160, 15, Color(0, 50, 50, 100))
		if (MyFatigue / 100) > 0 then
			local fatiguebarclamp = math.Clamp((MyFatigue / 100) * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 68, fatiguebarclamp, 15, Color(0, 80, 80, 160))
			draw.RoundedBox(4, 210, scrh - 68, fatiguebarclamp, 8, Color(0, 100, 100, 80))
		end

-------------- Infection --------------
		draw.SimpleText(translate.Format("infection", math.Round(MyInfection / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 210, scrh - 42, Color(205, 105, 105, 255), 0, 1)
		draw.RoundedBox(2, 210, scrh - 32, 160, 15, Color(80, 0, 0, 100))
		if (MyInfection / 100) > 0 then
			local infectionbarclamp = math.Clamp((MyInfection / 100) * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 32, infectionbarclamp, 15, Color(250, 0, 0, 160))
			draw.RoundedBox(4, 210, scrh - 32, infectionbarclamp, 8, Color(50, 0, 0, 100))
		end

-------------- Battery --------------
		draw.RoundedBox(0, 140, 30, 180, 45, Color(0, 0, 0, 175))
		surface.SetDrawColor(0, 0, 60, 205)
		surface.DrawOutlinedRect(140, 30, 180, 45)
		local armorstr = me:GetNWString("ArmorType") or "none"
		local armortype = self.ItemsList[armorstr]
		draw.SimpleText(translate.Format("battery", math.Clamp(MyBattery, 0, math.huge), 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0)), "TargetIDTiny", 150, 42, Color(5,5,255,255), 0, 1)
		draw.RoundedBox(2, 150, 52, 160, 15, Color(0, 0, 80, 100))
		if MyBattery > 0 then
			local batterybarclamp = math.Clamp((MyBattery * 1.6) / (1 + (armorstr and armortype and armortype["ArmorStats"]["battery"] / 100 or 0)), 0, 160)
			draw.RoundedBox(4, 150, 52, batterybarclamp, 15, Color(0, 0, 250, 160))
			draw.RoundedBox(4, 150, 52, batterybarclamp, 8, Color(0, 0, 50, 100))
		end

----------------Levels, cash & prestige----------------

		draw.RoundedBox(1, 10, scrh - 200, 180, 85, Color(0, 0, 0, 175))
		surface.SetDrawColor(55, 55, 155 ,255)
		surface.DrawOutlinedRect(10, scrh - 200, 180, 85)
		draw.SimpleText(translate.Format("bounty", math.floor(MyBounty)), "TargetIDSmall", 20, scrh - 187, Color(155, math.Clamp(127 - (MyBounty / 60), 0, 255), math.Clamp(255 - (MyBounty / 30), 0, 255), 255), 0, 1)
		draw.SimpleText(translate.Format("prestige", math.floor(MyPrestige)), "TargetIDSmall", 20, scrh - 168, Color(205,155,255,255), 0, 1)
		draw.SimpleText(translate.Format("level", math.floor(MyLvl)), "TargetIDSmall", 20, scrh - 149, Color(200,200,200,255), 0, 1)
		draw.SimpleText(translate.Format("money", math.floor(MyMoney)), "TargetIDSmall", 20, scrh - 130, Color(0,255,255,255), 0, 1)


	elseif self.HUDStyle == HUDSTYLE_CLASSIC then

---------------- HEALTH ----------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 200, 200, 8)
		draw.SimpleText(translate.Format("health", Health, MaxHealth), "TargetIDSmall", 21, scrh - 210, Color(205,205,205,255), 0, 1)

		surface_DrawRectColor(20, scrh - 200, 200, 8, Color(50,0,0,210))
		if Health > 0 then
			local hpbarclamp = math.Clamp(200 * (Health / MaxHealth), 0, 200)
			surface_DrawRectColor(20, scrh - 200, hpbarclamp, 4, Color(150,0,0,210))
			surface_DrawRectColor(20, scrh - 196, hpbarclamp, 4, Color(150,0,0,150))
		end

---------------- ARMOR ----------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 170, 200, 8)
		draw.SimpleText(translate.Format("armor", Armor, MaxArmor), "TargetIDSmall", 21, scrh - 180, Color(205,205,205,255),0,1)
		surface_DrawRectColor(20, scrh - 170, 200, 8, Color(0,0,50,210))
		if Armor > 0 then
			local armorbarclamp = math.Clamp(200 * (Armor / MaxArmor), 0, 200)
			surface_DrawRectColor(20, scrh - 170, armorbarclamp, 4, Color(0,0,150,210))
			surface_DrawRectColor(20, scrh - 166, armorbarclamp, 4, Color(0,0,150,150))
		end

---------------- AMMO ----------------
		if weapon != NULL then
			if (SWEP.AmmoClip1 != -1 or SWEP.AmmoClip2 != -1) then
				IsAmmoBox = true
				--Ammo Text
				if (SWEP.AmmoClip2 != -1) then
					draw.SimpleText("Ammo in Clip: ".. SWEP.AmmoClip1 .." / ".. SWEP.AmmoClip2, "TargetIDSmall", 270, scrh - 210, Color(205,205,205,255), 0, 1) 
				else
					draw.SimpleText("Ammo in Clip: ".. SWEP.AmmoClip1, "TargetIDSmall", 270, scrh - 210, Color(205,205,205,255), 0, 1) 
				end
				--Second Clip Ammo Text
				draw.SimpleText("Ammo Remaining: ".. SWEP.MaxAmmoType, "TargetIDSmall", 270, scrh - 192, Color(205,205,205,255), 0, 1)
				--Alt ammo Text
				draw.SimpleText("ALT: ".. SWEP.MaxAmmoType2, "TargetIDSmall", 270, scrh - 174, Color(205,205,205,255), 0, 1)
			else IsAmmoBox = false end
		end
-------------- EXperience --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(scrw - 250, scrh - 50, 200, 8)
		draw.SimpleText(Format("XP: %s/%s (%s%%)", math.floor(MyXP), me:GetReqXP(), math.Round(math.floor(MyXP) * 100 / me:GetReqXP())), "TargetIDSmall", scrw - 250, scrh - 60, Color(205, 205, 205, 255), 0, 1)
		surface_DrawRectColor(scrw - 250, scrh - 50, 200, 8, Color(50,0,0,75))
	
		local xpbarclamp = math.Clamp(200 * (MyXP / me:GetReqXP()), 0, 200)
		surface_DrawRectColor(scrw - 250, scrh - 50, xpbarclamp, 8, Color(150,0,0,160))

-------------- Stamina -------------- 
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 140, 200, 8)
		draw.SimpleText(translate.Format("stamina", math.Round(MyStamina, self.HUDDecimalValues and 1 or 0)), "TargetIDSmall", 20, scrh - 150, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(20, scrh - 140, 200, 8, Color(50,50,0,75))
		if MyStamina > 0 then
			local staminabarclamp = math.Clamp(MyStamina * 2, 0, 200)
			surface_DrawRectColor(20, scrh - 140, staminabarclamp, 4, Color(250, 200, 0, 160))
			surface_DrawRectColor(20, scrh - 136, staminabarclamp, 4, Color(220, 170, 0, 160))
		end
-------------- Thirst --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 110, 200, 8)
		draw.SimpleText(translate.Format("thirst", math.Round(MyThirst / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDSmall", 20, scrh - 120, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(20, scrh - 110, 200, 8, Color(50,75,100,75))
		if MyThirst > 0 then
			local thirstbarclamp = math.Clamp(MyThirst / 50, 0, 200)
			surface_DrawRectColor(20, scrh - 110, thirstbarclamp, 4, Color(100,150,200,160))
			surface_DrawRectColor(20, scrh - 106, thirstbarclamp, 4, Color(90,135,180,160))
		end

-------------- Hunger --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 80, 200, 8)
		draw.SimpleText(translate.Format("hunger", math.Round(MyHunger / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDSmall", 20, scrh - 90, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(20, scrh - 80, 200, 8, Color(0,50,0,75))
		if MyHunger > 0 then
			local hungerbarclamp = math.Clamp(MyHunger / 50, 0, 200)
			surface_DrawRectColor(20, scrh - 80, hungerbarclamp, 4, Color(0,100,0,160))
			surface_DrawRectColor(20, scrh - 76, hungerbarclamp, 4, Color(0,100,0,160))
		end

-------------- Fatigue --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 50, 200, 8)
		draw.SimpleText(translate.Format("fatigue", math.Round(MyFatigue / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDSmall", 20, scrh - 60, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(20, scrh - 50, 200, 8, Color(75,75,75,75))
		if MyFatigue > 0 then
			local fatiguebarclamp = math.Clamp(MyFatigue / 50, 0, 200)
			surface_DrawRectColor(20, scrh - 50, fatiguebarclamp, 4, Color(250,250,250,160))
			surface_DrawRectColor(20, scrh - 46, fatiguebarclamp, 4, Color(200,200,250,160))
		end

-------------- Infection --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, scrh - 20, 200, 8)
		draw.SimpleText(translate.Format("infection", math.Round(MyInfection / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDSmall", 20, scrh - 30, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(20, scrh - 20, 200, 8, Color(75,0,0,75))
		if MyInfection > 0 then
			local infectionbarclamp = math.Clamp(MyInfection / 50, 0, 200)
			surface_DrawRectColor(20, scrh - 20, infectionbarclamp, 4, Color(200,100,100,160))
			surface_DrawRectColor(20, scrh - 16, infectionbarclamp, 4, Color(160,80,80,160))
		end

-------------- Battery --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(scrw - 250, scrh - 20, 200, 8)
		local armorstr = me:GetNWString("ArmorType") or "none"
		local armortype = self.ItemsList[armorstr]
		draw.SimpleText(translate.Format("battery", math.max(MyBattery, 0), 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0)), "TargetIDSmall", scrw - 250, scrh - 30, Color(205,205,205,255), 0, 1)
		surface_DrawRectColor(scrw - 250, scrh - 20, 200, 8, Color(0,0,75,75))
		if MyBattery > 0 then
			local batterybarclamp = math.Clamp((MyBattery * 2) / (1 + (armorstr and armortype and armortype["ArmorStats"]["battery"] / 100 or 0)), 0, 200)
			surface_DrawRectColor(scrw - 250, scrh - 20, batterybarclamp, 4, Color(0,0,200,160))
			surface_DrawRectColor(scrw - 250, scrh - 16, batterybarclamp, 4, Color(0,0,150,160))
		end
----------------Levels, cash, prestige & time survived----------------
		draw.SimpleText(translate.Format("prestige", math.floor(MyPrestige)), "TargetIDSmall", 270, scrh - 140, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Format("level", math.floor(MyLvl)), "TargetIDSmall", 270, scrh - 122, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Format("money", math.floor(MyMoney)), "TargetIDSmall", 270, scrh - 104, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Format("bounty", math.floor(MyBounty)), "TargetIDSmall", 270, scrh - 86, Color(205, 205, 205, 255), 0, 1)
	elseif self.HUDStyle == HUDSTYLE_TEA then
		surface_DrawRectColor(16, scrh - 108, 192, 100, Color(255,255,255,65))
		draw.SimpleText(string.upper(translate.Format("health", Health, MaxHealth)), "TargetIDSmall", 21, scrh - 96, Color(255,255,255), 0, 1)
		draw.SimpleText(string.upper(translate.Format("armor", Armor, MaxArmor)), "TargetIDSmall", 21, scrh - 80, Color(255,255,255), 0, 1)

		draw.SimpleText(translate.Format("prestige", math.floor(MyPrestige)), "TargetIDSmall", 21, scrh - 60, Color(255,255,255), 0, 1)
		draw.SimpleText(translate.Format("level", math.floor(MyLvl)), "TargetIDSmall", 21, scrh - 44, Color(255,255,255), 0, 1)
		draw.SimpleText(translate.Format("money", math.floor(MyMoney)), "TargetIDSmall", 21, scrh - 28, Color(255,255,255), 0, 1)

		surface_DrawRectColor(216, scrh - 108, 192, 100, Color(255,255,255,65))
		surface_DrawRectColor(scrw - 208, scrh - 108, 192, 100, Color(255,255,255,65))
		draw.SimpleText(translate.Format("stamina", math.Round(MyStamina, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, scrh - 100, Color(255,255,255), 0, 1)
		draw.SimpleText(translate.Format("thirst", math.Round(MyThirst / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, scrh - 84, Color(255, 205, 255, 255), 0, 1)
		draw.SimpleText(translate.Format("hunger", math.Round(MyHunger / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, scrh - 68, Color(155,155,255,255), 0, 1)
		draw.SimpleText(translate.Format("fatigue", math.Round(MyFatigue / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, scrh - 52, Color(205,205,255,255), 0, 1)
		draw.SimpleText(translate.Format("infection", math.Round(MyInfection / 100, self.HUDDecimalValues and 1 or 0)), "TargetIDTiny", 224, scrh - 36, Color(205, 105, 105, 255), 0, 1)
		draw.SimpleText(translate.Format("battery", math.Clamp(MyBattery, 0, math.huge), 100 + (armorstr and armortype and armortype["ArmorStats"]["battery"] or 0)), "TargetIDTiny", 224, scrh - 20, Color(5,5,255,255), 0, 1)

	end


	--Max Weight
	if not self.NoInvWeightHUDDisplay then
		draw.SimpleText(translate.Format("inv_weight", LocalPlayer():CalculateWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWeight(), WEIGHT_UNIT, LocalPlayer():CalculateMaxWalkWeight(), WEIGHT_UNIT), "TargetIDSmall", 20, 155, Color(205, 205, 205, 255), 0, 1)
	end

	if MyOxygen < 100 then
		draw.SimpleText(Format("Oxygen: %d%%", math.Round(MyOxygen)), "TargetIDTiny", ScrW()/2, 186, Color(205, 205, 255, 255), TEXT_ALIGN_CENTER, 0)
		draw.RoundedBox(2, 210, scrh - 176, 160, 15, Color(50, 50, 0, 100))
		if MyStamina > 0 then
			local staminabarclamp = math.Clamp(MyStamina * 1.6, 0, 160)
			draw.RoundedBox(4, 210, scrh - 176, staminabarclamp, 15, Color(100, 150, 0, 160))
			draw.RoundedBox(4, 210, scrh - 176, staminabarclamp, 8, Color(100, 150, 0, 160))
		end
	end



--	draw.SimpleText("Height difference: "..math.Round(me:GetPos().z - me:GetEyeTrace().HitPos.z), "TargetIDSmall", ScrW() / 2, 255, Color(205, 205, 205, 255), 1, 1)

	local tr = me:GetEyeTrace()
	local y = 172
	if self:GetDebug() >= DEBUGGING_NORMAL then
		draw.SimpleText(translate.Get(GetGlobalBool("GM.ZombieSpawning") and "zspawnon" or "zspawnoff"), "TargetIDSmall", 20, y, Color(255, 255, 205, 255), 0, 1)
		y = y + 16
	end
	if self:GetDebug() >= DEBUGGING_ADVANCED then
		draw.SimpleText("Curtime: "..math.Round(CurTime(), 3), "TargetIDSmall", 20, y, Color(205,255,205,255), 0, 1)
		y = y + 8
	end
	if self:GetDebug() >= DEBUGGING_EXPERIMENTAL then
		draw.SimpleText("Trace Entity: "..tostring(tr.Entity), "TargetIDSmall", 20, y, Color(205,205,255,255), 0, 0)
		y = y + 22
		if tr.Entity != NULL and tr.Entity:Health() > 0 then
			y = y - 8
			draw.SimpleText("Ent HP: "..tr.Entity:Health().."/"..tr.Entity:GetMaxHealth(), "TargetIDSmall", 20, y, Color(205,205,255,255), 0, 0)
			y = y + 22
		end

		draw.SimpleText("Held weapon: "..tostring(weapon), "TargetIDSmall", 20, y, Color(205,205,255,255), 0, 1)
		y = y + 22
	end
	if self:GetDebug() >= DEBUGGING_TRUE then
		draw.SimpleText("Trace Entity: "..tostring(tr.Entity), "TargetIDSmall", 20, y, Color(205,205,255,255), 0, 0)
	end

	if self:GetServerRestartTime() ~= 0 then
		draw.DrawText("Server restarts in: "..util.ToMinutesSeconds(math.max(0, self:GetServerRestartTime() - CurTime())), "TargetID", ScrW()/2, 180, Color(255,255,255,255), TEXT_ALIGN_CENTER)
	end

	if self:GetEventTimer() ~= -1 and self:GetEvent() ~= EVENT_NONE then
		local events = {
			[EVENT_ZOMBIEAPOCALYPSE] = "Zombie Survival",
		}

		if events[self:GetEvent()] then
			draw.DrawText("Event: "..events[self:GetEvent()], "TargetIDSmall", ScrW()/2, 210, Color(255,215,155,255), TEXT_ALIGN_CENTER)
		end

		local str = "Event timer: "
		local s = self:GetEventTimer() - CurTime() < 60 and math.sin(CurTime()*2.1)*100 or 0
		draw.DrawText(str..util.ToMinutesSeconds(math.max(0, self:GetEventTimer() - CurTime())), "TargetIDSmall", ScrW()/2, 230, Color(255,155+s,155+s,255), TEXT_ALIGN_CENTER)
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

	surface.DrawCircle(80,90, 30 , Color(155,155,155,55))
	surface.DrawCircle(80,90, 5 , Color(155,155,155,55))
	surface.SetDrawColor(155,155,155,255)
	surface.DrawLine(80, 90, 80, 70)

	-- add 5 to x and 10 to y, i dont know why it puts them in the wrong position but whatever
	draw.SimpleText("N", "TargetID", nx - 5, ny - 10, Color(205,205,205,255), 0, 0)
	draw.SimpleText("E", "TargetID", ex - 5, ey - 10, Color(205,205,205,255), 0, 0)
	draw.SimpleText("S", "TargetID", sx - 5, sy - 10, Color(205,205,205,255), 0, 0)
	draw.SimpleText("W", "TargetID", wx - 5, wy - 10, Color(205,205,205,255), 0, 0)
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
--	surface.SetFont("TargetID")
--	local txx, txy = surface.GetTextSize("Threat level: "..threats[i])
--	local txx, txy = surface.GetTextSize(text)
	surface.SetDrawColor(0,0,0,200)
	surface.DrawRect(140, 115, 160, 25)
	surface.SetDrawColor(90,90,0,255)
	surface.DrawOutlinedRect(140, 115, 160, 25)
	draw.SimpleText(text, "TargetIDSmall", 145, 120, Color(205 + (math.sin(RealTime() * math.pi * (1.2 + i * 0.07)) * i * 10),205 - (i * 10),205 - (i * 10),255), 0, 0)
--	draw.SimpleText("Threat level: "..threats[i], "TargetID", 140, 40, Color(205,205,205,255), 0, 0)
]]


-- draw pvp status

	local mpvp = GetMyPvP()
	local mpvptab = {
		[0] = translate.Get("pvp_state1"),
		[1] = translate.Get("pvp_state2"),
		[2] = translate.Get("pvp_state3"),
		[3] = translate.Get("pvp_state4"),
		[4] = translate.Get("pvp_state5"),
	}

	if self.HUDStyle == HUDSTYLE_ATE then
		if mpvp == 3 or mpvp == 4 then
			surface.SetDrawColor(100,0,0,175)
		else
			surface.SetDrawColor(0,0,0,200)
		end
		surface.DrawRect(140, 80, 180, 27)
		surface.SetDrawColor(40,0,40,255)
		surface.DrawOutlinedRect(140, 80, 180, 27)

		draw.SimpleText("PvP: "..mpvptab[mpvp], "TargetIDSmall", 180, 86, Color(205,205,205,255), 0, 0)
		if mpvp == 2 or mpvp == 3 or mpvp == 4 then
			draw.SimpleTextOutlined("C", "CSSTextFont", 135, 85, Color(255, 50, 0, 255), 0, 0, 2, Color(50, 0, 0, 255))
		elseif mpvp == 1 then
			draw.SimpleTextOutlined("p", "CSSTextFont", 145, 83, Color(50, 250, 0, 255), 0, 0, 2, Color(0, 50, 0, 255))
		else
			draw.SimpleTextOutlined("C", "CSSTextFont", 135, 85, Color(50, 50, 50, 255), 0, 0, 2, Color(20, 0, 0, 255))
		end
	elseif self.HUDStyle == HUDSTYLE_CLASSIC then
		draw.SimpleText("PvP: "..mpvptab[mpvp], "TargetIDSmall", 270, scrh - 30, Color(205,205,205,255), 0, 0)
	elseif self.HUDStyle == HUDSTYLE_TEA then
	end

	for _, ent in pairs (ents.FindByClass("tea_trader")) do
		if ent:GetPos():DistToSqr(me:GetPos()) < 14400 then --120^2
			draw.RoundedBox(2, scrw / 2 - 230, 20, 460, 75, Color(0, 0, 0, 175))
			surface.SetDrawColor(155, 155, 0 ,255)
			surface.DrawOutlinedRect(scrw / 2 - 230, 20, 460, 75)

			draw.DrawText("You are in a trader protection zone", "TargetID", scrw / 2, 30, Color(230, 255, 230, 255), TEXT_ALIGN_CENTER)
			draw.DrawText("You cannot hurt other players or be hurt by them while in this area", "TargetIDSmall", scrw / 2, 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			draw.DrawText("You take 10% less damage from all sources while in trader area", "TargetIDSmall", scrw / 2, 70, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end
end


/*
	timer.Simple(3, function() mouthbreather = CreateSound(LocalPlayer(), "player/breathe1.wav") end)
	local dingus = Material("overlays/scope_lens")
	local dingus2 = Material("sprites/scope_arc")
	local function GasMaskOverlay()
	surface.SetDrawColor(Color(0,0,0,205))
	surface.SetMaterial(dingus)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	surface.SetDrawColor(Color(0,0,0,105))
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

	self.BaseClass:HUDPaint()

	self:DrawVitals()
	self:DrawNames()
	if LocalPlayer():Alive() then
		self:DrawMiscThings()
	end

end

function GM:PostDrawHUD()
	local me = LocalPlayer()
	--XP, Money & Mastery gain texts
	cam.Start2D()
	draw.SimpleText(translate.Format("masteryxpgained", MasteryXPGained, MasteryType), "TargetIDSmall", self.HUDStyle == HUDSTYLE_ATE and 330 or 140, 40, MasteryColor, 0, 1)
/*
	if me:GetObserverMode() ~= OBS_MODE_NONE then
		surface.SetDrawColor(0, 0, 0, tonumber(self.tea_screenfadeout))
		surface.DrawRect(0, 0, ScrW(), ScrH())
		surface.SetDrawColor(255, 255, 0, math.Clamp(tonumber(self.tea_survivalstats_a), 0, 200))
		surface.DrawOutlinedRect(ScrW() / 2 - 300, (ScrH() / 2) + 120, 600, 200)

		surface.SetDrawColor(255, 255, 255, tonumber(self.tea_survivalstats_a))
		surface.DrawRect(0, ScrH() / 2 - 140, ScrW(), 80)
		surface.SetDrawColor(255, 255, 255, math.Clamp(tonumber(self.tea_survivalstats_a), 0, 200))
		surface.DrawOutlinedRect(0, (ScrH() / 2) - 140, ScrW(), 80)

		draw.DrawText("You are dead", "DeathScreenFont", ScrW() / 2, ScrH() / 2 - 40, Color(255, 255, 255, tonumber(self.tea_deathtext_a)), TEXT_ALIGN_CENTER)

		draw.DrawText(self.DeathMessage, "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 - 110, Color(0, 0, 0, tonumber(self.tea_survivalstats_a)), TEXT_ALIGN_CENTER)

		draw.DrawText("SURVIVAL STATS", "DeathScreenFont_3", ScrW() / 2, ScrH() / 2 + 90, Color(255, 255, 255, tonumber(self.tea_survivalstats_a)), TEXT_ALIGN_CENTER)

		local survtime,bsurvtime = math.floor(self.MyLastSurvivalStats.SurvivalTime), math.floor(self.MyLastSurvivalStats.BestSurvivalTime)
		local text = Format(bsurvtime < survtime and "Survival Time: %ss (Previous Best: %ss, +%ss)" or "Survival Time: %ss", survtime, bsurvtime, survtime - bsurvtime)
		draw.DrawText(text, "DeathScreenFont_2", (ScrW() / 2) - 275, (ScrH() / 2) + 150, Color(255, 255, 255, tonumber(self.tea_survivalstats_a)), 0)
	end
*/
	if !me:Alive() and self:GetEvent() == EVENT_NONE then
		if self.HUDStyle == HUDSTYLE_CLASSIC then
			local a = 205

			local message
			draw.DrawText("You died", "TargetIDSmall", ScrW() / 2, ScrH() / 2 - 40, Color(230,115,115,a), TEXT_ALIGN_CENTER)
			draw.DrawText("Cause of death: "..self.DeathMessage, "TargetIDSmall", ScrW() / 2, ScrH() / 2 - 180, Color(230,230,230,a), TEXT_ALIGN_CENTER)

			local survtime,bsurvtime = math.floor(self.MyLastSurvivalStats.SurvivalTime), math.floor(self.MyLastSurvivalStats.BestSurvivalTime)

			draw.DrawText(Format(bsurvtime < survtime and "Survival Time: %s (Previous Best: %s, +%s)" or "Survival Time: %s", util.ToMinutesSeconds(survtime), util.ToMinutesSeconds(bsurvtime), util.ToMinutesSeconds(survtime - bsurvtime)),
			"TargetIDSmall", ScrW() / 2, ScrH() / 2 + 20, Color(230,230,230,a), TEXT_ALIGN_CENTER)
			draw.DrawText(Format("Zombies killed: %d", self.MyLastSurvivalStats.ZombiesKilled), "TargetIDSmall", ScrW() / 2, ScrH() / 2 + 44, Color(230,230,230,a), TEXT_ALIGN_CENTER)
			draw.DrawText(Format("Players killed: %d", self.MyLastSurvivalStats.PlayersKilled), "TargetIDSmall", ScrW() / 2, ScrH() / 2 + 68, Color(230,230,230,a), TEXT_ALIGN_CENTER)
		else
			local a = 205

			local message
			draw.DrawText("You died", "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 - 40, Color(230,115,115,a), TEXT_ALIGN_CENTER)
			draw.DrawText("Cause of death: "..self.DeathMessage, "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 - 180, Color(230,230,230,a), TEXT_ALIGN_CENTER)

			local survtime,bsurvtime = math.floor(self.MyLastSurvivalStats.SurvivalTime), math.floor(self.MyLastSurvivalStats.BestSurvivalTime)

			draw.DrawText(Format(bsurvtime < survtime and "Survival Time: %s (Previous Best: %s, +%s)" or "Survival Time: %s", util.ToMinutesSeconds(survtime), util.ToMinutesSeconds(bsurvtime), util.ToMinutesSeconds(survtime - bsurvtime)),
			"DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 20, Color(230,230,230,a), TEXT_ALIGN_CENTER)
			draw.DrawText(Format("Zombies killed: %d", self.MyLastSurvivalStats.ZombiesKilled), "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 44, Color(230,230,230,a), TEXT_ALIGN_CENTER)
			draw.DrawText(Format("Players killed: %d", self.MyLastSurvivalStats.PlayersKilled), "DeathScreenFont_2", ScrW() / 2, ScrH() / 2 + 68, Color(230,230,230,a), TEXT_ALIGN_CENTER)
		end


		if self.HUDStyle == HUDSTYLE_ATE then
			surface.SetDrawColor(255,255,0,255)
			surface.DrawOutlinedRect(ScrW() / 2 - 135,90,270,40)
			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(ScrW() / 2 - 135,90,270,40)
			message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()),0,2147483647),translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
			draw.DrawText(message, "TargetIDSmall", ScrW() / 2, 102, Color(255,255,255), TEXT_ALIGN_CENTER)
		elseif self.HUDStyle == HUDSTYLE_CLASSIC then
			message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
			draw.DrawText(message, "TargetID", ScrW() / 2, ScrH() / 2 - 200, Color(255,255,255), TEXT_ALIGN_CENTER)
		elseif self.HUDStyle == HUDSTYLE_TEA then
			message = Spawn > CurTime() + 1 and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("seconds")) or Spawn > CurTime() and translate.Format("respawn_1", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647), translate.Get("second")) or translate.Get("respawn_2")
			draw.DrawText(message, "TargetID", ScrW() / 2, ScrH() / 2 - 200, Color(255,255,255), TEXT_ALIGN_CENTER)
		end
	end

	draw.SimpleText(translate.Format("xpgained", XPGained, TotalXPGained), "TargetID", ScrW() / 2 + 10, ScrH() / 2, XPColor, 0, 1)
	draw.SimpleText(translate.Format("cashgained", MoneyGained, TotalMoneyGained), "TargetID", ScrW() / 2 + 10, ScrH() / 2 + 18, MoneyColor, 0, 1)

	if self.DrawVersionOnHUD then
		local glow = 127 + math.abs(math.sin(CurTime() * 0.74) * 128)
		local dbgmode = self:GetDebug()
		draw.SimpleText(dbgmode >= DEBUGGING_TRUE and translate.Format("ver_5", self.Version)
		or dbgmode >= DEBUGGING_EXPERIMENTAL and translate.Format("ver_4", self.Version)
		or dbgmode >= DEBUGGING_ADVANCED and translate.Format("ver_3", self.Version)
		or dbgmode >= DEBUGGING_NORMAL and translate.Format("ver_2", self.Version)
		or translate.Format("ver_1", self.Version), "TargetIDSmall", 2, 1, Color(191, 191, glow, 45), 0, 0)
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
	local me = LocalPlayer()
	if me:GetObserverMode() ~= OBS_MODE_NONE then return end

	local modify = {}
	local color = 1
	local hp = (((me:GetMaxHealth() * 0.5) - me:Health()) * (1 / (me:GetMaxHealth() * 0.5)))
	
	if (me:Health() < (me:GetMaxHealth() * 0.5)) then
		if (me:Alive()) then
			color = math.Clamp(color - hp, 0, color)
		else
			color = 0
		end

		DrawMotionBlur(math.Clamp(1 - hp, 0.1, 1), 1, 0)
	end

	if GAMEMODE.WraithAlpha > 220 then DrawMotionBlur(0.4, 0.8, 0.01) end


	local horror = false

	modify["$pp_colour_addr"] = 0
	modify["$pp_colour_addg"] = 0
	modify["$pp_colour_addb"] = 0
	modify["$pp_colour_brightness"] = horror and -0.045 or 0
	modify["$pp_colour_contrast"] = (horror and 1.15 or 1) * (!me:Alive() and math.Clamp(1 + (self.LastAliveTime + 5 - CurTime()) * 0.2, 0.05, 1) or 1)
	modify["$pp_colour_colour"] = horror and math.max(0, color - 0.725) or color
	modify["$pp_colour_mulr"] = 0
	modify["$pp_colour_mulg"] = 0
	modify["$pp_colour_mulb"] = 0
	
	DrawColorModify(modify)
end

function GM:DrawMiscThings()
	local me = LocalPlayer()
	for _, ent in pairs (ents.FindByClass("structure_base_core")) do
		if ent:GetPos():DistToSqr(me:GetPos()) < 810000 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then --900^2
			local t2 = ScrW() / 2 - 175
			local s2 = 85
			local facmsg = "Faction: "..team.GetName(ent:GetNWEntity("owner"):Team())
			if self.HUDStyle == HUDSTYLE_ATE then
				surface.SetDrawColor(255, 255, 0, 255)
				surface.DrawOutlinedRect(t2, s2, 350, 45)
				surface.SetDrawColor(0, 0, 0, 200)
				surface.DrawRect(t2, s2, 350, 45)
			end
--			local xz, xy = surface.GetTextSize(facmsg)
			if ent:GetNWEntity("owner"):Team() == me:Team() then
				draw.DrawText("You are in friendly territory", "TargetID", t2 + 65, s2 + 4, Color(205, 255, 205, 255))
			else
				draw.DrawText("You are in another factions territory!", "TargetID", t2 + 32, s2 + 4, Color(255, 255, 255, 255))
			end
			draw.DrawText(facmsg , "TargetID", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), 1)
		end
	end


	for _, ent in pairs (ents.FindByClass("airdrop_cache")) do
		if ent:GetPos():DistToSqr(me:GetPos()) < 1440000 and ent:GetNWBool("ADActive") then --1200^2
		local t2 = ScrW() / 2 - 175
		local s2 = 25
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t2, s2, 350, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t2, s2, 350, 45)
		draw.DrawText("You are in an active airdrop zone!", "TargetID", t2 + 42, s2 + 4, Color(255, 205, 205, 255))
		draw.DrawText("PvP is forced, beware of other survivors!", "TargetID", t2 + 15, s2 + 22, Color(255, 205, 205, 255))
		end
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


	if ent:GetClass() == "prop_flimsy" or ent:GetClass() == "prop_strong" or SpecialSpawns[ent:GetClass()] then 
		local owner = ent:GetNWEntity("owner")
		if !owner or !owner:IsValid() then return false end
		local t = ScrW() / 2 - 175
		local s = ScrH() - 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 350, 65)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 350, 65)
		draw.DrawText(ent.PrintName, "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText("Owner: ".. owner:Nick(), "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
		draw.DrawText("Faction:", "TargetID", t + 5, s + 40, Color(255, 255, 255, 255))
		draw.DrawText(team.GetName(owner:Team()), "TargetID", t + 72, s + 40, team.GetColor(owner:Team()))


		local shp = ent:GetNWInt("ate_integrity", -1)
		local smaxhp = ent:GetNWInt("ate_maxintegrity", -1)
		if shp < 0 or smaxhp < 0 then return end
		local dix = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
		local fraction = shp / smaxhp
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(dix.x - 75, dix.y, 150, 25)

		surface.SetDrawColor(100, 0, 0, 190)
		surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 25)
		surface.SetDrawColor(110, 0, 0, 190)
		surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 12)

		surface.SetDrawColor(150, 0, 0, 200)
		surface.DrawOutlinedRect(dix.x - 75, dix.y, 150, 25)
		draw.DrawText(math.Round(fraction * 10000) / 100 .."%", "TargetID", dix.x, dix.y + 4, Color(255, 255, 255, 155), 1)
	end
	

	if ent:GetClass() == "ate_droppeditem" then 

		local name = ent:GetNWString("ItemClass")

		local itemtable = self.ItemsList[name]
		if !itemtable then return false end
		local rarity = itemtable.Rarity

		local raretbl = gamemode.Call("CheckItemRarity", rarity)
		
		local t = ScrW() / 2 - 100
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 200, 65)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 200, 65)
		draw.DrawText(GAMEMODE:GetItemName(name), "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText(itemtable.Weight.."kg", "TargetID", t + 5, s + 22, Color(255, 255, 155, 255))
		draw.DrawText("Rarity: "..raretbl.text, "TargetID", t + 5, s + 40, raretbl.col)
	end

	if ent:GetClass() == "loot_cache" or ent:GetClass() == "loot_cache_weapon" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 150, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 150, 45)
		draw.DrawText("Loot Cache", "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText("Press E to pick up", "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
	end

	if ent:GetClass() == "loot_cache_special" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 150, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 150, 45)
		draw.DrawText("Rare Cache", "TargetID", t + 5, s + 4, Color(255,255,255,255))
		draw.DrawText("Press E to pick up", "TargetID", t + 5, s + 22, Color(255,255,255,255))
	end

	if ent:GetClass() == "loot_cache_boss" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 150, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 150, 45)
		draw.DrawText("Boss Cache", "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText(ent:GetNWEntity("pickup"):IsValid() and ent:GetNWEntity("pickup"):IsPlayer() and ent:GetNWEntity("pickup") != me and "Can't pick up" or "Can pick up", "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
	end

	if ent:GetClass() == "loot_cache_faction" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 150, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 150, 45)
		draw.DrawText("Faction Loot Cache", "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText("Press E to pick up", "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
	end


	if ent:GetClass() == "ate_cash" then 
		if !ent:GetNWInt("CashAmount") then return false end
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 255, 0, 255)
		surface.DrawOutlinedRect(t, s, 150, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t, s, 150, 45)
		draw.DrawText(ent:GetNWInt("CashAmount").." "..self.Config["Currency"].."(s)", "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText("Press E to pick up", "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
	end
end



function GM.ScreenEffects()
	local me = LocalPlayer()
	if me:GetObserverMode() ~= OBS_MODE_NONE then return end
	if me:Alive() then
		if GAMEMODE.WraithAlpha <= 0 then return end

		surface.SetDrawColor(0, 0, 0, math.Round(GAMEMODE.WraithAlpha * (me:IsNewbie() and 0.8 or 1)))
		surface.DrawRect(-1, -1, ScrW() + 1, ScrH() + 1)
	else
		GAMEMODE.WraithAlpha = 0
	end
end
hook.Add("RenderScreenspaceEffects", "tea_VariousEffects", GM.ScreenEffects)

net.Receive("PrestigeEffect", function()
	pralpha = 263
end)

function GM.PrestigeEffects()
	if LocalPlayer():GetObserverMode() ~= OBS_MODE_NONE then return end
	if pralpha > 0 then pralpha = math.Clamp(pralpha - 3, 0, 263)
	else return end
	
	surface.SetDrawColor(255, 255, 255, math.Round(math.Clamp(pralpha, 0, 255)))
	surface.DrawRect(-1, -1, ScrW() + 1, ScrH() + 1)
end
hook.Add("RenderScreenspaceEffects", "PrestigeEffect", GM.PrestigeEffects)


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


local spawntypes = {
	["zombies"] = {
		txt = "Zombie Spawn %s",
		col = Color(255,0,0)
	},

	["loots"] = {
		txt = "Loot Spawn %s",
		col = Color(0,255,0)
	},

	["traders"] = {
		txt = "Trader Spawn %s",
		col = Color(0,128,255)
	},

	["taskdealers"] = {
		txt = "Task Dealer Spawn %s",
		col = Color(128,0,255)
	},

	["airdrops"] = {
		txt = "Airdrop Spawn %s",
		col = Color(255,255,0)
	},

	["playerspawns"] = {
		txt = "Player Spawn %s",
		col = Color(255,255,255)
	},
}

hook.Add("PostDrawTranslucentRenderables", "GM.Spawns", function(bDrawingDepth, bDrawingSkybox, isDraw3DSkybox)
	if isDraw3DSkybox then return end
	if not GAMEMODE.Spawns then return end
	local ply = LocalPlayer()
	if not AdminCheck(ply) then return end


	for spawntype, spawns in pairs(GAMEMODE.Spawns) do
		for _,v in pairs(spawns) do
			if not spawntypes[spawntype] then continue end
			local pos = v[1]
			local ang = v[2]

			-- pos.x = math.Round(pos.x)
			-- pos.y = math.Round(pos.y)
			-- pos.z = math.Round(pos.z)

			local txt = spawntypes[spawntype].txt
			local col = spawntypes[spawntype].col
			local ang = ply:EyeAngles() + Angle(0,-90,90)
			ang.pitch = 0

			-- PrintTable(pos)
			render.DrawLine(pos + Vector(0,0,40), pos, col)
			cam.Start3D2D(pos + Vector(0,0,60), ang, math.Clamp(ply:GetPos():Distance(pos)/500, 0.5, 5))
			cam.IgnoreZ(true)
			draw.DrawText(Format(txt, pos), "TargetID", 0, 0, col, TEXT_ALIGN_CENTER)
			cam.End3D2D()
			cam.Start3D2D(pos + Vector(0,0,60), ang + Angle(0,180,0), math.Clamp(ply:GetPos():Distance(pos)/500, 0.5, 5))
			draw.DrawText(Format(txt, pos), "TargetID", 0, 0, col, TEXT_ALIGN_CENTER)
			cam.End3D2D()
			-- pos
			-- local Ang = Angle(0,0,0)
			-- cam.Start3D2D(pos + Vector(0,0,40), Ang, 0.6)
			-- surface.DrawLine(startX, startY, endX, endY)
		end
	end
	cam.IgnoreZ(false)
end)



