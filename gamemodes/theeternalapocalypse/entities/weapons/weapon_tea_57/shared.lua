// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A fast firing pistol that spews a hail of small high velocity bullets"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses pistol rounds"

SWEP.Primary.Sound 		= Sound("Weapon_FiveSeven.Single")
SWEP.Primary.Recoil		= 0.6
SWEP.Primary.Damage		= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.012
SWEP.Primary.Delay 		= 0.12

SWEP.Primary.ClipSize		= 20					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.05

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-5.949, -0.922, 3.104)
SWEP.IronSightsAng = Vector(-0.597, 0, 0)

SWEP.ZWweight				= 20 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/fiveseven/fiveseven-1.wav")
end