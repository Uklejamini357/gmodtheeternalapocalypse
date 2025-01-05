SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_aw50_awp.mdl"
SWEP.WorldModel			= "models/weapons/w_acc_int_aw50.mdl"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"

SWEP.Purpose			= "Boom"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses sniper rounds"

SWEP.Primary.Sound 		= Sound("Weaponaw50.Single")
SWEP.Primary.Recoil		= 6
SWEP.Primary.Damage		= 145
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 1.6

SWEP.Primary.ClipSize		= 5
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

SWEP.IronSightsPos = Vector(3.64, -2.984, 1.039)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(0, 1.547, 0)
SWEP.RunArmAngle = Vector(-9.568, -8.641, 0)

SWEP.ScopeZooms			= {8}

SWEP.BoltActionSniper		= true

function SWEP:Precache()

    	util.PrecacheSound("weapons/awm/awm1.wav")
end