include('shared.lua')

SWEP.PrintName			= "Molotov Cocktail"			// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 4							// Slot in the weapon selection menu
SWEP.SlotPos			= 1							// Position in the slot

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

	local ply = LocalPlayer()
	local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
	local weapon = ply:GetActiveWeapon()
	local vmodel = ply:GetViewModel()
	local gren = vmodel:LookupBone( "v_weapon.FlashBang_Parent" )
	local hudpos = vmodel:GetBonePosition( gren )

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
	surface.DrawRect(x-30, y-1, 20, 2)
	surface.DrawRect(x+10, y-1, 20, 2)
	end


	if hudpos then 
	local screenpos2 = hudpos:ToScreen()
	local x2 = screenpos2.x
	local y2 = screenpos2.y
	surface.SetTextColor(0, 0, 0, ammoalpha)
	surface.SetTextPos(x2 - 22, y2 + 32)
	surface.SetFont("DermaLarge")
	surface.DrawText(ammo)
	surface.SetTextColor(255, 255, 255, ammoalpha)
	surface.SetTextPos(x2 - 20, y2 + 30)
	surface.SetFont("DermaLarge")
	surface.DrawText(ammo)
end
end
end