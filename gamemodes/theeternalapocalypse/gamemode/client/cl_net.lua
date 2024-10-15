net.Receive("tea_damagefloater", function(length)
	local damage = net.ReadFloat()
	local pos = net.ReadVector()

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
	me.LifeZKills = net.ReadFloat()
	me.LifePlayerKills = net.ReadFloat()
end)


net.Receive("tea_taskassign", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = task

	chat.AddText(Color(255,255,255), "You assigned new task: ", Color(255,255,127), taskl.Name, Color(255,255,255), ", complete the task for the reward!")
end)

net.Receive("tea_taskprogress", function(len)
	local task = net.ReadString()
	local value = net.ReadFloat()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTaskProgress = value

	chat.AddText(Color(255,255,255), "Task progress for ", Color(255,255,127), taskl.Name, Color(255,255,255), ": ", Color(255,255,63), value.." / "..taskl.ReqProgress)
end)

net.Receive("tea_taskcomplete", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	chat.AddText(Color(255,255,255), "You have completed a task ", Color(255,255,127), taskl.Name, Color(255,255,255), ", go to task dealer to claim the reward!")
end)

net.Receive("tea_taskfinish", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = ""
	GAMEMODE.CurrentTaskProgress = nil

	chat.AddText(Color(255,255,255), "You have finished a task ", Color(255,255,127), taskl.Name, Color(255,255,255), "!")
end)

net.Receive("tea_taskcancel", function(len)
	local task = net.ReadString()

	local taskl = GAMEMODE.Tasks[task]

	GAMEMODE.CurrentTask = ""
	GAMEMODE.CurrentTaskProgress = nil

	chat.AddText(Color(255,255,255), "You cancelled task ", Color(255,255,127), taskl.Name, Color(255,255,255), ", you have ", Color(255,127,127), "1", Color(255,255,255), " hour cooldown before taking in new task and ", Color(255,127,127), taskl.CancelCooldown / TIME_HOUR, Color(255,255,255), " hour cooldown before taking this task again!")
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
