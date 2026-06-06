SWEP.Base 				= "weapon_tea_base"

SWEP.ShellEffect			= "effect_mad_shell_shotgun"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= true
SWEP.Sniper				= false

SWEP.Penetration			= false
SWEP.Ricochet			= false

function SWEP:Think()
	local owner = self:GetOwner()

	if self:Clip1() > self.Primary.ClipSize then
		self:SetClip1(self.Primary.ClipSize)
	end

	if self:GetNetworkedBool("Reloading") == true then
		if self:GetNetworkedInt("ReloadTime") < CurTime() then
			if (self:Clip1() >= self.Primary.ClipSize or owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
				self:SetNextPrimaryFire(CurTime() + self.ShotgunFinish)
				self:SetNextSecondaryFire(CurTime() + self.ShotgunFinish)
				self:SetNetworkedBool("Reloading", false)
				self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

				if (IsValid(owner) and owner:GetViewModel()) then
					self:IdleAnimation(owner:GetViewModel():SequenceDuration())
				end
			else
				self:SetNetworkedInt("ReloadTime", CurTime() + 0.45)
				self:SendWeaponAnim(ACT_VM_RELOAD)
				owner:RemoveAmmo(1, self.Primary.Ammo, false)
				self:SetClip1(self:Clip1() + 1)
				self:SetNextPrimaryFire(CurTime() + 0.5)
				self:SetNextSecondaryFire(CurTime() + 0.5)

				if (self:Clip1() >= self.Primary.ClipSize or owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
					self:SetNextPrimaryFire(CurTime() + 1.5)
					self:SetNextSecondaryFire(CurTime() + 1.5)
				else
					self:SetNextPrimaryFire(CurTime() + 0.5)
					self:SetNextSecondaryFire(CurTime() + 0.5)
				end
			end
		end
	end

	if (owner:KeyPressed(IN_ATTACK)) and (self:GetNWBool("Reloading", true)) then
		self:SetNextPrimaryFire(CurTime() + self.ShotgunFinish)
		self:SetNextPrimaryFire(CurTime() + self.ShotgunFinish)
		self:SetNetworkedInt("ReloadTime", CurTime() + self.ShotgunFinish)
		self:SetNetworkedBool("Reloading", false)

		timer.Simple(owner:GetViewModel():SequenceDuration(), function()
			if !self:IsValid() or !owner then return end

			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

			if (IsValid(owner) and owner:GetViewModel()) then
				self:IdleAnimation(owner:GetViewModel():SequenceDuration())
			end
		end)
	end

	self:SecondThink()

	if self.IdleDelay < CurTime() and self.IdleApply and self:Clip1() > 0 then
		local WeaponModel = owner:GetActiveWeapon():GetClass()

		if owner:GetActiveWeapon():GetClass() == WeaponModel and owner:Alive() then
			if self:GetDTBool(3) and self.Type == 2 then
				self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end

			if self.AllowPlaybackRate and not self:GetDTBool(1) then
				owner:GetViewModel():SetPlaybackRate(1)
			else
				owner:GetViewModel():SetPlaybackRate(0)
			end
		end

		self.IdleApply = false
	elseif self:Clip1() <= 0 then
		self.IdleApply = false
	end

	if self:GetDTBool(2) and owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end

	// If you're running or if your weapon is holsted, the third person animation is going to change
	if owner:KeyDown(IN_SPEED) or self:GetDTBool(0) then
		if self.Rifle or self.Sniper or self.Shotgun then
			if owner:KeyDown(IN_DUCK) then
				self:SetHoldType("normal")
			else
				self:SetHoldType("passive")
			end

		elseif self.Pistol then
			self:SetHoldType("normal")
		end
	else
		self:SetHoldType(self.HoldType)
	end

	if self:GetDTBool(3) and self.Type == 3 then
		if self.BurstTimer + self.BurstDelay < CurTime() then
			if self.BurstCounter > 0 then
				self.BurstCounter = self.BurstCounter - 1
				self.BurstTimer = CurTime()

				if self:CanPrimaryAttack() then
					self:EmitSound(self.Primary.Sound)
					self:ShootBulletInformation()
					self:TakePrimaryAmmo(1)
				end
			end
		end
	end

	self:NextThink(CurTime())
end

function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end

	if (self:GetNWBool("Reloading") or self.ShotgunReloading) then return end

	local owner = self:GetOwner()

	if (self:Clip1() < self.Primary.ClipSize and owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ShotgunReloading = true
		self:SetNextPrimaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self:SetNextSecondaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

		timer.Simple(self.ShotgunBeginReload, function()
			if !self:IsValid() then return end
			self.ShotgunReloading = false
			self:SetNetworkedBool("Reloading", true)
			self:SetVar("ReloadTime", CurTime() + 1)
			self:SetNextPrimaryFire(CurTime() + 0.5)
			self:SetNextSecondaryFire(CurTime() + 0.5)
		end)

		if (SERVER) then
			owner:SetFOV( 0, 0.15 )
			self:SetIronsights(false)
		end
	end
end

function SWEP:Deploy()

	self.ShotgunReloading = false
	self:SetNetworkedBool("Reloading", false)

	self:SendWeaponAnim(ACT_VM_DRAW)

	self:SetNextPrimaryFire(CurTime() + self.DeployDelay)
	self:SetNextSecondaryFire(CurTime() + self.DeployDelay)
	self.ActionDelay = (CurTime() + self.DeployDelay)

	if (SERVER) then
		self:SetIronsights(false)
	end

	local owner = self:GetOwner()

	if (IsValid(owner) and owner:GetViewModel()) then
		self:IdleAnimation(owner:GetViewModel():SequenceDuration())
	end

	return true
end
