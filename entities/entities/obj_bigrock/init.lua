AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	local faggotshit = {
	"models/props_debris/concrete_chunk01a.mdl",
	"models/props_debris/concrete_chunk01b.mdl",
	"models/props_debris/concrete_chunk01c.mdl",
	"models/props_debris/concrete_chunk02b.mdl",
	}
	self:SetModel(table.Random(faggotshit))
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor(Color(255,255,255,255))

	self.bounce = 0

	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
		phys:SetBuoyancyRatio(0)
	end
	self.delayRemove = CurTime() + 8
	util.SpriteTrail(self.Entity, 0, Color(155, 155, 155, 55), false, 50, 20, 0.2, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
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
	local damagedents = ents.FindInSphere(self:GetPos(),200)
--	local effectdata = EffectData()
--	effectdata:SetOrigin(self:GetPos())
--	util.ParticleEffect("goregrenade_splash",self:GetPos(),self:GetAngles(),nil,nil,0.25)
	local valid = IsValid(self.Zed)
	sound.Play("npc/dog/car_impact1.wav", self:GetPos(),75,math.Rand(80, 120))

	local gas = EffectData()
	gas:SetOrigin(self:GetPos())
	gas:SetScale(2)
	util.Effect("rock_smash", gas)

	for _,v in pairs(damagedents) do
		if v:IsPlayer() then
			v:TakeDamage(GAMEMODE.tea_CalcDefenseDamage(v, 50), self.Owner)
		elseif v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong" then
			v:TakeDamage(300,self.Owner)
		elseif SpecialSpawns[v:GetClass()] then
			v:TakeDamage(100, self.Owner)
		end

	end
	self:Remove()
end

function ENT:PhysicsCollide(data, physobj)
	if data.HitEntity:IsPlayer() then
		data.HitEntity:TakeDamage(GAMEMODE.tea_CalcDefenseDamage(data.HitEntity, 10), self.Owner)
	end

	local gas = EffectData()
	gas:SetOrigin(self:GetPos())
	gas:SetScale(1)
	util.Effect("rock_smash", gas)

	self:EmitSound("physics/concrete/boulder_impact_hard1.wav")

	self.bounce = self.bounce + 1
	if self.bounce > 3 then
	self:Splode()
	end
	return true
end

