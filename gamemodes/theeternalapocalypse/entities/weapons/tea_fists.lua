
AddCSLuaFile()

SWEP.PrintName	= "Hands"

SWEP.Author		= "Uklejamini"
SWEP.Purpose	= "Use right click to pick up some stuff up and left click to attack\nHold E and attack to switch fire modes"

SWEP.DrawCrosshair	= false
SWEP.Spawnable	= true
SWEP.UseHands	= true
SWEP.DrawAmmo	= false

SWEP.ViewModel	= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel	= ""

SWEP.ViewModelFOV	= 58
SWEP.Slot			= 0
SWEP.SlotPos		= 0

SWEP.Primary.Damage			= 12
SWEP.Primary.CritDamage		= 29
SWEP.Primary.Delay			= 0.45
SWEP.Primary.Recoil			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

local SwingSound = Sound("weapons/slam/throw.wav")
local HitSound = Sound("Flesh.ImpactHard")

SWEP.PassiveMode = false

function SWEP:Initialize()
	self:SetHoldType( "fist" )

end

function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end

SWEP.HitDistance = 48

function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )
	
end

function SWEP:PrimaryAttack()
	local ct = CurTime()
	local owner = self:GetOwner()

	if owner:KeyDown(IN_USE) then
		self:SetNextPrimaryFire( ct + 0.8 )
		self:SetNextSecondaryFire( ct + 0.8 )
		if ( IsFirstTimePredicted() ) then
			self.PassiveMode = !self.PassiveMode
		end

	else
		if self.PassiveMode then return false end

	owner:SetAnimation( PLAYER_ATTACK1 )

	local anim = "fists_right" 

	if math.random(1,2) == 1 then
	anim = "fists_left"
	end

	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
		self:SetNextPrimaryFire( ct + 0.85 )
		self:SetNextSecondaryFire( ct + 0.85 )
		if (SERVER) then
			owner.Stamina = math.Clamp(owner.Stamina - math.Rand(0.1, 0.3), 0, 100)
		timer.Simple(0.15, function()
			if !self:IsValid() then return end
			owner.Stamina = math.Clamp(owner.Stamina - math.Rand(0.7, 2.5), 0, 100)
		end)
		end
	else
		self:SetNextPrimaryFire( ct + self.Primary.Delay )
		self:SetNextSecondaryFire( ct + self.Primary.Delay )
		if (SERVER) then
			owner.Stamina = math.Clamp(owner.Stamina - math.Rand(0.14, 0.4), 0, 100)
		timer.Simple(0.15, function()
			if !self:IsValid() then return end
			owner.Stamina = math.Clamp(owner.Stamina - math.Rand(0.4, 1.1), 0, 100)
		end)
		end
	end

	owner:ViewPunch( Angle(math.random(0.5, 1.5), math.random(0.5, 1.5), math.random(0.5, 1.5)) )

	local vm = owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingSound )


	self:UpdateNextIdle()
	self:SetNextMeleeAttack( ct + 0.15 )

end

end


function SWEP:CanCarry(entity)
	local physicsObject = entity:GetPhysicsObject()

	if (!IsValid(physicsObject)) then
		return false
	end

	if (physicsObject:GetMass() > 150 or !physicsObject:IsMoveable()) then
		return false
	end

	if (IsValid(entity.carrier)) then
		return false
	end

	return true
end

function SWEP:DoPickup(entity)
	local owner = self:GetOwner()
	if (entity:IsPlayerHolding()) then
		return
	end

	timer.Simple(FrameTime() * 8, function()
		if (!IsValid(entity) or entity:IsPlayerHolding()) then
			return
		end


		owner:PickupObject(entity)
		owner:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 3)..".wav", 75)
	end)

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire(CurTime() + 1)
end


function SWEP:SecondaryAttack()
	if !IsFirstTimePredicted() then
		return
	end
	local owner = self:GetOwner()
	local trace = owner:GetEyeTraceNoCursor()
	local entity = trace.Entity

	if SERVER and IsValid(entity) then
		local distance = owner:EyePos():DistToSqr(trace.HitPos)

		if (distance > 8100) then return end -- 90^2

		if !entity:IsPlayer() and !entity:IsNPC() and self:CanCarry(entity) then
			local phys = entity:GetPhysicsObject()
			phys:Wake()
			self:DoPickup(entity)
			self:SetNextSecondaryFire(CurTime() + 0.5)
		else
			if !entity:IsPlayer() and !entity:IsNPC() then
				owner:SendChat("I can't pick this up!")
			end
			self:SetNextSecondaryFire(CurTime() + 0.5)
		end
	end
end


function SWEP:DealDamage()
	local owner = self:GetOwner()
	local anim = self:GetSequenceName(owner:GetViewModel():GetSequence())

	owner:LagCompensation( true )
	
	local tr = util.TraceLine( {
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
		filter = owner
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
			filter = owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 )
		} )
	end

	-- We need the second part for single player because SWEP:Think is ran shared in SP.
	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	local hit = false

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
	
		local attacker = owner
		if !IsValid(attacker) then attacker = self end
		dmginfo:SetAttacker(attacker)

		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(self.Primary.Damage)
		dmginfo:SetDamageType(DMG_CLUB)

		if anim == "fists_left" then
			dmginfo:SetDamageForce( owner:GetRight() * 4912 + owner:GetForward() * 9998 ) -- Yes we need those specific numbers
		elseif anim == "fists_right" then
			dmginfo:SetDamageForce( owner:GetRight() * -4912 + owner:GetForward() * 9989 )
		elseif anim == "fists_uppercut" then
			dmginfo:SetDamageForce( owner:GetUp() * 5158 + owner:GetForward() * 10012 )
			dmginfo:SetDamage( self.Primary.CritDamage )
		end

		tr.Entity:TakeDamageInfo( dmginfo )
		hit = true

	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	owner:LagCompensation( false )

end

function SWEP:OnRemove()
	
	if ( IsValid( self.Owner ) ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	end
	
end

function SWEP:Holster( wep )
	self:OnRemove()

	return true

end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
	
	self:UpdateNextIdle()
	
	if SERVER then
		self:SetCombo( 0 )
	end

	self:SetNextPrimaryFire(CurTime() + 0.5)
	
	return true

end

function SWEP:Think()
	
	local vm = self.Owner:GetViewModel()
	local ct = CurTime()
	local idletime = self:GetNextIdle()

	if self.PassiveMode == true then self:SetHoldType( "normal" ) else self:SetHoldType( "fist" ) end
	
	if ( idletime > 0 && ct > idletime ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
		
		self:UpdateNextIdle()

	end
	
	local meleetime = self:GetNextMeleeAttack()
	
	if ( meleetime > 0 && ct > meleetime ) then

		self:DealDamage()
		
		self:SetNextMeleeAttack( 0 )

	end


	if ( SERVER && ct > self:GetNextPrimaryFire() + 0.27 + (0.07 * self:GetCombo()) ) and self:GetCombo() > 0 then

		if self:GetCombo() >= 1 then
		self:SetCombo( 0 )
		end
	end
end

function SWEP:DrawHUD()

	if not (LocalPlayer():InVehicle()) then
	surface.DrawCircle( ScrW() /2 -17, ScrH() /2 -16, 3, Color(50, 50, 50, 45) )
	surface.DrawCircle( ScrW() /2 +16, ScrH() /2 -16, 3, Color(50, 50, 50, 45) )

	surface.DrawCircle( ScrW() /2 -17, ScrH() /2 +16, 3, Color(50, 50, 50, 45) )
	surface.DrawCircle( ScrW() /2 +16, ScrH() /2 +16, 3, Color(50, 50, 50, 45) )

--	surface.DrawCircle( ScrW() /2 -1, ScrH() /2, 16, Color(50, 50, 50, 55) )

--	surface.SetDrawColor(155, 155, 155, 155)

--	surface.DrawLine(ScrW() /2 + 7, ScrH() /2 -12, ScrW() /2 -9, ScrH() /2 -12) -- top
--	surface.DrawLine(ScrW() /2 + 7, ScrH() /2 +12, ScrW() /2 -9, ScrH() /2 +12) -- bottom

--	surface.DrawCircle( ScrW() /2, ScrH() /2, 12, Color(200, 200, 250, 255) )
--	surface.DrawCircle( ScrW() /2, ScrH() /2, 14, Color(50, 50, 50, 255) )
end
end

function SWEP:GetViewModelPosition( pos, ang )
 	if self.PassiveMode then
	ang:RotateAroundAxis( ang:Right(), -16 )
	end
 
	return pos, ang
 
end