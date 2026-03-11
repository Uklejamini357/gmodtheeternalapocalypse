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

    if CurTime() < 300 then
        ent:PrintMessage(3, "Whoa slow down, you cannot go to another map yet!")
        return
    end

	ent.OpenworldCanTravelTo = self

	gamemode.Call("OpenworldPlayerSendConfirm", ent, self)
end

function ENT:EndTouch(ent)
	if not (ent:IsPlayer()) then return end

	GAMEMODE:OpenworldPlayerLeaveTransition(ent, self)
	ent.OpenworldCanTravelTo = nil

	net.Start("tea_openworld_level")
	net.WriteUInt(OPENWORLD_NETTYPE_LEFTAREA, 4)
	net.Send(ent)
end
