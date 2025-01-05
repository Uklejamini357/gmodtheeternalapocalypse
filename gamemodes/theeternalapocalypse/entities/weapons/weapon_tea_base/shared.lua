
local Sound = Sound
local Vector = Vector
local CreateConVar = CreateConVar
local CurTime = CurTime
local IsFirstTimePredicted = IsFirstTimePredicted
local Angle = Angle
local EffectData = EffectData
local SinglePlayer = SinglePlayer
local FrameTime = FrameTime
local IsValid = IsValid
local WorldSound = WorldSound
local util = util
local hook = hook
local math = math
local timer = timer
local ents = ents
local ACT_VM_IDLE = ACT_VM_IDLE
local PLAYERANIMEVENT_CUSTOM_GESTURE = PLAYERANIMEVENT_CUSTOM_GESTURE
local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD
local ACT_MP_ATTACK_CROUCH_PRIMARYFIRE = ACT_MP_ATTACK_CROUCH_PRIMARYFIRE
local ACT_MP_ATTACK_STAND_PRIMARYFIRE = ACT_MP_ATTACK_STAND_PRIMARYFIRE
local FCVAR_REPLICATED = FCVAR_REPLICATED
local FCVAR_ARCHIVE = FCVAR_ARCHIVE
local ACT_VM_DRAW_EMPTY = ACT_VM_DRAW_EMPTY
local ACT_VM_DRAW_SILENCED = ACT_VM_DRAW_SILENCED
local ACT_VM_DRAW = ACT_VM_DRAW
local IN_SPEED = IN_SPEED
local ACT_VM_IDLE_SILENCED = ACT_VM_IDLE_SILENCED
local ACT_VM_IDLE_EMPTY = ACT_VM_IDLE_EMPTY
local IN_FORWARD = IN_FORWARD
local IN_BACK = IN_BACK
local IN_MOVELEFT = IN_MOVELEFT
local IN_MOVERIGHT = IN_MOVERIGHT
local HUD_PRINTTALK = HUD_PRINTTALK
local ACT_VM_RELOAD = ACT_VM_RELOAD
local ACT_VM_RELOAD_SILENCED = ACT_VM_RELOAD_SILENCED
local ACT_VM_RELOAD_EMPTY = ACT_VM_RELOAD_EMPTY
local IN_USE = IN_USE
local ACT_INVALID = ACT_INVALID
local IN_DUCK = IN_DUCK
local SERVER = SERVER
local CLIENT = CLIENT
local MAT_GLASS = MAT_GLASS
local MAT_SAND = MAT_SAND
local MAT_FLESH = MAT_FLESH
local MAT_ALIENFLESH = MAT_ALIENFLESH
local MAT_WOOD = MAT_WOOD
local MAT_CONCRETE = MAT_CONCRETE
local MAT_PLASTIC = MAT_PLASTIC

/*---------------------------------------------------------
------mmmm---mmmm-aaaaaaaa----ddddddddd---------------------------------------->
     mmmmmmmmmmmm aaaaaaaaa   dddddddddd	  Name: Mad Cows Weapons
     mmm mmmm mmm aaa    aaa  ddd     ddd	  Author: Worshipper
    mmm  mmm  mmm aaaaaaaaaaa ddd     ddd	  Project Start: October 23th, 2009
    mmm       mmm aaa     aaa dddddddddd	  Version: 2.0
---mmm--------mmm-aaa-----aaa-ddddddddd---------------------------------------->
---------------------------------------------------------*/

local RecoilMul = CreateConVar ("mad_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local DamageMul = CreateConVar ("mad_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local AccuracyMul = CreateConVar ("mad_accuracymul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})

if SERVER then
	util.AddNetworkString( "HitMarker" )
end

SWEP.Category			= "T.E.A. Weapons"
SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= ""
SWEP.Instructions			= ""
SWEP.HoldType				= "pistol"
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix			= "python"
SWEP.UseHands			= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound		= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil		= 10
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 0

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ActionDelay			= CurTime()

SWEP.AlwaysSilenced			= false

SWEP.DeployDelay			= 1

SWEP.ShellEffect			= "effect_mad_shell_pistol"	-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronFireAccel		= 3
SWEP.HipFireLoss		= 1
SWEP.IronCrosshair = false

SWEP.IronSightsPos 		= Vector (0, 0, 0)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (0, 0, 5.5)
SWEP.RunArmAngle 			= Vector (-35, -3, 0)

SWEP.Burst				= false
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.05
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 1
SWEP.Mode				= false

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to semi-automatic."
SWEP.data.ModeMsg			= "Switched to automatic."
SWEP.data.Delay			= 0.5
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1
SWEP.data.Automatic		= false

SWEP.ConstantAccuracy		= false

SWEP.Penetration			= true
SWEP.Ricochet			= true
SWEP.MaxRicochet			= 1

SWEP.Tracer				= 0

SWEP.IdleDelay			= 0
SWEP.IdleApply			= false
SWEP.AllowIdleAnimation		= true
SWEP.AllowPlaybackRate		= true

SWEP.BoltActionSniper		= false
SWEP.ScopeAfterShoot		= false

SWEP.IronSightZoom 		= 1.5
SWEP.ScopeZooms			= {10}
SWEP.ScopeScale 			= 0.4

SWEP.ShotgunReloading		= false
SWEP.ShotgunFinish		= 0.5
SWEP.ShotgunBeginReload		= 0.3



function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	if SERVER then
		self:SetNPCMinBurst(30)
		self:SetNPCMaxBurst(30)
		self:SetNPCFireRate(self.Primary.Delay)
	end
end

function SWEP:Precache()
	util.PrecacheSound("weapons/clipempty_pistol.wav")
end

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "Holsted")
	self:DTVar("Bool", 1, "Ironsights")
	self:DTVar("Bool", 2, "Scope")
	self:DTVar("Bool", 3, "Mode")
end 

function SWEP:IdleAnimation(time)
	if not self.AllowIdleAnimation then return false end

	self.IdleApply = true
	self.ActionDelay = CurTime() + time
	self.IdleDelay = CurTime() + time
end

function SWEP:PrimaryAttack()
	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self:SetNextPrimaryFire(CurTime() + 0.3)
		self:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if not self:CanPrimaryAttack() then return end

	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	-- If the burst mode is activated, it's going to shoot the three bullets (or more if you're dumb and put 4 or 5 bullets for your burst mode)
	if self:GetDTBool(3) and self.Type == 3 then
		self.BurstTimer 	= CurTime()
		self.BurstCounter = self.BurstShots - 1
		self:SetNextPrimaryFire(CurTime() + 0.5)
	end

	if self.PlayFireWeaponSound then
		self:PlayFireWeaponSound()
	else
		self:EmitSound(self.Primary.Sound, 130)
	end

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
end

function SWEP:SecondaryAttack()

	if self.Owner:IsNPC() then return end

	if (self.Owner:KeyDown(IN_USE) and (self.Mode)) then
		bMode = !self:GetDTBool(3)
		self:SetMode(bMode)
		self:SetIronsights(false)

		self:SetNextPrimaryFire(CurTime() + self.data.Delay)
		self:SetNextSecondaryFire(CurTime() + self.data.Delay)

		return
	end

	if (!self.IronSightsPos) or (self.Owner:KeyDown(IN_SPEED) or self:GetDTBool(0)) then return end
	
	bIronsights = !self:GetDTBool(1)
	self:SetIronsights(bIronsights)

	self:SetNextPrimaryFire(CurTime() + 0.2)
	self:SetNextSecondaryFire(CurTime() + 0.2)
end

/*---------------------------------------------------------
   Name: SWEP:SetHolsted()
---------------------------------------------------------*/
function SWEP:SetHolsted(b)

	if (self.Owner) then
		if (b) then
			self:EmitSound("weapons/universal/iron_in.wav")
		else
			self:EmitSound("weapons/universal/iron_out.wav")
		end
	end

	if (self) then
		self:SetDTBool(0, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:SetIronsights()
---------------------------------------------------------*/
function SWEP:SetIronsights(b)

	if (self.Owner) then
		if (b) then
			if (SERVER) then
				self.Owner:SetFOV(65, 0.2)
			end

			if self.AllowIdleAnimation then
				if self:GetDTBool(3) and self.Type == 2 then
					self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_IDLE)
				end

				self.Owner:GetViewModel():SetPlaybackRate(0)
			end

			self:EmitSound("weapons/universal/iron_in.wav")
		else
			if (SERVER) then
				self.Owner:SetFOV(0, 0.2)
			end

			if self.AllowPlaybackRate and self.AllowIdleAnimation then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			end	

			self:EmitSound("weapons/universal/iron_out.wav")
		end
	end

	if (self) then
		self:SetDTBool(1, b)
	end
end

function SWEP:SetMode(b)

	if (self.Owner) then
		if (b) then
			if self.Type == 1 then
				self.Primary.Automatic = self.data.Automatic
				self:EmitSound("weapons/smg1/switch_burst.wav")
			elseif self.Type == 2 then
				self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
				self.Primary.Sound = Sound(self.Primary.SuppressorSound)

				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			elseif self.Type == 3 then
				self:EmitSound("weapons/smg1/switch_burst.wav")
			end

			if (SERVER) then
				self.Owner:PrintMessage(HUD_PRINTTALK, self.data.ModeMsg)
			end
		else
			if self.Type == 1 then
				self.Primary.Automatic = !self.data.Automatic
				self:EmitSound("weapons/smg1/switch_single.wav")
			elseif self.Type == 2 then
				self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
				self.Primary.Sound = Sound(self.Primary.NoSuppressorSound)

				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			elseif self.Type == 3 then
				self:EmitSound("weapons/smg1/switch_single.wav")
			end

			if (SERVER) then
				self.Owner:PrintMessage(HUD_PRINTTALK, self.data.NormalMsg)
			end
		end
	end

	if (self) then
		self:SetDTBool(3, b)
	end
end

function SWEP:CheckReload()
end

function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self:DefaultReload(ACT_VM_RELOAD)

	if (self:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:SetIronsights(false)
		self:ReloadAnimation()
	end
end

function SWEP:ReloadAnimation()

	if self:GetDTBool(3) and self.Type == 2 then
		self:DefaultReload(ACT_VM_RELOAD_SILENCED)
	else
		self:DefaultReload(ACT_VM_RELOAD)
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end

function SWEP:SecondThink()
end

function SWEP:Think()

	self:SecondThink()

	if self:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if self:GetDTBool(3) and self.Type == 2 then
				self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end

			if self.AllowPlaybackRate and not self:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end		
		end

		self.IdleApply = false
	elseif self:Clip1() <= 0 then
		self.IdleApply = false
	end

	if self:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end

	if self.Owner:KeyDown(IN_SPEED) or self:GetDTBool(0) then
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

function SWEP:Holster()

	return true
end

function SWEP:Deploy()

	self:DeployAnimation()

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end

	self:SetNextPrimaryFire(CurTime() + self.DeployDelay + 0.05)
	self:SetNextSecondaryFire(CurTime() + self.DeployDelay + 0.05)
	self.ActionDelay = (CurTime() + self.DeployDelay + 0.05)

	self:SetIronsights(false)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()

	// Weapon has a suppressor
	if self:GetDTBool(3) and self.Type == 2 then
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	else
		self:SendWeaponAnim(ACT_VM_DRAW)
	end
end

/*---------------------------------------------------------
   Name: SWEP:CrosshairAccuracy()
   Desc: Crosshair informations.
---------------------------------------------------------*/
SWEP.SprayTime 		= 0.1
SWEP.SprayAccuracy 	= 0.2

function SWEP:CrosshairAccuracy()

	// Is it a constant accuracy weapon or is it a NPC? The NPC doesn't need a crosshair. Fuck him!
	if (self.ConstantAccuracy) or (self.Owner:IsNPC()) then
		return 1.0
	end
	
	local LastAccuracy 	= self.LastAccuracy or 0
	local Accuracy 		= 1.0
	local LastShoot 		= self:GetNetworkedFloat("LastShootTime", 0)
	
	local Speed 		= self.Owner:GetVelocity():Length()

	local SpeedClamp = math.Clamp(math.abs(Speed / 705), 0, 1)
	
	if (CurTime() <= LastShoot + self.SprayTime) then
		Accuracy = Accuracy * self.SprayAccuracy
	end
	
	if (not self.Owner:IsOnGround()) then
		Accuracy = Accuracy * 0.1
	elseif (Speed > 10) then
		Accuracy = Accuracy * (((1 - SpeedClamp) + 0.1) / 2)
	end

	if (LastAccuracy != 0) then
		if (Accuracy > LastAccuracy) then
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * 2)
		else
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * -2)
		end
	end
	
	self.LastAccuracy = Accuracy
	return math.Clamp(Accuracy, 0.2, 1)
end


function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)

	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0

	self:ShootEffects()

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end
	
	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.Src 		= self.Owner:GetShootPos()			// Source
	bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)			// Aim Cone
	bullet.Tracer	= 1							// Show a tracer on every x bullets
	bullet.TracerName = TracerName
	bullet.Force	= damage * 0.5					// Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.Callback	= function(attacker, tr, dmginfo) 
		if not self.Owner:IsNPC() and self.Owner:GetNetworkedInt("Fuel") > 0 then
			self:ShootFire(attacker, tr, dmginfo) 
		end

		if tr.Entity:GetClass() == "prop_vehicle_prisoner_pod" then
			if SERVER then
				tr.Entity:TakeDamage(damage, self:GetOwner())
			end
		end

		if tr.Entity:IsPlayer() == true or tr.Entity:IsNPC() == true or tr.Entity.Type == "nextbot" then
			if SERVER then
				if self.Sniper == true then
					net.Start( "HitMarkerSnip" )
   					net.Send( self.Owner )
   				else
   					net.Start( "HitMarker" )
   					net.Send( self.Owner )
   				end
   			end
		end

		if self.BulletCallback then
			self.BulletCallback(attacker, tr, dmginfo)
		end

--						return self:RicochetCallback_Redirect(attacker, tr, dmginfo) 
	end

	self.Owner:FireBullets(bullet)

	-- Realistic recoil. Only on snipers and shotguns. Disable for the admin gun because if you put the max damage, you'll fly like you never fly!
	if SERVER and (self.Sniper or self.Shotgun) then
		self.Owner:SetVelocity(self.Owner:GetAimVector() * -(damage * num_bullets * 0.4))
	end

	-- Recoil
	if (not self.Owner:IsNPC()) and ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT)) then
		if ( IsFirstTimePredicted() ) then
		local eyeangle 	= self.Owner:EyeAngles()
		eyeangle.pitch 	= eyeangle.pitch - recoil
		self.Owner:SetEyeAngles(eyeangle)
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This function add the damage, the recoil, the number of shots and the cone on the bullet.
---------------------------------------------------------*/
function SWEP:ShootBulletInformation()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	local owner = self.Owner

	if self:GetDTBool(3) then
		CurrentDamage = self.Primary.Damage * self.data.Damage
		CurrentRecoil = self.Primary.Recoil * self.data.Recoil * math.max(0.4, 1 - (owner.StatGunslinger or Perks and Perks.Gunslinger or 0) * 0.03)
		CurrentCone = self.Primary.Cone * self.data.Cone
	else
		CurrentDamage = self.Primary.Damage
		CurrentRecoil = self.Primary.Recoil * math.max(0.4, 1 - (owner.StatGunslinger or Perks and Perks.Gunslinger or 0) * 0.03)
		CurrentCone = self.Primary.Cone
	end

	if owner:IsNPC() then
		self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, self.Primary.Cone)
		return
	end

	if owner:GetNetworkedInt("Fuel") > 0 then
		CurrentDamage = CurrentDamage * 1.25
	end


	if not owner:IsOnGround() then
		-- Player is aiming
		if (self:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone * self.HipFireLoss)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil), math.Rand(-1, 1) * (CurrentRecoil), 0))
			end
		-- Player is not aiming
		else
			self:ShootBullet(CurrentDamage, CurrentRecoil * 2.5, self.Primary.NumShots, CurrentCone )
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 2), math.Rand(-1, 1) * (CurrentRecoil * 2.5), 0))
			end
		end
	-- Player is moving
	elseif owner:KeyDown (bit.bor( IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT )) then
		-- Player is aiming
		if (self:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone * self.HipFireLoss)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil), math.Rand(-1, 1) * (CurrentRecoil / 1.5), 0))
			end
		-- Player is not aiming
		else
			self:ShootBullet(CurrentDamage, CurrentRecoil * 1.5, self.Primary.NumShots, CurrentCone )
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 1.5), math.Rand(-1, 1) * (CurrentRecoil * 1.5), 0))
			end
		end
	-- Player is crouching
	elseif owner:Crouching() then
		-- Player is aiming
		if (self:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, 0, self.Primary.NumShots, CurrentCone * self.HipFireLoss)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 3), 0))
			end
		-- Player is not aiming
		else
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
			end
		end
	-- Player is doing nothing
	else
		-- Player is aiming
		if (self:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone * self.HipFireLoss)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 1.5), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
			end
		-- Player is not aiming
		else
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			if ( IsFirstTimePredicted() ) then
				owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
			end
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootEffects()
   Desc: A convenience function to shoot effects.
---------------------------------------------------------*/
function SWEP:ShootEffects()
	local owner = self:GetOwner()

	if not owner:IsNPC() then
		self:ShootAnimation()
	end

	if (IsValid(owner) and owner:GetViewModel()) then
		self:IdleAnimation(owner:GetViewModel():SequenceDuration())
	end

	local WeaponModel = self:GetOwner():GetActiveWeapon():GetClass()

	if (not owner:IsNPC() and self:Clip1() < 1) then
		timer.Simple(owner:GetViewModel():SequenceDuration(), function() 
			if owner and owner:Alive() and self:GetOwner():GetActiveWeapon():GetClass() == WeaponModel then
				self.ActionDelay = CurTime()
				self:Reload()
			end
		end)
	end

	owner:MuzzleFlash()
	owner:SetAnimation(PLAYER_ATTACK1)

	local effectdata = EffectData()
		effectdata:SetOrigin(owner:GetShootPos())
		effectdata:SetEntity(self)
		effectdata:SetStart(owner:GetShootPos())
		effectdata:SetNormal(owner:GetAimVector())
		effectdata:SetAttachment(1)
		if (self.Shotgun) then
			util.Effect("effect_mad_shotgunsmoke", effectdata)
		elseif self:GetDTBool(3) and self.Type == 2 then
			util.Effect("effect_mad_gunsmoke_sil", effectdata)
		elseif self.AlwaysSilenced == true then
			util.Effect("effect_mad_gunsmoke_sil", effectdata)
			else
			util.Effect("effect_mad_gunsmoke", effectdata)
		end

	// Add a timer to solve this problem : in multiplayer, when you aim with the ironsights, tracers, effects, etc. still come from where the barrel is when you don't aim with ironsights
	/*
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
	timer.Simple(0, function()
		if not IsValid(owner) then return end
		if (not IsFirstTimePredicted() or not owner:Alive())then return end

		if (self.Shotgun) then
			util.Effect("effect_mad_shotgunsmoke", effectdata)
		else
			util.Effect("effect_mad_gunsmoke", effectdata)
		end
	end)
	end
	*/
	// Shell eject
/*
	timer.Simple(self.ShellDelay, function()
		if not owner then return end
		if not IsFirstTimePredicted() then return end
		if not owner:IsNPC() and not owner:Alive() then return end

		local effectdata = EffectData()
			effectdata:SetEntity(self)
			effectdata:SetNormal(owner:GetAimVector())
			effectdata:SetAttachment(2)
		util.Effect(self.ShellEffect, effectdata)
	end)
*/
	if owner:IsNPC() then return end

local trace = owner:GetEyeTrace()

/*
	if trace.HitPos:Distance(owner:GetShootPos()) < 250 and self.Shotgun then
		if trace.Entity:GetClass() == "prop_door_rotating" and (SERVER) then
            trace.Entity:Fire("open", "", 0.1)
			trace.Entity:Fire("unlock", "", 0.1)

			local pos = trace.Entity:GetPos()
			local ang = trace.Entity:GetAngles()
			local model = trace.Entity:GetModel()
			local skin = trace.Entity:GetSkin()

			trace.Entity:SetNotSolid(true)
			trace.Entity:SetNoDraw(true)

			local function ResetDoor(door, fakedoor)
				door:SetNotSolid(false)
				door:SetNoDraw(false)
				fakedoor:Remove()
			end

			local push =(owner:GetPos()):Normalize()
			local ent = ents.Create("prop_physics")

			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetModel(model)
			
			if(skin) then
				ent:SetSkin(skin)
			end

			ent:Spawn()
			timer.Simple( 25 , function() ResetDoor(trace.Entity, ent) end)

		end
	end
*/

	// Crosshair effect
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self:SetNetworkedFloat("LastShootTime", CurTime())
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootFire()
   Desc: Shoot fire bullets.
---------------------------------------------------------*/
function SWEP:ShootFire(attacker, tr, dmginfo)

	self.Owner:SetNetworkedInt("Fuel", math.Clamp(self.Owner:GetNetworkedInt("Fuel") - (math.random(1, 3) / self.Primary.NumShots), 0, 100))

	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetNormal(tr.HitNormal)
	effectdata:SetScale(20)
	util.Effect("effect_mad_firehit", effectdata)

	util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

	local random = (1 / self.Primary.Delay) * (self.Primary.NumShots * (self.Primary.NumShots / 4))

	if math.random(0, random) < 1 then
		if tr.Entity:GetPhysicsObject():IsValid() and not tr.Entity:IsPlayer() then
			tr.Entity:Ignite(math.random(5, 20), 0)

			local tracedata = {}
			tracedata.start = tr.HitPos
			tracedata.endpos = Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z - 10)
			tracedata.filter = tr.HitPos
			local tracedata = util.TraceLine(tracedata)

			if tracedata.HitWorld then
				local fire = ents.Create("env_fire")
				fire:SetPos(tr.HitPos)
				fire:SetKeyValue("health", math.random(5, 15))
				fire:SetKeyValue("firesize", "8")
				fire:SetKeyValue("fireattack", "10")
				fire:SetKeyValue("damagescale", "1.0")
				fire:SetKeyValue("StartDisabled", "0")
				fire:SetKeyValue("firetype", "0")
				fire:SetKeyValue("spawnflags", "128")
				fire:Spawn()
				fire:Fire("StartFire", "", 0)
			end
		end
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	local AllowDryFire = self.Owner:GetActiveWeapon():GetClass() == ("weapon_mad_deagle") 
				   or self.Owner:GetActiveWeapon():GetClass() == ("weapon_mad_usp") 
				   or self.Owner:GetActiveWeapon():GetClass() == ("weapon_mad_usp_match")

	if (self:Clip1() <= 0) then
		if (AllowDryFire) then
			if self:GetDTBool(3) and self.Type == 2 then
				self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)	
			else
				self:SendWeaponAnim(ACT_VM_DRYFIRE)
			end
		elseif self:GetDTBool(3) and self.Type == 2 then
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
		else
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			if self:GetDTBool(1) then
			self.Owner:GetViewModel():SetPlaybackRate(self.IronFireAccel)
			else
			self.Owner:GetViewModel():SetPlaybackRate(1)
			end 
		end
	else
		if self:GetDTBool(3) and self.Type == 2 then
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
		else
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			if self:GetDTBool(1) then
			self.Owner:GetViewModel():SetPlaybackRate(self.IronFireAccel)
			else
			self.Owner:GetViewModel():SetPlaybackRate(1)
			end 
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootBullet()
   Desc: A convenience function to shoot bullets.
---------------------------------------------------------*/
local TracerName = "Tracer"

/*---------------------------------------------------------
   Name: SWEP:BulletPenetrate()
---------------------------------------------------------*/
function SWEP:BulletPenetrate(bouncenum, attacker, tr, dmginfo, isplayer)

	if (CLIENT) then return end

	local MaxPenetration

	if self.Primary.Ammo == "AirboatGun" then // 5.56MM Ammo
		MaxPenetration = 18
	elseif self.Primary.Ammo == "Gravity" then // 4.6MM Ammo
		MaxPenetration = 8
	elseif self.Primary.Ammo == "AlyxGun" then // 5.7MM Ammo
		MaxPenetration = 12
	elseif self.Primary.Ammo == "Battery" then // 9MM Ammo
		MaxPenetration = 18
	elseif self.Primary.Ammo == "StriderMinigun" then // 7.62MM Ammo
		MaxPenetration = 20
	elseif self.Primary.Ammo == "SniperPenetratedRound" then // .45 Ammo
		MaxPenetration = 16
    elseif self.Primary.Ammo == "ammo_50" then // .50 Ammo
		MaxPenetration = 20
	elseif self.Primary.Ammo == "ammo_556X45" then // 5.56
		MaxPenetration = 21
	elseif self.Primary.Ammo == "ammo_338" then // .338 ammo
		MaxPenetration = 45
	elseif self.Primary.Ammo == "ammo_556X39" then // 
		MaxPenetration = 17
	elseif self.Primary.Ammo == "ammo_300" then // 
		MaxPenetration = 42
	elseif self.Primary.Ammo == "ammo_127" then // 
		MaxPenetration = 18
	elseif self.Primary.Ammo == "ammo_slug" then // 
		MaxPenetration = 12
	elseif self.Primary.Ammo == "Buckshot" then // 
		MaxPenetration = 10
	elseif self.Primary.Ammo == "ammo_45" then // .45 Ammo
		MaxPenetration = 15
	elseif self.Primary.Ammo == "ammo_762" then // 7.62MM Ammo
		MaxPenetration = 24
	else
		MaxPenetration = 16
	end

	local DoDefaultEffect = true
	// Don't go through metal, sand or player
	if ((tr.MatType == MAT_METAL and self.Ricochet) or (tr.MatType == MAT_SAND) or (tr.Entity:IsPlayer() or tr.Entity:IsNPC() == true or tr.Entity.Type == "nextbot")  ) then return false end

	if tr.Entity:IsValid() and tr.Entity:GetModel() == "models/arleitiss/riotshield/shield.mdl" then return false end

	// Don't go through more than 3 times
	if (bouncenum > 3) then return false end
	
	// Direction (and length) that we are going to penetrate
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
		
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + PenetrationDirection
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	// Bullet didn't penetrate.
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
	// Damage multiplier depending on surface
	local fDamageMulti = 0.5
	
	if (tr.MatType == MAT_CONCRETE) then
		fDamageMulti = 0.3
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_GLASS) then
		fDamageMulti = 0.8
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 0.9
	end
		
	// Fire bullet from the exit point using the original trajectory
	local bullet = 
	{	
		Num 		= 1,
		Src 		= trace.HitPos,
		Dir 		= tr.Normal,	
		Spread 	= Vector(0, 0, 0),
		Tracer	= 1,
		TracerName 	= "effect_mad_penetration_trace",
		Force		= 5,
		Damage	= (dmginfo:GetDamage() * fDamageMulti),
		HullSize	= 2
	}
	
--	bullet.Callback   = function(a, b, c) if (self.Ricochet) then return self:RicochetCallback(bouncenum + 1, a, b, c) end end
	
	timer.Simple(0.05, function()
		if not IsFirstTimePredicted() then return end
		attacker.FireBullets(attacker, bullet, true)
	end)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:RicochetCallback()
---------------------------------------------------------*/
function SWEP:RicochetCallback(bouncenum, attacker, tr, dmginfo)

return false -- ricochet is disabled in ZW cos its an unnecessary waste of processor power

/*

	if (CLIENT) then return end

	if (not self) then return end

	local DoDefaultEffect = true
	if (tr.HitSky) then return end
	
	// Can we go through whatever we hit?
	if (self.Penetration) and (self:BulletPenetrate(bouncenum, attacker, tr, dmginfo)) then
		return {damage = true, effects = DoDefaultEffect}
	end
	
	// Your screen will shake and you'll hear the savage hiss of an approaching bullet which passing if someone is shooting at you.
	if (tr.MatType != MAT_METAL) then
		if (SERVER) then
			util.ScreenShake(tr.HitPos, 5, 0.1, 0.5, 64)
			sound.Play("Bullets.DefaultNearmiss", tr.HitPos, 250, math.random(110, 180))
		end

		if self.Tracer == 1 or self.Tracer == 2 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("AR2Impact", effectdata)
		elseif self.Tracer == 3 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("StunstickImpact", effectdata)
		end

		return 
	end

	if (self.Ricochet == false) then return {damage = true, effects = DoDefaultEffect} end
	
	if (bouncenum > self.MaxRicochet) then return end
	
	// Bounce vector
	local trace = {}
	trace.start = tr.HitPos
	trace.endpos = trace.start + (tr.HitNormal * 16384)

	local trace = util.TraceLine(trace)

 	local DotProduct = tr.HitNormal:Dot(tr.Normal * -1) 
	
	local bullet = 
	{	
		Num 		= 1,
		Src 		= tr.HitPos + (tr.HitNormal * 5),
		Dir 		= ((2 * tr.HitNormal * DotProduct) + tr.Normal) + (VectorRand() * 0.05),
		Spread 	= Vector(0, 0, 0),
		Tracer	= 1,
		TracerName 	= "effect_mad_ricochet_trace",
		Force		= dmginfo:GetDamage() * 0.25,
		Damage	= dmginfo:GetDamage() * 0.5,
		HullSize	= 2
	}
		
	// Added conditional to stop errors when bullets ricochet after weapon switch
	bullet.Callback  	= function(a, b, c) if (self.Ricochet) then return self:RicochetCallback(bouncenum + 1, a, b, c) end end

	timer.Simple(0.05, function()
		if not IsFirstTimePredicted() then return end
		attacker.FireBullets(attacker, bullet, true)
	end)
	
	return {damage = true, effects = DoDefaultEffect}
	*/
end

/*---------------------------------------------------------
   Name: SWEP:RicochetCallback_Redirect()
---------------------------------------------------------*/
function SWEP:RicochetCallback_Redirect(a, b, c)
 return false
--	return self:RicochetCallback(0, a, b, c) 
end

/*---------------------------------------------------------
   Name: SWEP:CanPrimaryAttack()
   Desc: Helper function for checking for no ammo.
---------------------------------------------------------*/
function SWEP:CanPrimaryAttack()

	// Clip is empty or you're under water
	if (self:Clip1() <= 0) or (self.Owner:WaterLevel() > 2) then
		self:SetNextPrimaryFire(CurTime() + 0.5)
//		self:EmitSound("Default.ClipEmpty_Pistol")
		return false
	end

	// You're sprinting or your weapon is holsted
	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self:SetNextPrimaryFire(CurTime() + 0.5)
		return false
	end

	return true
end

/*---------------------------------------------------------
   Name: SWEP:CanSecondaryAttack()
   Desc: Helper function for checking for no ammo.
---------------------------------------------------------*/
function SWEP:CanSecondaryAttack()

	// Clip is empty or you're under water
	if (self:Clip2() <= 0) then
		self:SetNextSecondaryFire(CurTime() + 0.5)
//		self:EmitSound("Default.ClipEmpty_Pistol")
		return false
	end

	// You're sprinting or your weapon is holsted
	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self:SetNextSecondaryFire(CurTime() + 0.5)
		return false
	end

	return true
end