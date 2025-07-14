include('shared.lua')

language.Add("ent_mad_plasmaround", "Explosive Plasma")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
	local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

	local emitter 	= ParticleEmitter(vOffset)

	for i = 1, 1500 do 
		timer.Simple(i / 150, function()
			if not IsValid(self.Entity) or self.Entity:GetNWBool("Explode") then return end

			local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
			local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()

			
		end)
	end

	emitter:Finish()
end

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel()
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()
end

/*---------------------------------------------------------
   Name: ENT:IsTranslucent()
---------------------------------------------------------*/
function ENT:IsTranslucent()

	return true
end


