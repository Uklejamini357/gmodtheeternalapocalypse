AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

function ENT:SpawnFunction( userid, tr )
	local trace = util.GetPlayerTrace( userid, userid:GetCursorAimVector() )
	local tr = util.TraceLine( trace )
	local thisent = ents.Create( "trader" )
		thisent:SetPos( tr.HitPos + tr.HitNormal * 32 )
		thisent:SetAngles( Angle( 0, 0, 0 ) )
		thisend:SetNetworkedString( "Owner", "World" )
		thisent:Spawn()
		thisent:DropToFloor()
		thisent:Activate()
end

function ENT:Think() 

local people = ents.FindInSphere(self:GetPos() + Vector(0, 0, 20), 120)

for k, v in pairs(people) do
	if v:IsValid() and v:IsPlayer() and v:Alive() and !v:IsPvPForced() then

		v:SetPvPGuarded( 1 )

		timer.Create("pvpguardtimer"..v:UniqueID(), 3, 1, function() 
		if !v:IsValid() then return false end
			v:SetPvPGuarded( 0 )
		end)
	end
end

--shouldn't cause too many unsignificant problems (trader himself will not be targetted by anyone)
local meta = self
local tbNPCsNoTarget = {}
local AddEntityRelationship = meta.AddEntityRelationship
tbNPCsNoTarget[self] = {}
for _,ent in ipairs(ents.GetAll()) do
	if(ent:IsNPC() and ent ~= self) then
		tbNPCsNoTarget[self][ent] = ent:Disposition(self)
		AddEntityRelationship(ent,self,D_NU,100)
	end
end


end


function ENT:Initialize( )
	self:SetModel( "models/odessa.mdl" )
 	self:SetHullType( HULL_HUMAN )
	self:SetUseType( SIMPLE_USE )
	self:SetHullSizeNormal( )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE || CAP_USE_SHOT_REGULATOR || CAP_TURN_HEAD || CAP_AIM_GUN )
	self:SetMaxYawSpeed( 5000 )
	self.IsUsed = 0
	local PhysAwake = self.Entity:GetPhysicsObject( )
	if PhysAwake:IsValid( ) then
		PhysAwake:Wake( )
	end

end

function ENT:OnTakeDamage( dmg )
	return false
end

function ENT:AcceptInput( input, ply, caller )
	if input == "Use" && ply:IsPlayer() && ply:KeyPressed( 32 ) then
		net.Start( "OpenTraderMenu" )
		net.Send(ply)
		if self.IsUsed != 1 then
		self:EmitSound("vo/npc/male01/hi0"..math.random(1,2)..".wav")
		self.IsUsed = 1
		timer.Simple(10, function() self.IsUsed = 0 end)
		end
--ply:ConCommand( "play vo/coast/odessa/nlo_cub_hello.wav" )
	end
end