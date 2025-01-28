ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Flimsy Prop"
ENT.Author			= "LegendofRobbo"
/*
 function ENT:SetupDataTables()
 	self:NetworkVar( "Float", 0, "Integrity" )
 end
*/

ENT.Spawnable			= false
ENT.AdminOnly			= false


function ENT:SpawnFunction( ply, tr ) -- spawnfunction isnt actually used within zombified world but i left it here for debug purposes
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + Vector(0,0,50)
	local ent = ents.Create( "prop_flimsy" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()

	local selfent = self.Entity
	self.IsBuilt = false
	self.CreateTime = CurTime()
	self.BuildLevel = 0
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local model = self:GetModel()

	self:SetMaterial("models/wireframe")
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )

	self:SetColor(Color(105, 105, 105, 100))
/*
	timer.Simple(3, function() 
	if self:IsValid() then
	self:SetMaterial("")
	self:SetColor(Color(255, 255, 255, 255))
	self.IsBuilt = true
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	end
	end)
*/

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

/*
	timer.Simple(3, function()
	if not self:IsValid() then return false end


	local ent = self
	local mins, maxs = ent:LocalToWorld(ent:OBBMins( )), ent:LocalToWorld(ent:OBBMaxs( ))
	local cube = ents.FindInBox( mins, maxs )

		for _,v in pairs(cube) do
			if v:IsPlayer() or v:IsNPC() or v.Type == "nextbot" then self:Remove()
			if v:IsPlayer() then
 			v:SendChat("Unable to build prop, biological obstruction detected" )
 			end
		end
	end

end)
*/

end

function ENT:Use(activator, caller)
	return false
end 

function ENT:FinishBuild()
	if self:IsValid() then
		self:SetMaterial("")
		self:SetColor(Color(255, 255, 255, 255))
		self.IsBuilt = true
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
	end
end

function ENT:Think()

	local owner = self:GetNWEntity("owner")
	
	if SERVER then
		if !self.IsBuilt and owner:IsValid() and owner:HasPerk("speedy_hands") and self.CreateTime and self.CreateTime + 60 < CurTime() then
			local mins, maxs = self:LocalToWorld(self:OBBMins()), self:LocalToWorld(self:OBBMaxs( ))
			local cube = ents.FindInBox(mins, maxs)

			for _,v in pairs(cube) do
				if v:IsPlayer() or v:IsNPC() or v.Type == "nextbot" then
					self:NextThink(CurTime() + 1)
					if CLIENT then
						self:SetNextClientThink(CurTime() + 1)
					end
					return true
				end
			end

			self:NextThink(CurTime() + 1)
			if CLIENT then
				self:SetNextClientThink(CurTime() + 1)
			end
			self:FinishBuild()
			return true
		end

		self:NextThink(CurTime() + 1)
		if CLIENT then
			self:SetNextClientThink(CurTime() + 1)
		end
	end
	return true
end


function ENT:OnTakeDamage( dmg )
	local damage = dmg:GetDamage()
	local attacker = dmg:GetAttacker()
	local owner = self:GetNWEntity("owner")
	local ownerhasperk = owner:IsValid() and owner:HasPerk("speedy_hands")

	if damage <= 0 then return end
	if attacker:IsPlayer() and attacker:IsValid() and attacker:Team() == 1 and attacker:GetNWBool("pvp") != true and owner != attacker and owner != NULL then
		if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
			attacker:SystemMessage("You cannot damage other players props unless you have PvP mode enabled!", Color(255,205,205,255), true)
			timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
		end
		return false 
	end

	if ownerhasperk and !self.IsBuilt then
		damage = damage * 20
	end


	local currenthealth = self:GetStructureHealth()
	local maxhealth = self:GetStructureMaxHealth()
	if dmg:IsBulletDamage() then 
		currenthealth = (currenthealth - (damage * 0.6))
	else
		currenthealth = (currenthealth - damage)
	end
	self:SetStructureHealth( currenthealth )

	local hp = maxhealth / 500
	local swag = math.Clamp(currenthealth / (2 * hp), 0, 255)

	self:SetColor(Color(swag +5,swag+5,swag+5,255))

	if currenthealth < 0 or !self.IsBuilt and (!ownerhasperk or attacker:IsPlayer()) then
		self:BreakPanel()
		self.Entity:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)              
		self.Entity:Remove()
	end
end


function ENT:PhysicsUpdate() end

function ENT:PhysicsCollide( data, physobj ) end

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