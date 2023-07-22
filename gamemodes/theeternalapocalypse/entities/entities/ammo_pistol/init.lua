AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel( "models/Items/BoxSRounds.mdl" )
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
	caller:GiveAmmo(100, "Pistol")
	caller:SystemMessage("Why does this even exist?!?!?", Color(255,255,255), false)
	tea_SendInventory(caller)
	timer.Simple(math.Rand(35,50), function()
		caller:SystemMessage("ok bye", Color(255,64,64), false)
		timer.Simple(math.Rand(20,300), function()
			caller:Kill()
		end)
	end) --for fun
	self:EmitSound("items/itempickup.wav", 100, 100)
	self.Entity:Remove()
end

function ENT:AcceptInput( input, ply )
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
function ENT:KeyValue( k, v )
end

--Called when a save-game is loaded.
function ENT:OnRestore()
end

--Called when something hurts the entity.
function ENT:OnTakeDamage( dmiDamage )
end

--Controls/simulates the physics on the entity.
--Return: (SimulateConst) sim, (Vector) linear_force and (Vector) angular_force
function ENT:PhysicsSimulate( pobPhysics,numDeltaTime )
end

--Called when an entity starts touching this SENT.
function ENT:StartTouch( entEntity )
end

--Called when an entity is no longer touching this SENT.
function ENT:EndTouch(entEntity)
end

--Called when the SENT thinks.
function ENT:Think()
end

--Called when an entity touches this SENT.
function ENT:Touch( entity )
end

--Called when: 
--TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState( entEntity )
end