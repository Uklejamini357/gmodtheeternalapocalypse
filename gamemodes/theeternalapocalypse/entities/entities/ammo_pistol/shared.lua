ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Pistol Ammo" --The name of the SENT.
ENT.Author = "LegendofRobbo" --Your name.
ENT.Contact = "" --EMail address.
ENT.Purpose = "Pistol Ammo" --The purpose of this SENT.
ENT.Instructions = "" --Instructions

ENT.Spawnable = true --Can the clients spawn this SENT?
ENT.AdminSpawnable = true --Can the admins spawn this SENT?

--Called when the SENT is removed
--Return: Nothing
function ENT:OnRemove()
end

--Controls what a scripted entity does during a collison.
--Return: Nothing
--Notes: tblData contains: HitEntity (Entity), HitPos (Vector), OurOldVelocity (Vector), HitObject (PhysObj), DeltaTime (number), TheirOldVelocity (Vector), Speed (number?) and HitNormal (Vector).
function ENT:PhysicsCollide( tblData )
end

--Called when physics are updated?
--Return: Nothing
function ENT:PhysicsUpdate( pobPhysics )
end
