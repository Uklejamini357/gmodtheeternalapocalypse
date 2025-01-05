SWEP.Base 				= "weapon_tea_base_shotgun"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_rem870tactical.mdl"
SWEP.WorldModel			= "models/weapons/w_remington_870_tact.mdl"
SWEP.HoldType			= "shotgun"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60
SWEP.Shotgun			= true

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A 12 guage pump shotgun that fires extra strength magnum shells"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses shotgun rounds"

SWEP.Primary.Sound 		= Sound("WepRem870.Single")
SWEP.Primary.Recoil		= 6
SWEP.Primary.Damage		= 12.5
SWEP.Primary.NumShots		= 10
SWEP.Primary.Cone			= 0.08
SWEP.Primary.Delay 		= 0.95

SWEP.IronFireAccel		= 1.5

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


SWEP.ShellDelay			= 0.53

SWEP.IronSightsPos = Vector(-2.014, 0.1, 1.2)
SWEP.IronSightsAng = Vector(0.551, 0.028, 0)

SWEP.RunArmOffset = Vector(0, 0, 0)
SWEP.RunArmAngle = Vector(-5.757, 5.672, 0)


/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	if (self.Weapon:GetNWBool("Reloading") or self.ShotgunReloading) then return end

	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ShotgunReloading = true
		self.Weapon:SetNextPrimaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

		timer.Simple(self.ShotgunBeginReload, function()
			self.ShotgunReloading = false
			self.Weapon:SetNetworkedBool("Reloading", true)
			self.Weapon:SetVar("ReloadTime", CurTime() + 1)
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
		end)

		if (SERVER) then
			self.Owner:SetFOV( 0, 0.15 )
			self:SetIronsights(false)
		end
	end
end