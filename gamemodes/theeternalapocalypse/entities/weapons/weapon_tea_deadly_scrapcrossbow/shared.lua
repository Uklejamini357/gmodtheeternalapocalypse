SWEP.Base 				= "weapon_mad_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/c_crossbow.mdl"
SWEP.WorldModel			= "models/weapons/w_crossbow.mdl"
SWEP.HoldType				= "crossbow"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true
SWEP.Purpose			= "A crossbow cobbled together from an old battery and a bunch of scrap metal. Unlike regular crossbow, this makes bolts explode on impact."
SWEP.Instructions		= "Left click to fire, Right click to aim, uses steel bolts"

SWEP.Primary.Sound 		= Sound("Weapon_Crossbow.Single")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 65
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 0.5

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.BoltExplosionDamage = 190 -- Explosion damage
SWEP.BoltExplosionRadius = 155 -- Explosion radius

SWEP.ShellEffect			= "none"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos	= Vector(-7.961, -11.658, 1.919)
SWEP.IronSightsAng	= Vector(0, 0, 0)
SWEP.RunArmOffset 		= Vector (1.6747, -1.5757, 3.7093)
SWEP.RunArmAngle 			= Vector (-19.0161, 11.682, 0)

SWEP.ScopeZooms			= {8}

SWEP.BoltActionSniper		= true

function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self:DefaultReload(ACT_VM_RELOAD) 

	if (self:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ActionDelay = CurTime() + 2
		self.Owner:SetFOV(0, 0.15)
		self:SetIronsights(false)

		self:EmitSound("Weapon_Crossbow.Reload")
		timer.Simple(1, function() 
			if not IsFirstTimePredicted() then return end
			if not self.Owner:IsNPC() and not self.Owner:Alive() then return end

			local effectdata = EffectData()
				effectdata:SetOrigin(self.Owner:GetShootPos())
				effectdata:SetEntity(self)
				effectdata:SetStart(self.Owner:GetShootPos())
				effectdata:SetNormal(self.Owner:GetAimVector())
				effectdata:SetAttachment(1)
			util.Effect("effect_mad_shotgunsmoke", effectdata)

			self:EmitSound("Weapon_Crossbow.BoltElectrify") 
		end)

		if not (CLIENT) then
			self.Owner:DrawViewModel(true)
		end

		--self:IdleAnimation(2)
	end
end

/*---------------------------------------------------------
   Name: SWEP:Bolt()
---------------------------------------------------------*/
function SWEP:Bolt()

	if CLIENT then return end

	local owner = self:GetOwner()
	local bolt = ents.Create("ent_tea_bolt")

	if not self:GetDTBool(1) then
		local pos = owner:GetShootPos()
			pos = pos + owner:GetForward() * -10
			pos = pos + owner:GetRight() * 9
			pos = pos + owner:GetUp() * -7
		bolt:SetPos(pos)	
	else
		bolt:SetPos(owner:EyePos() + owner:GetAimVector() + owner:GetUp() + owner:GetForward() * -10)
	end

	bolt:SetAngles(owner:GetAimVector():Angle())
	bolt:SetOwner(owner)
	bolt:Spawn()
	bolt:Activate()
	bolt.BoltDamage = self.Primary.Damage
	bolt.ExplosionDamage = self.BoltExplosionDamage
	bolt.ExplosionRadius = self.BoltExplosionRadius
	bolt.ShotFrom = self
	bolt.Deadly = true

	if (owner:WaterLevel() == 3) then
		bolt:SetVelocity(owner:GetAimVector() * (BOLT_WATER_VELOCITY or 0.65))
	else
		bolt:SetVelocity(owner:GetAimVector() * (BOLT_AIR_VELOCITY or 1))
	end
end

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()

	if (not owner:IsNPC() and owner:KeyDown(IN_USE)) then
		bHolsted = !self:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self:SetNextPrimaryFire(CurTime() + 0.3)
		self:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end

	self.ActionDelay = (CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	owner:SetAnimation(PLAYER_ATTACK1)

	self:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:Bolt()

	if (not owner:IsNPC()) then
		owner:ViewPunch(Angle(math.Rand(-1, -5), math.Rand(0, 0), math.Rand(0, 0)))
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(owner:GetShootPos())
		effectdata:SetEntity(self)
		effectdata:SetStart(owner:GetShootPos())
		effectdata:SetNormal(owner:GetAimVector())
		effectdata:SetAttachment(1)
	util.Effect("effect_mad_shotgunsmoke", effectdata)	

	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self:SetNetworkedFloat("LastShootTime", CurTime())
	end

	local WeaponModel = self:GetOwner():GetActiveWeapon():GetClass()

	if (self:Clip1() < 1 and not self:GetDTBool(1)) then
		timer.Simple(self.Primary.Delay + 0.1, function()
			if owner:GetActiveWeapon():GetClass() == WeaponModel and owner:Alive() then
				self:Reload() 
			end
		end)
	end
end
