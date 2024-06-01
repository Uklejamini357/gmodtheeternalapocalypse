SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"
SWEP.UseHands			= true
SWEP.HoldType			= "revolver"

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A newer model of glock that was popular among police and servicemen before the apocalpyse"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses pistol rounds"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Primary.Sound 		= Sound("Weapon_Glock.Single")
SWEP.Primary.Recoil		= 0.8
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.016
SWEP.Primary.Delay 		= 0.15

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(-5.768, -5.726, 2.757)
SWEP.IronSightsAng = Vector(0.577, 0, 0)
SWEP.RunArmOffset = Vector(0, 0, 0)
SWEP.RunArmAngle = Vector(-6.773, 2.286, 0)

SWEP.Burst				= true
SWEP.BurstShots			= 2
SWEP.BurstDelay			= 0.06
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 3
SWEP.Mode				= false




--SWEP.data 				= {}
--SWEP.data.NormalMsg		= "Switched to semi-automatic."
--SWEP.data.ModeMsg			= "Switched to burst fire mode."
--SWEP.data.Delay			= 0.5
--SWEP.data.Cone			= 2
--SWEP.data.Damage			= 1
--SWEP.data.Recoil			= 1

function SWEP:Precache()

    	util.PrecacheSound("weapons/glock/glock18-1.wav")
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
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)

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