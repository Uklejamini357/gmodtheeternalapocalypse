SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_sg552.mdl"
SWEP.UseHands			= true

SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A shortened version of the Stug 556LR Sniper that has been optimized for use as an assault rifle"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.Sound 		= Sound("Weapon_SG552.Single")
SWEP.Primary.Recoil		= 0.7
SWEP.Primary.Damage		= 24
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.007
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos = Vector(-8.881, -16.299, 2.559)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(15.038, 0, 0)

SWEP.RunArmAngle = Vector(-14.056, 40.512, 0)

SWEP.ZWweight				= 115 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Rare" -- Junk, Common, Uncommon, Rare, Epic

SWEP.ScopeZooms			= {4}

function SWEP:Precache()

    	util.PrecacheSound("weapons/sg552/sg552-1.wav")
end