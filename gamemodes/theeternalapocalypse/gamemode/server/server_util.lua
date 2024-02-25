local function IsMeleeDamage(num)
	return (num == DMG_GENERIC or num == DMG_SLASH or num == DMG_CLUB)
end

local MT_PLAYER = FindMetaTable("Player")
local MT_ENTITY = FindMetaTable("Entity")

function MT_PLAYER:CheckPvPDamage(dmginfo)
	local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
	if self:IsPlayer() and attacker:IsPlayer() and self != attacker and !self:IsPvPForced() and self.Territory != team.GetName(attacker:Team()) then
		 
		if self:Alive() and attacker:IsPlayer() and self:IsPlayer() and (self:HasGodMode() or self.SpawnProtected) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("This target is invulnerable!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif self:Alive() and attacker:IsPlayer() and self:IsPlayer() and attacker:IsPvPGuarded() then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You have PvP guarded! You can't damage other players!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif self:Alive() and attacker:IsPlayer() and self:IsPlayer() and self:IsPvPGuarded() then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("Target has PvP guarded! You can't damage that player!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		end

		if self:Alive() and attacker:Team() == TEAM_LONER and attacker:GetNWBool("pvp") == false and GAMEMODE.VoluntaryPvP then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("Your PvP is not enabled!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif self:Alive() and self:Team() == TEAM_LONER and self:GetNWBool("pvp") == false and GAMEMODE.VoluntaryPvP then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You can't attack loners unless they have PvP enabled!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif self:Alive() and (self:Team() == attacker:Team()) and not (self:Team() == TEAM_LONER or attacker:Team() == TEAM_LONER) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:EntIndex()) then
				attacker:SystemMessage("You can't attack your factionmates!", Color(255,205,205), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:EntIndex(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		end

		self.PvPNoToggle = CurTime() + 60
		attacker.PvPNoToggle = CurTime() + 60
	end

	return true
end

function MT_PLAYER:ProcessPlayerDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local directdmg = bit.band(DMG_DIRECT, dmginfo:GetDamageType()) ~= 0

	if self.SpawnProtected then
		dmginfo:SetDamage(0)
		return false
	end
	
	for _, ent in pairs(ents.FindByClass("tea_trader")) do
		if ent:GetPos():DistToSqr(self:GetPos()) < 14400 then -- 120^2
			dmginfo:ScaleDamage(0.9)
			break
		end
	end

	if attacker == NULL then return true end

	local attackerclass = attacker:GetClass()
	local armorvalue = 0
	local plyarmor = self:GetNWString("ArmorType")
	local env_classes = {"trigger_hurt", "point_hurt", "entityflame", "env_fire"}
	
	if attacker:IsPlayer() then
		dmginfo:SetDamage(GAMEMODE:CalcPlayerDamage(self, dmginfo:GetDamage()))
/*
		if plyarmor and plyarmor != "none" then
			local armortype = GAMEMODE.ItemsList[plyarmor]
			armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
		end

		local defencebonus = 0.015 * self.StatDefense
		local armorbonus = armorvalue
		dmginfo:SetDamage(math.max(0, dmginfo:GetDamage() * (1 - (defencebonus + armorbonus))))
*/
	elseif env_classes[dmginfo:GetAttacker():GetClass()] then
		dmginfo:SetDamage(GAMEMODE:CalcEnvDamage(self, dmginfo:GetDamage()))
/*
		if plyarmor and plyarmor != "none" then
			local armortype = GAMEMODE.ItemsList[plyarmor]
			armorvalue = tonumber((armortype["ArmorStats"]["env_reduction"]) / 100)
		end
		
		local defencebonus = 0.01 * self.StatDefense
		local armorbonus = armorvalue
		dmginfo:ScaleDamage(1 - (defencebonus + armorbonus))
*/
	end

	if dmginfo:GetDamageType() == DMG_CRUSH and attackerclass == "obj_bigrock" then
		dmginfo:SetDamage(1 + (dmginfo:GetDamage() * 0.01))
	elseif dmginfo:GetDamageType() == DMG_CRUSH then
		dmginfo:ScaleDamage(0.5)
	end

	if !directdmg and self.UnlockedPerks["damageresistance"] then
		dmginfo:ScaleDamage(0.925)
	end


	--Players need to take more damage from explosions since thanks to armor they can tank some damage (but not the damage from themselves)
	if attackerclass != "trigger_hurt" and dmginfo:GetDamageType() == DMG_BLAST then
		dmginfo:ScaleDamage(1.45)
	end

	if self:Alive() and attacker != self and attacker:IsPlayer() and IsMeleeDamage(dmginfo:GetDamageType()) and (!self:IsPvPGuarded() and !attacker:IsPvPGuarded()) then
		attacker.MeleeDamageDealt = attacker.MeleeDamageDealt + math.Clamp(0.035 * dmginfo:GetDamage(), 0, 0.035 * self:Health())
		timer.Create("MeleeMasteryGain"..attacker:EntIndex(), 5, 1, function() if attacker:IsValid() then attacker:GainMasteryXP(attacker.MeleeDamageDealt, "Melee") attacker.MeleeDamageDealt = 0 end end)
	end

	if self:Alive() and attacker != self and attacker:IsPlayer() and (!self:IsPvPGuarded() and !attacker:IsPvPGuarded()) then
		if attacker:GetInfoNum("tea_cl_hitsounds", 1) >= 1 and attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3) > 0 and attacker.HitSoundEffect < CurTime() then
			attacker:SendLua("LocalPlayer():ConCommand(\"playvol \\\"theeternalapocalypse/hitsound.wav\\\" "..attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3).."\")")
			attacker.HitSoundEffect = CurTime() + 0.15
		end
		if GAMEMODE:GetDebug() >= DEBUGGING_ADVANCED then
			print("[Debug] "..attacker:Nick().." damage -> "..self:Nick().." with "..dmginfo:GetDamage().." damage")
		end
	end

	if attacker.IsZombie then
		dmginfo:ScaleDamage(GAMEMODE:GetInfectionMul(0.5)) -- +0.5% damage per 1% infection

		if self:IsNewbie() then
			dmginfo:ScaleDamage(0.9)
		end	

		if attacker:GetEliteVariant() == VARIANT_POISONOUS then
			self.PoisonDamage = self.PoisonDamage + math.floor(dmginfo:GetDamage())
		elseif attacker:GetEliteVariant() == VARIANT_SHOCK and self.LastStunTime + 0.5 < CurTime() and math.random(2) == 1 then -- 50% chance
			for i=0,0.2,0.1 do
				timer.Simple(i, function()
					local eff = EffectData()
					eff:SetOrigin(self:GetPos())
					eff:SetMagnitude(9)
					util.Effect("TeslaHitboxes", eff)
				end)
			end

			self.LastStunTime = CurTime()
			self:Freeze(true)
			timer.Simple(0.25, function()
				self:Freeze(false)
			end)
		elseif attacker:GetEliteVariant() == VARIANT_OVERPOWERED then
			dmginfo:ScaleDamage(1.35)
		elseif attacker:GetEliteVariant() == VARIANT_INFECTIVE then
			self:AddInfection(dmginfo:GetDamage() * 10) -- 1% of infection for every 10% damage
		elseif attacker:GetEliteVariant() == VARIANT_SICKNESS then
			self.SicknessDuration = CurTime() + dmginfo:GetDamage() * 0.1
		elseif attacker:GetEliteVariant() == VARIANT_LEECH then
			attacker:SetHealth(math.min(attacker:GetMaxHealth(), attacker:Health() + (dmginfo:GetDamage() * 2)))
		end
	end

	return true
end

function MT_ENTITY:ProcessDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local directdmg = bit.band(DMG_DIRECT, dmginfo:GetDamageType()) ~= 0
	if attacker:IsPlayer() then
		if IsMeleeDamage(dmginfo:GetDamageType()) then
			dmginfo:ScaleDamage(1 + (0.01 * attacker.StatStrength) + (0.005 * math.Clamp(attacker.MasteryMeleeLevel, 0, 10)))
		end
		if self:IsNextBot() or self:IsNPC() then
			if IsMeleeDamage(dmginfo:GetDamageType()) then
				attacker.MeleeDamageDealt = attacker.MeleeDamageDealt + math.Clamp(0.05 * dmginfo:GetDamage(), 0, 0.05 * self:Health())
				timer.Create("MeleeMasteryGain"..attacker:EntIndex(), 5, 1, function() if attacker:IsValid() then attacker:GainMasteryXP(attacker.MeleeDamageDealt, "Melee") attacker.MeleeDamageDealt = 0 end end)
			end
			if attacker:GetInfoNum("tea_cl_hitsounds", 1) >= 1 and attacker:GetInfoNum("tea_cl_hitsounds_volnpc", 0.225) > 0 and attacker.HitSoundEffect < CurTime() then
				attacker:SendLua("LocalPlayer():ConCommand(\"playvol \\\"theeternalapocalypse/hitsound.wav\\\" "..attacker:GetInfoNum("tea_cl_hitsounds_volnpc", 0.225).."\")")
				attacker.HitSoundEffect = CurTime() + 0.15
			end
		end
	end

	if attacker:IsPlayer() and dmginfo:IsBulletDamage() then
		dmginfo:ScaleDamage(1 + (attacker.StatGunslinger * 0.01))
	end

	-- This is so RNG...
	if attacker:IsPlayer() and attacker.UnlockedPerks["criticaldamage"] and !directdmg and math.random(15) == 1 then
		dmginfo:ScaleDamage(1.2)
	end

	if attacker.IsZombie and self.IsPropBarricade then
		dmginfo:ScaleDamage(GAMEMODE:GetInfectionMul(0.5)) -- +0.5% damage to barricade per 1% infection
	end

	return true
end

function MT_ENTITY:ProcessNPCDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()
	local directdmg = bit.band(DMG_DIRECT, dmginfo:GetDamageType()) ~= 0
	if attacker == NULL then return true end
	if attacker:GetClass() == "tea_trader" or attacker:GetClass() == "tea_taskdealer" then return false end

	if attacker:GetClass() != "trigger_hurt" and dmginfo:GetDamageType() == DMG_BLAST and (self:IsNextBot() or self:IsNPC()) then --AI NPCs and nextbots need to take more damage if they take explosive damage so it will be much better and explosives will be more useful (What about explosive crossbow?!?!?)
		dmginfo:ScaleDamage(1.85)
	end

	if !directdmg and self.IsZombie then
		dmginfo:ScaleDamage(1 / GAMEMODE:GetInfectionMul())

		if !self.BossMonster and attacker:IsPlayer() and attacker.UnlockedPerks["celestiality"] then
			if self:GetEliteVariant() ~= 0 then
				dmginfo:ScaleDamage(1.1)
			else
				dmginfo:ScaleDamage(1.03)
			end
		end

		if inflictor == attacker and (attacker:IsPlayer() or attacker:IsNPC()) then
			inflictor = attacker:GetActiveWeapon()
			if !inflictor:IsValid() then inflictor = attacker end
		end

		if self:GetEliteVariant() == VARIANT_REFLECTOR and IsMeleeDamage(dmginfo:GetDamageType()) and attacker:IsPlayer() and attacker:Alive() then
			local damageinfo = DamageInfo()
			damageinfo:SetDamage(dmginfo:GetDamage() * 0.15)
			damageinfo:SetDamageType(dmginfo:GetDamageType())
			damageinfo:SetAttacker(self)
			damageinfo:SetInflictor(dmginfo:GetInflictor())
			timer.Simple(0, function()
				attacker:TakeDamageInfo(damageinfo)
			end)
		end
	end

	if attacker:IsPlayer() and attacker:IsNewbie() and self.IsZombie then
		dmginfo:ScaleDamage(1.15)
	end
	return true
end


function GM:ScalePlayerDamage(ent, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local headdmg = 2

	if inflictor == attacker and (attacker:IsPlayer() or attacker:IsNPC()) then
		inflictor = attacker:GetActiveWeapon()
		if !inflictor:IsValid() then inflictor = attacker end
	end

	if inflictor:IsValid() and inflictor.HeadshotDamageMulti then
		headdmg = inflictor.HeadshotDamageMulti
	end

	if hitgroup == HITGROUP_HEAD then dmginfo:ScaleDamage(headdmg)
	elseif hitgroup == HITGROUP_CHEST then dmginfo:ScaleDamage(1)
	elseif hitgroup == HITGROUP_STOMACH then dmginfo:ScaleDamage(0.8)
	elseif hitgroup == HITGROUP_LEFTARM then dmginfo:ScaleDamage(0.35)
	elseif hitgroup == HITGROUP_RIGHTARM then dmginfo:ScaleDamage(0.35)
	elseif hitgroup == HITGROUP_LEFTLEG then dmginfo:ScaleDamage(0.35)
	elseif hitgroup == HITGROUP_RIGHTLEG then dmginfo:ScaleDamage(0.35)
	elseif hitgroup == HITGROUP_GEAR then dmginfo:ScaleDamage(0.1) -- ????
	end

	-- the other half of this logic is within the actual trader entity, should stop queerbaits from trader camping with pvp on
	if ent:IsPvPGuarded() or (attacker:IsPlayer() and attacker:IsPvPGuarded()) then
		dmginfo:SetDamage(0)
	end

/*
	for _, entity in pairs (ents.FindByClass("tea_trader")) do
		if attacker:IsPlayer() and (entity:GetPos():Distance(ply:GetPos()) < 120 or entity:GetPos():Distance(attacker:GetPos()) < 120) then
			dmginfo:SetDamage(0)
		end
	end
*/

	return dmginfo
end

function GM:ScaleNPCDamage(ent, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local headdmg = 2

	if inflictor == attacker and (attacker:IsPlayer() or attacker:IsNPC()) then
		inflictor = attacker:GetActiveWeapon()
		if !inflictor:IsValid() then inflictor = attacker end
	end

	if inflictor:IsValid() and inflictor.HeadshotDamageMulti then
		headdmg = inflictor.HeadshotDamageMulti
	end

	if hitgroup == HITGROUP_HEAD then dmginfo:ScaleDamage(headdmg)
	elseif hitgroup == HITGROUP_CHEST then dmginfo:ScaleDamage(1)
	elseif hitgroup == HITGROUP_STOMACH then dmginfo:ScaleDamage(0.8)
	elseif hitgroup == HITGROUP_LEFTARM then dmginfo:ScaleDamage(0.5)
	elseif hitgroup == HITGROUP_RIGHTARM then dmginfo:ScaleDamage(0.5)
	elseif hitgroup == HITGROUP_LEFTLEG then dmginfo:ScaleDamage(0.25)
	elseif hitgroup == HITGROUP_RIGHTLEG then dmginfo:ScaleDamage(0.25)
	elseif hitgroup == HITGROUP_GEAR then dmginfo:ScaleDamage(0.1) -- ????
	end

	return dmginfo
end

/*
net.Receive("Respawn", function(length, ply)
	if ply.RespawnTime < CurTime() then
		ply:Spawn()
	end
end)
*/

function GM:PlayerDeathThink(ply)
/* -- Auto-Respawn?
	if ply.RespawnTime >= CurTime() then
		ply:PrintMessage(HUD_PRINTCENTER, "Respawn in:"..math.ceil(ply.RespawnTime - CurTime()))
	else
		ply:Spawn()
	end
*/

	if (ply:KeyPressed(IN_ATTACK) || ply:KeyPressed(IN_ATTACK2) || ply:GetMoveType() ~= MOVETYPE_NOCLIP && ply:KeyPressed(IN_JUMP)) then
		if ply.RespawnTime == nil then
			ply:Spawn()
		elseif ply.RespawnTime < CurTime() then
			ply:Spawn()
		end
	end
end

function GM:PlayerDeath(ply, inflictor, attacker)
	if IsValid(attacker) && attacker:IsVehicle() && IsValid(attacker:GetDriver()) then attacker = attacker:GetDriver() end
	if !IsValid(inflictor) && IsValid(attacker) then inflictor = attacker end

	if IsValid(inflictor) && inflictor == attacker && (inflictor:IsPlayer() || inflictor:IsNPC()) then
		inflictor = inflictor:GetActiveWeapon()
		if !IsValid(inflictor) then inflictor = attacker end
	end

	player_manager.RunClass(ply, "Death", inflictor, attacker)
end

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	local survived = CurTime() - ply.SurvivalTime

	local stolenbounty
	if tonumber(ply.Bounty) >= 5 then
		if ply ~= attacker and attacker:IsPlayer() and attacker:IsValid() and attacker.UnlockedPerks["bountyhunter"] then
			stolenbounty = math.ceil(ply.Bounty * 0.5)
			attacker:SystemMessage("You stole "..stolenbounty.." bounty from "..ply:Nick().."!")
			attacker.Bounty = attacker.Bounty + stolenbounty

			ply.Bounty = ply.Bounty - stolenbounty
		end

		local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
		local bountyloss = ply.Bounty - cashloss
		if self:GetDebug() >= DEBUGGING_NORMAL then
			print(ply:Nick().." has died with "..ply.Bounty.." bounty, dropped money worth of "..math.floor(cashloss).." "..GAMEMODE.Config["Currency"].."s and survived for "..math.floor(survived).."s")
		end

		local ent = ents.Create("ate_cash")
		ent:SetPos(ply:GetPos() + Vector(0, 0, 10))
		ent:SetAngles(Angle(0,0,0))
		ent:SetNWInt("CashAmount", math.floor(cashloss))
		ent:Spawn()
		ent:Activate()

		ply:SystemMessage("You died and dropped your bounty cash worth of "..math.floor(cashloss).." "..GAMEMODE.Config["Currency"].."s! The remaining "..math.ceil(bountyloss).." "..GAMEMODE.Config["Currency"].."s is lost forever!"..(stolenbounty and " Your bounty of "..stolenbounty.." was stolen by the killer." or ""), Color(255,205,205), true)
		if ply:GetInfoNum("tea_cl_nobountytipmessage", 0) < 1 then
			ply:SystemMessage("Remember to cash in your bounties regularly, this specifically means if you have high bounty!", Color(255,205,205), true)
		end
	else
		print(ply:Nick().." has died with "..ply.Bounty.." bounty and survived for "..math.floor(survived).."s")
	end

	if !attacker:IsPlayer() then
		MsgN("[Death Log] "..ply:Nick().." was killed by "..attacker:GetClass())
	elseif attacker != ply then
		MsgN("[Death Log] "..ply:Nick().." was killed by "..attacker:Nick().." using "..attacker:GetActiveWeapon():GetClass())
	end

	ply.Bounty = 0
	ply:SetNWInt("PlyBounty", ply.Bounty)

	ply:Flashlight(false)
	ply:Freeze(false)

	if ply:GetObserverMode() == OBS_MODE_NONE then
		ply:CreateRagdoll()
	end

	--ply:SendLua("DeathSC()")
	timer.Destroy("IsSleeping_"..ply:EntIndex())
	ply:AddDeaths(1)
	ply.playerdeaths = ply.playerdeaths + 1

	ply.BestSurvivalTime = math.floor(math.max(ply.BestSurvivalTime, survived))
	ply.SurvivalTime = CurTime()
	timer.Simple(0, function()
		self:NetUpdateStatistics(ply)
	end)
/* 
	if attacker:IsPlayer() and (ply:Team() == attacker:Team()) and attacker != ply and not (ply:Team() == TEAM_LONER or attacker:Team() == TEAM_LONER) then
		attacker:AddFrags(-1)
		attacker.XP = attacker.XP - 500
		if tonumber(attacker.Money) <= 1000 then
			attacker:SystemMessage("You killed your teammate! -500XP and -"..attacker.Money.." "..GAMEMODE.Config["Currency"].."s penalty!", Color(255,205,205), true)
			attacker.Money = 0
		else
			attacker:SystemMessage("You killed your teammate! -500XP and -1000 "..GAMEMODE.Config["Currency"].."s penalty!", Color(255,205,205), true)
			attacker.Money = attacker.Money - 1000
		end
		self:FullyUpdatePlayer(attacker)
		return false

	else*/if attacker:IsPlayer() and attacker != ply then
		attacker:AddFrags(1) 
		attacker.playerskilled = attacker.playerskilled + 1
		attacker.LifePlayerKills = attacker.LifePlayerKills + 1
		self:SendPlayerSurvivalStats(attacker)

		local lvl = math.min(60, ply.Level)
		timer.Simple(1, function() attacker:GainMasteryXP(math.Rand(11 + (0.15 * lvl), 15 + (0.18 * lvl)), "PvP") end)
		self:NetUpdateStatistics(attacker)
	elseif attacker.IsZombie and (attacker:IsNPC() or attacker:IsNextBot()) then
		local boss = attacker.BossMonster
		if self:GetInfectionLevel() > 0 then
			self:SetInfectionLevel(math.max(0, self:GetInfectionLevel() - (0.24 / (1 + ((player.GetCount() - 1) * (5 / 9))) * (boss and 0.4 or 1))))
		end

		if self.PlayerLoseXPOnDeath and tonumber(ply.XP) > 0 and !ply:IsNewbie() then
			local xploss = math.ceil(math.min(250, ply.XP * (boss and 0.004 or 0.01)))
			ply.XP = ply.XP - xploss
			ply:SystemMessage("You died to a zombie, losing "..xploss.." experience points!", Color(255,205,205), true)
		end

	end

	local nodropweapons = {"gmod_tool", "weapon_physgun", "tea_fists", "tea_buildtool"}
	if ply:GetActiveWeapon() ~= NULL then
		local weapon_name = ply:GetActiveWeapon():GetClass()
		local nodrop = false

		for k,v in pairs(nodropweapons) do
			if weapon_name == v then nodrop = true break end
		end

		if !nodrop and self.ItemsList[weapon_name] and ply.Inventory[weapon_name] and !self.DropActiveWeaponOnDeath then
			self:SystemRemoveItem(ply, weapon_name)

			local ent = ents.Create("ate_droppeditem")
			ent:SetPos(ply:GetPos() + Vector(0, 0, 60))
			ent:SetAngles(Angle(0,0,0))
			ent:SetModel(GAMEMODE.ItemsList[weapon_name]["Model"])
			ent:SetNWString("ItemClass", weapon_name)
			ent:Spawn()
			ent:Activate()
			ent:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
			self:SendInventory(ply)
		end
	end

	local inflictor = dmginfo:GetInflictor()
	inflictor = inflictor:IsValid() and inflictor or attacker

	if attacker == ply then
		net.Start("PlayerKilledSelf")
		net.WriteEntity(ply)
		net.WriteEntity(attacker)
		net.WriteFloat(dmginfo:GetDamage())
		net.WriteUInt(dmginfo:GetDamageType(), 32)
		net.WriteString(ply.CauseOfDeath or "")
		net.WriteString(ply.DeathMessage or "")
		net.Broadcast()
		MsgAll(ply:Nick() .." suicided!\n")
	return end

	if attacker:IsPlayer() then
		net.Start("PlayerKilledByPlayer")
		net.WriteEntity(ply)
		net.WriteString(inflictor:GetClass())
		net.WriteEntity(attacker)
		net.WriteFloat(dmginfo:GetDamage())
		net.WriteUInt(dmginfo:GetDamageType(), 32)
		net.WriteString(ply.CauseOfDeath or "")
		net.WriteString(ply.DeathMessage or "")
		net.Broadcast()
		MsgAll(attacker:Nick().." killed "..ply:Nick().." using "..inflictor:GetClass().."\n")
	return end

	net.Start("PlayerKilled")
	net.WriteEntity(ply)
	net.WriteString(inflictor:GetClass())
	net.WriteString(attacker:GetClass())
	net.WriteFloat(dmginfo:GetDamage())
	net.WriteUInt(dmginfo:GetDamageType(), 32)
	net.WriteString(ply.CauseOfDeath or "")
	net.WriteString(ply.DeathMessage or "")
	net.Broadcast()

	MsgAll((attacker:IsValid() or attacker:IsWorld()) and ply:Nick().." was killed by "..attacker:GetClass().."\n" or ply:Nick().." was killed by the environment\n")
end

function GM:PostPlayerDeath(ply)
	ply.RespawnTime = CurTime() + self.RespawnTime
	net.Start("UpdateRespawnTimer")
	net.WriteFloat(CurTime() + self.RespawnTime)
	net.Send(ply)
	ply.CauseOfDeath = ""
	ply.DeathMessage = ""
end

function GM:PlayerDeathSound(ply)
	if not self.DeathSounds then return false end
	local tbl = self.Deathsounds[ply:GetModel()]
	if !tbl then return false end
	local sound = table.Random(tbl)
	ply:EmitSound(sound, 85)
	if self:GetDebug() >= DEBUGGING_ADVANCED then print(sound) end
	return true
end

function GM:OnDamagedByExplosion(ply, dmginfo)
	if ply:GetInfoNum("tea_cl_noearrings", 0) < 1 then
		ply:SetDSP(35)
	end
end

function GM:PlayerTraceAttack(ply, dmginfo, dir, trace)
	local attacker = dmginfo:GetAttacker()
	
	if !attacker:IsValid() or attacker == ply then return end
	
	util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)

	return self.BaseClass:PlayerTraceAttack(ply, dmginfo, dir, trace)
end

function FormatSteamID(SteamID)
	SteamID = SteamID or "STEAM_0:0:0"

	local str
	str = string.gsub(SteamID,"STEAM","")
	str = string.gsub(str,":","")
	str = string.gsub(str,"_","")
	
	return str
end

-- calculate damage with modifier of armor protection + defense skill
function GM:CalcPlayerDamage(ply, dmg)
	local newdmg = tonumber(dmg)
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end
		
	local defencebonus = 0.015 * ply.StatDefense
	local armorbonus = armorvalue
	newdmg = newdmg * (1 - (defencebonus + armorbonus))
	return math.max(0, newdmg)
end

-- calculate damage with modifier of armor environmental protection + defense skill
function GM:CalcEnvDamage(ply, dmg)
	local newdmg = tonumber(dmg)
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"]["env_reduction"]) / 100)
	end
		
	local defencebonus = 0.01 * ply.StatDefense
	local armorbonus = armorvalue
	newdmg = newdmg * (1 - (defencebonus + armorbonus))
	return math.max(0, newdmg)
end

-- calculate damage with modifier of armor protection only
function GM:CalcArmorDamage(ply, dmg)
	local newdmg = tonumber(dmg)
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = GAMEMODE.ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end

	newdmg = newdmg * (1 - armorvalue)
	return math.max(0, newdmg)
end

-- calculate damage with modifier of defense skill only
function GM:CalcDefenseDamage(ply, dmg)
	local newdmg = tonumber(dmg)
	newdmg = newdmg * ( 1 - (ply.StatDefense * 0.015))
	
	return math.max(0, newdmg)
end
