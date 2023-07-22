SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_fraggrenade.mdl"
SWEP.HoldType				= "grenade"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Grenade"

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

SWEP.GrenadeType			= "ent_tea_grenade_frag"
SWEP.GrenadeName			= "weapon_zw_grenade_frag"
SWEP.GrenadeTime			= "3"
SWEP.CookGrenade			= true
SWEP.ThrowForce				= 800

function SWEP:PrimaryAttack()

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if (self.Owner:GetNetworkedInt("Throw") > CurTime() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 or self.Owner:GetNetworkedInt("Primed") != 0 or self.Weapon:GetNetworkedBool("Holsted")) then return end

	self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)

	self.Owner:SetNetworkedInt("Primed", 1)
	self.Owner:SetNetworkedInt("Throw", CurTime() + 1)
	self.Owner:SetNetworkedBool("Cooked", false)
end

function SWEP:SecondaryAttack()

	// I used the cooking script of Wizey as an example.
	if not self.CookGrenade then return end
	if self.Owner:GetNetworkedBool("Reloading") then return end
	if self.Owner:GetNetworkedInt("Primed") == 0 then return end
	if self.Owner:GetNetworkedInt("Primed") == 2 then return end
	local playa = self.Owner

	playa:SetNetworkedBool("Reloading", true)
	timer.Simple(self.GrenadeTime + 0.1, function()
		if not playa then return end
		playa:SetNetworkedBool("Reloading", false)
	end)

	self.Weapon:EmitSound("weapons/grenade/cook.wav", 60)

	self.Owner:SetNetworkedBool("Cooked", true)
	self.NextExplode = CurTime() + self.GrenadeTime

	timer.Simple(self.GrenadeTime, function()
		if not playa then return end 	
		if not IsFirstTimePredicted() then return end

		if playa:GetNetworkedBool("Cooked") and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == self.GrenadeName and playa:Alive() then
			if playa:GetNetworkedInt("Primed") == 1 then
				local grenade = ents.Create(self.GrenadeType)

				local pos = playa:GetShootPos()
					pos = pos + playa:GetForward() * 1
					pos = pos + playa:GetRight() * 7
	
					if playa:KeyDown(IN_SPEED) then
						pos = pos + playa:GetUp() * -4
					else
						pos = pos + playa:GetUp() * 1
					end

				grenade:SetPos(pos)

				grenade:GetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
				grenade:SetOwner(playa)
				grenade:SetNetworkedInt("Cook", 0)
				grenade:Spawn()
				grenade:Activate()
				
				playa:SetNetworkedInt("Primed", 0)
				playa:SetNetworkedBool("Cooked", false)

				timer.Simple(0.6, function()
					if not playa then return end

					if playa:GetAmmoCount(self.Primary.Ammo) > 0 then
						self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
						playa:SetNetworkedInt("Primed", 0)
					else
						playa:SetNetworkedInt("Primed", 0)
						playa:ConCommand("lastinv")
					end
				end)
			end			
		end 
	end)
end

function SWEP:Think()
	local owner = self.Owner

	self:SecondThink()

	if (self.Owner:KeyDown(IN_SPEED) and self.Owner:GetNetworkedInt("Primed") == 0) or self.Weapon:GetNetworkedBool("Holsted") then
		if self.Rifle or self.Sniper or self.Shotgun then

			self:SetHoldType("passive")
	
		elseif self.Pistol then
		
			self:SetHoldType("normal")
		end
	else
		self:SetHoldType(self.HoldType)
	end

	if (self.Owner:GetNetworkedInt("Primed") == 1 and not self.Owner:KeyDown(IN_ATTACK)) then
		if self.Owner:GetNetworkedInt("Throw") < CurTime() then
			self.Owner:SetNetworkedInt("Primed", 2)
			self.Owner:SetNetworkedInt("Throw", CurTime() + 1.5)

			if not self.Owner:Crouching() then
				self.Weapon:SendWeaponAnim(ACT_VM_THROW)
			end

			self.Owner:SetAnimation(PLAYER_ATTACK1)

			timer.Simple(0.35, function()
				if not IsValid(owner) then return end
				if not IsValid(self) then owner:SetNetworkedInt("Primed", 0) print("bruh no") return end
				self:ThrowGrenade()
				self.Owner:ViewPunch(Angle(math.Rand(1, 2), math.Rand(0, 0), math.Rand(0, 0)))
			end)
		end
	end

	if self.Owner:GetNetworkedBool("Cooked") and self.Owner:GetNetworkedBool("LastShootCook") < CurTime() then
		if ((game.SinglePlayer() and SERVER) or CLIENT) then
			self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
			self.Owner:EmitSound("NPC_CombineCamera.Click")
		end

		self.Owner:SetNetworkedBool("LastShootCook", CurTime() + 1)
	end
end

function SWEP:Holster()

	self.Owner:SetNetworkedInt("Primed", 0)
	self.Owner:SetNetworkedInt("Throw", CurTime())

	return true
end

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	self.Weapon:SetNextPrimaryFire(CurTime() + self.DeployDelay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.DeployDelay)
	self.ActionDelay 	= (CurTime() + self.DeployDelay)

	self.Owner:SetNetworkedBool("LastShootCook", CurTime())

	return true
end

/*---------------------------------------------------------
   Name: SWEP:ThrowGrenade()
---------------------------------------------------------*/
function SWEP:ThrowGrenade()
	local owner = self.Owner

	if (owner:GetNetworkedInt("Primed") != 2 or CLIENT) then return end

	if self.CookGrenade and not owner:GetNetworkedBool("Cooked") then
		self.NextExplode = CurTime() + self.GrenadeTime
		self.Weapon:EmitSound("weapons/grenade/cook.wav", 60)
	end

	local grenade = ents.Create(self.GrenadeType)

	if self.CookGrenade then
		owner:SetNetworkedBool("Cooked", false)

		local RemainingTime = self.NextExplode - CurTime()
		grenade:SetNetworkedInt("Cook", CurTime() + RemainingTime)
	end

	local pos = owner:GetShootPos()
		pos = pos + owner:GetRight() * 7

		if owner:KeyDown(IN_SPEED) and not owner:Crouching() then
			pos = pos + owner:GetUp() * -4
		elseif not owner:Crouching() then
			pos = pos + owner:GetForward() * -6
			pos = pos + owner:GetUp() * 1
		else
			pos = pos + owner:GetForward() * 1
			pos = pos + owner:GetUp() * -24
		end

	grenade:SetPos(pos)
	grenade:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
	grenade:SetOwner(owner)
	grenade:Spawn()
	grenade:Activate()
	
	local phys = grenade:GetPhysicsObject()

	if owner:KeyDown(IN_FORWARD) then
		self.Force = self.ThrowForce * 1.2
	elseif owner:KeyDown(IN_BACK) then
		self.Force = self.ThrowForce * 0.8
	else
		self.Force = self.ThrowForce
	end

	if not owner:Crouching() then
		phys:ApplyForceCenter(owner:GetAimVector() * self.Force * 1.2 + Vector(0, 0, 200))
	else
		phys:ApplyForceCenter(owner:GetAimVector() * self.Force * 1.2 + Vector(0, 0, 0))
	end

	phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))

	owner:RemoveAmmo(1, self.Primary.Ammo)

	timer.Simple(0.6, function()
		if not owner then return end

		owner:SetNetworkedInt("Primed", 0)
		if !self:IsValid() then return end
		if owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		else
			owner:StripWeapon(self.Weapon:GetClass())
		end
	end)
end