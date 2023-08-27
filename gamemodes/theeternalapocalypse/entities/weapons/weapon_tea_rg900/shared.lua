SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_tmp.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 54

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A modern tactical machine pistol fitted with an integrated silencer"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses SMG rounds"

SWEP.Primary.Sound 		= Sound("Weapon_TMP.Single")
SWEP.Primary.Recoil		= 0.4
SWEP.Primary.Damage		= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.022
SWEP.Primary.Delay 		= 0.07

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.AlwaysSilenced			= true

SWEP.IronSightsPos = Vector(-6.981, -2.126, 2.799)

SWEP.IronSightsAng = Vector(0.699, 0, 0)
SWEP.RunArmOffset = Vector(7.953, 0, 0)

SWEP.RunArmAngle = Vector(-5.788, 23.424, 0)

SWEP.AllowPlaybackRate		= false

SWEP.ZWweight				= 50 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Uncommon" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/tmp/tmp-1.wav")
end