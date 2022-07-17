function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

			local Pos = (data:GetOrigin())

			for i = 1, 20 do
		
			local particle = emitter:Add("particle/smokesprites_000"..math.random(1,9)..".wav", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(50, 90))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.5, 2.5))
				
				particle:SetColor(20, 50, 0)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(5)
				particle:SetEndSize(math.random(150, 250))
				
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