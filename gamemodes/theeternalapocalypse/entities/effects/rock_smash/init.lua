function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	if data:GetScale() == 1 then
		for i=1, 5 do
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
			if (particle) then
				particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(50, 150) )
				if i == 1 or i == 2 or i == 3 or i == 5 then 
				particle:SetDieTime( 3 )
				else
				particle:SetDieTime( math.Rand( 1, 3 ) )
				end
				particle:SetStartAlpha( math.Rand( 40, 60 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 10, 30 ) )
				particle:SetEndSize( math.Rand( 100, 150 ) )
				particle:SetRoll( math.Rand(0, 180) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 155 , 155 , 155 ) 
 				particle:SetAirResistance( 100 ) 
 				//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
				particle:SetCollide( true )
				particle:SetBounce( 1 )
			end
		end
	end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()

end