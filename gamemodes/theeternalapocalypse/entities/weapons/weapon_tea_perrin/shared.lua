SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_bizon19.mdl"
SWEP.WorldModel			= "models/weapons/w_pp19_bizon.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A russian weapon designed to put assualt rifle levels of firepower in the hands of tankers and support crews"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses pistol rounds"

SWEP.Primary.Sound 		= Sound("Weapon_P19.Single")
SWEP.Primary.Recoil		= 0.4
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.016
SWEP.Primary.Delay 		= 0.075

SWEP.IronFireAccel		= 3

SWEP.Primary.ClipSize		= 64
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

SWEP.IronSightsPos = Vector(3.359, 0, 0.839)
SWEP.IronSightsAng = Vector(0.744, -0.588, 0)

SWEP.RunArmOffset = Vector(-0.382, -0.247, 0.344)

SWEP.RunArmAngle = Vector(-8.799, -9.952, 0)

function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5navy/mp5-1.wav")
end