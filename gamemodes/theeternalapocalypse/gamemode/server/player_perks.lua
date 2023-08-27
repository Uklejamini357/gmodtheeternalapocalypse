local meta = FindMetaTable("Player")

function meta:HasPerk(perk)
    return self.UnlockedPerks[perk]
end

function GM:LoadPlayerPerks(ply)
	if !ply:IsValid() or !ply:IsPlayer() then Error("The Eternal Apocalypse: Tried to load a player perks file that doesn't exist!") return end
	ply.UnlockedPerks = {}

	local LoadedData
	if self.Config["FileSystem"] == "Legacy" then
		if (file.Exists(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/perks.txt", "DATA")) then
			LoadedData = file.Read(self.DataFolder.."/players/"..string.lower(string.gsub( ply:SteamID(), ":", "_").."/perks.txt"), "DATA")
		end
	elseif self.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("tea_playerperks")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)

        if self:GetDebug() >= DEBUGGING_ADVANCED then
			print("Loading perks:\n\n")
			PrintTable(formatted)
		end
		ply.UnlockedPerks = formatted
	end
end


function GM:SavePlayerPerks(ply)
	if !ply:IsValid() then return end
	if !ply.AllowSave and not self.DatabaseSaving then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.UnlockedPerks)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_")).."/perks.txt", data)
        if self:GetDebug() >= DEBUGGING_NORMAL then
            print(Format("✓ %s perks saved", ply:Nick()))
        end
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.UnlockedPerks)
		ply:SetPData("tea_playerperks", formatted)
        if self:GetDebug() >= DEBUGGING_NORMAL then
            print(Format("✓ %s perks saved", ply:Nick()))
        end
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
end

