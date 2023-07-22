SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"
SWEP.UseHands			= true
SWEP.PrintName			= "M4A7 7.62" --"7.62 M4A1"	
SWEP.Purpose			= "This weapon uses 7.62 caliber and deals higher damage than it's normal one."

SWEP.Primary.Sound 		= Sound("Weapon_AK47.Single")
SWEP.Primary.SuppressorSound 	= Sound("Weapon_M4A1.Silenced")
SWEP.Primary.NoSuppressorSound= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil		= 0.8
SWEP.Primary.Damage		= 34
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.022
SWEP.Primary.Delay 		= 0.13

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_762"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-7.72, -6.064, 0.72)
SWEP.IronSightsAng = Vector(2, -1.3, -3.031)
SWEP.RunArmOffset = Vector(3.385, 0, 0)

SWEP.RunArmAngle = Vector(-14.606, 20.118, -4.134)

SWEP.Type				= 2
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= ""
SWEP.data.ModeMsg			= ""
SWEP.data.Delay			= 2
SWEP.data.Cone			= 1.5
SWEP.data.Damage			= 0.75
SWEP.data.Recoil			= 0.5
function SWEP:Precache()

    	util.PrecacheSound("weapons/ak47/ak47-1.wav")
end