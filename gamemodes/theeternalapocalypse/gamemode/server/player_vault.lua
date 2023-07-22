function GM:CalculateVaultWeight(ply)
	local totalweight = 0
	for k, v in pairs(ply.Vault) do
		local ref = self.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
	return totalweight
end


function GM:SendVault(ply)
	if !ply:IsValid() then return end
	net.Start("UpdateVault")
	net.WriteTable(ply.Vault)
	net.Send(ply)
end
concommand.Add("refresh_vault", function(ply)
	gamemode.Call("SendVault", ply)
end)

function GM:CalculateRemainingVaultWeight(ply, weight)
	return math.Round(-self.Config["VaultSize"] + self:CalculateVaultWeight(ply) + tonumber(weight), 2)
end


function GM:LoadPlayerVault(ply)
	local LoadedData
	if self.Config["FileSystem"] == "Legacy" then
		if file.Exists(self.DataFolder.."/players/".. string.lower(string.gsub( ply:SteamID(), ":", "_").."/vault.txt"), "DATA") then
			LoadedData = file.Read(self.DataFolder.."/players/".. string.lower(string.gsub( ply:SteamID(), ":", "_").."/vault.txt"), "DATA")
		end
	elseif self.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("ate_playervault")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)
		ply.Vault = formatted
	else
		ply.Vault = table.Copy(self.Config["NewbieVault"])
	end

	timer.Simple(1, function() gamemode.Call("SendVault", ply) end)
	timer.Simple(2, function() gamemode.Call("SavePlayerVault", ply) end)
end


function GM:SavePlayerVault(ply)
	if !ply.AllowSave and not self.DatabaseSaving then return end

	if self.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Vault)
		file.Write(self.DataFolder.."/players/"..string.lower(string.gsub(ply:SteamID(), ":", "_").."/vault.txt"), data)
	elseif self.Config["FileSystem"] == "PData" then
		local formatted = util.TableToJSON(ply.Vault)
		ply:SetPData("ate_playervault", formatted)
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
	print("✓ ".. ply:Nick() .." vault saved into database")
end


function GM:AddToVault(ply, str)
	if !ply:IsValid() then return end
	if !self.ItemsList[str] then return end
	if timer.Exists("Isplyequippingarmor"..ply:EntIndex().."_"..str) then print(ply:Nick().." tried to place item into vault while equipping armor!") ply:SystemMessage("Just NO", Color(255,155,155,255), true) return false end

	local item = self.ItemsList[str]
	if (self:CalculateVaultWeight(ply) + item["Weight"]) > self.Config["VaultSize"] then
		ply:SystemMessage(translate.ClientFormat(ply, "notenoughspacevault", self.Config["VaultSize"], gamemode.Call("CalculateRemainingVaultWeight", ply, item["Weight"])), Color(255,205,205,255), true)
		return false
	end

	if ply.Vault[str] then
		ply.Vault[str] = ply.Vault[str] + 1
	else 
		ply.Vault[str] = 1
	end

	if item["IsGrenade"] then
		self:SystemRemoveItem(ply, str, false)
	else
		self:SystemRemoveItem(ply, str, true)
	end
end

function GM:WithdrawFromVault(ply, str)
	if !ply:IsValid() then return end
	if !self.ItemsList[str] then return end
	if !ply.Vault[str] then return end
	local item = self.ItemsList[str]

	if ((self:CalculateWeight(ply) + item["Weight"]) > (self:CalculateMaxWeight(ply))) then
		ply:SystemMessage(Format("You don't have enough space for that! Need %skg more space!", gamemode.Call("CalculateRemainingInventoryWeight", ply, item["Weight"])), Color(255,205,205,255), true)
		return false
	end

	ply.Vault[str] = ply.Vault[str] - 1
	if ply.Vault[str] < 1 then ply.Vault[str] = nil end

	gamemode.Call("SystemGiveItem", ply, str)
end


net.Receive("AddVault", function(length, client)
	local str = net.ReadString()
	if !client:IsValid() or !client:Alive() then return false end
	if !client.Inventory[str] then client:SystemMessage("You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist
	GAMEMODE:AddToVault(client, str)

	if client.EquippedArmor == str then
		UseFunc_RemoveArmor(client, str)
	end
	gamemode.Call("SendInventory", client)
	client:EmitSound("items/ammocrate_open.wav", 100, 100)
end)


net.Receive("WithdrawVault", function(length, client)
	local str = net.ReadString()
	if !client:IsValid() or !client:Alive() then return false end
	if !client.Vault[str] then client:SystemMessage("You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist

	local item = GAMEMODE.ItemsList[str]
	GAMEMODE:WithdrawFromVault(client, str)
	GAMEMODE:SendInventory(client)
	client:EmitSound("items/ammocrate_open.wav", 100, 100)
end)

