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
	self.BedObstructed = 0

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
if ply.Fatigue <= 2000 then SendChat(ply, "You are not tired") return false end
if ply.Hunger <= 3000 then SendChat(ply, "You are hungry, you should eat something.") return false end
if ply.Thirst <= 3000 then SendChat(ply, "You are thirsty, you should drink something.") return false end
if ply.Infection >= 8000 then SendChat(ply, "You are infected, find a cure.") return false end
if self.BedObstructed == 1 then SendChat(ply, "This bed is obstructed!") return false end
	SendChat( ply, "You are now asleep" )
	umsg.Start( "DrawSleepOverlay", ply )
	umsg.End()
	ply.Fatigue = 0
	ply:Freeze(true)
	self.BedObstructed = 1
	self.Entity:SetColor(Color(255, 0, 0, 255)) --for various reasons bed will be red to indicate that the bed is obstructed
	timer.Simple(25, function()
		self.BedObstructed = 0
		self.Entity:SetColor( Color(255, 255, 255, 255) )
		ply:Freeze(false)
	end)
	ply:SetHealth(math.Clamp(ply:Health() + (0.05 * ply:GetMaxHealth()), 1, ply:GetMaxHealth())) --heal 5% of player's max health
end