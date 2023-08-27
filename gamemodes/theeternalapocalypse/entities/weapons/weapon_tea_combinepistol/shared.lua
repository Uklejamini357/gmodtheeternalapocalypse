SWEP.Base 				= "weapon_tea_base"

SWEP.ViewModel			= "models/weapons/v_cmbhgp.mdl"
SWEP.WorldModel			= "models/weapons/w_cmbhgp.mdl"
SWEP.HoldType			= "pistol"
SWEP.UseHands			= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"

SWEP.Primary.Sound 		= Sound("weapons/CombinePistol/CombinePistol_Fire3.wav")
SWEP.Primary.Reload 		= Sound("weapons/CombinePistol/CP_Reload.wav")
SWEP.Primary.Recoil		= 0.75
SWEP.Primary.Damage		= 23
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay 		= 0.09

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ammo_ar2_pulseammo"

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

SWEP.IronSightsPos = Vector(-2.991, -7.008, 1.5)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunArmOffset 		= Vector (0.041, 0, 5.6778)
SWEP.RunArmAngle 			= Vector (-17.6901, 0.321, 0)

SWEP.Burst				= true
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.05
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 3
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to Semi Automatic"
SWEP.data.ModeMsg			= "Switched to burst fire mode."
SWEP.data.Delay			= 0.7
SWEP.data.Cone			= 0.03
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1
SWEP.FiremodeToggleable		= true

function SWEP:Precache()
	util.PrecacheSound("weapons/pistol/pistol_fire2.wav")
	util.PrecacheSound("weapons/pistol/pistol_reload1.wav")
end

function SWEP:Reload()
	if self.Owner:KeyDown(IN_USE) then
		if !self.Primary.Automatic and self.FiremodeToggleable then
			self.FiremodeToggleable = false
			self.Primary.Automatic = true
			timer.Simple(0.8, function() if self:IsValid() then self.FiremodeToggleable = true end end)
			if CLIENT then chat.AddText("Automatic mode enabled") end
		elseif self.Primary.Automatic and self.FiremodeToggleable then
			self.FiremodeToggleable = false
			self.Primary.Automatic = false
			timer.Simple(0.8, function() if self:IsValid() then self.FiremodeToggleable = true end end)
			if CLIENT then chat.AddText("Automatic mode disabled") end
		end
	else
		if (self.ActionDelay > CurTime()) then return end 

		self.Weapon:DefaultReload(ACT_VM_RELOAD) 

		if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			self.ActionDelay = CurTime() + 1
			self.Owner:SetFOV(0, 0.15)
			self:SetIronsights(false)
			self.Weapon:EmitSound(self.Primary.Reload)
			self:IdleAnimation(1)
		end
	end
end


local pulseeffect = EffectData()
pulseeffect:SetRadius(8)
pulseeffect:SetMagnitude(1)
pulseeffect:SetScale(1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	if IsFirstTimePredicted() then
		pulseeffect:SetOrigin(tr.HitPos)
		pulseeffect:SetNormal(tr.HitNormal)
		util.Effect("AR2Impact", pulseeffect)
	end
end

