AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Leaper Zombie"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()
self.loco:SetAcceleration(900)
self.loco:SetJumpHeight( 300 )

-- dont bother changing any of this unless you like derpy shit
self.CanScream = true
self.RageLevel = 1
self.SpeedBuff = 1

-- animations for the StartActivity function
self.AttackAnim = (ACT_MELEE_ATTACK1)
self.WalkAnim = (ACT_WALK)
self.RunAnim = (ACT_RUN)
self.FlinchAnim = (ACT_FLINCH_PHYSICS)
self.FallAnim = (ACT_IDLE_ON_FIRE)


self.ZombieStats = {
["Model"] = "models/zombie/fast.mdl",

--refer to entites/entities/npc_ate_basic.lua
["Damage"] = 11,
["PropDamage"] = 14,
["Force"] = 20,
["Infection"] = 8,
["Reach"] = 75,
["StrikeDelay"] = 0.15,
["AfterStrikeDelay"] = 0.3,

["Health"] = 145,
["MoveSpeedWalk"] = 55,
["MoveSpeedRun"] = 214,
["VisionRange"] = 1200,
["LoseTargetRange"] = 1500,

["Ability1"] = true,
["Ability1Range"] = 500,
["Ability1Cooldown"] = 10,
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
endpos = self:GetPos() + Vector(0, 0, 340), 
filter = {self}
} )

if !jtr.Hit then
	self.loco:Jump()
	return true
end

return false
end