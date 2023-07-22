AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self.Entity:SetModel("models/props/cs_militia/crate_extrasmallmill.mdl")
 	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
 	self.Entity:SetColor(Color(255, 255, 255, 255))
	self.Entity:SetUseType(SIMPLE_USE)

	self:SetNWBool("ADActive", false)
	self:GetADOpenedStatus(false)
	self.Flying = true
	self.nxtuse = CurTime()
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:EnableDrag(true)
		PhysAwake:SetDamping(3, 0)
		PhysAwake:SetMass(600)
		PhysAwake:Wake()
	end 

	self.chute = ents.Create("prop_dynamic_override")
	self.chute:SetModel("models/props_phx/construct/metal_dome360.mdl")
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

	timer.Simple(1800, function() if self:IsValid() then self:Remove() GAMEMODE:SystemBroadcast("Airdrop crate is gone!", Color(255,105,105,255), true) end end)
end

function ENT:Use(ply, caller)
	if self.Flying or self.nxtuse > CurTime() then return end
	if !self:GetADOpenedStatus() and !self.Decoder then
		self:EmitSound("buttons/blip2.wav", 100, 100)
--		ply:SendUseDelay(12)
		self.nxtuse = CurTime() + 0.5
		self:SetADOpeningTime(CurTime() + 30)
		self:SetADOpeningPlayer(ply)
		self:SetADOpeningStatus(true)

		ply:SendChat("Opening airdrop crate... It will take 30 seconds to open.")
	elseif self:GetADOpenedStatus() then
		GAMEMODE:OpenContainer(self, ply)
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
			v:SetPvPGuarded(2)
			timer.Create("forcepvptimer"..v:EntIndex(), 1, 1, function() 
				if !v:IsValid() then return end
				v:SetPvPGuarded(0)
			end)
		end
	end

	local decodingply = self:GetADOpeningPlayer()
	if self:GetADOpeningStatus() then
		if self:GetADOpeningTime() <= CurTime() and decodingply:IsValid() and decodingply:Alive() and decodingply:GetPos():DistToSqr(self:GetPos()) <= 62500 then --250^2
			GAMEMODE:SystemBroadcast(decodingply:Nick().." has opened an air drop crate!", Color(255,255,255,255), false)
			self:SetADOpenedStatus(true)
			self:SetADOpeningPlayer(ply)
			self:SetADOpeningStatus(false)
			self:EmitSound("npc/scanner/scanner_pain1.wav", 85, math.Rand(90, 95))
			if self.panel and self.panel:IsValid() then self.panel:Remove() end
		elseif !decodingply:IsValid() or !decodingply:Alive() or decodingply:GetPos():DistToSqr(self:GetPos()) > 62500 then --250^2
			decodingply:SystemMessage("You moved too far away from airdrop crate or died!", Color(255,155,155), true)
			self:SetADOpeningPlayer(NULL)
			self:SetADOpeningStatus(false)
		end
	end
end
