local meta = FindMetaTable("Player")

-- 0 = no pvp guard, 1 = pvp guarded, 2 = pvp forced
function meta:SetPvPGuarded(int)
	if !SERVER then return end
	self:SetNWInt("PvPGuard", math.Clamp(int, 0, 2) )
end

function meta:IsPvPGuarded()
	if self:GetNWInt("PvPGuard") == 1 then return true
	else return false end
end

function meta:IsPvPForced()
	if self:GetNWInt("PvPGuard") == 2 then return true
	else return false end
end

function meta:SlowPlayerDown(value, time)

	self.SlowDown = math.max(value, self.SlowDown)

	gamemode.Call("RecalcPlayerSpeed", self)
	timer.Create("tea_SLOWDOWN_"..self:EntIndex(), time, 1, function()
		if !self:IsValid() then return end
		self.SlowDown = 0
		gamemode.Call("RecalcPlayerSpeed", self)
	end)
end

function meta:SendChat(msg)
	if self == NULL then return end -- ?????
	if !SERVER or !self:IsPlayer() then return end
	self:PrintMessage(3, msg)
end

function meta:SystemMessage(msg, color, sys)
	net.Start("SystemMessage")
	net.WriteString(msg)
	net.WriteColor(color or Color(255,255,255))
	net.WriteBool(sys or false)
	net.Send(self)
end

-- not working for client yet!!
function meta:IsNewbie()
	return SERVER and tonumber(self:GetTEALevel()) < 10 and tonumber(self:GetTEAPrestige()) < 1
end

function meta:AddInfection(inf)
	self.Infection = math.Clamp((self.Infection or 0) + (inf * (1 - (self.StatImmunity or 0) * 0.03)), 0, 10000)
end

function meta:GetTEALevel()
	return self.Level or self:GetNWInt("PlyLevel", 1)
end

function meta:GetTEAPrestige()
	return self.Prestige or self:GetNWInt("PlyPrestige", 0)
end

function meta:GetMaxLevel()
	return math.min(100, GAMEMODE.MaxLevel + (self:GetTEAPrestige() * GAMEMODE.LevelsPerPrestige))
end

-- maybe i should also do it for entity meta table
local meta_entity = FindMetaTable("Entity")

function meta_entity:SetEliteVariant(value)
	self:SetNWInt("TEA_ELITE_VARIANT", value)
end

function meta_entity:GetEliteVariant()
	return self:GetNWInt("TEA_ELITE_VARIANT", 0)
end
