AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel("models/Items/item_item_crate.mdl")
 	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
 	self.Entity:SetColor(Color(255,255,255,255))
	self.Entity:SetUseType(SIMPLE_USE)
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction(userid, tr)
end

function ENT:Use( activator, caller )
	if !caller:IsValid() or !caller:IsPlayer() or !self.LootType or !caller:Alive() then self:Remove() return false end
	local name = self.LootType
	local item = GAMEMODE.ItemsList[name]
	local itemweight = item["Weight"]
	local itemname = GAMEMODE:GetItemName(name, caller)

	local qty = self.LootQuantity or GAMEMODE.LootTable3[name]["Qty"]

	if !name or !item or !qty then caller:SendChat(translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	if !item then return false end

	gamemode.Call("SystemGiveItem", caller, name, qty)
	gamemode.Call("GiveTaskProgress", caller, "loot_finder", 1)

	caller:SendChat("You picked up a rare cache containing [ "..qty.."x "..itemname.." ]")
	GAMEMODE:SystemBroadcast(caller:Nick().." has found a rare cache containing "..qty.."x "..itemname.."!", Color(255,255,255,255), true)
	GAMEMODE:SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
