AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel( "models/props/de_prodigy/ammo_can_02.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Use( activator, caller )
	if !caller:IsValid() or !caller:IsPlayer() or !self.LootType or !caller:Alive() then self:Remove() return false end
	local name = self.LootType
	local item = ItemsList[name]
	local itemweight = ItemsList[name]["Weight"]
	local itemname = ItemsList[name]["Name"]

	local qtycheck = LootTableFaction[name]["Qty"]

	if !name or !item or !qtycheck then SendChat(caller, "Sorry, this loot cache was bugged and was auto removed to avoid breaking the game, please tell an admin or developer") self:Remove() return false end

	if !item then return false end
	if (CalculateWeight(caller) + (qtycheck * itemweight)) > CalculateMaxWeight(caller) then SendChat(caller, translate.ClientFormat(caller, "NotEnoughSpaceLoot", qtycheck * itemweight, translate.ClientGet(caller, "kg"), -CalculateMaxWeight(caller) + CalculateWeight(caller) + (qtycheck * itemweight), translate.ClientGet(caller, "kg"))) return false end

	SystemGiveItem( caller, name, qtycheck )

	SendChat(caller, "You picked up a faction loot cache containing [ "..qtycheck.."x "..translate.ClientGet(caller, itemname).." ]")
	SystemBroadcast( caller:Nick().." has found a faction loot cache!", Color(255,255,255,255), true)
	SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end