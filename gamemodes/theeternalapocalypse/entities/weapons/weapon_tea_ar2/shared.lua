SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel 			= "models/weapons/c_irifle.mdl"
SWEP.WorldModel 			= "models/weapons/w_irifle.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.Instructions    = "A weapon used by combine soldiers, before and after an outbreak has begun. Uses Pulse ammo."
SWEP.UseHands			= true

SWEP.Primary.Sound 		= Sound("Weapon_AR2.Single")
SWEP.Primary.Reload 		= Sound("Weapon_AR2.Reload")
SWEP.Primary.Recoil		= 0.55
SWEP.Primary.Damage		= 32
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.01
SWEP.Primary.Delay 		= 0.1

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_ar2_pulseammo"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos = Vector(-5.881, -12.865, 1.44)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset 		= Vector (7.3723, 0, 2.0947)
SWEP.RunArmAngle 			= Vector (-12.9765, 26.8708, 0)

SWEP.ScopeZooms			= {2}
SWEP.RedDot				= true

SWEP.Tracer				= 1

function SWEP:Precache()
    util.PrecacheSound("weapons/ar2/fire1.wav")
end

local pulseeffect = EffectData()
pulseeffect:SetRadius(8)
pulseeffect:SetMagnitude(1)
pulseeffect:SetScale(1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	if IsFirstTimePredicted() then
		pulseeffect:SetOrigin(tr.HitPos)
		pulseeffect:SetNormal(tr.HitNormal)
		util.Effect("cball_bounce", pulseeffect)
	end
end
