ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Propane"
ENT.Category		= "T.E.A. Items"
ENT.Author			= "Uklejamini"

ENT.Spawnable			= true
ENT.AdminOnly			= true


function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create("prop_tea_propane")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

    return ent
end

function ENT:Initialize()
	self:SetModel("models/props_junk/PropaneCanister001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(20)
	end
end

function ENT:Use(activator, caller, usetype, value)
	if caller:KeyDown(IN_SPEED) then
		gamemode.Call("SystemGiveItem", activator, "item_propane")
		GAMEMODE:SendInventory(activator)
		self:Remove()
	end
	if self:IsPlayerHolding() and self.Holder == caller then
		caller:DropObject()
		self.Holder = nil
	elseif self:IsPlayerHolding() then return end

	caller:PickupObject(self)
	self.Holder = caller
end

function ENT:Think()
	return true
end


function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()

	if dmginfo:IsBulletDamage() then
		self:Explode(attacker)
	end
end





function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data, physobj)
	if data.Speed >= 800 and not self:IsPlayerHolding() then
		self:Explode(self:GetPhysicsAttacker())
	end
end

function ENT:Explode(attacker)
	if self.Exploded then return end
	self.Exploded = true

	local env_explo = ents.Create("env_explosion")
	env_explo:SetPos(self:GetPos() + self:OBBCenter())
	env_explo:SetKeyValue("iMagnitude", "500")
	env_explo:SetKeyValue("iRadiusOverride", "450")
	env_explo:SetKeyValue("rendermode", "5")
	env_explo:SetOwner(attacker != NULL and attacker or self)
	env_explo:Spawn()
	env_explo:Input("explode")
	self:Remove()
end
