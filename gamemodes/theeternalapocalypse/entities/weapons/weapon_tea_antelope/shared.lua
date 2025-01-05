SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_scout.mdl"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 50

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_SCOUT.Single")
SWEP.Primary.Recoil		= 3
SWEP.Primary.Damage		= 74
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.001
SWEP.Primary.Delay 		= 1.2

SWEP.Primary.ClipSize		= 6
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
SWEP.HeadshotDamageMulti = 2.5

SWEP.IronSightsPos = Vector(-6.68, -14.094, 2.369)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(7.164, 0, 0)

SWEP.RunArmAngle = Vector(-10.197, 22.322, 0)

SWEP.ScopeZooms			= {8}

SWEP.BoltActionSniper		= true

function SWEP:Precache()

    	util.PrecacheSound("weapons/scout/scout_fire-1.wav")
end