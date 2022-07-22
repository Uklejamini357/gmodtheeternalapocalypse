AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Shambler Zombie"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetUpStats()

-- animations for the StartActivity function
self.AttackAnim = (ACT_MELEE_ATTACK1)
self.WalkAnim = (ACT_WALK)
self.RunAnim = (ACT_WALK)

self.FlinchAnim = (ACT_FLINCH_PHYSICS)
self.FallAnim = (ACT_IDLE_ON_FIRE)


self.ZombieStats = {
["Model"] = "models/zombie/classic.mdl",

["Damage"] = 35, -- how much damage per strike?
["Force"] = 400, -- how far to knock the player back upon striking them
["Infection"] = 8, -- percentage chance to infect them
["Reach"] = 60, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 0.8, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 1, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 180, -- self explanatory
["MoveSpeedWalk"] = 50, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 115, -- zombies move speed when moving towards a target
["VisionRange"] = 1200, -- how far is the zombies standard sight range in source units, this will be tripled when they are frenzied
["LoseTargetRange"] = 1500, -- how far must the target be from the zombie before it will lose interest and revert to wandering, this will be tripled when the zombie is frenzied

["Ability1"] = false, -- does the zombie have a special ability?
["Ability1Range"] = 0, -- at what range from the player will this ability be triggered
["Ability1Cooldown"] = 0, -- how many seconds before this ability can be activated again
["Ability1TrigDelay"] = 0, -- the actual ability will run this many seconds after the condition for it being triggered, used for the leaper zombie

}


self.AttackSounds = {"npc/zombie/zo_attack1.wav",
"npc/zombie/zo_attack2.wav"
}

self.AlertSounds = {"npc/zombie/zombie_alert1.wav", 
"npc/zombie/zombie_alert2.wav", 
"npc/zombie/zombie_alert3.wav"
}

self.IdleSounds = {
"npc/zombie/zombie_voice_idle1.wav",
"npc/zombie/zombie_voice_idle2.wav",
"npc/zombie/zombie_voice_idle3.wav",
"npc/zombie/zombie_voice_idle4.wav",
"npc/zombie/zombie_voice_idle5.wav",
"npc/zombie/zombie_voice_idle6.wav",
"npc/zombie/zombie_voice_idle7.wav",
"npc/zombie/zombie_voice_idle8.wav",
"npc/zombie/zombie_voice_idle9.wav"
}

self.PainSounds = {"npc/zombie/zombie_pain1.wav",
"npc/zombie/zombie_pain2.wav", 
"npc/zombie/zombie_pain3.wav", 
"npc/zombie/zombie_pain4.wav", 
"npc/zombie/zombie_pain5.wav", 
"npc/zombie/zombie_pain6.wav"
}

self.DieSounds = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav", 
"npc/zombie/zombie_die3.wav"
}

self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

self.Hit = Sound("npc/zombie/zombie_hit.wav")
self.Miss = Sound("npc/zombie/claw_miss1.wav")

self.CanScream = true
self.RageLevel = 1
self.SpeedBuff = 1

self.Ability1CD = CurTime()
end

function ENT:CanSeeTarget()
if !self:IsValid() then return false end
if self.target != nil then
	local tracedata = {}
	tracedata.start = self:GetPos() + Vector(0, 0, 30)
	tracedata.endpos = self.target:GetPos() + Vector(0, 0, 30)
	tracedata.filter = self
	local trace = util.TraceLine(tracedata)
	if trace.HitWorld == false then
		return true
	else 
	return false
	end
else
return false
end
end


function ENT:Precache()

--Models--
util.PrecacheModel(self.ZombieStats["Model"])

end


function ENT:Initialize()
	if CLIENT then return end
	self:SetUpStats()
	self:SetModel(self.ZombieStats["Model"])
	self.NextVehicleCollide = CurTime()
	self.loco:SetDeathDropHeight(700)
	self:SetHealth(self.ZombieStats["Health"])
	self:SetCollisionBounds(Vector(-12,-12, 0), Vector(12, 12, 64))
	self.NxtTick = 5
end


function ENT:DelayedCallback(delay, callback)
	timer.Simple(delay, function()
		if self:IsValid() then
			callback()
		end
	end)
end

function ENT:OnContact( ent )
if self.NextVehicleCollide > CurTime() then return end
if ent:IsVehicle() and ent:GetVelocity():Length() > 300 then
	ent:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, math.random( 80, 90) )

	local ded2 = DamageInfo()
	ded2:SetDamage( 0 )
	print( "taken: "..math.min( (self:Health() / 4), ent:GetVelocity():Length() / 28 ).." dealt: "..ent:GetVelocity():Length() / 2.5 )
	ded2:SetDamageType( DMG_VEHICLE )
	local f = (ent:GetPos() - self:GetPos() * 200) * ent:GetVelocity():Length() / 800
	ded2:SetDamageForce( f )
	ent:TakeDamageInfo( ded2 )

	local ded = DamageInfo()

	ded:SetDamage( ent:GetVelocity():Length() )
	ded:SetDamageType( DMG_VEHICLE )
	if ent:GetDriver():IsValid() then ded:SetAttacker( ent:GetDriver() ) else ded:SetAttacker( game.GetWorld() ) end
	self:TakeDamageInfo( ded )

	self.NextVehicleCollide = CurTime() + 0.5

end
end

function ENT:Think()
if !IsValid(self) then return end

-- need to drown them in water otherwise the stupid fucks will just skip happily along the sea floor
if  ( self:WaterLevel() >= 3 ) then
	local drown = DamageInfo()
	drown:SetDamage( 10000 )
	drown:SetDamageType( DMG_DROWN )
	drown:SetAttacker( game.GetWorld() )
	drown:SetDamageForce( Vector( 0, 0, 0 ) )
	self:TakeDamageInfo( drown )
end

end


function ENT:SpecialSkill1()
return true
end


function ENT:RunBehaviour()
while (true) do
if CLIENT then return end

local target = self.target


if IsValid(target) and target:Alive() and self:GetRangeTo(target) <= (1500 * self.RageLevel) then
	self.loco:FaceTowards(target:GetPos())

	if self.NxtTick < 1 then
		if math.random( 1,500) < 25 then
			self:EmitSound( table.Random(self.IdleSounds) )
		end

-- check if we are obstructed by props and smash them if we are
		local breakshit = ents.FindInSphere(self:GetPos() + self:GetAngles():Up() * 55, 35)

		for k, v in pairs(breakshit) do
			if v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong" or SpecialSpawns[v:GetClass()] then
				self:AttackProp(v)
			elseif v:GetClass() == "prop_door_rotating" and v:GetNoDraw() == false then
			self:AttackDoor(v)
			else continue end
		end
		self.NxtTick = 5
	else
		self.NxtTick = self.NxtTick - 1
	end


-- run our first ability
if self.ZombieStats["Ability1"] and self:GetRangeTo(target) <= self.ZombieStats["Ability1Range"] then

	if self.Ability1CD <= CurTime() then
		timer.Simple(self.ZombieStats["Ability1TrigDelay"], function()
		if !self:IsValid() then return false end
		local bool = self:SpecialSkill1()
		if bool == true then self.Ability1CD = CurTime() + self.ZombieStats["Ability1Cooldown"] end		
		end )
	end

end

-- check if we have a player within arms reach and bash them if they are
		if (self:GetRangeTo(target) <= self.ZombieStats["Reach"] * 0.8 && self:CanSeeTarget() ) then

			self:AttackPlayer(target)

			self:StartActivity(self.AttackAnim)
			coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
			self:StartActivity( self.WalkAnim )	


-- we can see a player but we cant reach them so lets go fuck their shit up
		else
			self:StartActivity(self.RunAnim)

			self.loco:SetDesiredSpeed(self.ZombieStats["MoveSpeedRun"] * self.SpeedBuff)
			self:MoveToPos(target:GetPos(), {
				tolerance = self.ZombieStats["Reach"],
				maxage = 1,
				repath = 1,
			})
		end

-- failed all above checks, they arent in range so we lose interest and go back to wandering
else
self.target = nil
self.CanScream = true
self:StartActivity(self.WalkAnim)
self.loco:SetDesiredSpeed(self.ZombieStats["MoveSpeedWalk"])
self:MoveToPos(self:GetPos() + Vector(math.random(-256, 256), math.random(-256, 256), 0), {
	repath = 3,
	maxage = 3,
})

-- find ourselves a new target
	if (!self.target) then
		for k, v in pairs(player.GetAll()) do
			if (v:Alive() and self:GetRangeTo(v) <= (1200 * self.RageLevel)) then
				self.target = v
				if self.CanScream == true then
				self:EmitSound(table.Random(self.AlertSounds), 90, math.random(90, 110))
				self.CanScream = false
				end
				break
			end
		end
	end


		end

		coroutine.yield()
	end
end

function ENT:OnLandOnGround()
	self:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
end



function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()
/*
	if( attacker:IsPlayer() ) then
		Payout(attacker, self.XPMin, self.XPMax, self.MoneyMin, self.MoneyMax)
	end
*/
	self:EmitSound(table.Random(self.DieSounds), 100, math.random(75, 130))
	self:BecomeRagdoll(damageInfo)
	timer.Simple(1, function()
	self:Remove()
	end)
end

function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local range = self:GetRangeTo(attacker)

	self:EmitSound(table.Random(self.PainSounds), 100, math.random(90, 110))
	if attacker:IsPlayer() then
	self.target = attacker
	end

	self.RageLevel = 3
end



function ENT:AttackPlayer(ply)
if !ply:IsValid() or !self:IsValid() then return false end
self:EmitSound(table.Random(self.AttackSounds), 100, math.random(95, 105))

-- swing those claws baby
self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 0.75, function()
	self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
end)

-- actually apply the damage
self:DelayedCallback(self.ZombieStats["StrikeDelay"], function()
if !self:IsValid() or self:Health() < 1 then return end
					
	if (IsValid(ply) and self:GetRangeTo(ply) <= self.ZombieStats["Reach"]) then
		self:ApplyPlayerDamage(ply, self.ZombieStats["Damage"], -self.ZombieStats["Force"], self.ZombieStats["Infection"])
	end
end)

-- check if we killed the guy and find a new target if we did
self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 1.2, function()
if (IsValid(ply) and !ply:Alive()) then
	self.target = nil
end
end)

return false
end



function ENT:AttackProp(target)
if !target:IsValid() then return false end
	
self:StartActivity(self.AttackAnim)

coroutine.wait(self.ZombieStats["StrikeDelay"])
self:EmitSound(self.Miss)

local phys = target:GetPhysicsObject()
if (phys != nil && phys != NULL && phys:IsValid()) then
phys:ApplyForceCenter(self:GetForward():GetNormalized()*30000 + Vector(0, 0, 2))
target:EmitSound(self.Hit, 100, math.random(80, 110))
target:EmitSound(self.DoorBreak)
target:TakeDamage(self.ZombieStats["Damage"], self)	
util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 300)
end
coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
self:StartActivity( self.WalkAnim )
end




function ENT:AttackDoor(target)
if !target:IsValid() or !target:GetClass() == "prop_door_rotating" then return false end

target:EmitSound("physics/wood/wood_plank_break"..math.random(1, 4)..".wav", 100, math.random(90, 100))

local effect = EffectData()
local position = target:LocalToWorld(target:OBBCenter()) + target:GetRight()*math.random(-16, 16) + target:GetUp()*math.random(-16, 16)
effect:SetStart(position)
effect:SetOrigin(position)
util.Effect("GlassImpact", effect)

util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 360)

local pos = target:GetPos()
local ang = target:GetAngles()
local model = target:GetModel()
local skin = target:GetSkin()

target:Fire("open", "", 0.1)
target:Fire("unlock", "", 0.1)
target:SetNotSolid(true)
target:SetNoDraw(true)

local function ResetDoor(door, fakedoor)
	door:SetNotSolid(false)
	door:SetNoDraw(false)
	fakedoor:Remove()
end

local push = self:GetPos():Normalize()
local ent = ents.Create("prop_physics")

ent:SetPos(pos)
ent:SetAngles(ang)
ent:SetModel(model)
ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			
if(skin) then
	ent:SetSkin(skin)
end

ent:Spawn()
timer.Simple( 30, function() ResetDoor(target, ent) end)
coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
self:StartActivity( self.WalkAnim )
end



function ENT:ApplyPlayerDamage(ply, damage, hitforce, infection)
local damageInfo = DamageInfo()
local dmg1 = damage

local armorvalue = 0
local plyarmor = ply:GetNWString("ArmorType")

if plyarmor and plyarmor != "none" then
local armortype = ItemsList[plyarmor]
armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
end

local armorbonus = dmg1 * armorvalue
local defencebonus = dmg1 * (0.015 * ply.StatDefense)

local dmg2 = dmg1 - (defencebonus + armorbonus)

damageInfo:SetAttacker(self)
damageInfo:SetDamage(dmg2)
damageInfo:SetDamageType(DMG_CLUB)

local force = ply:GetAimVector() * hitforce
force.z = 32
damageInfo:SetDamageForce(force)

ply:TakeDamageInfo(damageInfo)
ply:EmitSound(self.Hit, 100, math.random(80, 110))
ply:ViewPunch(VectorRand():Angle() * 0.05)
ply:SetVelocity(force)
if math.random(0, 100) > (100 - infection * (1 - (0.04 * ply.StatImmunity))) then
	ply.Infection = ply.Infection + math.random(60,300)
end
end