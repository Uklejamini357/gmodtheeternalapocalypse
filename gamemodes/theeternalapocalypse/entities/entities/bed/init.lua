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

function ENT:Use(ply, caller)
	if self.UseTimer > CurTime() then return false end
	self.UseTimer = CurTime() + 1
	if timer.Exists("IsSleeping_"..ply:EntIndex()) then ply:SendChat("You are already sleeping, why would you sleep again??") return false end
	if ply.Fatigue <= 2000 then ply:SendChat("You are not tired") return false end
	if ply.Hunger <= 3000 then ply:SendChat("You are hungry, you should eat something.") return false end
	if ply.Thirst <= 3000 then ply:SendChat("You are thirsty, you should drink something.") return false end
	if ply.Infection >= 8000 then ply:SendChat("You are infected, find a cure.") return false end
	if self.BedObstructed then ply:SendChat("This bed is obstructed!") return false end
	ply:SendChat("You are now asleep")
	umsg.Start("DrawSleepOverlay", ply)
	umsg.End()
	ply.Fatigue = 0
	ply:Freeze(true)
	self.BedObstructed = true
	self.Entity:SetColor(Color(255, 0, 0, 255)) -- for various reasons bed will be red to indicate that the bed is obstructed

	local handler = "bed_timer_unobstruct_"..self:EntIndex().."_"..ply:EntIndex()
	timer.Create(handler, 25, 1, function() self.BedObstructed = false end)
	timer.Create("bed_timer_"..self:EntIndex().."_"..ply:EntIndex(), 1, 0, function()
		if self.BedObstructed and ply:IsValid() and ply:Alive() then return end
		self.BedObstructed = false
		self.Entity:SetColor(Color(255, 255, 255, 255)) -- then set it back to normal
		ply:Freeze(false)
		timer.Remove(handler)
	end)
	ply:SetHealth(math.Clamp(ply:Health() + (0.05 * ply:GetMaxHealth()), 1, ply:GetMaxHealth())) --heal 5% of player's max health
end