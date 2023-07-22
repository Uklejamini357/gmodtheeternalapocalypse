SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_mp40smg.mdl"
SWEP.WorldModel			= "models/weapons/w_mp40smg.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "An antique SMG that fires an unnecessarily large caliber bullet."
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.Sound 		= Sound("mp40.Single")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 26
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.018
SWEP.Primary.Delay 		= 0.1

SWEP.IronFireAccel		= 2

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(3.881, 0.187, 1.626)
SWEP.IronSightsAng = Vector(-0.047, 0, 0)
SWEP.RunArmOffset = Vector(0, 0, 0)
SWEP.RunArmAngle = Vector(-9.389, -6.778, 0)

SWEP.ZWweight				= 60 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5navy/mp5-1.wav")
end