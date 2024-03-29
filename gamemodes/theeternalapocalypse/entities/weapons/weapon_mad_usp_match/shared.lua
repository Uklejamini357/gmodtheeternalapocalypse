SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.UseHands			= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_Pistol.Single")
SWEP.Primary.Reload 		= Sound("Weapon_Pistol.Reload")
SWEP.Primary.Recoil		= 0.75
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.01
SWEP.Primary.Delay 		= 0.1

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Battery"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-5.761, -8.898, 3.119)
SWEP.IronSightsAng = Vector(0.275, -1, 0)
SWEP.RunArmOffset 		= Vector (0.041, 0, 5.6778)
SWEP.RunArmAngle 			= Vector (-17.6901, 0.321, 0)

function SWEP:Precache()

    	util.PrecacheSound("weapons/pistol/pistol_fire2.wav")
    	util.PrecacheSound("weapons/pistol/pistol_reload1.wav")
end

function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self.Weapon:DefaultReload(ACT_VM_RELOAD) 

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ActionDelay = CurTime() + 1
		self.Owner:SetFOV(0, 0.15)
		self:SetIronsights(false)
		self.Weapon:EmitSound(self.Primary.Reload)
		self:IdleAnimation(1)
	end
end