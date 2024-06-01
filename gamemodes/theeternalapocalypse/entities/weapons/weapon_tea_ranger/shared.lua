SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"
SWEP.UseHands			= true

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_M4A1.Single")
SWEP.Primary.SuppressorSound 	= Sound("Weapon_M4A1.Silenced")
SWEP.Primary.NoSuppressorSound= Sound("Weapon_M4A1.Single")
SWEP.Primary.Recoil		= 0.6
SWEP.Primary.Damage		= 26
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.015
SWEP.Primary.Delay 		= 0.09

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "An iconic american rifle that has been kept up to modern standards via constant upgrades"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-7.72, -6.064, 0.72)
SWEP.IronSightsAng = Vector(2, -1.3, -3.031)
SWEP.RunArmOffset = Vector(3.385, 0, 0)

SWEP.RunArmAngle = Vector(-14.606, 20.118, -4.134)

SWEP.Type				= 2
SWEP.Mode				= true




SWEP.data 				= {}
SWEP.data.NormalMsg		= ""
SWEP.data.ModeMsg			= ""
SWEP.data.Delay			= 2
SWEP.data.Cone			= 1.5
SWEP.data.Damage			= 0.9
SWEP.data.Recoil			= 0.5

function SWEP:Precache()

    	util.PrecacheSound("weapons/m4a1/m4a1-1.wav")
end

