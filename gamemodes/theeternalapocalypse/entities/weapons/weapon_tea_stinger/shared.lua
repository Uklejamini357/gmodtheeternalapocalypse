SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.HoldType				= "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "T.E.A. Weapons"
SWEP.UseHands			= true

SWEP.Primary.Sound 		= Sound("Weapon_SMG1.Single")
SWEP.Primary.Reload 		= Sound("Weapon_SMG1.Reload")
SWEP.Primary.Recoil		= 0.45
SWEP.Primary.Damage		= 19
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.013
SWEP.Primary.Delay 		= 0.1

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A burst fire machine pistol designed to be accurate enough to go toe to toe with longer range attackers"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses smg rounds"

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"	// "none" or "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Burst				= true
SWEP.BurstShots			= 4
SWEP.BurstDelay			= 0.06
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false




SWEP.IronSightsPos 		= Vector (-6.39, -3.32, 1.05)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (9.071, 0, 1.6418)
SWEP.RunArmAngle 			= Vector (-12.9765, 26.8708, 0)

function SWEP:Precache()

    	util.PrecacheSound("weapons/smg1/smg1_fire1.wav")
    	util.PrecacheSound("weapons/smg1/smg1_reload.wav")
end

/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self.Weapon:DefaultReload(ACT_VM_RELOAD) 

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.Owner:SetFOV( 0, 0.15 )
		self:SetIronsights(false)
		self.Weapon:EmitSound(self.Primary.Reload)
	end
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

	self:SecondThink()

	if self.Weapon:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if self.Weapon:GetDTBool(3) and self.Type == 2 then
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
		self.IdleApply = false
	end

	if self.Weapon:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end

		// If you're running or if your weapon is holsted, the third person animation is going to change
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
	

	// Burst fire mode
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

	self:NextThink(CurTime())
end