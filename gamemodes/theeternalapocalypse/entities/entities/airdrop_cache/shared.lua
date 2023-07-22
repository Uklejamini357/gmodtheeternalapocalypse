ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Aidrop Crate"
ENT.Author = "LegendofRobbo"
ENT.Contact = ""
ENT.Purpose = "dank"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetADOpeningStatus(status)
    self:SetNWBool("ADIsOpening", status)
end

function ENT:GetADOpeningStatus(status)
    return self:GetNWBool("ADIsOpening", status)
end

function ENT:SetADOpenedStatus(status)
    self:SetNWBool("ADHasOpened", status)
end

function ENT:GetADOpenedStatus(status)
    return self:GetNWBool("ADHasOpened", status)
end

function ENT:SetADOpeningPlayer(ply)
    self:SetNWEntity("ADIsOpeningPlayer", ply)
end

function ENT:GetADOpeningPlayer(ply)
    return self:GetNWEntity("ADIsOpeningPlayer", ply)
end

function ENT:SetADOpeningTime(time)
    self:SetNWFloat("ADOpenTime", time)
end

function ENT:GetADOpeningTime()
    return self:GetNWFloat("ADOpenTime", 0)
end
