SWEP.Base 				= "weapon_tea_base_shotgun"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_xm1014.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A military grade 12 guage shotgun with a semi auto trigger"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses shotgun rounds"

SWEP.Primary.Sound 		= Sound("Weapon_XM1014.Single")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 11
SWEP.Primary.NumShots		= 9
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Delay 		= 0.3

SWEP.IronFireAccel		= 1

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellDelay			= 0.1

SWEP.IronSightsPos = Vector(-6.921, -6.064, 2.68)
SWEP.IronSightsAng = Vector(0, -0.851, 0)
SWEP.RunArmOffset = Vector(7.322, 0, 0)

SWEP.RunArmAngle = Vector(-7.993, 28.385, 0)
SWEP.ShotgunReloading		= true
SWEP.ShotgunFinish		= 0.3
SWEP.ShotgunBeginReload		= 0.5




function SWEP:Precache()

    	util.PrecacheSound("weapons/xm1014/xm1014-1.wav")
end

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
