// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_rif_tavor.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_tavor.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "An advanced assault rifle chambered in an experimental 8x46mm bullet"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("weapons/dmg_vikhr/galil-1.wav")
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.009
SWEP.Primary.Delay 		= 0.15

SWEP.IronFireAccel = 8

SWEP.Primary.ClipSize		= 20					// Size of a clip
SWEP.Primary.DefaultClip	= 0			// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
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

SWEP.IronSightsPos = Vector(-3.454, -3.727, 0.976)
SWEP.IronSightsAng = Vector(-0.348, 0, 0)
SWEP.RunArmOffset = Vector(2.303, 0.119, 0.395)
SWEP.RunArmAngle = Vector(-9.398, 20.02, 0)
SWEP.NearWallPos = Vector (-1.0416, -11.4198, -2.2259)
SWEP.NearWallAng = Vector (40.6435, -56.4456, -17.6906)

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/xamas/xamas-1.wav")
end