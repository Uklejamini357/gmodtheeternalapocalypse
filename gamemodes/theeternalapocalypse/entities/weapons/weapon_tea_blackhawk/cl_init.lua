include('shared.lua')

SWEP.PrintName			= "Black Hawk"			// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 3							// Slot in the weapon selection menu
SWEP.SlotPos			= 1							// Position in the slot

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("materials/weapons/weapon_mad_sg550.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_sg550")
end

local iScreenWidth 	= surface.ScreenWidth()
local iScreenHeight 	= surface.ScreenHeight()

local SCOPEFADE_TIME = 0.4

local alpha = 255

net.Receive( "HitMarkerSnip", function( length, client )
    alpha = 255
 end )

ammoalpha = 0







local AdjustCoefficient = 0.02 -- The bigger this number, the more quickly the nightvision starts up

-- Colormod Settings
local Color_Brightness		= 0.6
local Color_Contrast 		= 1.1
local Color_AddGreen		= -0.35
local Color_MultiplyGreen 	= 0.028


-- Alpha Add Settings (for the CSS nightvision shader)
local AlphaAdd_Alpha 			= 1
local AlphaAdd_Passes			= 1 -- The bigger this integer, the more brightness is added
									-- alpha add = AlphaAdd_Alpha*AlphaAdd_Passes
									
-- Bloom Settings
local Bloom_Multiply		= 1
local Bloom_Darken 			= 0
local Bloom_Blur			= 0.1
local Bloom_ColorMul 		= 0.5
local Bloom_Passes			= 1 -- Should be an integer

-- END ADJUSTABLE SETTINGS

local matNightVision = Material("effects/nightvision") -- CSS nightvision
matNightVision:SetFloat( "$alpha", AlphaAdd_Alpha )


local Color_Tab = 
{
	[ "$pp_colour_addr" ] 		= -1,
	[ "$pp_colour_addg" ] 		= Color_AddGreen,
	[ "$pp_colour_addb" ] 		= -1,
	[ "$pp_colour_brightness" ] = Color_Brightness,
	[ "$pp_colour_contrast" ]	= Color_Contrast,
	[ "$pp_colour_colour" ] 	= 0,
	[ "$pp_colour_mulr" ] 		= 0 ,
	[ "$pp_colour_mulg" ] 		= Color_MultiplyGreen,
	[ "$pp_colour_mulb" ] 		= 0
}

local sndOn = Sound( "items/nvg_on.wav" )
local sndOff = Sound( "items/nvg_off.wav" )

if render.GetDXLevel() < 80 then -- the nightvision shader reverts to  a white overlay for dx7 cards, so any more alpha add than 1 gives a white screen
	AlphaAdd_Passes			= 1
	AlphaAdd_Alpha 			= 0.6 -- Make it less to reduce the whiteness
end

local DoNightVision = false
local CurScale = 0.5

-- A most likely futile attempt to make things faster
local render = render

/*
local function Dlight()
	local dlight = DynamicLight( LocalPlayer() )
		local clr = Color(50,165,50,255)
			if ( dlight ) then
					dlight.Pos = LocalPlayer():GetShootPos()
					dlight.r = clr.r
					dlight.g = clr.g
					dlight.b = clr.b
					dlight.Brightness = 0.8
					dlight.Size = 2500
					dlight.Decay = 128
					dlight.DieTime = CurTime() + 0.1
		end
end
*/

local function NightVisionFX() 

/*

	if CurScale < 0.85 then 
		CurScale = CurScale + AdjustCoefficient * (1 - CurScale)
	end
	
	-- Alpha add			
	for i=1,AlphaAdd_Passes do
	
		render.UpdateScreenEffectTexture()
	 	render.SetMaterial( matNightVision )
	 	render.DrawScreenQuad()
	render.SuppressEngineLighting( true )
		
	end
	
	-- Colormod
	Color_Tab[ "$pp_colour_brightness" ] = CurScale * Color_Brightness
	Color_Tab[ "$pp_colour_contrast" ] = CurScale * Color_Contrast
	
	DrawColorModify( Color_Tab )


	-- Bloom
	DrawBloom(	Bloom_Darken,  					-- Darken
 				CurScale * Bloom_Multiply,		-- Multiply
 				Bloom_Blur, 					-- Horizontal Blur
 				Bloom_Blur, 					-- Vertical Blur
 				Bloom_Passes, 					-- Passes
 				CurScale * Bloom_ColorMul, 		-- Color Multiplier
 				0, 								-- Red
 				1, 								-- Green
 				0 ) 							-- Blue
 */
end

function SWEP:DrawHUD()

	self:SecondDrawHUD()
	self:DrawFuelHUD()

	if (self.Sniper) then

		local bScope = self.Weapon:GetDTBool(2)

		if bScope ~= self.bLastScope then // Are we turning the scope off/on?
			self.bLastScope = bScope
			self.fScopeTime = CurTime()
		elseif bScope then
			local fScopeZoom = self.Weapon:GetNetworkedFloat("ScopeZoom")

			if fScopeZoom ~= self.fLastScopeZoom then // Are we changing the scope zoom level?
		
				self.fLastScopeZoom = fScopeZoom
				self.fScopeTime = CurTime()
			end
		end
			
		local fScopeTime = self.fScopeTime or 0

		if fScopeTime > CurTime() - SCOPEFADE_TIME then
		
			local Mul = 1.0 -- This scales the alpha
			Mul = 1 - math.Clamp((CurTime() - fScopeTime) / SCOPEFADE_TIME, 0, 1)
		
			surface.SetDrawColor(0, 0, 0, 255 * Mul) // Draw a black rect over everything and scale the alpha for a neat fadein effect
			surface.DrawRect(0, 0, iScreenWidth,iScreenHeight)
		end

		if (bScope) then 
		zw_huddraw = 0
		NightVisionFX() 
--		Dlight()

	surface.SetDrawColor(150, 255, 150, 255)
		surface.DrawRect((ScrW() / 2) - 1, (ScrH() / 2) - 1, 3, 3)
		surface.DrawRect((ScrW() / 2) - 200, (ScrH() / 2) - 100, 2, 200)
		surface.DrawRect((ScrW() / 2) + 200, (ScrH() / 2) - 100, 2, 200)
		local trace = LocalPlayer():GetEyeTrace()
		local dist = math.floor((LocalPlayer():GetPos():Distance(trace.HitPos)) * 0.02)
		if !trace.HitSky then
		draw.SimpleText( "Rng: "..tostring(dist).."m", "TargetIDSmall", (ScrW() / 2 - 190), (ScrH() / 2 + 100), Color(150, 255, 150, 255) )
		end
		draw.SimpleText( "Mag: "..self:Clip1(), "TargetIDSmall", (ScrW() / 2 - 190), (ScrH() / 2 - 120), Color(150, 255, 150, 255) )
		draw.SimpleText( "Zoom: 5x", "TargetIDSmall", (ScrW() / 2 + 135), (ScrH() / 2 + 100), Color(150, 255, 150, 255) )
		draw.SimpleText( "Bri: 500lu", "TargetIDSmall", (ScrW() / 2 + 130), (ScrH() / 2 - 120), Color(150, 255, 150, 255) )
	/*
			// Draw the crosshair
			if not (self.RedDot) then
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawLine(self.CrossHairTable.x11, self.CrossHairTable.y11, self.CrossHairTable.x12, self.CrossHairTable.y12)
				surface.DrawLine(self.CrossHairTable.x21, self.CrossHairTable.y21, self.CrossHairTable.x22, self.CrossHairTable.y22)
			end

			// Put the texture
			surface.SetDrawColor(0, 0, 0, 255)

			if (self.RedDot) then
				surface.SetTexture(surface.GetTextureID("scope/scope_reddot"))
			else
				surface.SetTexture(surface.GetTextureID("scope/scope_normal"))
			end

			surface.DrawTexturedRect(self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h)

			// Fill in everything else
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(self.QuadTable.x1 - 2.5, self.QuadTable.y1 - 2.5, self.QuadTable.w1 + 5, self.QuadTable.h1 + 5)
			surface.DrawRect(self.QuadTable.x2 - 2.5, self.QuadTable.y2 - 2.5, self.QuadTable.w2 + 5, self.QuadTable.h2 + 5)
			surface.DrawRect(self.QuadTable.x3 - 2.5, self.QuadTable.y3 - 2.5, self.QuadTable.w3 + 5, self.QuadTable.h3 + 5)
			surface.DrawRect(self.QuadTable.x4 - 2.5, self.QuadTable.y4 - 2.5, self.QuadTable.w4 + 5, self.QuadTable.h4 + 5)
		*/
		else
		zw_huddraw = 1
		end
	end

	if (self.Weapon:GetDTBool(1) and not self.Weapon:GetNetworkedBool("Suppressor")) or (cl_crosshair_t:GetBool() == false) or (LocalPlayer():InVehicle()) then return end
	
	local hitpos = util.TraceLine ({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 4096,
		filter = LocalPlayer(),
		mask = MASK_SHOT
	}).HitPos

	local screenpos = hitpos:ToScreen()
	
	local x = screenpos.x
	local y = screenpos.y
	local ply = LocalPlayer()
	local ammo1 = self:Clip1()
	local ammo2 = self.Owner:GetAmmoCount(self.Primary.Ammo)
	local weapon = ply:GetActiveWeapon()
	local vmodel = ply:GetViewModel()
	local hudpos = vmodel:GetAttachment("1")
	pos2 = hudpos.Pos
	local screenpos2 = pos2:ToScreen()
	local x2 = screenpos2.x
	local y2 = screenpos2.y
	
	local gap = ((self.Primary.Cone * 275) + (((self.Primary.Cone * 275) * (ScrH() / 720))) * (1 / self:CrosshairAccuracy())) * 2
	local gap2 = math.Clamp(gap, 0, (ScrH() / 2) - 100)
	local length = cl_crosshair_l:GetInt()

	if self.IronCrosshair or !self.Weapon:GetDTBool(1) then
	/*
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(x-1, y-1, 2, 2)
	surface.DrawRect(x-1, y + gap, 2, 20)
	surface.DrawRect(x-1, y - (gap + 20), 2, 20)
	surface.DrawRect(x + gap, y-1, 20, 2)
	surface.DrawRect(x - (gap + 20), y-1, 20, 2)
	*/

	if self.Owner:KeyDown(IN_RELOAD) or self.Owner:KeyDown(IN_ATTACK) then
		ammoalpha = 230
	else
		if ammoalpha > 0 then
		ammoalpha = ammoalpha - 1
	end
	end

	surface.SetTextColor(0, 0, 0, ammoalpha)
	surface.SetTextPos(x2 - 72, y2 + 32)
	surface.SetFont("DermaLarge")
	surface.DrawText(ammo1.."/"..ammo2)
	surface.SetTextColor(255, 255, 255, ammoalpha)
	surface.SetTextPos(x2 - 70, y2 + 30)
	surface.SetFont("DermaLarge")
	surface.DrawText(ammo1.."/"..ammo2)


	if !LocalPlayer():Alive() then alpha = 0 return end
	
	alpha = math.Approach( alpha, 0, 3 )
	
	local screen = Vector(ScrW() / 2, ScrH() / 2)
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.DrawLine( x - 20, y - 20, x - 5, y - 5 )
	surface.DrawLine( x - 20, y + 20, x - 5, y + 5 )
	surface.DrawLine( x + 20, y - 20, x + 5, y - 5 )
	surface.DrawLine( x + 20, y + 20, x + 5, y + 5 )
	end
end

/*---------------------------------------------------------
   Name: SWEP:TranslateFOV()
---------------------------------------------------------*/
local IRONSIGHT_TIME = 0.2

function SWEP:TranslateFOV(current_fov)

	local fScopeZoom = self.Weapon:GetNetworkedFloat("ScopeZoom")

	if self.Weapon:GetDTBool(2) then return current_fov / fScopeZoom end
	
	local bIron = self.Weapon:GetDTBool(1)

	if bIron ~= self.bLastIron then // Do the same thing as in CalcViewModel. I don't know why this works, but it does.
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
	end
	
	local fIronTime = self.fIronTime or 0

	if not bIron and (fIronTime < CurTime() - IRONSIGHT_TIME) then 
		return current_fov
	end
	
	local Mul = 1.0 // More interpolating shit
	
	if fIronTime > CurTime() - IRONSIGHT_TIME then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		if not bIron then Mul = 1 - Mul end
	end

	current_fov = current_fov*(1 + Mul/self.IronSightZoom - Mul)

	return current_fov
end

/*---------------------------------------------------------
   Name: SWEP:GetTracerOrigin()
   Desc: Allows you to override where the tracer comes from (in first person view)
	   returning anything but a vector indicates that you want the default action.
---------------------------------------------------------*/
function SWEP:GetTracerOrigin()

	if (self.Weapon:GetDTBool(1)) then
		local pos = self:GetOwner():EyePos() + self:GetOwner():EyeAngles():Up() * -5
		return pos
	end
end

/*---------------------------------------------------------
   Name: SniperCreateMove()
---------------------------------------------------------*/
local staggerdir = VectorRand():GetNormalized()

local function SniperCreateMove(cmd)
	
	
	if (LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetDTBool(2)) then
		local ang = cmd:GetViewAngles()

		local ft = FrameTime()

		
		if LocalPlayer():GetActiveWeapon():GetDTBool(3) then 
			ang.pitch = math.NormalizeAngle(ang.pitch + staggerdir.z * ft * 0.2)
			ang.yaw = math.NormalizeAngle(ang.yaw + staggerdir.x * ft * 0.2)
			staggerdir = (staggerdir + ft * 100 * VectorRand()):GetNormalized()
		elseif LocalPlayer():Crouching() then 
			ang.pitch = math.NormalizeAngle(ang.pitch + staggerdir.z * ft * 0.4)
			ang.yaw = math.NormalizeAngle(ang.yaw + staggerdir.x * ft * 0.4)
			staggerdir = (staggerdir + ft * 100 * VectorRand()):GetNormalized()
		elseif LocalPlayer():GetVelocity():Length() > 50 then
			ang.pitch = math.NormalizeAngle(ang.pitch + staggerdir.z * ft * 5)
			ang.yaw = math.NormalizeAngle(ang.yaw + staggerdir.x * ft * 5)
			staggerdir = (staggerdir + ft * 100 * VectorRand()):GetNormalized()
		else
			ang.pitch = math.NormalizeAngle(ang.pitch + staggerdir.z * ft * 1)
			ang.yaw = math.NormalizeAngle(ang.yaw + staggerdir.x * ft * 1)
			staggerdir = (staggerdir + ft * 1 * VectorRand()):GetNormalized()
		end
		
		
		cmd:SetViewAngles(ang)		
	end
	
end
hook.Add ("CreateMove", "SniperCreateMove", SniperCreateMove)
