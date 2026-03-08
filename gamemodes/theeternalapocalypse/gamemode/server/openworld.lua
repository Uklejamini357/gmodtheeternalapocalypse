util.AddNetworkString("tea_openworld_level")

-- I'd love to actually make it connect between servers and share data with SQL/MySQL. But for now, this is what we'll be having.

function GM:OpenworldTransition(routeid)
    local map = self.OpenworldTransitions[routeid]
    if !map then return end
    local loading = map.Map1 == game.GetMap() and map.Map2 or map.Map2 == game.GetMap() and map.Map1 or nil

    if !loading then return end
    PrintMessage(3, "Transitioning to "..loading.."...")

    timer.Create("TEA.OpenworldMapchange", 5, 1, function()
        RunConsoleCommand("changelevel", loading)
    end)
end

function GM:OpenworldPlayerJoinTransition(ply, routeid)
    local map = self.OpenworldTransitions[routeid]
    if !map then return end
    local loading = map.Map1 == game.GetMap() and map.Map2 or map.Map2 == game.GetMap() and map.Map1 or nil

    if !loading then return end
    if not (map.Direction == MAP_DIRECTION_BOTH or map.Direction == MAP_DIRECTION_FORWARD and map.Map1 == game.GetMap() or map.Direction == MAP_DIRECTION_BACKWARD and map.Map2 == game.GetMap()) then
        return
    end

    pl.TransitioningToMap = loading

    local joined = 0
    for _,pl in ipairs(player.GetHumans()) do
        if pl.TransitioningToMap == loading then
            joined = joined + 1
        end
    end

    if joined >= #player.GetHumans() then
        self:OpenworldTransition(routeid)
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

    if joined < #player.GetHumans() then
        timer.Remove("TEA.OpenworldMapchange")
        PrintMessage(3, "Map transitioning aborted!")
    end
end

function GM:OpenworldPlayerSendConfirm(ply, routeid, map)
    local map = self.OpenworldTransitions[routeid]
    if !map then return end
    local loading = map.Map1 == game.GetMap() and map.Map2 or map.Map2 == game.GetMap() and map.Map1 or nil

    if !loading then return end
    if not (map.Direction == MAP_DIRECTION_BOTH or map.Direction == MAP_DIRECTION_FORWARD and map.Map1 == game.GetMap() or map.Direction == MAP_DIRECTION_BACKWARD and map.Map2 == game.GetMap()) then
        return
    end

    net.Start("tea_openworld_level")
    net.WriteUInt(OPENWORLD_NETTYPE_SENDINFO, 4)
    net.WriteUInt(routeid, 8)
    net.WriteString(map.Name)
    net.WriteString(loading)
    net.WriteUInt(map.Direction, 2)
    net.Send(ply)
end

function GM:CreateMapRouteLink(name, from, frompos, fromminbounds, frommaxbounds, name2, to, topos, tominbounds, tomaxbounds, direction)
    self.OpenworldTransitions[#self.OpenworldTransitions + 1] = {
        Name1 = name1,
        Map1 = from,
        Pos1 = frompos,
        MinBounds1 = fromminbounds,
        MaxBounds1 = frommaxbounds,
        Name2 = name2,
        Map2 = to,
        Pos2 = topos,
        MinBounds2 = tominbounds,
        MaxBounds2 = tomaxbounds,
        Direction = direction
    }

    -- debugging
    PrintMessage(3, "A new path has opened: "..name.." ("..from.." <-> "..to..")")
end

function GM:LoadTransitionsData()
    local method = self.Config.SFS and sfs.decode or util.JSONToTable
    local tbl = method(file.Read(self.DataFolder.."/openworlddata.txt", "LUA"))

    for _,data in pairs(tbl) do
        local id = data.ID
        data.ID = nil
        self.OpenworldTransitions[id] = data
    end
end

function GM:SpawnLevelTransitions()
    for id, v in pairs(self.OpenworldTransitions) do
        local second = v.Map2 == game.GetMap()
        if v.Map1 ~= game.GetMap() and !second then continue end

        local transition = ents.Create("tea_transition")
        transition.min = second and v.MinBounds2 or v.MinBounds1
        transition.max = second and v.MaxBounds2 or v.MaxBounds1
        transition.RouteID = id
        transition:SetPos(second and v.Pos2 or v.Pos1)
        transition:Spawn()
    end
end

function GM:SaveTransitionsData()
    self.OpenworldTransitions[#self.OpenworldTransitions + 1] = {}
    
	local method = self.Config.SFS and sfs.encode or util.TableToJSON
    file.Write(self.DataFolder.."/openworlddata.txt", method(Data, self.Config.SFS and 50000 or true))

    -- debugging
    PrintMessage(3, "A new path has opened: "..name.." ("..from.." <-> "..to..")")
end
