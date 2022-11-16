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
	local itemname = translate.ClientGet(caller, name.."_n")

	local qtycheck = GAMEMODE.LootTable3[name]["Qty"]

	if !name or !item or !qtycheck then SendChat(caller, translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	if !item then return false end
	if (tea_CalculateWeight(caller) + (qtycheck * itemweight)) > tea_CalculateMaxWeight(caller) then SendChat(caller, translate.ClientFormat(caller, "notenoughspaceloot", qtycheck * itemweight, -tea_CalculateMaxWeight(caller) + tea_CalculateWeight(caller) + (qtycheck * itemweight))) return false end

	tea_SystemGiveItem(caller, name, qtycheck)

	SendChat(caller, "You picked up a rare loot cache containing [ "..qtycheck.."x "..itemname.." ]")
	tea_SystemBroadcast(caller:Nick().." has found a rare loot cache!", Color(255,255,255,255), true)
	tea_SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
