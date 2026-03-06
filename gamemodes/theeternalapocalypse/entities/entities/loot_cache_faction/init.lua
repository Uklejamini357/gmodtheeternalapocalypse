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
	local item = GAMEMODE.ItemsList[name]
	local itemweight = item["Weight"]

	local qty = self.LootQuantity or GAMEMODE.LootTableFaction[name]["Qty"]

	if !name or !item or !qty then caller:SendChat(translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	if !item then return false end

	gamemode.Call("SystemGiveItem", caller, name, qty)
	gamemode.Call("GiveTaskProgress", caller, "loot_finder", 1)

	caller:SendChat("You picked up a faction loot cache containing [ "..qty.."x "..GAMEMODE:GetItemName(name, caller).." ]")
	-- caller:SendChat(translate.ClientFormat(caller, "you_picked_up_a_lootcache_faction", qty, GAMEMODE:GetItemName(name, caller)))
	for _,ply in pairs(player.GetAll()) do
		ply:SystemMessage(caller:Nick().." has found a faction loot cache containing "..qty.."x "..GAMEMODE:GetItemName(name, ply).."!", Color(255,255,255,255), true)
		-- ply:SystemMessage(translate.ClientFormat(ply, "player_found_lootcache_faction", caller:Nick(), qty, GAMEMODE:GetItemName(name, caller)), Color(255,255,255), true)
	end
	GAMEMODE:SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
