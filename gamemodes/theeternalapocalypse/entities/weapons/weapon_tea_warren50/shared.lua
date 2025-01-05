SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.IronFireAccel		= 3

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A powerful and flashy pistol that fires heavy magnum rounds, warrens are still in high demand despite their high skill requirement to use effectively"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses magnum rounds"

SWEP.Primary.Sound 		= Sound("Weapon_Deagle.Single")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 52
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.015
SWEP.Primary.Delay 		= 0.3

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.05

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-6.361, -10.787, 2.16)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(0, 0, 6.377)

SWEP.RunArmAngle = Vector(-26.181, 0, 0)



function SWEP:Precache()

    	util.PrecacheSound("weapons/deagle/deagle-1.wav")
end