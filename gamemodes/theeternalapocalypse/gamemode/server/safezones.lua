
function GM:OnSafezoneEnter(pl, ent)
    if pl.SpawnProtected then
        gamemode.Call("OnSafezoneFull", pl)
    else
        timer.Create("TEASafeZoneProtection."..pl:EntIndex(), self.SafezoneProtectionDelay, 1, function()
            gamemode.Call("OnSafezoneFull", pl)
        end)
    end

    net.Start("tea_safezone")
    net.WriteBool(true)
    net.Send(pl)
end

function GM:OnSafezoneFull(pl)
    pl:SetSZProtected(true)

    pl.SZSurvivalTime = pl:GetTimeSurvived()
end

function GM:OnSafezoneLeave(pl, ent)
    if timer.Exists("TEASafeZoneProtection."..pl:EntIndex()) then
        timer.Remove("TEASafeZoneProtection."..pl:EntIndex())
    end

    if pl:IsSZProtected() then
        if pl:Alive() then
            pl:SystemMessage("You have left the safezone.", Color(255, 255, 200), true)
        end
        pl.SurvivalTime = pl:GetTimeSurvived()
        pl.SZSurvivalTime = nil
    end
    pl:SetSZProtected(false)

    net.Start("tea_safezone")
    net.WriteBool(false)
    net.Send(pl)
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

-- unused
function GM:ConnectSafeZones(id1, id2)
	if !id1 or !self.MapSafezones[id1] then print("invalid safezone (arg #1)") return end
	if !id2 or !self.MapSafezones[id2] then print("invalid safezone (arg #2)") return end

	self.MapSafezones[id1].LinkedTo = id2
    self:UpdateSafezones()

	print("Created a link to a map")
end

function GM:DeleteSafezone(id)
    if !id or !self.MapSafezones[id] then return end
    print("test")

    self.MapSafezones[id] = nil

    self:UpdateAdminEyes("Safezones")
    self:SaveSafezonesData()
    self:SpawnMapSafezones()
end

function GM:ClearSafezones()
    table.Empty(self.MapSafezones)
    if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt", "DATA") then
        file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/safezones.txt")
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
        local safezone = ents.Create("tea_safezone")
        safezone.min = v.AreaMin
        safezone.max = v.AreaMax
        safezone.ID = id
        safezone:SetPos((v.AreaMin + v.AreaMax) / 2)
        safezone:Spawn()
    end
    self:UpdateAdminEyes("Safezones")
end

function GM:UpdateSafezones()
    for _, ent in ipairs(ents.FindByClass("tea_safezone")) do
    	if !ent.ID then print(ent, "has invalid ID, wtf!!!") continue end
        local data = self.MapSafezones[ent.ID]
        if !data then ent:Remove() continue end

        ent.min = data.AreaMin
        ent.max = data.AreaMax
        ent:SetPos((data.AreaMin + data.AreaMax) / 2)

    	local w = ent.max.x - ent.min.x
    	local l = ent.max.y - ent.min.y
    	local h = ent.max.z - ent.min.z

    	local min = Vector(-(w/2), -(l/2), -(h/2))
    	local max = Vector(w/2, l/2, h/2)
        ent:SetCollisionBounds(min, max)
    end

    self:UpdateAdminEyes("Safezones")
end
