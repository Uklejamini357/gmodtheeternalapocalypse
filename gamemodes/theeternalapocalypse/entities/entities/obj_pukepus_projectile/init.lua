AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor(Color(255,255,200,255))

	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
		phys:SetBuoyancyRatio(0)
	end
	self.delayRemove = CurTime() +8
	util.SpriteTrail(self.Entity, 0, Color(25, 155, 5, 55), false, 2, 10, 0.2, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
end

function ENT:OnRemove()
end

function ENT:Think()
	if(CurTime() > self.delayRemove) then self:Remove() end
end

function ENT:OnTakeDamage(dmginfo)
	return false
end

function ENT:Splode()
local damagedents = ents.FindInSphere(self:GetPos(),50)
--	local effectdata = EffectData()
--	effectdata:SetOrigin(self:GetPos())
--	util.ParticleEffect("goregrenade_splash",self:GetPos(),self:GetAngles(),nil,nil,0.25)
	local valid = IsValid(self.Zed)
	sound.Play("npc/barnacle/barnacle_crunch3.wav", self:GetPos(),75,math.Rand(80, 120))

	local gas = EffectData()
	gas:SetOrigin(self:GetPos())
	gas:SetScale(0.3)
	util.Effect("poison_splat", gas)

for _,v in pairs(damagedents) do
	if v:IsPlayer() or v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong" then
	v:TakeDamage(2,self.Entity)
	end
end
	self:Remove()
end

function ENT:PhysicsCollide(data, physobj)
	self:Splode()
	return true
end

