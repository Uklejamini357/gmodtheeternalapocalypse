-- OLD TYPE (may need redoing) (absolutely no)

SWEP.Base 				= "weapon_tea_base"
SWEP.Category           = "Mad Cows Weapons"
SWEP.UseHands			= true

SWEP.Author			= "Uklejamini"
SWEP.Purpose			= "A crowbar which was earlier used by Gordon Freeman. Can deal high damage."
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ShowWorldModel		= false
SWEP.HoldType				= "melee2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.HitDistance		= 100

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 69 -- nice
SWEP.Primary.PlayerDamage	= 48
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.0420
SWEP.Primary.Delay 		= 0.525

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false


SWEP.RunArmOffset = Vector(2.68, -6.85, -2.8)
SWEP.RunArmAngle = Vector(0, 0, 0)


SWEP.Sequence			= 0



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

function SWEP:Deploy()

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1)

	--self:EmitSound("weapons/knife/knife_deploy1.wav", 50, 100) --bruh why is that excluded

	self:IdleAnimation(1)

	return true
end


function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local trace = self.Owner:GetEyeTrace()

	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= self.HitDistance then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		local bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 1
		bullet.HullSize = 4
		bullet.Damage = trace.Entity:IsPlayer() and self.Primary.PlayerDamage or self.Primary.Damage
		self.Owner:FireBullets(bullet) 
		self:EmitSound("physics/flesh/flesh_impact_bullet"..math.random(3,5)..".wav")
	else
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	end
end
function SWEP:SecondaryAttack()
end
