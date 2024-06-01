AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Hunter Zombie"
ENT.Category = "TEA Zombies"
ENT.Purpose = "Very Agile zombie that will tear you apart if it sees you. Beware."
ENT.Author = "Uklejamini"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()
	self.loco:SetAcceleration(900)
	self.loco:SetJumpHeight(180)
	self:SetColor(Color(127,255,127))
	self:SetModelScale(1.3)

-- dont bother changing any of this unless you like derpy shit (yea, i do like it)
	self.CanScream = true
	self.RageLevel = 2
	self.SpeedBuff = 2

-- animations for the StartActivity function
	self.AttackAnim = (ACT_MELEE_ATTACK1)
	self.WalkAnim = (ACT_WALK)
	self.RunAnim = (ACT_RUN)
	self.FlinchAnim = (ACT_FLINCH_PHYSICS)
	self.FallAnim = (ACT_IDLE_ON_FIRE)


	self.ZombieStats = {
		["Model"] = "models/zombie/fast.mdl",

--refer to entites/entities/npc_tea_basic.lua
		["Damage"] = 14,
		["PropDamage"] = 18,
		["Force"] = 40,
		["Infection"] = 13,
		["Reach"] = 90,
		["StrikeDelay"] = 0.15,
		["AfterStrikeDelay"] = 0.25,

		["Health"] = 1850,
		["MoveSpeedWalk"] = 60,
		["MoveSpeedRun"] = 160,
		["VisionRange"] = 1200,
		["LoseTargetRange"] = 1500,

		["Ability1"] = true,
		["Ability1Range"] = 500,
		["Ability1Cooldown"] = 8,
		["Ability1TrigDelay"] = 0.5,
	}


	self.AttackSounds = {"npc/zombie/zo_attack1.wav",
		"npc/zombie/zo_attack2.wav"
	}

	self.AlertSounds = {"npc/fast_zombie/fz_alert_close1.wav"}

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
		"npc/zombie_poison/pz_pain1.wav", 
		"npc/zombie_poison/pz_pain2.wav", 
		"npc/zombie_poison/pz_pain3.wav"
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
	local jtr = util.TraceLine( {
	start = self:GetPos() + Vector(0, 0, 40), 
	endpos = self:GetPos() + Vector(0, 0, 300), 
	filter = {self}
	} )

	if !jtr.Hit then
		self.loco:Jump()
		if self.target and self.target:IsValid() then
			local distancevector = self.target:GetPos() - self:GetPos()
			local vel = (distancevector / math.max(100, distancevector:Length())) * 100
--			vel.z = 0
			self.loco:SetVelocity(self.loco:GetVelocity() + vel)
		end
		return true
	end

	return false
end
