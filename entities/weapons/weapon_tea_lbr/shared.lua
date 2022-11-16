// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_snip_m14sp.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_m14sp.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A powerful semi-auto battle rifle that is a rebuilt version of an old and popular design"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("Weapon_M14SP.Single")
SWEP.Primary.Recoil		= 1.1
SWEP.Primary.Damage		= 52
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.006
SWEP.Primary.Delay 		= 0.1

SWEP.IronFireAccel = 8

SWEP.Primary.ClipSize		= 14					// Size of a clip
SWEP.Primary.DefaultClip	= 0			// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.7031, -1.0539, 1.6562)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunArmOffset = Vector(2.303, 0.119, 0.395)
SWEP.RunArmAngle = Vector(-9.398, 20.02, 0)


/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/