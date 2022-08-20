AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Nightmare" --This is unfinished, don't add it to zombie spawns in sh_config.lua
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

["Damage"] = 31, -- how much damage per strike?
["Force"] = 400, -- how far to knock the player back upon striking them
["Infection"] = 8, -- percentage chance to infect them
["Reach"] = 60, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 0.8, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 1, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 180, -- self explanatory
["MoveSpeedWalk"] = 50, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 85, -- zombies move speed when moving towards a target
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
