AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel( "models/props/de_inferno/bed.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )
	self.UseTimer = 0
	self.BedObstructed = false

--	timer.Simple(600, function() if self.Entity:IsValid() then self.Entity:Remove() end end )

	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Think()
	if self.BedObstructed then
		local ply = self.PlayerSleeping
		if ply and ply:IsValid() and ply:IsSleeping() then
			self:NextThink(CurTime() + 1)
			return true
		else
			self.PlayerSleeping = nil
			self.BedObstructed = nil
			self:SetColor(Color(255, 255, 255))
		end
	end
end

function ENT:Use(ply, caller)
	if self.UseTimer > CurTime() then return false end
	if not ply:CheckCanSleep() then return end
	if self.BedObstructed then ply:SystemMessage("This bed is obstructed!", Color(255, 205, 205)) return end
	self.UseTimer = CurTime() + 1

	ply:GoSleep()

	self.PlayerSleeping = ply
	self.BedObstructed = true
	self:SetColor(Color(255, 0, 0)) -- for various reasons bed will be red to indicate that the bed is obstructed
end
