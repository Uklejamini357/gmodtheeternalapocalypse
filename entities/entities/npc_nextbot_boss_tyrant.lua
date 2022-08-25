AddCSLuaFile()

-- todo: recode this on new zombie base

ENT.Base = "base_nextbot"
ENT.PrintName = "The Tyrant"
ENT.Category = "a"
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AttackAnim = (ACT_MELEE_ATTACK1)
ENT.WalkAnim = (ACT_WALK_HURT)
ENT.RunAnim = (ACT_RUN)

ENT.FlinchAnim = (ACT_FLINCH_PHYSICS)
ENT.FallAnim = (ACT_IDLE_ON_FIRE)

ENT.AttackWaitTime = 1.5
ENT.AttackFinishTime = 0.5

ENT.CanScream = true
ENT.RageLevel = 1 -- RageLevel increases zombies perception radius
ENT.SpeedBuff = 1

ENT.StepSound = "npc/dog/dog_footstep1.wav"

-- sound
ENT.Attack1 = Sound("npc/zombie/zo_attack1.wav")
ENT.Attack2 = Sound("npc/zombie/zo_attack2.wav")

ENT.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

ENT.Alert1 = Sound("npc/antlion_guard/angry1.wav")
ENT.Alert2 = Sound("npc/antlion_guard/angry2.wav")
ENT.Alert3 = Sound("npc/antlion_guard/angry3.wav")

ENT.Death1 = Sound("npc/zombie/zombie_die1.wav")
ENT.Death2 = Sound("npc/zombie/zombie_die2.wav")
ENT.Death3 = Sound("npc/zombie/zombie_die3.wav")

ENT.Flinch1 = Sound("npc/zombie/zombie_voice_idle10.wav")
ENT.Flinch2 = Sound("npc/zombie/zombie_voice_idle11.wav")
ENT.Flinch3 = Sound("npc/zombie/zombie_voice_idle12.wav")

ENT.Fall1 = Sound("npc/zombie/zombie_voice_idle11.wav")
ENT.Fall2 = Sound("npc/zombie/zombie_voice_idle13.wav")

ENT.Idle1 = Sound("npc/antlion_guard/frustrated_growl1.wav")
ENT.Idle2 = Sound("npc/antlion_guard/frustrated_growl2.wav")
ENT.Idle3 = Sound("npc/antlion_guard/frustrated_growl3.wav")

ENT.Pain1 = Sound("npc/antlion_guard/angry1.wav")
ENT.Pain2 = Sound("npc/antlion_guard/angry2.wav")
ENT.Pain3 = Sound("npc/antlion_guard/angry3.wav")

ENT.Hit = Sound("npc/zombie/claw_strike1.wav")
ENT.Miss = Sound("npc/zombie/claw_miss1.wav")

/*
for i = 2, 4 do
	util.PrecacheModel("models/zed/malezed_0"..(i * 2)..".mdl")
end
*/



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

function ENT:Initialize()

	self.DamagedBy = {}
	self:SetModel("models/sin/quadralex.mdl")
--	self.breathing = CreateSound(self, "npc/zombie_poison/pz_breathe_loop1.wav")
--	self.breathing:Play()
--	self.breathing:ChangePitch(60, 0)
--	self.breathing:ChangeVolume(0.3, 0)
	if SERVER then
		self.loco:SetDeathDropHeight(700) --bug with tyrant fixed?
		self.loco:SetAcceleration(800)
		self:SetHealth(30000)
		self:SetMaxHealth(30000)
	end
	self.IsEnraged = 0
	self:SetModelScale(0.8, 0)
	self:SetCollisionBounds(Vector(-34,-34, 0), Vector(34, 34, 84))
	--	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	--	self:SetSkin(math.random(0, self:SkinCount() - 1))
	
	self.NextPainSound = CurTime()
	self.nexttoss = CurTime()
	self.nextslam = CurTime()

	timer.Simple(1200, function()
		if self:IsValid() and SERVER then --it was rare bug that runs clientside and creates clientside error
			self:Remove()
			SystemBroadcast("[BOSS]: The Tyrant was not killed and has left the area!", Color(255,105,105,255), false)
		end
	end)

	hook.Add("EntityRemoved", self, function()
		if self.breathing then
			self.breathing:Stop()
			self.breathing = nil
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

end

function ENT:RunBehaviour()
	while (true) do
		if CLIENT then return end
		local target = self.target

		if (IsValid(target) and target:Alive()) then
			local data = {}
			data.start = self:GetPos()
			data.endpos = self:GetPos() + self:GetForward()*128
			data.filter = self
			data.mins = self:OBBMins() * 0.65
			data.maxs = self:OBBMaxs() * 0.65
			local trace = util.TraceHull(data)
			local entity = trace.Entity

			if math.random(1,1000) < 25 then
				local sounds = {}
				sounds[1] = (self.Idle1)
				sounds[2] = (self.Idle2)
				sounds[3] = (self.Idle3)
				self:EmitSound(sounds[math.random(1,3)])
			end
		end

		if (IsValid(target) and target:Alive() and self:GetRangeTo(target) <= (2500 * self.RageLevel)) then
			self.loco:FaceTowards(target:GetPos())

			if (self:GetRangeTo(target) <= 400 && self.nextslam < CurTime() && self:HasLOS()) then 
				self:StartActivity(ACT_RANGE_ATTACK1)
				self:TimedEvent(3.2, function()
					if not (self:IsValid() && self:Health() > 0) then return end
					self:EmitSound("npc/env_headcrabcanister/explosion.wav", 140, 100)
					local effectdata = EffectData()
					effectdata:SetOrigin(self:GetPos())
					effectdata:SetScale(2)
					effectdata:SetMagnitude(1)
					util.Effect("HelicopterMegaBomb", effectdata)

					local effectdata = EffectData()
					effectdata:SetOrigin(self:GetPos())
					effectdata:SetMagnitude(15)
					effectdata:SetScale(150)
					effectdata:SetRadius(50)
					util.Effect("ThumperDust", effectdata)

					util.ScreenShake(self:GetPos(), 120, 30, 2, 800)

					local slammed = ents.FindInSphere(self:GetPos(), 1000)

					for k, v in pairs(slammed) do
						if v:IsPlayer() and v:Alive() and v:IsOnGround() then 
							if self.IsEnraged == 1 then
								local damageInfo = DamageInfo()
								damageInfo:SetAttacker(self)
								damageInfo:SetDamage(65 * (1 - (v.StatDefense * 0.015)))
								damageInfo:SetDamageType(DMG_CLUB)

								v:TakeDamageInfo(damageInfo)
								v:SetVelocity(Vector(math.random(-100, 100),math.random(-100, 100),350))
							else
								local damageInfo = DamageInfo()
								damageInfo:SetAttacker(self)
								damageInfo:SetDamage(50 * (1 - (v.StatDefense * 0.015)))
								damageInfo:SetDamageType(DMG_CLUB)

								v:TakeDamageInfo(damageInfo)
								v:SetVelocity(Vector(math.random(-100, 100),math.random(-100, 100),300))
							end
						elseif v:GetPhysicsObject():IsValid() then
							v:GetPhysicsObject():SetVelocity(Vector(math.random(-100, 100),math.random(-100, 100),300))
						end
					end
				end)
				coroutine.wait(4)

				self.nextslam = CurTime() + 25


			elseif (self:GetRangeTo(target) <= 1000 && self.nexttoss < CurTime() && self:HasLOS()) then 

				self:StartActivity(self.AttackAnim)
				coroutine.wait(1)

				local tracedata = {}
				tracedata.start = self:GetPos() + Vector(0, 0, 40)
				tracedata.endpos = self.target:GetPos() + Vector(0, 0, 40)
				tracedata.filter = self
				local trace = util.TraceLine(tracedata)

				local spit = ents.Create("obj_bigrock")
				if !spit:IsValid() then return false end
				spit:SetAngles(Angle(math.random(0,360), math.random(0,360), math.random(0,360)))
				spit:SetPos(self:GetPos() + self:GetAngles():Up() * 40)
				spit:Spawn()
				spit:Activate()
				spit.Zed = self.Entity
				local phys = spit:GetPhysicsObject()
				phys:AddAngleVelocity(Vector(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
				phys:SetVelocity(trace.Normal * 1000 + (self:GetAngles():Up() * (self:GetPos():Length(trace.HitPos) * 0.03)) + (self:GetAngles():Forward() * (self:GetPos():Length(trace.HitPos) * 0.03)))

				if self.IsEnraged == 1 then
					self.nexttoss = CurTime() + 6
				else
					self.nexttoss = CurTime() + 10
				end


			elseif (self:GetRangeTo(target) <= 110) then                                                     -- hit the player
				self:EmitSound("npc/antlion_guard/antlion_guard_pain1.wav", 120, math.random(95, 125))

				self:TimedEvent(0.5, function()
					self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav", 100, 70)
				end)

				self:TimedEvent(1, function()
					if not (self:IsValid() && self:Health() > 0) then return end
					
					if (IsValid(target) and self:GetRangeTo(target) <= 155) then
						if self.IsEnraged == 1 then			
							local damageInfo = DamageInfo()
							damageInfo:SetAttacker(self)
							damageInfo:SetDamage(math.random(50, 75) * (1 - (target.StatDefense * 0.015)))
							damageInfo:SetDamageType(DMG_CLUB)

							local force = target:GetAimVector() * -600
							force.z = 180

							damageInfo:SetDamageForce(force)
							target:TakeDamageInfo(damageInfo)
							target:EmitSound("npc/zombie/zombie_hit.wav", 100, math.random(60, 80))
							target:ViewPunch(VectorRand():Angle() * 0.05)
							target:SetVelocity(force)
							if math.random(0, 100) > 50 then
								target.Infection = target.Infection + math.Rand(200,750)
							end
						else
							local damageInfo = DamageInfo()
							damageInfo:SetAttacker(self)
							damageInfo:SetDamage(math.random(40, 60) * (1 - (target.StatDefense * 0.015)))
							damageInfo:SetDamageType(DMG_CLUB)

							local force = target:GetAimVector() * -600
							force.z = 180

							damageInfo:SetDamageForce(force)
							target:TakeDamageInfo(damageInfo)
							target:EmitSound("npc/zombie/zombie_hit.wav", 100, math.random(60, 80))
							target:ViewPunch(VectorRand():Angle() * 0.05)
							target:SetVelocity(force)
							if math.random(0, 100) > 50 then
								target.Infection = target.Infection + math.Rand(120,500)
							end
						end
					end
				end)

				self:TimedEvent(0.45, function()
					if (IsValid(target) and !target:Alive()) then
						target.target = nil
					end
				end)

				self:StartActivity(self.AttackAnim)

				coroutine.wait(self.AttackWaitTime)

				self:StartActivity(self.WalkAnim)	

			else
				self:StartActivity(self.RunAnim)

				if (self.breathing) then
					self.breathing:ChangePitch(80, 1)
					self.breathing:ChangeVolume(1.25, 1)
				end

--				if (math.random(1, 2) == 2 and (self.nextYell or 0) < CurTime()) then
--					self:EmitSound("npc/zombie_poison/pz_pain"..math.random(1, 3)..".wav", 80, math.random(30, 50))
--					self.nextYell = CurTime() + math.random(4, 8)
--				end
				
				if self.IsEnraged == 1 then
					self.loco:SetDesiredSpeed(400) 
				else
					self.loco:SetDesiredSpeed(250)
				end


				self:MoveToPos(target:GetPos(), {
					tolerance = 80,
					maxage = 2
				})
			end
		else
			self.target = nil
			self.CanScream = true
			self:StartActivity(self.WalkAnim)
			if self.IsEnraged == 1 then
				self.loco:SetDesiredSpeed(80)
			else
				self.loco:SetDesiredSpeed(65)
			end
			self:MoveToPos(self:GetPos() + Vector(math.random(-256, 256), math.random(-256, 256), 0), {
				repath = 3,
				maxage = 2
			})

			if (!self.target) then
				for k, v in pairs(player.GetAll()) do
					if (v:Alive() and self:GetRangeTo(v) <= (2500 * self.RageLevel)) then
--						self:AlertNearby(v)
						self.target = v
--						self:PlaySequenceAndWait("wave_smg1", 0.9)
						if self.CanScream == true then
							self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 100, 100)
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

local deathSounds = {
	"npc/antlion_guard/antlion_guard_die1.wav",
	"npc/antlion_guard/antlion_guard_die2.wav",
}


function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()

	if attacker:IsPlayer() then
	SystemBroadcast("[BOSS]: "..attacker:Nick().." has slain the Tyrant!", Color(255,105,105,255), false)
	else
	SystemBroadcast("[BOSS]: The Tyrant has been slain by an unknown cause!", Color(255,105,105,255), false)
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

	self:SetColor(Color(255,255,255,255))
	self:EmitSound(table.Random(deathSounds), 100, math.random(95, 105))
	self:BecomeRagdoll(damageInfo)
end

local painSounds = {
	"npc/antlion_guard/antlion_guard_pain1.wav",
	"npc/antlion_guard/antlion_guard_pain2.wav",
}

function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local dmg = damageInfo:GetDamage()
	local range = self:GetRangeTo(attacker)

	if self.NextPainSound < CurTime() and damageInfo:GetDamage() < self:Health() then
		self.NextPainSound = CurTime() + 0.8
		self:EmitSound(table.Random(painSounds), 100, math.random(50, 80))
	end

	if attacker:IsPlayer() then
	self.target = attacker
	end

	if attacker:IsPlayer() then
	if !self.DamagedBy[attacker] then self.DamagedBy[attacker] = math.Clamp(dmg, 0, self:GetMaxHealth())
	else
	self.DamagedBy[attacker] = math.Clamp(self.DamagedBy[attacker] + dmg, 0, self:GetMaxHealth())
	end
	end

	if (self:Health() - dmg) <= 10000 then
		self.RageLevel = 5
		self.loco:SetDesiredSpeed(400)
		if self.IsEnraged == 0 then
			SystemBroadcast("[BOSS]: The Tyrant is now Enraged!", Color(255,105,105,255), false)
			self.nexttoss = CurTime()
			self:SetColor(Color(255,128,128,255))
		end
		self.IsEnraged = 1
	else
		self.RageLevel = 3
	end
		
--	if(attacker:IsPlayer()) then
--	self:AlertNearby(attacker, 1000)
--	end
end

function ENT:AttackProp(targetprops)
--	local entstoattack = ents.FindInSphere(self:GetPos() + self:GetAngles():Up() * 55, 35)
	for _,v in pairs(targetprops) do
	
		if v:IsValid() and (v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong") then
			/*
			if SERVER then
			
			local sounds = {}
				sounds[1] = (self.Attack1)
				sounds[2] = (self.Attack2)
				self:EmitSound(sounds[math.random(1,2)])
			end
			*/
	
			self:StartActivity(self.AttackAnim)

			coroutine.wait(self.AttackWaitTime)
			self:EmitSound(self.Miss)
		
			local phys = v:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
			phys:ApplyForceCenter(self:GetForward():GetNormalized()*30000 + Vector(0, 0, 2))
			v:EmitSound(self.DoorBreak, 100, 60)
			v:TakeDamage(math.random(80, 100), self)	
			util.ScreenShake(v:GetPos(), 8, 6, math.Rand(0.3, 0.5), 400)
			end
		coroutine.wait(self.AttackFinishTime)
		self:StartActivity(self.WalkAnim)	
			return true
		end
	end
	return false
end