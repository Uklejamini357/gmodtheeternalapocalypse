SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_awp.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true

SWEP.Primary.Sound 		= Sound("Weapon_AWP.Single")
SWEP.Primary.Recoil		= 8
SWEP.Primary.Damage		= 112
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0001
SWEP.Primary.Delay 		= 1.55

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "ammo_sniper"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.6

SWEP.IronSightsPos = Vector(-7.2, -11.733, 1.84)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(9.527, 0, 0)

SWEP.RunArmAngle = Vector(-9.094, 22.874, 0)
SWEP.ScopeZooms			= {12}

SWEP.BoltActionSniper		= true

function SWEP:Precache()

    	util.PrecacheSound("weapons/awp/awp1.wav")
end