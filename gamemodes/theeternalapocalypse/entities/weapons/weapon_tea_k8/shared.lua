SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_ump45.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 54

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "The last weapon design released by Kohl before germany was overrun by the zombies, this is a modern SMG that offers excellent power, efficiency and accuracy"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.Sound 		= Sound("Weapon_UMP45.Single")
SWEP.Primary.Recoil		= 0.45
SWEP.Primary.Damage		= 23
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.011
SWEP.Primary.Delay 		= 0.12

SWEP.IronFireAccel = 5

SWEP.Primary.ClipSize		= 25
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

SWEP.IronSightsPos = Vector(-8.73, -10.563, 4.024)
SWEP.IronSightsAng = Vector(-1.231, -0.29, -2.013)
SWEP.RunArmOffset = Vector(5.96, -5.989, 0.49)
SWEP.RunArmAngle = Vector(-5.52, 36.693, 0)

SWEP.ZWweight				= 70 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Uncommon" -- Junk, Common, Uncommon, Rare, Epic

SWEP.Type				= 3
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg		= "Switched to burst fire mode."
SWEP.data.Delay			= 0.5
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 0.5

function SWEP:Precache()

    	util.PrecacheSound("weapons/ump45/ump45-1.wav")
end