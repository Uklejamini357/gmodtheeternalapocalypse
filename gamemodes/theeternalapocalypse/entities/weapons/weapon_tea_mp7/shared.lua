SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"
SWEP.UseHands			= true

SWEP.Primary.Sound 		= Sound("Weapon_SMG1.Single")
SWEP.Primary.Reload 		= Sound("Weapon_SMG1.Reload")
SWEP.Primary.Recoil		= 0.75
SWEP.Primary.Damage		= 12
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.013
SWEP.Primary.Delay 		= 0.075

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Gravity"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"	-- "none" or "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (-6.39, -3.32, 1.05)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (9.071, 0, 1.6418)
SWEP.RunArmAngle 			= Vector (-12.9765, 26.8708, 0)

function SWEP:Precache()
    util.PrecacheSound("weapons/smg1/smg1_fire1.wav")
    util.PrecacheSound("weapons/smg1/smg1_reload.wav")
end

function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self.Weapon:DefaultReload(ACT_VM_RELOAD) 

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.Owner:SetFOV( 0, 0.15 )
		self:SetIronsights(false)
		self.Weapon:EmitSound(self.Primary.Reload)
	end
end