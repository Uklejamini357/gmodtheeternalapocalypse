AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Owner = self:GetOwner()

	if !IsValid(self.Owner) then
		self:Remove()
		return
	end

	self:SetModel("models/crossbow_bolt.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	
//	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false) 
		phys:SetMass(2)
        	phys:Wake()
--		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
--		phys:AddGameFlag(FVPHYSICS_NO_NPC_IMPACT_DMG)
--		phys:AddGameFlag(FVPHYSICS_PENETRATING)
	end

	self.Moving = true
	util.SpriteTrail(self, 0, Color(255, 105, 55, 55), false, 0.5, 1, 0.2, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()
/*
local zed = ents.FindInSphere(self:GetPos(), 40)
if self.Moving then
	for k, v in pairs(zed) do
		if v.Type == "nextbot" then 
		self:EmitSound("Weapon_Crossbow.BoltHitBody")

		info = DamageInfo()
		info:SetAttacker(self.Owner)
		info:SetInflictor(self)
		info:SetDamageType (DMG_GENERIC)
		info:SetDamage(130)
		info:SetMaxDamage(130)
		info:SetDamageForce(Vector(0,0,0))

		v:TakeDamageInfo(info)
		self:Remove()
		end	
	end
end
*/
	local phys 		= self:GetPhysicsObject()
	local ang 		= self:GetForward() * 100000
	local up		= self:GetUp() * -800

	local force		= ang + up

	phys:ApplyForceCenter(force)

	tr = {}
		tr.start = self:GetPos()
		tr.filter = {self, self.Owner}
		tr.endpos = self:GetAngles():Forward() * 500
	tr = util.TraceLine(tr)


	if (self.HitWeld) then  
		self.HitWeld = false  
		constraint.Weld(self.HitEnt, self, 0, 0, 0, true)  
	end 
end

/*---------------------------------------------------------
   Name: ENT:Impact()
---------------------------------------------------------*/

function ENT:Impact(sent, normal, pos)

	if not IsValid(self) then
		return
	end

	local tr, info

	tr = {}
		tr.start = self:GetPos()
		tr.filter = {self, self.Owner}
		tr.endpos = pos
	tr = util.TraceLine(tr)

	if tr.HitSky then self:Remove() return end

	bullet = {}
	bullet.Num    = 1
	bullet.Src    = pos
	bullet.Dir    = normal
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 0
	bullet.Damage = 0
	self:FireBullets(bullet)

	if not sent:IsPlayer() and not sent:IsNPC() and not sent.Type == "nextbot" then
		local effectdata = EffectData()
			effectdata:SetOrigin(pos - normal * 10)
			effectdata:SetEntity(self)
			effectdata:SetStart(pos)
			effectdata:SetNormal(normal)
		util.Effect("effect_mad_shotgunsmoke", effectdata)

	end


	if IsValid(sent) then
		info = DamageInfo()
			info:SetAttacker(self.Owner)
			info:SetInflictor(self.ShotFrom and self.ShotFrom:IsValid() and self.ShotFrom or self)
			info:SetDamageType(DMG_NEVERGIB)
			info:SetDamage(self.BoltDamage or 60)
			info:SetMaxDamage(self.BoltDamage or 60)
			info:SetDamageForce(tr.HitNormal * 10)

		self:EmitSound("Weapon_Crossbow.BoltHitBody")
		sent:TakeDamageInfo(info)

		if self.Deadly then
			self:Explosion()
		end
		self:Remove()
		return
	end
	
	self:EmitSound("Weapon_Crossbow.BoltHitWorld")

	self:SetPos(pos - normal * 10)
	self:SetAngles(normal:Angle())

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(0.2)
	effectdata:SetRadius(3)
	effectdata:SetMagnitude(0.15)
	util.Effect("Sparks", effectdata)

	effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetEntity(self)
	util.Effect("effect_zw_flare_glow", effectdata)

	if self.Deadly then
		self:Explosion()
	else
		timer.Simple(2, function() if self:IsValid() then self:Explosion() end end)
	end
	
	if not IsValid(sent) then
		self:GetPhysicsObject():EnableMotion(false)
	end

--	self:Fire("kill", "", 10)
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)

	if self.Moving then
		self.Moving = false
		phys:Sleep()
		self:Impact(data.HitEntity, data.HitNormal, data.HitPos)
	end
end


function ENT:Explosion()
	
	util.BlastDamage(self.ShotFrom and self.ShotFrom:IsValid() and self.ShotFrom or self, self.Owner, self:GetPos(), self.ExplosionRadius, self.ExplosionDamage)

	local explo = ents.Create("env_explosion")
	explo:SetOwner(self.Owner)
	explo:SetPos(self:GetPos())
	explo:SetKeyValue("iMagnitude", 0)
	explo:Spawn()
	explo:Activate()
	explo:Fire("Explode", "", 0)

	self:Remove()
end