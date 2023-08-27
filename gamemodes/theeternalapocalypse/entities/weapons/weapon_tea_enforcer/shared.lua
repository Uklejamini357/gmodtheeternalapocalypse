SWEP.Base 				= "weapon_tea_base_shotgun"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_m3super90.mdl"
SWEP.HoldType			= "shotgun"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 54
SWEP.Shotgun			= true

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A 12 guage pump shotgun that was commonly used by police and sport shooters before the apocalpyse"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses shotgun rounds"

SWEP.Primary.Sound 		= Sound("Weapon_M3.Single")
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 13
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Delay 		= 0.95

SWEP.IronFireAccel		= 1.25

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


SWEP.ShellDelay			= 0.53

SWEP.IronSightsPos = Vector(-7.64, -8.898, 3.559)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(11.26, 0, 0)

SWEP.RunArmAngle = Vector(-7.441, 36.102, 0)

SWEP.ZWweight				= 85 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/m3/m3-1.wav")
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