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

	ply:SendNetworkEvent("tea_plyevent_vaultupdate")
end
concommand.Add("refresh_vault", function(ply)
	gamemode.Call("SendVault", ply)
end)

function GM:CalculateRemainingVaultWeight(ply, weight)
	return math.Round(-self.Config["VaultSize"] + self:CalculateVaultWeight(ply) + tonumber(weight), 2)
end



function GM:AddToVault(ply, str, amt)
	if !ply:IsValid() then return end
	if !self.ItemsList[str] then return end
	if timer.Exists("Isplyequippingarmor"..ply:EntIndex().."_"..str) then print(ply:Nick().." tried to place item into vault while equipping armor!") ply:SystemMessage("Just NO", Color(255,155,155,255), true) return false end
	amt = math.floor(amt or 1)

	local item = self.ItemsList[str]
	local weight = item.Weight * amt
	if (self:CalculateVaultWeight(ply) + weight) > self.Config["VaultSize"] then
		ply:SystemMessage(translate.ClientFormat(ply, "notenoughspacevault", self.Config["VaultSize"], gamemode.Call("CalculateRemainingVaultWeight", ply, weight)), Color(255,205,205,255), true)
		return false
	end

	if ply.Vault[str] then
		ply.Vault[str] = ply.Vault[str] + amt
	else 
		ply.Vault[str] = amt
	end

	if item["IsGrenade"] then
		self:SystemRemoveItem(ply, str, false, amt)
	else
		self:SystemRemoveItem(ply, str, true, amt)
	end
end

function GM:WithdrawFromVault(ply, str, amt)
	if !ply:IsValid() then return end
	if !self.ItemsList[str] then return end
	if !ply.Vault[str] then return end
	amt = math.floor(amt or 1)
	
	local item = self.ItemsList[str]
	local weight = item.Weight * amt
/*
	if ((ply:CalculateWeight() + weight) > (ply:CalculateMaxWeight())) then
		ply:SystemMessage(Format("You don't have enough space for that! Need %skg more space!", gamemode.Call("CalculateRemainingInventoryWeight", ply, weight)), Color(255,205,205,255), true)
		return false
	end
*/
	ply.Vault[str] = ply.Vault[str] - amt
	if ply.Vault[str] <= 0 then ply.Vault[str] = nil end

	gamemode.Call("SystemGiveItem", ply, str, amt)
end


net.Receive("AddVault", function(length, ply)
	local str = net.ReadString()
	local amt = net.ReadUInt(32)

	if !ply:IsValid() or !ply:Alive() then return false end
	if !ply.Inventory[str] then ply:SystemMessage("You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist
	GAMEMODE:AddToVault(ply, str, amt)

	if ply.EquippedArmor == str then
		UseFunc_RemoveArmor(ply, str)
	end
	gamemode.Call("SendInventory", ply)
	ply:EmitSound("items/ammocrate_open.wav", 100, 100)
end)


net.Receive("WithdrawVault", function(length, ply)
	local str = net.ReadString()
	local amt = net.ReadUInt(32)

	if !ply:IsValid() or !ply:Alive() then return false end
	if !ply.Vault[str] then ply:SystemMessage("You don't have one of those!", Color(255,205,205,255), true) return false end
	if !GAMEMODE.ItemsList[str] then return false end -- if the item doesnt exist

	local item = GAMEMODE.ItemsList[str]
	GAMEMODE:WithdrawFromVault(ply, str, amt)
	GAMEMODE:SendInventory(ply)
	ply:EmitSound("items/ammocrate_open.wav", 100, 100)
end)

