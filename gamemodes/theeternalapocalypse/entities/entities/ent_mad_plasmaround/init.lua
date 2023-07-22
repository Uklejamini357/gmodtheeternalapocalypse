AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity:GetOwner()
	self.Power = 50

	if !IsValid(self.Owner) then
		self:Remove()
		return
	end

	self.Entity:SetModel("models/items/ar2_grenade.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Timer = CurTime() + 0.075
	self.Explode = true

	util.SpriteTrail(self.Entity, 0, Color(128, 255, 255, 255), false, 30, 0, 0.5, 1 / ((30 + 0) * 0.5), "trails/laser.vmt")
//	util.SpriteTrail(self.Entity, 0, Color(155, 155, 155, 155), false, 2, 10, 5, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.Power < 220 then
		self.Power = self.Power + 5
	end

	if self.Timer < CurTime() then
		self.Explode = true
		self.Timer = CurTime() + 100
	end

	if self.Entity:WaterLevel() > 2 then
		self:Explosion()
		self.Entity:Remove()
	end

	local energyball = ents.Create("env_citadel_energy_core")
	energyball:SetPos(self.Entity:GetPos())
	energyball:SetKeyValue("scale", 8)
	energyball:Spawn()
	energyball:Activate()
	energyball:SetParent(self.Entity)
	energyball:Fire("StartCharge", "2", 0)
end

/*---------------------------------------------------------
   Name: ENT:Explosion()
---------------------------------------------------------*/
function ENT:Explosion()
/*
	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
*/
/*
	local explo = ents.Create("env_explosion")
		explo:SetOwner(self.Owner)
		explo:SetPos(self.Entity:GetPos())
		explo:SetKeyValue("iMagnitude", self.Power)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode", "", 0)
*/
	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetScale(self.Power / 10)
	util.Effect("effect_mad_plasmabomb", effectdata)

	local position = self.Entity:GetPos()
	local damage = self.Power
	local radius = self.Power * 2.75
	local attacker = self.Owner
	local inflictor = self.Entity
 
util.BlastDamage(inflictor, attacker, position, radius, damage)

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetScale((self.Power / 50))
		effectdata:SetRadius((self.Power / 50))
		effectdata:SetMagnitude((self.Power / 10))
	util.Effect("Sparks", effectdata)
	
	local shake = ents.Create("env_shake")
		shake:SetOwner(self.Owner)
		shake:SetPos(self.Entity:GetPos())
		local amp = self.Power /2
		local rad = self.Power * 4
		local dur = self.Power / 80
		shake:SetKeyValue("amplitude", amp)	// Power of the shake
		shake:SetKeyValue("radius", rad)		// Radius of the shake
		shake:SetKeyValue("duration", dur)	// Time of shake
		shake:SetKeyValue("frequency", "255")	// How har should the screenshake be
		shake:SetKeyValue("spawnflags", "4")	// Spawnflags(In Air)
		shake:Spawn()
		shake:Activate()
		shake:Fire("StartShake", "", 0)
/*
	local en = ents.FindInSphere(self.Entity:GetPos(), 100)

	for k, v in pairs(en) do
		if (v:GetPhysicsObject():IsValid()) then
			// Unweld and unfreeze props
			if (math.random(1, 100) < 10) then
				v:Fire("enablemotion", "", 0)
				constraint.RemoveAll(v)
			end
		end
	end
end
*/
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj)

	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("Grenade.ImpactHard"))
	end

	if not self.Explode then 
		self.Entity:Fire("kill", "", 5)
		self.Entity:SetNWBool("Explode", true)
		self.Timer = CurTime() + 100
		self.Explode = false
		return 
	end

	self.Explode = false

	util.Decal("Scorch", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal) 

	self:Explosion()
	self.Entity:EmitSound("ambient/energy/weld1.wav", 80, 125)
	self.Entity:EmitSound("ambient/energy/ion_cannon_shot2.wav", 90, 75)
	self.Entity:Remove()
end