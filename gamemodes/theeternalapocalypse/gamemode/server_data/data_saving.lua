function GM:InitializeDataDirs()
    file.CreateDir(self.DataFolder)
    file.CreateDir(self.DataFolder.."/logs")
    file.CreateDir(self.DataFolder.."/players")
    file.CreateDir(self.DataFolder.."/server")
    file.CreateDir(self.DataFolder.."/spawns")
end

function GM:LoadServerData()
    local filedir = self.DataFolder.."/server/globaldata.txt"

    if file.Exists(filedir, "DATA") then
		local method = self.Config.SFS and sfs.decode or util.JSONToTable
		local tbl = method(file.Read(filedir, "DATA"))
 
        if tbl.InfectionLevel then
            self:SetInfectionLevel(tbl.InfectionLevel, true)
        end

        self.ServerInitOsTime = tbl.ServerInitOsTime or os.time()
    else
        self:SetInfectionLevel(0, true)
    end
end

function GM:SaveServerData()
	if not force and not self.DatabaseSaving then return end
    local filedir = self.DataFolder.."/server/globaldata.txt"
    local Data = {}
	Data["InfectionLevel"] = self:GetInfectionLevel()
	Data["Statistics"] = self.StatTracker
	Data["ServerInitOsTime"] = self.ServerInitOsTime


	local method = self.Config.SFS and sfs.encode or util.TableToJSON
	file.Write(filedir, method(Data, self.Config.SFS and 50000 or true))
	self:DebugLog("Saved global server data to file: "..filedir)
end
