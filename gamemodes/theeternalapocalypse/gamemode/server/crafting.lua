--Crafting system is finally (semi-)implemented (BETA, EXPECT BUGS)


net.Receive("CraftItem", function(length, client)
	local str = net.ReadString()
	if !GAMEMODE.CraftableList[str] then return false end
	if client:IsValid() and client:Alive() then
		gamemode.Call("CraftItem", client, str)
	end
end)

function GM:CraftItem(ply, str)
	if !self.CraftableList[str] then return false end
	if timer.Exists("ItemCrafting_"..ply:EntIndex()) then return false end
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(self.CraftableList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)

		if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
		elseif ply.Inventory[k] >= v then
			table.insert(HaveItems, v, k)
		end
	end

	RequiredItems = table.ToString(RequiredItems)
	HaveItems = table.ToString(HaveItems)

	if HaveItems == RequiredItems then
		local crafttime = tonumber(self.CraftableList[str]["CraftTime"])
		ply:SendUseDelay(crafttime)
		timer.Create("ItemCrafting_"..ply:EntIndex(), crafttime, 1, function()
			if not ply:Alive() then return end
			for k,v in pairs(self.CraftableList[str]["Requirements"]) do
				if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
				elseif ply.Inventory[k] > v then
					ply.Inventory[k] = ply.Inventory[k] - v
				elseif ply.Inventory[k] == v then
					ply.Inventory[k] = nil
				end
			end

			local xp = gamemode.Call("Payout", ply, tonumber(self.CraftableList[str]["XP"]), 0)
			gamemode.Call("SystemGiveItem", ply, str, qty)
			ply:EmitSound("items/itempickup.wav")

			gamemode.Call("SendInventory", ply)
			ply:SendChat("Successfully crafted an item! Gained "..xp.." XP")
		end)
	else
		ply:SystemMessage("You don't have the required items to craft this!", Color(255,205,205), true)
		ply:SystemMessage("You need:", Color(255,205,205), false)
		for k,v in pairs(self.CraftableList[str]["Requirements"]) do
			ply:SystemMessage("	"..v.."x "..translate.Get(k.."_n"), Color(255,230,230), false)
		end
	end
end

net.Receive("CraftSpecialItem", function(length, client)
	local str = net.ReadString()
	if !GAMEMODE.CraftableSpecialList[str] then return false end
	if client:IsValid() and client:Alive() and client:IsPvPGuarded() then
		gamemode.Call("CraftSpecialItem", client, str)
	end
end)

function GM:CraftSpecialItem(ply, str)
	if !self.CraftableSpecialList[str] then return false end
	if timer.Exists("ItemCrafting_"..ply:EntIndex()) then return false end
	local RequiredItems = {}
	local HaveItems = {}
	for k,v in pairs(self.CraftableSpecialList[str]["Requirements"]) do
		table.insert(RequiredItems, v, k)

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
		local crafttime = tonumber(self.CraftableSpecialList[str]["CraftTime"])
		ply:SendUseDelay(crafttime)
		timer.Create("ItemCrafting_"..ply:EntIndex(), crafttime, 1, function()
			if not ply:Alive() then return end
			for k,v in pairs(self.CraftableSpecialList[str]["Requirements"]) do
				if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
				elseif ply.Inventory[k] > v then
					ply.Inventory[k] = ply.Inventory[k] - v
				elseif ply.Inventory[k] == v then
					ply.Inventory[k] = nil
				end
			end

			local xp = Payout(ply, tonumber(self.CraftableSpecialList[str]["XP"]), 0)
			gamemode.Call("SystemGiveItem", ply, str, qty)
			ply:EmitSound("items/itempickup.wav")

			gamemode.Call("SendInventory", ply)
			ply:SendChat("Successfully crafted an item! Gained "..xp.." XP")
		end)
	else
		ply:SystemMessage("You don't have the required items to craft this!", Color(255,205,205), true)
		ply:SystemMessage("You need:", Color(255,205,205), false)
		for k,v in pairs(self.CraftableSpecialList[str]["Requirements"]) do
			ply:SystemMessage("	"..v.."x "..translate.Get(k.."_n"), Color(255,230,230), false)
		end
	end
end

