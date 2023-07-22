include('shared.lua')

language.Add("obj_fleshbomb", "Fleshpile Zombie")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
end
 
function ENT:OnRemove()
end
 