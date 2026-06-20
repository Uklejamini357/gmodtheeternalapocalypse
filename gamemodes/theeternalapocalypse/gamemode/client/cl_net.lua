net.Receive("tea_damagefloater", function(length)
	local damage = net.ReadFloat()
	local pos = net.ReadVector()
	local pl = net.ReadBool()

	-- for i=1,2 do
	-- LocalPlayer():EmitSound("buttons/button10.wav", 150, 100, 1)
	-- end
	if GAMEMODE.HitSounds then
		local snd = "theeternalapocalypse/hitsound.wav"
		if pl and GAMEMODE.HitSoundsVolumeNPC > 0 then
			LocalPlayer():EmitSound(snd, 0, nil, GAMEMODE.HitSoundsVolumeNPC)
		elseif !pl and GAMEMODE.HitSoundsVolume > 0 then
			LocalPlayer():EmitSound(snd, 0, nil, GAMEMODE.HitSoundsVolume)
		end
	end

	if !GAMEMODE.EnableDamageNumbers then return end
	local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	effectdata:SetMagnitude(damage)
	effectdata:SetScale(0)
	util.Effect("damagenumber", effectdata)
end)

net.Receive("SystemMessage", function(length, client)
	local msg = net.ReadString()
	local col = net.ReadColor()
	local sys = net.ReadBool()

	if sys then
		chat.AddText(COLOR_WHITE, "[System] ", col, msg)
	else
		chat.AddText(col, msg)
	end
end)

local radiosounds = {
	"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
	"npc/metropolice/vo/wearesociostablethislocation.wav",
	"npc/metropolice/vo/readytoprosecutefinalwarning.wav",
	"npc/metropolice/vo/pickingupnoncorplexindy.wav",
	"npc/metropolice/vo/malcompliant10107my1020.wav",
	"npc/metropolice/vo/ivegot408hereatlocation.wav",
	"npc/metropolice/vo/investigating10-103.wav",
	"npc/metropolice/vo/ihave10-30my10-20responding.wav",
	"npc/metropolice/vo/holdingon10-14duty.wav",
	"npc/metropolice/vo/gota10-107sendairwatch.wav",
	"npc/metropolice/vo/get11-44inboundcleaningup.wav",
	"npc/metropolice/vo/hidinglastseenatrange.wav"
}

net.Receive("RadioMessage", function(length, client)
	local sender = net.ReadString()
	local msg = net.ReadString()
	local rad = net.ReadBool()

	chat.AddText( Color(155,255,155), "[Radio] "..sender..": ", Color(205,205,205), msg )
	if rad then
		surface.PlaySound(table.Random(radiosounds))
	end
end)

net.Receive("WraithBlind", function()
	local value = net.ReadInt(10)
	GAMEMODE.WraithAlpha = math.max(GAMEMODE.WraithAlpha, value)
end)

net.Receive("tea_survivalstatsupdate", function(len)
	local me = LocalPlayer()
	me.LifeStats = net.ReadTable()
end)


net.Receive("tea_taskassign", function(len)
	local id = net.ReadString()
	local taskl = GAMEMODE.Tasks[id]
	local pl = LocalPlayer()
	if !pl:IsValid() then return end

	pl.CurrentTasks[id] = 0

	chat.AddText(COLOR_WHITE, translate.Get("you_assigned_new_task1"), Color(255,255,127), taskl.Name, COLOR_WHITE, translate.Get("you_assigned_new_task2"))
end)

net.Receive("tea_taskprogress", function(len)
	local id = net.ReadString()
	local value = net.ReadFloat()

	local pl = LocalPlayer()
	if !pl:IsValid() then return end

	pl.CurrentTasks[id] = value

	local taskl = GAMEMODE.Tasks[id]
	if pl:HasCompletedTask(id) then
		chat.AddText(COLOR_WHITE, "The task ", Color(255,255,127), taskl.Name, COLOR_WHITE, " is now complete, go back to task dealer for the reward!")
	end
end)

-- net.Receive("tea_taskcomplete", function(len)
-- 	local id = net.ReadString()

-- 	local taskl = GAMEMODE.Tasks[id]

-- 	chat.AddText(COLOR_WHITE, translate.Get("task_complete1"), Color(255,255,127), taskl.Name, COLOR_WHITE, translate.Get("task_complete2"))
-- end)

net.Receive("tea_taskfinish", function(len)
	local id = net.ReadString()
	local taskl = GAMEMODE.Tasks[id]

	local pl = LocalPlayer()
	if !pl:IsValid() then return end
	pl.CurrentTasks[id] = nil

	chat.AddText(COLOR_WHITE, translate.Get("task_finished1"), Color(255,255,127), taskl.Name, COLOR_WHITE, "!")
end)

net.Receive("tea_taskcancel", function(len)
	local id = net.ReadString()
	local taskl = GAMEMODE.Tasks[id]

	local pl = LocalPlayer()
	if !pl:IsValid() then return end
	pl.CurrentTasks[id] = nil

	chat.AddText(COLOR_WHITE, translate.Get("task_cancelled1"), Color(255,255,127), taskl.Name, COLOR_WHITE, translate.Get("task_cancelled2"), Color(255,127,127), taskl.Cooldown / TIME_HOUR, COLOR_WHITE, translate.Get("task_cancelled3"))
end)

net.Receive("tea_taskstatsupdate", function(len)
	local tasks = net.ReadTable()

	local pl = LocalPlayer()
	if !pl:IsValid() then return end
	if !pl.CurrentTasks then return end
	table.Empty(pl.CurrentTasks)
	table.Merge(pl.CurrentTasks, tasks)
end)

net.Receive("tea_perksupdate", function(len)
	GAMEMODE.LocalPerks = net.ReadTable()
end)

net.Receive("tea_admin_sendspawns", function(len)
	local typ = net.ReadString()
	local tbl = net.ReadTable()


	GAMEMODE.Spawns = GAMEMODE.Spawns or {}
	GAMEMODE.Spawns[typ] = tbl
end)

net.Receive("tea_itemuse", function()
	local pl = LocalPlayer()
	local duration = net.ReadFloat()
	local text = net.ReadString()
	local shouldtranslate = net.ReadBool()
	local canmove = net.ReadBool()

	pl.UsingItemText = shouldtranslate and translate.Get(text) or text
	pl.UsingItemDuration = duration
	pl.UsingItemTime = CurTime()
	pl.UsingItemCanMove = canmove
end)

net.Receive("UpdatePerks", function(length)
	local me = LocalPlayer()
	for statname, _ in SortedPairs(GAMEMODE.StatConfigs) do
		me["Stat"..statname] = net.ReadUInt(32)
	end
end)


net.Receive("RecvFactions", function(length, client)
	local data = net.ReadTable()

	table.Empty(LocalFactions)

	-- put the loner faction back in since it can never be deleted
	LocalFactions["Loner"] = {
		["index"] = TEAM_LONER,
		["color"] = TEAM_COLOR_LONER,
		["public"] = true,
		["leader"] = nil
	}
	table.Merge(LocalFactions, data)
	for k, v in pairs(LocalFactions) do
		team.SetUp(v.index, k, v.color, v.public)
	end
end)

local opnwrld_ui
net.Receive("tea_openworld_level", function()
    local nettype = net.ReadUInt(4)

	if nettype == OPENWORLD_NETTYPE_SENDINFO then
		local map = net.ReadString()
		local plrs = net.ReadUInt(8)


		if IsValid(opnwrld_ui) then opnwrld_ui:Remove() end
		opnwrld_ui = vgui.Create("DPanel")
		opnwrld_ui:SetSize(400, 175)
		opnwrld_ui:CenterHorizontal()
		opnwrld_ui:CenterVertical(0.1)
		opnwrld_ui.Paint = function(self, w, h)
			surface.SetDrawColor(0,0,0,150)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end
		opnwrld_ui:MakePopup()
		opnwrld_ui:SetKeyboardInputEnabled(false)

		local label = vgui.Create("DLabel", opnwrld_ui)
		label:SetText("Traverse to another map?")
		label:SetFont("TEA.HUDFontSmall")
		label:Dock(TOP)
		label:DockMargin(0,10,0,0)

		local labelmap = vgui.Create("DLabel", opnwrld_ui)
		labelmap:SetText(map)
		labelmap:SetFont("TEA.HUDFontSmall")
		labelmap:Dock(TOP)
		labelmap:DockMargin(0,10,0,0)

		local labelplrs = vgui.Create("DLabel", opnwrld_ui)
		labelplrs:SetFont("TEA.HUDFontSmall")
		labelplrs:Dock(TOP)
		labelplrs:DockMargin(0,10,0,0)
		labelplrs.UpdatePlayers = function(self, plrs)
			self:SetText("Other players who also want to transition: "..plrs.."/"..#player.GetHumans())
		end
		labelplrs:UpdatePlayers(plrs)
		opnwrld_ui.players = labelplrs

		local btn = vgui.Create("DButton", opnwrld_ui)
		local close
		btn:SetText("Yes!")
		btn:SetFont("TEA.HUDFontSmall")
		btn:Dock(TOP)
		btn:DockMargin(0,10,0,0)
		btn.DoClick = function(self)
			opnwrld_ui:SetMouseInputEnabled(false)

			btn:Remove()
			close:Remove()

			net.Start("tea_openworld_level")
			net.WriteUInt(OPENWORLD_NETTYPE_CONFIRM, 4)
			net.SendToServer()
		end
		btn.Paint = function(self, w, h)
			surface.SetDrawColor(0,0,200,self:IsHovered() and 150 or 0)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,200)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		close = vgui.Create("DButton", opnwrld_ui)
		close:SetText("No!!")
		close:SetFont("TEA.HUDFontSmall")
		close:Dock(TOP)
		close:DockMargin(0,10,0,0)
		close.DoClick = function(self)
			opnwrld_ui:Remove()
		end
		close.Paint = btn.Paint
	elseif nettype == OPENWORLD_NETTYPE_SENDMAPSINFO then
		GAMEMODE.OpenworldTransitions = net.ReadTable()
		for _,v in pairs(GAMEMODE.OpenworldTransitions) do
			v.Pos = (v.AreaMin + v.AreaMax)/2
		end
	elseif nettype == OPENWORLD_NETTYPE_UPDATEPLAYERS then
		if !IsValid(opnwrld_ui) then return end
		opnwrld_ui.players:UpdatePlayers(net.ReadUInt(8))
	elseif nettype == OPENWORLD_NETTYPE_LEFTAREA then
		if !IsValid(opnwrld_ui) then return end
		opnwrld_ui:Remove()
	elseif nettype == OPENWORLD_NETTYPE_GETTRANSITIONSINFO then
		if !IsValid(GAMEMODE.AdminFrame) then return end
		GAMEMODE.AdminFrame:OnReceiveTransitionsData(net.ReadTable())
	end
end)

net.Receive("tea_admin_tool", function()
	local mode = net.ReadString()
	if mode == "admineyes" then
		local var = net.ReadString()
		local vars = net.ReadTable()

		GAMEMODE.AdminEyes[var] = vars
	elseif mode == "openworldcreate" then
		local startpos = net.ReadVector()
		local startang = net.ReadAngle()
		local box = {net.ReadVector(), net.ReadVector()}

		gamemode.Call("CreateOpenworldTransition", startpos, startang, box[1], box[2])
	elseif mode == "safezonecreate" then
		local box = {net.ReadVector(), net.ReadVector()}

		gamemode.Call("CreateSafezoneArea", box[1], box[2])
	end
end)

net.Receive("tea_safezone", function()
	local id = net.ReadUInt(2)

	if id == NET_SAFEZONE_ENTER then
		GAMEMODE.SafezoneEntered = true
		GAMEMODE.SafezoneTimeEntered = CurTime()
		GAMEMODE.SafezoneTimeProtected = CurTime()+GAMEMODE.SafezoneProtectionDelay
	elseif id == NET_SAFEZONE_LEAVE then
		GAMEMODE.SafezoneEntered = false
		GAMEMODE.SafezoneTimeEntered = 0
		GAMEMODE.SafezoneTimeProtected = 0
	elseif id == NET_SAFEZONE_GETINFO then
		GAMEMODE.MapSafezones = net.ReadTable()
		for _,v in pairs(GAMEMODE.MapSafezones) do
			v.Pos = (v.AreaMin + v.AreaMax)/2
		end
	end
end)

local itemcol = Color(171,232,249)
net.Receive("tea_lootpickup", function(len)
	local pl = net.ReadEntity()
	local ltype = net.ReadUInt(4)
	local lrarity = net.ReadUInt(4)
	local item = net.ReadString()
	local qty = net.ReadUInt(8) -- only 0-255.


	local me = LocalPlayer()
	if pl == me then
		if ltype == LOOTTYPE_NORMAL then
			if qty ~= 1 then
				chat.AddText(color_white, "[", GAMEMODE:GetLootRarityColor(lrarity), GAMEMODE:GetLootRarityName(lrarity), color_white, "] ",
				translate.Get("you_picked_up_a_lootcache").." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", GAMEMODE:GetLootRarityColor(lrarity), qty, color_white, ")")
			else
				chat.AddText(color_white, "[", GAMEMODE:GetLootRarityColor(lrarity), GAMEMODE:GetLootRarityName(lrarity), color_white, "] ",
				translate.Get("you_picked_up_a_lootcache").." ", itemcol, GAMEMODE:GetItemName(item, me))
			end
		elseif ltype == LOOTTYPE_BOSS then
			if qty ~= 1 then
				chat.AddText(color_white, translate.Get("you_picked_up_a_lootcache_boss").." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", qty, ")")
			else
				chat.AddText(color_white, translate.Get("you_picked_up_a_lootcache_boss").." ", itemcol, GAMEMODE:GetItemName(item, me))
			end
		elseif ltype == LOOTTYPE_FACTION then
			if qty ~= 1 then
				chat.AddText(color_white, translate.Get("you_picked_up_a_lootcache_faction").." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", qty, ")")
			else
				chat.AddText(color_white, translate.Get("you_picked_up_a_lootcache_faction").." ", itemcol, GAMEMODE:GetItemName(item, me))
			end
		end
	end

	if ltype == LOOTTYPE_NORMAL and lrarity < LOOTRARITY_EPIC then return end

	if ltype == LOOTTYPE_NORMAL then
		if qty ~= 1 then
			chat.AddText(color_white, "[", GAMEMODE:GetLootRarityColor(lrarity), GAMEMODE:GetLootRarityName(lrarity), color_white, "] ",
			translate.Format("plr_picked_up_a_lootcache", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", GAMEMODE:GetLootRarityColor(lrarity), qty, color_white, ")")
		else
			chat.AddText(color_white, "[", GAMEMODE:GetLootRarityColor(lrarity), GAMEMODE:GetLootRarityName(lrarity), color_white, "] ",
			translate.Format("plr_picked_up_a_lootcache", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me))
		end
	elseif ltype == LOOTTYPE_BOSS then
		if qty ~= 1 then
			chat.AddText(color_white, translate.Format("plr_picked_up_a_lootcache_boss", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", qty, ")")
		else
			chat.AddText(color_white, translate.Format("plr_picked_up_a_lootcache_boss", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me))
		end
	elseif ltype == LOOTTYPE_FACTION then
		if qty ~= 1 then
			chat.AddText(color_white, translate.Format("plr_picked_up_a_lootcache_faction", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me), color_white, " (x", qty, ")")
		else
			chat.AddText(color_white, translate.Format("plr_picked_up_a_lootcache_faction", pl:Nick()).." ", itemcol, GAMEMODE:GetItemName(item, me))
		end
	end
end)

net.Receive("tea_events", function(len)
	local eventType = net.ReadUInt(4)

	if eventType == EVENTTYPE_AIRDROP then
		surface.PlaySound("ambient/overhead/hel1.wav")

		chat.AddText(Color(127,255,255), translate.Get("airdrop_appeared"))
	elseif eventType == EVENTTYPE_BOSS then
		if GAMEMODE.BossSound then
			surface.PlaySound("music/stingers/hl1_stinger_song8.mp3")
		end
	elseif eventType == EVENTTYPE_SPECIAL_ZOMBIEFOG then
		local start = net.ReadBool()
		GAMEMODE.ZombieFogActive = start
		if start then
			GAMEMODE.ZombieFogStart = CurTime()
			chat.AddText(Color(0,190,0), "A zombie fog is forming, and it's getting more difficult to breathe...")
			chat.AddText(Color(0,255,0), "The zombies become stronger, and the infection level seems to be increasing...")
			-- chat.AddText(Color(0,255,0), "The poisoned air also seems to be affecting survivors...")
		else
			GAMEMODE.ZombieFogEnd = CurTime()
			chat.AddText(Color(95,190,0), "The zombie fog fades away...")
			chat.AddText(Color(125,255,0), "The air is breathable again, and the zombies no longer gain boosts.")
		end
	elseif eventType == EVENTTYPE_SPECIAL_BLOODMOON then
		local start = net.ReadBool()
		GAMEMODE.BloodMoonActive = start
		if start then
			GAMEMODE.BloodMoonStart = CurTime()
			chat.AddText(Color(190,0,0), "The blood moon is rising...")
			chat.AddText(Color(255,0,0), "The zombies are greatly influenced by the blood moon, making them faster and stronger!")
		else
			GAMEMODE.BloodMoonEnd = CurTime()
			chat.AddText(Color(95,190,0), "The blood moon is fading...")
			chat.AddText(Color(125,255,0), "The zombies are no longer boosted...")
		end
	end
end)

net.Receive("tea_playerevent", function(len)
	local pl = LocalPlayer()
	local eventType = net.ReadUInt(4)

	if eventType == PLAYEREVENT_INITSPAWN then
		GAMEMODE.SkyBoxCameraPos = net.ReadVector()
	elseif eventType == PLAYEREVENT_ARMORSWITCHED then
		local armor = net.ReadString()

		pl:SetEquippedArmor(armor)
		if IsValid(pInvPanel) then
			pInvPanel:UpdateEquippedArmor(armor, true)
		end
	end
end)
