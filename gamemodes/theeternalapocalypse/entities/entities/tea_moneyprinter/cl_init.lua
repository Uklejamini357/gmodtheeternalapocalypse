include('shared.lua')

/*
function ENT:Draw()
	self.Entity:DrawModel()
end
*/

function ENT:Initialize()

end


function ENT:Draw()
    self:DrawModel()

    local me = LocalPlayer()
    if self:GetPos():DistToSqr(me:GetPos()) < 160000 then --400^2

		local ang = self:GetAngles()
--        cam.Start3D2D(self:GetPos() + Vector(0, 0, 11), Angle(0, ang.yaw + 90, ang.pitch), 0.5)
        cam.Start3D2D(self:GetPos() + Vector(0, 0, 20), Angle(0, me:EyeAngles().yaw - 90, 90), 0.5)
        draw.DrawText("Printer", "TargetID", 0, -20, Color(255,155,155,255), TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end

end
