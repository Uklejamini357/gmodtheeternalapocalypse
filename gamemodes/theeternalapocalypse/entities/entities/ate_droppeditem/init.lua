AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.CreatedTime = CurTime()

	--	self:SetModel( "models/Items/HealthKit.mdl" )
 	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- don't let the player collide with the dropped item
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
--	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	local PhysAwake = self:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:Wake()
	end
end

function ENT:Think()
	if self.CreatedTime and self.CreatedTime + 3600 < CurTime() then
		self:Remove()
		return
	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:SpawnFunction(userid, tr)
end

function ENT:Use( activator, caller )
	if !activator:IsValid() or !activator:IsPlayer() or !self:GetNWString("ItemClass") or !activator:Alive() then return false end
	if activator:KeyDown(IN_RELOAD) or activator:GetInfoNum("tea_cl_usereloadtopickup", 0) < 1 then
		local name = self:GetNWString("ItemClass")
		local ref = GAMEMODE.ItemsList[name]
/*
		if (activator:CalculateWeight() + ref.Weight) > activator:CalculateMaxWeight() then
			caller:SendChat(Format("You don't have enough space for this item! Need %skg more space!", GAMEMODE:CalculateRemainingInventoryWeight(activator, ref.Weight)))
			return false
		end
*/		
		gamemode.Call("SystemGiveItem", activator, name)
		
		GAMEMODE:SendInventory(activator)
		activator:EmitSound("items/itempickup.wav", 100, 100)
		self:Remove()
	else
		activator:PrintMessage(HUD_PRINTCENTER, "R+E to pick up")
		activator:PickupObject(self)
	end
end
