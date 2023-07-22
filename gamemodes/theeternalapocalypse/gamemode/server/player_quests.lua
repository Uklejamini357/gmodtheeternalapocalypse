function GM:GiveTask(pl, task)
    if pl.CurrentTask ~= "" then return end

    pl.CurrentTask = task
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = false

    net.Start("tea_taskassign")
    net.WriteString(pl.CurrentTask)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:GiveTaskProgress(pl, task, amt)
    if pl.CurrentTask ~= task then return end

    local taskl = self.Tasks[pl.CurrentTask]
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
    if pl.CurrentTask ~= task or pl.TaskComplete or pl.CurrentTaskProgress < self.Tasks[task].ReqProgress then return end

    pl.TaskComplete = true

    net.Start("tea_taskcomplete")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:FinishTask(pl, task)
    if pl.CurrentTask ~= task or pl.CurrentTaskProgress < self.Tasks[pl.CurrentTask].ReqProgress then return end

    local taskl = self.Tasks[pl.CurrentTask]
    pl.CurrentTask = ""
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = true

    if taskl.Callback then
        taskl.Callback(pl)
    end

    net.Start("tea_taskfinish")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

function GM:CancelTask(pl, task)
    if pl.CurrentTask ~= task then return end

    pl.TaskCooldown = os.time() + TIME_HOUR -- 1 hour before they can assign new task
    pl.CurrentTask = ""
    pl.CurrentTaskProgress = 0
    pl.TaskComplete = false

    net.Start("tea_taskcancel")
    net.WriteString(task)
    net.Send(pl)

	pl:RefreshTasksStats()
end

TaskDealersData = ""

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

local meta = FindMetaTable("Player")
if not meta then return end

function meta:RefreshTasksStats()
	net.Start("tea_taskstatsupdate")
	net.WriteString(self.CurrentTask)
	net.WriteFloat(self.CurrentTaskProgress)
	net.WriteBool(self.CurrentTaskCompleted)
	net.Send(self)
end
