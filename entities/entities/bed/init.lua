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

--	timer.Simple(600, function() if self.Entity:IsValid() then self.Entity:Remove() end end )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Use( ply, caller )
	SendChat( ply, "You are now asleep" )
	umsg.Start( "DrawSleepOverlay", ply )
	umsg.End()
	ply.Fatigue = 0
	ply:SetHealth( 100 + ( ply.StatHealth * 5 ))
end