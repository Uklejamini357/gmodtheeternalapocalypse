// I took a look on Kogitsune's wiretrap code
// I took the .phy of the crossbow_bolt made by Silver Spirit

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity:GetOwner()

	if !IsValid(self.Owner) then
		self:Remove()
		return
	end

	self.Entity:SetModel("models/crossbow_bolt.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
//	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
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
	util.SpriteTrail(self.Entity, 0, Color(255, 105, 55, 55), false, 0.5, 1, 0.2, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
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
		self.Entity:EmitSound("Weapon_Crossbow.BoltHitBody")

		info = DamageInfo()
		info:SetAttacker(self.Owner)
		info:SetInflictor(self)
		info:SetDamageType (DMG_GENERIC)
		info:SetDamage(130)
		info:SetMaxDamage(130)
		info:SetDamageForce(Vector(0,0,0))

		v:TakeDamageInfo(info)
		self.Entity:Remove()
		end	
	end
end
*/
	local phys 		= self.Entity:GetPhysicsObject()
	local ang 		= self.Entity:GetForward() * 100000
	local up		= self.Entity:GetUp() * -800

	local force		= ang + up

	phys:ApplyForceCenter(force)

	tr = {}
		tr.start = self:GetPos()
		tr.filter = {self, self.Owner}
		tr.endpos = self:GetAngles():Forward() * 500
	tr = util.TraceLine(tr)


	if (self.Entity.HitWeld) then  
		self.HitWeld = false  
		constraint.Weld(self.Entity.HitEnt, self.Entity, 0, 0, 0, true)  
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
	self.Entity:FireBullets(bullet)

	if not sent:IsPlayer() and not sent:IsNPC() and not sent.Type == "nextbot" then
		local effectdata = EffectData()
			effectdata:SetOrigin(pos - normal * 10)
			effectdata:SetEntity(self.Entity)
			effectdata:SetStart(pos)
			effectdata:SetNormal(normal)
		util.Effect("effect_mad_shotgunsmoke", effectdata)

	end


	if IsValid(sent) then
		info = DamageInfo()
			info:SetAttacker(self.Owner)
			info:SetInflictor(self)
			info:SetDamageType (bit.bor(DMG_GENERIC, DMG_SHOCK))
			info:SetDamage(60)
			info:SetMaxDamage(60)
			info:SetDamageForce(tr.HitNormal * 10)

		self.Entity:EmitSound("Weapon_Crossbow.BoltHitBody")
		sent:TakeDamageInfo(info)

		self.Entity:Remove()
		return
	end
	
	self.Entity:EmitSound("Weapon_Crossbow.BoltHitWorld")

	// We've hit a prop, so let's weld to it
	// Also embed this in the object for looks

	self:SetPos(pos - normal * 10)
	self:SetAngles(normal:Angle())

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetScale(0.2)
		effectdata:SetRadius(3)
		effectdata:SetMagnitude(0.15)
	util.Effect("Sparks", effectdata)

		local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())
			effectdata:SetEntity(self)
		util.Effect("effect_zw_flare_glow", effectdata)

	timer.Simple(2, function() if self:IsValid() then self:Explosion() end end)
	
	if not IsValid(sent) then
		self:GetPhysicsObject():EnableMotion(false)
	end

--	self.Entity:Fire("kill", "", 10)
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)

	if self.Moving then
		self.Moving = false
		phys:Sleep()
		self.Entity:Impact(data.HitEntity, data.HitNormal, data.HitPos)
	end
end


function ENT:Explosion()
	
--	util.BlastDamage( self.Entity, self.Owner, self:GetPos(), 100, 120 )

	local explo = ents.Create("env_explosion")
		explo:SetOwner(self.Owner)
		explo:SetPos(self.Entity:GetPos())
		explo:SetKeyValue("iMagnitude", "120")
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode", "", 0)

	self:Remove()
end