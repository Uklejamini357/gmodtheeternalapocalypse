SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "My first peashooter, given to all players that are under level 10 when they spawn"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses pistol rounds"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_Glock.Single")
SWEP.Primary.Recoil		= 0.8
SWEP.Primary.Damage		= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay 		= 0.12

SWEP.Primary.ClipSize		= 14
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-5.768, -5.726, 2.757)
SWEP.IronSightsAng = Vector(0.577, 0, 0)
SWEP.RunArmOffset = Vector(0, 0, 0)
SWEP.RunArmAngle = Vector(-6.773, 2.286, 0)

SWEP.Burst				= true
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.025
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 3
SWEP.Mode				= false

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to semi-automatic."
SWEP.data.ModeMsg			= "Switched to burst fire mode."
SWEP.data.Delay			= 0.5
SWEP.data.Cone			= 2
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1

SWEP.ZWweight				= 15 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Junk" -- Junk, Common, Uncommon, Rare, Epic

function SWEP:Precache()

    	util.PrecacheSound("weapons/glock/glock18-1.wav")
end