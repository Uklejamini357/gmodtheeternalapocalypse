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
	do return end -- Nope. I'd consider not doing this yet.

	if !caller:IsValid() or !caller:IsPlayer() or !self.LootType or !caller:Alive() then self:Remove() return false end
	local name = self.LootType
	local item = ItemsList[name]

	local weightcheck = LootTable1[name]["Weight"]
	local qtycheck = LootTable1[name]["Qty"]

	if !name or !item or !weightcheck or !qtycheck then
		caller:SendChat(translate.ClientGet(caller, "buggedcache"))
		return false
	end

	if !item then return false end

	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end