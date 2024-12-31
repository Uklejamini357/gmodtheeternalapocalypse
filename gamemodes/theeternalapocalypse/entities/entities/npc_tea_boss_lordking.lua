AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Zombie Lord King"
ENT.Category = "Boss Zombie"
ENT.Author = "Uklejamini"
ENT.Purpose = "Can teleport nearby zombies"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AttackAnim = (ACT_MELEE_ATTACK_SWING)
ENT.WalkAnim = (ACT_WALK)
ENT.RunAnim = (ACT_RUN)

ENT.FlinchAnim = (ACT_FLINCH_PHYSICS)
ENT.FallAnim = (ACT_IDLE_ON_FIRE)

ENT.AttackWaitTime = 0.6
ENT.AttackFinishTime = 0.5

ENT.CanScream = true
ENT.RageLevel = 1 -- RageLevel increases zombies perception radius
ENT.SpeedBuff = 1

ENT.StepSound = "npc/dog/dog_footstep1.wav"

-- sound
ENT.AttackSounds = {"npc/ichthyosaur/attack_growl1.wav",
"npc/ichthyosaur/attack_growl2.wav"}

ENT.DoorBreakSound = Sound("npc/zombie/zombie_pound_door.wav")

ENT.AlertSounds = {"npc/antlion_guard/angry1.wav",
"npc/antlion_guard/angry2.wav",
"npc/antlion_guard/angry3.wav"}

ENT.DeathSounds = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav",
"npc/zombie/zombie_die3.wav"}

ENT.FlinchSounds = {"npc/zombie/zombie_voice_idle10.wav",
"npc/zombie/zombie_voice_idle11.wav",
"npc/zombie/zombie_voice_idle12.wav"}

ENT.FallSounds = {"npc/zombie/zombie_voice_idle11.wav",
"npc/zombie/zombie_voice_idle13.wav"}

ENT.IdleSounds = {"npc/antlion_guard/frustrated_growl1.wav",
"npc/antlion_guard/frustrated_growl2.wav",
"npc/antlion_guard/frustrated_growl3.wav"}

ENT.PainSounds = {"npc/stalker/stalker_pain1.wav",
"npc/stalker/stalker_pain2.wav",
"npc/stalker/stalker_pain3.wav"}

ENT.Hit = Sound("npc/zombie/claw_strike1.wav")
ENT.Miss = Sound("npc/zombie/claw_miss1.wav")

/*
for i = 2, 4 do
	util.PrecacheModel("models/zed/malezed_0"..(i * 2)..".mdl")
end
*/

function ENT:SetUpStats()
	self.Ouchies = 0
	self.IsEnraged = false
end

function ENT:CanSeeTarget()
	if !self:IsValid() then return false end
	if self.target != nil then
		local tracedata = {}
		tracedata.start = self:GetPos() + Vector(0, 0, 30)
		tracedata.endpos = self.target:GetPos() + Vector(0, 0, 30)
		tracedata.filter = self
		local trace = util.TraceLine(tracedata)
		if !trace.HitWorld then
			return true
		else 
			return false
		end
	else
		return false
	end
end

function ENT:HasLOS()
	if !self:IsValid() or !self.target:IsValid() then return false end
	if self.target != nil then
		local tracedata = {}
		tracedata.start = self:GetPos() + Vector(0, 0, 40)
		tracedata.endpos = self.target:GetPos() + Vector(0, 0, 40)
		tracedata.filter = self
		local trace = util.TraceLine(tracedata)
		if trace.HitWorld == false then
			return true
		else 
			return false
		end
	else
		return false
	end
end

function ENT:GetTEAZombieSpeedMul()
	return math.min(self:GetEliteVariant() == VARIANT_ENRAGED and 1.6 or 1, 2 - (self:Health() / self:GetMaxHealth())) * math.Clamp(GAMEMODE:GetInfectionMul(0.5)-0.25, 1, 1.25) * GAMEMODE.ZombieSpeedMultiplier * self.SpeedBuff
end

function ENT:Initialize()
	if CLIENT then return end
	self:SetModel("models/undead/undead.mdl")
	self.loco:SetDeathDropHeight(700)
	self.loco:SetAcceleration(800)
	self.loco:SetJumpHeight(240)
	self:SetHealth(19500) --15500
	self:SetMaxHealth(19500) --15500
	self:SetUpStats()
	self:SetModelScale(1.4, 0)
	self:SetColor(Color(127,127,255))
	self:SetCollisionBounds(Vector(-34,-34, 0), Vector(34, 34, 84))
	self:SetLagCompensated(true)
--	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
--	self:SetSkin(math.random(0, self:SkinCount() - 1))
	
	self.NextPainSound = CurTime()
	self.AbilityCD = CurTime()
	self.Ability2CD = CurTime()
	self.NxtTick = 5

	timer.Simple(1200, function()
		if self:IsValid() then
			self:Remove()
			GAMEMODE:SystemBroadcast("[BOSS]: The Zombie Lord King was not killed and has left the area!", Color(255,105,105,255), false)
		end
	end)
end

function ENT:TimedEvent(time, callback)
	timer.Simple(time, function()
		if (IsValid(self)) then
			callback()
		end
	end)
end

function ENT:Think()
	if !IsValid(self) then return end
	local target = self.target

	if IsValid(target) and target:Alive() and !target.TEANoTarget and (self:GetRangeTo(target) <= 1750 && self.AbilityCD < CurTime() && self:HasLOS()) then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
		util.Effect("zw_master_pulse", effectdata)
		self:EmitSound("ambient/machines/thumper_hit.wav", 125, 55)

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 2000)) do
--			v.Type == "nextbot"
			if (self != v and (GAMEMODE.Config["ZombieClasses"][v:GetClass()] or GAMEMODE.Config["BossClasses"][v:GetClass()])) then
				if (v.RageLevel or 0) < 4 then
					v.RageLevel = 4
				end
				if (v.SpeedBuff or 0) < 1.4 then
					v.SpeedBuff = 1.4
				end
				if math.random(1, 100) > 20 then self:Teleport_NPC(v) end
				local effectdata = EffectData()
				effectdata:SetOrigin(v:GetPos() + Vector(0, 0, 60))
				util.Effect("zw_master_strike", effectdata)
			end
		end

		self.AbilityCD = CurTime() + math.Rand(20,25) -- i would enjoy the chaos if you set this to 0 (HIGHLY UNRECOMMENDED)
	end

	if IsValid(target) and target:Alive() and !target.TEANoTarget and (self:GetRangeTo(target) <= 1000 && self.Ability2CD < CurTime() && self:HasLOS()) and self.IsEnraged then
		self:TimedEvent(0.4, function()
			local jtr = util.TraceLine( {
				start = self:GetPos() + Vector(0, 0, 40), 
				endpos = self:GetPos() + Vector(0, 0, 340), 
				filter = {self}
			} )

			if !jtr.Hit then
				self.loco:Jump()
				return true
			end
				
--			self:StartActivity(self.AttackAnim)
			self.loco:Jump()
		end)

		self.Ability2CD = CurTime() + math.Rand(10,14)
	end
end

function ENT:RunBehaviour()
	while (true) do
		if CLIENT then return end
		local target = self.target
		local selfpos = self:GetPos()

		if (IsValid(target) and target:Alive() and !target.TEANoTarget) then
			local data = {}
			data.start = self:GetPos()
			data.endpos = self:GetPos() + self:GetForward()*128
			data.filter = self
			data.mins = self:OBBMins() * 0.65
			data.maxs = self:OBBMaxs() * 0.65
			local trace = util.TraceHull(data)
			local entity = trace.Entity

			if math.random(1,1000) < 25 then
				self:EmitSound(table.Random(self.IdleSounds))
			end
		end

		if (IsValid(target) and target:Alive() and (self:GetRangeTo(target) <= (2500 * self.RageLevel) or GAMEMODE.ZombieApocalypse) and !target.TEANoTarget) then
			self.loco:FaceTowards(target:GetPos())

			if self.NxtTick < 1 then

-- check if we are obstructed by props and smash them if we are
				local breakshit = ents.FindInSphere(self:GetPos() + self:GetAngles():Up() * 55, 55)

				self:AttackProp(breakshit)
				for k,v in pairs(breakshit) do
					if v:IsValid() then
						if v:GetClass() == "prop_door_rotating" and v:GetNoDraw() == false then
							self:AttackDoor(v)
						else continue end
					end
				end
				self.NxtTick = 2
			else
				self.NxtTick = self.NxtTick - 1
			end

			if (self:GetRangeTo(target) <= 100) and self:CanSeeTarget(target) then									-- hit the player
				self:EmitSound(table.Random(self.AttackSounds), 125, math.random(85, 95))

				self:TimedEvent(0.35, function()
					self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav", 100, 70)
				end)

				self:TimedEvent(self.AttackWaitTime, function()
					if not (self:IsValid() && self:Health() > 0) then return end
					
					if (IsValid(target) and self:GetRangeTo(target) <= 105) and target:Alive() then
						local damageInfo = DamageInfo()
						damageInfo:SetAttacker(self)
						damageInfo:SetDamage(GAMEMODE:CalcPlayerDamage(target, self.IsEnraged and math.random(65, 75) or math.random(50, 55)))
						damageInfo:SetDamageType(DMG_CLUB)

						local distancevector = target:GetPos() - self:GetPos()
						local force = (distancevector / distancevector:Length()) * 800
						force.z = force.z + 260


						local function DOIT()
							self:EmitSound("ambient/energy/zap9.wav", 120, 80)
							local effectdata = EffectData()
							effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
							util.Effect("zw_master_strike", effectdata)
						end
						DOIT()
						timer.Create("Boss_LordKingAttack"..self:EntIndex(), 0.05, 3, DOIT)

						damageInfo:SetDamageForce(force)
						target:TakeDamageInfo(damageInfo)
						target:EmitSound(self.Hit, 100, math.random(60, 80))
						target:ViewPunch(VectorRand():Angle() * 0.05)
						target:SetVelocity(force)
						local rng = math.random(0, 100)
						if self.IsEnraged and rng > 50 then
							target:AddInfection(math.Rand(200,750))
						elseif rng > 70 then
							target:AddInfection(math.Rand(120,500))
						end
						target:SlowPlayerDown(self.IsEnraged and 0.25 or 0.2, self.IsEnraged and 6 or 4)
						net.Start("WraithBlind")
						net.WriteInt(self.IsEnraged and 223 or 207, 10)
						net.Send(target)

					end
				end)

				self:TimedEvent(0.45, function()
					if (IsValid(target) and !target:Alive()) then
						target.target = nil
					end
				end)

				self:StartActivity(self.AttackAnim)
				coroutine.wait(self.AttackWaitTime + self.AttackFinishTime)
				self:StartActivity(self.WalkAnim)	
			else
				local distance = selfpos:Distance(target:GetPos())
				self:StartActivity(self.RunAnim)

				if (self.breathing) then
					self.breathing:ChangePitch(80, 1)
					self.breathing:ChangeVolume(1.25, 1)
				end

--				if (math.random(1, 2) == 2 and (self.nextYell or 0) < CurTime()) then
--					self:EmitSound("npc/zombie_poison/pz_pain"..math.random(1, 3)..".wav", 80, math.random(30, 50))
--					self.nextYell = CurTime() + math.random(4, 8)
--				end
				
				self.loco:SetDesiredSpeed((self.IsEnraged and 270 or 200) * self:GetTEAZombieSpeedMul())


				self:MoveToPos(target:GetPos(), {
					tolerance = 100,
					maxage = distance < 2000 and 1 or distance < 5000 and 2 or 3,
					repath = 3,
				})
			end
		else
			self.target = nil
			self.CanScream = true
			self:StartActivity(self.WalkAnim)
			self.loco:SetDesiredSpeed(self.IsEnraged and 80 or 70)
			self:MoveToPos(self:GetPos() + Vector(math.random(-256, 256), math.random(-256, 256), 0), {
				repath = 3,
				maxage = 2
			})

			if (!self.target) then
				for k, v in pairs(player.GetAll()) do
					if (v:Alive() and (self:GetRangeTo(v) <= (2500 * self.RageLevel) or GAMEMODE.ZombieApocalypse) and !v.TEANoTarget) then
--						self:AlertNearby(v)
						self.target = v
--						self:PlaySequenceAndWait("wave_smg1", 0.9)
						if self.CanScream == true then
							self:EmitSound(table.Random(self.AlertSounds), 120, 85)
							self.CanScream = false
						end
						break
					end
				end
			end


--idk what this one does
--			if (math.random(1, 8) == 2) then
--				self:EmitSound("npc/zombie/zombie_voice_idle"..math.random(2, 7)..".wav", 100, 60)
/*
				if (math.random(1, 2) == 2) then
					self:PlaySequenceAndWait("scaredidle")
				else
					self:PlaySequenceAndWait("photo_react_startle")
				end
*/
--			end

		end
		coroutine.yield()
	end
end

function ENT:OnLandOnGround()
	self:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
end

function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()

	if attacker:IsPlayer() then
		GAMEMODE:SystemBroadcast("[BOSS]: "..attacker:Nick().." has slain the Zombie Lord King!", Color(255,105,105,255), false)
	else
		GAMEMODE:SystemBroadcast("[BOSS]: The Zombie Lord King has been slain by an unknown cause!", Color(255,105,105,255), false)
	end
/*
	if !attacker:IsWorld() then 
		if (IsValid(attacker) and self:GetRangeTo(attacker) <= 4800) then
			self:AlertNearby(attacker, 1600, true)
		else
			local entities = ents.FindInSphere(self:GetPos(), 2400)

			for k, v in pairs(entities) do
				if (v:IsPlayer()) then
					self:AlertNearby(v, 2400, true)

					break
				end
			end
		end
	end
*/

	self:EmitSound(table.Random(self.DeathSounds), 130, math.random(95, 105))
	self:BecomeRagdoll(damageInfo)
	gamemode.Call("OnNPCKilled", self, damageInfo:GetAttacker(), damageInfo:GetInflictor())
end

function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local dmg = damageInfo:GetDamage()
	local range = self:GetRangeTo(attacker)

	if self.NextPainSound < CurTime() and damageInfo:GetDamage() < self:Health() then
		self.NextPainSound = CurTime() + 1.1
		self:EmitSound(table.Random(self.PainSounds), 120, math.random(50, 80))
	end
	self.Ouchies = (self.Ouchies or 0) + dmg
	
	if attacker:IsPlayer() then
		self.target = attacker
	end

	if self.IsEnraged and self.Ouchies > math.min(2000, 0.06 * self:GetMaxHealth()) or self.Ouchies > math.min(3500, 0.13 * self:GetMaxHealth()) then
		self:Teleport()
		self.Ouchies = 0
	end

	if (self:Health() - dmg) <= self:GetMaxHealth() * 0.3 then
		self.RageLevel = 4
		if !self.IsEnraged then
			GAMEMODE:SystemBroadcast("[BOSS]: The Zombie Lord King is now Enraged!", Color(255,105,105,255), false)
			self.loco:SetDesiredSpeed(270 * self:GetTEAZombieSpeedMul())
		end
		self.IsEnraged = true
	else
		self.RageLevel = 3
	end

end

function ENT:AttackProp(targetprops)
--	local entstoattack = ents.FindInSphere(self:GetPos() + self:GetAngles():Up() * 55, 35)
	for _,v in pairs(targetprops) do
	
		if v:IsValid() and (v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong" or SpecialSpawns[v:GetClass()]) then

			self:EmitSound(table.Random(self.AttackSounds), 110, math.random(90, 120))
			self:StartActivity(self.AttackAnim)

			coroutine.wait(self.AttackWaitTime)
			self:EmitSound(self.Miss)

			if !v:IsValid() then return end
			local phys = v:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
			phys:ApplyForceCenter(self:GetForward():GetNormalized() * 30000 + Vector(0, 0, 2))
			v:EmitSound(self.DoorBreakSound, 100, 60)
			v:TakeDamage(self.IsEnraged and math.random(195, 225) or math.random(150, 165), self)
			util.ScreenShake(v:GetPos(), 8, 6, math.Rand(0.3, 0.5), 400)
			end
		coroutine.wait(self.AttackFinishTime)
		self:StartActivity(self.WalkAnim)
			return true
		end
	end
	return false
end

function ENT:AttackDoor(target)
	if !target:IsValid() or !target:GetClass() == "prop_door_rotating" then return false end

	self:EmitSound(table.Random(self.AttackSounds), 105, math.random(85, 95))

	self:StartActivity(self.AttackAnim)
	coroutine.wait(self.AttackWaitTime)
	if target:GetNoDraw() then
		coroutine.wait(self.AttackFinishTime)
		self:StartActivity(self.WalkAnim)
		return
	end

	target:EmitSound(self.Hit, 100, math.random(80, 110))
	target.doorhealth = target.doorhealth - (self.IsEnraged and math.random(195, 225) or math.random(150, 165))
	
	if target.doorhealth >= 0 then
		util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 300)
		coroutine.wait(self.AttackFinishTime)
		self:StartActivity(self.WalkAnim)
		return
	end
	target:EmitSound("physics/wood/wood_plank_break"..math.random(1, 4)..".wav", 100, math.random(90, 100))

	local effect = EffectData()
	local position = target:LocalToWorld(target:OBBCenter()) + target:GetRight()*math.random(-16, 16) + target:GetUp()*math.random(-16, 16)
	effect:SetStart(position)
	effect:SetOrigin(position)
	util.Effect("GlassImpact", effect)

	util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 360)

	local pos = target:GetPos()
	local ang = target:GetAngles()
	local model = target:GetModel()
	local skin = target:GetSkin()

	target:Fire("open", "", 0.1)
	target:SetNotSolid(true)
	target:SetNoDraw(true)

	local function ResetDoor(door, fakedoor)
		if door:IsValid() and fakedoor:IsValid() then
			door.doorhealth = tonumber(GAMEMODE.Config["DoorHealth"])
			door:SetNotSolid(false)
			door:SetNoDraw(false)
			fakedoor:Remove()
		end
	end

	local push = self:GetPos():Normalize()
	local ent = ents.Create("prop_physics")

	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetModel(model)
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			
	if(skin) then
		ent:SetSkin(skin)
	end

	ent:Spawn()
	timer.Simple(tonumber(GAMEMODE.Config["DoorResetTime"]), function() ResetDoor(target, ent) end)
	coroutine.wait(self.AttackFinishTime)
	self:StartActivity( self.WalkAnim )
end

function ENT:Teleport()
	local pos = self:GetPos() + Vector(math.random(-350,350), math.random(-350,350), 140)
	if !util.IsInWorld(pos) then timer.Simple(0.1, function() self:Teleport() end) return false end

	self:SetPos(pos)
	self:DropToFloor()
end

function ENT:Teleport_NPC(ent)
	local Teleport_NPC_2 = self.Teleport_NPC --back it up for some reason not to cause any errors
	if !ent or !IsValid(ent) then return end
	local pos = ent:GetPos() + Vector(math.random(-250,250), math.random(-250,250), 100)
	if !util.IsInWorld(pos) then timer.Simple(0.1, function() Teleport_NPC_2(ent) end) return false end

	ent:SetPos(pos)
	ent:DropToFloor()
end
