--Crafting system is finally (semi-)implemented (BETA, EXPECT BUGS)


net.Receive("CraftItem", function(length, client)
	local str = net.ReadString()
	if !GAMEMODE.CraftableList[str] then return false end
	if client:IsValid() and client:Alive() then
		tea_CraftItem(client, str)
	end
end)

function tea_CraftItem(ply, str)
	if !GAMEMODE.CraftableList[str] then return false end
	if timer.Exists("ItemCrafting_"..ply:EntIndex()) then return false end
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)
	end

	for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
		elseif ply.Inventory[k] >= v then
			table.insert(HaveItems, v, k)
		end
	end

	RequiredItems = table.ToString(RequiredItems)
	HaveItems = table.ToString(HaveItems)

	if HaveItems == RequiredItems then
		local crafttime = tonumber(GAMEMODE.CraftableList[str]["CraftTime"])
		SendUseDelay(ply, crafttime)
		timer.Create("ItemCrafting_"..ply:EntIndex(), crafttime, 1, function()
			for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
				if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
				elseif ply.Inventory[k] > v then
					ply.Inventory[k] = ply.Inventory[k] - v
				elseif ply.Inventory[k] == v then
					ply.Inventory[k] = nil
				end
			end

			local xp = Payout(ply, tonumber(GAMEMODE.CraftableList[str]["XP"]), 0)
			tea_SystemGiveItem_NoWeight(ply, str, qty)
			ply:EmitSound("items/itempickup.wav")

			tea_SendInventory(ply)
			SendChat(ply, "Successfully crafted an item! Gained "..xp.." XP")
		end)
	else
		SystemMessage(ply, "You don't have the required items to craft this!", Color(255,205,205), true)
		SystemMessage(ply, "You need:", Color(255,205,205), false)
		for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
			SystemMessage(ply, "	"..v.."x "..translate.Get(k.."_n"), Color(255,230,230), false)
		end
	end
end

net.Receive("CraftSpecialItem", function(length, client)
	local str = net.ReadString()
	if !GAMEMODE.CraftableSpecialList[str] then return false end
	if client:IsValid() and client:Alive() and client:IsPvPGuarded() then
		tea_CraftSpecialItem(client, str)
	end
end)

function tea_CraftSpecialItem(ply, str)
	if !GAMEMODE.CraftableSpecialList[str] then return false end
	if timer.Exists("ItemCrafting_"..ply:EntIndex()) then return false end
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(GAMEMODE.CraftableSpecialList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)
	end

	for k,v in pairs(GAMEMODE.CraftableSpecialList[str]["Requirements"]) do
		if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
		elseif ply.Inventory[k] > v then
			table.insert(HaveItems, v, k)
		elseif ply.Inventory[k] == v then
			table.insert(HaveItems, v, k)
		end
	end

	RequiredItems = table.ToString(RequiredItems)
	HaveItems = table.ToString(HaveItems)

	if HaveItems == RequiredItems then
		local crafttime = tonumber(GAMEMODE.CraftableSpecialList[str]["CraftTime"])
		SendUseDelay(ply, crafttime)
		timer.Create("ItemCrafting_"..ply:EntIndex(), crafttime, 1, function()
			for k,v in pairs(GAMEMODE.CraftableSpecialList[str]["Requirements"]) do
				if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
				elseif ply.Inventory[k] > v then
					ply.Inventory[k] = ply.Inventory[k] - v
				elseif ply.Inventory[k] == v then
					ply.Inventory[k] = nil
				end
			end

			local xp = Payout(ply, tonumber(GAMEMODE.CraftableSpecialList[str]["XP"]), 0)
			tea_SystemGiveItem_NoWeight(ply, str, qty)
			ply:EmitSound("items/itempickup.wav")

			tea_SendInventory(ply)
			SendChat(ply, "Successfully crafted an item! Gained "..xp.." XP")
		end)
	else
		SystemMessage(ply, "You don't have the required items to craft this!", Color(255,205,205), true)
		SystemMessage(ply, "You need:", Color(255,205,205), false)
		for k,v in pairs(GAMEMODE.CraftableSpecialList[str]["Requirements"]) do
			SystemMessage(ply, "	"..v.."x "..translate.Get(k.."_n"), Color(255,230,230), false)
		end
	end
end

