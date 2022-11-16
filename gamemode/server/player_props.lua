function CountProps(ply)
	local PlyProps = 0

	for k, v in pairs( ents.FindByClass( "prop_flimsy" ) ) do
		if v:GetNWEntity("owner") == ply then
		PlyProps = PlyProps + 1
		end
	end

	for k, v in pairs( ents.FindByClass( "prop_strong" ) ) do
		if v:GetNWEntity("owner") == ply then
		PlyProps = PlyProps + 1
		end
	end

	return PlyProps
end

function CountStructures(ply, struc)
	local PlyStrucs = 0

	for k, v in pairs( ents.FindByClass( struc ) ) do
		if v:GetNWEntity("owner") == ply then
		PlyStrucs = PlyStrucs + 1
		end
	end

	return PlyStrucs
end

function CheckBases(ply, pos)
	local bases = ents.FindInSphere(pos, 950)
	for k, v in pairs(bases) do
		if v:GetClass() == "structure_base_core" and v.IsBuilt == true and v:GetNWEntity("owner"):Team() != ply:Team() then return true end
	end

	return false
end

function DestroyProp(ply, ent)
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

	if owner != ply then SystemMessage(ply, "You don't own this prop!", Color(255,205,205,255), true) return false end

	SendUseDelay( ply, 2 )

	timer.Simple(2, function()
		if !ply:IsValid() or !ply:Alive() or !ent:IsValid() then return false end

		local refund = checktable[ent:GetModel()]["COST"]
		if refund == nil then return false end
		if GetConVar("tea_config_propcostenabled"):GetInt() >= 1 then
			ply.Money = ply.Money + math.floor(refund * 0.45)
			SystemMessage(ply, "You salvaged one of your props and gained "..math.floor(refund * 0.45).." Gold", Color(205,205,255,255), true)
		end
		ent:EmitSound("physics/wood/wood_furniture_break"..math.random(1,2)..".wav", 100, math.random(95,105))
		ent:Remove()

		tea_NetUpdatePeriodicStats(ply)
	end)
end

function DestroyStructure(ply, ent)
	if !ply:IsValid() or !ply:Alive() then return false end
	if !ent:IsValid() or !SpecialSpawns[ent:GetClass()] then return false end
	local owner = ent:GetNWEntity("owner")
	if !owner:IsValid() or !owner:Alive() then return false end

	if owner != ply then SystemMessage(ply, "You don't own this structure!", Color(255,205,205,255), true) return false end

	SendUseDelay( ply, 2 )
	timer.Simple(2, function()
		if !ply:IsValid() or !ply:Alive() or !ent:IsValid() then return false end

		local refund = SpecialSpawns[ent:GetClass()]["Cost"]
		if refund == nil then return false end
		if GetConVar("tea_config_factionstructurecostenabled"):GetInt() >= 1 then
			ply.Money = ply.Money + math.floor(refund * 0.5)
			SystemMessage(ply, "You salvaged one of your buildings and gained "..math.floor(refund * 0.5).." Gold", Color(205,205,255,255), true)
		end
		ent:EmitSound("physics/wood/wood_furniture_break"..math.random(1,2)..".wav", 100, math.random(95,105))
		ent:Remove()

		tea_NetUpdatePeriodicStats(ply)
	end)
end




function CheckFactionBases(pos)
	local check = ents.FindInSphere(pos, 950)
	for k, v in pairs(check) do
		if v:GetClass() == "structure_base_core" or v:GetClass() == "trader" or v:GetClass() == "spawn_guard" then return false end
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


function MakeProp(ply, model, pos, ang)
	if !ply:IsValid() or !ply:Alive() then return false end
	if SpecialSpawns[model] then MakeStructure(ply, model, pos, ang) return false end -- if the model is a structure then break out of this function and run the create structure function instead

	if CheckBases(ply, pos) then SystemMessage(ply, "You cannot spawn props this close to an opposing faction base!", Color(255,205,205,255), true) return false end

	local ptype
	local checktable
	if FLIMSYPROPS[model] then ptype = 1
	elseif TOUGHPROPS[model] then ptype = 2
	else return false end

	if ptype == 1 then checktable = FLIMSYPROPS
	elseif ptype == 2 then checktable = TOUGHPROPS
	else return false end

	if ptype == 2 and ply:Team() == 1 then SystemMessage(ply, "You must be in a faction to spawn strong props!", Color(255,205,205,255), true) return false end

	local cash = tonumber(ply.Money)
	local pcost = checktable[model]["COST"]
	local discount = 1 - (ply.StatEngineer * 0.02)
	local tea_config_maxprops = GetConVar("tea_config_maxprops"):GetInt()

	if cash < (pcost * discount) and GetConVar("tea_config_propcostenabled"):GetInt() >= 1 then SystemMessage(ply, "Unable to spawn prop due to insufficient Gold!", Color(255,205,205,255), true) return false end

	for k, v in pairs(ents.FindByClass("trader")) do
		if pos:Distance(v:GetPos()) < GetConVar("tea_config_propspawndistance"):GetFloat() then SystemMessage(ply, "Unable to spawn prop! Too close to a trader!", Color(255,205,205,255), true) return false end
	end

	if CountProps(ply) >= tea_config_maxprops then 
	SendChat( ply, "You cannot have more than "..tea_config_maxprops.." prop(s)!" )
		return false
	end

	if ptype == 1 then
		local prop = ents.Create( "prop_flimsy" )
		prop:SetModel(model)
		prop:SetPos(pos)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:Activate()
		prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
		local phys = prop:GetPhysicsObject()
		phys:Wake()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (checktable[model]["TOUGHNESS"] or 1) )
		prop:SetNWInt("ate_integrity", 500 * (checktable[model]["TOUGHNESS"] or 1) )
		prop:SetNWEntity("owner", ply)
		if GetConVar("tea_config_propcostenabled"):GetInt() >= 1 then
			ply.Money = tonumber(ply.Money) - (pcost * discount)
		end
	else
		local prop = ents.Create( "prop_strong" )
		prop:SetModel(model)
		prop:SetPos(pos)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:Activate()
		prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
		local phys = prop:GetPhysicsObject()
		phys:Wake()
		phys:EnableMotion(false)
		prop:SetNWInt("ate_maxintegrity", 500 * (checktable[model]["TOUGHNESS"] or 1) )
		prop:SetNWInt("ate_integrity", 500 * (checktable[model]["TOUGHNESS"] or 1) )
		prop:SetNWEntity("owner", ply)
		if GetConVar("tea_config_propcostenabled"):GetInt() >= 1 then
			ply.Money = tonumber(ply.Money) - (pcost * discount)
		end
	end
	tea_NetUpdatePeriodicStats(ply)
end



function MakeStructure(ply, struc, pos, ang)
	if !ply:IsValid() or !ply:Alive() then return false end
	if !SpecialSpawns[struc] then SystemMessage(ply, "Invalid Structure! Tell a developer because something bugged", Color(255,205,205,255), true) return false end
	if ply:Team() == 1 then SystemMessage(ply, "You must be in a faction to place structures!", Color(255,205,205,255), true) return false end
	if CheckBases(ply, pos) then SystemMessage(ply, "You cannot spawn structures this close to an opposing faction base!", Color(255,205,205,255), true) return false end

	local cash = tonumber(ply.Money)
	local pcost = SpecialSpawns[struc]["Cost"]

	if (cash < pcost) and GetConVar("tea_config_factionstructurecostenabled"):GetInt() >= 1 then SystemMessage(ply, "Unable to create structure: insufficient Gold!", Color(255,205,205,255), true) return false end

	if CountStructures(ply, struc) >= SpecialSpawns[struc]["Max"] then 
		SystemMessage(ply, "You cannot have more than "..SpecialSpawns[struc]["Max"].." "..SpecialSpawns[struc]["Name"].."s", Color(255,205,205,255), true)
		return false
	end

	if struc == "structure_base_core" and CheckFactionBases(pos) != true then SystemMessage(ply, "Unable to create base core: Too close to trader, spawn or another base core!", Color(255,205,205,255), true) return false end
	local plyteam = team.GetName(ply:Team())
	if struc == "structure_base_core" and Factions[ plyteam ]["leader"] != ply then SystemMessage(ply, "You must be the leader of your faction to create a base core!", Color(255,205,205,255), true) return false end

	local prop = ents.Create( struc )
	prop:SetModel(SpecialSpawns[struc]["Model"])
	prop:SetPos( pos )
	prop:SetAngles( ang )
	prop:Spawn()
	prop:Activate()
	prop:EmitSound(Sound("physics/plastic/plastic_barrel_impact_bullet1.wav",100,math.random(95,105)))
	local phys = prop:GetPhysicsObject()
	phys:Wake()
	phys:EnableMotion(false)
	prop:SetNWEntity("owner", ply)
	if GetConVar("tea_config_factionstructurecostenabled"):GetInt() >= 1 then
		ply.Money = tonumber(ply.Money) - pcost
	end

	tea_NetUpdatePeriodicStats(ply)

end

function ClearFactionStructures(ply)
	for k, v in pairs(SpecialSpawns) do
		for k, v in pairs(ents.FindByClass(k)) do
			if v:GetNWEntity("owner") == ply then v:Remove() end
		end
	end
end