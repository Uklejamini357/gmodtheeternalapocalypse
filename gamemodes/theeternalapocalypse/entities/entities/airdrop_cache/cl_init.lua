include("shared.lua")

--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
    self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
end

--Return true if this entity is translucent.
--Return: Boolean
function ENT:IsTranslucent()
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end

function ENT:Draw()
    self:DrawModel()

    local me = LocalPlayer()
    if self:GetPos():DistToSqr(me:GetPos()) < 1440000 then --1200^2

        cam.Start3D2D(self:GetPos() + Vector(0, 0, 90), Angle(0, me:EyeAngles().yaw - 90, 90), 0.5)
        cam.IgnoreZ(true)
        local openingply = self:GetADOpeningPlayer()
        if self:GetADOpeningStatus() and openingply:IsValid() then
            draw.DrawText("Airdrop is being opened by "..openingply:Name().."...", "TargetIDSmall", 0, 0, Color(255,205,155,255), TEXT_ALIGN_CENTER)
            draw.DrawText(math.ceil(self:GetADOpeningTime() - CurTime()).." seconds remain", "TargetIDSmall", 0, 15, Color(255,205,155,255), TEXT_ALIGN_CENTER)
            if openingply == me then
                draw.DrawText("Distance away: "..math.ceil(math.sqrt(me:GetPos():DistToSqr(self:GetPos()))).."/250", "TargetIDSmall", 0, -15, Color(205,205,205,255), TEXT_ALIGN_CENTER)
            end
        elseif self:GetADOpenedStatus() then
            draw.DrawText("Airdrop is open!", "TargetIDSmall", 0, 0, Color(155,255,155,255), TEXT_ALIGN_CENTER)
        else
            draw.DrawText("Airdrop is not open", "TargetIDSmall", 0, 0, Color(255,155,155,255), TEXT_ALIGN_CENTER)
        end

        cam.IgnoreZ(false)
        cam.End3D2D()
    end

end


