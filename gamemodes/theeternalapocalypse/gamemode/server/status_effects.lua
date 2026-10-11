local entMeta = FindMetaTable("Entity")
local plyMeta = FindMetaTable("Entity")
if not (entMeta and plyMeta) then return end

local m_StatusValidEntities = {}
hook.Add("OnReloaded", "refreshEntStatuses", function()
    for _,ent in ents.Iterator() do
        if !IsValid(ent) then continue end
        if not ent.StatusEffects then continue end

        m_StatusValidEntities[ent] = ent.StatusEffects
    end
end)

local nextTick = CurTime()+1
hook.Add("Tick", "processEntStatuses", function()
    local a,b = pairs(m_StatusValidEntities)
    for ent,status in a,b do
        for id,effect in pairs(status) do
            effect.Table.Think(ent)
        end
    end

    if nextTick > CurTime() then return end
    nextTick = CurTime() + 1

    for ent,status in a,b do
        for id,effect in pairs(status) do
            effect.Table.Tick(ent)
        end
    end
end)

function entMeta:GiveStatusEffect(id, duration, add, addTbl)
    local gm_StatusEffects = GAMEMODE.StatusEffectsTable[id]
    if !gm_StatusEffects then return end
    if !self.StatusEffects then return end

    local presentStatus = self.StatusEffects[id]
    local time = CurTime()

    
    local addTime = add and (self:GetStatusDuration(id) + duration) or duration
    if duration ~= 0 then
        if presentStatus then
            if presentStatus.End > CurTime() + addTime then return
            else
                self.StatusEffects[id].End = time + addTime
            end
        else
            self.StatusEffects[id] = {
                End = time + addTime
            }
        end
    end

    if self.StatusEffects[id] and not self.StatusEffects[id].Table then
        self.StatusEffects[id].Table = gm_StatusEffects
    end

    if addTbl then
        table.Merge(self.StatusEffects[id], addTbl)
    end

    if presentStatus then return end

    if gm_StatusEffects.OnGet then
        gm_StatusEffects.OnGet(self, duration)
    end

    net.Start("tea_statusget")
    net.WriteEntity(self)
    net.WriteString(id)
    net.WriteFloat(addTime)
    net.WriteTable(addTbl)
    net.SendPVS(self:GetPos())
end

function entMeta:RemoveStatusEffect(id)
    local gm_StatusEffects = GAMEMODE.StatusEffectsTable[id]
    if !gm_StatusEffects then return end

    local presentStatus = self.StatusEffects[id]
    if !presentStatus then return end

    self.StatusEffects[id] = nil

    if gm_StatusEffects.OnRemove then
        gm_StatusEffects.OnRemove(self)
    end
end

function entMeta:GetStatusEffect(id)
    return self.StatusEffects[id]
end

function entMeta:GetStatusDuration(id, precise)
    if not self.StatusEffects[id] then return 0 end

    if precise then
        return self.StatusEffects[id].End - CurTime()
    end

    return math.ceil(self.StatusEffects[id].End - CurTime())
end

