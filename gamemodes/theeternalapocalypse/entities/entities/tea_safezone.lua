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

				for i=1,#tbl do
					local allow = true
					for _,v in ipairs(ents.FindInSphere(tbl[i], 200)) do
						if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then allow = false break end
					end
					if !allow then continue end

					ent:SetPos(tbl[i])
					break
				end
			elseif GAMEMODE.SafezoneZombiesAction == 2 or GAMEMODE.SafezoneZombiesAction == 3 then
				if GAMEMODE.SafezoneZombiesAction == 2 or ent.BossMonster then
					for k,v in RandomPairs(GAMEMODE.ZombieSpawnpoints) do
						local allow = true
						for _,v in ipairs(ents.FindInSphere(v[1], 200)) do
							if v:IsNextBot() or v:IsNPC() or v:IsPlayer() then allow = false break end
						end
						if !allow then continue end

						ent:SetPos(v[1])
						break
					end
				else
					ent:Remove()
				end
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

-- fucking EndTouch don't work if safezone gets removed
function ENT:OnRemove()
	for _,ply in player.Iterator() do
		ply.InsideSafeZones = ply.InsideSafeZones or {}
		table.RemoveByValue(ply.InsideSafeZones, self)
		if table.Count(ply.InsideSafeZones) == 0 then
			gamemode.Call("OnSafezoneLeave", ply, self)
		end
	end
end
