AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/PlasticCrate01a.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )

	local cash = (self:GetNWInt("CashAmount") or 1)

	self.cashwad = ents.Create("prop_dynamic_override")
	self.cashwad:SetModel( "models/props/cs_assault/Money.mdl" )
	self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * 0 +self.Entity:GetAngles():Right() * 0 + self.Entity:GetAngles():Up() * -7)
	self.cashwad:SetAngles(Angle(0,90,0))
	self.cashwad:SetParent(self.Entity)
	self.cashwad:SetSolid(SOLID_NONE)
	self.cashwad:SetMoveType(MOVETYPE_NONE)

	if cash > 500 then
		self.cashwad = ents.Create("prop_dynamic_override")
		self.cashwad:SetModel( "models/props/cs_assault/Money.mdl" )
		self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * 0 +self.Entity:GetAngles():Right() * 6 + self.Entity:GetAngles():Up() * -7)
		self.cashwad:SetAngles(Angle(0,5,0))
		self.cashwad:SetParent(self.Entity)
		self.cashwad:SetSolid(SOLID_NONE)
		self.cashwad:SetMoveType(MOVETYPE_NONE)

		self.cashwad = ents.Create("prop_dynamic_override")
		self.cashwad:SetModel( "models/props/cs_assault/Money.mdl" )
		self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * 2 +self.Entity:GetAngles():Right() * -8 + self.Entity:GetAngles():Up() * -7)
		self.cashwad:SetAngles(Angle(0,340,0))
		self.cashwad:SetParent(self.Entity)
		self.cashwad:SetSolid(SOLID_NONE)
		self.cashwad:SetMoveType(MOVETYPE_NONE)
	end


	if cash > 2000 then
		self.cashwad = ents.Create("prop_dynamic_override")
		self.cashwad:SetModel( "models/props_lab/box01a.mdl" )
		self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * -5 +self.Entity:GetAngles():Right() * 1 + self.Entity:GetAngles():Up() * -4)
		self.cashwad:SetAngles(Angle(0,5,0))
		self.cashwad:SetParent(self.Entity)
		self.cashwad:SetSolid(SOLID_NONE)
		self.cashwad:SetMoveType(MOVETYPE_NONE)
	end

	if cash > 5000 then
		self.cashwad = ents.Create("prop_dynamic_override")
		self.cashwad:SetModel( "models/props_lab/box01a.mdl" )
		self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * -5 +self.Entity:GetAngles():Right() * -8 + self.Entity:GetAngles():Up() * -4)
		self.cashwad:SetAngles(Angle(0,5,0))
		self.cashwad:SetParent(self.Entity)
		self.cashwad:SetSolid(SOLID_NONE)
		self.cashwad:SetMoveType(MOVETYPE_NONE)

		self.cashwad = ents.Create("prop_dynamic_override")
		self.cashwad:SetModel( "models/props/cs_assault/Money.mdl" )
		self.cashwad:SetPos(self.Entity:GetPos() + self.Entity:GetAngles():Forward() * 5 +self.Entity:GetAngles():Right() * -1 + self.Entity:GetAngles():Up() * -7)
		self.cashwad:SetAngles(Angle(0,95,0))
		self.cashwad:SetParent(self.Entity)
		self.cashwad:SetSolid(SOLID_NONE)
		self.cashwad:SetMoveType(MOVETYPE_NONE)
	end

	--"models/props_lab/box01a.mdl"
	--models/props/cs_assault/Money.mdl

	timer.Simple(3600, function() if self:IsValid() then self:Remove() end end )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction(userid, tr)
end

function ENT:Use(activator, caller)
	if !activator:IsValid() or !activator:IsPlayer() or !self:GetNWString("CashAmount") or !activator:Alive() then return false end
	if activator:KeyDown(IN_RELOAD) or activator:GetInfoNum("tea_cl_usereloadtopickup", 0) < 1 then
		local cash = self:GetNWInt("CashAmount")

		activator.Money = activator.Money + cash

		activator:SystemMessage(Format("You picked up a box containing %s %s(s)!", cash, GAMEMODE.Config["Currency"]), Color(205,255,205,255), true)
		GAMEMODE:NetUpdatePeriodicStats(activator)

		activator:EmitSound("items/itempickup.wav", 100, 100)
		self:Remove()
	else
		activator:PrintMessage(HUD_PRINTCENTER, "R+E to pick up")
		activator:PickupObject(self)
	end
end
