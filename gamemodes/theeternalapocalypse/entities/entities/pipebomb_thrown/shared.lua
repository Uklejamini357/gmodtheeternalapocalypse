ENT.Type = "anim"
ENT.PrintName			= "Thrown Pipe Bomb"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions			= ""

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()

	self.Owner = self.Entity.Owner

	self.Entity:SetModel("models/props_lab/pipesystem03c.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
--	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end
	self.timeleft = CurTime() + 3
	self:Think()

	self.sound = CreateSound(self, Sound("ambient/gas/steam2.wav"))
	self.sound:SetSoundLevel(70)
	self.sound:PlayEx(1, 100)
end

 function ENT:Think()
	
	if self.timeleft < CurTime() then
			self:Explosion()	
	end

	local sparks = EffectData()
		sparks:SetOrigin(self:GetPos())
		sparks:SetScale(1)//otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
	util.Effect("pipebomb_sparks", sparks)



	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetEntity(self.Entity)
		effectdata:SetStart(self.Entity:GetPos())
		effectdata:SetNormal(Vector(0,0,1))
		--util.Effect("ManhackSparks", effectdata)
		util.Effect("cball_explode", effectdata)
		util.Effect("Explosion", effectdata)
	
	local thumper = effectdata
		thumper:SetOrigin(self.Entity:GetPos())
		thumper:SetScale(500)
		thumper:SetMagnitude(500)
		util.Effect("ThumperDust", effectdata)
		
	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
		util.Effect("Sparks", sparkeffect)
		
	local scorchstart = self.Entity:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self.Entity:GetPos() + ((Vector(0,0,-1)) * 5)
	
	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 280, 190)
	util.ScreenShake(self.Entity:GetPos(), 500, 500, 1.25, 500)
	self.Entity:Remove()
	util.Decal("Scorch", scorchstart, scorchend)
end

function ENT:OtherExplosion()

	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 450, 350)
	util.ScreenShake(self.Entity:GetPos(), 500, 500, 1.25, 500)	
	
	local scorchstart = self.Entity:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self.Entity:GetPos() + ((Vector(0,0,-1)) * 5)

	pos = self.Entity:GetPos() --+Vector(0,0,10)
	
	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetEntity(self.Entity)
		effectdata:SetStart(pos)
		effectdata:SetNormal(Vector(0,0,1))
	util.Effect("Explosion", effectdata)
	
	local thumper = effectdata
		thumper:SetOrigin(self.Entity:GetPos())
		thumper:SetScale(500)
		thumper:SetMagnitude(500)
	util.Effect("ThumperDust", thumper)
	
	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
	util.Effect("Sparks", sparkeffect)
	

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	
	self.Entity:Remove()
	util.Decal("Scorch", scorchstart, scorchend)
	
	self.Entity:EmitSound("ambient/explosions/explode_9.wav", pos, 500, 100 )
end

/*---------------------------------------------------------
PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("HEGrenade.Bounce"))
	end
/*
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
*/	
end

end

if CLIENT then
function ENT:Draw()
	self.Entity:DrawModel()
end
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end