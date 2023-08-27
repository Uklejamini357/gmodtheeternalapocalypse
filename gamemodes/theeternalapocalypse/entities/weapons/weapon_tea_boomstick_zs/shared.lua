-- Nah, forget about it.

SWEP.Base 				= "weapon_tea_base_shotgun"

SWEP.ViewModel			= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.HoldType				= "shotgun"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.UseHands			= true
SWEP.Category			= "ZW Weapons"
SWEP.Shotgun			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A pump shotgun that has been cut down from its original length to save on weight.  It has also been modded with an alternate slamfire mode that fires 2 rounds in quick succession"
SWEP.Instructions			= "Left click to fire, Right click to aim, Left Click + E to change firemode, uses shotgun rounds"

SWEP.Primary.Sound 		= Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Reload		= Sound("Weapon_SHOTGUN.Reload")
SWEP.Primary.Special	= Sound("Weapon_SHOTGUN.Special1")
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 17
SWEP.Primary.NumShots	= 6
SWEP.Primary.Cone		= 0.185
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= 4
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.IronSightsPos = Vector(-8.961, -8.74, 4.199)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset 	= Vector (3, 0, 2.5)
SWEP.RunArmAngle 	= Vector (-13, 27, 0)

SWEP.ShellEffect = "effect_mad_shell_shotgun"

SWEP.ShotgunReloading = false
SWEP.ShotgunFinish = 0.3
SWEP.ShotgunBeginReload = 0.6

SWEP.Knockback = 80
SWEP.Type = 3
SWEP.Mode = true

function SWEP:Precache()
	util.PrecacheSound("weapons/shotgun/shotgun_reload1.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_reload2.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_reload3.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_cock.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_fire6.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_fire7.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_dbl_fire.wav")
	util.PrecacheSound("weapons/shotgun/shotgun_dbl_fire7.wav")
end

function SWEP:Think()

	if self.Weapon:Clip1() > self.Primary.ClipSize then
		self.Weapon:SetClip1(self.Primary.ClipSize)
	end

	if self.Weapon:GetNetworkedBool("Reloading") == true then
		if self.Weapon:GetNetworkedInt("ReloadTime") < CurTime() then
			if self.unavailable then return end

			if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
				self.Weapon:SetNextPrimaryFire(CurTime() + 1)
				self.Weapon:SetNextSecondaryFire(CurTime() + 1)
				self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + 1)
				self.Weapon:SetNetworkedBool("Reloading", false)
				self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			else
				self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + 0.4)
				self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
				self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
				self.Weapon:SetClip1(self.Weapon:Clip1() + 1)
				self.Weapon:SetNextPrimaryFire(CurTime() + 1)
				self.Weapon:SetNextSecondaryFire(CurTime() + 1)
				self.Weapon:EmitSound(self.Primary.Reload)

				if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
					self.Weapon:SetNextPrimaryFire(CurTime() + 1)
					self.Weapon:SetNextSecondaryFire(CurTime() + 1)
				else
					self.Weapon:SetNextPrimaryFire(CurTime() + 1)
					self.Weapon:SetNextSecondaryFire(CurTime() + 1)
				end
			end
		end
	end

	if self.Owner:KeyPressed(IN_ATTACK) and (self.Weapon:GetNWBool("Reloading", true)) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
		self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + 1)
		self.Weapon:SetNetworkedBool("Reloading", false)

		timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function()
			if not self.Owner then return end
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

			if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
				self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
			end
		end)
	end

	self:SecondThink()

	if self.IdleDelay < CurTime() and self.IdleApply and self.Weapon:Clip1() > 0 then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)

			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end		
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() <= 0 then
		self.IdleApply = false
	end

	if self.Weapon:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end

	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if self.Rifle or self.Sniper or self.Shotgun then
			if self.Owner:KeyDown(IN_DUCK) then
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

	self:NextThink(CurTime())
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

	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.5)

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration() + 0.5)
	end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:EmitSound(self.Primary.Sound)

	local shots = self:Clip1()
	self:TakePrimaryAmmo(shots)
	self.Owner:SetVelocity(-self.Knockback * shots * self.Owner:GetAimVector())
	local originalshots = self.Primary.NumShots
	self.Primary.NumShots = originalshots * shots

	local punch = math.Clamp(shots * 0.8, 0, 3)
	self.Owner:ViewPunch(Angle(math.Rand(-punch,punch), math.Rand(-punch,punch), 1.65 * shots))
	self:ShootBulletInformation()

	self.Primary.NumShots = originalshots

	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end
end

function SWEP:ShootAnimation()

	if self.Weapon:GetDTBool(3) and (self.Weapon:Clip1() >= 2) then
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end

function SWEP:Reload()
	if (self.ActionDelay > CurTime()) then return end 

	if (self.Weapon:GetNWBool("Reloading") or self.ShotgunReloading) then return end

	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.ShotgunReloading = true
		self.Weapon:SetNextPrimaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.ShotgunBeginReload + 0.1)
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

		timer.Simple(self.ShotgunBeginReload, function()
			self.ShotgunReloading = false
			self.Weapon:SetNetworkedBool("Reloading", true)
			self.Weapon:SetVar("ReloadTime", CurTime() + 1)
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.4)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.4)
		end)

		if (SERVER) then
			self.Owner:SetFOV( 0, 0.15 )
			self:SetIronsights(false)
		end
	end
end
