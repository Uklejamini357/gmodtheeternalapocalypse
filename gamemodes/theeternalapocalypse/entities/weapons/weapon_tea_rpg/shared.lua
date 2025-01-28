SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/c_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.HoldType				= "rpg"
SWEP.UseHands			= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"

SWEP.Primary.Sound 		= Sound("NPC_Helicopter.FireRocket")
SWEP.Primary.Recoil		= 0
SWEP.Primary.Damage		= 560
SWEP.Primary.DamageRadius	= 320
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 2

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG_Round"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos	=	Vector (-16.681, -10.921, -3.12)
SWEP.IronSightsAng	=	Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (7.6581, -13.4056, 1.4333)
SWEP.RunArmAngle 			= Vector (-14.4149, 29.214, 0)

function SWEP:Precache()
	util.PrecacheSound("weapons/stinger_fire1.wav")
end

function SWEP:Rocket()

	if (CLIENT) then return end

	local rocket = ents.Create("ent_tea_rocket")

	rocket:SetOwner(self.Owner)
		
	local pos = self.Owner:GetShootPos()
		pos = pos + self.Owner:GetForward() * 17.5
		pos = pos + self.Owner:GetRight() * 20
		pos = pos + self.Owner:GetUp() * 0
	rocket:SetPos(pos)	
		
	rocket:SetAngles(self.Owner:EyeAngles())
	rocket.Number = 1
	rocket.ExplosionDamage = self.Primary.Damage
	rocket.ExplosionRadius = self.Primary.DamageRadius
	rocket.ShotFromWeapon = self
	rocket:Spawn()
	rocket:Activate()
end

function SWEP:DoubleRocket()

	if (CLIENT) then return end

	local rocket = ents.Create("ent_tea_rocket")

	rocket:SetOwner(self.Owner)
		
	local pos = self.Owner:GetShootPos()
		pos = pos + self.Owner:GetForward() * 17.5
		pos = pos + self.Owner:GetRight() * 20
		pos = pos + self.Owner:GetUp() * 0
	rocket:SetPos(pos)	
		
	rocket:SetAngles(self.Owner:EyeAngles())
	rocket.Number = 2
	rocket:Spawn()
	rocket:Activate()
end

function SWEP:PrimaryAttack()

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end

	self.ActionDelay = (CurTime() + self.Primary.Delay)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self:SetIronsights(false)

	if self.Weapon:Clip1() == 2 then
		self:TakePrimaryAmmo(1)

		timer.Simple(0.1, function()
			if not self.Owner then return end
			if not IsFirstTimePredicted() then return end
			self:TakePrimaryAmmo(1)
			self:DoubleRocket()
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:ViewPunch(Angle(math.Rand(-30, -35), math.Rand(0, 0), math.Rand(0, 0)))	
		end)

		self:DoubleRocket()

		self.Weapon:EmitSound(self.Primary.Sound)
		self.Owner:ViewPunch(Angle(math.Rand(-30, -35), math.Rand(0, 0), math.Rand(0, 0)))	
	else
		self:TakePrimaryAmmo(1)
		self:Rocket()

		self.Weapon:EmitSound(self.Primary.Sound)
		self.Owner:ViewPunch(Angle(math.Rand(-20, -35), math.Rand(0, 0), math.Rand(0, 0)))	
		self.Owner:SetVelocity(self.Owner:GetAimVector() * -150)
	end

	self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())

	local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()
end

function SWEP:SecondaryAttack()

// Experimental test: two rockets at the same time.
/*
	if self.Weapon:Clip1() == self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		self.ActionDelay = (CurTime() + self.Primary.Delay)
		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)

		timer.Simple(1, function() 
			if not self.Owner then return end
			if not IsFirstTimePredicted() then return end
			self.Weapon:SetClip1(self.Weapon:Clip1() + 1)
			self.Owner:RemoveAmmo(1, self.Weapon:GetPrimaryAmmoType())
		end)
	end
*/
end