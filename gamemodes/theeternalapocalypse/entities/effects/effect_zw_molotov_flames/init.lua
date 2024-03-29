function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())
	self.FlareEnt 		= data:GetEntity()

		for i = 0, 1 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/yellowflare", Pos)

			if (particle) then
				if self.FlareEnt:IsValid() then
				particle:SetVelocity(self.FlareEnt:GetVelocity())
				else
				particle:SetVelocity(Vector(0,0,0))
				end
				
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.3, 0.5))
				
				particle:SetColor(255, 100, 100)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(20)
				particle:SetEndSize(50)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(80, 160))
				
				particle:SetGravity(Vector(0, 0, -50))

				particle:SetCollide(true)
				particle:SetBounce(0.45)
			end
		end

	emitter:Finish()
end

function EFFECT:Think()

	return false
end

function EFFECT:Render()
end