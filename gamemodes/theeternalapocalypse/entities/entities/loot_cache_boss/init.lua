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
	if self:GetNWEntity("pickup") and self:GetNWEntity("pickup"):IsValid() and self:GetNWEntity("pickup"):IsPlayer() and self:GetNWEntity("pickup") != caller then SystemMessage(caller, "You can't pick up the boss cache! Only "..self:GetNWEntity("pickup"):Nick().." can pick it up!", Color(255,205,205), true) return false end
	local name = self.LootType
	local item = GAMEMODE.ItemsList[name]
	local itemweight = item["Weight"]
	local itemname = translate.ClientGet(caller, name.."_n")

	local qtycheck = GAMEMODE.LootTableBoss[name]["Qty"]

	if !name or !item or !qtycheck then SendChat(caller, translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	if !item then return false end
	if (tea_CalculateWeight(caller) + (qtycheck * itemweight)) > tea_CalculateMaxWeight(caller) then SendChat(caller, translate.ClientFormat(caller, "notenoughspaceloot", qtycheck * itemweight, -tea_CalculateMaxWeight(caller) + tea_CalculateWeight(caller) + (qtycheck * itemweight))) return false end

	tea_SystemGiveItem(caller, name, qtycheck)

	SendChat(caller, "You picked up a boss drop cache containing [ "..qtycheck.."x "..itemname.." ]")
	tea_SystemBroadcast(caller:Nick().." has found a boss cache!", Color(255,255,255,255), true)
	tea_SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
