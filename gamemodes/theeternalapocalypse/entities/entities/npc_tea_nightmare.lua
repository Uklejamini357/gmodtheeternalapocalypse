AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Nightmare" --This is unfinished, don't add it to zombie spawns in sh_config.lua yet
ENT.Category = "TEA Zombies"
ENT.Purpose = "A zombie that attack you and can infect"
ENT.Author = "Uklejamini"

list.Set("NPC", "npc_tea_nightmare", {
	Name = ENT.PrintName,
	Class = "npc_tea_nightmare",
	Category = ENT.Category
})


function ENT:SetUpStats()

-- animations for the StartActivity function
    self.AttackAnim = ACT_MELEE_ATTACK1
    self.WalkAnim = ACT_WALK
    self.RunAnim = ACT_WALK
	self.IdleAnim = ACT_IDLE

    self.FlinchAnim = ACT_FLINCH_PHYSICS
    self.FallAnim = ACT_IDLE_ON_FIRE


    self.ZombieStats = {
        ["Model"] = "models/zombie/classic.mdl",

--refer to entites/entities/npc_tea_basic.lua
        ["Damage"] = 31,
        ["PropDamage"] = 40,
        ["Force"] = 400,
        ["Infection"] = 8,
        ["Reach"] = 60,
        ["StrikeDelay"] = 0.8,
        ["AfterStrikeDelay"] = 1,

        ["Health"] = 180,
        ["MoveSpeedWalk"] = 50,
        ["MoveSpeedRun"] = 225,
        ["VisionRange"] = 1200,
        ["LoseTargetRange"] = 1500,

        ["Ability1"] = false,
        ["Ability1Range"] = 0,
        ["Ability1Cooldown"] = 0,
        ["Ability1TrigDelay"] = 0,
    }


    self.AttackSounds = {
        "npc/zombie/zo_attack1.wav",
        "npc/zombie/zo_attack2.wav"
    }

    self.AlertSounds = {
        "npc/zombie/zombie_alert1.wav", 
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

    self.PainSounds = {
        "npc/zombie/zombie_pain1.wav",
        "npc/zombie/zombie_pain2.wav", 
        "npc/zombie/zombie_pain3.wav", 
        "npc/zombie/zombie_pain4.wav", 
        "npc/zombie/zombie_pain5.wav", 
        "npc/zombie/zombie_pain6.wav"
    }

    self.DieSounds = {
        "npc/zombie/zombie_die1.wav",
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
