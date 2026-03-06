net.Receive("tea_damagefloater", function(length)
	local damage = net.ReadFloat()
	local pos = net.ReadVector()

	-- LocalPlayer():EmitSound("buttons/button10.wav", 0, 100, 1)

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
		chat.AddText(Color(255,255,255), "[System] ", col, msg)
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
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = task

	chat.AddText(Color(255,255,255), translate.Get("you_assigned_new_task1"), Color(255,255,127), taskl.Name, Color(255,255,255), translate.Get("you_assigned_new_task2"))
end)

net.Receive("tea_taskprogress", function(len)
	local task = net.ReadString()
	local value = net.ReadFloat()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTaskProgress = value

	-- chat.AddText(Color(255,255,255), "Task progress ", Color(255,255,127), taskl.Name, Color(255,255,255), ": ", Color(255,255,63), value.." / "..taskl.ReqProgress)
end)

net.Receive("tea_taskcomplete", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	chat.AddText(Color(255,255,255), translate.Get("task_complete1"), Color(255,255,127), taskl.Name, Color(255,255,255), translate.Get("task_complete2"))
end)

net.Receive("tea_taskfinish", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = ""
	GAMEMODE.CurrentTaskProgress = nil

	chat.AddText(Color(255,255,255), translate.Get("task_finished1"), Color(255,255,127), taskl.Name, Color(255,255,255), "!")
end)

net.Receive("tea_taskcancel", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = ""
	GAMEMODE.CurrentTaskProgress = nil

	chat.AddText(Color(255,255,255), translate.Get("task_cancelled1"), Color(255,255,127), taskl.Name, Color(255,255,255), translate.Get("task_cancelled2"), Color(255,127,127), taskl.CancelCooldown / TIME_HOUR, Color(255,255,255), translate.Get("task_cancelled3"))
end)

net.Receive("tea_taskstatsupdate", function(len)
	local task = net.ReadString()
	local value = net.ReadFloat()
	local complete = net.ReadBool()

	GAMEMODE.CurrentTask = task
	GAMEMODE.CurrentTaskProgress = value
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

net.Receive("UpdateStatistics", function(length)
	local pl = LocalPlayer()

	if not pl:IsValid() then return end
	if not pl.Statistics then pl.Statistics = {} end
	for stat, value in pairs(net.ReadTable()) do
		pl.Statistics[stat] = value
	end

	MyMMeleexp = net.ReadFloat()
	MyMMeleelvl = net.ReadFloat()
	MyMPvpxp = net.ReadFloat()
	MyMPvplvl = net.ReadFloat()
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
		["color"] = Color(100, 50, 50, 255),
		["public"] = true,
		["leader"] = nil
	}
	table.Merge(LocalFactions, data)
	for k, v in pairs(LocalFactions) do
		team.SetUp(v.index, k, v.color, v.public)
	end
end)
