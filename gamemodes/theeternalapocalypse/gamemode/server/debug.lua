-- Much better logging system, now logs when the message was added (HH:MM:SS)
function tea_DebugLog(str)
	local time = os.date("%H:%M:%S")
	if GAMEMODE.Config["DebugLogging"] == true then
		table.insert(GAMEMODE.DebugLogs, "["..time.."] "..str)
	end
	if GetConVar("tea_server_debugging"):GetInt() >= 1 then
		print("[LOGS] ["..time.."] "..str)
	end
end


function tea_SaveLog()
	if GAMEMODE.Config["DebugLogging"] != true then return end

	local TimeStr = os.date("%H:%M:%S")
	local DateStr = os.date("%d/%m/%Y")
	local filename = string.Replace(DateStr, "/", "_")..".txt"
	tea_DebugLog("Logs have been saved.\n")

	if not file.IsDir(GAMEMODE.DataFolder.."/logs", "DATA") then
	   file.CreateDir(GAMEMODE.DataFolder.."/logs")
	end

	local StringToWrite = ""
	for k, v in pairs(GAMEMODE.DebugLogs) do
		if (StringToWrite == "") then
			StringToWrite = v
		else
			StringToWrite = StringToWrite .. "\n" .. v
		end
	end

	if file.Exists(GAMEMODE.DataFolder.."/logs/"..filename, "DATA" ) then
		file.Append(GAMEMODE.DataFolder.."/logs/"..filename, StringToWrite)
	else
		file.Write(GAMEMODE.DataFolder.."/logs/"..filename, StringToWrite )
	end

	print("The Eternal Apocalypse: Saved logs at "..TimeStr.." to data/"..GAMEMODE.DataFolder.."/logs/"..filename)
	GAMEMODE.DebugLogs = {}
end
timer.Create("ate_savelogs_timer", 480, 0, tea_SaveLog)

function GM.AdminCmds.SaveLog(ply, cmd, args)
	if !ply:IsValid() then return end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	tea_SaveLog()
	SystemMessage(ply, "Logs saved", Color(255,255,255,255), true)
end
concommand.Add("tea_debug_savelogs", GM.AdminCmds.SaveLog)


function GM.AdminCmds.ReadLogs(ply, cmd, args)
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "superadmincheckfail"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	local filename = string.Replace(os.date("%d/%m/%Y"), "/", "_")
	local arg1 = args[1] or filename
	local fileexists = file.Exists(GAMEMODE.DataFolder.."/logs/"..arg1..".txt", "DATA")
	local TheFile
	local DataPieces

	if fileexists then
		TheFile = file.Read(GAMEMODE.DataFolder.."/logs/"..arg1..".txt", "DATA")
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
		for k,v in pairs(GAMEMODE.DebugLogs) do
			ply:PrintMessage(2, v)
		end
	end
	ply:SendLua([[MsgC(Color(63,127,191,255), "\n------=== ENDING MESSAGE OF THE LOGS ===------\n\n")]])
end
concommand.Add("tea_debug_readlogsfile", GM.AdminCmds.ReadLogs)
