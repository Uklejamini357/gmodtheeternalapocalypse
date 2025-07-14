SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_sg550.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "ar2"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_SG550.Single")
SWEP.Primary.Recoil		= 2.5
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.00075
SWEP.Primary.Delay 		= 0.15

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_556x45"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos = Vector(-7.441, -12.363, 1.48)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(8.267, 0, 0)

SWEP.RunArmAngle = Vector(-14.056, 28.385, 0)
SWEP.ScopeZooms			= {6}

function SWEP:Precache()

    	util.PrecacheSound("weapons/sg550/sg550-1.wav")
end