function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

		for i = 0, 4 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/yellowflare", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(400, 700))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(0.25)
				
				particle:SetColor(255, 155, 155)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(3)
				particle:SetEndSize(math.Rand(5, 15))
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(80, 140))
				
				particle:SetGravity(Vector(0, 0, -50))

				particle:SetCollide(true)
				particle:SetBounce(0.45)
			end
		end

		for i = 0, 1 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/yellowflare", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(10, 20))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.75, 1.25))
				
				particle:SetColor(255, 100, 100)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(150)
				particle:SetEndSize(350)
				
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