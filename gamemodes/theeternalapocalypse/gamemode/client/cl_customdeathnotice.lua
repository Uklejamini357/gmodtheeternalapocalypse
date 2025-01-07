-- this is mostly c+p from sandbox and still needs to be finished (in a different way)

local tea_cl_deathnoticetime = CreateClientConVar("tea_cl_deathnoticetime", "7", true, false, "Amount of time to show death notice", 4, 12)

-- These are our kill icons
local Color_Icon = Color(255, 80, 0, 255)
local NPC_Color = Color(250, 50, 50, 255)


local Deaths = {}
local RDtext = {
	"was trashed",
	"was ripped apart",
	"was slaughtered",
	"was chewed up and spat out",
	"was wrecked",
	"was stomped on",
	"was turned inside-out",
	"was ruined",
	"was violated",
	"was vanquished",
	"was butchered",
	"was chopped up",
	"was sliced and diced",
	"was dominated",
	"was wiped out of the reality",
	"was put off their misery",
	"was murdered"
}

local RDStext = {
	"has died.",
	"suicided.",
	"has taken their life off the reality.",
	"could not stand the living anymore.",
	"has put to end their misery.",
	"was unable to survive for the rest of the days.",
}

local function CheckAttacker(attacker)
	if GAMEMODE.Config["ZombieClasses"][attacker] then attacker = GAMEMODE.Config["ZombieClasses"][attacker]["Name"]
	elseif GAMEMODE.Config["BossClasses"][attacker] then attacker = GAMEMODE.Config["BossClasses"][attacker]["Name"]
	elseif attacker == "npc_zombie" then attacker = "Zombie"
	elseif attacker == "npc_fastzombie" then attacker = "Fast Zombie"
	elseif attacker == "npc_poisonzombie" then attacker = "Poison Zombie"
	elseif attacker == "npc_headcrab" then attacker = "Headcrab"
	elseif attacker == "npc_headcrab_fast" then attacker = "Fast Headcrab"
	elseif attacker == "npc_headcrab_poison" or attacker == "npc_headcrab_black" then attacker = "Poison Headcrab"
	elseif attacker == "trigger_hurt" or attacker == "point_hurt" then attacker = "Unknown"
	elseif attacker == "prop_physics" then attacker = "Physics Prop"
	elseif attacker == "func_pushable" then attacker = "Object"
	elseif attacker == "worldspawn" then attacker = "World"
	elseif attacker == "env_explosion" then attacker = "Explosion"
	elseif attacker == "env_fire" or attacker == "entityflame" then attacker = "Fire"
	elseif attacker == "npc_handgrenade" then attacker = "Grenade"
	elseif attacker == "airdrop_cache" then attacker = "Airdrop Cache"
	elseif attacker == "gmod_gamerules" then attacker = "Gmod Gamerules"
	elseif attacker == "stormfox_mapice" then attacker = "Ice" -- it's just there, for a reason
	else attacker = Format("#%s", attacker)
	end
	return attacker
end

local function CheckLocalPlayerDeath(victim, attacker, dmg, dmgtype, msgoverride)
	local suicidetable = {"Suicide"}

	local killedbyplayer = {"Killed by %s"}--[[{"You were killed by %s.",
		"%s has killed You.",
		"You were dominated by %s."}
]]	
	local killedbyboss = {"Killed by boss %s"}--[[{"You were killed by %s.",
		"You were butchered by %s."}]]
	
	local killedbyzombie = {"Killed by %s"}--[[{"You were violated by %s.",
		"%s has ripped you apart into pieces.",
		"You were sliced and diced by the %s"}]]

	local killedbynpc = {"Killed by NPC %s"}--[[{"You were killed by a NPC. (%s)"}]]
	
	local killedbydoor = {"KILLED BY DOOR WTF"}--[[{""}]]
	
	local killedbyenv = {"Environment"}--[[{"Better be careful next time.",
		"Environment is harsh these days, be careful!"}]]

	local killedbyother = {"Unknown cause"}--[[{"You were killed by an unknown cause."}]]

	if victim == LocalPlayer() then
		gamemode.Call("LocalPlayerDeath", attacker)

		if msgoverride != "" then
			GAMEMODE.DeathMessage = msgoverride
			return
		end

		if attacker == LocalPlayer() then
			GAMEMODE.DeathMessage = table.Random(suicidetable)
		elseif IsValid(attacker) and attacker:IsPlayer() then
			GAMEMODE.DeathMessage = Format(table.Random(killedbyplayer), attacker:Name())
		elseif GAMEMODE.Config["ZombieClasses"][attacker] then
			GAMEMODE.DeathMessage = Format(table.Random(killedbyzombie), CheckAttacker(attacker))
		elseif GAMEMODE.Config["BossClasses"][attacker] then
			GAMEMODE.DeathMessage = Format(table.Random(killedbyboss), CheckAttacker(attacker))
		elseif string.sub(attacker, 1, 4) == "npc_" then
			GAMEMODE.DeathMessage = Format(table.Random(killedbynpc), CheckAttacker(attacker))
		elseif attacker == "func_door" or attacker == "func_door_rotating" then
			GAMEMODE.DeathMessage = table.Random(killedbydoor)
		elseif attacker == "trigger_hurt" or attacker == "point_hurt" or attacker == "entityflame" or attacker == "env_fire" then
			GAMEMODE.DeathMessage = table.Random(killedbyenv)
		elseif attacker == "worldspawn" and dmgtype == DMG_FALL then
			GAMEMODE.DeathMessage = "Fall damage ("..math.floor(dmg).." damage taken)"
		else
			GAMEMODE.DeathMessage = table.Random(killedbyother)
		end
	end
end


local function PlayerIDOrNameToString( var )
	if type( var ) == "string" then
		if ( var == "" ) then return "" end
		return "#" .. var
	end
	
	local ply = Entity( var )
	
	if ( !IsValid( ply ) ) then return "NULL!" end
	
	return ply:Nick()
end


local function RecvPlayerKilledByPlayer()
	local victim		= net.ReadEntity()
	local inflictor		= net.ReadString()
	local attacker		= net.ReadEntity()
	local dmg			= net.ReadFloat()
	local dmgtype		= net.ReadUInt(32)
	local msgoverride	= net.ReadString()
	local deathmsg		= net.ReadString()

	if ( !IsValid( attacker ) ) then return end
	if ( !IsValid( victim ) ) then return end

	CheckLocalPlayerDeath(victim, attacker, dmg, dmgtype, msgoverride)
	
	GAMEMODE:AddDeathNotice( attacker:Nick(), attacker:Team(), inflictor, victim:Nick(), victim:Team(), dmg, dmgtype, msgoverride, deathmsg )
end
net.Receive( "PlayerKilledByPlayer", RecvPlayerKilledByPlayer )

local function RecvPlayerKilledSelf()

	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()
	local dmg		= net.ReadFloat()
	local dmgtype	= net.ReadUInt(32)
	local msgoverride	= net.ReadString()
	local deathmsg		= net.ReadString()

	if ( !IsValid( victim ) ) then return end
	CheckLocalPlayerDeath(victim, attacker, dmg, dmgtype, msgoverride)
	GAMEMODE:AddDeathNotice( nil, 0, "suicide", victim:Nick(), victim:Team(), dmg, dmgtype, msgoverride, deathmsg )

end
net.Receive( "PlayerKilledSelf", RecvPlayerKilledSelf )

local function RecvPlayerKilled()

	local victim	= net.ReadEntity()
	if (!IsValid(victim)) then return end
	local inflictor	= net.ReadString()
	local attackertype	= net.ReadString()
	local dmg		= net.ReadFloat()
	local dmgtype	= net.ReadUInt(32)
	local msgoverride	= net.ReadString()
	local deathmsg		= net.ReadString()
	local attacker = CheckAttacker(attackertype)

	CheckLocalPlayerDeath(victim, attackertype, dmg, dmgtype, msgoverride)

	GAMEMODE:AddDeathNotice( attacker, -1, inflictor, victim:Nick(), victim:Team(), dmg, dmgtype, msgoverride, deathmsg )

end
net.Receive( "PlayerKilled", RecvPlayerKilled )

local function RecvPlayerKilledNPC()

	local victimtype = net.ReadString()
	local victim = CheckAttacker(victimtype)
	local inflictor	= net.ReadString()
	local attacker	= net.ReadEntity()
	local dmg		= net.ReadFloat()
	local dmgtype	= net.ReadUInt(32)
	local msgoverride	= net.ReadString()

	--
	-- For some reason the killer isn't known to us, so don't proceed.
	--
	if (!IsValid(attacker)) then return end
	
	GAMEMODE:AddDeathNotice( attacker:Nick(), attacker:Team(), inflictor, victim, -1, dmg, dmgtype, msgoverride )
	
	local bIsLocalPlayer = ( IsValid(attacker) && attacker == LocalPlayer() )
	
	local bIsEnemy = IsEnemyEntityName( victim )
	local bIsFriend = IsFriendEntityName( victim )
	
	if ( bIsLocalPlayer && bIsEnemy ) then
		achievements.IncBaddies()
	end
	
	if ( bIsLocalPlayer && bIsFriend ) then
		achievements.IncGoodies()
	end
	
	if ( bIsLocalPlayer && ( !bIsFriend && !bIsEnemy ) ) then
		achievements.IncBystander()
	end

end
net.Receive( "PlayerKilledNPC", RecvPlayerKilledNPC )

local function RecvNPCKilledNPC()

	local victimtype	= net.ReadString()
	local victim = CheckAttacker(victimtype)
	local inflictor	= net.ReadString()
	local attackertype	= net.ReadString()
	local dmg		= net.ReadFloat()
	local dmgtype	= net.ReadUInt(32)
	local msgoverride	= net.ReadString()
	local attacker = CheckAttacker(attackertype)

	GAMEMODE:AddDeathNotice( attacker, -1, inflictor, victim, -1, dmg, dmgtype, msgoverride )

end
net.Receive( "NPCKilledNPC", RecvNPCKilledNPC )


function GM:AddDeathNotice( Victim, team1, Inflictor, Attacker, team2, dmg, dmgtype, msgoverride, deathmsg )
	local Death = {}
	Death.victim	= Victim
	Death.attacker	= Attacker
	Death.inflictor	= Inflictor
	Death.damage	= dmg
	Death.dmgtype	= dmgtype
	Death.time		= RealTime()
	Death.dur		= tea_cl_deathnoticetime:GetFloat()
	Death.Message	= table.Random(RDtext)
	Death.SMessage	= table.Random(RDStext)
	Death.Time		= RealTime()

	Death.left		= Victim
	Death.right		= Attacker
	Death.icon		= Inflictor

	if dmgtype == DMG_BLAST then
		Death.Message = "was blasted into pieces"
	end

	if dmgtype == DMG_DROWN then
		Death.SMessage = "has drowned"
	end

	if dmgtype == DMG_FALL then
		Death.SMessage = table.Random({"thought he could fly", "fell off from a great height", "hit the ground too hard"})
		Death.left = nil
	end

	if deathmsg ~= "" then
		Death.left = nil
		Death.Message = deathmsg
		Death.SMessage = deathmsg
	end


	if team1 == -1 then Death.color1 = table.Copy(NPC_Color)
	else Death.color1 = table.Copy(team.GetColor(team1)) end
	
	if team2 == -1 then Death.color2 = table.Copy(NPC_Color)
	else Death.color2 = table.Copy( team.GetColor( team2 ) ) end

	if team1 == -1 then Death.pteam1 = ""
	else Death.pteam1 = " ["..team.GetName(team1).."]" end
	
	if team2 == -1 then Death.pteam2 = ""
	else Death.pteam2 = " ["..team.GetName(team2).."]" end
	
	if Death.left == Death.right then
		Death.left = nil
		Death.icon = "suicide"
	end
	
	table.insert( Deaths, Death )
end

local function DrawDeath(x, y, death, tea_cl_deathnoticetime)
	local w, h = 50, 50
	if (!w || !h) then return end
	
	local fadeout = ( death.time + tea_cl_deathnoticetime ) - RealTime()
	
	local alpha = math.Clamp( fadeout * 255, 0, 255 )
	death.color1.a = alpha
	death.color2.a = alpha

	local text
	local textsize

	surface.SetFont("ChatFont")
	-- Draw KILLER
	if death.right and not death.left then
		text = Format("Death: %s%s %s", death.right, death.pteam2, death.SMessage)
		textsize = surface.GetTextSize(text)
		draw.SimpleText(text, "ChatFont", x - (w / 2) + math.Clamp(350 + textsize - ((1.5 * textsize) * ((RealTime()) - death.Time)), 250, 350 + textsize), y, Color(223,45,45,alpha), TEXT_ALIGN_RIGHT)
	elseif (death.left) then
		text = Format("Death: %s%s %s by %s%s", death.right, death.pteam2, death.Message, death.left, death.pteam1)
		textsize = surface.GetTextSize(text)
		draw.SimpleText(text, "ChatFont", x - (w / 2) + math.Clamp(350 + textsize - ((1.5 * textsize) * ((RealTime()) - death.Time)), 250, 350 + textsize), y, Color(255,75,75,alpha), TEXT_ALIGN_RIGHT)
	end

	return (y + h * 0.70)
end


function GM:DrawDeathNotice(x, y)
	if GetConVar("cl_drawhud"):GetInt() < 1 then return end

	x = x * ScrW()
	y = y * ScrH()
	
	-- Draw
	for k, Death in pairs(Deaths) do

		if Death.time + Death.dur > RealTime() then
	
			if Death.lerp then
				x = x * 0.3 + Death.lerp.x * 0.7
				y = y * 0.3 + Death.lerp.y * 0.7
			end
			
			Death.lerp = Death.lerp or {}
			Death.lerp.x = x
			Death.lerp.y = y
		
			y = DrawDeath( x, y, Death, Death.dur )
		
		end
		
	end

	for k, Death in pairs(Deaths) do
		if Death.time + Death.dur > RealTime() then
			return
		end
	end
	
	Deaths = {}
end
