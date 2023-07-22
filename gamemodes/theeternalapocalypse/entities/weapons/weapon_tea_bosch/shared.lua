SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_smgsten.mdl"
SWEP.WorldModel			= "models/weapons/w_sten.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A dated but still reasonably effective SMG with an interesting side loading magazine"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.Sound 		= Sound("Weaponsten.Single")
SWEP.Primary.Recoil		= 0.6
SWEP.Primary.Damage		= 21
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay 		= 0.12

SWEP.IronFireAccel		= 5

SWEP.Primary.ClipSize		= 32
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

SWEP.IronSightsPos = Vector(4.39, -3.837, 3.108)
SWEP.IronSightsAng = Vector(-0.35, -0.42, 0)
SWEP.RunArmOffset = Vector(0, 0, 0)
SWEP.RunArmAngle = Vector(-9.389, -6.778, 0)

SWEP.ZWweight				= 60 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5navy/mp5-1.wav")
end