// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_famas.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Primary.Sound 		= Sound("Weapon_FAMAS.Single")
SWEP.Primary.Recoil		= 0.65
SWEP.Primary.Damage		= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.006
SWEP.Primary.Delay 		= 0.075

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A tough, accurate rifle that was used in large numbers by the european union as they tried to quell the zombie plague"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses rifle rounds"

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "ammo_rifle"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronCrosshair = true

SWEP.IronSightsPos = Vector(-6.2, -5.402, 0)
SWEP.IronSightsAng = Vector(1.095, 0, -1.219)
SWEP.RunArmOffset 		= Vector (1.7661, -3.2645, 1.9996)
SWEP.RunArmAngle	 		= Vector (-19.3086, 29.9962, 0)

SWEP.Burst				= true
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.05
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 3
SWEP.Mode				= false

SWEP.ZWweight				= 95 -- in kilograms divided by 10 eg 20 = 2kg
SWEP.ZWrarity				= "Common" -- Junk, Common, Uncommon, Rare, Epic

/*
SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to burst fire mode."
SWEP.data.Delay			= 0.5
SWEP.data.Cone			= 0.75
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1
*/

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/famas/famas-1.wav")
end

function SWEP:PrimaryAttack()

	// Holst/Deploy your fucking weapon
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