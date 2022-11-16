include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel()
end


/*---------------------------------------------------------
   Name: ENT:IsTranslucent()
---------------------------------------------------------*/
function ENT:IsTranslucent()

	return true
end

function ENT:Initialize()

	self.Timer = CurTime() + 0.1

end

function ENT:Think()

	if (self.Timer < CurTime()) then
		local light = DynamicLight(self:EntIndex())
		if (light) then
			light.Pos = self:GetPos()
			light.r = 205
			light.g = 50
			light.b = 50
			light.Brightness = 1
			light.Decay = math.random(500, 800) * 5
			light.Size = math.random(1100, 1150)
			light.DieTime = CurTime() + 1
		end
	end
end