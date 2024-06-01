SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV		= "45"
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_galil.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A rugged assault rifle that was used by the Saudi Union before their homeland was nuked in an attempt to halt the spread of zombies"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("Weapon_Galil.Single")
SWEP.Primary.Recoil		= 0.65
SWEP.Primary.Damage		= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.016
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false




SWEP.IronSightsPos = Vector(-6.361, -11.103, 2.519)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(4.645, 0, -1.339)

SWEP.RunArmAngle = Vector(-12.403, 23.424, -6.89)

function SWEP:Precache()

    	util.PrecacheSound("weapons/galil/galil-1.wav")
end