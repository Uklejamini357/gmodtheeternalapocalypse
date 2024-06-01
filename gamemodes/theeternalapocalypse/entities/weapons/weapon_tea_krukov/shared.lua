SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A simple but incredibly effective russian assault rifle"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0085
SWEP.Primary.Delay 		= 0.11

SWEP.IronFireAccel = 8

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
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




SWEP.IronSightsPos = Vector(-6.507, -14.591, 2.483)
SWEP.IronSightsAng = Vector(2.819, 0.2, 0)
SWEP.RunArmOffset = Vector(12.119, 0, -1.68)
SWEP.RunArmAngle = Vector(-7.6, 27.399, 0)
SWEP.NearWallPos = Vector (-1.0416, -11.4198, -2.2259)
SWEP.NearWallAng = Vector (40.6435, -56.4456, -17.6906)

function SWEP:Precache()

    	util.PrecacheSound("weapons/ak47/ak47-1.wav")
end