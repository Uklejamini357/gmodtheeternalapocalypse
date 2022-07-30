function GM:PlayerUse(ply, entity)
	if not entity then return end
	if not entity:IsValid() then return end
	return true
end

function Damagemods( target, dmginfo )
local attacker, inflictor, dmg = dmginfo:GetAttacker(), dmginfo:GetInflictor(), dmginfo:GetDamage()

	if target:GetClass() == "prop_physics" and target.maxhealth then
		target:SetHealth( target:Health() - dmginfo:GetDamage() )
		local ColorAmount =  ( ( target:Health() / target.maxhealth ) * 255 )
		target:SetColor( Color(ColorAmount, ColorAmount, ColorAmount, 255) )
		if target:Health() <= 0 then
			target:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
			target:Remove()
		end
	end

	local tea_server_voluntarypvp = GetConVar("tea_server_voluntarypvp")
	if target:IsPlayer() and attacker:IsPlayer() and target != attacker and !target:IsPvPForced() and target.Territory != team.GetName(attacker:Team()) and tea_server_voluntarypvp:GetInt() > 0 then

		if target:Alive() and attacker:Team() == 1 and attacker:GetNWBool("pvp") == false then
			SystemMessage(attacker, "Your PvP is not enabled!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false

		elseif target:Alive() and target:Team() == 1 and target:GetNWBool("pvp") == false then
			SystemMessage(attacker, "You can't attack loners unless they have PvP enabled!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false
		
		elseif target:Alive() and (target:Team() == attacker:Team()) and not (target:Team() == 1 or attacker:Team() == 1) then
			SystemMessage(attacker, "You can't attack your factionmates!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false

		end


		if timer.Exists("pvpnominge_"..target:UniqueID()) then timer.Destroy("pvpnominge_"..target:UniqueID()) end

		timer.Create( "pvpnominge_"..target:UniqueID(), 60, 1, function() -- this timer actually does nothing, its only purpose is to be checked if it exists
			if !target:IsValid() then return false end
			timer.Destroy("pvpnominge_"..target:UniqueID())
		end )



		if timer.Exists("pvpnominge_"..attacker:UniqueID()) then timer.Destroy("pvpnominge_"..attacker:UniqueID()) end

		timer.Create( "pvpnominge_"..attacker:UniqueID(), 60, 1, function() -- this timer actually does nothing, its only purpose is to be checked if it exists
			if !attacker:IsValid() then return false end
			timer.Destroy("pvpnominge_"..attacker:UniqueID())
		end )



	end

	local tea_server_debugging = GetConVar( "tea_server_debugging" )

	if target:IsPlayer() and target:IsValid() and tonumber(target.Prestige) >= 15 then
		dmginfo:ScaleDamage(0.95)
	end

	if dmginfo:GetDamageType() == DMG_CRUSH and target:IsPlayer() then
		dmginfo:SetDamage((dmginfo:GetDamage() * 0.01) + 1 )
	end

	if dmginfo:GetDamageType() == DMG_BLAST and (target.Type == "nextbot" or target:IsNPC()) then --AI NPCs and nextbots need to take more damage if they take explosive damage so it will be much better and explosives will be more useful
		dmginfo:ScaleDamage( 2.7 )
	end
/*
	if attacker:GetClass() == "trigger_hurt" then
		dmginfo:ScaleDamage( 0.5 )
	end
*/
	if dmginfo:GetDamageType() == DMG_BLAST and target:IsPlayer() then --Players need to take more damage from explosions since thanks to armor they can tank some big damage
		dmginfo:ScaleDamage( 1.55 )
	end

	if !target:IsPlayer() and attacker:IsPlayer() then
		dmginfo:ScaleDamage( 1 + (0.01 * attacker.StatDamage) )
		if target:IsPlayer() or target.Type == "nextbot" or target:IsNPC() then
			attacker:PrintMessage(HUD_PRINTCENTER, "Damage: "..dmginfo:GetDamage())
			if tea_server_debugging:GetInt() >= 1 then
				attacker:ConCommand("playgamesound buttons/button10.wav")
			end
		end
	end

	if target:IsPlayer() and target:Alive() and attacker != target and attacker:IsPlayer() and dmginfo:GetDamageType() == DMG_GENERIC then
		dmginfo:ScaleDamage( 1 + (0.01 * attacker.StatDamage) )
		attacker:PrintMessage(HUD_PRINTCENTER, "Damage: "..dmginfo:GetDamage().."")
		print(attacker:Nick().." has damaged "..target:Nick().." for "..dmginfo:GetDamage().." damage!")
		if tea_server_debugging:GetInt() >= 1 then
			attacker:ConCommand("playgamesound buttons/button10.wav")
		end
	elseif target:IsPlayer() and target:Alive() and attacker != target and attacker:IsPlayer() then
		attacker:PrintMessage(HUD_PRINTCENTER, "Damage: "..dmginfo:GetDamage().."")
		print(attacker:Nick().." has damaged "..target:Nick().." for "..dmginfo:GetDamage().." damage!")
		if tea_server_debugging:GetInt() >= 1 then
			attacker:ConCommand("playgamesound buttons/button10.wav")
		end
	end

	for _, ent in pairs (ents.FindByClass("trader")) do
		if target:IsPlayer() and ent:GetPos():Distance(target:GetPos()) < 120 then
			dmginfo:ScaleDamage( 0.9 )
		end
	end

	if tea_server_debugging:GetInt() >= 1 then
		if target:IsPlayer() and target:Alive() then
		target:PrintMessage(HUD_PRINTCENTER, "Damage taken: "..dmginfo:GetDamage().."")
		target:ConCommand("playgamesound buttons/button10.wav")
		print(""..target:Nick().." has taken "..dmginfo:GetDamage().." damage!")
		end
	end

end
hook.Add( "EntityTakeDamage", "damagemodshook", Damagemods )

function GM:ScalePlayerDamage( ply, group, dmginfo )
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
	local armortype = ItemsList[plyarmor]
	armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end

	local attacker = dmginfo:GetAttacker()

	if attacker:IsPlayer() then
	local defencebonus = dmginfo:GetDamage() * (0.015 * ply.StatDefense) --taken from damage
	local armorbonus = dmginfo:GetDamage() * armorvalue
	local attackbonus = dmginfo:GetDamage() * (0.01 * attacker.StatDamage) --added to damage

	local TheTotalDamage = dmginfo:GetDamage() + attackbonus - (defencebonus + armorbonus)



	if group == HITGROUP_HEAD then
		dmginfo:SetDamage( 2 * TheTotalDamage )
	elseif group == HITGROUP_CHEST then
		dmginfo:SetDamage( TheTotalDamage )
	elseif group == HITGROUP_STOMACH then
		dmginfo:SetDamage( 0.8 * TheTotalDamage )
	elseif group == HITGROUP_LEG then
		dmginfo:SetDamage( 0.4 * TheTotalDamage )
	else
		dmginfo:SetDamage( 0.5 * TheTotalDamage )
	end
	-- the other half of this logic is within the actual trader entity, should stop queerbaits from trader camping with pvp on
	if ply:IsPvPGuarded() or attacker:IsPvPGuarded() then
		dmginfo:SetDamage( 0 )
	end

	/*
	for _, ent in pairs (ents.FindByClass("trader")) do
		if attacker:IsPlayer() and (ent:GetPos():Distance(ply:GetPos()) < 120 or ent:GetPos():Distance(attacker:GetPos()) < 120) then
			dmginfo:SetDamage( 0 )
		end
	end
	*/

	return dmginfo
	end
end


function GM:PlayerDeathThink( ply )

	if ply.RespawnTime and ply.RespawnTime < CurTime() then 
		if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
			ply:Spawn()
		end
	end
	
end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	ply:ConCommand( "play theeternalapocalypse/gameover_music.wav" )
	
	local tea_server_respawntime = GetConVar( "tea_server_respawntime" )

	ply.RespawnTime = CurTime() + tea_server_respawntime:GetString()

	if tonumber(ply.Bounty) >= 5 then
	local cashloss = ply.Bounty * math.Rand(0.3, 0.4)
	local bountyloss = ply.Bounty - cashloss
	print( "".. ply:Nick() .." has died with "..ply.Bounty.." bounty, dropped money worth of "..math.floor(cashloss).." "..Config[ "Currency" ].."s and survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds! ".. tea_server_respawntime:GetString() .." seconds until able to respawn" )

	local EntDrop = ents.Create( "ate_cash" )
		EntDrop:SetPos( ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles( Angle( 0, 0, 0 ) )
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()

	SystemMessage(ply, "You died and dropped your bounty cash worth of "..math.floor(cashloss).." "..Config[ "Currency" ].."s! The remaining "..math.ceil(bountyloss).." "..Config[ "Currency" ].."s is lost forever! Always remember to cash in your bounty at traders, especially when having high bounty.", Color(255,205,205,255), true)
	else
	print( "".. ply:Nick() .." has died with "..ply.Bounty.." bounty and survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds! ".. tea_server_respawntime:GetString() .." seconds until able to respawn" )
	end

	SendChat(ply, "You survived for "..math.floor(CurTime() - ply.SurvivalTime).." seconds before getting killed")
	ply.Bounty = 0
	ply:SetNWInt( "PlyBounty", ply.Bounty )

--	ply.Autorespawntime = CurTime() + 20

	ply:Flashlight( false )
	ply:Freeze( false )

	ply:CreateRagdoll()

	ply:AddDeaths( 1 )

/*	if attacker:IsPlayer() and (ply:Team() == attacker:Team()) and attacker != ply and not (ply:Team() == 1 or attacker:Team() == 1) then
		attacker:AddFrags( -1 )
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
		attacker:AddFrags( 1 ) 


	end

	if ply:GetActiveWeapon() == NULL then return end --you don't need to worry about it, you still drop the weapon you held from your inventory when you die
	if (ply:GetActiveWeapon():GetClass() != "gmod_tool" and ply:GetActiveWeapon():GetClass() != "weapon_physgun" and ply:GetActiveWeapon():GetClass() != "ate_fists" and ply:GetActiveWeapon():GetClass() != "ate_buildtool") then
		local weapon_name = ply:GetActiveWeapon():GetClass()
		
		if ItemsList[weapon_name] and ply.Inventory[weapon_name] then

			SystemRemoveItem( ply, weapon_name )

			local EntDrop = ents.Create( "ate_droppeditem" )
			EntDrop:SetPos( ply:GetPos() + Vector(0, 0, 60) )
			EntDrop:SetAngles( Angle( 0, 0, 0 ) )
			EntDrop:SetModel(ItemsList[weapon_name]["Model"])
			EntDrop:SetNWString("ItemClass", weapon_name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
			SendInventory( ply )
		end
	end	
end
	
function GM:PlayerTraceAttack( ply, dmginfo, dir, trace )

	local attacker = dmginfo:GetAttacker()
	
	if !attacker:IsValid() or attacker == ply then
		return
	end
	
	util.Decal( "Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )

	return self.BaseClass:PlayerTraceAttack( ply, dmginfo, dir, trace )
end

function FormatSteamID( SteamID )

	local SteamID = SteamID, "STEAM_0:0:0"

	str = string.gsub( SteamID,"STEAM","" )
	str = string.gsub( str,":","" )
	str = string.gsub( str,"_","" )
	
	return str
	
end