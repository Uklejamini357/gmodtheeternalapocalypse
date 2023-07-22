function EFFECT:Init(data)
	
	local emitter = ParticleEmitter(data:GetOrigin())

		for i = 0, 10 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/muzzleflash"..math.random(1, 4), Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(400, 600))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.1, 0.4))
				
				particle:SetColor(255, 255, 255)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(8)
				particle:SetEndSize(math.Rand(25, 65))
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(100, 150))
				
				particle:SetGravity(Vector(0, 0, -50))

				particle:SetCollide(true)
				particle:SetBounce(0.45)
			end
		end

		for i = 0, 1 do

			local Pos = (data:GetOrigin())
		
			local particle = emitter:Add("effects/muzzleflash"..math.random(1, 4), Pos)

			if (particle) then
				particle:SetVelocity(VectorRand() * math.Rand(10, 20))
				
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.75, 1.25))
				
				particle:SetColor(255, 255, 255)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(80)
				particle:SetEndSize(math.Rand(175, 250))
				
				particle:SetRoll(math.Rand(-360, 360))
				particle:SetRollDelta(math.Rand(-0.21, 0.21))
				
				particle:SetAirResistance(math.Rand(80, 160))
				
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
				
				particle:SetColor(255, 255, 255)			

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				
				particle:SetStartSize(80)
				particle:SetEndSize(math.Rand(95, 170))
				
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