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

["Damage"] = 18, -- how much damage per strike?
["Force"] = 30, -- how far to knock the player back upon striking them
["Infection"] = 13, -- percentage chance to infect them
["Reach"] = 77, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 0.15, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 0.6, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 140, -- self explanatory
["MoveSpeedWalk"] = 55, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 284, -- zombies move speed when moving towards a target
["VisionRange"] = 1200, -- how far is the zombies standard sight range in source units, this will be tripled when they are frenzied
["LoseTargetRange"] = 1500, -- how far must the target be from the zombie before it will lose interest and revert to wandering, this will be tripled when the zombie is frenzied

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