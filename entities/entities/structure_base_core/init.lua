AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )


function ENT:Think() 

if !self.IsBuilt then return false end
local owner = self:GetNWEntity("owner")
local people = ents.FindInSphere(self:GetPos(), 900)

for k, v in pairs(people) do
	if v:IsValid() and v:IsPlayer() and v:Alive() and owner:IsValid() and (v:Team() != owner:Team())then

		v.Territory = team.GetName(owner:Team())

		timer.Create("factimer"..v:UniqueID(), 1, 1, function() 
		if !v:IsValid() then return false end
			v.Territory = "none"
		end)
	end
end

end

function ENT:Initialize()

	local selfent = self.Entity
	self.IsBuilt = false
	self.BuildLevel = 1
	self.integrity = 2000
	self.maxinteg = 2000
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

end 

function ENT:FinishBuild()
if self:IsValid() then
self:SetMaterial("")
self:SetColor(Color(255, 255, 255, 255))
self.IsBuilt = true
self:SetCollisionGroup( COLLISION_GROUP_NONE )
end
end



function ENT:PhysicsUpdate() end

function ENT:PhysicsCollide( data, physobj ) end

function ENT:BreakPanel()
	local vPoint = self:GetPos()
	local effectdata = EffectData()

	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(0.3)
	util.Effect("HelicopterMegaBomb", effectdata)

	local ar2Explo = ents.Create("env_ar2explosion")
		ar2Explo:SetOwner(self.Owner)
		ar2Explo:SetPos(self.Entity:GetPos())
		ar2Explo:Spawn()
		ar2Explo:Activate()
		ar2Explo:Fire("Explode", "", 0)

	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
		util.Effect("Sparks", sparkeffect)

end

function ENT:OnTakeDamage( dmg )

	local damage = dmg:GetDamage()
	local attacker = dmg:GetAttacker()
	local owner = self:GetNWEntity("owner")

	if attacker:IsPlayer() and attacker:IsValid() and attacker:Team() == 1 and attacker:GetNWBool("pvp") != true and self:GetNWEntity("owner") != attacker then -- this should stop little shitters from wrecking your base while not in pvp mode
	SystemMessage(attacker, "You cannot damage other players props unless you have PvP mode enabled!", Color(255,205,205,255), true)
	return false 
	end

	if attacker:Team() == owner:Team() then SystemMessage(attacker, "You cannot damage your own factions base core!", Color(255,205,205,255), true) return false end


	local currenthealth = self.integrity
	if dmg:IsBulletDamage() then 
		self.integrity = (self.integrity - damage / 2)
	else
		self.integrity = (self.integrity - damage)
	end

		local swag = math.Clamp(self.integrity / 8 , 0, 255)

		self:SetColor(Color(swag +5,swag+5,swag+5,255))

		if self.integrity - damage < 0 or self.IsBuilt == false then
			self:BreakPanel()
--			self.Entity:EmitSound("physics/wood/wood_plank_break"..math.random(1,2)..".wav", 100, 100)
			self.Entity:EmitSound("npc/dog/car_impact1.wav", 120, 100)
			SystemBroadcast("The "..team.GetName(owner:Team()).."s base has been destroyed!", Color(205,205,255,255), true)
			if self.IsBuilt then
			local EntDrop = ents.Create( "loot_cache_faction" )
			EntDrop:SetPos( self:GetPos() + Vector(0, 0, 30) )
			EntDrop:SetAngles( self:GetAngles() )
			EntDrop.LootType = table.Random(LootTableFaction)["Class"]
			EntDrop:Spawn()
			EntDrop:Activate()

			if attacker:IsPlayer() then
			Payout(attacker, 5000, 5000, 5000, 5000)
			end

			end

			self.Entity:Remove()
		end
end