ENT.Base = "base_brush"
ENT.Type = "brush"


function ENT:Initialize()
	local w = self.max.x - self.min.x
	local l = self.max.y - self.min.y
	local h = self.max.z - self.min.z

	local min = Vector(-(w/2), -(l/2), -(h/2))
	local max = Vector(w/2, l/2, h/2)

	self:DrawShadow(false)
	self:SetCollisionBounds(min, max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end


function ENT:StartTouch(ent)
	if not ent:IsPlayer() then
		if (ent:IsNPC() or ent:IsNextBot()) and ent.IsZombie then
			if GAMEMODE.SafezoneZombiesAction == 1 then
				local tbl = {}
				for _,v in pairs(GAMEMODE.ZombieSpawnpoints) do
					tbl[#tbl+1] = v[1]
				end

				table.sort(tbl, function(a,b) return (a-ent:GetPos()):Length() < (b-ent:GetPos()):Length() end)

				ent:SetPos(tbl[1])
			elseif GAMEMODE.SafezoneZombiesAction == 2 then
				ent:Remove()
			end
		end

		return
	end
	if !ent:Alive() then return end

	ent.InsideSafeZones = ent.InsideSafeZones or {}
	table.insert(ent.InsideSafeZones, self)
	if table.Count(ent.InsideSafeZones) == 1 then
		gamemode.Call("OnSafezoneEnter", ent, self)
	end
end

function ENT:EndTouch(ent)
	if not ent:IsPlayer() then return end

	ent.InsideSafeZones = ent.InsideSafeZones or {}
	table.RemoveByValue(ent.InsideSafeZones, self)
	if table.Count(ent.InsideSafeZones) == 0 then
		gamemode.Call("OnSafezoneLeave", ent, self)
	end
end
