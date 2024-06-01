function GM:CountProps(ply)
	local PlyProps = 0

	for k, v in pairs(ents.FindByClass("prop_flimsy")) do
		if v:GetNWEntity("owner") == ply then
		PlyProps = PlyProps + 1
		end
	end

	for k, v in pairs(ents.FindByClass("prop_strong")) do
		if v:GetNWEntity("owner") == ply then
		PlyProps = PlyProps + 1
		end
	end

	return PlyProps
end

function GM:CountStructures(ply, struc)
	local PlyStrucs = 0

	for k, v in pairs(ents.FindByClass(struc)) do
		if v:GetNWEntity("owner") == ply then
		PlyStrucs = PlyStrucs + 1
		end
	end

	return PlyStrucs
end

function GM:CheckBases(ply, pos)
	local bases = ents.FindInSphere(pos, 950)
	for k, v in pairs(bases) do
		if v:GetClass() == "structure_base_core" and v.IsBuilt == true and v:GetNWEntity("owner"):Team() != ply:Team() then return true end
	end

	return false
end

function GM:DestroyProp(ply, ent)
	if !ply:IsValid() or !ply:Alive() then return false end
	if !ent:IsValid() or !ent:GetClass() == "prop_flimsy" or !ent:GetClass() == "prop_strong" then return false end
	local owner = ent:GetNWEntity("owner")
	if !owner:IsValid() or !owner:Alive() then return false end

	local ptype
	local checktable
	if FLIMSYPROPS[ent:GetModel()] then ptype = 1
	elseif TOUGHPROPS[ent:GetModel()] then ptype = 2
	else return false end

	if ptype == 1 then checktable = FLIMSYPROPS
	elseif ptype == 2 then checktable = TOUGHPROPS
	else return false end

	if owner != ply then ply:SystemMessage("You don't own this prop!", Color(255,205,205,255), true) return false end

	local salvagedelay = ply:HasPerk("speedy_hands") and 1 or 2
	ply:SendUseDelay(salvagedelay)

	timer.Simple(salvagedelay, function()
		if !ply:IsValid() or !ply:Alive() or !ent:IsValid() then return false end

		local refund = checktable[ent:GetModel()]["COST"]
		if refund == nil then return false end
		refund = refund * 0.45
		if self.PropCostEnabled then
			ply.Money = ply.Money + math.floor(refund)
			ply:SystemMessage("You salvaged one of your props and gained "..math.floor(refund).." Gold", Color(205,205,255,255), true)
		end
		ent:EmitSound("physics/wood/wood_furniture_break"..math.random(1,2)..".wav", 100, math.random(95,105))
		ent:Remove()

		self:NetUpdatePeriodicStats(ply)
	end)
end

function GM:DestroyStructure(ply, ent)
	if !ply:IsValid() or !ply:Alive() then return false end
	if !ent:IsValid() or !SpecialSpawns[ent:GetClass()] then return false end
	local owner = ent:GetNWEntity("owner")
	if !owner:IsValid() or !owner:Alive() then return false end

	if owner != ply then ply:SystemMessage("You don't own this structure!", Color(255,205,205,255), true) return false end

	local salvagedelay = ply:HasPerk("speedy_hands") and 1 or 2
	ply:SendUseDelay(salvagedelay)
	timer.Simple(salvagedelay, function()
		if !ply:IsValid() or !ply:Alive() or !ent:IsValid() then return false end

		local refund = SpecialSpawns[ent:GetClass()]["Cost"]
		if refund == nil then return false end
		refund = refund * 0.5
		if self.FactionStructureCostEnabled then
			ply.Money = ply.Money + math.floor(refund)
			ply:SystemMessage("You salvaged one of your buildings and gained "..math.floor(refund).." Gold", Color(205,205,255,255), true)
		end
		ent:EmitSound("physics/wood/wood_furniture_break"..math.random(1,2)..".wav", 100, math.random(95,105))
		ent:Remove()

		self:NetUpdatePeriodicStats(ply)
	end)
end




function GM:CheckFactionBases(pos)
	local check = ents.FindInSphere(pos, 950)
	for k, v in pairs(check) do
		if v:GetClass() == "structure_base_core" or v:GetClass() == "tea_trader" or v:GetClass() == "tea_taskdealer" or v:GetClass() == "spawn_guard" then return false end
	end

	return true
end


local entmeta = FindMetaTable("Entity")

function entmeta:GetStructureHealth()
	return self:GetNWInt("ate_integrity", 0)
end

function entmeta:SetStructureHealth(val)
	return self:SetNWInt("ate_integrity", val)
end

function entmeta:GetStructureMaxHealth()
	return self:GetNWInt("ate_maxintegrity", 0)
end


function GM:MakeProp(ply, model, pos, ang)
	if !ply:IsValid() or !ply:Alive() then return false end
	if SpecialSpawns[model] then GAMEMODE:MakeStructure(ply, model, pos, ang) return false end -- if the model is a structure then break out of this function and run the create structure function instead

	if gamemode.Call("CheckBases", ply, pos) then
		ply:SystemMessage("You cannot spawn props this close to an opposing faction base!", Color(255,205,205,255), true)
		return false
	end

	local ptype
	local checktable
	if FLIMSYPROPS[model] then ptype = 1
	elseif TOUGHPROPS[model] then ptype = 2
	else return false end

	if ptype == 1 then checktable = FLIMSYPROPS
	elseif ptype == 2 then checktable = TOUGHPROPS
	else return false end

	if ptype == 2 and ply:Team() == TEAM_LONER then ply:SystemMessage("You must be in a faction to spawn strong props!", Color(255,205,205,255), true) return false end

	local cash = tonumber(ply.Money)
	local pcost = checktable[model]["COST"]
	local discount = 1 - (ply.StatEngineer * 0.02)

	if cash < (pcost * discount) and self.PropCostEnabled then ply:SystemMessage("Unable to spawn prop due to insufficient Gold!", Color(255,205,205,255), true) return false end

	for k, v in pairs(ents.FindByClass("tea_trader")) do
		if pos:Distance(v:GetPos()) < self.PropSpawnTraderDistance then ply:SystemMessage("Unable to spawn prop! Too close to a trader!", Color(255,205,205,255), true) return false end
	end

	for k, v in pairs(ents.FindByClass("tea_taskdealer")) do
		if pos:Distance(v:GetPos()) < self.PropSpawnTraderDistance then ply:SystemMessage("Unable to spawn prop! Too close to a task dealer!", Color(255,205,205,255), true) return false end
	end

	if gamemode.Call("CountProps", ply) >= self.MaxProps then 
		ply:SendChat("You cannot have more than "..self.MaxProps.." prop(s)!")
		return false
	end

	if ptype == 1 then
		local prop = ents.Create("prop_flimsy")
		prop:SetModel(model)
		prop:SetPos(pos)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:Activate()
		prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
		prop.IsPropBarricade = true
		local phys = prop:GetPhysicsObject()
		phys:Wake()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (checktable[model]["TOUGHNESS"] or 1))
		prop:SetNWInt("ate_integrity", 500 * (checktable[model]["TOUGHNESS"] or 1))
		prop:SetNWEntity("owner", ply)
		if self.PropCostEnabled then
			ply.Money = tonumber(ply.Money) - (pcost * discount)
		end
	else
		local prop = ents.Create("prop_strong")
		prop:SetModel(model)
		prop:SetPos(pos)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:Activate()
		prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
		prop.IsPropBarricade = true
		local phys = prop:GetPhysicsObject()
		phys:Wake()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (checktable[model]["TOUGHNESS"] or 1))
		prop:SetNWInt("ate_integrity", 500 * (checktable[model]["TOUGHNESS"] or 1))
		prop:SetNWEntity("owner", ply)
		if self.PropCostEnabled then
			ply.Money = tonumber(ply.Money) - (pcost * discount)
		end
	end
	self:NetUpdatePeriodicStats(ply)
end



function GM:MakeStructure(ply, struc, pos, ang)
	if !ply:IsValid() or !ply:Alive() then return false end
	if !SpecialSpawns[struc] then ply:SystemMessage("Invalid Structure! Tell a developer because something bugged", Color(255,205,205,255), true) return false end
	if ply:Team() == 1 then ply:SystemMessage("You must be in a faction to place structures!", Color(255,205,205,255), true) return false end
	if gamemode.Call("CheckBases", ply, pos) then ply:SystemMessage("You cannot spawn structures this close to an opposing faction base!", Color(255,205,205,255), true) return false end

	local cash = tonumber(ply.Money)
	local pcost = SpecialSpawns[struc]["Cost"]

	if (cash < pcost) and self.FactionStructureCostEnabled then ply:SystemMessage("Unable to create structure: insufficient Gold!", Color(255,205,205,255), true) return false end

	if gamemode.Call("CountStructures", ply, struc) >= SpecialSpawns[struc]["Max"] then 
		ply:SystemMessage("You cannot have more than "..SpecialSpawns[struc]["Max"].." "..SpecialSpawns[struc]["Name"].."s", Color(255,205,205,255), true)
		return false
	end

	if struc == "structure_base_core" and gamemode.Call("CheckFactionBases", pos) != true then
		ply:SystemMessage("Unable to create base core: Too close to trader, spawn or another base core!", Color(255,205,205,255), true)
		return false
	end

	local plyteam = team.GetName(ply:Team())
	if struc == "structure_base_core" and Factions[plyteam]["leader"] != ply then
		ply:SystemMessage("You must be the leader of your faction to create a base core!", Color(255,205,205,255), true)
		return false
	end

	local prop = ents.Create(struc)
	prop:SetModel(SpecialSpawns[struc]["Model"])
	prop:SetPos(pos)
	prop:SetAngles(ang)
	prop:Spawn()
	prop:Activate()
	prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
	prop.IsPropBarricade = true
	local phys = prop:GetPhysicsObject()
	phys:Wake()
	phys:EnableMotion(false)
	prop:SetNWEntity("owner", ply)
	if self.FactionStructureCostEnabled then
		ply.Money = tonumber(ply.Money) - pcost
	end

	self:NetUpdatePeriodicStats(ply)

end

function GM:ClearFactionStructures(ply)
	for k, v in pairs(SpecialSpawns) do
		for k, v in pairs(ents.FindByClass(k)) do
			if v:GetNWEntity("owner") == ply then v:Remove() end
		end
	end
end