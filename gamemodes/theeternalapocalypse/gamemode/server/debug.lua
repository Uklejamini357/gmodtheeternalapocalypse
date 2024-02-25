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
concommand.Add("tea_debug_testlog", function(ply, cmd, args, str)
	if !TEADevCheck(ply) then
		ply:SystemMessage(translate.ClientGet(ply, "devcheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end

	GAMEMODE:DebugLog(str)
end)


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
		ply:SystemMessage(translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	self:SaveLog()
	ply:SystemMessage("Logs saved", Color(255,255,255,255), true)
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
	local page = args[1] or 1
	local _file = args[2] or filename
	local fileexists = file.Exists(self.DataFolder.."/logs/".._file..".txt", "DATA")
	local TheFile
	local DataPieces
	local DebugDataPieces

	if fileexists then
		TheFile = file.Read(self.DataFolder.."/logs/".._file..".txt", "DATA")
		DataPieces = string.Explode("\n", TheFile)
	end

	if DataPieces[#DataPieces] == "" then
		DataPieces[#DataPieces] = nil
	end

	if filename == _file then
		local str = ""
		for k,v in pairs(self.DebugLogs) do
			str = str..v.."\n"
		end
		DebugDataPieces = string.Explode("\n", str)

		if DebugDataPieces[#DebugDataPieces] == "" then
			DebugDataPieces[#DebugDataPieces] = nil
		end

		for k,v in pairs(DebugDataPieces) do
			table.insert(DataPieces, v)
		end
	end

	page = math.Clamp(page, 1, math.ceil(#DataPieces/100))

	ply:SendLua([[MsgC(Color(63,127,191,255), "\n------=== STARTING MESSAGE OF THE LOGS [Page ]]..page..[[/]]..math.ceil(#DataPieces/100)..[[] ===------\n\n")]])
	for i=1+(page*100-100),math.min(page*100, #DataPieces) do
		ply:PrintMessage(2, DataPieces[i])
	end

	ply:SendLua([[MsgC(Color(63,127,191,255), "\n------=== ENDING MESSAGE OF THE LOGS ===------\n\n")]])

	if not args[2] then
		ply:PrintMessage(3, "Tip: Place in argument #2 to read the file (example argument: 05_12_2023 [dd_mm_yyyy])")
	end
end
concommand.Add("tea_debug_readlogsfile", function(ply, cmd, args)
	gamemode.Call("AdminCmds_ReadLogs", ply, cmd, args)
end)
