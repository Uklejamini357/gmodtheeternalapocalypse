AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Tormented Wraith"
ENT.Category = ""
ENT.Author = "Uklejamini"
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

--refer to entites/entities/npc_ate_basic.lua
["Damage"] = 22,
["PropDamage"] = 25,
["Force"] = 180,
["Infection"] = 12,
["Reach"] = 70,
["StrikeDelay"] = 0.36,
["AfterStrikeDelay"] = 1,

["Health"] = 400,
["MoveSpeedWalk"] = 65,
["MoveSpeedRun"] = 200,
["VisionRange"] = 1200,
["LoseTargetRange"] = 1500,

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

/*self.DieSounds = {"npc/stalker/stalker_die1.wav",
"npc/stalker/stalker_die2.wav", 
}*/

self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

self.Hit = Sound("npc/zombie/zombie_hit.wav")
self.Miss = Sound("npc/zombie/claw_miss1.wav")

self.Ability1CD = CurTime()

end

--gives a speed buff for self if target is spotted
function ENT:SpecialSkill1()
	if !self:IsValid() then return false end
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
	util.Effect("zw_master_pulse", effectdata)
	self:EmitSound("ambient/machines/thumper_hit.wav", 120, 70)
	if self.SpeedBuff < 3 then self.SpeedBuff = math.Clamp(self.SpeedBuff + 0.1, 1, 3) end
	self.Ability1CD = CurTime() + self.ZombieStats["Ability1Cooldown"]
end

function ENT:AttackPlayer(ply)
if !ply:IsValid() or !self:IsValid() then return false end
self:EmitSound(table.Random(self.AttackSounds), 100, math.random(95, 105))
self:SetMaterial("")

-- swing those claws
self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 0.75, function()
	self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
end)

-- actually apply the damage
self:DelayedCallback(self.ZombieStats["StrikeDelay"], function()
if !self:IsValid() or self:Health() < 1 then return end
					
	if (IsValid(ply) and self:GetRangeTo(ply) <= self.ZombieStats["Reach"] * 1.3) then
		self:ApplyPlayerDamage(ply, self.ZombieStats["Damage"], -self.ZombieStats["Force"], self.ZombieStats["Infection"])
		ply.SlowDown = 1 --slow them down temporarily by 40%
		RecalcPlayerSpeed(ply)
		timer.Create("WraithAttack_"..ply:UniqueID(), 5, 1, function()
		ply.SlowDown = 0
		RecalcPlayerSpeed(ply)
		end)
		net.Start("WraithBlind")
		net.Send(ply)
	end
end)


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

function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()
	self:EmitSound("npc/combine_soldier/die1.wav", 100, math.Rand(90, 100))
	self:BecomeRagdoll(damageInfo)
	timer.Simple(0.25, function() -- there was one case scenario where a zombie disappeared without leaving a corpse during server lag so i had to increase timer
	self:Remove()
	end)
end