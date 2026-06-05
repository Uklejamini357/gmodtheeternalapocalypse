-- Might get reworked in the future update.
-- Really needs a recode though.

Factions = Factions or {}

Factions["Loner"] = {
	["index"] = TEAM_LONER,
	["color"] = TEAM_COLOR_LONER,
	["public"] = true,
	["leader"] = nil
}

FactionIndex = FactionIndex or TEAM_LONER + 1

net.Receive("CreateFaction", function(length, pl)
	if !pl:IsValid() then return end
	local name = net.ReadString()
	local col = net.ReadTable()
	local public = net.ReadBool()

	if Factions[name] or name == "Loner" then
		pl:SystemMessage(translate.ClientGet(pl, "fac_name_exists"), COLOR_WARN, true)
		return
	end
	local col = Color(col.r, col.g, col.b)

	gamemode.Call("CreateFaction", client, name, col, public)
end)

net.Receive("JoinFaction", function(length, pl)
	if !pl:IsValid() then return end
	local name = net.ReadString()

	if name == "Loner" then
		gamemode.Call("LeaveFaction", pl)
	else
		gamemode.Call("JoinFaction", pl, name)
	end
end)

net.Receive("InviteFaction", function(length, pl)
	local target = net.ReadEntity()
	if !pl:IsValid() then return end
	if pl:Team() == TEAM_LONER then
		pl:SystemMessage(translate.ClientGet(pl, "fac_need_faction_inv"), COLOR_WARN, true)
		return
	end

	gamemode.Call("InviteFaction", client, target)
end)

net.Receive("KickFromFaction", function(length, pl)
	local target = net.ReadEntity()
	if !pl:IsValid() or !target:IsValid() then return end
	if team.GetName(pl:Team()) == "Loner" then
		pl:SystemMessage(translate.ClientGet(pl, "fac_kick_attempt_not_leader"), COLOR_WARN, true)
		return
	end

	gamemode.Call("BootFromFaction", client, target)
end)

net.Receive("GiveLeader", function(length, pl)
	local target = net.ReadEntity()
	if !pl:IsValid() or !target:IsValid() then return end

	gamemode.Call("GiveLeader", pl, target)
end)

net.Receive("DisbandFaction", function(length, client)
	if !client:IsValid() then return end
	local plyfaction = team.GetName(client:Team())

	gamemode.Call("PlayerDisbandFaction", client, plyfaction)
end)


function GM:CreateFaction(ply, name, col, public)
	if !ply:IsValid() then return end
	if ply:Team() ~= TEAM_LONER then
		ply:SystemMessage(translate.ClientGet(ply, "fac_no_create_in_faction"), COLOR_WARN, true)
		return
	end

	if name == "" then
		ply:SystemMessage(translate.ClientGet(ply, "fac_no_create_no_name"), COLOR_WARN, true)
		return
	end

	if (col.r + col.g + col.b) < 75 or col.r < 40 and col.g < 40 and col.b < 40 then
		ply:SystemMessage(translate.ClientGet(ply, "fac_no_create_too_dark"), COLOR_WARN, true)
		return
	end

	if (tonumber(ply.Money) <= self.FactionCost) then
		ply:SystemMessage(translate.ClientFormat(ply, "fac_no_create_expensive", self.FactionCost, self.Config["Currency"]), COLOR_WARN, true)
		return
	end

	if string.len(name) > 20 then
		ply:SystemMessage(translate.ClientFormat(ply, "fac_no_create_too_long", 20), COLOR_WARN, true)
		return
	end

	-- Because of the way how this is coded, it could be used to break factions.
	-- Thankfully, this process can be expensive (cost a lot of in-game money) so the bug will never happen unless it's abused.
	FactionIndex = FactionIndex + 1
	if FactionIndex > 100 then FactionIndex = 2 end
	Factions[name] = {
		["index"] = FactionIndex,
		["color"] = col,
		["public"] = public,
		["leader"] = ply,
	}
	
	team.SetUp(FactionIndex, tostring(name), Color(col.r, col.g, col.b, 255))
	ply:SetTeam(FactionIndex)
	ply.Money = ply.Money - self.FactionCost

	print(ply:Nick().." has created a faction for "..self.FactionCost.." "..self.Config["Currency"].."s named: "..tostring(name))

	self:SystemTranslatedBroadcast(translate.ClientFormat(ply, "fac_created", ply:Nick(), tostring(name)), COLOR_ACTION, true)
	self:NetUpdatePeriodicStats(ply)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:JoinFaction(ply, fac)
	if !ply:IsValid() or !Factions[fac] then return end
	if ply:Team() ~= TEAM_LONER then ply:SystemMessage(translate.ClientGet(ply, "fac_no_join_already_in_fac"), COLOR_WARN, true) return end

	local facdata = Factions[fac]
	local public = facdata["public"]
	local facindex = tonumber(facdata["index"])

	if ply:Team() == facindex then ply:SystemMessage(translate.ClientGet(ply, "fac_no_join_already_in_this_fac"), COLOR_WARN, true) return end
	if !public and !table.HasValue(ply.InvitedTo, fac) then ply:SystemMessage(translate.ClientGet(ply, "fac_no_join_private"), COLOR_WARN, true) return end

	ply:SetTeam(facindex)
	ply:SystemMessage(translate.ClientFormat(ply, "fac_joined", team.GetName(facindex)), COLOR_ACTION, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:BootFromFaction(ply, target)
	if !ply:IsValid() or !target:IsValid() then return end
	if ply:Team() == TEAM_LONER or target:Team() == TEAM_LONER then return end

	local plfac, tgfac = ply:Team(), target:Team()

	if ply ~= Factions[team.GetName(plfac)]["leader"] then ply:SystemMessage(translate.ClientGet(ply, "fac_not_leader"), COLOR_WARN, true) return end
	if ply == target then ply:SystemMessage(translate.ClientGet(ply, "fac_cant_kick_self"), COLOR_WARN, true) return end

	target:SetTeam(TEAM_LONER)
	self:ClearFactionStructures(target)

	ply:SystemMessage(translate.ClientFormat(ply, "", target:Nick()), COLOR_ACTION, true)
	target:SystemMessage(translate.ClientFormat(target, "fac_kicked_from", ply:Nick()), COLOR_WARN, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:LeaveFaction(ply)
	if !ply:IsValid() then return end
	if ply:Team() == TEAM_LONER then ply:SystemMessage(translate.ClientGet(ply, "fac_already_loner"), COLOR_WARN, true) return end
	if timer.Exists("pvpnominge_"..ply:EntIndex()) then ply:SystemMessage(translate.ClientGet(ply, "fac_cant_leave_pvp"), COLOR_WARN, true) return end

	ply:SystemMessage("You have left your faction and you are now a loner.", COLOR_ACTION, true)

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
	if !ply:IsValid() or !target:IsValid() then return end

	local plyfaction = team.GetName(ply:Team())

	if ply == target then ply:SystemMessage("You can't invite yourself to a faction!", COLOR_WARN, true) return end
	if Factions[plyfaction]["leader"] != ply then ply:SystemMessage("You are not the leader of your faction!", COLOR_WARN, true) return end
	if team.GetName(ply:Team()) == team.GetName(target:Team()) then ply:SystemMessage(target:Nick().." is already in your faction!", COLOR_ACTION, true) return end
	if table.HasValue(target.InvitedTo, plyfaction) then ply:SystemMessage("You have already sent a faction invite to "..target:Nick().."!", COLOR_WARN, true) return end

	table.insert(target.InvitedTo, plyfaction)
	ply:SystemMessage("You have invited: "..target:Nick().." to join your faction", COLOR_ACTION, true)
	target:SystemMessage(ply:Nick().." has invited you to join their faction '"..team.GetName(ply:Team()).."'. Navigate to the factions tab in your inventory window to join.", COLOR_ACTION, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:SelectRandomLeader(fac)
	if !Factions[fac] then return end
	local index = Factions[fac]["index"]
	Factions[fac]["leader"] = table.Random(team.GetPlayers(index))
	self:SystemBroadcast(translate.Format("factionnewleader", Factions[fac]["leader"]:Nick(), fac), COLOR_ACTION, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:GiveLeader(ply, target)
	if !ply:IsValid() or !target:IsValid() then return end
	if ply == target then ply:SystemMessage("You cannot give faction leadership to yourself!", COLOR_WARN, true) return end
	if ply:Team() == TEAM_LONER or target:Team() == TEAM_LONER then ply:SystemMessage("You apparently tried to give leadership to a loner, You dun goof'd mate", COLOR_WARN, true) return end
	if ply:Team() != target:Team() then ply:SystemMessage("You cannot give leadership to somebody that isn't in your faction!", COLOR_WARN, true) return end
	local plyfaction = team.GetName(ply:Team())
	if Factions[plyfaction]["leader"] != ply then ply:SystemMessage("You are not the leader of your faction!", COLOR_WARN, true) return end
	
	Factions[plyfaction]["leader"] = target
	ply:SystemMessage("You have ceded leadership of your faction to: "..target:Nick(), COLOR_ACTION, true)
	target:SystemMessage(ply:Nick().." has given faction leader to you! You now own the faction: "..plyfaction, COLOR_ACTION, true)
	self:SystemBroadcast(ply:Nick().." has selected "..target:Nick().." to be the new leader of "..plyfaction, COLOR_ACTION, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:PlayerDisbandFaction(ply, fac)
	if !Factions[fac] or !ply:IsValid() then return end
	if ply:Team() == TEAM_LONER then ply:SystemMessage("You are not in a faction!", COLOR_WARN, true) return end
	if Factions[fac]["leader"] != ply then ply:SystemMessage("You cannot disband a faction as you are not the leader of that faction!", COLOR_WARN, true) return end
	local plyfaction = team.GetName(ply:Team())

	for k, v in pairs(team.GetPlayers(tonumber(Factions[fac]["index"]))) do
		v:SetTeam(1)
		gamemode.Call("ClearFactionStructures", v)
		if ply == v then
			v:SystemMessage(Format("You have disbanded your faction \"%s\"!", plyfaction), COLOR_WARN, true)
		else
			v:SystemMessage(Format("Your faction \"%s\" has been disbanded by \"%s\"!", plyfaction, ply:Nick()), COLOR_WARN, true)
		end
		gamemode.Call("AutoDisbandFaction", plyfaction)
	end
	Factions[fac] = nil

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end


function GM:AutoDisbandFaction(fac)
	if !Factions[fac] then return end
	Factions[fac] = nil
	self:SystemBroadcast("The faction: "..fac.." has no more members and has been disbanded", COLOR_ACTION, true)

	net.Start("RecvFactions")
	net.WriteTable(Factions)
	net.Broadcast()
end
