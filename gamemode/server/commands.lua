-------------------------------------------------------------------Inventory Commands------------------------------------------------------------------

function GM.TogglePVP(ply)
	if timer.Exists("pvptoggle_"..ply:UniqueID()) then SystemMessage(ply, translate.ClientGet(ply, "pvp_nospam"), Color(255,205,205,255), true) return false end
	if timer.Exists("pvpnominge_"..ply:UniqueID()) then SystemMessage(ply, translate.ClientGet(ply, "pvp_unabletotoggle"), Color(255,205,205,255), true) return false end

	ply:SetPvPGuarded(2)
	SystemMessage(ply, "Toggling PvP in 5 seconds...", Color(205,205,255,255), true)
	ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 100, 100)

	local nerds = ents.FindInSphere(ply:GetPos(), 800)
	if ply:GetNWBool("pvp") == false then
		for _, v in pairs(nerds) do
			if !v:IsPlayer() then continue end
			if v == ply then continue end
			SystemMessage(v, translate.ClientFormat(v, "pvp_proxy_warn", ply:Nick()), Color(255,105,105,255), false)
		end
	end

	timer.Create("pvptoggle_"..ply:UniqueID(), 5, 1, function()
		if !ply:IsValid() or !ply:Alive() then return false end
		if timer.Exists("pvpnominge_"..ply:UniqueID()) then SystemMessage(ply, translate.ClientGet(ply, "pvp_unabletotoggle"), Color(255,205,205,255), true) return false end

		if ply:GetNWBool("pvp") == true then ply:SetNWBool("pvp", false) SystemMessage(ply, translate.ClientGet(ply, "pvp_off"), Color(205,205,205,255), true)
		else
			ply:SetNWBool("pvp", true) SystemMessage(ply, translate.ClientGet(ply, "pvp_on"), Color(205,255,205,255), true)
		end
		ply:SetPvPGuarded(0)
	end)
end
concommand.Add("tea_togglepvp", GM.TogglePVP)


function tea_TrashProps(ply)
	if !ply:IsValid() then return false end
	for k, v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end

	ply:ConCommand("play physics/metal/metal_large_debris1.wav")
	SystemMessage(ply, translate.ClientGet(ply, "clearedmyprops"), Color(205,205,255,255), true)
end
concommand.Add("tea_clearmyprops", tea_TrashProps)


function GM.DropCash(ply, cmd, args)
	if !ply:IsValid() then return false end
	if !ply:Alive() then SystemMessage(ply, "You can't drop money when dead!", Color(255,105,105,255), false) return false end
--if timer exists then function must be cancelled, else some users can use to spam this command and lag it
	if timer.Exists("dropcashcooldown_"..ply:UniqueID()) then
		ply.DropCashCDcount = ply.DropCashCDcount + 1
		if ply.DropCashCDcount >= 7 then
			tea_DebugLog("Kicking player "..ply:Nick().."! (Attempted to spam dropcash command)")
			ply:Kick("[The Eternal Apocalypse System]\nThis was unexcepted...\n\nKick Reason: Attempted to spam the drop cash command!")
		else
			SystemMessage(ply, "Wait before you drop more money!", Color(255,205,205,255), true)
			tea_DebugLog(ply:Nick().." attempted to drop money while on cooldown! (Attempts within short time: "..ply.DropCashCDcount..")")
		end
	return false end
	timer.Create("dropcashcooldown_"..ply:UniqueID(), 1.5, 1, function() if ply:IsValid() then ply.DropCashCDcount = 0 end end)

	local cash = math.floor(args[1])
	local plycash = tonumber(ply.Money)

	if cash < 1 then SystemMessage(ply, "Invalid drop amount, must be at least 1 "..GAMEMODE.Config["Currency"].."!", Color(255,205,205,255), true) return false end
	if plycash < cash then SystemMessage(ply, "You don't have that many "..GAMEMODE.Config["Currency"].."(s)!", Color(255,205,205,255), true) return false end
	ply.Money = plycash - cash

	tea_DebugLog(ply:Nick().." has dropped "..cash.." "..GAMEMODE.Config["Currency"].."(s)!")

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

	SystemMessage(ply, "You dropped "..cash.." "..GAMEMODE.Config["Currency"].."(s)!", Color(205,255,205,255), true)
	tea_NetUpdatePeriodicStats(ply)
end
concommand.Add("tea_dropcash", GM.DropCash)
