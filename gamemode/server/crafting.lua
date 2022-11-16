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
		for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
			if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
			elseif ply.Inventory[k] > v then
				ply.Inventory[k] = ply.Inventory[k] - v
			elseif ply.Inventory[k] == v then
				ply.Inventory[k] = nil
			end
		end

		local vStart = ply:GetShootPos()
		local vForward = ply:GetAimVector()
		local trace = {}
		trace.start = vStart
		trace.endpos = vStart + (vForward * 70)
		trace.filter = ply
		local tr = util.TraceLine(trace)
		local EntDrop = ents.Create("ate_droppeditem")
		EntDrop:SetPos(tr.HitPos)
		EntDrop:SetAngles(Angle(0, 0, 0))
		EntDrop:SetModel(GAMEMODE.ItemsList[str]["Category"] == 4 and "models/props/cs_office/cardboard_box01.mdl" or GAMEMODE.ItemsList[str]["Model"])
		EntDrop:SetNWString("ItemClass", str)
		EntDrop:Spawn()
		EntDrop:Activate()
		EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))

		tea_SendInventory(ply)
		SendChat(ply, "Successfully crafted an item!")
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
		for k,v in pairs(GAMEMODE.CraftableSpecialList[str]["Requirements"]) do
			if ply.Inventory[k] == nil or ply.Inventory[k] < v then continue
			elseif ply.Inventory[k] > v then
				ply.Inventory[k] = ply.Inventory[k] - v
			elseif ply.Inventory[k] == v then
				ply.Inventory[k] = nil
			end
		end

		local vStart = ply:GetShootPos()
		local vForward = ply:GetAimVector()
		local trace = {}
		trace.start = vStart
		trace.endpos = vStart + (vForward * 70)
		trace.filter = ply
		local tr = util.TraceLine(trace)
		local EntDrop = ents.Create("ate_droppeditem")
		EntDrop:SetPos(tr.HitPos)
		EntDrop:SetAngles(Angle(0, 0, 0))
		EntDrop:SetModel(GAMEMODE.ItemsList[str]["Category"] == 4 and "models/props/cs_office/cardboard_box01.mdl" or GAMEMODE.ItemsList[str]["Model"])
		EntDrop:SetNWString("ItemClass", str)
		EntDrop:Spawn()
		EntDrop:Activate()
		EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
		
		tea_SendInventory(ply)
		SendChat(ply, "Successfully crafted an item!")
	else
		SystemMessage(ply, "You don't have the required items to craft this!", Color(255,205,205), true)
		SystemMessage(ply, "You need:", Color(255,205,205), false)
		for k,v in pairs(GAMEMODE.CraftableList[str]["Requirements"]) do
			SystemMessage(ply, "	"..v.."x "..translate.Get(k.."_n"), Color(255,230,230), false)
		end
	end
end

