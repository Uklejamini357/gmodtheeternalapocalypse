function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

		for i = 0, 55 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("particle/smokesprites_0001", Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(350, 550))
				
				particle:SetDieTime(math.Rand(28, 30))
				
				particle:SetColor(105, 105, 105)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(100)
				particle:SetEndSize(600)
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(70, 150))
				
				particle:SetGravity(Vector(0, 0, -5))

				particle:SetCollide(false)
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