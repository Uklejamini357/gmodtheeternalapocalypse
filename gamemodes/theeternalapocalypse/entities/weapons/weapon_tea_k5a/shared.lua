SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mp5.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 54

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "This old german SMG may be an outdated design but it still packs a punch on the battlefield "
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.Sound 		= Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil		= 0.4
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.014
SWEP.Primary.Delay 		= 0.075

SWEP.IronFireAccel		= 5

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

SWEP.IronSightsPos = Vector(-5.334, -8.237, 1.958)
SWEP.IronSightsAng = Vector(1.317, 0, 0)
SWEP.RunArmOffset = Vector(5.748, -1.025, -0.866)

SWEP.RunArmAngle = Vector(-5.788, 32.243, 0)




function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5navy/mp5-1.wav")
end