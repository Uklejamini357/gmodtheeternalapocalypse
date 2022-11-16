// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mac10.mdl"
SWEP.UseHands			= true

SWEP.HoldType				= "pistol"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "An old machine pistol, makes for a decent close quarters weapon but performs poorly at longer ranges"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses SMG rounds"

SWEP.Primary.Sound 		= Sound("Weapon_MAC10.Single")
SWEP.Primary.Recoil		= 0.4
SWEP.Primary.Damage		= 10.5
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Delay 		= 0.06

SWEP.IronFireAccel		= 5

SWEP.Primary.ClipSize		= 35					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-9.073, -8.353, 2.865)
SWEP.IronSightsAng = Vector(0.772, -5.442, -7.159)
SWEP.RunArmOffset = Vector(0, 0, 0.865)

SWEP.RunArmAngle = Vector(-15.157, 12.953, -6.89)

SWEP.ZWweight				= 45 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/mac10/mac10-1.wav")
end