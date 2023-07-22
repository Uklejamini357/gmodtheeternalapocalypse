AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
--	self.Entity:SetModel( "models/Items/HealthKit.mdl" )
 	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- don't let the player collide with the dropped item
	self.Entity:SetSolid(SOLID_VPHYSICS)
 	self.Entity:SetColor(Color(255, 255, 255, 255))
	self.Entity:SetUseType(SIMPLE_USE)
--	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	timer.Simple(3600, function() if self:IsValid() then self:Remove() end end )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction(userid, tr)
end

function ENT:Use( activator, caller )
	if !activator:IsValid() or !activator:IsPlayer() or !self:GetNWString("ItemClass") or !activator:Alive() then return false end
	if activator:KeyDown(IN_RELOAD) or activator:GetInfoNum("tea_cl_usereloadtopickup", 0) < 1 then
		local name = self:GetNWString("ItemClass")
		local ref = GAMEMODE.ItemsList[name]
		if (GAMEMODE:CalculateWeight(activator) + ref.Weight) > GAMEMODE:CalculateMaxWeight(activator) then
			caller:SendChat(Format("You don't have enough space for this item! Need %skg more space!", GAMEMODE:CalculateRemainingInventoryWeight(activator, ref.Weight)))
			return false
		end
		
		gamemode.Call("SystemGiveItem", activator, name)
		
		GAMEMODE:SendInventory(activator)
		activator:EmitSound("items/itempickup.wav", 100, 100)
		self:Remove()
	else
		activator:PrintMessage(HUD_PRINTCENTER, "R+E to pick up")
		activator:PickupObject(self)
	end
end
