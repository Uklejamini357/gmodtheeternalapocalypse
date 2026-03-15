AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Zombine"
ENT.Category = "TEA Zombies"
ENT.Purpose = "Can sprint."--Pulls out a grenade when low on health.
ENT.Author = "Uklejamini"

list.Set("NPC", "npc_tea_zombine", {
	Name = ENT.PrintName,
	Class = "npc_tea_zombine",
	Category = ENT.Category
})


function ENT:SetUpStats()
-- dont bother changing any of this unless you like derpy shit
	self.CanScream = true
	self.RageLevel = 1
	self.SpeedBuff = 1

-- animations for the StartActivity function
	self.AttackAnim = ACT_MELEE_ATTACK1
	self.WalkAnim = ACT_WALK
	self.RunAnim = ACT_RUN
	self.IdleAnim = ACT_IDLE
	self.FlinchAnim = ACT_FLINCH_PHYSICS
	self.FallAnim = ACT_IDLE_ON_FIRE


	self.ZombieStats = {
		["Model"] = "models/zombie/zombie_soldier.mdl",

--refer to entites/entities/npc_tea_basic.lua
		["Damage"] = 45,
		["PropDamage"] = 60,
		["Force"] = 400,
		["Infection"] = 5,
		["Reach"] = 82,
		["StrikeDelay"] = 0.9,
		["AfterStrikeDelay"] = 1.3,

		["Health"] = 750,
		["MoveSpeedWalk"] = 55,
		["MoveSpeedRun"] = 180,
		["VisionRange"] = 1200,
		["LoseTargetRange"] = 1500,

		["Ability1"] = false,
		["Ability1Range"] = 800,
		["Ability1Cooldown"] = 3,
		["Ability1TrigDelay"] = 0.8,
	}


	self.AttackSounds = {
		"npc/zombine/zombine_charge1.wav",
		"npc/zombine/zombine_charge2.wav",
	}

	self.AlertSounds = {
		"npc/zombine/zombine_alert1.wav",
		"npc/zombine/zombine_alert2.wav",
		"npc/zombine/zombine_alert3.wav",
		"npc/zombine/zombine_alert4.wav",
		"npc/zombine/zombine_alert5.wav",
		"npc/zombine/zombine_alert6.wav",
		"npc/zombine/zombine_alert7.wav"
	}

	self.IdleSounds = {
		"npc/zombine/zombine_idle1.wav",
		"npc/zombine/zombine_idle2.wav",
		"npc/zombine/zombine_idle3.wav",
		"npc/zombine/zombine_idle4.wav",
	}

	self.PainSounds = {
		"npc/zombine/zombine_pain1.wav",
		"npc/zombine/zombine_pain2.wav",
		"npc/zombine/zombine_pain3.wav",
		"npc/zombine/zombine_pain4.wav"
	}

	self.DieSounds = {
		"npc/zombie/zombie_die1.wav",
		"npc/zombie/zombie_die2.wav", 
		"npc/zombie/zombie_die3.wav"
	}

	self.LandingSounds = {
		"npc/zombine/gear1.wav",
		"npc/zombine/gear2.wav",
		"npc/zombine/gear3.wav"
	}

	self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

	self.Hit = {
		"npc/zombie/claw_strike1.wav",
		"npc/zombie/claw_strike2.wav",
		"npc/zombie/claw_strike3.wav"
	}
	self.HitProp = Sound("npc/zombie/zombie_hit.wav")
	self.Miss = Sound("npc/zombie/claw_miss1.wav")
	self.Ability1CD = CurTime()

end


function ENT:SpecialSkill1()
	-- if !IsValid(self.target) or !self:CanSeeTarget() then return false end

	return false
end
