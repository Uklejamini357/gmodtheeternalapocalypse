util.AddNetworkString("tea_openworld_level")

-- I'd love to actually make it connect between servers and share data with SQL. But for now, this is what we'll be having.

function GM:OpenworldTransition(routeid)
    local map = self.OpenworldMaps[routeid]
    if !map then return end
    local loading = map.Map1 == game.GetMap() and map.Map2 or map.Map2 == game.GetMap() and map.Map1 or nil

    if !loading then return end
    PrintMessage(3, "Transitioning to "..loading.."...")

    timer.Create("TEA.OpenworldMapchange", 5, 1, function()
        RunConsoleCommand("changelevel", loading)
    end)
end

function GM:OpenworldPlayerJoin(ply, routeid)
    local map = self.OpenworldMaps[routeid]
    if !map then return end
    local loading = map.Map1 == game.GetMap() and map.Map2 or map.Map2 == game.GetMap() and map.Map1 or nil

    if !loading then return end

    local joined = 0
    for _,pl in ipairs(player.GetHumans()) do
        if pl.TransitioningToMap == loading then
            joined = joined + 1
        end
    end
end

function GM:CreateMapRouteLink(name, from, frompos, to, topos, oneway)
    self.OpenworldMaps[#self.OpenworldMaps + 1] = {
        Name = name,
        Map1 = from,
        Pos1 = frompos,
        Map2 = to,
        Pos2 = topos,
        Oneway = oneway
    }

    -- debugging
    PrintMessage(3, "A new path has opened: "..name.." ("..from.." <-> "..to..")")
end
