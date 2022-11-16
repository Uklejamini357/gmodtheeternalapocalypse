ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Ammo Pile"
ENT.Author			= "LegendofRobbo"
/*
 function ENT:SetupDataTables()
 	self:NetworkVar( "Float", 0, "Integrity" )
 end
*/

ENT.Spawnable			= false
ENT.AdminOnly			= false


function ENT:SpawnFunction(ply, tr) -- spawnfunction isnt actually used within zombified world but i left it here for debug purposes (alright)
return false
end

function ENT:Initialize()
	local selfent = self.Entity
	self.IsBuilt = false
	self.UseTimer = CurTime()
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


	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end	
end

function ENT:Use(activator, caller)
	local owner = self:GetNWEntity("owner")
	if !self.IsBuilt then return false end
	if !self.IsPowered then SystemMessage(activator, "This isn't powered by faction base core!", Color(255,205,205,255), true) return false end
	if activator:Team() != owner:Team() then SystemMessage(activator, "This doesn't belong to your faction!", Color(255,205,205,255), true) return false end
	if self.UseTimer > CurTime() then SystemMessage(activator, "You must wait for "..math.ceil(self.UseTimer - CurTime()).." more seconds before being able to refill your ammo again!", Color(255,205,205,255), true) return false end

	if activator:GetAmmoCount( "Pistol" ) < 200 then
		activator:SetAmmo( 200, "Pistol" )
	end
	if activator:GetAmmoCount( "Buckshot" ) < 100 then
		activator:SetAmmo( 100, "Buckshot" )
	end
	if activator:GetAmmoCount( "ammo_rifle" ) < 250 then
		activator:SetAmmo( 250, "ammo_rifle" )
	end
	if activator:GetAmmoCount( "357" ) < 100 then
		activator:SetAmmo( 100, "357" )
	end
	if activator:GetAmmoCount( "ammo_sniper" ) < 100 then
		activator:SetAmmo( 100, "ammo_sniper" )
	end
	if activator:GetAmmoCount( "SMG1" ) < 100 then
		activator:SetAmmo( 100, "SMG1" )
	end
	activator:EmitSound("items/ammopickup.wav")
	SystemMessage(activator, "You refilled your ammo!", Color(205,255,205,255), true)
	self.UseTimer = CurTime() + 40
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
	local powered = false
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 900)) do
		if v:GetClass() == "structure_base_core" and v.IsBuilt and v:GetNWEntity("owner") and v:GetNWEntity("owner"):Team() == self:GetNWEntity("owner"):Team() then
			powered = true
		end
	end
	self.IsPowered = powered
end


function ENT:OnTakeDamage( dmg )
	local damage = dmg:GetDamage()
	local attacker = dmg:GetAttacker()

	if attacker:IsPlayer() and attacker:IsValid() and attacker:Team() == 1 and attacker:GetNWBool("pvp") != true and self:GetNWEntity("owner") != attacker then -- this should stop little shitters from wrecking your base while not in pvp mode
	SystemMessage(attacker, "You cannot damage other players props unless you have PvP mode enabled!", Color(255,205,205,255), true)
	return false 
	end


	local currenthealth = self.integrity
	if dmg:IsBulletDamage() then 
		self.integrity = (self.integrity - damage / 2)
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

		self:SetColor(Color(swag + 5,swag + 5,swag + 5,255))

		if self.integrity - damage < 0 or !self.IsBuilt then
			if attacker:IsPlayer() and self.IsBuilt then
				Payout(attacker, 850, 850, 1000, 1000)
			elseif attacker:IsPlayer() and !self.IsBuilt then
				SystemMessage(attacker, "nice try", Color(255,230,230,255), false)
			end

			self:BreakPanel()
			self.Entity:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)              
			self.Entity:Remove()
		end
end


function ENT:PhysicsUpdate() end

function ENT:PhysicsCollide(data, physobj) end

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
