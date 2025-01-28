AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Zombie Lord"
ENT.Category = "TEA Zombies"
ENT.Author = "Uklejamini"
ENT.Purpose = "Can teleport if taken too much damage"

list.Set("NPC", "npc_tea_lork", {
	Name = ENT.PrintName,
	Class = "npc_tea_lord",
	Category = ENT.Category
})


function ENT:SetUpStats()

-- dont bother changing any of this unless you like derpy shit
	self.CanScream = true
	self.RageLevel = 1
	self.SpeedBuff = 1
	self.Ouchies = 0

-- animations for the StartActivity function
	self.AttackAnim = ACT_MELEE_ATTACK_SWING
	self.WalkAnim = ACT_WALK
	self.RunAnim = ACT_WALK
	self.IdleAnim = ACT_IDLE
	self.FlinchAnim = ACT_FLINCH_PHYSICS
	self.FallAnim = ACT_IDLE_ON_FIRE


	self.ZombieStats = {
		["Model"] = "models/undead/undead.mdl",

--refer to entites/entities/npc_tea_basic.lua
		["Damage"] = 50,
		["PropDamage"] = 85,
		["Force"] = 650,
		["Infection"] = 0,
		["Reach"] = 115,
		["StrikeDelay"] = 0.6,
		["AfterStrikeDelay"] = 1.1,

		["Health"] = 1500,
		["MoveSpeedWalk"] = 65,
		["MoveSpeedRun"] = 90,
		["VisionRange"] = 1200,
		["LoseTargetRange"] = 1500,

		["Ability1"] = true,
		["Ability1Range"] = 800,
		["Ability1Cooldown"] = 25,
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

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2000)) do
		if (self != v and (GAMEMODE.Config["ZombieClasses"][v:GetClass()] or GAMEMODE.Config["BossClasses"][v:GetClass()])) then
			if (v.RageLevel or 0) < 2.5 then
				v.RageLevel = 2.5
			end
			if (v.SpeedBuff or 0) < 1.15 then
				v.SpeedBuff = 1.15
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
	if math.random(0, 100) > (100 - infection) then
		ply:AddInfection(100)
	end
end


function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local range = self:GetRangeTo(attacker)
	local dmg = damageInfo:GetDamage()

	self.Ouchies = (self.Ouchies or 0) + dmg
	if self.NextPainSound < CurTime() and dmg < self:Health() then
		self.NextPainSound = CurTime() + 0.5
		self:EmitSound(table.Random(self.PainSounds), 100, math.random(90, 110))
	end
	if attacker:IsPlayer() then
	self.target = attacker
	end
	if self.Ouchies > 400 then
		self:Teleport()
		self.Ouchies = 0
	end

	self.RageLevel = 3
end

function ENT:Teleport()
	local pos = self:GetPos() + Vector(math.random(-250,250), math.random(-250,250), 100)
	if !util.IsInWorld(pos) then timer.Simple(0.1, function() self:Teleport() end) return false end

	self:SetPos(pos)
	self:DropToFloor()
end
