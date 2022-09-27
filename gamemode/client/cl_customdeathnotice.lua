-- this is mostly c+p from sandbox and still needs to be finished (in a different way)


local tea_cl_deathnoticetime = CreateClientConVar("tea_cl_deathnoticetime", "7", true, false, "Amount of time to show death notice", 4, 12)

-- These are our kill icons
local Color_Icon = Color(255, 80, 0, 255)
local NPC_Color = Color(250, 50, 50, 255)


local Deaths = {}
local RDtext = {
	"trashed",
	"ripped apart",
	"slaughtered",
	"chewed up and spat out",
	"wrecked",
	"stomped on",
	"turned inside-out",
	"ruined",
	"violated",
	"vanquished",
	"butchered",
	"chopped up",
	"sliced and diced",
	"dominated",
	"blasted",
	"wiped out of the reality",
	"die'ed",
	"no mercified",
	"destroyed",
	"put off their misery"
}

local RDStext = {
	"just died",
	"did suicide thing"
}

local function CheckAttacker(attacker)
	if attacker == "npc_ate_basic" then attacker = "Shambler Zombie"
	elseif attacker == "npc_ate_leaper" then attacker = "Leaper Zombie"
	elseif attacker == "npc_ate_tank" then attacker = "Tank Zombie"
	elseif attacker == "npc_ate_wraith" then attacker = "Wraith Zombie"
	elseif attacker == "npc_ate_lord" then attacker = "Zombie Lord"
	elseif attacker == "npc_ate_tormented_wraith" then attacker = "Tormented Wraith"
	elseif attacker == "npc_ate_superlord" then attacker = "Zombie Superlord"
	elseif attacker == "npc_ate_fleshpile" or attacker == "obj_fleshbomb" then attacker = "Fleshpile Zombie"
	elseif attacker == "npc_nextbot_boss_tyrant" or attacker == "obj_bigrock" then attacker = "The Tyrant"
	elseif attacker == "npc_zombie" then attacker = "HL2 Zombie"
	elseif attacker == "npc_fastzombie" then attacker = "HL2 Fast Zombie"
	elseif attacker == "npc_poisonzombie" then attacker = "HL2 Poison Zombie"
	elseif attacker == "trigger_hurt" then attacker = "Unknown"
	elseif attacker == "prop_physics" then attacker = "Physics Prop"
	elseif attacker == "func_pushable" then attacker = "Object"
	elseif attacker == "worldspawn" then attacker = "World"
	elseif attacker == "env_explosion" then attacker = "Explosion"
	elseif attacker == "env_fire" or attacker == "entityflame" then attacker = "Fire"
	elseif attacker == "npc_handgrenade" then attacker = "Grenade"
	elseif attacker == "airdrop_cache" then attacker = "Airdrop Cache"
	elseif attacker == "gmod_gamerules" then attacker = "Gmod Gamerules"
	elseif attacker == "stormfox_mapice" then attacker = "Ice"
	end
	return attacker
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
	local victim	= net.ReadEntity()
	local inflictor	= net.ReadString()
	local attacker	= net.ReadEntity()

	if ( !IsValid( attacker ) ) then return end
	if ( !IsValid( victim ) ) then return end
	
	GAMEMODE:AddDeathNotice( attacker:Nick(), attacker:Team(), inflictor, victim:Nick(), victim:Team() )
end
net.Receive( "PlayerKilledByPlayer", RecvPlayerKilledByPlayer )

local function RecvPlayerKilledSelf()

	local victim = net.ReadEntity()
	if ( !IsValid( victim ) ) then return end
	GAMEMODE:AddDeathNotice( nil, 0, "suicide", victim:Nick(), victim:Team() )

end
net.Receive( "PlayerKilledSelf", RecvPlayerKilledSelf )

local function RecvPlayerKilled()

	local victim	= net.ReadEntity()
	if (!IsValid(victim)) then return end
	local inflictor	= net.ReadString()
	local attackertype	= net.ReadString()
	local attacker = CheckAttacker(attackertype)

	GAMEMODE:AddDeathNotice( attacker, -1, inflictor, victim:Nick(), victim:Team() )

end
net.Receive( "PlayerKilled", RecvPlayerKilled )

local function RecvPlayerKilledNPC()

	local victimtype = net.ReadString()
	local victim = CheckAttacker(victimtype)
	local inflictor	= net.ReadString()
	local attacker	= net.ReadEntity()

	--
	-- For some reason the killer isn't known to us, so don't proceed.
	--
	if (!IsValid(attacker)) then return end
	
	GAMEMODE:AddDeathNotice( attacker:Nick(), attacker:Team(), inflictor, victim, -1 )
	
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
	local attacker = CheckAttacker(attackertype)

	GAMEMODE:AddDeathNotice( attacker, -1, inflictor, victim, -1 )

end
net.Receive( "NPCKilledNPC", RecvNPCKilledNPC )

--[[---------------------------------------------------------
	Name: gamemode:AddDeathNotice( Victim, Attacker, Weapon )
	Desc: Adds an death notice entry
-----------------------------------------------------------]]

function GM:AddDeathNotice( Victim, team1, Inflictor, Attacker, team2 )

	local Death = {}
	Death.victim	= Victim
	Death.attacker	= Attacker
	Death.time		= CurTime()
	Death.Message = table.Random(RDtext)
	Death.SMessage = table.Random(RDStext)
	Death.Time = CurTime()

	Death.left		= Victim
	Death.right		= Attacker
	Death.icon		= Inflictor

	if team1 == -1 then Death.color1 = table.Copy(NPC_Color)
	else Death.color1 = table.Copy(team.GetColor(team1)) end
	
	if team2 == -1 then Death.color2 = table.Copy(NPC_Color)
	else Death.color2 = table.Copy( team.GetColor( team2 ) ) end

	if team1 == -1 then Death.pteam1 = "The Horde?"
	else Death.pteam1 = team.GetName( team1 ) end
	
	if team2 == -1 then Death.pteam2 = "Killed NPC"
	else Death.pteam2 = team.GetName( team2 ) end
	
	if Death.left == Death.right then
		Death.left = nil
		Death.icon = "suicide"
	end
	
	table.insert( Deaths, Death )

end

local function DrawDeath(x, y, death, tea_cl_deathnoticetime)
	local w, h = 50, 50
	if ( !w || !h ) then return end
	
	local fadeout = ( death.time + tea_cl_deathnoticetime ) - CurTime()
	
	local alpha = math.Clamp( fadeout * 255, 0, 255 )
	death.color1.a = alpha
	death.color2.a = alpha

	-- Draw KILLER
	if death.right and not death.left then
		draw.SimpleText("Death: "..death.right.." ["..death.pteam2.."] "..death.SMessage, "ChatFont", x - (w / 2) + math.Clamp(1030 - (800 * ((CurTime()) - death.Time)), 230, 1030), y, Color(223,45,45,alpha), TEXT_ALIGN_RIGHT)
	elseif (death.left) then
		draw.SimpleText("Death: "..death.right.." ["..death.pteam2.."] was "..death.Message.." by "..death.left.." ["..death.pteam1.."]",	"ChatFont", x - (w / 2) + math.Clamp(1030 - (800 * ((CurTime()) - death.Time)), 230, 1030), y, Color(255,75,75,alpha), TEXT_ALIGN_RIGHT)
	end

	return (y + h * 0.70)
end


function GM:DrawDeathNotice(x, y)
	if !tobool(GetConVarNumber("cl_drawhud")) then return end

	local tea_cl_deathnoticetime = tea_cl_deathnoticetime:GetFloat()

	x = x * ScrW()
	y = y * ScrH()
	
	-- Draw
	for k, Death in pairs(Deaths) do

		if Death.time + tea_cl_deathnoticetime > CurTime() then
	
			if Death.lerp then
				x = x * 0.3 + Death.lerp.x * 0.7
				y = y * 0.3 + Death.lerp.y * 0.7
			end
			
			Death.lerp = Death.lerp or {}
			Death.lerp.x = x
			Death.lerp.y = y
		
			y = DrawDeath( x, y, Death, tea_cl_deathnoticetime )
		
		end
		
	end

	for k, Death in pairs( Deaths ) do
		if ( Death.time + tea_cl_deathnoticetime > CurTime() ) then
			return
		end
	end
	
	Deaths = {}
end
