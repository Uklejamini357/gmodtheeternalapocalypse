include('shared.lua')

SWEP.PrintName			= "Crowbar"						// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 1							// Slot in the weapon selection menu
SWEP.SlotPos			= 1							// Position in the slot

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("materials/weapons/weapon_mad_crowbar.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_crowbar")
end

function SWEP:DrawHUD()
	self:SecondDrawHUD()
	self:DrawFuelHUD()

	local hitpos = util.TraceLine ({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 4096,
		filter = LocalPlayer(),
		mask = MASK_SHOT
	}).HitPos

	local screenpos = hitpos:ToScreen()
	
	local x = screenpos.x
	local y = screenpos.y
	local gap = ((self.Primary.Cone * 275) + (((self.Primary.Cone * 275) * (ScrH() / 720))) * (1 / self:CrosshairAccuracy())) * 0.5
	gap = math.Clamp(gap, 5, (ScrH() / 2) - 100)

	local ply = LocalPlayer()
	local ammo1 = self:Clip1()
	local ammo2 = self.Owner:GetAmmoCount(self.Primary.Ammo)
	local weapon = ply:GetActiveWeapon()
	local vmodel = ply:GetViewModel()
	local hudpos = vmodel:GetAttachment("1")

	if self.Owner:KeyDown(IN_RELOAD) or self.Owner:KeyDown(IN_ATTACK) then
		ammoalpha = 230
	else
		if ammoalpha > 0 then
			ammoalpha = ammoalpha - 1
		end
	end

	if not (cl_crosshair_t:GetBool() == false) or (LocalPlayer():InVehicle()) then
		if self.IronCrosshair or !self.Weapon:GetDTBool(1) then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawRect(x-1, y-1, 2, 2)
			surface.DrawRect(x-1, y + gap, 2, 20)
			surface.DrawRect(x-1, y - (gap + 20), 2, 20)
			surface.DrawRect(x + gap, y-1, 20, 2)
			surface.DrawRect(x - (gap + 20), y-1, 20, 2)
		end
--		surface.DrawCircle( x, y, gap, Color(200, 200, 250, 255) )
--		surface.DrawCircle( x, y, gap - 2, Color(50, 50, 50, 255) )

	end
end
