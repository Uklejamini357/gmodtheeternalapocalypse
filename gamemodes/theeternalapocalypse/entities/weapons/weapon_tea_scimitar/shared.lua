SWEP.Base 				= "weapon_tea_base_sniper"

SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_g3sg1.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true
SWEP.ViewModelFOV		= "54"
SWEP.Purpose			= "A burst fire sniper created by kohl to give infantry squads long range capabilites in battle"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses sniper ammo"

SWEP.Primary.Sound 		= Sound("Weapon_G3SG1.Single")
SWEP.Primary.Recoil		= 1
SWEP.Primary.Damage		= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0005
SWEP.Primary.Delay 		= 0.15

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "ammo_sniper"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.IronSightsPos = Vector(-7.16, -11.261, 1.919)

SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset = Vector(7.164, 0, -0.237)

SWEP.RunArmAngle = Vector(-7.993, 29.488, 0)

SWEP.ScopeZooms			= {6}

SWEP.Burst				= true
SWEP.BurstShots			= 2
SWEP.BurstDelay			= 0.06
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

function SWEP:Precache()

    	util.PrecacheSound("weapons/g3sg1/g3sg1-1.wav")
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

	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	self.BurstTimer 	= CurTime()
	self.BurstCounter = self.BurstShots - 1
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.4)

	self.Weapon:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
end

function SWEP:Think()
	self:SetHoldType(self.HoldType)

	self:SecondThink()

	if self.IdleDelay < CurTime() and self.IdleApply and self.Weapon:Clip1() > 0 then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if self.Weapon:GetNetworkedBool("Suppressor") then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			end

			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end	
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() <= 0 then
		self.IdleApply = true
	end

	if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) and self.Owner:KeyDown(IN_SPEED) then
		self:ResetVariables()
		self.Owner:SetFOV(0, 0.2)
	end

	if (self.BoltActionSniper) and (self.Owner:KeyPressed(IN_ATTACK2) or self.Owner:KeyPressed(IN_RELOAD)) then
		self.ScopeAfterShoot = false
	end

	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if (self.BoltActionSniper) then
			self.ScopeAfterShoot = false
		end

	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if self.Sniper then
			if self.Owner:KeyDown(IN_DUCK) then
				self:SetHoldType("normal")
			else
				self:SetHoldType("passive")
			end

		else
			self:SetHoldType("ar2")
		end
	else
		self:SetHoldType(self.HoldType)
	end
end
		if self.BurstTimer + self.BurstDelay < CurTime() then
			if self.BurstCounter > 0 then
				self.BurstCounter = self.BurstCounter - 1
				self.BurstTimer = CurTime()
				
				if self:CanPrimaryAttack() then
					self.Weapon:EmitSound(self.Primary.Sound)
					self:ShootBulletInformation()
					self:TakePrimaryAmmo(1)
				end
			end
		end

	if (CLIENT) and (self.Weapon:GetDTBool(2)) then
		self.MouseSensitivity = self.Owner:GetFOV() / 60
	else
		self.MouseSensitivity = 1
	end

	if not (CLIENT) and (self.Weapon:GetDTBool(2)) and (self.Weapon:GetDTBool(1)) then
		self.Owner:DrawViewModel(false)
	elseif not (CLIENT) then
		self.Owner:DrawViewModel(true)
	end

	self:NextThink(CurTime())
end