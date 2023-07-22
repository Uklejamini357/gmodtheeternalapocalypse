-- Much better logging system, now logs when the message was added (HH:MM:SS)
function GM:DebugLog(str)
	local time = os.date("%H:%M:%S")
	if self.Config["DebugLogging"] == true then
		table.insert(self.DebugLogs, "["..time.."] "..str)
	end
	if self:GetDebug() >= DEBUGGING_NORMAL then
		print("[LOGS] ["..time.."] "..str)
	end
end


function GM:SaveLog()
	if self.Config["DebugLogging"] ~= true then return end

	local TimeStr = os.date("%H:%M:%S")
	local DateStr = os.date("%d/%m/%Y")
	local filename = string.Replace(DateStr, "/", "_")..".txt"
	self:DebugLog("Logs have been saved.\n")

	if not file.IsDir(self.DataFolder.."/logs", "DATA") then
	   file.CreateDir(self.DataFolder.."/logs")
	end

	local StringToWrite = ""
	for k, v in pairs(self.DebugLogs) do
		if (StringToWrite == "") then
			StringToWrite = v
		else
			StringToWrite = StringToWrite .. "\n" .. v
		end
	end

	if file.Exists(self.DataFolder.."/logs/"..filename, "DATA" ) then
		file.Append(self.DataFolder.."/logs/"..filename, StringToWrite)
	else
		file.Write(self.DataFolder.."/logs/"..filename, StringToWrite )
	end

	print("The Eternal Apocalypse: Saved logs at "..TimeStr.." to data/"..self.DataFolder.."/logs/"..filename)
	self.DebugLogs = {}
end
timer.Create("ate_savelogs_timer", 480, 0, function()
	gamemode.Call("SaveLog")
end)

function GM:AdminCmds_SaveLog(ply)
	if !ply:IsValid() then return end
	if !SuperAdminCheck(ply) then 
		self:SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	self:SaveLog()
	self:SystemMessage(ply, "Logs saved", Color(255,255,255,255), true)
end
concommand.Add("tea_debug_savelogs", function(ply)
	gamemode.Call("AdminCmds_SaveLog", ply)
end)


function GM:AdminCmds_ReadLogs(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local filename = string.Replace(os.date("%d/%m/%Y"), "/", "_")
	local arg1 = args[1] or filename
	local fileexists = file.Exists(self.DataFolder.."/logs/"..arg1..".txt", "DATA")
	local TheFile
	local DataPieces

	if fileexists then
		TheFile = file.Read(self.DataFolder.."/logs/"..arg1..".txt", "DATA")
		DataPieces = string.Explode("\n", TheFile)
	end

	ply:SendLua([[MsgC(Color(63,127,191,255), "\n------=== STARTING MESSAGE OF THE LOGS ===------\n\n")]])
	if fileexists then
		for k, v in pairs(DataPieces) do
		    local TheLine = string.Explode(";", v)

			ply:PrintMessage(2, TheLine[1])
		end
	end

	if filename == arg1 then
		for k,v in pairs(self.DebugLogs) do
			ply:PrintMessage(2, v)
		end
	end
	ply:SendLua([[MsgC(Color(63,127,191,255), "\n------=== ENDING MESSAGE OF THE LOGS ===------\n\n")]])
end
concommand.Add("tea_debug_readlogsfile", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ReadLogs", ply, cmd, args)
end)
