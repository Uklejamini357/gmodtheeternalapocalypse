include('shared.lua')

/*
function ENT:Draw()
	self.Entity:DrawModel()
end
*/

function ENT:Initialize()

	self.Timer = CurTime() + 0.1

end

function ENT:Think()

	if (self.Timer < CurTime() && self:GetMaterial() != "models/wireframe") then
		local light = DynamicLight(self:EntIndex())
		if (light) then
			light.Pos = self:GetPos()
			light.r = 205
			light.g = 205
			light.b = 50
			light.Brightness = 1
			light.Decay = 1000
			light.Size = 1000
			light.DieTime = CurTime() + 1
		end
	end
end