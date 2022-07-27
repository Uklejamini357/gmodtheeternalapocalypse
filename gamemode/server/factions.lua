-- declare factions as itself to stop autorefresh raping everything

Factions = Factions or {}


Factions[ "Loner" ] = 
{
		["index"] = 1,
		["color"] = Color( 100, 50, 50, 255 ),
		["public"] = true,
		["leader"] = nil
}




FactionIndex = FactionIndex or 2

net.Receive( "CreateFaction", function( length, client )
if !client:IsValid() then return false end

local name = net.ReadString()
local col = net.ReadTable()
local public = net.ReadBool()

if Factions[name] or name == "Loner" then SystemMessage(client, "A faction with this name already exists!", Color(255,205,205,255), true) return false end
local col = Color(col.r, col.g, col.b, 255)

CreateFaction(client, name, col, public)
end)

net.Receive( "JoinFaction", function( length, client )
if !client:IsValid() then return end

local name = net.ReadString()

if name == "Loner" then LeaveFaction( client ) else
JoinFaction( client, name )
end

end)

net.Receive( "InviteFaction", function( length, client )
local target = net.ReadEntity()
if !client:IsValid() then return false end
if team.GetName(client:Team()) == "Loner" then SystemMessage(client, "You need to be in a faction to invite somebody else to join you", Color(255,205,205,255), true) return false end
InviteFaction(client, target)
end)

net.Receive( "KickFromFaction", function( length, client )
local target = net.ReadEntity()
if !client:IsValid() or !target:IsValid() then return false end
if team.GetName(client:Team()) == "Loner" then SystemMessage(client, "You can't kick somebody if you arent the faction leader", Color(255,205,205,255), true) return false end
BootFromFaction(client, target)
end)

net.Receive( "DisbandFaction", function( length, client )
if !client:IsValid() then return false end
local plyfaction = team.GetName(client:Team())
PlayerDisbandFaction( client, plyfaction )
end)


function CreateFaction( ply, name, col, public )
	local tea_config_factioncost = GetConVar("tea_config_factioncost")
	if !ply:IsValid() then return false end
	if name == "" then SystemMessage(ply, "You can't create a faction with no name!", Color(255,205,205,255), true) return false end
	if ((col.r + col.g + col.b) < 75) then SystemMessage(ply, "You can't create a faction with a black colour! Try a brighter colour instead!", Color(255,205,205,255), true) return false end
	if (tonumber(ply.Money) <= tea_config_factioncost:GetInt()) then SystemMessage(ply, "You can't afford to make a faction! making a faction costs "..tea_config_factioncost:GetInt().." "..Config[ "Currency" ].."s", Color(255,205,205,255), true) return false end
	if string.len(name) > 20 then SystemMessage(ply, "Your faction name cannot be longer than 20 characters!", Color(255,205,205,255), true) return false end
--	ply.Money = ply.Money - 250

	FactionIndex = FactionIndex + 1

	if FactionIndex > 100 then FactionIndex = 2 end
	
	Factions[ name ] = 
	{
	["index"] = FactionIndex,
	["color"] = col,
	["public"] = public,
	["leader"] = ply,
	}
	
	team.SetUp( FactionIndex, tostring( name ), Color( col.r, col.g, col.b, 255 ) )
	ply:SetTeam( FactionIndex )
	ply.Money = ply.Money - tea_config_factioncost:GetInt()
	print(ply:Nick().." has created a faction for "..tea_config_factioncost:GetInt().." "..Config[ "Currency" ].."s named: "..tostring(name))
	SystemBroadcast(ply:Nick().." has created a faction named: "..tostring(name), Color(205,205,255,255), true)
	FullyUpdatePlayer(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function JoinFaction( ply, fac )
if !ply:IsValid() or !Factions[fac] then return false end
local facdata = Factions[fac]
local public = facdata["public"] or false

if team.GetName(ply:Team()) == fac then SystemMessage(ply, "You are already in this faction!", Color(255,205,205,255), true) return false end

if !public and !table.HasValue(ply.InvitedTo, fac) then SystemMessage(ply, "This faction is not public! You must be invited to join it", Color(255,205,205,255), true) return false end

ply:SetTeam( tonumber(facdata["index"]) )
SystemMessage(ply, "You joined the faction: "..team.GetName(ply:Team()).."", Color(205,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()
end


function BootFromFaction( ply, target )
if !ply:IsValid() or !target:IsValid() then return false end
if ply:Team() == 1 or target:Team() == 1 then SystemMessage(ply, "You can't kick a loner!", Color(255,205,205,255), true) return false end -- how the fuck did they manage to kick somebody if they are a loner
local plyfaction = team.GetName(ply:Team())
local targetfaction = team.GetName(target:Team())
if Factions[plyfaction]["leader"] != ply then SystemMessage(ply, "You aren't the leader of your faction!", Color(255,205,205,255), true) return false end
if target == ply then SystemMessage(ply, "You can't kick yourself! Use the leave faction or disband faction command instead!", Color(255,205,205,255), true) return false end
if plyfaction != targetfaction then SystemMessage(ply, "Stop trying to hack you little faggot", Color(255,205,205,255), true) return false end

	target:SetTeam( 1 )
	ClearFactionStructures(target)
	SystemMessage(ply, "You have kicked "..target:Nick().." from your faction", Color(205,205,255,255), true)
	SystemMessage(target, ply:Nick().." has kicked you out of their faction!", Color(205,205,255,255), true)
	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function LeaveFaction( ply, cmd, args )
if !ply:IsValid() then return false end
if ply:Team() == 1 then SystemMessage(ply, "You are already a loner!", Color(255,205,205,255), true) return false end
if timer.Exists("pvpnominge_"..ply:UniqueID()) then SystemMessage(ply, "You cannot leave faction as you have damaged or you took damage from another player within the last 60 seconds!", Color(255,205,205,255), true) return false end
	
	SystemMessage(ply, "You left your faction and are now a loner", Color(205,205,255,255), true)

	local plyfaction = team.GetName(ply:Team())
	if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
		timer.Simple(0.25, function() -- hopefully that will work
		ply:SetTeam( 1 )
		SelectRandomLeader(plyfaction)
		end)
	elseif team.NumPlayers(ply:Team()) <= 1 then
		AutoDisbandFaction( plyfaction )
	end

	ply:SetTeam( 1 )
	ClearFactionStructures(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end
concommand.Add( "ate_leavefaction", LeaveFaction )


function InviteFaction(ply, target)
if !ply:IsValid() or !target:IsValid() then return false end

local plyfaction = team.GetName(ply:Team())

if ply == target then SystemMessage(ply, "You cant invite yourself to a faction!", Color(255,205,205,255), true) return false end
if Factions[plyfaction]["leader"] != ply then SystemMessage(ply, "You aren't the leader of your faction!", Color(255,205,205,255), true) return false end
if team.GetName(ply:Team()) == team.GetName(target:Team()) then SystemMessage(ply, target:Nick().."Is already in your faction!", Color(205,205,255,255), true) return false end
if table.HasValue(target.InvitedTo, plyfaction) then SystemMessage(ply, "You have already sent a faction invite to "..target:Nick().."!", Color(255,205,205,255), true) return false end

table.insert( target.InvitedTo, plyfaction )
--PrintTable(target.InvitedTo)
SystemMessage(ply, "You have invited: "..target:Nick().." to join your faction", Color(205,205,255,255), true)
SystemMessage(target, ply:Nick().." has invited you to join their faction: "..team.GetName(ply:Team()).." .  Navigate to the factions tab in your inventory window to join.", Color(205,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()
end


function SelectRandomLeader(fac)
if !Factions[fac] then return false end
local index = Factions[fac]["index"]
Factions[fac]["leader"] = table.Random(team.GetPlayers(index))
--SystemMessage(Factions[fac]["leader"], "You have been randomly selected to be the new leader of "..fac, Color(205,205,255,255), true)
SystemBroadcast(Factions[fac]["leader"]:Nick().." has been randomly selected to be the new leader of "..fac, Color(205,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()
end


function GiveLeader( ply, target )
if !ply:IsValid() or !target:IsValid() then return false end
if ply:Team() == 1 or target:Team() == 1 then SystemMessage(ply, "You apparently tried to give leadership to a loner, You dun goof'd mate", Color(255,205,205,255), true) return false end
if ply:Team() == target:Team() then SystemMessage(ply, "You cannot give leadership to somebody that isn't in your faction!", Color(255,205,205,255), true) return false end
local plyfaction = team.GetName(ply:Team())
if Factions[plyfaction]["leader"] != ply then SystemMessage(ply, "You aren't the leader of your faction!", Color(255,205,205,255), true) return false end

Factions[plyfaction]["leader"] = target
SystemMessage(ply, "You have ceded leadership of your faction to : "..target:Nick(), Color(205,205,255,255), true)
SystemMessage(target, ply:Nick().." has given faction leader to you! You now own the faction: "..plyfaction, Color(205,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()

end


function PlayerDisbandFaction( ply, fac )
if !Factions[fac] or !ply:IsValid() then return false end
if ply:Team() == 1 then SystemMessage(ply, "You aren't in a faction!", Color(255,205,205,255), true) return false end
if Factions[fac]["leader"] != ply then SystemMessage(ply, "You cannot disband a faction you aren't the leader of", Color(255,205,205,255), true) return false end
local plyfaction = team.GetName(ply:Team())

for k, v in pairs(team.GetPlayers(tonumber(Factions[fac]["index"]))) do
	LeaveFaction( v )
end
Factions[fac] = nil
--SystemBroadcast(ply:Nick().." has disbanded the faction: "..plyfaction, Color(255,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()
end


function AutoDisbandFaction( fac )
if !Factions[fac] then return false end
Factions[fac] = nil
SystemBroadcast("The faction: "..fac.." has no more members and has been disbanded", Color(205,205,255,255), true)

net.Start("RecvFactions")
net.WriteTable(Factions)
net.Broadcast()
end
