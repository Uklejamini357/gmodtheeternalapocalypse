AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local RocketSound = Sound("Missile.Accelerate")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity:GetOwner()

	if !IsValid(self.Owner) then
		self:Remove()
		return
	end

	local trail = util.SpriteTrail(self.Entity, 0, Color(155,155,155), false, 6, 70, 2, 1/(15+1)*0.5, "trails/smoke.vmt")
 
	self.Entity:SetModel("models/weapons/w_missile_closed.mdl")
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)   
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.SpawnTime = CurTime()
 
	self.PhysObj = self.Entity:GetPhysicsObject()

	if (self.PhysObj:IsValid()) then
		self.PhysObj:EnableGravity(false)
		self.PhysObj:EnableDrag(false) 
		self.PhysObj:SetMass(30)
        	self.PhysObj:Wake()
	end
		
	self.Entity:EmitSound(RocketSound)
	util.PrecacheSound("explode_4")

	self.TimeLeft = CurTime() + 5
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	local phys 		= self.Entity:GetPhysicsObject()
	local ang 		= self.Entity:GetForward() * 18500
	local upang
	local rightang

	upang 	= self.Entity:GetUp() * math.Rand(500, 2000) * (math.sin(CurTime() * math.Rand(500, 1000)))
	rightang 	= self.Entity:GetRight() * math.Rand(500, 2000) * (math.cos(CurTime() * math.Rand(500, 1000)))

	local force

	if self.Entity:WaterLevel() > 0 or self.TimeLeft < CurTime() then
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		self.Entity:StopSound(RocketSound)
	else
		if self.SpawnTime + 0.75 < CurTime() then
			force = ang + upang + rightang
		else
			force = ang
		end

		phys:ApplyForceCenter(force)
	end
end

/*---------------------------------------------------------
   Name: ENT:Explosion()
---------------------------------------------------------*/
function ENT:Explosion()

	local trace = {}
	trace.start = self.Entity:GetPos() + Vector(0, 0, 32)
	trace.endpos = self.Entity:GetPos() - Vector(0, 0, 128)
	trace.Entity = self.Entity
	trace.mask  = 16395
	local Normal = util.TraceLine(trace).HitNormal

	self.Scale = 2
	self.EffectScale = self.Scale ^ 0.65
	
	-- util.BlastDamage(self.ShotFromWeapon, self.Owner, self:GetPos(), self.ExplosionRadius, self.ExplosionDamage)
	local explo = ents.Create("env_explosion")
	explo:SetOwner(self.Owner)
	explo:SetPos(self.Entity:GetPos())
	explo:SetKeyValue("iMagnitude", self.ExplosionDamage or 0)
	explo:SetKeyValue("iRadiusOverride", self.ExplosionRadius or 0)
	explo:Spawn()
	explo:Activate()
	explo:Fire("Explode", "", 0)

/*	-- thanks rain bob for pointing this out, this one is excluded and other one is added
	local shake = ents.Create("env_shake")
	shake:SetOwner(self.Owner)
	shake:SetPos(self.Entity:GetPos())
	shake:SetKeyValue("amplitude", "2000")	// Power of the shake
	shake:SetKeyValue("radius", "900")		// Radius of the shake
	shake:SetKeyValue("duration", "2")	// Time of shake
	shake:SetKeyValue("frequency", "255")	// How har should the screenshake be
	shake:SetKeyValue("spawnflags", "4")	// Spawnflags(In Air)
	shake:Spawn()
	shake:Activate()
	shake:Fire("StartShake", "", 0)
	shake:Fire("Kill", "", 0.5)
*/
	util.ScreenShake( self:GetPos(), 2000, 255, 2.5, 900, true )


	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	/*
	local ar2Explo = ents.Create("env_ar2explosion")
		ar2Explo:SetOwner(self.Owner)
		ar2Explo:SetPos(self.Entity:GetPos())
		ar2Explo:Spawn()
		ar2Explo:Activate()
		ar2Explo:Fire("Explode", "", 0)
	*/

end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj) 

	util.Decal("Scorch", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal) 

	if not self.Exploded then
		self:Explosion()
		self.Exploded = true -- bug?

		local ent = data.HitEntity
		if ent:IsValid() then
			local dmg = DamageInfo()
			dmg:SetDamage(1000)
			dmg:SetDamageType(DMG_BLAST)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.ShotFromWeapon or self)
			dmg:SetDamagePosition(self:GetPos())
			ent:TakeDamageInfo(dmg)
		end
	end

	self.Entity:Remove()
end

/*---------------------------------------------------------
   Name: ENT:OnRemove()
---------------------------------------------------------*/
function ENT:OnRemove()

	self.Entity:StopSound(RocketSound)
end

