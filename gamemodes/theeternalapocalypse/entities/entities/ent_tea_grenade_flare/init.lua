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

	self.Entity:SetModel("models/props_lab/pipesystem03a.mdl")
	self.Entity:SetColor(Color(255,100,100))
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:Wake()
	end

	self.Timer = self.Entity:GetNWInt("Cook")

	self.Entity:EmitSound("Weapon_FlareGun.Burn")
/*
	self.sound = CreateSound(self, Sound("ambient/gas/steam2.wav"))
	self.sound:SetSoundLevel(70)
	self.sound:PlayEx(1, 100)
*/
--	util.SpriteTrail(self.Entity, 0, Color(55, 55, 55, 55), false, 2, 10, 0.8, 5 / ((2 + 10) * 0.5), "trails/smoke.vmt")
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.Timer < CurTime() then
		self.Entity:Remove()
	end

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

end

function ENT:OnRemove()
self.Entity:StopSound("Weapon_FlareGun.Burn")
/*
	if self.sound then
		self.sound:Stop()
	end
*/
end