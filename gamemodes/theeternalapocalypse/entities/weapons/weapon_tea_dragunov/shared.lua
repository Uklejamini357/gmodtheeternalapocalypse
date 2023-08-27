SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_dragunov02.mdl"
SWEP.WorldModel			= "models/weapons/w_svd_dragunov.mdl"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 70
SWEP.SwayScale = 0.1

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Purpose			= "The russians found this old sniper rifle to be particularly effective at popping off zombies, now you will too"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses sniper rounds"

SWEP.Primary.Sound 		= Sound("Weapon_svd01.Single")
SWEP.Primary.Recoil		= 3.5
SWEP.Primary.Damage		= 87
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0012
SWEP.Primary.Delay 		= 0.28

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "ammo_sniper"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.IronFireAccel		= 1

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.53

SWEP.HipFireLoss = 1

SWEP.IronSightsPos = Vector(-3.161, -2.938, 0.119)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.RunArmOffset = Vector(1.662, 0.023, -0.375)

SWEP.RunArmAngle = Vector(-8.436, 17.437, 0)

SWEP.ScopeZooms			= {6}

SWEP.BoltActionSniper		= false

function SWEP:Precache()

    	util.PrecacheSound("weapons/m14/m14-1.wav")
end