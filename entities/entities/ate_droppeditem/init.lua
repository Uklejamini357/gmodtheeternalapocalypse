AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
--	self.Entity:SetModel( "models/Items/HealthKit.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )

	timer.Simple(3600, function() if self:IsValid() then self:Remove() end end )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Use( activator, caller )
if !activator:IsValid() or !activator:IsPlayer() or !self:GetNWString("ItemClass") or !activator:Alive() then return false end
local name = self:GetNWString("ItemClass")
local ref = ItemsList[name]
if (CalculateWeight(activator) + ref.Weight) > (37.4 + ((activator.StatStrength or 0) * 1.53)) then SendChat(activator, "You don't have enough space for this item!") return false end

SystemGiveItem( activator, name )

SendInventory(activator)
activator:EmitSound("items/itempickup.wav", 100, 100)
self:Remove()
end