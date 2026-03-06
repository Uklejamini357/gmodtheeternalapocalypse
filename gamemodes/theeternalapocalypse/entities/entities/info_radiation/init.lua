ENT.Base = "gmod_baseentity"

ENT.Name = "Radiation Info"
ENT.Purpose = "Irradiates you."

function ENT:Initialize()

end

function ENT:Think()

	for _,ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if ent:IsPlayer() then
			
		end
	end


	self:NextThink(CurTime() + 0.15)

	return true
end
