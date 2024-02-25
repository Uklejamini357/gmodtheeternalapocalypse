SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "Point away from face"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses steel bolts"

SWEP.Primary.Sound 		= Sound("ambient/explosions/explode_4.wav")
SWEP.Primary.Recoil		= 20
SWEP.Primary.Damage		= 265
SWEP.Primary.NumShots		= 3
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0.05

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-5.949, -0.922, 3.104)
SWEP.IronSightsAng = Vector(-0.597, 0, 0)

function SWEP:Precache()

    	util.PrecacheSound("weapons/fiveseven/fiveseven-1.wav")
end
/*
local explosioneffect = EffectData()
explosioneffect:SetRadius(8)
explosioneffect:SetMagnitude(1)
explosioneffect:SetScale(1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	if IsFirstTimePredicted() then
		explosioneffect:SetOrigin(tr.HitPos)
		explosioneffect:SetNormal(tr.HitNormal)
		util.Effect("Explosion", explosioneffect)
	end
end
*/
