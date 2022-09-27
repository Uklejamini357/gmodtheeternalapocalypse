function GM:PlayerUse(ply, entity)
	if not entity then return end
	if not entity:IsValid() then return end
	return true
end

function Damagemods(target, dmginfo)
	local attacker, inflictor, dmg = dmginfo:GetAttacker(), dmginfo:GetInflictor(), dmginfo:GetDamage()

	--i think that one's broken
	if target:GetClass() == "prop_physics" and target.maxhealth then
		target:SetHealth(target:Health() - dmg)
		local ColorAmount =  ((target:Health() / target.maxhealth) * 255)
		target:SetColor(Color(ColorAmount, ColorAmount, ColorAmount, 255))
		if target:Health() <= 0 then
			target:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
			target:EmitSound("physics/metal/metal_box_break2.wav", 80, 100)
			target:Remove()
		end
	end

	local tea_server_voluntarypvp = GetConVar("tea_server_voluntarypvp"):GetInt()
	if target:IsPlayer() and attacker:IsPlayer() and target != attacker and !target:IsPvPForced() and target.Territory != team.GetName(attacker:Team()) then
		 
		if target:Alive() and attacker:IsPlayer() and target:IsPlayer() and (target:HasGodMode() or target.SpawnProtected) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:UniqueID()) then
				SystemMessage(attacker, "This target is invulnerable!", Color(255,205,205,255), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:UniqueID(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
		return false end

		if target:Alive() and tea_server_voluntarypvp <= -1 then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:UniqueID()) then
				SystemMessage(attacker, "PvP is entirely disabled!", Color(255,205,205,255), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:UniqueID(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif target:Alive() and attacker:Team() == 1 and attacker:GetNWBool("pvp") == false and tea_server_voluntarypvp >= 1 then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:UniqueID()) then
				SystemMessage(attacker, "Your PvP is not enabled!", Color(255,205,205,255), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:UniqueID(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif target:Alive() and target:Team() == 1 and target:GetNWBool("pvp") == false and tea_server_voluntarypvp >= 1 then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:UniqueID()) then
				SystemMessage(attacker, "You can't attack loners unless they have PvP enabled!", Color(255,205,205,255), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:UniqueID(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		elseif target:Alive() and (target:Team() == attacker:Team()) and not (target:Team() == 1 or attacker:Team() == 1) then
			if !timer.Exists("NoPvPMsgAntiSpamTimer"..attacker:UniqueID()) then
				SystemMessage(attacker, "You can't attack your factionmates!", Color(255,205,205,255), true)
				timer.Create("NoPvPMsgAntiSpamTimer"..attacker:UniqueID(), 0.5, 1, function() end)
			end
			dmginfo:SetDamage(0)
			return false
		end




		if timer.Exists("pvpnominge_"..target:UniqueID()) then timer.Destroy("pvpnominge_"..target:UniqueID()) end
		timer.Create("pvpnominge_"..target:UniqueID(), 60, 1, function() -- this timer actually does nothing, its only purpose is to be checked if it exists for target
			if !target:IsValid() then return false end
			timer.Destroy("pvpnominge_"..target:UniqueID())
		end)

		if timer.Exists("pvpnominge_"..attacker:UniqueID()) then timer.Destroy("pvpnominge_"..attacker:UniqueID()) end
		timer.Create("pvpnominge_"..attacker:UniqueID(), 60, 1, function() -- same as above but for attacker
			if !attacker:IsValid() then return false end
			timer.Destroy("pvpnominge_"..attacker:UniqueID())
		end)
	end

	local tea_server_debugging = GetConVar("tea_server_debugging")
	if target:IsPlayer() and target.SpawnProtected then
		dmginfo:SetDamage(0)
		return false
	end

	if !attacker:IsValid() then return end
	if target:GetClass() == "trader" then return end

	if dmginfo:GetDamageType() == DMG_CRUSH and target:IsPlayer() and attacker:GetClass() == "obj_bigrock" then
		dmginfo:SetDamage(1 + (dmginfo:GetDamage() * 0.01))
	elseif dmginfo:GetDamageType() == DMG_CRUSH and target:IsPlayer() then
		dmginfo:ScaleDamage(0.5)
	end

	if target:IsPlayer() and target:IsValid() and tonumber(target.Prestige) >= 8 then
		dmginfo:ScaleDamage(0.95)
	end

	if attacker:GetClass() != "trigger_hurt" and dmginfo:GetDamageType() == DMG_BLAST and (target.Type == "nextbot" or target:IsNPC()) then --AI NPCs and nextbots need to take more damage if they take explosive damage so it will be much better and explosives will be more useful
		dmginfo:ScaleDamage(2.7)
	elseif attacker:GetClass() != "trigger_hurt" and dmginfo:GetDamageType() == DMG_BLAST and target:IsPlayer() then --Players need to take more damage from explosions since thanks to armor they can tank some big damage
		dmginfo:ScaleDamage(1.55)
	end

	if !target:IsPlayer() and attacker:IsPlayer() then
		if dmginfo:GetDamageType() == DMG_GENERIC then
			dmginfo:ScaleDamage(1 + (0.01 * attacker.StatDamage) + (0.005 * math.Clamp(attacker.MasteryMeleeLevel, 0, 10)))
		else
			dmginfo:ScaleDamage(1 + (0.01 * attacker.StatDamage))
		end
		if target.Type == "nextbot" or target:IsNPC() then
			if dmginfo:GetDamageType() == DMG_GENERIC then
				attacker.MeleeDamageDealt = attacker.MeleeDamageDealt + math.Clamp(0.035 * dmginfo:GetDamage(), 0, 0.035 * target:Health())
				timer.Create("MeleeMasteryGain"..attacker:UniqueID(), 5, 1, function() if attacker:IsValid() then attacker:GainMasteryXP(attacker.MeleeDamageDealt, "Melee") attacker.MeleeDamageDealt = 0 end end)
			end
			attacker:PrintTranslatedMessage(HUD_PRINTCENTER, "DmgDealt", dmginfo:GetDamage())
			if attacker:GetInfoNum("tea_cl_hitsounds", 1) >= 1 and attacker:GetInfoNum("tea_cl_hitsounds_volnpc", 0.225) > 0 and !timer.Exists("HitSFX_"..attacker:UniqueID()) then
				attacker:ConCommand("playvol theeternalapocalypse/hitsound.wav "..attacker:GetInfoNum("tea_cl_hitsounds_volnpc", 0.225))
				timer.Create("HitSFX_"..attacker:UniqueID(), 0.15, 1, function() end)
			end
		end
	end

	if target:IsPlayer() and target:Alive() and attacker != target and attacker:IsPlayer() and dmginfo:GetDamageType() == DMG_GENERIC and (!target:IsPvPGuarded() and !attacker:IsPvPGuarded()) then
		dmginfo:ScaleDamage(1 + (0.01 * attacker.StatDamage) + (0.005 * math.Clamp(attacker.MasteryMeleeLevel, 0, 10)))
		attacker:PrintTranslatedMessage(HUD_PRINTCENTER, "DmgDealt", dmginfo:GetDamage())
		attacker.MeleeDamageDealt = attacker.MeleeDamageDealt + math.Clamp(0.05 * dmginfo:GetDamage(), 0, 0.05 * target:Health())
		timer.Create("MeleeMasteryGain"..attacker:UniqueID(), 5, 1, function() if attacker:IsValid() then attacker:GainMasteryXP(attacker.MeleeDamageDealt, "Melee") attacker.MeleeDamageDealt = 0 end end)
		if attacker:GetInfoNum("tea_cl_hitsounds", 1) >= 1 and attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3) > 0 and !timer.Exists("HitSFX_"..attacker:UniqueID()) then
			attacker:ConCommand("playvol theeternalapocalypse/hitsound.wav "..attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3))
			timer.Create("HitSFX_"..attacker:UniqueID(), 0.15, 1, function() end)
		end
		print(attacker:Nick().." has damaged "..target:Nick().." for "..dmginfo:GetDamage().." damage!")
	elseif target:IsPlayer() and target:Alive() and attacker != target and attacker:IsPlayer() and (!target:IsPvPGuarded() and !attacker:IsPvPGuarded()) then
		attacker:PrintTranslatedMessage(HUD_PRINTCENTER, "DmgDealt", dmginfo:GetDamage())
		if attacker:GetInfoNum("tea_cl_hitsounds", 1) >= 1 and attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3) > 0 and !timer.Exists("HitSFX_"..attacker:UniqueID()) then
			attacker:ConCommand("playvol theeternalapocalypse/hitsound.wav "..attacker:GetInfoNum("tea_cl_hitsounds_vol", 0.3))
			timer.Create("HitSFX_"..attacker:UniqueID(), 0.15, 1, function() end)
		end
		if tea_server_debugging:GetInt() >= 2 then print(attacker:Nick().." has damaged "..target:Nick().." for "..dmginfo:GetDamage().." damage!") end
	end
	
	for _, ent in pairs(ents.FindByClass("trader")) do
		if target:IsPlayer() and ent:GetPos():Distance(target:GetPos()) < 120 then
			dmginfo:ScaleDamage(0.9)
		end
	end

	if tea_server_debugging:GetInt() >= 2 then
		if target:IsPlayer() and target:Alive() and !target:IsPvPGuarded() and (!target.SpawnProtected and !target:HasGodMode()) then
			target:PrintTranslatedMessage(HUD_PRINTCENTER, "DmgTaken", dmginfo:GetDamage())
			print(target:Nick().." has taken "..dmginfo:GetDamage().." damage!")
		end
	end
end
hook.Add("EntityTakeDamage", "damagemodshook", Damagemods)

function GM:ScalePlayerDamage(ply, group, dmginfo)
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
		local armortype = ItemsList[plyarmor]
		armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end

	local attacker = dmginfo:GetAttacker()

	if attacker:IsPlayer() then
		local defencebonus = 0.015 * ply.StatDefense --taken from damage
		local armorbonus = armorvalue
		local attackbonus = (0.01 * attacker.StatDamage) + (0.005 * math.Clamp(attacker.MasteryPvPLevel, 0, 10)) --added to damage
		local TheTotalDamage = (dmginfo:GetDamage() * (1 + attackbonus)) * (1 - (defencebonus + armorbonus))
				
		if group == HITGROUP_HEAD then dmginfo:SetDamage(2 * TheTotalDamage)
		elseif group == HITGROUP_STOMACH then dmginfo:SetDamage(0.8 * TheTotalDamage)
		elseif group == HITGROUP_LEG then dmginfo:SetDamage(0.4 * TheTotalDamage)
		else dmginfo:SetDamage(TheTotalDamage) end

		-- the other half of this logic is within the actual trader entity, should stop queerbaits from trader camping with pvp on
		if ply:IsPvPGuarded() or attacker:IsPvPGuarded() then
			dmginfo:SetDamage(0)
		end

	/*
	for _, ent in pairs (ents.FindByClass("trader")) do
		if attacker:IsPlayer() and (ent:GetPos():Distance(ply:GetPos()) < 120 or ent:GetPos():Distance(attacker:GetPos()) < 120) then
			dmginfo:SetDamage(0)
		end
	end
	*/

		return dmginfo
	end
end

/*
net.Receive("Respawn", function(length, ply)
	ply:Spawn()
end)
*/

function GM:PlayerDeathThink(ply)
	if (ply:KeyPressed(IN_ATTACK) || ply:KeyPressed(IN_ATTACK2) || ply:KeyPressed(IN_JUMP)) then
		if ply.RespawnTime == nil then
			ply:Spawn()
		elseif ply.RespawnTime < CurTime() then
			ply:Spawn()
		end
	end
end

function GM:PlayerDeath(ply, inflictor, attacker)
	if IsValid(attacker) && attacker:IsVehicle() && IsValid(attacker:GetDriver()) then
		attacker = attacker:GetDriver()
	end

	if !IsValid(inflictor) && IsValid(attacker) then
		inflictor = attacker
	end

	if IsValid(inflictor) && inflictor == attacker && (inflictor:IsPlayer() || inflictor:IsNPC()) then
		inflictor = inflictor:GetActiveWeapon()
		if !IsValid(inflictor) then inflictor = attacker end
	end

	player_manager.RunClass(ply, "Death", inflictor, attacker)

	if attacker == ply then
		net.Start("PlayerKilledSelf")
		net.WriteEntity(ply)
		net.Broadcast()
		MsgAll(ply:Nick() .. " suicided!\n")
	return end

	if attacker:IsPlayer() then
		net.Start("PlayerKilledByPlayer")
		net.WriteEntity(ply)
		net.WriteString(inflictor:GetClass())
		net.WriteEntity(attacker)
		net.Broadcast()
		MsgAll(attacker:Nick().." killed "..ply:Nick().." using "..inflictor:GetClass().."\n")
	return end

	net.Start("PlayerKilled")
	net.WriteEntity(ply)
	net.WriteString(inflictor:GetClass())
	net.WriteString(attacker:GetClass())
	net.Broadcast()

	MsgAll(ply:Nick().." was killed by "..attacker:GetClass().."\n")
end

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	local respawn = GetConVar("tea_server_respawntime"):GetFloat()

	if ply.IsAlive then 
		ply.RespawnTime = CurTime() + respawn
		net.Start("UpdateRespawnTimer")
		net.WriteFloat(CurTime() + respawn)
		net.Send(ply)
	end

	if tonumber(ply.Bounty) >= 5 then
		local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
		local bountyloss = ply.Bounty - cashloss
		print(ply:Nick().." has died with "..ply.Bounty.." bounty, dropped money worth of "..math.floor(cashloss).." "..Config["Currency"].."s and survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds! "..respawn.." seconds until able to respawn")

		local EntDrop = ents.Create("ate_cash")
		EntDrop:SetPos(ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles(Angle(0,0,0))
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()
		
		SystemMessage(ply, "You died and dropped your bounty cash worth of "..math.floor(cashloss).." "..Config["Currency"].."s! The remaining "..math.ceil(bountyloss).." "..Config["Currency"].."s is lost forever! Always remember to cash in your bounty at traders, especially when having high bounty.", Color(255,205,205,255), true)
	else
		print(ply:Nick().." has died with "..ply.Bounty.." bounty and survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds! "..respawn.." seconds until able to respawn")
	end

	if ply.IsAlive then --to prevent player from spamming the same thing in chat when dying while dead
		if math.floor(ply.BestSurvivalTime) < (CurTime() - ply.SurvivalTime) then
			SystemMessage(ply, "Survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds (Previous Best: "..math.floor(ply.BestSurvivalTime).." seconds)", Color(220,180,220,255), false)
			ply.BestSurvivalTime = math.floor(CurTime() - ply.SurvivalTime)
		else
			SystemMessage(ply, "Survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds", Color(220,180,220,255), false)
		end
	end

/*	for k,v in pairs(player.GetAll()) do
		if !attacker:IsPlayer() then
			v:PrintMessage(2, "[Death Log] "..ply:Nick().." was killed by "..attacker:GetClass())
		else
			if attacker != ply then
				v:PrintMessage(2, "[Death Log] "..ply:Nick().." was killed by "..attacker:Nick().." using "..attacker:GetActiveWeapon():GetClass())
			end
		end
	end*/ --not included because i think it would be too obvious

	ply.Bounty = 0
	ply.IsAlive = false
	ply.SurvivalTime = CurTime() --idk why, it's already included in PlayerSpawn
	ply:SetNWInt("PlyBounty", ply.Bounty)

	ply:Flashlight(false)
	ply:Freeze(false)

	ply:CreateRagdoll()

	--ply:SendLua("DeathSC()")

	timer.Destroy("IsSleeping_"..ply:UniqueID())
	ply:AddDeaths(1)
	ply.playerdeaths = ply.playerdeaths + 1
	TEANetUpdateStatistics(ply)

/*	if attacker:IsPlayer() and (ply:Team() == attacker:Team()) and attacker != ply and not (ply:Team() == 1 or attacker:Team() == 1) then
		attacker:AddFrags(-1)
		attacker.XP = attacker.XP - 500
		if tonumber(attacker.Money) <= 1000 then
			SystemMessage(attacker, "You killed your teammate! -500XP and -"..attacker.Money.." "..Config[ "Currency" ].."s penalty!", Color(255,205,205,255), true)
			attacker.Money = 0
		else
			SystemMessage(attacker, "You killed your teammate! -500XP and -1000 "..Config[ "Currency" ].."s penalty!", Color(255,205,205,255), true)
			attacker.Money = attacker.Money - 1000
		end
		FullyUpdatePlayer(attacker)
		return false

	else*/if attacker:IsPlayer() and attacker != ply then
		attacker:AddFrags(1) 
		attacker.playerskilled = attacker.playerskilled + 1
		timer.Simple(1, function() attacker:GainMasteryXP(math.Rand(2 + (0.11 * ply.Level), 3 + (0.13 * ply.Level)), "PvP") end)
		TEANetUpdateStatistics(attacker)
	end

	if ply:GetActiveWeapon() == NULL then return end --you don't need to worry about it, you still drop the weapon you held from your inventory when you die
	if (ply:GetActiveWeapon():GetClass() != "gmod_tool" and ply:GetActiveWeapon():GetClass() != "weapon_physgun" and ply:GetActiveWeapon():GetClass() != "ate_fists" and ply:GetActiveWeapon():GetClass() != "ate_buildtool") then
		local weapon_name = ply:GetActiveWeapon():GetClass()
		if ItemsList[weapon_name] and ply.Inventory[weapon_name] then
			SystemRemoveItem(ply, weapon_name)

			local EntDrop = ents.Create("ate_droppeditem")
			EntDrop:SetPos(ply:GetPos() + Vector(0, 0, 60))
			EntDrop:SetAngles(Angle(0,0,0))
			EntDrop:SetModel(ItemsList[weapon_name]["Model"])
			EntDrop:SetNWString("ItemClass", weapon_name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
			SendInventory(ply)
		end
	end	
end

function GM:PostPlayerDeath(ply)
	ply:SendLua([[if GetConVar("tea_cl_deathsfx"):GetInt() >= 1 then RunConsoleCommand("play", GetConVar("tea_cl_deathsound"):GetString()) end]])
end

function GM:PlayerDeathSound(ply)

	return false
end
	
function GM:PlayerTraceAttack(ply, dmginfo, dir, trace)

	local attacker = dmginfo:GetAttacker()
	
	if !attacker:IsValid() or attacker == ply then return end
	
	util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)

	return self.BaseClass:PlayerTraceAttack(ply, dmginfo, dir, trace)
end

function FormatSteamID(SteamID)
	local SteamID = SteamID, "STEAM_0:0:0"

	str = string.gsub(SteamID,"STEAM","")
	str = string.gsub(str,":","")
	str = string.gsub(str,"_","")
	
	return str
end
