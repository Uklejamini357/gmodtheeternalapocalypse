ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Fridge"
ENT.Author			= "LegendofRobbo"

ENT.Spawnable			= false
ENT.AdminOnly			= false


function ENT:SpawnFunction(ply, tr)
	return false
end

function ENT:Initialize()

	local selfent = self.Entity
	self.UseTimer = CurTime()
	self.integrity = 500
	self.maxinteg = 500
	self:SetModel("models/props_c17/consolebox01a.mdl")
	selfent:PhysicsInit( SOLID_VPHYSICS )
	selfent:SetMoveType( MOVETYPE_VPHYSICS )
	selfent:SetSolid( SOLID_VPHYSICS )
	selfent:SetUseType(3)

	local phys = selfent:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end	
end

function ENT:Use(activator, caller)
	local owner = self:GetNWEntity("owner")
	if self.UseTimer > CurTime() then return false end

	activator:EmitSound("npc/barnacle/barnacle_gulp2.wav")
	activator:SystemMessage("NOW HOLD ON, I NEED TO MAKE A PANEL OF THIS!", Color(205,255,205,255), false)
	activator:SendUseDelay(2)
	self.UseTimer = CurTime() + 5
end 


function ENT:Think()
end

function ENT:OnTakeDamage(dmg)
	if self.HasBeenRemoved then return end

	local damage = dmg:GetDamage()
	local attacker = dmg:GetAttacker()
	local owner = self:GetNWEntity("owner")

	local currenthealth = self.integrity
	if dmg:IsBulletDamage() then 
		self.integrity = (self.integrity - damage / 2)
	else
		self.integrity = (self.integrity - damage)
	end

	local lvl = math.floor(self.maxinteg / 500)
	local swag
	if lvl == 1 then swag = math.Clamp(self.integrity / 2 , 0, 255)
	elseif lvl == 2 then swag = math.Clamp(self.integrity / 4 , 0, 255)
	else
		swag = math.Clamp(self.integrity / 6 , 0, 255)
	end

	self:SetColor(Color(swag +5,swag+5,swag+5,255))

	if self.integrity - damage < 0 then
		if attacker:IsPlayer() and attacker != owner then
			GAMEMODE:Payout(attacker, 1000, 1000)
		end

		local pos = self:GetPos()

		self:BreakPanel()
		self:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)              
		self:Remove()

		self.HasBeenRemoved = true

		local eff = EffectData()
		eff:SetOrigin(pos)
		util.Effect("Explosion", eff)

		util.BlastDamage(self, self, self:GetPos(), 90, 150)
	end
end


function ENT:PhysicsUpdate() end

function ENT:PhysicsCollide(data, physobj) end

function ENT:BreakPanel()
	local vPoint = self:GetPos()
	local effectdata = EffectData()

	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(0.3)
	util.Effect("HelicopterMegaBomb", effectdata)

	local sparkeffect = effectdata
	sparkeffect:SetMagnitude(3)
	sparkeffect:SetRadius(8)
	sparkeffect:SetScale(5)
	util.Effect("Sparks", sparkeffect)
end
