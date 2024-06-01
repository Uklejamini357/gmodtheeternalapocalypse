AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self.Entity:SetModel( "models/props/cs_office/cardboard_box03.mdl" )
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

	local weightcheck = LootTable1[name]["Weight"]
	local qtycheck = LootTable1[name]["Qty"]

	if !name or !item or !weightcheck or !qtycheck then caller:SendChat("Sorry, this loot cache was bugged and was auto removed to avoid breaking the game, please tell an admin or developer") return false end

	if !item then return false end
	if (CalculateWeight(caller) + weightcheck) > CalculateMaxWeight(caller) then caller:SendChat("You don't have enough space for this item! It weighs: "..weightcheck.."kg") return false end

if caller.Inventory[name] then
	local used = caller.Inventory[name]
	used.Qty = used.Qty + qtycheck
else 
	caller.Inventory[name] = {
		["Name"] = item["Name"],
		["Model"] = item["Model"],
		["Description"] = item["Description"],
		["Weight"] = item["Weight"],
		["Rarity"] = item["Rarity"],
		["Qty"] = qtycheck,
}
end

	caller:SendChat("You picked up a loot cache containing [ "..LootTable1[name]["Name"].." ]")
	GAMEMODE:SystemBroadcast( caller:Nick().." has found a loot cache!", Color(255,255,255,255), true)
	GAMEMODE:SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end