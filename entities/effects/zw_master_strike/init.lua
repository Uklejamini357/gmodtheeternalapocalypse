function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/stunstick", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(10, 20))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(0.2)
				
				particle:SetColor(100, 100, 250)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(2)
				particle:SetEndSize(50)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(80, 160))
				
				particle:SetGravity(Vector(0, 0, -50))

				particle:SetCollide(true)
				particle:SetBounce(0.45)
			end

			local particle = emitter:Add("effects/select_ring", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(10, 20))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(0.2)
				
				particle:SetColor(255, 100, 100)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(5)
				particle:SetEndSize(100)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(80, 160))
				
				particle:SetGravity(Vector(0, 0, -50))

				particle:SetCollide(true)
				particle:SetBounce(0.45)
			end

	emitter:Finish()
end

function EFFECT:Think()

	return false
end

function EFFECT:Render()
end