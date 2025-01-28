AddCSLuaFile()

ENT.Base = "npc_tea_basic"
ENT.PrintName = "Wraith Zombie"
ENT.Category = "TEA Zombies"
ENT.Purpose = "Can temporarily blind survivors"
ENT.Author = "Uklejamini"

list.Set("NPC", "npc_tea_wraith", {
	Name = ENT.PrintName,
	Class = "npc_tea_wraith",
	Category = ENT.Category
})


function ENT:SetUpStats()

--Wraith is 30% visible now (i guess)
	self:SetColor(Color(76,76,76,255))
	self:SetMaterial("models/effects/vol_lightmask01")

	self.loco:SetAcceleration(900)
	self.loco:SetJumpHeight(300)

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

--refer to entites/entities/npc_tea_basic.lua
		["Damage"] = 27,
		["PropDamage"] = 28,
		["Force"] = 180,
		["Infection"] = 12,
		["Reach"] = 60,
		["StrikeDelay"] = 0.4,
		["AfterStrikeDelay"] = 1.4,

		["Health"] = 130,
		["MoveSpeedWalk"] = 55,
		["MoveSpeedRun"] = 220,
		["VisionRange"] = 1200,
		["LoseTargetRange"] = 1500,

		["Ability1"] = false,
		["Ability1Range"] = 0,
		["Ability1Cooldown"] = 0,
		["Ability1TrigDelay"] = 0,

	}


	self.AttackSounds = {"npc/stalker/go_alert2a.wav"}

	self.AlertSounds = {
		"npc/stalker/stalker_scream1.wav",
		"npc/stalker/stalker_scream2.wav",
		"npc/stalker/stalker_scream3.wav",
		"npc/stalker/stalker_scream4.wav"
	}

	self.IdleSounds = {
		"npc/fast_zombie/idle1.wav",
		"npc/fast_zombie/idle2.wav",
		"npc/fast_zombie/idle3.wav",
	}

	self.PainSounds = {
		"npc/stalker/stalker_die1.wav",
		"npc/stalker/stalker_die2.wav", 
	}

	self.DieSounds = {
		"npc/stalker/stalker_die1.wav",
		"npc/stalker/stalker_die2.wav", 
	}

	self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

	self.Hit = Sound("npc/zombie/zombie_hit.wav")
	self.Miss = Sound("npc/zombie/claw_miss1.wav")

end



function ENT:AttackPlayer(ply)
	if !ply:IsValid() or !self:IsValid() then return false end
	self:EmitSound(table.Random(self.AttackSounds), 100, math.random(95, 105))
	self:SetMaterial("")

	self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 0.75, function()
		self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
	end)

	self:DelayedCallback(self.ZombieStats["StrikeDelay"], function()
		if !self:IsValid() or self:Health() < 1 then return end
					
		if (IsValid(ply) and self:GetRangeTo(ply) <= self.ZombieStats["Reach"] * 1.2) then
			self:ApplyPlayerDamage(ply, self.ZombieStats["Damage"], -self.ZombieStats["Force"], self.ZombieStats["Infection"])

			net.Start("WraithBlind")
			net.WriteInt(255, 10)
			net.Send(ply)
		end
	end)

-- check if we killed the guy and find a new target if we did
	self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 1.2, function()
		if (IsValid(ply) and !ply:Alive()) then
			self.target = nil
		end
	end)

	self:DelayedCallback(1.5, function()
		self:SetMaterial("models/effects/vol_lightmask01")
	end)

	return false
end