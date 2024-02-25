-- declare factions as itself to stop autorefresh raping everything

Factions = Factions or {}

Factions["Loner"] = 
{
	["index"] = TEAM_LONER,
	["color"] = Color( 100, 50, 50, 255 ),
	["public"] = true,
	["leader"] = nil
}

FactionIndex = FactionIndex or TEAM_LONER + 1

net.Receive("CreateFaction", function(length, client)
	if !client:IsValid() then return false end
	local name = net.ReadString()
	local col = net.ReadTable()
	local public = net.ReadBool()

	if Factions[name] or name == "Loner" then
		ply:SystemMessage("A faction with this name already exists!", Color(255,205,205,255), true)
		return false
	end
	local col = Color(col.r, col.g, col.b, 255)

	gamemode.Call("CreateFaction", client, name, col, public)
end)

net.Receive("JoinFaction", function(length, client)
	if !client:IsValid() then return end
	local name = net.ReadString()

	if name == "Loner" then
		gamemode.Call("LeaveFaction", client)
	else
		gamemode.Call("JoinFaction", client, name)
	end
end)

net.Receive("InviteFaction", function(length, client)
	local target = net.ReadEntity()
	if !client:IsValid() then return false end
	if team.GetName(client:Team()) == "Loner" then
		ply:SystemMessage("You need to be in a faction to invite somebody else to join you!", Color(255,205,205,255), true)
		return false
	end

	gamemode.Call("InviteFaction", client, target)
end)

net.Receive("KickFromFaction", function(length, client)
	local target = net.ReadEntity()
	if !client:IsValid() or !target:IsValid() then return false end
	if team.GetName(client:Team()) == "Loner" then
		ply:SystemMessage("You can't kick somebody if you aren't the faction leader!", Color(255,205,205,255), true)
		return false
	end

	gamemode.Call("BootFromFaction", client, target)
end)

net.Receive("GiveLeader", function(length, client)
	local target = net.ReadEntity()
	if !client:IsValid() or !target:IsValid() then return false end

	gamemode.Call("GiveLeader", client, target)
end)

net.Receive("DisbandFaction", function(length, client)
	if !client:IsValid() then return false end
	local plyfaction = team.GetName(client:Team())

	gamemode.Call("PlayerDisbandFaction", client, plyfaction)
end)


function GM:CreateFaction(ply, name, col, public)
	if !ply:IsValid() then return false end
	if ply:Team() ~= TEAM_LONER then
		ply:SystemMessage("You can't create a new faction while in a faction!", Color(255,205,205,255), true)
		return false
	end

	if name == "" then
		ply:SystemMessage("You can't create a faction with no name!", Color(255,205,205,255), true)
		return false
	end

	if (col.r + col.g + col.b) < 75 or col.r < 40 and col.g < 40 and col.b < 40 then
		ply:SystemMessage("You can't create a faction with a black colour! Try a brighter colour instead!", Color(255,205,205,255), true)
		return false
	end

	if (tonumber(ply.Money) <= self.FactionCost) then
		ply:SystemMessage("You can't afford to make a faction! making a faction costs "..self.FactionCost.." "..self.Config["Currency"].."s", Color(255,205,205,255), true)
		return false
	end

	if string.len(name) > 20 then
		ply:SystemMessage("Your faction name cannot be longer than 20 characters!", Color(255,205,205,255), true)
		return false
	end

	FactionIndex = FactionIndex + 1
	if FactionIndex > 100 then FactionIndex = 2 end
	
	Factions[name] = 
	{
		["index"] = FactionIndex,
		["color"] = col,
		["public"] = public,
		["leader"] = ply,
	}
	
	team.SetUp(FactionIndex, tostring(name), Color(col.r, col.g, col.b, 255))
	ply:SetTeam(FactionIndex)
	ply.Money = ply.Money - self.FactionCost
	print(ply:Nick().." has created a faction for "..self.FactionCost.." "..self.Config["Currency"].."s named: "..tostring(name))
	self:SystemBroadcast(ply:Nick().." has created a faction named: "..tostring(name), Color(205,205,255,255), true)
	self:NetUpdatePeriodicStats(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:JoinFaction(ply, fac)
	if !ply:IsValid() or !Factions[fac] then return false end
	if ply:Team() != TEAM_LONER then ply:SystemMessage("You can't join a faction while already in a faction!", Color(255,205,205,255), true) return false end
	local facdata = Factions[fac]
	local public = facdata["public"] or false

	if team.GetName(ply:Team()) == fac then ply:SystemMessage("You are already in this faction!", Color(255,205,205,255), true) return false end
	if !public and !table.HasValue(ply.InvitedTo, fac) then ply:SystemMessage("This faction is not public! You must be invited to join it", Color(255,205,205,255), true) return false end

	ply:SetTeam( tonumber(facdata["index"]) )
	ply:SystemMessage("You joined the faction: "..team.GetName(ply:Team()), Color(205,205,255,255), true)
	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:BootFromFaction( ply, target )
	if !ply:IsValid() or !target:IsValid() then return false end
	if ply:Team() == TEAM_LONER or target:Team() == TEAM_LONER then ply:SystemMessage("You can't kick a loner!", Color(255,205,205,255), true) return false end -- how in the world did they manage to kick somebody if they are a loner
	local plyfaction = team.GetName(ply:Team())
	local targetfaction = team.GetName(target:Team())
	if Factions[plyfaction]["leader"] != ply then ply:SystemMessage("You are not the leader of your faction!", Color(255,205,205,255), true) return false end
	if target == ply then ply:SystemMessage("You can't kick yourself! Use the leave faction or disband faction command instead!", Color(255,205,205,255), true) return false end
	if plyfaction != targetfaction then ply:SystemMessage("just what the FUCK ARE YOU DOING?!", Color(255,205,205,255), true) return false end

	target:SetTeam(1)
	self:ClearFactionStructures(target)
	ply:SystemMessage("You have kicked "..target:Nick().." from your faction!", Color(205,205,255,255), true)
	target:SystemMessage(ply:Nick().." has kicked you out from the faction!", Color(255,205,205,255), true)
	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:LeaveFaction(ply)
	if !ply:IsValid() then return false end
	if ply:Team() == TEAM_LONER then ply:SystemMessage("You are already a loner!", Color(255,205,205,255), true) return false end
	if timer.Exists("pvpnominge_"..ply:EntIndex()) then ply:SystemMessage("You cannot leave faction as you have damaged or you took damage from another player within the last 60 seconds!", Color(255,205,205,255), true) return false end
	
	ply:SystemMessage("You have left your faction and you are now a loner.", Color(205,205,255,255), true)

	local plyfaction = team.GetName(ply:Team())
	if team.NumPlayers(ply:Team()) > 1 && Factions[plyfaction]["leader"] == ply then
		ply:SetTeam(1)
		timer.Simple(0.25, function()
			gamemode.Call("SelectRandomLeader", plyfaction)
		end)
	elseif team.NumPlayers(ply:Team()) <= 1 then
		gamemode.Call("AutoDisbandFaction", plyfaction)
	end

	ply:SetTeam(1)
	gamemode.Call("ClearFactionStructures", ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end
concommand.Add("tea_leavefaction", function(ply)
	gamemode.Call("LeaveFaction", ply)
end)


function GM:InviteFaction(ply, target)
	if !ply:IsValid() or !target:IsValid() then return false end

	local plyfaction = team.GetName(ply:Team())

	if ply == target then ply:SystemMessage("You can't invite yourself to a faction!", Color(255,205,205,255), true) return false end
	if Factions[plyfaction]["leader"] != ply then ply:SystemMessage("You are not the leader of your faction!", Color(255,205,205,255), true) return false end
	if team.GetName(ply:Team()) == team.GetName(target:Team()) then ply:SystemMessage(target:Nick().." is already in your faction!", Color(205,205,255,255), true) return false end
	if table.HasValue(target.InvitedTo, plyfaction) then ply:SystemMessage("You have already sent a faction invite to "..target:Nick().."!", Color(255,205,205,255), true) return false end

	table.insert(target.InvitedTo, plyfaction)
	ply:SystemMessage("You have invited: "..target:Nick().." to join your faction", Color(205,205,255,255), true)
	target:SystemMessage(ply:Nick().." has invited you to join their faction '"..team.GetName(ply:Team()).."'. Navigate to the factions tab in your inventory window to join.", Color(205,205,255,255), true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:SelectRandomLeader(fac)
	if !Factions[fac] then return false end
	local index = Factions[fac]["index"]
	Factions[fac]["leader"] = table.Random(team.GetPlayers(index))
	self:SystemBroadcast(translate.Format("factionnewleader", Factions[fac]["leader"]:Nick(), fac), Color(205,205,255,255), true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:GiveLeader(ply, target)
	if !ply:IsValid() or !target:IsValid() then return false end
	if ply == target then ply:SystemMessage("You cannot give faction leadership to yourself!", Color(255,205,205,255), true) return false end
	if ply:Team() == TEAM_LONER or target:Team() == TEAM_LONER then ply:SystemMessage("You apparently tried to give leadership to a loner, You dun goof'd mate", Color(255,205,205,255), true) return false end
	if ply:Team() != target:Team() then ply:SystemMessage("You cannot give leadership to somebody that isn't in your faction!", Color(255,205,205,255), true) return false end
	local plyfaction = team.GetName(ply:Team())
	if Factions[plyfaction]["leader"] != ply then ply:SystemMessage("You are not the leader of your faction!", Color(255,205,205,255), true) return false end
	
	Factions[plyfaction]["leader"] = target
	ply:SystemMessage("You have ceded leadership of your faction to: "..target:Nick(), Color(205,205,255,255), true)
	target:SystemMessage(ply:Nick().." has given faction leader to you! You now own the faction: "..plyfaction, Color(205,205,255,255), true)
	self:SystemBroadcast(ply:Nick().." has selected "..target:Nick().." to be the new leader of "..plyfaction, Color(205,205,255,255), true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:PlayerDisbandFaction(ply, fac)
	if !Factions[fac] or !ply:IsValid() then return false end
	if ply:Team() == TEAM_LONER then ply:SystemMessage("You are not in a faction!", Color(255,205,205,255), true) return false end
	if Factions[fac]["leader"] != ply then ply:SystemMessage("You cannot disband a faction as you are not the leader of that faction!", Color(255,205,205,255), true) return false end
	local plyfaction = team.GetName(ply:Team())

	for k, v in pairs(team.GetPlayers(tonumber(Factions[fac]["index"]))) do
		v:SetTeam(1)
		gamemode.Call("ClearFactionStructures", v)
		if ply == v then
			v:SystemMessage(Format("You have disbanded your faction \"%s\"!", plyfaction), Color(255,205,205,255), true)
		else
			v:SystemMessage(Format("Your faction \"%s\" has been disbanded by \"%s\"!", plyfaction, ply:Nick()), Color(255,205,205,255), true)
		end
		gamemode.Call("AutoDisbandFaction", plyfaction)
	end
	Factions[fac] = nil

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:AutoDisbandFaction(fac)
	if !Factions[fac] then return false end
	Factions[fac] = nil
	self:SystemBroadcast("The faction: "..fac.." has no more members and has been disbanded", Color(205,205,255,255), true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end
