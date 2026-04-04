
function GM:OnSafezoneEnter(pl, ent)
end

function GM:OnSafezoneFull(pl, ent)

end

function GM:OnSafezoneLeave(pl, ent)

end

function GM:SendMapSafezonesInfo(pl)
end

function GM:CreateMapSafezone(name, min, max)
	local id = #self.MapSafezones + 1
    self.MapSafezones[id] = {
        Name = name,
        AreaMin = min,
        AreaMax = max
    }

    gamemode.Call("SaveSafezonesData")
    gamemode.Call("SpawnMapSafezones")
    self:UpdateAdminEyes("Safezones")
end

function GM:ConnectSafeZones(id1, id2)
	if !id1 or !self.MapSafezones[id1] then print("invalid safezone (arg #1)") return end
	if !id2 or !self.MapSafezones[id2] then print("invalid safezone (arg #2)") return end

	self.MapSafezones[id1].LinkedTo = id2
    self:UpdateSafezones()

	print("Created a link to a map")
end

function GM:DeleteSafezone(id)
    if !id or !self.MapSafezones[id] then return end
    local thismap = self.MapSafezones[id].Map == game.GetMap()
    self.MapSafezones[id] = nil
    for _,v in pairs(self.MapSafezones) do
        if v.LinkedTo ~= id then continue end
        v.LinkedTo = nil
    end

    self:SaveSafezonesData()
    if thismap then
        self:SpawnMapSafezones()
    end
end

function GM:ClearSafezones()
    self.MapSafezones = {}
    if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt", "DATA") then
        file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt")
    end

    self:SpawnMapSafezones()

    for id,v in pairs(self.MapSafezones) do
        if v.Map ~= game.GetMap() then continue end

        self.MapSafezones[id] = nil
    end

    if table.Count(self.MapSafezones) == 0 then
        if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt", "DATA") then
            file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt")
        end
    else
        self:SaveSafezonesData()
    end
    self:SpawnMapSafezones()
end


function GM:SaveSafezonesData()
	local method = self.Config.SFS and sfs.encode or util.TableToJSON
    file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt", method(self.MapSafezones, self.Config.SFS and 50000 or true))
end

function GM:LoadSafezonesData()
    local method = self.Config.SFS and sfs.decode or util.JSONToTable
    local tbl = method(file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt", "DATA"))

    for id,data in pairs(tbl) do
        self.MapSafezones[id] = data
    end
end

function GM:SpawnMapSafezones()
    for _, ent in ipairs(ents.FindByClass("tea_safezone")) do
    	ent:Remove()
    end

    for id, v in pairs(self.MapSafezones) do
        if v.Map ~= game.GetMap() then continue end

        local safezone = ents.Create("tea_safezone")
        safezone.min = v.AreaMin
        safezone.max = v.AreaMax
        safezone.ID = id
        safezone.LinkedTo = v.LinkedTo
        safezone.StartPos = v.StartPos
        safezone.StartAng = v.StartAng
        safezone:SetPos((v.AreaMin + v.AreaMax) / 2)
        safezone:Spawn()
    end
    self:UpdateAdminEyes("Openworld")
end

function GM:UpdateSafezones()
    for _, ent in ipairs(ents.FindByClass("tea_safezone")) do
    	if !ent.ID then print(ent, "has invalid ID, wtf!!!") continue end
        local data = self.MapSafezones[ent.ID]
        if !data then ent:Remove() continue end

        ent.min = data.AreaMin
        ent.max = data.AreaMax
        ent.LinkedTo = data.LinkedTo
        ent.StartPos = data.StartPos
        ent.StartAng = data.StartAng
        ent:SetPos((data.AreaMin + data.AreaMax) / 2)

    	local w = ent.max.x - ent.min.x
    	local l = ent.max.y - ent.min.y
    	local h = ent.max.z - ent.min.z

    	local min = Vector(-(w/2), -(l/2), -(h/2))
    	local max = Vector(w/2, l/2, h/2)
        print(min, max)
        ent:SetCollisionBounds(min, max)
    end

    self:UpdateAdminEyes("Openworld")
end
