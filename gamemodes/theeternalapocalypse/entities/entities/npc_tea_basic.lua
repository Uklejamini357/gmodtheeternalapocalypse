AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Shambler Zombie"
ENT.Category = "TEA Zombies"
ENT.Purpose = "A zombie that attack you and can infect"
ENT.Author = "Uklejamini"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model = "models/zombie/classic.mdl"

list.Set("NPC", "npc_tea_basic", {
	Name = ENT.PrintName,
	Class = "npc_tea_basic",
	Category = ENT.Category
})

function ENT:SetUpStats()

-- animations for the StartActivity function
	self.AttackAnim = ACT_MELEE_ATTACK1
	self.WalkAnim = ACT_WALK
	self.RunAnim = ACT_WALK
	self.IdleAnim = ACT_RESET

	self.FlinchAnim = ACT_FLINCH_PHYSICS
	self.FallAnim = ACT_IDLE_ON_FIRE


	self.ZombieStats = {
		["Damage"] = 31, -- how much damage per strike?
		["PropDamage"] = 35, -- damage done to props per attack (normal damage is not impacted)
		["Force"] = 400, -- how far to knock the player back upon striking them
		["Infection"] = 8, -- percentage chance to infect them
		["Reach"] = 60, -- how far can the zombies attack reach? in source units
		["StrikeDelay"] = 0.8, -- how long does it take for the zombie to deal damage after beginning an attack
		["AfterStrikeDelay"] = 1, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

		["Health"] = 145, -- self explanatory
		["MoveSpeedWalk"] = 60, -- zombies move speed when idly wandering around
		["MoveSpeedRun"] = 83, -- zombies move speed when moving towards a target
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

	self.Hit = {
		"npc/zombie/claw_strike1.wav",
		"npc/zombie/claw_strike2.wav",
		"npc/zombie/claw_strike3.wav"
	}
	self.HitProp = Sound("npc/zombie/zombie_hit.wav")
	self.Miss = Sound("npc/zombie/claw_miss1.wav")

	self.CanScream = true
	self.RageLevel = 1
	self.SpeedBuff = 1

	self.Ability1CD = CurTime()
end

function ENT:CanSeeTarget()
	if !self:IsValid() then return false end

	if self.target then
		local tracedata = {}
		tracedata.start = self:GetPos() + self:OBBCenter()
		tracedata.endpos = self.target:GetPos() + self.target:OBBCenter()
		tracedata.filter = function(ent) return ent == self.target or string.sub(ent:GetClass(), 1, 5) == "prop_" end --ent == self.target or ent == NULL end
		local trace = util.TraceLine(tracedata)
		return not trace.HitWorld and (self.target == trace.Entity)
	end

	return false
end


function ENT:Precache()

--Models--
	util.PrecacheModel(self.Model)

end


function ENT:GetTEAZombieSpeedMul()
	return math.min(self:GetEliteVariant() == VARIANT_ENRAGED and 1.6 or 1, 2 - (self:Health() / self:GetMaxHealth())) * math.Clamp(1+(self:GetZombieLevel()-20)*0.01, 1, 1.25) * GAMEMODE.ZombieSpeedMultiplier * self.SpeedBuff
end

local ai_disabled = GetConVar("ai_disabled")

function ENT:Initialize()
	self:SetCollisionBounds(Vector(-12,-12, 0), Vector(12, 12, 64))
	self:SetModel(self.Model)
	self:PhysicsInitShadow(true)
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false)
	end
	if CLIENT then return end
	self:SetUpStats()
	self.NextVehicleCollide = CurTime()
	self.loco:SetDeathDropHeight(700)
	self.loco:SetStepHeight(32)
	self.loco:SetClimbAllowed(false)
	self:SetHealth(self.ZombieStats["Health"])
	self:SetMaxHealth(self.ZombieStats["Health"])
	self:SetLagCompensated(true)
	self.NxtTick = 5
	self.NextPainSound = CurTime()

	if not ai_disabled:GetBool() then
		self:FindTarget()
	end
end


function ENT:DelayedCallback(delay, callback)
	timer.Simple(delay, function()
		if self:IsValid() then
			callback()
		end
	end)
end

function ENT:OnContact(ent)
	if self.NextVehicleCollide > CurTime() then return end
	if ent:IsVehicle() and ent:GetVelocity():Length() > 300 then
		ent:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, math.random(80, 90))

		local ded2 = DamageInfo()
		ded2:SetDamage(0)
		ded2:SetDamageType(DMG_VEHICLE)
		local f = (ent:GetPos() - self:GetPos() * 200) * ent:GetVelocity():Length() / 3000
		ded2:SetDamageForce(f)
		ent:TakeDamageInfo(ded2)

		-- print("taken: "..math.min((self:Health() / 4), ent:GetVelocity():Length() / 28).." | dealt: "..ent:GetVelocity():Length() / 2.5)

		local ded = DamageInfo()
		ded:SetDamage(ent:GetVelocity():Length())
		ded:SetDamageType(DMG_VEHICLE)
		if ent:GetDriver():IsValid() then ded:SetAttacker(ent:GetDriver()) else ded:SetAttacker(game.GetWorld()) end
		self:TakeDamageInfo(ded)

		self.NextVehicleCollide = CurTime() + 0.5
	end
end

function ENT:Think()
	if !SERVER then return end
	if !IsValid(self) then return end

	local phy=self:GetPhysicsObject()
	if IsValid(phy) then
		phy:SetPos(self:GetPos())
		phy:SetAngles(self:GetAngles())
	end
	
-- need to slowly drown them in water or else they will just skip happily along the sea floor
	if self:WaterLevel() >= 3 and self:Health() > 0 then
		local drown = DamageInfo()
		drown:SetDamage(math.Clamp(self:GetMaxHealth() * 0.005, 1, 10))
		drown:SetDamageType(DMG_DIRECT + DMG_DROWN)
		drown:SetAttacker(game.GetWorld())
		drown:SetInflictor(game.GetWorld())
		drown:SetDamageForce(Vector(0, 0, 0))
		self:TakeDamageInfo(drown)
		self.LastAttacker = nil -- if you try killing zombies by water, don't think about it.
	end
end


function ENT:SpecialSkill1()
	return true
end


function ENT:RunBehaviour()
	while (true) do
		if CLIENT then return end
		if ai_disabled:GetBool() then
			coroutine.wait(0.1)
			coroutine.yield()
			continue
		end

		local target = self.target
		local selfpos = self:GetPos()
		local cantarget = IsValid(target) and (target:IsPlayer() and target:Alive() or target:IsNPC() and target:Health() > 0) and not (target:IsFlagSet(FL_NOTARGET) or target.AdminMode)

		if cantarget and (self:GetRangeTo(target) <= (1500 * self.RageLevel) or GAMEMODE.ZombieApocalypse) then
			self.loco:FaceTowards(target:GetPos())

-- check if we are obstructed by props and smash them if we are
			local breakshit = ents.FindInSphere(selfpos + self:GetAngles():Up() * 55, 45)

			for k,v in pairs(breakshit) do
				if v:IsValid() then
					if v:GetClass() == "prop_flimsy" or v:GetClass() == "prop_strong" or GAMEMODE.SpecialStructureSpawns[v:GetClass()] then
						self:AttackProp(v)
						break
					elseif v:GetClass() == "prop_door_rotating" and not v:GetNoDraw() then
						self:AttackDoor(v)
						break
					else continue end
				end
			end


-- run our first ability
			if self.ZombieStats["Ability1"] and self:GetRangeTo(target) <= self.ZombieStats["Ability1Range"] then

				if self.Ability1CD <= CurTime() then
					if self.CanSpecialSkill1 and self:CanSpecialSkill1() or not self.CanSpecialSkill1 then
						timer.Simple(self.ZombieStats["Ability1TrigDelay"], function()
							if !self:IsValid() then return false end
							self:SpecialSkill1()
						end)
						self.Ability1CD = CurTime() + self.ZombieStats["Ability1Cooldown"]
					end
				end
			end

-- check if we have a player within arms reach and bash them if they are
			if (self:GetRangeTo(target) <= self.ZombieStats["Reach"] * 0.8 && self:CanSeeTarget()) then

				self:AttackPlayer(target)

				self:StartActivity(self.AttackAnim)
				coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
				self:StartActivity(self.WalkAnim)	


-- we can see a player but we cant reach them so lets go fuck their shit up
			else
				local distance = selfpos:Distance(target:GetPos())
				if self:GetActivity() != self.RunAnim then
					self:StartActivity(self.RunAnim)
				end

				self.loco:SetDesiredSpeed(self.ZombieStats["MoveSpeedRun"] * self:GetTEAZombieSpeedMul())

				local tr = util.TraceLine({
					start = target:GetPos(),
					endpos = target:GetPos() + Vector(0,0,-200)
				})

				self:GotoPos(tr.HitPos)
			end

-- failed all above checks, they arent in range so we lose interest and go back to wandering (or just standing there waiting to wander around)
		else
			self.target = nil
			self.CanScream = true
			if true then--math.random(10) == 1 -- Not yet.
				local success
				for i=1,10 do -- repeat 10 times to find the suitable path for the zombie
					local pos = self:GetPos() + Vector(math.random(-256, 256), math.random(-256, 256), math.random(-20,20))
					local nav = navmesh.GetNearestNavArea(pos, false, 500, false, true, -2)
					local reachpos
					if nav then
						if nav:IsUnderwater() then
							continue -- attempt to find another position to go to
						end
						if self.loco:IsAreaTraversable(nav) then
							reachpos = nav:GetClosestPointOnArea(pos)
						end
					end
					if reachpos then
						self:StartActivity(self.WalkAnim)
						self.loco:SetDesiredSpeed(self.ZombieStats["MoveSpeedWalk"])
						local result = self:MoveToPos(reachpos, {
							-- repath = 1,
							maxage = 3,
						})
					end

					success = true
					break
				end
			else
				if self:GetActivity() != (self.IdleAnim or ACT_IDLE) then
					self:StartActivity(self.IdleAnim or ACT_IDLE)
				end
				coroutine.wait(1)
			end
			
			if self.NxtTick < 1 then
				if math.random(1, 50) < 25 then
					self:EmitSound(table.Random(self.IdleSounds))
				end

				self.NxtTick = 5
			else
				self.NxtTick = self.NxtTick - 1
			end

-- find ourselves a new target
			if (!self.target) then
				self:FindTarget()
			end

		end
		coroutine.yield()
	end
end

function ENT:FindTarget()
	local targets = {}
	for _, ent in pairs(ents.FindInSphere(self:GetPos(), 1200 * self.RageLevel)) do
		if ent:IsNPC() and ent:Health() > 0 or ent:IsPlayer() and ent:Alive() and not (ent:IsFlagSet(FL_NOTARGET) or ent.AdminMode) then
			targets[ent] = self:GetRangeTo(ent)
		end
	end
	if GAMEMODE.ZombieApocalypse then
		for _, ent in pairs(player.GetAll()) do
			if ent:Alive() and not (ent:IsFlagSet(FL_NOTARGET) or ent.AdminMode) and not targets[ent] then
				targets[ent] = self:GetRangeTo(ent)
			end
		end
	end

	table.sort(targets, function(a,b) return a < b end)

	for ent,_ in SortedPairsByValue(targets) do
		self.target = ent
		if self.CanScream then
			self:EmitSound(table.Random(self.AlertSounds), 90, math.random(90, 110))
			self.CanScream = false
		end

		break
	end

end

function ENT:GotoPos(pos)
	local target = self.target
	local nav = navmesh.GetNearestNavArea(pos, false, 2000, false, true, -2)
	local reachpos
	if nav then
		if self.loco:IsAreaTraversable(nav) then
			reachpos = nav:GetClosestPointOnArea(target:GetPos())
		end
	end
	if self:CanSeeTarget() and self:GetRangeTo(target) < 800 or not nav then
		self.loco:FaceTowards(pos)
		self.loco:Approach(pos, 1)
	elseif reachpos then
		local result = self:MoveToPos(reachpos or target:GetPos(), {
			tolerance = self.ZombieStats["Reach"],
			maxage = self:GetRangeTo(target) >= 1500 and 2 or 1,
			repath = self:GetRangeTo(target) >= 1500 and 2 or 1,
		})
	end
end

function ENT:OnLandOnGround()
	if self.LandingSounds then
		local snd = table.Random(self.LandingSounds)
		self:EmitSound(snd)
	else
		self:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
	end
end



function ENT:OnKilled(damageInfo)
	local attacker = damageInfo:GetAttacker()

	self:EmitSound(table.Random(self.DieSounds), 100, math.random(75, 130))
	self:BecomeRagdoll(damageInfo)

	gamemode.Call("OnNPCKilled", self, damageInfo:GetAttacker(), damageInfo:GetInflictor())
end

function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	if self.NextPainSound < CurTime() and damageInfo:GetDamage() < self:Health() then
		self.NextPainSound = CurTime() + 0.6
		self:EmitSound(table.Random(self.PainSounds), 100, math.random(90, 110))
	end
	if !attacker:IsValid() then return end
	local range = self:GetRangeTo(attacker)
	if attacker:IsPlayer() then
		self:FindTarget()
	end
	if self.RageLevel <= 2 then
		self.RageLevel = 2
	end
	
	damageInfo = self:OnInjuredAlt(damageInfo)
end

function ENT:OnInjuredAlt(dmginfo)
	return dmginfo
end


function ENT:AttackPlayer(target)
	if !target:IsValid() or !self:IsValid() then return false end
	self:EmitSound(table.Random(self.AttackSounds), 100, math.random(95, 105))

	-- swing those claws baby
	self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 0.75, function()
		self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
	end)

	-- actually apply the damage
	self:DelayedCallback(self.ZombieStats["StrikeDelay"], function()
	if !self:IsValid() or self:Health() < 1 then return end

		if (IsValid(target) and self:GetRangeTo(target) <= self.ZombieStats["Reach"]) then
			self:ApplyPlayerDamage(target, self.ZombieStats["Damage"], -self.ZombieStats["Force"], self.ZombieStats["Infection"])
		end
	end)

	-- check if we killed the guy and find a new target if we did
	self:DelayedCallback(self.ZombieStats["StrikeDelay"] * 1.2, function()
		if target:IsValid() and (target:IsPlayer() and !target:Alive() or target:IsNPC() and target:Health() <= 0) then
			self.target = nil
		end
	end)

	return false
end



function ENT:AttackProp(target)
	if !target:IsValid() then return false end
	self:EmitSound(table.Random(self.AttackSounds), 90, math.random(85, 95))
	
	self:StartActivity(self.AttackAnim)
	self:SetPlaybackRate(self.ZombieStats["StrikeAnimSpeed"] or 1)

	coroutine.wait(self.ZombieStats["StrikeDelay"])
	self:EmitSound(self.Miss)

	if !target:IsValid() then return end
	local phys = target:GetPhysicsObject()
	if (phys != nil && phys != NULL && phys:IsValid()) then
		local snd = istable(self.HitProp) and table.Random(self.HitProp) or self.HitProp

		phys:ApplyForceCenter(self:GetForward():GetNormalized()*30000 + Vector(0, 0, 2))
		target:EmitSound(snd, 100, math.random(80, 110))
		target:EmitSound(self.DoorBreak)
		target:TakeDamage(self.ZombieStats["PropDamage"] or self.ZombieStats["Damage"], self)	
		util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 300)
	end
	coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
	self:StartActivity(self.WalkAnim)
end




function ENT:AttackDoor(target)
	if !target:IsValid() or !target:GetClass() == "prop_door_rotating" then return false end

	self:EmitSound(table.Random(self.AttackSounds), 90, math.random(85, 95))

	self:StartActivity(self.AttackAnim)
	self:SetPlaybackRate(self.ZombieStats["StrikeAnimSpeed"] or 1)
	coroutine.wait(self.ZombieStats["StrikeDelay"])
	if target:GetNoDraw() then
		coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
		self:StartActivity(self.WalkAnim)
		return
	end

	local snd = istable(self.HitProp) and table.Random(self.HitProp) or self.HitProp
	target:EmitSound(snd, 100, math.random(80, 110))
	target.doorhealth = target.doorhealth - (self.ZombieStats["PropDamage"] or self.ZombieStats["Damage"])
	
	if target.doorhealth >= 0 then
		util.ScreenShake(target:GetPos(), 5, 5, math.Rand(0.2, 0.4), 300)
		coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
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
	coroutine.wait(self.ZombieStats["AfterStrikeDelay"])
	self:StartActivity(self.WalkAnim)
end



function ENT:ApplyPlayerDamage(ply, damage, hitforce, infection)
	if !ply:IsValid() or !ply:IsPlayer() and ply:Health() <= 0 or ply:IsPlayer() and !ply:Alive() then return end
	local dmg1 = tonumber(damage)
	
	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(self)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamage(ply:IsPlayer() and dmg1 * ply:GetArmorDamageMultiplier() or dmg1)
	dmginfo:SetDamageType(DMG_CLUB)

	local distancevector = self:GetPos() - ply:GetPos()
	local force = (distancevector / distancevector:Length()) * hitforce
	force.z = 32
	dmginfo:SetDamageForce(force)

	ply:TakeDamageInfo(dmginfo)
	local snd = istable(self.Hit) and table.Random(self.Hit) or self.Hit
	ply:EmitSound(snd, 100, math.random(80, 110))
	ply:SetVelocity(force)
	if ply:IsPlayer() then
		ply:ViewPunch(VectorRand():Angle() * 0.05)
		if math.random(0, 100) < infection then
			ply:AddInfection(math.random(60,300) * math.max(infection/100, 1))
		end
	end
end

function ENT:OnStuck()
	local pos = self:GetPos() + self:GetAngles():Forward()*-90 + Vector(0,0,32)

	local nav = navmesh.GetNearestNavArea(pos, false, 300, false, true, -2)
	local reachpos
	if nav then
		if self.loco:IsAreaTraversable(nav) then
			reachpos = nav:GetClosestPointOnArea(pos)
		end
	end

	self:SetPos(reachpos or pos)
	self:DropToFloor()

	self.loco:ClearStuck()
end
