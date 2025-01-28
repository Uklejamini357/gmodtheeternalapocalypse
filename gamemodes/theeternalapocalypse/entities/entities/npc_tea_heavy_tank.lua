AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Heavy Tank Zombie"
ENT.Category = "TEA Zombies"
ENT.Purpose = "Miniboss: Brings destruction, reflect 10% of melee damage taken"
ENT.Author = "Uklejamini"

list.Set("NPC", "npc_tea_heavy_tank", {
	Name = ENT.PrintName,
	Class = "npc_tea_heavy_tank",
	Category = ENT.Category
})


function ENT:SetUpStats()
    self:SetModelScale(1.2, 0)
    self:SetColor(Color(180,255,180))

    self.CanScream = true
    self.RageLevel = 1
    self.SpeedBuff = 1

    -- animations for the StartActivity function
    self.AttackAnim = ACT_MELEE_ATTACK1
    self.WalkAnim = ACT_WALK
    self.RunAnim = ACT_WALK
	self.IdleAnim = ACT_IDLE
    self.FlinchAnim = ACT_FLINCH_PHYSICS
    self.FallAnim = ACT_IDLE_ON_FIRE


    self.ZombieStats = {
        ["Model"] = "models/zombie/poison.mdl",

        --refer to entites/entities/npc_tea_basic.lua
        ["Damage"] = 65,
        ["PropDamage"] = 120,
        ["Force"] = 400,
        ["Infection"] = 38,
        ["Reach"] = 80,
        ["StrikeDelay"] = 1.1,
        ["AfterStrikeDelay"] = 1.5,

        ["Health"] = 6150,
        ["MoveSpeedWalk"] = 45,
        ["MoveSpeedRun"] = 45,
        ["VisionRange"] = 1200,
        ["LoseTargetRange"] = 1500,

        ["Ability1"] = false,
        ["Ability1Range"] = 0,
        ["Ability1Cooldown"] = 0,
        ["Ability1TrigDelay"] = 0,

    }


    self.AttackSounds = {
        "npc/antlion_guard/angry1.wav",
        "npc/antlion_guard/angry2.wav", 
        "npc/antlion_guard/angry3.wav", 
    }

    self.AlertSounds = {
        "npc/antlion_guard/angry1.wav",
        "npc/antlion_guard/angry2.wav",
        "npc/antlion_guard/angry3.wav"
    }

    self.IdleSounds = {
        "npc/antlion_guard/frustrated_growl1.wav",
        "npc/antlion_guard/frustrated_growl2.wav",
        "npc/antlion_guard/frustrated_growl3.wav",
    }

    self.PainSounds = {
        "npc/antlion_guard/angry1.wav",
        "npc/antlion_guard/angry2.wav", 
        "npc/antlion_guard/angry3.wav", 
    }

    self.DieSounds = {
        "npc/zombie/zombie_die1.wav",
        "npc/zombie/zombie_die2.wav", 
        "npc/zombie/zombie_die3.wav"
    }

    self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

    self.Hit = Sound("npc/zombie/zombie_hit.wav")
    self.Miss = Sound("npc/zombie/claw_miss1.wav")

end

local function IsMeleeDamage(num)
	return (num == DMG_SLASH or num == DMG_CLUB)
end

function ENT:OnInjuredAlt(dmginfo)
    local attacker = dmginfo:GetAttacker()

    if attacker:IsValid() and attacker:IsPlayer() and IsMeleeDamage(dmginfo:GetDamageType()) and dmginfo:GetDamage() >= 1 then
        attacker:TakeDamage(dmginfo:GetDamage() * 0.1, self, dmginfo:GetInflictor())
    end
end

