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
	if self:GetNWEntity("pickup") and self:GetNWEntity("pickup"):IsValid() and self:GetNWEntity("pickup"):IsPlayer() and self:GetNWEntity("pickup") != caller then
		caller:SystemMessage(Format("You can't pick up the boss cache! Only %s can pick it up!", self:GetNWEntity("pickup"):Nick()), Color(255,205,205), true)
		return false
	end

	local name = self.LootType
	local item = GAMEMODE.ItemsList[name]
	local itemweight = item["Weight"]
	local itemname = translate.ClientGet(caller, name.."_n")

	local qtycheck = GAMEMODE.LootTableBoss[name]["Qty"]

	if !name or !item or !qtycheck then caller:SendChat(translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	if !item then return false end
	-- if (caller:CalculateWeight() + (qtycheck * itemweight)) > caller:CalculateMaxWeight() then caller:SendChat(translate.ClientFormat(caller, "notenoughspaceloot", qtycheck * itemweight, -caller:CalculateMaxWeight() + caller:CalculateWeight() + (qtycheck * itemweight))) return false end

	gamemode.Call("SystemGiveItem", caller, name, qtycheck)
	gamemode.Call("GiveTaskProgress", caller, "loot_finder", 1)

	caller:SendChat("You picked up a boss drop cache containing [ "..qtycheck.."x "..itemname.." ]")
	GAMEMODE:SystemBroadcast(caller:Nick().." has found a boss cache containing "..qtycheck.."x "..itemname.."!", Color(255,255,255,255), true)
	GAMEMODE:SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
