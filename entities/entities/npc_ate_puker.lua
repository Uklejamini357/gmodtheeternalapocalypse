AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Puker Zombie"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()

self:SetMaterial("models/flesh")
self:SetColor(Color(100,205,100,255))

-- dont bother changing any of this unless you like derpy shit
self.CanScream = true
self.RageLevel = 1
self.SpeedBuff = 1

-- animations for the StartActivity function
self.AttackAnim = (ACT_MELEE_ATTACK1)
self.WalkAnim = (ACT_WALK)
self.RunAnim = (ACT_WALK)
self.FlinchAnim = (ACT_FLINCH_PHYSICS)
self.FallAnim = (ACT_IDLE_ON_FIRE)


self.ZombieStats = {
["Model"] = "models/zombie/poison.mdl",

--refer to entites/entities/npc_ate_basic.lua
["Damage"] = 25,
["PropDamage"] = 20,
["Force"] = 300,
["Infection"] = 100,
["Reach"] = 73,
["StrikeDelay"] = 1.1,
["AfterStrikeDelay"] = 1.5,

["Health"] = 450,
["MoveSpeedWalk"] = 55,
["MoveSpeedRun"] = 60,
["VisionRange"] = 1200,
["LoseTargetRange"] = 1500,

["Ability1"] = true,
["Ability1Range"] = 800,
["Ability1Cooldown"] = 1,
["Ability1TrigDelay"] = 0.4,

}


self.AttackSounds = {"npc/antlion_guard/angry1.wav",
"npc/antlion_guard/angry2.wav", 
"npc/antlion_guard/angry3.wav", 
}

self.AlertSounds = {"npc/barnacle/barnacle_tongue_pull1.wav"}

self.IdleSounds = {"npc/barnacle/barnacle_die1.wav",
"npc/barnacle/barnacle_die2.wav", 
}

self.PainSounds = {"npc/barnacle/barnacle_die1.wav",
"npc/barnacle/barnacle_die2.wav", 
}

self.DieSounds = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav", 
"npc/zombie/zombie_die3.wav"
}

self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

self.Hit = Sound("npc/zombie/zombie_hit.wav")
self.Miss = Sound("npc/zombie/claw_miss1.wav")

self.Ability1CD = CurTime()

end


function ENT:SpecialSkill1()
if !self.target:IsValid() or !self:CanSeeTarget() then return false end


local tracedata = {}
tracedata.start = self:GetPos() + Vector(0, 0, 40)
tracedata.endpos = self.target:GetPos() + Vector(0, 0, 40)
tracedata.filter = self
local trace = util.TraceLine(tracedata)

self:EmitSound("npc/headcrab_poison/ph_hiss1.wav", 100, 60)

for i=1,6 do
local spit = ents.Create("obj_fleshbomb")
if !spit:IsValid() then return false end
spit:SetAngles(self:GetAngles())
spit:SetPos(self:GetPos() + self:GetAngles():Up() * 40)
spit:Spawn()
spit:Activate()
spit.Zed = self.Entity
local phys = spit:GetPhysicsObject()
phys:SetVelocity(trace.Normal * 1000 )
phys:AddVelocity( Vector(0, 0, 100) )
phys:AddVelocity( Vector(math.random(-150, 150), math.random(-150, 150), math.random(-150, 150)) )
end

return true
end

function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()

	local nerds = ents.FindInSphere(self:GetPos(), 120)

	for _, v in pairs(nerds) do
		if !v:IsPlayer() then continue end
		timer.Create("Poison"..v:EntIndex(), 0.5, 30, function() v:TakeDamage(1, self) end)
		v:TakeDamage(15, self)
	end

	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, math.random(95, 105))

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 20))
	util.Effect("zw_fleshpile_splode", effectdata)
	util.Effect("Explosion", effectdata)

	self:Remove()
end