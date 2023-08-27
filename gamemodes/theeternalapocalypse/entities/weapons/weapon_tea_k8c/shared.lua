SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_hkoch_usc.mdl"
SWEP.WorldModel			= "models/weapons/w_hk_usc.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= 60

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "The last weapon design released by Kohl before germany was overrun by the zombies, this is a modern SMG that offers excellent power, efficiency and accuracy"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.Sound 		= Sound("Weapon_hkusc.Single")
SWEP.Primary.Recoil		= 0.5
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.007
SWEP.Primary.Delay 		= 0.1

SWEP.IronFireAccel = 5

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
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

SWEP.IronSightsPos = Vector(4.691, -4.435, 2.029)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(-1.492, 0, 0)
SWEP.RunArmAngle = Vector(-7.121, -8.921, 0)

SWEP.ZWweight				= 70 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Uncommon" -- Junk, Common, Uncommon, Rare, Epic

SWEP.Type				= 3
SWEP.Mode				= false

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