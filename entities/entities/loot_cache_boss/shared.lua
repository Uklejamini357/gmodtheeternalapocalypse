ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Loot Cache"
ENT.Author = "LegendofRobbo"
ENT.Contact = ""
ENT.Purpose = "dank"
ENT.Instructions = ""

ENT.Spawnable = true --Can the clients spawn this SENT?
ENT.AdminSpawnable = true --Can the admins spawn this SENT?


function ENT:OnRemove()
end


function ENT:PhysicsCollide( tblData )
end


function ENT:PhysicsUpdate( pobPhysics )
end
