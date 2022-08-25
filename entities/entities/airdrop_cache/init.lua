AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self.Entity:SetModel( "models/props/cs_militia/crate_extrasmallmill.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )

	self:SetNWBool("ADActive", false)
	self.Decoded = false
	self.Flying = true
	self.nxtuse = CurTime()
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:EnableDrag( true )
		PhysAwake:SetDamping( 3, 0 )
		PhysAwake:SetMass( 600 )
		PhysAwake:Wake()
	end 

	self.chute = ents.Create("prop_dynamic_override")
	self.chute:SetModel( "models/props_phx/construct/metal_dome360.mdl" )
	self.chute:SetMaterial("models/props_wasteland/wood_fence01a")
	self.chute:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Up() * 80)
	self.chute:SetAngles(Angle(0,0,0))
	self.chute:SetParent(self.Entity)
	self.chute:SetSolid(SOLID_NONE)
	self.chute:SetMoveType(MOVETYPE_NONE)

	self.panel = ents.Create("prop_dynamic_override")
	self.panel:SetModel( "models/props_lab/reciever01a.mdl" )
	self.panel:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Up() * 50)
	self.panel:SetAngles(Angle(0,0,0))
	self.panel:SetParent(self.Entity)
	self.panel:SetSolid(SOLID_NONE)
	self.panel:SetMoveType(MOVETYPE_NONE)

	timer.Simple(1800, function() if self:IsValid() then self:Remove() SystemBroadcast("Airdrop crate is gone!", Color(255,105,105,255), true) end end)
end

function ENT:Use( ply, caller )
	if self.Flying or self.nxtuse > CurTime() then return end
	if !self.Decoded and !self.Decoder then
		self:EmitSound("buttons/blip2.wav", 100, 100)
		SendUseDelay( ply, 12 )
		self.nxtuse = CurTime() + 0.5
		self.Decoder = ply
		nxtuse = CurTime() + 0.5
		SendChat(ply, "STAY CLOSE TO AIRDROP CRATE AND STAY ALIVE OR THE CRATE WON'T BE OPENED")
		timer.Simple(12, function() 
			if !self.Decoder:IsValid() or !self.Decoder:Alive() or self.Decoder:GetPos():Distance( self:GetPos() ) > 120 then self.Decoder = nil return end
			SystemBroadcast( self.Decoder:Nick().." has opened an air drop crate!", Color(255,255,255,255), false)
			self.Decoded = true
			self:EmitSound("npc/scanner/scanner_pain1.wav", 85, math.Rand(90, 95))
			if self.panel:IsValid() then self.panel:Remove() end
		end)
	elseif self.Decoded then
		OpenContainer( self, ply )
		self.nxtuse = CurTime() + 0.5
	end
end

function ENT:PhysicsCollide()
if self.Flying then 
if self.chute:IsValid() then self.chute:Remove() end
self:GetPhysicsObject():SetDamping( 0, 0 )
self:SetNWBool("ADActive", true)
self.Flying = false
end

end


function ENT:Think() 

	if !self:GetNWBool("ADActive") then return end
	local owner = self:GetNWEntity("owner")
	local people = ents.FindInSphere(self:GetPos(), 1200)

	for k, v in pairs(people) do
		if v:IsValid() and v:IsPlayer() and v:Alive() and !v:IsPvPGuarded() then
			v:SetPvPGuarded( 2 )
			timer.Create("forcepvptimer"..v:UniqueID(), 1, 1, function() 
				if !v:IsValid() then return end
				v:SetPvPGuarded( 0 )
			end)
		end
	end
end