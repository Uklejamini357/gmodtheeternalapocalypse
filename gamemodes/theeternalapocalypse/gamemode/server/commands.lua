-------------------------------------------------------------------Inventory Commands------------------------------------------------------------------

function GM:TogglePVP(ply)
	if timer.Exists("pvptoggle_"..ply:EntIndex()) then ply:SystemMessage(translate.ClientGet(ply, "pvp_nospam"), COLOR_WARN, true) return false end
	if (ply.PvPNoToggle or 0) > CurTime() then ply:SystemMessage(translate.ClientGet(ply, "pvp_unabletotoggle"), COLOR_WARN, true) return false end

	ply:SetPvPGuarded(2)
	ply:SystemMessage(translate.Get("toggling_pvp"), COLOR_ACTION, true)
	ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 100, 100)

	local nearby = ents.FindInSphere(ply:GetPos(), 800)
	if not ply:GetNWBool("pvp") then
		for _, v in pairs(nearby) do
			if !v:IsPlayer() or v == ply then continue end
			v:SystemMessage(translate.ClientFormat(v, "pvp_proxy_warn", ply:Nick()), COLOR_CRITWARN, false)
		end
	end

	timer.Create("pvptoggle_"..ply:EntIndex(), 5, 1, function()
		if !ply:IsValid() or !ply:Alive() then return false end
		if (ply.PvPNoToggle or 0) > CurTime() then
			ply:SystemMessage(translate.ClientGet(ply, "pvp_unabletotoggle"), COLOR_WARN, true)
			return false
		end

		if ply:GetNWBool("pvp") == true then
			ply:SetNWBool("pvp", false)
			ply:SystemMessage(translate.ClientGet(ply, "pvp_off"), COLOR_INFO, true)
		else
			ply:SetNWBool("pvp", true)
			ply:SystemMessage(translate.ClientGet(ply, "pvp_on"), COLOR_SUCCESS, true)
		end
		ply:SetPvPGuarded(0)
	end)
end
concommand.Add("tea_togglepvp", function(ply, cmd, args)
	gamemode.Call("TogglePVP", ply)
end)


function GM:TrashProps(ply)
	if !ply:IsValid() then return false end
	for k, v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then
			v:Remove()
		end
	end

	ply:ConCommand("play physics/metal/metal_large_debris1.wav")
	ply:SystemMessage(translate.ClientGet(ply, "clearedmyprops"), COLOR_DONE, true)
end
concommand.Add("tea_clearmyprops", function(ply, cmd, args)
	gamemode.Call("TrashProps", ply)
end)


function GM:DropCash(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !ply:Alive() then ply:SystemMessage(translate.ClientGet(ply, "cant_drop_money_dead"), COLOR_CRITWARN, false) return false end

	if timer.Exists("dropcashcooldown_"..ply:EntIndex()) then
		ply:SystemMessage(translate.ClientGet(ply, "cant_drop_money_cd"), COLOR_WARN, true)
	return false end
	timer.Create("dropcashcooldown_"..ply:EntIndex(), 3, 1, function() end)

	local cash = math.floor(args[1])
	local plycash = tonumber(ply.Money)

	if cash < 1 then ply:SystemMessage(translate.ClientFormat(ply, "cant_drop_money_low", self.Config["Currency"]), COLOR_WARN, true) return false end
	if plycash < cash then ply:SystemMessage(translate.ClientFormat(ply, "insufficient_money_drop", self.Config["Currency"]), COLOR_WARN, true) return false end
	ply.Money = plycash - cash

	self:DebugLog(ply:Nick().." has dropped "..cash.." "..self.Config["Currency"].."(s)!")

	local vStart = ply:GetShootPos()
	local vForward = ply:GetAimVector()
	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 70)
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local EntDrop = ents.Create("ate_cash")
	EntDrop:SetPos(tr.HitPos + Vector(0, 0, 5))
	EntDrop:SetAngles(Angle( 0, 0, 0 ))
	EntDrop:SetNWInt("CashAmount", cash)
	EntDrop:Spawn()
	EntDrop:Activate()

	ply:SystemMessage(translate.ClientFormat(ply, "dropped_money", cash, self.Config["Currency"]), COLOR_SUCCESS, true)
	self:NetUpdatePeriodicStats(ply)
end
concommand.Add("tea_dropcash", function(ply, cmd, args)
	gamemode.Call("DropCash", ply, cmd, args)
end)
