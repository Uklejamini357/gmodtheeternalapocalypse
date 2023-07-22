function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	for i = 0, 5 do
	self.Emitter = ParticleEmitter(pos)
			local particle = self.Emitter:Add( "effects/yellowflare", pos)
			if (particle) then
				particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(50, 100) )
				particle:SetDieTime( math.Rand( 0.1, 0.3 ) )
				particle:SetStartAlpha( math.Rand( 100, 150 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 2, 4 ) )
				particle:SetEndSize( math.Rand( 7, 10 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 255 , 255 , 255 ) 
 				particle:SetAirResistance( 100 ) 
 				//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
				particle:SetCollide( true )
				particle:SetBounce( 1 )
			end
	end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()

end