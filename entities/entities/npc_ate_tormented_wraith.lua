AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Tormented Wraith"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()

--Tormented Wraith is green and 40% visible to indicate that it is Tormented Wraith Zombie
self:SetColor(Color(25,102,25,255))
self:SetMaterial("models/effects/vol_lightmask01")

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

["Damage"] = 27, -- how much damage per strike?
["Force"] = 180, -- how far to knock the player back upon striking them
["Infection"] = 12, -- percentage chance to infect them
["Reach"] = 70, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 0.36, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 1, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 400, -- self explanatory
["MoveSpeedWalk"] = 65, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 200, -- zombies move speed when moving towards a target
["VisionRange"] = 1200, -- how far is the zombies standard sight range in source units, this will be tripled when they are frenzied
["LoseTargetRange"] = 1500, -- how far must the target be from the zombie before it will lose interest and revert to wandering, this will be tripled when the zombie is frenzied

["Ability1"] = true,
["Ability1Range"] = 500,
["Ability1Cooldown"] = 5,
["Ability1TrigDelay"] = 0,

}


self.AttackSounds = {"npc/stalker/go_alert2a.wav"}

self.AlertSounds = {"npc/stalker/stalker_scream1.wav",
"npc/stalker/stalker_scream2.wav",
"npc/stalker/stalker_scream3.wav",
"npc/stalker/stalker_scream4.wav"}

self.IdleSounds = {
"npc/fast_zombie/idle1.wav",
"npc/fast_zombie/idle2.wav",
"npc/fast_zombie/idle3.wav",
}

self.PainSounds = {"npc/stalker/stalker_die1.wav",
"npc/stalker/stalker_die2.wav", 
}

self.DieSounds = {"npc/stalker/stalker_die1.wav",
"npc/stalker/stalker_die2.wav", 
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
	if self.SpeedBuff <= 3 then self.SpeedBuff = math.Clamp(self.SpeedBuff + 1, 1, 3) end
	self.Ability1CD = CurTime() + self.ZombieStats["Ability1Cooldown"]
end

function ENT:AttackPlayer(ply)
if !ply:IsValid() or !self:IsValid() then return false end
self:EmitSound(table.Random(self.AttackSounds), 100, math.random(95, 105))
self:SetMaterial("")

-- swing those claws baby
self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 0.75, function()
	self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
end)

-- actually apply the damage
self:DelayedCallback(self.ZombieStats["StrikeDelay"], function()
if !self:IsValid() or self:Health() < 1 then return end
					
	if (IsValid(ply) and self:GetRangeTo(ply) <= self.ZombieStats["Reach"] * 1.3) then
		self:ApplyPlayerDamage(ply, self.ZombieStats["Damage"], -self.ZombieStats["Force"], self.ZombieStats["Infection"])

		net.Start("WraithBlind")
		net.Send(ply)
	end
end)

-- check if we killed the guy and find a new target if we did
self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 1.2, function()
if (IsValid(ply) and !ply:Alive()) then
	self.target = nil
end
end)

self:DelayedCallback(1, function()
self:SetMaterial("models/effects/vol_lightmask01")
end)

return false
end