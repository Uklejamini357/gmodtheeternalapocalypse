--Crafting system is in progress
--So hard that i have to delay this to other version.

RequiredItems = {}
/*
net.Receive("CraftItem", function(length, client)
	local str = net.ReadString()
	if !CraftableList[str] then return false end
	if client:IsValid() and client:Alive() then
		TEACraftItem(client, str)
	end
end)

function TEACraftItem(ply, str)
	if !CraftableList[str] then return false end
	for k,v in pairs(CraftableList[str]["Requirements"]) do
		print(ply.Inventory[k], v, k)
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then
			SendChat(ply, "You don't have the required items to craft this!") continue
		elseif ply.Inventory[k] > v then
			ply.Inventory[k] = ply.Inventory[k] - v
		elseif ply.Inventory[k] == v then
			ply.Inventory[k] = nil
		end
	end
end

net.Receive("CraftSpecialItem", function(length, client)
	local str = net.ReadString()
	if !CraftableSpecialList[str] then return false end
	if client:IsValid() and client:Alive() and client:IsPvPGuarded() then
		TEACraftSpecialItem(client, str)
	end
end)

function TEACraftSpecialItem(ply, str)
	if !CraftableSpecialList[str] then return false end
	for k,v in pairs(CraftableSpecialList[str]["Requirements"]) do
		print(ply.Inventory[k], v, k)
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then
			SendChat(ply, "You don't have the required items to craft this!") return
		elseif ply.Inventory[k] > v then
			ply.Inventory[k] = ply.Inventory[k] - v
		elseif ply.Inventory[k] == v then
			ply.Inventory[k] = nil
		end
	end
	
end
*/