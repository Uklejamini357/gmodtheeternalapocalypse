ENT.Base = "base_brush"
ENT.Type = "brush"


function ENT:Initialize()
	local w = self.max.x - self.min.x
	local l = self.max.y - self.min.y
	local h = self.max.z - self.min.z

	local min = Vector(-(w/2), -(l/2), -(h/2))
	local max = Vector(w/2, l/2, h/2)

	self:DrawShadow(false)
	self:SetCollisionBounds(min, max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end


function ENT:StartTouch(ent)
	if not (ent:IsPlayer() and ent:Alive()) then return end

-- TODO: Don't immediately make player join the transition. Instead, make a prompt when a player wants to go to another map.
	--GAMEMODE:OpenworldPlayerJoinTransition(ent, self)
end

function ENT:EndTouch(ent)
	if not (ent:IsPlayer()) then return end

	GAMEMODE:OpenworldPlayerLeaveTransition(ent)
end
