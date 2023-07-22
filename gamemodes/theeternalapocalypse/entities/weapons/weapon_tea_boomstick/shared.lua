// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base_shotgun"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_doublebarrl.mdl"
SWEP.WorldModel			= "models/weapons/w_double_barrel_shotgun.mdl"
SWEP.HoldType			= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 55
SWEP.Shotgun			= true

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "You can't beat a good old fashioned boomstick!"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses shotgun rounds"

SWEP.Primary.Sound 		= Sound("Double_Barrel.Single")
SWEP.Primary.Recoil		= 6
SWEP.Primary.Damage		= 12
SWEP.Primary.NumShots		= 9
SWEP.Primary.Cone			= 0.035
SWEP.Primary.Delay 		= 0.3

SWEP.IronFireAccel		= 1.25
SWEP.IronCrosshair = true

SWEP.Primary.ClipSize		= 2					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"


SWEP.ShellDelay			= 0.53

SWEP.IronSightsPos = Vector(-2.8, 0, 1.24)
SWEP.IronSightsAng = Vector(0.065, 0, 0)

SWEP.RunArmOffset = Vector(3.47, 0.18, 0.381)

SWEP.RunArmAngle = Vector(-9.903, 19.238, 0)

SWEP.ZWweight				= 85 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    util.PrecacheSound("weapons/spas/spas-1.wav")
end


/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	// When the weapon is already doing an animation, just return end because we don't want to interrupt it
	if (self.ActionDelay > CurTime()) then return end 

	// Need to call the default reload before the real reload animation
	self.Weapon:DefaultReload(ACT_VM_RELOAD)

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:SetIronsights(false)
		self:ReloadAnimation()
	end


end

function SWEP:ReloadAnimation()

	// Reload with the suppressor animation if you're suppressor is on the FUCKING gun
	if self.Weapon:GetDTBool(3) and self.Type == 2 then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED)
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.9)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1.9)
	timer.Simple(1, function()
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	end )
end