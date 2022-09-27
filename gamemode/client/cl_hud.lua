---------------- HUD ----------------

dohuddraw = 1

local wralpha = 0 -- wraith blind effect
local pralpha = 0 -- wraith blind effect (but white and when prestiged)

Spawn = 0


Mystamina = 0
Myhunger = 0
Mythirst = 0
Myfatigue = 0
Myinfection = 0
Mysurvivaltime = 0
Mybattery = 0
Mylevel = 0
Myprestige = 0
Mymoney = 0
Myxp = 0
Mypoints = 0
Mybounty = 0


net.Receive( "UpdateStats", function( length ) -- this net message is received once per frame
	local stam = net.ReadFloat()
	local hung = net.ReadFloat()
	local thir = net.ReadFloat()
	local fat = net.ReadFloat()
	local infec = net.ReadFloat()
	local survtim = net.ReadFloat()
	local bat = net.ReadFloat()

	Mystamina = stam
	Myhunger = hung
	Mythirst = thir
	Myfatigue = fat
	Myinfection = infec
	Mysurvivaltime = survtim
	Mybattery = bat
end)

net.Receive( "UpdatePeriodicStats", function( length ) -- this net message is only received when one of these values need to be updated
	local level = net.ReadFloat()
	local prestige = net.ReadFloat()
	local money = net.ReadFloat()
	local setxp = net.ReadFloat()
	local points = net.ReadFloat()
	local bounty = net.ReadFloat()

	Mylevel = level
	Myprestige = prestige
	Mymoney = money
	Myxp = setxp
	Mypoints = points
	Mybounty = bounty
end)



surface.CreateFont( "Arial", {
	font = "Arial",
	size = 12,
	weight = 500,
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


local XPColor = Color(255, 255, 255, 0)
local XPGained = 0
local MoneyColor = Color(255, 255, 255, 0)
local MoneyGained = 0
local MasteryType = 0
local MasteryXPGained = 0
local MasteryColor = Color(205, 205, 205, 0)

function GM:HUDDrawTargetID()	
	return false
end

net.Receive( "Payout", function( length )
	local xpgain = net.ReadFloat()
	local moneygain = net.ReadFloat()

	XPGained = xpgain
	MoneyGained = moneygain
	if XPGained != 0 then XPColor = Color( 255, math.Clamp(350 - (0.2 * XPGained), 0, 255), math.Clamp(350 - (0.2 * XPGained), 0, 255), 255 ) end
	if MoneyGained != 0 then MoneyColor = Color( 255, math.Clamp(350 - (0.2 * MoneyGained), 0, 255), math.Clamp(350 - (0.2 * MoneyGained), 0, 255), 255 ) end
	timer.Create( "payout_timer", 2.75, 1, function() XPColor = Color( 255, 255, 255, 0 ) MoneyColor = Color( 255, 255, 255, 0 ) end )
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
	if GetConVar("tea_server_voluntarypvp"):GetInt() <= -1 then return -1 end
	if GetConVar("tea_server_voluntarypvp"):GetInt() >= 1 then return 4 end
	if LocalPlayer():Team() == 1 and LocalPlayer():GetNWBool("pvp") then return 2 end
	if LocalPlayer():Team() != 1 then return 2 end
	if LocalPlayer():IsPvPForced() then return 3 end
	return 0
end


local function DrawNames()
	local trace = {}

	if GetConVar("tea_server_debugging"):GetInt() >= 2 then
		trace.start = LocalPlayer():EyePos()
		trace.endpos = trace.start + LocalPlayer():GetAimVector() * 1500000
		trace.filter = LocalPlayer()
	
		local tr = util.TraceLine(trace)
		if !tobool(GetConVarNumber("tea_cl_hud")) or !tobool(GetConVarNumber("cl_drawhud")) or LocalPlayer():GetActiveWeapon() == "gmod_camera" then return end 
		if tr.Entity != NULL then
			draw.SimpleText(tr.Entity, "TargetIDSmall", 20, 180, Color(205,205,255,255), 0, 0)
			if tr.Entity:Health() > 0 then
				draw.SimpleText("Ent HP: "..tr.Entity:Health().."/"..tr.Entity:GetMaxHealth(), "TargetIDSmall", 20, 210, Color(205,205,255,255), 0, 0)
			end
		else
			draw.SimpleText("Entity [?][NULL]", "TargetIDSmall", 20, 180, Color(205,205,255,255), 0, 0)
		end
	end
	trace.start = LocalPlayer():EyePos()
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 1500
	trace.filter = LocalPlayer()

	local tea_server_voluntarypvp = GetConVar("tea_server_voluntarypvp")	
	local tr = util.TraceLine(trace)
	local ply = tr.Entity
	if ply:IsValid() and ply:IsPlayer() and ply != LocalPlayer() and ply:Alive() then
		local headPos = (ply:GetShootPos() + Vector(0,0,18)):ToScreen()
		surface.SetFont("TargetID")

		local message = ply:Nick()
		local wo, ho = surface.GetTextSize(message)

		surface.SetFont("TargetIDSmall")

		local message2 = translate.Get("Health")..": "..ply:Health().." / "..ply:GetMaxHealth()
		local wo2, ho2 = surface.GetTextSize(message2)

		local message3 = translate.Get("Armor")..": "..ply:Armor().." / "..ply:GetMaxArmor()
		local wo3, ho3 = surface.GetTextSize(message3)
 
		local message4 = translate.Get("Level")..": "..ply:GetNWInt("PlyLevel", 1)
		local wo4, ho4 = surface.GetTextSize(message4)
 
		local message5 = translate.Get("Bounty")..": "..math.floor(ply:GetNWInt("PlyBounty", 0))
		local wo5, ho5 = surface.GetTextSize(message5)
	
		local message6 = translate.Get("Faction")..": "..team.GetName(ply:Team())
		local wo6, ho6 = surface.GetTextSize(message6)

		if ply:IsPvPGuarded() then
			draw.SimpleTextOutlined(  "p", "CounterShit", headPos.x - 15, headPos.y - 62, Color( 50, 250, 0, 255 ), 0, 0, 2, Color( 0, 50, 0, 255 ) )
		elseif ply:IsPvPForced() or (ply:Team() == 1 and ply:GetNWBool("pvp") == true) or ( (ply:Team() != 1 and ply:Team() != LocalPlayer():Team()) or (ply:Team() == 1 and !tobool(GetConVarNumber("tea_server_voluntarypvp")))) then
			draw.SimpleTextOutlined(  "C", "CounterShit", headPos.x - 25, headPos.y - 60, Color( 255, 50, 0, 255 ), 0, 0, 2, Color( 50, 0, 0, 255 ) )
		end

		draw.SimpleTextOutlined(ply:Nick(), "TargetID", headPos.x - (wo /2 ), headPos.y - 40, Color( 255, 255, 255, 255 ), 0, 0, 2, Color( 0, 0, 0, 255 ) )
		draw.SimpleTextOutlined(translate.Get("Health")..": " .. ply:Health() .." / " .. ply:GetMaxHealth(), "TargetIDSmall", headPos.x - (wo2 / 2), headPos.y - 20, Color( 255, math.Clamp(((ply:Health() * 100) / ply:GetMaxHealth()) * 2.5, 0, 255), math.Clamp(((ply:Health() * 100) / ply:GetMaxHealth()) * 2.5, 0, 255), 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
		draw.SimpleTextOutlined(translate.Get("Armor")..": " .. ply:Armor() .." / " .. ply:GetMaxArmor(), "TargetIDSmall", headPos.x - (wo3 / 2), headPos.y - 7, Color( math.Clamp((50 + (ply:Armor() * 100) / ply:GetMaxArmor()), 0, 255), math.Clamp((50 + (ply:Armor() * 100) / ply:GetMaxArmor()), 0, 255), 255, 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
		draw.SimpleTextOutlined(translate.Get("Level")..": " .. ply:GetNWInt( "PlyLevel", 1 ) , "TargetIDSmall", headPos.x - (wo4 / 2 ) - 2, headPos.y + 7, Color( 255, 205, 255, 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
		draw.SimpleTextOutlined(translate.Get("Bounty")..": " .. math.floor(ply:GetNWInt( "PlyBounty", 0 )) , "TargetIDSmall", headPos.x - (wo5 / 2 ) - 2, headPos.y + 20, Color( 255, 64, 64, 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
		draw.SimpleTextOutlined(translate.Get("Faction")..": "..team.GetName(ply:Team()), "TargetIDSmall", headPos.x - (wo6 / 2 ) - 2, headPos.y + 33, team.GetColor(ply:Team()), 0, 0, 1, Color( 0, 0, 0, 255 ) )
	end
end

MaxClipAmmo = {}

local function DrawVitals()
	local me = LocalPlayer()
	if !me:Alive() or !me:IsValid() then return end
	if GetConVar("tea_cl_hud"):GetInt() < 1 or GetConVar("cl_drawhud"):GetInt() < 1 or me:GetActiveWeapon() == "gmod_camera" then return end 
	local Health = me:Health()
	local MaxHealth = me:GetMaxHealth()
	local Armor = me:Armor()
	local MaxArmor = me:GetMaxArmor()
--	local HealthTexture = surface.GetTextureID( "gui/silkicons/heart" )
--	local ArmorTexture = surface.GetTextureID( "gui/silkicons/shield" )
	local DGradientCenter = surface.GetTextureID( "gui/center_gradient" )
	local timesurvived = CurTime() - Mysurvivaltime

	local glow = math.abs(math.sin(CurTime() * 1.7) * 255)

	if Myhunger < 1000 then
		draw.SimpleText(translate.Get("NeedToEatHunger"), "TargetID", 21, ScrH() - 360, Color( 255, glow, glow, 255 ), 0, 1)
	end

	if Mythirst < 1000 then
		draw.SimpleText(translate.Get("NeedToDrinkThirst"), "TargetID", 21, ScrH() - 340, Color( 255, glow, glow, 255 ), 0, 1)
	end

	if Myfatigue > 9000 then
		draw.SimpleText(translate.Get("NeedToSleepFatigue"), "TargetID", 21, ScrH() - 320, Color( 255, glow, glow, 255 ), 0, 1)
	end

	if Myinfection > 9000 then
		draw.SimpleText(translate.Get("NeedToCureInfection"), "TargetID", 21, ScrH() - 300, Color( 255, glow, glow, 255 ), 0, 1)
	end


	if GetConVar("tea_cl_hudstyle"):GetInt() < 1 then
---------------- HEALTH ----------------
		draw.RoundedBox(1, 10, ScrH() - 110, 180, 100, Color(0, 0, 0, 175))
		surface.SetDrawColor(90, 0, 0 ,255)
		surface.DrawOutlinedRect(10, ScrH() - 110, 180, 100)
		draw.SimpleText(translate.Get("Health")..": " .. Health .. "/" .. MaxHealth, "TargetIDSmall", 21, ScrH() - 96, Color(math.Clamp(255 * (Health / MaxHealth), 127, 255),48,48,255), 0, 1)
		draw.RoundedBox(2, 20, ScrH() - 86, 160, 20, Color(50, 0, 0, 160))
		if Health > 0 then
			local hpbarclamp = math.Clamp(160 * ( Health / MaxHealth ), 0, 160)
			draw.RoundedBox( 4, 20, ScrH() - 86, hpbarclamp, 20, Color( 150, 0, 0, 160 ) )
			draw.RoundedBox( 4, 20, ScrH() - 86, hpbarclamp, 10, Color( 150, 0, 0, 100 ) )
		end

---------------- ARMOR ----------------
		draw.SimpleText(translate.Get("Armor")..": " .. Armor .. "/" .. MaxArmor, "TargetIDSmall", 21, ScrH() - 50, Color(48,48,math.Clamp(255 * (Armor / MaxArmor), 127, 255),255), 0, 1)
		draw.RoundedBox(2, 20, ScrH() - 36, 160, 20, Color( 0, 0, 50, 160 ) )
		if Armor > 0 then
			local armorbarclamp = math.Clamp(160 * (Armor / MaxArmor),0,160)
			draw.RoundedBox(4,20, ScrH() - 36, armorbarclamp,20,Color(0,0,150,160))
			draw.RoundedBox(4,20, ScrH() - 36, armorbarclamp,10,Color(0,0,150,160))
		end

		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(58, ScrH() - 36,4,20)
		surface.DrawRect(98, ScrH() - 36,4,20)
		surface.DrawRect(138, ScrH() - 36,4,20)
		surface.DrawOutlinedRect(20, ScrH() - 36,160,20)
		surface.DrawOutlinedRect(19, ScrH() - 37,162,22)

---------------- AMMO ----------------


		if me:GetActiveWeapon() != NULL then
			local SWEP = me:GetActiveWeapon()
			local AmmoClip1 = me:GetActiveWeapon():Clip1()
			local AmmoClip2 = me:GetActiveWeapon():Clip2()
			local MaxAmmoType = me:GetAmmoCount( me:GetActiveWeapon():GetPrimaryAmmoType() )
			local MaxAmmoType2 = me:GetAmmoCount( me:GetActiveWeapon():GetSecondaryAmmoType() )
				
			if not MaxClipAmmo[SWEP] then
				MaxClipAmmo[SWEP] = AmmoClip1
			elseif AmmoClip1 > MaxClipAmmo[SWEP] then
				MaxClipAmmo[SWEP] = AmmoClip1
			end
		
			if (MaxAmmoType != 0 or MaxAmmoType2 != 0 or AmmoClip1 > 0 or AmmoClip2 > 0) then
				IsAmmoBox = true
				--Ammo Box
				draw.RoundedBox( 1,  ScrW() - 270,  ScrH() - 140, 250, 70, Color( 0, 0, 0, 175 ) )
				surface.SetDrawColor(200, 100, 0 ,255)
				surface.DrawOutlinedRect(ScrW() - 270,  ScrH() - 140, 250, 70)
	
				--Ammo Text
				if (AmmoClip2 != -1) then
					draw.SimpleText( "Ammo in Clip: " .. AmmoClip1 .. " / " .. AmmoClip2, "TargetIDSmall", ScrW() - 259, ScrH() - 110, Color( 255, 255, 255, 255 ), 0, 1 )
				else
					draw.SimpleText( "Ammo in Clip: " .. AmmoClip1, "TargetIDSmall", ScrW() - 259, ScrH() - 110, Color( 255, 255, 255, 255 ), 0, 1) 
				end
		
				--Ammo bar base
				draw.RoundedBox( 2, ScrW() - 250, ScrH() - 98, 140, 20, Color( 150, 100, 0, 100 ) )
	
				--Second Clip Ammo Text
				draw.SimpleText( "Ammo Remaining: " .. MaxAmmoType, "TargetIDSmall", ScrW() - 259, ScrH() - 130, Color( 255, 255, 255, 255 ), 0, 1 )
	
				--Alt ammo Text
				draw.SimpleText( "ALT: " .. MaxAmmoType2, "TargetIDSmall", ScrW() - 89, ScrH() - 90, Color( 255, 255, 255, 255 ), 0, 1 )
		
	
				if AmmoClip1 > 0 then
					--Ammo Bar
					draw.RoundedBox( 4, ScrW() - 250, ScrH() - 98, 140 * ( AmmoClip1 / MaxClipAmmo[SWEP] ), 20, Color( 200, 110, 0, 200 ) )
					draw.RoundedBox( 4, ScrW() - 250, ScrH() - 98, 140 * ( AmmoClip1 / MaxClipAmmo[SWEP] ), 10, Color( 200, 150, 0, 50 ) )
				end
			else IsAmmoBox = false end
		end

-------------- EXperience --------------

		draw.RoundedBox( 1,  ScrW() - 270,  ScrH() - 60, 250, 50, Color( 0, 0, 0, 175 ) )
		draw.RoundedBox( 1,  ScrW() - 520,  ScrH() - 60, 240, 50, Color( 0, 0, 0, 175 ) )
		surface.SetDrawColor(90, 0, 0 ,255)
		surface.DrawOutlinedRect(ScrW() - 270,  ScrH() - 60, 250, 50)
		surface.SetDrawColor(40, 90, 0 ,255)
		surface.DrawOutlinedRect(ScrW() - 520,  ScrH() - 60, 240, 50)

		draw.SimpleText( "XP: " .. math.floor( Myxp ) .. "/" .. GetReqXP(), "TargetIDSmall", ScrW() - 259, ScrH() - 46, Color( 255, 255, 255, 255 ), 0, 1 )
		draw.RoundedBox( 2, ScrW() - 250, ScrH() - 36, 210, 20, Color( 50, 0, 0, 160 ) )
		draw.RoundedBox( 4, ScrW() - 250, ScrH() - 36, math.Clamp( 210 * ( Myxp / GetReqXP() ), 0, 210), 20, Color( 150, 0, 0, 160 ) )

		draw.SimpleText( translate.Get("Pts")..": " .. math.floor(Mypoints), "TargetIDSmall", ScrW() - 376, ScrH() - 36, Color( 255, 255, 255, 255 ), 0, 1 )
		draw.SimpleText( translate.Get("Bounty")..": " .. math.floor(Mybounty), "TargetIDSmall", ScrW() - 509, ScrH() - 36, Color(155, math.Clamp(127 - (Mybounty / 60), 0, 255), math.Clamp(255 - (Mybounty / 30), 0, 255), 255 ), 0, 1 )

---------------- More ----------------
		draw.RoundedBox( 1,  200,  ScrH() - 200, 180, 190, Color( 0, 0, 0, 175 ) )
		surface.SetDrawColor(125, 125, 55 ,255)
		surface.DrawOutlinedRect(200,  ScrH() - 200, 180, 190)

-------------- Stamina --------------
		draw.SimpleText( translate.Get("Stamina")..": " .. Mystamina.."%", "TargetIDTiny", 210, ScrH() - 186, Color( 205, 255, 205, 255 ), 0, 1 )
		draw.RoundedBox( 2, 210, ScrH() - 176, 160, 15, Color( 50, 50, 0, 100 ) )
		if Mystamina > 0 then
			local staminabarclamp = math.Clamp(Mystamina * 1.6, 0, 160)
			draw.RoundedBox( 4, 210, ScrH() - 176, staminabarclamp, 15, Color( 100, 150, 0, 160 ) )
			draw.RoundedBox( 4, 210, ScrH() - 176, staminabarclamp, 8, Color( 100, 150, 0, 160 ) )
		end

-------------- Hunger --------------
		draw.SimpleText( translate.Get("Hunger")..": "..math.Clamp(Myhunger / 100, 0, 2^1024).."%", "TargetIDTiny", 210, ScrH() - 150, Color( 255, 205, 255, 255 ), 0, 1 )
		draw.RoundedBox( 2, 210, ScrH() - 140, 160, 15, Color( 50, 0, 50, 100 ) )
		if (Myhunger / 100) > 0 then
			local hungerbarclamp = math.Clamp((Myhunger / 100) * 1.6, 0, 160)
			draw.RoundedBox( 4, 210, ScrH() - 140, hungerbarclamp, 15, Color( 90, 0, 120, 160 ) )
			draw.RoundedBox( 4, 210, ScrH() - 140, hungerbarclamp, 8, Color( 120, 0, 120, 80 ) )
		end

-------------- Thirst --------------
		draw.SimpleText( translate.Get("Thirst")..": "..math.Clamp(Mythirst / 100, 0, 2^1024).."%", "TargetIDTiny", 210, ScrH() - 114, Color(155,155,255,255), 0, 1 )
		draw.RoundedBox( 2, 210, ScrH() - 104, 160, 15, Color( 45, 45, 75, 100 ) )
		if (Mythirst / 100) > 0 then
			local thirstbarclamp = math.Clamp((Mythirst / 100) * 1.6, 0, 160)
			draw.RoundedBox( 4, 210, ScrH() - 104, thirstbarclamp, 15, Color(155,155,255,255) )
			draw.RoundedBox( 4, 210, ScrH() - 104, thirstbarclamp, 8, Color(155,155,255,255) )
		end

-------------- Fatigue --------------
		draw.SimpleText( translate.Get("Fatigue")..": "..math.Clamp(Myfatigue / 100, 0, 2^1024).."%", "TargetIDTiny", 210, ScrH() - 78, Color(205,205,255,255), 0, 1 )
		draw.RoundedBox( 2, 210, ScrH() - 68, 160, 15, Color( 0, 50, 50, 100 ) )
		if (Myfatigue / 100) > 0 then
			local fatiguebarclamp = math.Clamp((Myfatigue / 100) * 1.6, 0, 160)
			draw.RoundedBox(4, 210, ScrH() - 68, fatiguebarclamp, 15, Color(0, 80, 80, 160))
			draw.RoundedBox(4, 210, ScrH() - 68, fatiguebarclamp, 8, Color(0, 100, 100, 80))
		end

-------------- Infection --------------
		draw.SimpleText( translate.Get("Infection")..": "..math.Clamp(Myinfection / 100, 0, 2^1024).."%", "TargetIDTiny", 210, ScrH() - 42, Color( 205, 105, 105, 255 ), 0, 1 )
		draw.RoundedBox( 2, 210, ScrH() - 32, 160, 15, Color( 80, 0, 0, 100 ) )
		if (Myinfection / 100) > 0 then
			local infectionbarclamp = math.Clamp((Myinfection / 100) * 1.6, 0, 160)
			draw.RoundedBox( 4, 210, ScrH() - 32, infectionbarclamp, 15, Color( 250, 0, 0, 160 ) )
			draw.RoundedBox( 4, 210, ScrH() - 32, infectionbarclamp, 8, Color( 50, 0, 0, 100 ) )
		end

-------------- Battery --------------
		draw.RoundedBox(0, 140, 30, 180, 45, Color(0, 0, 0, 175))
		surface.SetDrawColor(0, 0, 60 ,255)
		surface.DrawOutlinedRect(140, 30, 180, 45)
		local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
		local armortype = ItemsList[armorstr]
		if armorstr and armortype then
			draw.SimpleText(translate.Get("Battery")..": "..math.Clamp(Mybattery, 0, 2^1024).."% (".. 100 + armortype["ArmorStats"]["battery"] .."% max)", "TargetIDTiny", 150, 42, Color(5,5,255,255), 0, 1 )
		else
			draw.SimpleText(translate.Get("Battery")..": "..math.Clamp(Mybattery, 0, 2^1024).."% (100% max)", "TargetIDTiny", 150, 42, Color(5,5,255,255), 0, 1)
		end
		draw.RoundedBox(2, 150, 52, 160, 15, Color( 0, 0, 80, 100 ) )
		if Mybattery > 0 then
			if armorstr and armortype then
				local batterybarclamp = math.Clamp((Mybattery * 1.6) / (1 + (armortype["ArmorStats"]["battery"] / 100)), 0, 160)
				draw.RoundedBox(4, 150, 52, batterybarclamp, 15, Color( 0, 0, 250, 160 ) )
				draw.RoundedBox(4, 150, 52, batterybarclamp, 8, Color( 0, 0, 50, 100 ) )
			else
				local batterybarclamp = math.Clamp(Mybattery * 1.6, 0, 160)
				draw.RoundedBox(4, 150, 52, batterybarclamp, 15, Color( 0, 0, 250, 160 ) )
				draw.RoundedBox(4, 150, 52, batterybarclamp, 8, Color( 0, 0, 50, 100 ) )	
			end
		end

----------------Levels, cash, prestige & time survived----------------

		draw.RoundedBox(1, 10, ScrH() - 200, 180, 85, Color(0, 0, 0, 175))
		surface.SetDrawColor(55, 55, 155 ,255)
		surface.DrawOutlinedRect(10,  ScrH() - 200, 180, 85)
		draw.DrawText(translate.Get("Timesurvived")..": "..math.floor(timesurvived).." s", "TargetIDSmall", 20, ScrH() - 189, Color(255,255,255,255), 0, 1)
		draw.SimpleText(translate.Get("Prestige")..": " .. math.floor(Myprestige), "TargetIDSmall", 20, ScrH() - 164, Color(205,155,255,255), 0, 1)
		draw.SimpleText(translate.Get("Level")..": " .. math.floor(Mylevel), "TargetIDSmall", 20, ScrH() - 147, Color(200,200,200,255), 0, 1)
		draw.SimpleText(translate.Get("Money")..": " .. math.floor(Mymoney), "TargetIDSmall", 20, ScrH() - 130, Color(0,255,255,255), 0, 1)
	else

---------------- HEALTH ----------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 200, 200, 8)
		draw.SimpleText( translate.Get("Health")..": " .. Health .. "/" .. MaxHealth, "TargetIDSmall", 21, ScrH() - 210, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(50,0,0,210)
		surface.DrawRect( 20, ScrH() - 200, 200, 8 )
		if Health > 0 then
			local hpbarclamp = math.Clamp(200 * (Health / MaxHealth), 0, 200)
			surface.SetDrawColor(150,0,0,210)
			surface.DrawRect( 20, ScrH() - 200, hpbarclamp, 4 )
			surface.SetDrawColor(150,0,0,150)
			surface.DrawRect( 20, ScrH() - 196, hpbarclamp, 4 )
		end

---------------- ARMOR ----------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 170, 200, 8)
		draw.SimpleText(translate.Get("Armor")..": " .. Armor .. "/" .. MaxArmor, "TargetIDSmall", 21, ScrH() - 180, Color(205,205,205,255),0,1)
		surface.SetDrawColor(0,0,50,210)
		surface.DrawRect( 20, ScrH() - 170, 200, 8 )
		if Armor > 0 then
			local armorbarclamp = math.Clamp(200 * (Armor / MaxArmor), 0, 200)
			surface.SetDrawColor(0,0,150,210)
			surface.DrawRect( 20, ScrH() - 170, armorbarclamp, 4 )
			surface.SetDrawColor(0,0,150,150)
			surface.DrawRect( 20, ScrH() - 166, armorbarclamp, 4 )
		end

---------------- AMMO ----------------
		if me:GetActiveWeapon() != NULL then
			local SWEP = me:GetActiveWeapon()
			local AmmoClip1 = me:GetActiveWeapon():Clip1()
			local AmmoClip2 = me:GetActiveWeapon():Clip2()
			local MaxAmmoType = me:GetAmmoCount( me:GetActiveWeapon():GetPrimaryAmmoType() )
			local MaxAmmoType2 = me:GetAmmoCount( me:GetActiveWeapon():GetSecondaryAmmoType() )
				
			if not MaxClipAmmo[SWEP] then
				MaxClipAmmo[SWEP] = AmmoClip1
			elseif AmmoClip1 > MaxClipAmmo[SWEP] then
				MaxClipAmmo[SWEP] = AmmoClip1
			end

			if (AmmoClip1 != -1 or AmmoClip2 != -1) then
				IsAmmoBox = true
				--Ammo Text
				if (AmmoClip2 != -1) then
					draw.SimpleText( "Ammo in Clip: " .. AmmoClip1 .. " / " .. AmmoClip2, "TargetIDSmall", 270, ScrH() - 210, Color(205,205,205,255), 0, 1) 
				else
					draw.SimpleText( "Ammo in Clip: " .. AmmoClip1, "TargetIDSmall", 270, ScrH() - 210, Color(205,205,205,255), 0, 1) 
				end
				--Second Clip Ammo Text
				draw.SimpleText("Ammo Remaining: " .. MaxAmmoType, "TargetIDSmall", 270, ScrH() - 192, Color(205,205,205,255), 0, 1)
				--Alt ammo Text
				draw.SimpleText("ALT: " .. MaxAmmoType2, "TargetIDSmall", 270, ScrH() - 174, Color(205,205,205,255), 0, 1 )
			else IsAmmoBox = false end
		end
-------------- EXperience --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(ScrW() - 250, ScrH() - 50, 200, 8)
		draw.SimpleText( "XP: ".. math.floor( Myxp ) .."/".. GetReqXP(), "TargetIDSmall", ScrW() - 250, ScrH() - 60, Color(205, 205, 205, 255), 0, 1)
		surface.SetDrawColor(50,0,0,75)
		surface.DrawRect( ScrW() - 250, ScrH() - 50, 200, 8 )
	
		local xpbarclamp = math.Clamp( 200 * ( Myxp / GetReqXP() ), 0, 200)
		surface.SetDrawColor(150,0,0,160)
		surface.DrawRect(ScrW() - 250, ScrH() - 50, xpbarclamp, 8 )
		--Skill Points?
		draw.SimpleText( translate.Get("Pts")..": " .. math.floor(Mypoints), "TargetIDSmall", 270, ScrH() - 86, Color( 205, 205, 205, 255 ), 0, 1 )
		--Bounty
		draw.SimpleText( translate.Get("Bounty")..": " .. math.floor(Mybounty), "TargetIDSmall", 270, ScrH() - 68, Color( 205, 205, 205, 255), 0, 1 )

-------------- Stamina -------------- 
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 140, 200, 8)
		draw.SimpleText( translate.Get("Stamina")..": " .. Mystamina.."%", "TargetIDSmall", 20, ScrH() - 150, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(50,50,0,75)
		surface.DrawRect( 20, ScrH() - 140, 200, 8 )
		if Mystamina > 0 then
			local staminabarclamp = math.Clamp(Mystamina * 2, 0, 200)
			surface.SetDrawColor(250, 200, 0, 160)
			surface.DrawRect( 20, ScrH() - 140, staminabarclamp, 4 )
			surface.SetDrawColor(220, 170, 0, 160)
			surface.DrawRect( 20, ScrH() - 136, staminabarclamp, 4 )
		end
-------------- Thirst --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 110, 200, 8)
		draw.SimpleText( translate.Get("Thirst")..": "..math.Clamp(Mythirst / 100, 0, 2^1024).."%", "TargetIDSmall", 20, ScrH() - 120, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(50,75,100,75)
		surface.DrawRect( 20, ScrH() - 110, 200, 8 )
		if Mythirst > 0 then
			local thirstbarclamp = math.Clamp(Mythirst / 50, 0, 200)
			surface.SetDrawColor(100,150,200,160)
			surface.DrawRect( 20, ScrH() - 110, thirstbarclamp, 4 )
			surface.SetDrawColor(90,135,180,160)
			surface.DrawRect( 20, ScrH() - 106, thirstbarclamp, 4 )
		end

-------------- Hunger --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 80, 200, 8)
		draw.SimpleText( translate.Get("Hunger")..": "..math.Clamp(Myhunger / 100, 0, 2^1024).."%", "TargetIDSmall", 20, ScrH() - 90, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(0,50,0,75)
		surface.DrawRect( 20, ScrH() - 80, 200, 8 )
		if Myhunger > 0 then
			local hungerbarclamp = math.Clamp(Myhunger / 50, 0, 200)
			surface.SetDrawColor(0,100,0,160)
			surface.DrawRect( 20, ScrH() - 80, hungerbarclamp, 4 )
			surface.SetDrawColor(0,100,0,160)
			surface.DrawRect( 20, ScrH() - 76, hungerbarclamp, 4 )
		end

-------------- Fatigue --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 50, 200, 8)
		draw.SimpleText( translate.Get("Fatigue")..": "..math.Clamp(Myfatigue / 100, 0, 2^1024).."%", "TargetIDSmall", 20, ScrH() - 60, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(75,75,75,75)
		surface.DrawRect( 20, ScrH() - 50, 200, 8 )
		if Myfatigue > 0 then
			local fatiguebarclamp = math.Clamp(Myfatigue / 50, 0, 200)
			surface.SetDrawColor(250,250,250,160)
			surface.DrawRect( 20, ScrH() - 50, fatiguebarclamp, 4 )
			surface.SetDrawColor(200,200,250,160)
			surface.DrawRect( 20, ScrH() - 46, fatiguebarclamp, 4 )
		end

-------------- Infection --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(20, ScrH() - 20, 200, 8)
		draw.SimpleText( translate.Get("Infection")..": "..math.Clamp(Myinfection / 100, 0, 2^1024).."%", "TargetIDSmall", 20, ScrH() - 30, Color(205,205,205,255), 0, 1 )
		surface.SetDrawColor(75,0,0,75)
		surface.DrawRect( 20, ScrH() - 20, 200, 8 )
		if Myinfection > 0 then
			local infectionbarclamp = math.Clamp(Myinfection / 50, 0, 200)
			surface.SetDrawColor(200,100,100,160)
			surface.DrawRect(20, ScrH() - 20, infectionbarclamp, 4)
			surface.SetDrawColor(160,80,80,160)
			surface.DrawRect(20, ScrH() - 16, infectionbarclamp, 4)
		end

-------------- Battery --------------
		surface.SetDrawColor(0, 0, 0 ,255)
		surface.DrawOutlinedRect(ScrW() - 250, ScrH() - 20, 200, 8)
		local armorstr = LocalPlayer():GetNWString("ArmorType") or "none"
		local armortype = ItemsList[armorstr]
		if armorstr and armortype then
			draw.SimpleText(translate.Get("Battery")..": "..math.Clamp(Mybattery, 0, 2^1024).."% (".. 100 + armortype["ArmorStats"]["battery"] .."% max)", "TargetIDSmall", ScrW() - 250, ScrH() - 30, Color(205,205,205,255), 0, 1 )
		else
			draw.SimpleText(translate.Get("Battery")..": "..math.Clamp(Mybattery, 0, 2^1024).."% (100% max)", "TargetIDSmall", ScrW() - 250, ScrH() - 30, Color(205,205,205,255), 0, 1 )	
		end
		surface.SetDrawColor(0,0,75,75)
		surface.DrawRect(ScrW() - 250, ScrH() - 20, 200, 8)
		if Mybattery > 0 then
			if armorstr and armortype then
				local batterybarclamp = math.Clamp((Mybattery * 2) / (1 + (armortype["ArmorStats"]["battery"] / 100)), 0, 200)
				surface.SetDrawColor(0,0,200,160)
				surface.DrawRect(ScrW() - 250, ScrH() - 20, batterybarclamp, 4)
				surface.SetDrawColor(0,0,150,160)
				surface.DrawRect(ScrW() - 250, ScrH() - 16, batterybarclamp, 4)
			else
				local batterybarclamp = math.Clamp(Mybattery * 2, 0, 200)
				surface.SetDrawColor(0,0,200,160)
				surface.DrawRect(ScrW() - 250, ScrH() - 20, batterybarclamp, 4)
				surface.SetDrawColor(0,0,150,160)
				surface.DrawRect(ScrW() - 250, ScrH() - 16, batterybarclamp, 4)	
			end
		end
----------------Levels, cash, prestige & time survived----------------
		draw.DrawText(translate.Get("Timesurvived")..": "..math.floor(timesurvived).." s", "TargetIDSmall", 270, ScrH() - 164, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Get("Prestige")..": " .. math.floor(Myprestige), "TargetIDSmall", 270, ScrH() - 140, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Get("Level")..": " .. math.floor(Mylevel), "TargetIDSmall", 270, ScrH() - 122, Color(205,205,205,255), 0, 1)
		draw.SimpleText(translate.Get("Money")..": " .. math.floor(Mymoney), "TargetIDSmall", 270, ScrH() - 104, Color(205,205,205,255), 0, 1)
	end	

	
	--Max Weight
	draw.SimpleText( translate.Get("CurrentlyCarrying")..": "..CalculateWeightClient(me).."kg/"..CalculateMaxWeightClient(me).."kg", "TargetIDSmall", 20, 155, Color( 205, 205, 205, 255), 0, 1 )

	if GetConVar("tea_server_debugging"):GetInt() >= 1 then
		draw.SimpleText(GAMEMODE.ZombieSpawningEnabled and "Zombie spawning enabled" or "Zombie spawning disabled", "TargetIDSmall", 20, 172, Color(205, 255, 205, 255), 0, 1)
		if GetConVar("tea_server_debugging"):GetInt() >= 2 then draw.SimpleText("Curtime: "..CurTime(), "TargetIDSmall", 20, 203, Color(205, 205, 255, 255), 0, 1) end
	end

-- Compass

	local angles = tostring(math.Round(-me:GetAngles().y + 180))
	local nang = math.rad(angles)
	local eang = math.rad(angles - 90)
	local sang = math.rad(angles - 180)
	local wang = math.rad(angles - 270)

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

	draw.SimpleText("N", "TargetID", nx - 5, ny - 10, Color(205,205,205,255), 0, 0) -- add 5 to x and 10 to y, i dont know why it puts them in the wrong position but whatever
	draw.SimpleText("E", "TargetID", ex - 5, ey - 10, Color(205,205,205,255), 0, 0)
	draw.SimpleText("S", "TargetID", sx - 5, sy - 10, Color(205,205,205,255), 0, 0)
	draw.SimpleText("W", "TargetID", wx - 5, wy - 10, Color(205,205,205,255), 0, 0)

/*
-- Threat level (currently working on it)

	local i = 0
	i = math.Clamp(i + 1, 0, 7)

	local threats = {
		[0] = "None",
		[1] = "Minimal",
		[2] = "Low",
		[3] = "Moderate",
		[4] = "High",
		[5] = "Very high",
		[6] = "Hell on Earth",
		[7] = "BEYOND"
	}

	surface.SetFont("TargetID")
	local txx, txy = surface.GetTextSize("Threat level: "..threats[i])
	surface.SetDrawColor(0,0,0,200)
	surface.DrawRect(135, 35, txx + 15, 27)
	surface.SetDrawColor(90,0,0,255)
	surface.DrawOutlinedRect(135, 35, txx + 15, 27)
	draw.SimpleText("Threat level: "..threats[i], "TargetID", 140, 40, Color(205,205,205,255), 0, 0)
*/

	-- draw pvp status

	local mpvp = GetMyPvP()
	local mpvptab = {
		[-1] = "100% PvE",
		[0] = "Disabled",
		[1] = "Guarded",
		[2] = "Enabled",
		[3] = "Forced",
		[4] = "Force-Enabled",
	}

	if GetConVar("tea_cl_hudstyle"):GetInt() < 1 then
		if mpvp == 3 or mpvp == 4 then
			surface.SetDrawColor(100,0,0,175)
		else
			surface.SetDrawColor(0,0,0,200)
		end
		surface.DrawRect(140, 80, 180, 27)
		surface.SetDrawColor(40,0,40,255)
		surface.DrawOutlinedRect(140, 80, 180, 27)

		draw.SimpleText("PvP: "..mpvptab[mpvp], "TargetIDSmall", 180, 86, Color(205,205,205,255), 0, 0 )
		if mpvp == 2 or mpvp == 3 or mpvp == 4 then
			draw.SimpleTextOutlined("C", "CounterShit", 135, 85, Color( 255, 50, 0, 255 ), 0, 0, 2, Color( 50, 0, 0, 255 ))
		elseif mpvp == 1 then
			draw.SimpleTextOutlined("p", "CounterShit", 145, 83, Color( 50, 250, 0, 255 ), 0, 0, 2, Color( 0, 50, 0, 255 ))
		else
			draw.SimpleTextOutlined("C", "CounterShit", 135, 85, Color( 50, 50, 50, 255 ), 0, 0, 2, Color( 20, 0, 0, 255 ))
		end
	else
		draw.SimpleText("PvP: "..mpvptab[mpvp], "TargetIDSmall", 270, ScrH() - 30, Color(205,205,205,255), 0, 0 )
	end

	for _, ent in pairs (ents.FindByClass("trader")) do
		if ent:GetPos():Distance(me:GetPos()) < 120 then
			draw.RoundedBox( 2, ScrW() / 2 - 230, 20, 460, 75, Color( 0, 0, 0, 175 ) )
			surface.SetDrawColor(155, 0, 0 ,255)
			surface.DrawOutlinedRect(ScrW() / 2 - 230, 20, 460, 75)
			draw.SimpleText("You are in a trader protection zone", "TargetID", ScrW() / 2 - 135, 40, Color( 255, 255, 255, 255 ), 0, 1)
			draw.SimpleText("You cannot hurt other players or be hurt by them while in this area", "TargetIDSmall", ScrW() / 2 - 221, 60, Color( 255, 255, 255, 255 ), 0, 1)
			draw.SimpleText("You take 10% less damage from all sources while in trader area", "TargetIDSmall", ScrW() / 2 - 221, 80, Color( 255, 255, 255, 255 ), 0, 1)
		end
	end
end


/*
timer.Simple(3, function() mouthbreather = CreateSound( LocalPlayer(), "player/breathe1.wav" ) end)
local dingus = Material( "overlays/scope_lens" )
local dingus2 = Material( "sprites/scope_arc" )
local function GasMaskOverlay()
		surface.SetDrawColor( Color(0,0,0,205))
		surface.SetMaterial( dingus )
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		surface.SetDrawColor( Color(0,0,0,105))
		surface.SetMaterial( dingus2 )
		surface.DrawTexturedRectRotated( ScrW() - 250, ScrH() - 250, 600, 600, 0 )
		surface.DrawTexturedRectRotated( ScrW() - 250, 250, 600, 600, 90 )
		surface.DrawTexturedRectRotated( 250, 250, 600, 600, 180 )
		surface.DrawTexturedRectRotated( 250, ScrH() - 250, 600, 600, 270 )

		if !mouthbreather:IsPlaying() then mouthbreather:Play() end
end

local gasmask = false
concommand.Add("gastest", function() surface.PlaySound( "npc/combine_soldier/gear3.wav" ) gasmask = !gasmask end)
*/

function GM:HUDPaint()
	if dohuddraw != 1 then return false end

/*
	if gasmask then 
		GasMaskOverlay() 
	else
		mouthbreather:Stop()
	end
*/

	self.BaseClass:HUDPaint()

	DrawVitals()
	DrawNames()
	DrawMiscThings()

	--XP, Money & Mastery gain texts
	draw.SimpleText(translate.Format("XPGained", XPGained).."!", "TargetID", ScrW() / 2 + 10, ScrH() / 2, XPColor, 0, 1 )
	draw.SimpleText(translate.Format("MoneyGained", MoneyGained).."!", "TargetID", ScrW() / 2 + 10, ScrH() / 2 + 15, MoneyColor, 0, 1 )
	draw.SimpleText(translate.Format("MasteryGained", MasteryXPGained, MasteryType), "TargetIDSmall", 140, 120, MasteryColor, 0, 1)

	local glow = 127 + math.abs(math.sin(CurTime() * 0.74) * 128)
	draw.SimpleText(GetConVar("tea_server_debugging"):GetInt() >= 2 and "Ver. "..GAMEMODE.Version.." (Debug Mode (Advanced))" or GetConVar("tea_server_debugging"):GetInt() >= 1 and "Ver. "..GAMEMODE.Version.." (Debug Mode)" or "Ver. "..GAMEMODE.Version, "TargetIDSmall", 10, 5, Color(191,191,glow,255), 0, 0 )
	draw.SimpleText("Time: "..os.date("%H:%M:%S"), "TargetIDSmall", 10, 19, Color(205,205,205,255), 0, 0 )
	if !LocalPlayer():Alive() then
		if GetConVar("tea_cl_hudstyle"):GetFloat() < 1 then
			surface.SetDrawColor(255, 0, 0, 255)
			surface.DrawOutlinedRect( ScrW( ) / 2 - 135, 90, 270, 40 )
			surface.SetDrawColor(0, 0, 0, 200)
			surface.DrawRect( ScrW( ) / 2 - 135, 90, 270, 40 )
			if Spawn > CurTime() + 1 then
				draw.DrawText(translate.Format("CanRespawnIn", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647 ), translate.Get("Seconds")), "TargetIDSmall", ScrW() / 2 - 106, 102, Color( 255,255,255,255 ), 0)
			elseif Spawn > CurTime() then
				draw.DrawText(translate.Format("CanRespawnIn", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647 ), translate.Get("Second")), "TargetIDSmall", ScrW() / 2 - 105, 102, Color( 255,255,255,255 ), 0)
			else
				draw.DrawText(translate.Get("CanNowRespawn"), "TargetIDSmall", ScrW( ) / 2 - 106, 102, Color( 255,255,255,255 ), 0)
			end
		else
			if Spawn > CurTime() + 1 then
				draw.DrawText(translate.Format("CanRespawnIn", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647 ), translate.Get("Seconds")), "TargetID", ScrW( ) / 2 - 108, ScrH() / 2 - 200, Color( 255,255,255,255 ), 0 )
			elseif Spawn > CurTime() then
				draw.DrawText(translate.Format("CanRespawnIn", math.Clamp(math.ceil(Spawn - CurTime()), 0, 2147483647 ), translate.Get("Second")), "TargetID", ScrW( ) / 2 - 108, ScrH() / 2 - 200, Color( 255,255,255,255 ), 0 )
			else
				draw.DrawText(translate.Get("CanNowRespawn"), "TargetID", ScrW( ) / 2 - 108, ScrH() / 2 - 200, Color( 255,255,255,255 ), 0 )
			end
		end
	end
end

function GM:HUDShouldDraw(name)
	local donotdraw = 
	{"CHudHealth", "CHudAmmo", "CHudSecondaryAmmo", "CHudBattery"}
	
	for k, v in pairs(donotdraw) do
		if (name == v) then return false end
	end
	return true
end

function GM:RenderScreenspaceEffects()
	local modify = {}
	local color = 1
	
	if (LocalPlayer():Health() < (LocalPlayer():GetMaxHealth() * 0.5)) then
		if (LocalPlayer():Alive()) then
			color = math.Clamp(color - (((LocalPlayer():GetMaxHealth() * 0.5) - LocalPlayer():Health()) * (1 / (LocalPlayer():GetMaxHealth() * 0.5))), 0, color)
		else
			color = 0
		end
		
		DrawMotionBlur(math.Clamp(1 - (((LocalPlayer():GetMaxHealth() * 0.5) - LocalPlayer():Health()) * (1 / (LocalPlayer():GetMaxHealth() * 0.5))), 0.1, 1), 1, 0)
	end

	if wralpha > 220 then DrawMotionBlur(0.4, 0.8, 0.01) end
	
	modify["$pp_colour_addr"] = 0
	modify["$pp_colour_addg"] = 0
	modify["$pp_colour_addb"] = 0
	modify["$pp_colour_brightness"] = 0
	modify["$pp_colour_contrast"] = 1
	modify["$pp_colour_colour"] = color
	modify["$pp_colour_mulr"] = 0
	modify["$pp_colour_mulg"] = 0
	modify["$pp_colour_mulb"] = 0
	
	DrawColorModify(modify)
end



function DrawMiscThings()
	for _, ent in pairs (ents.FindByClass("structure_base_core")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 900 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then
			local t2 = ScrW() / 2 - 175
			local s2 = 85
			local facmsg = "Faction: "..team.GetName(ent:GetNWEntity("owner"):Team())
			if GetConVar("tea_cl_hudstyle"):GetInt() < 1 then
				surface.SetDrawColor(255, 0, 0, 255)
				surface.DrawOutlinedRect( t2, s2, 350, 45 )
				surface.SetDrawColor(0, 0, 0, 200)
				surface.DrawRect( t2, s2, 350, 45 )
			end
--			local xz, xy = surface.GetTextSize( facmsg )
			if ent:GetNWEntity("owner"):Team() == LocalPlayer():Team() then
				draw.DrawText("You are in friendly territory", "TargetID", t2 + 65, s2 + 4, Color( 205, 255, 205, 255 ) )
				draw.DrawText(facmsg , "TargetID", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), 1 )
			else
				draw.DrawText("You are in another factions territory!", "TargetID", t2 + 32, s2 + 4, Color( 255, 255, 255, 255 ) )
				draw.DrawText(facmsg , "TargetID", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), 1 )
			end
		end
	end


	for _, ent in pairs (ents.FindByClass("airdrop_cache")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1200 and ent:GetNWBool("ADActive") then
		local t2 = ScrW() / 2 - 175
		local s2 = 25
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect(t2, s2, 350, 45)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(t2, s2, 350, 45)
		draw.DrawText("You are in an active airdrop zone!", "TargetID", t2 + 42, s2 + 4, Color( 255, 205, 205, 255 ) )
		draw.DrawText("PvP is forced, beware of other survivors!", "TargetID", t2 + 15, s2 + 22, Color( 255, 205, 205, 255 ) )
		end
	end


		local CurTargetEnt = nil
		local TargetText = {}
		local trace = {}


		trace.start = LocalPlayer():EyePos()
		trace.endpos = trace.start + LocalPlayer():GetAimVector() * 120
		trace.filter = LocalPlayer()
	
		local tr = util.TraceLine(trace)
		if !tr.Entity:IsValid() then return false end


		if tr.Entity:GetClass() == "prop_flimsy" or tr.Entity:GetClass() == "prop_strong" or SpecialSpawns[tr.Entity:GetClass()] then 
		local owner = tr.Entity:GetNWEntity("owner")
		if !owner or !owner:IsValid() then return false end
		local t = ScrW() / 2 - 175
		local s = ScrH() - 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 350, 65 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 350, 65 )
		draw.DrawText(tr.Entity.PrintName, "TargetID", t + 5, s + 4, Color(255, 255, 255, 255))
		draw.DrawText("Owner: ".. owner:Nick(), "TargetID", t + 5, s + 22, Color(255, 255, 255, 255))
		draw.DrawText("Faction:", "TargetID", t + 5, s + 40, Color(255, 255, 255, 255))
		draw.DrawText(team.GetName(owner:Team()), "TargetID", t + 72, s + 40, team.GetColor(owner:Team()))


		local shp = tr.Entity:GetNWInt( "ate_integrity", -1 )
		local smaxhp = tr.Entity:GetNWInt( "ate_maxintegrity", -1 )
		if shp < 0 or smaxhp < 0 then return end
		local dix = tr.Entity:LocalToWorld( tr.Entity:OBBCenter() ):ToScreen()
		local fraction = shp / smaxhp
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect( dix.x - 75, dix.y, 150, 25 )

		surface.SetDrawColor(100, 0, 0, 190)
		surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 25)
		surface.SetDrawColor(110, 0, 0, 190)
		surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 12)

		surface.SetDrawColor(150, 0, 0, 200)
		surface.DrawOutlinedRect( dix.x - 75, dix.y, 150, 25 )
		draw.DrawText(math.Round(fraction * 100).."%", "TargetID", dix.x, dix.y + 4, Color(255, 255, 255, 155), 1)
	end
	

	if tr.Entity:GetClass() == "ate_droppeditem" then 

		local name = tr.Entity:GetNWString("ItemClass")

		local itemtable = ItemsList[name]
		if !itemtable then return false end
		local rarity = itemtable.Rarity

		local rarecol
		local raretext
		if rarity == 0 then rarecol = Color(210,210,210,255) raretext = "Trash"
		elseif rarity == 1 then rarecol = Color(155,155,255,255) raretext = "Junk"
		elseif rarity == 2 then rarecol = Color(155,155,255,255) raretext = "Common"
		elseif rarity == 3 then rarecol = Color(105,255,105,255) raretext = "Uncommon"
		elseif rarity == 4 then rarecol = Color(255,200,0,255) raretext = "Rare"
		elseif rarity == 5 then rarecol = Color(255,100,0,255) raretext = "Super Rare"
		elseif rarity == 6 then rarecol = Color(50,50,255,255) raretext = "Epic"
		elseif rarity == 7 then rarecol = Color(255,50,50,255) raretext = "Mythic"
		elseif rarity == 8 then rarecol = Color(205,0,205,255) raretext = "Legendary"
		elseif rarity == 9 then rarecol = Color(255,255,255,255) raretext = "Godly"
		elseif rarity == 10 then rarecol = Color(85,85,255,255) raretext = "Event"
		elseif rarity == 11 then rarecol = Color(160,160,160,255) raretext = "Unobtainable"
		else rarecol = Color(96,96,96,255) raretext = "Uncategorized"
		end

		local t = ScrW() / 2 - 100
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 200, 65 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 200, 65 )
		draw.DrawText( translate.Get(itemtable.Name), "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( itemtable.Weight.."kg", "TargetID", t + 5, s + 22, Color( 255, 255, 155, 255 ) )
		draw.DrawText( "Rarity: "..raretext, "TargetID", t + 5, s + 40, rarecol )
	end

	if tr.Entity:GetClass() == "loot_cache" or tr.Entity:GetClass() == "loot_cache_weapon" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 150, 45 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 150, 45 )
		draw.DrawText( "Loot Cache", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end


	if tr.Entity:GetClass() == "loot_cache_boss" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 150, 45 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 150, 45 )
		draw.DrawText( "Boss Cache", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end

	if tr.Entity:GetClass() == "loot_cache_faction" then 
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 150, 45 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 150, 45 )
		draw.DrawText( "Faction Loot Cache", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end


	if tr.Entity:GetClass() == "ate_cash" then 
		if !tr.Entity:GetNWInt("CashAmount") then return false end
		local t = ScrW() / 2 - 75
		local s = ScrH() / 2 + 100
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( t, s, 150, 45 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( t, s, 150, 45 )
		draw.DrawText( tr.Entity:GetNWInt("CashAmount").." Dollars", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end
end

net.Receive("WraithBlind", function()
	wralpha = 253
end)


function WraithBlind()
	if wralpha > 220 then wralpha = wralpha - 0.095
elseif wralpha > 0 then wralpha = wralpha - 0.6
else return end

surface.SetDrawColor(0, 0, 0, math.Round(wralpha))
surface.DrawRect(-1, -1, surface.ScreenWidth() + 1, surface.ScreenHeight() + 1)
end
hook.Add("RenderScreenspaceEffects", "WraithBlind", WraithBlind)

net.Receive("PrestigeEffect", function()
	pralpha = 263
end)

function PrestigeEffect()
	if pralpha > 0 then pralpha = math.Clamp(pralpha - 3, 0, 263)
	else return end
	
	surface.SetDrawColor(255, 255, 255, math.Round(math.Clamp(pralpha, 0, 255)))
	surface.DrawRect(-1, -1, surface.ScreenWidth() + 1, surface.ScreenHeight() + 1)
end
hook.Add("RenderScreenspaceEffects", "PrestigeEffect", PrestigeEffect)


hook.Add("PostDrawOpaqueRenderables", "circle", function()
	for _, ent in pairs (ents.FindByClass("structure_base_core")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 2000 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then
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
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 2000 and ent:GetNWBool("ADActive") then
			local Pos = ent:GetPos()
			local Ang = Angle(0,0,0)
			cam.Start3D2D(Pos + ent:GetUp() * 10, Ang, 0.6)
			local TexturedQuadStructure =
			{
				texture = surface.GetTextureID( 'particle/particle_ring_blur' ),
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