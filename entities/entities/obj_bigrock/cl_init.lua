include('shared.lua')

language.Add("obj_bigrock", "The Tyrant")
function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
end
 
function ENT:OnRemove()
end
 