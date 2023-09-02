function GM:GiveTask(pl, task)
    local taskl = self.Tasks[task]
    if pl.CurrentTask ~= "" then return end
	if pl.TaskCooldowns[task] and pl.TaskCooldowns[task] > os.time() then pl:SystemMessage("This task is still on cooldown! Becomes available in: ".. pl.TaskCooldowns[task] - os.time().." seconds", Color(255,155,155), true) return end
	if taskl.LevelReq < tonumber(pl.Level) then pl:SystemMessage("You need to be level "..taskl.LevelReq.." to take this task!", Color(255,155,155), true) return end

    pl.CurrentTask = task
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = false

    net.Start("tea_taskassign")
    net.WriteString(pl.CurrentTask)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:GiveTaskProgress(pl, task, amt)
    local taskl = self.Tasks[task]
    if pl.CurrentTask ~= task or pl.TaskComplete or !taskl then return end

    pl.CurrentTaskProgress = math.Clamp(pl.CurrentTaskProgress + amt, 0, taskl.ReqProgress)
    if pl.CurrentTaskProgress >= taskl.ReqProgress and not pl.TaskComplete then
        gamemode.Call("CompleteTask", pl, task)
	elseif not pl.TaskComplete then
        pl.CurrentTaskProgress = math.min(taskl.ReqProgress, pl.CurrentTaskProgress)
	else return
	end

	net.Start("tea_taskprogress")
	net.WriteString(task)
	net.WriteFloat(pl.CurrentTaskProgress)
	net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:CompleteTask(pl, task)
    local taskl = self.Tasks[task]
    if pl.CurrentTask ~= task or pl.TaskComplete or !taskl or tonumber(pl.CurrentTaskProgress) < taskl.ReqProgress then return end

    pl.TaskComplete = true

    net.Start("tea_taskcomplete")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:FinishTask(pl, task)
    local taskl = self.Tasks[task]
    if pl.CurrentTask ~= task or !taskl or !pl.TaskComplete or tonumber(pl.CurrentTaskProgress) < taskl.ReqProgress then return end

	pl.TaskCooldowns[task] = os.time() + taskl.Cooldown
    pl.CurrentTask = ""
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = false

    if taskl.Callback then
        taskl.Callback(pl)
    end

    net.Start("tea_taskfinish")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:CancelTask(pl, task)
    local taskl = self.Tasks[task]
    if pl.CurrentTask ~= task or !taskl then return end

	for tasks,_ in pairs(self.Tasks) do
		pl.TaskCooldowns[tasks] = os.time() + TIME_HOUR -- 1 hour before they can assign new task
	end
	pl.TaskCooldowns[task] = os.time() + taskl.CancelCooldown
    pl.CurrentTask = ""
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = false

    net.Start("tea_taskcancel")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

TaskDealersData = TaskDealersData or ""

function GM:LoadTaskDealers()
	if not file.IsDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()), "DATA") then
	   file.CreateDir(self.DataFolder.."/spawns/"..string.lower(game.GetMap()))
	end
	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/taskdealers.txt", "DATA") then
		TaskDealersData = ""
		TaskDealersData = file.Read(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/taskdealers.txt", "DATA")
		print("Task dealers file loaded")
		return true
	else
		TaskDealersData = ""
		print("No task dealers file for this map")
		return false
	end
end

function GM:SpawnTaskDealers()
	if TaskDealersData ~= "" then
		for k, v in pairs(ents.FindByClass("tea_taskdealer")) do
			v:Remove()
		end

		local TaskDealersList = string.Explode("\n", TaskDealersData)
		for k, v in pairs(TaskDealersList) do
			TaskDealer = string.Explode(";", v)
			local pos = util.StringToType(TaskDealer[1], "Vector")
			local ang = util.StringToType(TaskDealer[2], "Angle")
			local ent = ents.Create("tea_taskdealer")
			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetNetworkedString("Owner", "World")
			ent:Spawn()
			ent:Activate()
		end
	end
end
timer.Simple(1, function()
	gamemode.Call("SpawnTaskDealers")
end)

function GM:AddTaskDealer(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if TaskDealersData == "" then
		NewData = tostring(ply:GetPos())..";"..tostring(ply:GetAngles())
	else
		NewData = TaskDealersData.."\n"..tostring(ply:GetPos())..";"..tostring(ply:GetAngles())
	end
	
	file.Write(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/taskdealers.txt", NewData)

	gamemode.Call("LoadTaskDealers") --reload them
	ply:SendChat("Added a task dealer spawnpoint at position "..tostring(ply:GetPos()).."!")
	self:DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a task dealer spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand("playgamesound buttons/button3.wav")
	timer.Simple(1, function()
		gamemode.Call("SpawnTaskDealers")
	end)
end
concommand.Add("tea_addtaskdealer", function(ply, cmd, args)
	gamemode.Call("AddTaskDealer", ply, cmd, args)
end)

function GM:ClearTaskDealers(ply, cmd, args)
	if !SuperAdminCheck(ply) then
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if file.Exists(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/taskdealers.txt", "DATA") then
		file.Delete(self.DataFolder.."/spawns/"..string.lower(game.GetMap()).."/taskdealers.txt")
	end
	ply:SendChat("Deleted all task dealer spawnpoints!")
	self:DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all task dealer spawnpoints!")
	ply:ConCommand("playgamesound buttons/button15.wav")
end
concommand.Add("tea_cleartaskdealerspawns", function(ply, cmd, args)
	gamemode.Call("ClearTaskDealers", ply, cmd, args)
end)

function GM:RefreshTaskDealers(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	if gamemode.Call("LoadTaskDealers") then
		timer.Simple(1, function()
			gamemode.Call("SpawnTaskDealers")
		end)
	end
end
concommand.Add("tea_refreshtaskdealers", function(ply, cmd, args)
	gamemode.Call("RefreshTaskDealers", ply, cmd, args)
end)

net.Receive("tea_taskassign", function(len, pl)
	local task = net.ReadString()

	gamemode.Call("GiveTask", pl, task)
end)

net.Receive("tea_taskcancel", function(len, pl)
	local task = net.ReadString()

	gamemode.Call("CancelTask", pl, task)
end)

net.Receive("tea_taskfinish", function(len, pl)
	local task = net.ReadString()

	gamemode.Call("FinishTask", pl, task)
end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:RefreshTasksStats()
	net.Start("tea_taskstatsupdate")
	net.WriteString(self.CurrentTask)
	net.WriteFloat(self.CurrentTaskProgress)
	net.WriteBool(self.TaskComplete)
	net.Send(self)
end
