AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	local ltype = self:GetNWInt("loottype", 1)
	if ltype == LOOTTYPE_BOSS or ltype == LOOTTYPE_FACTION then
		self:SetModel("models/props/de_prodigy/ammo_can_02.mdl")
	else
		self:SetModel("models/props/cs_office/cardboard_box03.mdl")
	end

	-- Just in case.
	if self:GetNWInt("loottype", 0) == 0 then
		self:SetNWInt("loottype", LOOTTYPE_NORMAL)
	end
	if self:GetNWFloat("lootrarity", 0) == 0 then
		self:SetNWFloat("lootrarity", LOOTRARITY_COMMON)
	end

	-- self:SetModel( "models/props/cs_office/cardboard_box03.mdl" )
	-- boss: models/props/de_prodigy/ammo_can_02.mdl
	-- rare: models/Items/item_item_crate.mdl
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 	self:SetColor( Color(255, 255, 255, 255) )
	self:SetUseType( SIMPLE_USE )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if (PhysAwake:IsValid()) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction(userid, tr)
end

function ENT:Use(activator, caller)
	if !caller:IsValid() or !caller:IsPlayer() or !caller:Alive() then return false end

	local loottype = self:GetNWInt("loottype", 1)
	local lootrarity = math.Clamp(self:GetNWFloat("lootrarity", 1) + caller.StatScavenging*0.01, 1, #GAMEMODE.LootTable)
	self:SetNWInt("lootrarity", lootrarity)

	GAMEMODE:RandomizeEntityLoot(self)

	if self:GetNWEntity("pickup") and self:GetNWEntity("pickup"):IsValid() and self:GetNWEntity("pickup"):IsPlayer() and self:GetNWEntity("pickup") != caller then
		caller:SystemMessage(Format("You aren't permitted to pick up the boss cache!", self:GetNWEntity("pickup"):Nick()), Color(255,205,205), true)
		return false
	end

	
	local id = self.LootType
	local qty = self.LootQuantity or 1
	
	if !id or !qty then caller:SendChat(translate.ClientGet(caller, "buggedcache")) self:Remove() return false end
	
	local item = GAMEMODE.ItemsList[id]
	if !item then caller:SendChat(translate.ClientGet(caller, "buggedcache")) self:Remove() return false end

	gamemode.Call("SystemGiveItem", caller, id, qty)
	gamemode.Call("GiveTaskProgress", caller, "loot_finder", 1)

	net.Start("tea_lootpickup")
	net.WriteEntity(caller)
	net.WriteUInt(loottype, 4)
	net.WriteUInt(lootrarity or 1, 4)
	net.WriteString(id)
	net.WriteUInt(qty, 8) -- only 0-255.
	if ltype == LOOTTYPE_NORMAL and lrarity < LOOTRARITY_EPIC then
		net.Send(caller)
	else
		net.Broadcast()
	end
	-- caller:SendChat("You picked up a faction loot cache containing [ "..qty.."x "..GAMEMODE:GetItemName(name, caller).." ]")
	-- caller:SendChat(translate.ClientFormat(caller, "you_picked_up_a_lootcache_faction", qty, GAMEMODE:GetItemName(name, caller)))
	-- for _,ply in pairs(player.GetAll()) do
		-- ply:SystemMessage(caller:Nick().." has found a faction loot cache containing "..qty.."x "..GAMEMODE:GetItemName(name, ply).."!", Color(255,255,255,255), true)
		-- ply:SystemMessage(translate.ClientFormat(ply, "player_found_lootcache_faction", caller:Nick(), qty, GAMEMODE:GetItemName(name, caller)), Color(255,255,255), true)
	-- end

	GAMEMODE:SendInventory(caller)
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end
