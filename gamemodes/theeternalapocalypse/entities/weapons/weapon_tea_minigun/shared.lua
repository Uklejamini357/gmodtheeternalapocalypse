SWEP.Base				= "weapon_mad_base"

SWEP.ViewModel			= "models/weapons/v_minigunvulcan.mdl"
SWEP.WorldModel			= "models/weapons/w_m134_minigun.mdl"
SWEP.UseHands			= true

SWEP.HoldType			= "crossbow"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.Instructions		= ""
SWEP.Purpose			= "An enormous minigun that spews a constant stream of hot lead. Uses Rifle ammo."

SWEP.Primary.Sound		= Sound("Weapon_M249.Single")
SWEP.Primary.Recoil		= 0.55
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone			= 0.053
SWEP.Primary.Delay		= 0.055

SWEP.IronFireAccel	= 5

SWEP.Primary.ClipSize		= 250
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect	= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol			= false
SWEP.Rifle			= true
SWEP.Shotgun		= false
SWEP.Sniper			= false

SWEP.IronSightsPos	= Vector(0, 0, 0)
SWEP.IronSightsAng	= Vector(0, 0, 0)
SWEP.RunArmOffset 	= Vector(0, -6.356, -4.719)
SWEP.RunArmAngle 	= Vector(15.284, 0, 0)


function SWEP:Precache()

    	util.PrecacheSound("weapons/m249/m249-1.wav")
end

function SWEP:SecondaryAttack()
return false
end


function SWEP:PrimaryAttack()

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end

	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	// If the burst mode is activated, it's going to shoot the three bullets (or more if you're dumb and put 4 or 5 bullets for your burst mode)
	if self.Weapon:GetDTBool(3) and self.Type == 3 then
		self.BurstTimer 	= CurTime()
		self.BurstCounter = self.BurstShots - 1
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	end

	self.Weapon:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
end