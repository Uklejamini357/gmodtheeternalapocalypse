SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A silencable pistol that used to be popular among swat and miltary outfits"
SWEP.Instructions			= "Left click to fire, Right click to aim, e + right click to attach silencer, uses pistol rounds"

SWEP.Primary.Sound 		= Sound("Weapon_USP.Single")
SWEP.Primary.SuppressorSound	= Sound("Weapon_USP.SilencedShot")
SWEP.Primary.NoSuppressorSound= Sound("Weapon_USP.Single")
SWEP.Primary.Recoil		= 1.15
SWEP.Primary.Damage		= 21
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.019
SWEP.Primary.Delay 		= 0.11

SWEP.IronFireAccel = 5

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

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

SWEP.IronFireAccel		= 5

SWEP.IronSightsPos = Vector(-5.902, -7.044, 2.64)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(0, 0, 0)

SWEP.RunArmAngle = Vector(-14.056, 0, 0)

SWEP.Type				= 2
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= ""
SWEP.data.ModeMsg			= ""
SWEP.data.Delay			= 1.5
SWEP.data.Cone			= 1.5
SWEP.data.Damage			= 0.9
SWEP.data.Recoil			= 0.5

function SWEP:Precache()

    	util.PrecacheSound("weapons/usp/usp1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() <= 0) then
		if self.Weapon:GetDTBool(3) and self.Type == 2 then
			self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)	
		else
			self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE)
		end
	else
		if self.Weapon:GetDTBool(3) and self.Type == 2 then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence("shoot1"))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
	end
end