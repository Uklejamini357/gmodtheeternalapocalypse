-------------------------------------------------------------------Inventory Commands------------------------------------------------------------------

function GM:TogglePVP(ply)
	if timer.Exists("pvptoggle_"..ply:EntIndex()) then ply:SystemMessage(translate.ClientGet(ply, "pvp_nospam"), Color(255,205,205,255), true) return false end
	if (ply.PvPNoToggle or 0) > CurTime() then ply:SystemMessage(translate.ClientGet(ply, "pvp_unabletotoggle"), Color(255,205,205,255), true) return false end

	ply:SetPvPGuarded(2)
	ply:SystemMessage("Toggling PvP in 5 seconds...", Color(205,205,255,255), true)
	ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 100, 100)

	local nerds = ents.FindInSphere(ply:GetPos(), 800)
	if ply:GetNWBool("pvp") == false then
		for _, v in pairs(nerds) do
			if !v:IsPlayer() then continue end
			if v == ply then continue end
			v:SystemMessage(translate.ClientFormat(v, "pvp_proxy_warn", ply:Nick()), Color(255,105,105,255), false)
		end
	end

	timer.Create("pvptoggle_"..ply:EntIndex(), 5, 1, function()
		if !ply:IsValid() or !ply:Alive() then return false end
		if (ply.PvPNoToggle or 0) > CurTime() then
			ply:SystemMessage(translate.ClientGet(ply, "pvp_unabletotoggle"), Color(255,205,205,255), true)
			return false
		end

		if ply:GetNWBool("pvp") == true then
			ply:SetNWBool("pvp", false)
			ply:SystemMessage(translate.ClientGet(ply, "pvp_off"), Color(205,205,205,255), true)
		else
			ply:SetNWBool("pvp", true)
			ply:SystemMessage(translate.ClientGet(ply, "pvp_on"), Color(205,255,205,255), true)
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
	ply:SystemMessage(translate.ClientGet(ply, "clearedmyprops"), Color(205,205,255,255), true)
end
concommand.Add("tea_clearmyprops", function(ply, cmd, args)
	gamemode.Call("TrashProps", ply)
end)


function GM:DropCash(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !ply:Alive() then ply:SystemMessage("You can't drop money when dead!", Color(255,105,105,255), false) return false end
--if timer exists then function must be cancelled, else some users can use to spam this command and lag it
	if timer.Exists("dropcashcooldown_"..ply:EntIndex()) then
		ply.DropCashCDcount = ply.DropCashCDcount + 1
		if ply.DropCashCDcount >= 7 then
			self:DebugLog(Format("Kicking player %s! (Attempted to spam dropcash command)", ply:Nick()))
			ply:Kick("[The Eternal Apocalypse System]\nThis was unexcepted...\n\nKick Reason: Attempted to spam the drop cash command!")
		else
			ply:SystemMessage("Wait before you drop more money!", Color(255,205,205,255), true)
			self:DebugLog(ply:Nick().." attempted to drop money while on cooldown! (Attempts within short time: "..ply.DropCashCDcount..")")
		end
	return false end
	timer.Create("dropcashcooldown_"..ply:EntIndex(), 1.5, 1, function() if ply:IsValid() then ply.DropCashCDcount = 0 end end)

	local cash = math.floor(args[1])
	local plycash = tonumber(ply.Money)

	if cash < 1 then ply:SystemMessage("Invalid drop amount, must be at least 1 "..self.Config["Currency"].."!", Color(255,205,205,255), true) return false end
	if plycash < cash then ply:SystemMessage("You don't have that many "..self.Config["Currency"].."(s)!", Color(255,205,205,255), true) return false end
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

	ply:SystemMessage("You dropped "..cash.." "..self.Config["Currency"].."(s)!", Color(205,255,205,255), true)
	self:NetUpdatePeriodicStats(ply)
end
concommand.Add("tea_dropcash", function(ply, cmd, args)
	gamemode.Call("DropCash", ply, cmd, args)
end)
