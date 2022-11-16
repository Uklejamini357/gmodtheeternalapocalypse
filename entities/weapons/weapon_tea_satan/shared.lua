// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModel			= "models/weapons/v_pist_satan2.mdl"
SWEP.WorldModel			= "models/weapons/w_m29_satan.mdl"
SWEP.HoldType			= "revolver"
SWEP.UseHands			= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "This thing is fucking huge, i hope i can fire it without my hand breaking off!"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses magnum rounds"
SWEP.ViewModelFOV		= 55

SWEP.Primary.Sound 		= Sound("Weapon_satan1.single")
SWEP.Primary.Recoil		= 8
SWEP.Primary.Damage		= 90
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.012
SWEP.Primary.Delay 		= 0.85

SWEP.Primary.ClipSize		= 6					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronFireAccel		= 1

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-2.872, -2.722, 0.472)
SWEP.IronSightsAng = Vector(0.307, 2.448, 0)
SWEP.RunArmOffset 		= Vector(0, 0, 0)
SWEP.RunArmAngle 			= Vector(-13.285, 0, 0)
