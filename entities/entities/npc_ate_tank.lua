AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Tank Zombie"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()

self:SetModelScale(1.2, 0)
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

["Damage"] = 45, -- how much damage per strike?
["Force"] = 400, -- how far to knock the player back upon striking them
["Infection"] = 17, -- percentage chance to infect them
["Reach"] = 85, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 1.1, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 1.5, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 1350, -- self explanatory
["MoveSpeedWalk"] = 55, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 55, -- zombies move speed when moving towards a target
["VisionRange"] = 1200, -- how far is the zombies standard sight range in source units, this will be tripled when they are frenzied
["LoseTargetRange"] = 1500, -- how far must the target be from the zombie before it will lose interest and revert to wandering, this will be tripled when the zombie is frenzied

["Ability1"] = false,
["Ability1Range"] = 0,
["Ability1Cooldown"] = 0,
["Ability1TrigDelay"] = 0,

}


self.AttackSounds = {"npc/antlion_guard/angry1.wav",
"npc/antlion_guard/angry2.wav", 
"npc/antlion_guard/angry3.wav", 
}

self.AlertSounds = {"npc/antlion_guard/angry1.wav", "npc/antlion_guard/angry2.wav", "npc/antlion_guard/angry3.wav"}

self.IdleSounds = {
"npc/antlion_guard/frustrated_growl1.wav",
"npc/antlion_guard/frustrated_growl2.wav",
"npc/antlion_guard/frustrated_growl3.wav",
}

self.PainSounds = {"npc/antlion_guard/angry1.wav",
"npc/antlion_guard/angry2.wav", 
"npc/antlion_guard/angry3.wav", 
}

self.DieSounds = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav", 
"npc/zombie/zombie_die3.wav"
}

self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

self.Hit = Sound("npc/zombie/zombie_hit.wav")
self.Miss = Sound("npc/zombie/claw_miss1.wav")

end