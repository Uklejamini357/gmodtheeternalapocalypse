SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_rif_xamas.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_xamas.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A modern tactical carbine that is designed with urban combat in mind"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("weapons/xamas/xamas-1.wav")
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 29
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.018
SWEP.Primary.Delay 		= 0.085

SWEP.IronFireAccel = 8

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0			// Default number of bullets in a clip
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

SWEP.IronSightsPos = Vector(-3.082, -5.065, 1.11)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(12.119, 0, -1.68)
SWEP.RunArmAngle = Vector(-7.6, 27.399, 0)
SWEP.NearWallPos = Vector (-1.0416, -11.4198, -2.2259)
SWEP.NearWallAng = Vector (40.6435, -56.4456, -17.6906)

function SWEP:Precache()

    	util.PrecacheSound("weapons/xamas/xamas-1.wav")
end