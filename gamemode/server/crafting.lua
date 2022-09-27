--Crafting system is finally (semi-)implemented (BETA, EXPECT BUGS)


net.Receive("CraftItem", function(length, client)
	local str = net.ReadString()
	if !CraftableList[str] then return false end
	if client:IsValid() and client:Alive() then
		TEACraftItem(client, str)
	end
end)

function TEACraftItem(ply, str)
	if !CraftableList[str] then return false end
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(CraftableList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)
	end

	for k,v in pairs(CraftableList[str]["Requirements"]) do
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
		elseif ply.Inventory[k] > v then
			table.insert(HaveItems, v, k)
		elseif ply.Inventory[k] == v then
			table.insert(HaveItems, v, k)
		end
	end

	if table.concat(HaveItems," ") == table.concat(RequiredItems," ") then
		for k,v in pairs(CraftableList[str]["Requirements"]) do
			if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
			elseif ply.Inventory[k] > v then
				ply.Inventory[k] = ply.Inventory[k] - v
			elseif ply.Inventory[k] == v then
				ply.Inventory = nil
			end
		end
		SystemGiveItem(ply, str, 1)
		SendInventory(ply)
		SendChat(ply, "Successfully crafted an item!")
	else
		SendChat(ply, "You don't have the required items to craft this!")
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
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(CraftableSpecialList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)
	end

	for k,v in pairs(CraftableSpecialList[str]["Requirements"]) do
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
		elseif ply.Inventory[k] > v then
			table.insert(HaveItems, v, k)
		elseif ply.Inventory[k] == v then
			table.insert(HaveItems, v, k)
		end
	end

	if table.concat(HaveItems," ") == table.concat(RequiredItems," ") then
		for k,v in pairs(CraftableSpecialList[str]["Requirements"]) do
			if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
			elseif ply.Inventory[k] > v then
				ply.Inventory[k] = ply.Inventory[k] - v
			elseif ply.Inventory[k] == v then
				ply.Inventory = nil
			end
		end
		SystemGiveItem(ply, str, 1)
		SendInventory(ply)
		SendChat(ply, "Successfully crafted an item!")
	else
		SendChat(ply, "You don't have the required items to craft this!")
	end
end

