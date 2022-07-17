ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Faction Door"
ENT.Author			= "LegendofRobbo"
/*
 function ENT:SetupDataTables()
 	self:NetworkVar( "Float", 0, "Integrity" )
 end
*/

ENT.Spawnable			= false
ENT.AdminOnly			= false


function ENT:SpawnFunction( ply, tr ) -- spawnfunction isnt actually used within zombified world but i left it here for debug purposes
return false
end

function ENT:Initialize()

	local selfent = self.Entity
	self.IsBuilt = false
	self.IsOpen = false
	self.Public = 0
	self.BuildLevel = 1
	self.integrity = 1000
	self.maxinteg = 1000
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( 3 )
--	self:SetModel("models/props_c17/light_cagelight02_on.mdl")

	self:SetMaterial("models/wireframe")
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )

	self:SetColor(Color(105, 105, 105, 100))
/*
	timer.Simple(3, function() 
	if self:IsValid() then
	self:SetMaterial("")
	self:SetColor(Color(255, 255, 255, 255))
	self.IsBuilt = true
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	end
	end)
*/

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end	

/*
	timer.Simple(3, function()
	if not self:IsValid() then return false end


	local ent = self
	local mins, maxs = ent:LocalToWorld(ent:OBBMins( )), ent:LocalToWorld(ent:OBBMaxs( ))
	local cube = ents.FindInBox( mins, maxs )

		for _,v in pairs(cube) do
			if v:IsPlayer() or v:IsNPC() or v.Type == "nextbot" then self:Remove()
			if v:IsPlayer() then
 			SendChat( v, "Unable to build prop, biological obstruction detected" )
 			end
		end
	end

end)
*/

end

function ENT:Use(activator, caller)
local owner = self:GetNWEntity("owner")
if activator != owner then SystemMessage(activator, "You don't own this door!", Color(255,205,205,255), true) return false end
if self.Public == 0 then
	SystemMessage(activator, "Set door to public!", Color(205,255,205,255), true)
	self.Public = 1
elseif self.Public == 1 then
	SystemMessage(activator, "Set door to sealed!", Color(205,255,205,255), true)
	self.Public = 2
else
	SystemMessage(activator, "Set door to faction only!", Color(205,255,205,255), true)
	self.Public = 0
end

end 

function ENT:FinishBuild()
if self:IsValid() then
self:SetMaterial("")
self:SetColor(Color(255, 255, 255, 255))
self.IsBuilt = true
self:SetCollisionGroup( COLLISION_GROUP_NONE )
end
end

function ENT:Think() 

if !self.IsBuilt or self.IsOpen then return false end
local owner = self:GetNWEntity("owner")
local people = ents.FindInSphere(self:GetPos(), 25)
for k, v in pairs(people) do
	if v:IsValid() and v:IsPlayer() and v:Alive() and owner:IsValid() and self.Public != 2 then
		if (v:Team() == owner:Team()) or self.Public == 1 then 
		self:OpenDoor()
		end
	end
end

end


function ENT:OpenDoor()
self:SetMaterial("effects/com_shield002a")
self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
self.IsOpen = true
timer.Simple(2, function()
if !self:IsValid() then return false end 
self:SetMaterial("")
self:SetCollisionGroup( COLLISION_GROUP_NONE )
self.IsOpen = false
end)

end


function ENT:OnTakeDamage( dmg )
/*
self:SetHealth( self:Health() - dmg:GetDamage() )
local ColorAmount =  ( ( self:Health() / self.maxhealth ) * 255 )
self:SetColor( Color(ColorAmount, ColorAmount, ColorAmount, 255) )
if self:Health() <= 0 then
	self:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
	self:Remove()
end
*/
	local damage = dmg:GetDamage()
	local attacker = dmg:GetAttacker()

	if attacker:IsPlayer() and attacker:IsValid() and attacker:Team() == 1 and attacker:GetNWBool("pvp") != true and self:GetNWEntity("owner") != attacker then -- this should stop little shitters from wrecking your base while not in pvp mode
	SystemMessage(attacker, "You cannot damage other players props unless you have PvP mode enabled!", Color(255,205,205,255), true)
	return false 
	end


	local currenthealth = self.integrity
	if dmg:IsBulletDamage() then 
		return false
	else
		self.integrity = (self.integrity - damage)
	end

		local shit = math.floor(self.maxinteg / 500)
		local swag
		if shit == 1 then swag = math.Clamp(self.integrity / 2 , 0, 255)
		elseif shit == 2 then swag = math.Clamp(self.integrity / 4 , 0, 255)
		else
		swag = math.Clamp(self.integrity / 6 , 0, 255)
		end

		self:SetColor(Color(swag +5,swag+5,swag+5,255))

		if self.integrity - damage < 0 or self.IsBuilt == false then
			self:BreakPanel()
--			self.Entity:EmitSound("physics/wood/wood_plank_break"..math.random(1,2)..".wav", 100, 100)
			self.Entity:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)              
			self.Entity:Remove()
		end
end


function ENT:PhysicsUpdate() end

function ENT:PhysicsCollide( data, physobj ) 


end

function ENT:BreakPanel()
	local vPoint = self:GetPos()
	local effectdata = EffectData()

	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(0.3)
	util.Effect("HelicopterMegaBomb", effectdata)

	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
		util.Effect("Sparks", sparkeffect)

end