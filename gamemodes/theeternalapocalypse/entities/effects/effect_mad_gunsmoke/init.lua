/*---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------*/
function EFFECT:Init(data)

if not IsValid(data:GetEntity()) then return end
if GetConVarNumber( "zw_muzzleflash" ) != 1 then return end

	self.WeaponEnt 		= data:GetEntity()
	self.Attachment 		= data:GetAttachment()
	
	self.Position 		= self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward 		= data:GetNormal()
	self.Angle 			= self.Forward:Angle()
	self.Right 			= self.Angle:Right()
	self.Up 			= self.Angle:Up()

	if self.WeaponEnt == nil or self.WeaponEnt:GetOwner() == nil or self.WeaponEnt:GetOwner():GetVelocity() == nil then 
		return
	else
	
	local emitter 		= ParticleEmitter(self.Position)
	if emitter != nil then	

			local particle = emitter:Add("effects/muzzleflash"..math.random(1, 4), self.Position + 8 * self.Forward)
				if particle != nil then

				particle:SetVelocity(350 * self.Forward + 1.1 * self.WeaponEnt:GetOwner():GetVelocity())
				particle:SetAirResistance(160)

				particle:SetDieTime(0.08)

				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)

				particle:SetStartSize(8)
				particle:SetEndSize(35)

				particle:SetRoll(math.Rand(180, 480))
				particle:SetRollDelta(math.Rand(-1, 1))

				particle:SetColor(255, 255, 255)	

			local particle = emitter:Add("particle/particle_smokegrenade", self.Position + 8 * self.Forward)
				particle:SetVelocity(350 * self.Forward + 1 * self.WeaponEnt:GetOwner():GetVelocity())
				particle:SetAirResistance(160)

				particle:SetDieTime(0.6)

				particle:SetStartAlpha(200)
				particle:SetEndAlpha(0)

				particle:SetStartSize(8)
				particle:SetEndSize(35)

				particle:SetRoll(math.Rand(180, 480))
				particle:SetRollDelta(math.Rand(-1, 1))

			particle:SetColor(120, 120, 120)



/*

		local particle = emitter:Add("sprites/heatwave", self.Position + 8 * self.Forward)
			particle:SetVelocity(350 * self.Forward + 1.1 * self.WeaponEnt:GetOwner():GetVelocity())

			particle:SetAirResistance(160)

			particle:SetDieTime(0.1)

			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)

			particle:SetStartSize(10)
			particle:SetEndSize(20)

			particle:SetRoll(math.Rand(180, 480))
			particle:SetRollDelta(math.Rand(-1, 1))

			particle:SetColor(255, 255, 255)	

*/

		local particle = emitter:Add("particle/particle_smokegrenade", self.Position)

			particle:SetVelocity(100 * self.Forward + 8 * VectorRand()) // + AddVel)
			particle:SetAirResistance(400)
			particle:SetGravity(Vector(0, 0, math.Rand(25, 100)))

			particle:SetDieTime(math.Rand(1, 2))

			particle:SetStartAlpha(math.Rand(200, 235))
			particle:SetEndAlpha(0)

			particle:SetStartSize(math.Rand(2, 7))
			particle:SetEndSize(math.Rand(20, 35))

			particle:SetRoll(math.Rand(-25, 25))
			particle:SetRollDelta(math.Rand(-0.05, 0.05))

			particle:SetColor(100, 100, 100)
		end
	end

	emitter:Finish()

end
end

/*---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------*/
function EFFECT:Think()

	return false
end

/*---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------*/
function EFFECT:Render()
end


/*
[ERROR] addons/ender's mad cows weapons/lua/effects/effect_mad_gunsmoke/init.lua:21: Tried to use a NULL entity!
1. GetOwner - [C]:-1
2. unknown - addons/ender's mad cows weapons/lua/effects/effect_mad_gunsmoke/init.lua:21
*/