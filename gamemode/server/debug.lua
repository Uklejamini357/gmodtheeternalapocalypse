local DebugLogs = {}

function ate_DebugLog( str )
if Config[ "DebugLogging" ] != true then return end
table.insert(DebugLogs, str)
end

local function SaveLog()
if Config[ "DebugLogging" ] != true then return end

local TimeStr = "ate_log_"..os.date( "%d/%m/%Y" )
local filename = string.Replace( TimeStr, "/", "_" )..".txt"

if not file.IsDir( "theeternalapocalypse/logs", "DATA" ) then
   file.CreateDir( "theeternalapocalypse/logs" )
end

local StringToWrite = ""
for k, v in pairs( DebugLogs ) do
	if( StringToWrite == "" ) then
		StringToWrite = v
	else
		StringToWrite = StringToWrite .. "\n" .. v
	end
end

if file.Exists( "theeternalapocalypse/logs/"..filename, "DATA" ) then
	file.Append("theeternalapocalypse/logs/"..filename, StringToWrite)
else
	file.Write( "theeternalapocalypse/logs/"..filename, StringToWrite )
end

print("After the End: Saved debug logs to data/theeternalapocalypse/logs/"..filename)
DebugLogs = {}
end
concommand.Add("ate_savelogs", SaveLog)
timer.Create("ate_savelogs_timer", 200, 0, SaveLog)