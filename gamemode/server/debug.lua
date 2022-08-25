local DebugLogs = {}

-- Much better logging system, now logs when the message was added (HH:MM:SS)
function ate_DebugLog(str)
if Config["DebugLogging"] != true then return end
table.insert(DebugLogs, "["..os.date( "%H:%M:%S" ).."] "..str)
end

-- It should work now, especially without local function Savelog()
function SaveLog()
if Config["DebugLogging"] != true then return end

local TimeStr = os.date("%H:%M:%S")
local DateStr = os.date("%d/%m/%Y")
local filename = string.Replace(DateStr, "/", "_")..".txt"
ate_DebugLog("Logs have been saved.\n")

if not file.IsDir("theeternalapocalypse/logs", "DATA") then
   file.CreateDir("theeternalapocalypse/logs")
end

local StringToWrite = ""
for k, v in pairs(DebugLogs) do
	if (StringToWrite == "") then
		StringToWrite = v
	else
		StringToWrite = StringToWrite .. "\n" .. v
	end
end

if file.Exists("theeternalapocalypse/logs/"..filename, "DATA" ) then
	file.Append("theeternalapocalypse/logs/"..filename, StringToWrite)
else
	file.Write("theeternalapocalypse/logs/"..filename, StringToWrite )
end

print("The Eternal Apocalypse: Saved logs at "..TimeStr.." to data/theeternalapocalypse/logs/"..filename)
DebugLogs = {}
end
timer.Create("ate_savelogs_timer", 480, 0, SaveLog)

function TEADevSaveLog(ply, cmd, args)
	if !ply:IsValid() then return end
	if !SuperAdminCheck(ply) then 
		SystemMessage(ply, translate.ClientGet(ply, "TEASuperAdminCheckFailed"), Color(255,205,205,255), true)
		ply:ConCommand("playgamesound buttons/button8.wav")
		return
	end
	SystemMessage(ply, "Logs saved", Color(255,255,255,255), true)
	SaveLog()

end
concommand.Add("tea_debug_savelogs", TEADevSaveLog)
--Because now I made it so the logs saving on server shutdown, it was made to save less frequent