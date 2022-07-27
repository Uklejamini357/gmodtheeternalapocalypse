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

--	timer.Simple(600, function() if self.Entity:IsValid() then self.Entity:Remove() end end )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Use( ply, caller )
	if self.UseTimer > CurTime() then return false end
	self.UseTimer = CurTime() + 1
if timer.Exists("IsSleeping_"..ply:UniqueID()) then SendChat(ply, "You are already sleeping, why would you sleep again??") return false end
if ply.Fatigue <= 2000 then SendChat(ply, "You are not tired") return end
if ply.Hunger <= 3000 then SendChat(ply, "You are hungry, you should eat something.") return end
if ply.Thirst <= 3000 then SendChat(ply, "You are thirsty, you should drink something.") return end
if ply.Infection >= 8000 then SendChat(ply, "You are infected, find a cure.") return end
	SendChat( ply, "You are now asleep" )
	umsg.Start( "DrawSleepOverlay", ply )
	umsg.End()
	ply.Fatigue = 0
	timer.Create( "IsSleeping_"..ply:UniqueID(), 25, 1, function()
		timer.Destroy("IsSleeping_"..ply:UniqueID())
	end )
	ply:SetHealth( ply:GetMaxHealth() )
end