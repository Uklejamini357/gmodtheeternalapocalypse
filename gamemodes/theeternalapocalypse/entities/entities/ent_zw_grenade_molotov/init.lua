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

	self.Entity:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:Wake()
	end

	self.Timer = CurTime() + 10

	self.sound = CreateSound(self, Sound("ambient/fire/mtov_flame2.wav"))
	self.sound:SetSoundLevel(70)
	self.sound:PlayEx(1, 100)
	util.SpriteTrail(self.Entity, 0, Color(255, 155, 55, 55), false, 2, 10, 0.4, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.Timer < CurTime() then
		self.Entity:Remove()
	end

end

function ENT:HasLOS(target)
if !self:IsValid() or !target:IsValid() then return false end
if target != nil then
	local tracedata = {}
	tracedata.start = self:GetPos()
	tracedata.endpos = target:GetPos() + Vector(0, 0, 35)
	tracedata.filter = self
	local trace = util.TraceLine(tracedata)
	if trace.HitWorld == false then
		return true
	else 
	return false
	end
else
return false
end
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end

function ENT:Burn()
	self:SetNoDraw( true )
	self:GetPhysicsObject():EnableMotion( false )

	local d = DamageInfo()
	d:SetDamage( 10 )
	d:SetDamageType( DMG_BURN )
	d:SetAttacker( self.Owner )


	local burnt = ents.FindInSphere(self.Entity:GetPos(), 150)
	for k, v in pairs(burnt) do
		if (v:IsPlayer() and v:Alive() and self:HasLOS(v) and ( (v.PvP == true or v:Team() != 1) and (self.Owner.PvP == true or self.Owner:Team() != 1) )) then v:Ignite(10, 1)
		elseif v.Type == "nextbot" then v:Ignite(10, 1) end
	end

	timer.Create("burn"..self.Entity:EntIndex(), 0.25, 40, function()
		if !self:IsValid() then return false end
		local burnt2 = ents.FindInSphere(self.Entity:GetPos(), 150)
		for k, v in pairs(burnt2) do
			if (v:IsPlayer() and v:Alive() and self:HasLOS(v) and ( (v.PvP == true or v:Team() != 1) and (self.Owner.PvP == true or self.Owner:Team() != 1) )) then v:TakeDamageInfo( d )
			elseif v.Type == "nextbot" then v:TakeDamageInfo( d ) end
		end
	end)

end

function ENT:PhysicsCollide()
	local effectdata = EffectData()
	effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)

	self:EmitSound("ambient/fire/gascan_ignite1.wav", 120)

/*
	local flame = ents.Create("point_hurt")
	flame:SetPos(self.Entity:GetPos())
	flame:SetOwner(self.Owner)
	flame:SetKeyValue("DamageRadius", 150)
	flame:SetKeyValue("Damage", 20)
	flame:SetKeyValue("DamageDelay", 0.2)
	flame:SetKeyValue("DamageType", 8)
	flame:Spawn()
	flame:Fire("TurnOn", "", 0) 
	flame:Fire("kill", "", 10)

	local burnt = ents.FindInSphere(self.Entity:GetPos(), 150)
	for k, v in pairs(burnt) do
		if (v:IsPlayer() and v:Alive() and self:HasLOS(v) ) or v.Type == "nextbot" then v:Ignite(10, 1) end
	end
*/

	for i = 1, 6 do
		local fire = ents.Create("env_fire")
		fire:SetPos(self.Entity:GetPos() + Vector( math.random(-75, 75), math.random(-75, 75), 0))
		fire:SetOwner(self.Owner)
		fire:SetKeyValue("health", math.random(5, 15))
		fire:SetKeyValue("firesize", "90")
		fire:SetKeyValue("fireattack", "10")
		fire:SetKeyValue("damagescale", "1")
		fire:SetKeyValue("StartDisabled", "0")
		fire:SetKeyValue("firetype", "0")
		fire:SetKeyValue("spawnflags", "128")
		fire:Spawn()
		fire:Fire("StartFire", "", 0)
	end

	self:Burn()
end