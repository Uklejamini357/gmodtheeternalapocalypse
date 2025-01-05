SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.UseHands			= true

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_M249.Single")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 24
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.Delay 		= 0.1

SWEP.IronFireAccel = 5

SWEP.Primary.ClipSize		= 100
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

SWEP.IronSightsPos = Vector(-5.947, -4.067, 2.338)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset 		= Vector (2.2344, -2.2257, 1.7539)
SWEP.RunArmAngle 			= Vector (-19.3086, 29.9962, 0)

function SWEP:Precache()

    	util.PrecacheSound("weapons/m249/m249-1.wav")
end