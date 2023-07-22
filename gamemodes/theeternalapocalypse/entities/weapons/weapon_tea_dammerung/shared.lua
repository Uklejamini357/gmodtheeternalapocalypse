SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_usas12_shot.mdl"
SWEP.WorldModel			= "models/weapons/w_usas_12.mdl"
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"
SWEP.UseHands			= true

SWEP.Author				= ""
SWEP.Contact			= ""
SWEP.Purpose			= "A fully automatic 20 round assault shotgun that chews anybody in the room into pulpy red goop"
SWEP.Instructions			= "Left click to fire, Right click to aim, uses shotgun ammo"

SWEP.Primary.Sound 		= Sound("Weapon_usas.Single")
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 11
SWEP.Primary.NumShots		= 7
SWEP.Primary.Cone			= 0.07
SWEP.Primary.Delay 		= 0.2

SWEP.IronFireAccel = 1.5

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_shotgun"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector(4.355, -4.348, 0.862)
SWEP.IronSightsAng = Vector(1.603, -0.146, 0)
SWEP.RunArmOffset = Vector(0.158, 1.269, -0.398)
SWEP.RunArmAngle = Vector(-5.907, -9.433, 0)

function SWEP:Precache()
end


function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self.Weapon:DefaultReload(ACT_SHOTGUN_RELOAD_START)
		self:SetNextPrimaryFire(CurTime() + 2.5)
		self:SetNextSecondaryFire(CurTime() + 2.5)
--		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START) 
		timer.Simple(1.5, function()
		if !self:IsValid() then return false end
		self:SetIronsights(false)
		self:ReloadAnimation()
		end)
	end
end

function SWEP:ReloadAnimation()

	self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end