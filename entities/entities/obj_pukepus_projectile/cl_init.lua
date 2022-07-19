include('shared.lua')

language.Add("obj_pukepus_projectile", "Pukepus Projectile")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
end
 
function ENT:OnRemove()
end
 