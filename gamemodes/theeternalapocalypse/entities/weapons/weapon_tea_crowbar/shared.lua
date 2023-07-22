// Variables that are used on both client and server
// OLD TYPE*(mayneed redoing)

SWEP.Base 				= "weapon_mad_base"
SWEP.Category           = "Mad Cows Weapons"
SWEP.UseHands			= true

SWEP.Author			= "Uklejamini"
SWEP.Purpose			= "A crowbar which was earlier used by Gordon Freeman."
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ShowWorldModel		= false
SWEP.HoldType				= "melee2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 46
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.0420
SWEP.Primary.Delay 		= 0.45

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false


SWEP.RunArmOffset = Vector(2.68, -6.85, -2.8)
SWEP.RunArmAngle = Vector(0, 0, 0)


SWEP.Sequence			= 0



/*---------------------------------------------------------
   Name: SWEP:Precache()
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/knife/knife_slash1.wav")
    	util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
    	util.PrecacheSound("weapons/knife/knife_deploy1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit2.wav")
    	util.PrecacheSound("weapons/knife/knife_hit3.wav")
    	util.PrecacheSound("weapons/knife/knife_hit4.wav")
    	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:Deploy()
---------------------------------------------------------*/
function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	--self.Weapon:EmitSound("weapons/knife/knife_deploy1.wav", 50, 100) --bruh why is that excluded

	self:IdleAnimation(1)

	return true
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local trace = self.Owner:GetEyeTrace()

	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 1
		bullet.Damage = self.Primary.Damage
		self.Owner:FireBullets(bullet) 
		self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
	else
		self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	end
end
/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end
