util.AddNetworkString("tea_openworld_level")

-- I'd love to actually make it connect between servers and share data with SQL/MySQL. But for now, this is what we'll be having.

function GM:OpenworldTransition(tomapid)
    local data = self.OpenworldTransitions[tomapid]
    if !data then return end
    local map = data.Map

    PrintMessage(3, "Transitioning to "..map.."...")

    timer.Create("TEA.OpenworldMapchange", 5, 1, function()
		for _,pl in player.Iterator() do
			pl.TransitioningMap = map
			pl.TransitioningPos = data.StartPos
		end
	
        RunConsoleCommand("changelevel", map)
    end)
end

function GM:OpenworldPlayerJoinTransition(ply, ent)
	if !ent.LinkedTo then return end

    local data = self.OpenworldTransitions[ent.LinkedTo]
    ply.TransitioningToMap = data.Map
    ply:PrintMessage(3, "placeholder")

    local joined = 0
    for _,pl in ipairs(player.GetHumans()) do
        if pl.TransitioningToMap == data.Map then
            joined = joined + 1
        end
    end

    if joined >= #player.GetHumans() then
        self:OpenworldTransition(ent.LinkedTo)
    end
end

function GM:OpenworldPlayerLeaveTransition(ply)
    ply.TransitioningToMap = nil

    local joined = 0
    for _,pl in ipairs(player.GetHumans()) do
        if pl.TransitioningToMap == loading then
            joined = joined + 1
        end
    end

    if joined <= #player.GetHumans() then
        timer.Remove("TEA.OpenworldMapchange")
        PrintMessage(3, "Map transitioning aborted!")
    end
end

function GM:OpenworldPlayerSendConfirm(ply, ent)
    local data = self.OpenworldTransitions[ent.LinkedTo]
    if !map then return end
    local map = data.Map

    net.Start("tea_openworld_level")
    net.WriteUInt(OPENWORLD_NETTYPE_SENDINFO, 4)
    net.WriteString(data.Map)
    net.Send(ply)
end

function GM:SendMapTransitionsInfo(pl)
	local tbl = {}
	for _,map in pairs(self.OpenworldTransitions) do
		if map.Map == game.GetMap() then
			table.insert(tbl, map)
		end
	end 

	net.Start("tea_openworld_level")
	net.WriteUInt(OPENWORLD_NETTYPE_SENDMAPSINFO, 4)
	net.WriteTable(tbl)
	net.Send(pl)
end

function GM:CreateMapTransition(name, map, start, min, max)
	local id = #self.OpenworldTransitions + 1
    self.OpenworldTransitions[id] = {
        Name = name,
        Map = map,
        StartPos = start,
        AreaMin = min,
        AreaMax = max
    }

    -- debugging
    print("Created a new transition trigger")
end

function GM:CreateMapTransitionLink(id1, id2)
	if !self.OpenworldTransitions[id1] then print("invalid transition (arg #1)") return end
	if !self.OpenworldTransitions[id2] then print("invalid transition (arg #2)") return end

	self.OpenworldTransitions[id1].LinkedTo = id2

	print("Created a link to a map")
end

function GM:LoadTransitionsData()
    local method = self.Config.SFS and sfs.decode or util.JSONToTable
    local tbl = method(file.Read(self.DataFolder.."/openworlddata.txt", "DATA"))

    for id,data in pairs(tbl) do
        self.OpenworldTransitions[id] = data
    end
end

function GM:SpawnLevelTransitions()
    for _, ent in ipairs(ents.FindByClass("tea_transition")) do
    	ent:Remove()
    end

    for id, v in pairs(self.OpenworldTransitions) do
        if v.Map ~= game.GetMap() then continue end

        local transition = ents.Create("tea_transition")
        transition.min = v.AreaMin
        transition.max = v.AreaMax
        transition.ID = id
        transition.LinkedTo = v.LinkedTo
        transition.StartPos = v.StartPos
        transition:SetPos((v.AreaMin + v.AreaMax) / 2)
        transition:Spawn()
    end

    self:SendMapTransitionsInfo(player.GetAll())
end

function GM:UpdateLevelTransitions()
    for _, ent in ipairs(ents.FindByClass("tea_transition")) do
    	if !ent.ID then print(ent, "has invalid ID, wtf!!!") continue end
        local data = self.OpenworldTransitions[ent.ID]
        if !data then ent:Remove() continue end

        ent.min = data.AreaMin
        ent.max = data.AreaMax
        ent.LinkedTo = data.LinkedTo
        ent.StartPos = data.StartPos
        ent:SetPos((data.AreaMin + data.AreaMax) / 2)
    end

    self:SendMapTransitionsInfo(player.GetAll())
end

function GM:SaveTransitionsData()
	local method = self.Config.SFS and sfs.encode or util.TableToJSON
    file.Write(self.DataFolder.."/openworlddata.txt", method(self.OpenworldTransitions, self.Config.SFS and 50000 or true))
end
