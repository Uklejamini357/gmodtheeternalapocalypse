AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Zombie Superlord" --Superlord as a miniboss
ENT.Category = ""
ENT.Author = "Uklejamini"
ENT.Purpose = "Miniboss: Can enrage if drop below ~40% health and teleport"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()
self:SetColor(Color(255,0,255,255))
self:SetModelScale( 1.35, 0 )
-- dont bother changing any of this unless you like derpy shit
self.CanScream = true
self.RageLevel = 1
self.SpeedBuff = 1
self.IsEnraged = 0
self.Ouchies = 0

-- animations for the StartActivity function
self.AttackAnim = (ACT_MELEE_ATTACK_SWING)
self.WalkAnim = (ACT_WALK)
self.RunAnim = (ACT_WALK)
self.FlinchAnim = (ACT_FLINCH_PHYSICS)
self.FallAnim = (ACT_IDLE_ON_FIRE)


self.ZombieStats = {
["Model"] = "models/undead/undead.mdl",

--refer to entites/entities/npc_tea_basic.lua
["Damage"] = 65,
["PropDamage"] = 200,
["Force"] = 1125,
["Infection"] = 100,
["Reach"] = 140,
["StrikeDelay"] = 0.6,
["AfterStrikeDelay"] = 1.5,

["Health"] = 4000,
["MoveSpeedWalk"] = 65,
["MoveSpeedRun"] = 95,
["VisionRange"] = 1200,
["LoseTargetRange"] = 1500,

["Ability1"] = true,
["Ability1Range"] = 2500,
["Ability1Cooldown"] = math.Rand(10,15),
["Ability1TrigDelay"] = 0,

}


self.AttackSounds = {"npc/ichthyosaur/attack_growl1.wav",
"npc/ichthyosaur/attack_growl2.wav",  
}

self.AlertSounds = {"npc/antlion_guard/angry1.wav", "npc/antlion_guard/angry2.wav", "npc/antlion_guard/angry3.wav"}

self.IdleSounds = {
"npc/antlion_guard/frustrated_growl1.wav",
"npc/antlion_guard/frustrated_growl2.wav",
"npc/antlion_guard/frustrated_growl3.wav",
}

self.PainSounds = {"npc/stalker/stalker_pain1.wav",
"npc/stalker/stalker_pain2.wav", 
"npc/stalker/stalker_pain3.wav", 
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
	if !self:IsValid() then return false end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
	util.Effect("zw_master_pulse", effectdata)
	self:EmitSound("ambient/machines/thumper_hit.wav", 120, 70)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2250)) do
		if (self != v and (GAMEMODE.Config["ZombieClasses"][v:GetClass()] or GAMEMODE.Config["BossClasses"][v:GetClass()])) then
			if (v.RageLevel or 0) < 3.5 then
				v.RageLevel = 3.5
			end
			if (v.SpeedBuff or 0) < 1.3 then
				v.SpeedBuff = 1.3
			end
			local effectdata = EffectData()
			effectdata:SetOrigin(v:GetPos() + Vector(0, 0, 60))
			util.Effect("zw_master_strike", effectdata)
		end
	end
	return true
end


function ENT:ApplyPlayerDamage(ply, damage, hitforce, infection)
	if !ply:Alive() then return end
	local damageInfo = DamageInfo()
	local dmg1 = tonumber(damage)

	damageInfo:SetAttacker(self)
	damageInfo:SetDamage(GAMEMODE:CalcPlayerDamage(ply, dmg1))
	damageInfo:SetDamageType(DMG_CLUB)

	local force = ply:GetAimVector() * hitforce
	force.z = 300
	damageInfo:SetDamageForce(force)

	self:EmitSound("ambient/energy/zap9.wav", 100, 80)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
	util.Effect("zw_master_strike", effectdata)

	ply:TakeDamageInfo(damageInfo)
--ply:EmitSound(self.Hit, 100, math.random(80, 110))
	ply:ViewPunch(VectorRand():Angle() * 0.05)
	ply:SetVelocity(force)
	ply:AddInfection(math.random(60,1000))
end


function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local range = self:GetRangeTo(attacker)
	local dmg = damageInfo:GetDamage()

	self.Ouchies = (self.Ouchies or 0) + dmg
	if self.NextPainSound < CurTime() and damageInfo:GetDamage() < self:Health() then
		self.NextPainSound = CurTime() + 0.5
		self:EmitSound(table.Random(self.PainSounds), 100, math.random(90, 110))
	end
	if attacker:IsPlayer() then
		self.target = attacker
	end
	if self.Ouchies > 300 then
		self:Teleport()
		self.Ouchies = 0
	end
	if self:Health() - dmg <= 1500 and self.IsEnraged == 0 then
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
			if v:IsPlayer() then
				v:SystemMessage("Superlord has enraged!", Color(255,230,230,255), false)
			end
		end
		self.RageLevel = 4
		self.SpeedBuff = 1.7
		self.IsEnraged = 1
		self.ZombieStats["Damage"] = self.ZombieStats["Damage"] + 10
	end
end

function ENT:Teleport()
	local pos = self:GetPos() + Vector(math.random(-250,250), math.random(-250,250), 100)
	if !util.IsInWorld(pos) then timer.Simple(0.1, function() self:Teleport() end) return false end

	self:SetPos(pos)
	self:DropToFloor()
end
