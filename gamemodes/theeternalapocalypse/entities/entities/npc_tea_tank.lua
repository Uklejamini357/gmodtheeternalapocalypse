AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Tank Zombie"
ENT.Category = ""
ENT.Author = "Uklejamini"
ENT.Purpose = "Tough zombie - has high health and deal high damage to props"
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

--refer to entites/entities/npc_tea_basic.lua
["Damage"] = 45,
["PropDamage"] = 85,
["Force"] = 400,
["Infection"] = 17,
["Reach"] = 85,
["StrikeDelay"] = 1.1,
["AfterStrikeDelay"] = 1.5,

["Health"] = 1350,
["MoveSpeedWalk"] = 55,
["MoveSpeedRun"] = 55,
["VisionRange"] = 1200,
["LoseTargetRange"] = 1500,

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