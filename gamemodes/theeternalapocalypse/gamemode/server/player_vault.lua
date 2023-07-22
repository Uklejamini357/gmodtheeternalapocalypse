function tea_CalculateVaultWeight(ply)
	local totalweight = 0
	for k, v in pairs(ply.Vault) do
		local ref = GAMEMODE.ItemsList[k]
		totalweight = totalweight + (ref.Weight * v)
	end
	return totalweight
end


function tea_SendVault(ply)
	if !ply:IsValid() then return end
	net.Start("UpdateVault")
	net.WriteTable(ply.Vault)
	net.Send(ply)
end
concommand.Add("refresh_vault", tea_SendVault)


function tea_LoadPlayerVault(ply)
	local LoadedData
	if GAMEMODE.Config["FileSystem"] == "Legacy" then
		if file.Exists(GAMEMODE.DataFolder.."/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), "DATA" ) then
			LoadedData = file.Read(GAMEMODE.DataFolder.."/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), "DATA" )
		end
	elseif GAMEMODE.Config["FileSystem"] == "PData" then
		LoadedData = ply:GetPData("ate_playervault")
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end

	if LoadedData then 
		local formatted = util.JSONToTable(LoadedData)
		ply.Vault = formatted
	else
		ply.Vault = table.Copy(GAMEMODE.Config["RookieVault"])
	end

	timer.Simple(1, function() tea_SendVault(ply) end)
	timer.Simple(2, function() tea_SavePlayerVault(ply) end)
end


function tea_SavePlayerVault(ply)
	local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
	if !ply.AllowSave and tea_server_dbsaving:GetInt() < 1 then return end

	if GAMEMODE.Config["FileSystem"] == "Legacy" then
		local data = util.TableToJSON(ply.Vault)
		file.Write(GAMEMODE.DataFolder.."/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), data )
	elseif GAMEMODE.Config["FileSystem" ] == "PData" then
		local formatted = util.TableToJSON(ply.Vault)
		ply:SetPData("ate_playervault", formatted)
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
	print("✓ ".. ply:Nick() .." vault saved into database")
end


function tea_AddToVault(ply, str)
	if !ply:IsValid() then return end
	if !GAMEMODE.ItemsList[str] then return end
	if timer.Exists("Isplyequippingarmor"..ply:UniqueID().."_"..str) then print(ply:Nick().." tried to place item into vault while equipping armor!") SystemMessage(ply, "Just NO", Color(255,155,155,255), true) return false end

	local item = GAMEMODE.ItemsList[str]
	if (tea_CalculateVaultWeight(ply) + item["Weight"]) > GAMEMODE.Config["VaultSize"] then SystemMessage(ply, translate.ClientFormat(ply, "notenoughspacevault", GAMEMODE.Config["VaultSize"], -GAMEMODE.Config["VaultSize"] + tea_CalculateVaultWeight(ply) + item["Weight"]), Color(255,205,205,255), true) return false end

	if ply.Vault[str] then
		ply.Vault[str] = ply.Vault[str] + 1
	else 
		ply.Vault[str] = 1
	end

	if GAMEMODE.ItemsList[str]["IsGrenade"] then
		tea_SystemRemoveItem(ply, str, false)
	else
		tea_SystemRemoveItem(ply, str, true)
	end
end

function tea_WithdrawFromVault(ply, str)
	if !ply:IsValid() then return end
	if !GAMEMODE.ItemsList[str] then return end
	if !ply.Vault[str] then return end
	local item = GAMEMODE.ItemsList[str]

	if ((tea_CalculateWeight(ply) + item["Weight"]) > (tea_CalculateMaxWeight(ply))) then SystemMessage(ply, "You don't have enough space for that! Need "..-tea_CalculateMaxWeight(ply) + tea_CalculateWeight(ply) + item["Weight"].."kg more space!", Color(255,205,205,255), true) return false end

	ply.Vault[str] = ply.Vault[str] - 1
	if ply.Vault[str] < 1 then ply.Vault[str] = nil end

	tea_SystemGiveItem(ply, str)
end


net.Receive("AddVault", function(length, client)
	local str = net.ReadString()
	if !client:IsValid() or !client:Alive() then return false end
	if !client.Inventory[str] then SystemMessage(client, "You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist
	tea_AddToVault(client, str)

	if client.EquippedArmor == str then
		UseFunc_RemoveArmor(client, str)
	end
	tea_SendInventory(client)
	client:EmitSound("items/ammocrate_open.wav", 100, 100)
end)


net.Receive("WithdrawVault", function(length, client)
	local str = net.ReadString()
	if !client:IsValid() or !client:Alive() then return false end
	if !client.Vault[str] then SystemMessage(client, "You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist

	local item = GAMEMODE.ItemsList[str]
	tea_WithdrawFromVault(client, str)
	tea_SendInventory(client)
	client:EmitSound("items/ammocrate_open.wav", 100, 100)
end)
