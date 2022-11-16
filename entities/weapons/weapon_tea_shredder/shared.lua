// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_p90.mdl"
SWEP.HoldType				= "ar2"
SWEP.UseHands			= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.HasCrosshair = true


SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "An experimental SMG that fires a hail of small high velocity bullets"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses SMG rounds"


SWEP.Primary.Sound 		= Sound("Weapon_P90.Single")
SWEP.Primary.Recoil		= 0.3
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.015
SWEP.Primary.Delay 		= 0.066

SWEP.Primary.ClipSize		= 50					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos = Vector(-5.72, -12.521, 2.24)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(7.953, 0, -1.181)

SWEP.RunArmAngle = Vector(-1.93, 33.897, 0)

SWEP.ScopeZooms			= {2}
SWEP.RedDot				= true

SWEP.ZWweight				= 70 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Rare" -- Junk, Common, Uncommon, Rare, Epic

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/p90/p90-1.wav")
end