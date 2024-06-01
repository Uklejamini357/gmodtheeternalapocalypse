SWEP.Base 				= "weapon_tea_base_melee"
SWEP.Instructions   =	 "LMB to attack, RMB to stab"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_ct.mdl"
SWEP.ViewModelFOV 		= 70
SWEP.BobScale 			= 2
SWEP.HoldType			= "knife"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ZW Weapons"

SWEP.Author				= ""
SWEP.Contact			= ""

SWEP.Purpose			= "A combat knife that can save your ass if you run out of ammo"
SWEP.Instructions			= "Left click to slice, Right click to stab"

SWEP.HitDistance = 48
SWEP.StaminaNeeded = 1.65
SWEP.StaminaNeeded2 = 2.55 -- for stab

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 19
SWEP.Primary.CritDamage = 30
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.6

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay 		= 0.9


SWEP.ShellEffect			= "none"				-- "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.RunArmOffset 		= Vector (0.3671, 0.1571, 5.7856)
SWEP.RunArmAngle	 		= Vector (-37.4833, 2.7476, 0)

SWEP.Sequence			= 0





/*---------------------------------------------------------
   Name: SWEP:Precache()
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/knife/knife_slash1.wav")
    	util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
    	util.PrecacheSound("weapons/knife/knife_deploy1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit2.wav")
    	util.PrecacheSound("weapons/knife/knife_hit3.wav")
    	util.PrecacheSound("weapons/knife/knife_hit4.wav")
    	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
end

/*---------------------------------------------------------
   Name: SWEP:Deploy()
---------------------------------------------------------*/
function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	self.Weapon:EmitSound("weapons/knife/knife_deploy1.wav", 50, 100)

	self:IdleAnimation(1)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntsInSphereBack(pos, range)

	local ents = ents.FindInSphere(pos, range)

	for k, v in pairs(ents) do
		if v ~= self and v ~= self.Owner and (v:IsNPC() or v:IsPlayer()) and IsValid(v) and self:EntityFaceBack(v) then
			return true
		end
	end

	return false
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntityFaceBack(ent)

	local angle = self.Owner:GetAngles().y - ent:GetAngles().y

	if angle < -180 then angle = 360 + angle end
	if angle <= 90 and angle >= -90 then return true end

	return false
end

function SWEP:PrimaryAttack()

	if self.Weapon:GetNetworkedBool("Holsted") or self.Owner:KeyDown(IN_SPEED) then return end

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end
	
	if ((CLIENT and MyStamina < self.StaminaNeeded) or (SERVER and self.Owner.Stamina < self.StaminaNeeded)) then return end

	self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	local Animation = self.Owner:GetViewModel()
	Animation:SetSequence(Animation:LookupSequence("midslash" .. math.random(1, 2)))


	self:SetHoldType("knife")
--	timer.Simple(1, function() if self:IsValid() then self:SetHoldType("normal") end end)

	timer.Simple( 0.1, function()
	if (!IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self || CLIENT) then return end
		self:DealDamage( anim )
		self.Owner.Stamina = math.Clamp(self.Owner.Stamina - self.StaminaNeeded, 0, 100)
		self.Owner:EmitSound( "weapons/slam/throw.wav" )
	end )

	timer.Simple( 0.02, function()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	self.Owner:ViewPunch( Angle(-0.1, -0.3, 0.5) )
	end )

	timer.Simple( 0.2, function()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	self.Owner:ViewPunch( Angle( math.Rand(0.2,0.5), 0.5, -0.5 ) )
	end )

	if self.Weapon:GetNetworkedBool("Holsted") then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation(PLAYER_ATTACK1)



	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end

	self:IdleAnimation(1)
end

function SWEP:SecondaryAttack()
	if self.Weapon:GetNetworkedBool("Holsted") or self.Owner:KeyDown(IN_SPEED) or ((CLIENT and MyStamina < self.StaminaNeeded2) or (SERVER and self.Owner.Stamina < self.StaminaNeeded2)) then return end

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	local Animation = self.Owner:GetViewModel()
	Animation:SetSequence(Animation:LookupSequence("stab"))


	self:SetHoldType("knife")
--	timer.Simple(1, function() if self:IsValid() then self:SetHoldType("normal") end end)

	timer.Simple( 0.1, function()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self || CLIENT ) then return end
		self:DealDamage( anim )
		self.Owner.Stamina = math.Clamp(self.Owner.Stamina - self.StaminaNeeded2, 0, 100)
		self.Owner:EmitSound( "weapons/slam/throw.wav" )
	end )

	timer.Simple( 0.02, function()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	self.Owner:ViewPunch( Angle(-0.3, -0.3, 0.5) )
	end )

	timer.Simple( 0.2, function()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	self.Owner:ViewPunch( Angle( math.Rand(0.5,1.5), 0.5, -0.5 ) )
	end )

	if self.Weapon:GetNetworkedBool("Holsted") then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self.Owner:SetAnimation(PLAYER_ATTACK1)



	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end

	self:IdleAnimation(1)
end

function SWEP:DealDamage( anim )
	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 )
		} )
	end

	if ( tr.Hit ) then
	if (tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity.Type == "nextbot") then 

		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetStart(tr.HitPos)
		util.Effect("BloodImpact", effectdata)

		if ( anim == "stab" ) then
		self.Weapon:EmitSound("weapons/knife/knife_stab.wav", 80, 120)
		else
		self.Weapon:EmitSound("weapons/knife/knife_hit"..math.random(1,4)..".wav", 80, 100)
		end
	else
	self.Weapon:EmitSound( "weapons/knife/knife_hitwall1.wav", 70, math.Rand(85, 95) )
	end
--	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)

	end


	if ( IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity.Type == "nextbot" ||tr.Entity:GetClass() == "prop_physics" || tr.Entity:GetClass() == "func_breakable" || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		if anim == "stab" then
			dmginfo:SetDamage(self.Primary.CritDamage)
		else
			dmginfo:SetDamage(self.Primary.Damage)
		end
		dmginfo:SetDamageForce( self.Owner:GetRight() * 300 + self.Owner:GetForward() * 200 ) -- Yes we need those specific numbers
		dmginfo:SetInflictor( self )
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		tr.Entity:TakeDamageInfo( dmginfo )
	end
end