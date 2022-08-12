function CalculateVaultWeight(ply)
local totalweight = 0
	for k, v in pairs(ply.Vault) do
	local ref = ItemsList[k]
	totalweight = totalweight + (ref.Weight * v)
	end
return totalweight
end


function SendVault( ply )
	if !ply:IsValid() then return end
	net.Start("UpdateVault")
	net.WriteTable(ply.Vault)
	net.Send(ply)
end
concommand.Add("refresh_vault", SendVault)


function LoadPlayerVault( ply )

local LoadedData
if Config[ "FileSystem" ] == "Legacy" then

	if file.Exists( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), "DATA" ) then
		LoadedData = file.Read( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), "DATA" )
	end

elseif Config[ "FileSystem" ] == "PData" then
		LoadedData = ply:GetPData( "ate_playervault" )
else
	print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
end

if LoadedData then 
	local formatted = util.JSONToTable( LoadedData )
	ply.Vault = formatted
else
	ply.Vault = table.Copy( Config[ "RookieVault" ] )
end

timer.Simple( 1, function() SendVault(ply) end )
timer.Simple( 2, function() SavePlayerVault(ply) end )

end



function SavePlayerVault( ply )
local tea_server_dbsaving = GetConVar("tea_server_dbsaving")
if AllowSave != 1 and tea_server_dbsaving:GetInt() < 1 then return end

	if Config[ "FileSystem" ] == "Legacy" then
		local data = util.TableToJSON(ply.Vault)
		file.Write( "theeternalapocalypse/players/" .. string.lower(string.gsub( ply:SteamID(), ":", "_" ) .. "/vault.txt"), data )
	elseif Config[ "FileSystem" ] == "PData" then
		local formatted = util.TableToJSON( ply.Vault )
		ply:SetPData( "ate_playervault", formatted )
	else
		print("Bruh, did you try to setup incorrectly? Set your damned filesystem option to a proper setting in sh_config.lua")
	end
	print("✓ ".. ply:Nick() .." vault saved into database")
end


function AddToVault( ply, str )
if !ply:IsValid() then return end
if !ItemsList[str] then return end
if timer.Exists("Isplyequippingarmor"..ply:UniqueID().."_"..str) then print(ply:Nick().." tried to place item into vault while equipping armor!") SystemMessage(ply, "Bruh, did you just try to place armor that you're currently equipping into vault? You lil' bitch, play the gamemode like it was meant to be played.", Color(255,155,155,255), true) return false end

local item = ItemsList[str]
if (CalculateVaultWeight(ply) + item["Weight"]) > Config[ "VaultSize" ] then SystemMessage(ply, "Your vault doesn't have enough space for that! It can only hold "..Config[ "VaultSize" ].."kg of items! (Need "..-Config["VaultSize"] + CalculateVaultWeight(ply) + item["Weight"].."kg more space!)", Color(255,205,205,255), true) return false end

	if ply.Vault[str] then
		ply.Vault[str] = ply.Vault[str] + 1
	else 
		ply.Vault[str] = 1
	end

	SystemRemoveItem( ply, str, true )
end

function WithdrawFromVault( ply, str )
if !ply:IsValid() then return end
if !ItemsList[str] then return end
if !ply.Vault[str] then return end

local item = ItemsList[str]

if ((CalculateWeight(ply) + item["Weight"]) > (CalculateMaxWeight(ply))) then SystemMessage(ply, "You don't have enough space for that! Need "..-CalculateMaxWeight(ply) + CalculateWeight(ply) + item["Weight"].."kg more space!", Color(255,205,205,255), true) return false end


ply.Vault[str] = ply.Vault[str] - 1
if ply.Vault[str] < 1 then ply.Vault[str] = nil end

SystemGiveItem( ply, str )

end


net.Receive( "AddVault", function( length, client )
local str = net.ReadString()


if !client:IsValid() or !client:Alive() then return false end
if !client.Inventory[str] then SystemMessage(client, "You don't have one of those!", Color(255,205,205,255), true) return false end
if !ItemsList[str] then return false end -- if the item doesnt exist

AddToVault( client, str )

if client.EquippedArmor == str then
	UseFunc_RemoveArmor(client, str)
end

SendInventory(client)
client:EmitSound("items/ammocrate_open.wav", 100, 100)

end)


net.Receive( "WithdrawVault", function( length, client )
local str = net.ReadString()


if !client:IsValid() or !client:Alive() then return false end
if !client.Vault[str] then SystemMessage(client, "You don't have one of those!", Color(255,205,205,255), true) return false end
if !ItemsList[str] then return false end -- if the item doesnt exist

local item = ItemsList[str]

WithdrawFromVault( client, str )

SendInventory(client)
client:EmitSound("items/ammocrate_open.wav", 100, 100)

end)