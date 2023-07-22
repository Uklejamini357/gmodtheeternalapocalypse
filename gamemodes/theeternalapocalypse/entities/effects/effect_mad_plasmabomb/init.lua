function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

		for i = 0, 15 do

			local Pos = (data:GetOrigin())

			local Zap = (data:GetScale())
		
			local particle = emitter:Add("effects/electric1", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(20, 50) * Zap)
				
				particle:SetDieTime(math.Rand(0.3, 0.7))
				
				particle:SetColor(255, 255, 255)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(5)
				particle:SetEndSize(10 * Zap)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(70, 150))
				
				particle:SetGravity(Vector(0, 0, -5))

				particle:SetCollide(false)
				particle:SetBounce(0.45)
			end
		end


			local Pos = (data:GetOrigin())

			local Zap = (data:GetScale())
		
			local particle = emitter:Add("effects/select_ring", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(2, 5) * Zap)
				
				particle:SetDieTime(math.Rand(0.3, 0.7))
				
				particle:SetColor(155, 155, 255)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(5)
				particle:SetEndSize(20 * Zap)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(70, 150))
				
				particle:SetGravity(Vector(0, 0, -5))

				particle:SetCollide(false)
				particle:SetBounce(0.45)
		end


	emitter:Finish()
end

function EFFECT:Think()

	return false
end

function EFFECT:Render()
end