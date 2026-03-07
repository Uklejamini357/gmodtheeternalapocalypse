function GM:LoadServerData()
    local filedir = self.DataFolder.."/server"
    local filedir2 = self.DataFolder.."/server/globaldata.txt"

    if not file.IsDir(filedir, "DATA") then file.CreateDir(filedir) end

    if file.Exists(filedir2, "DATA") then
		local method = self.Config.SFS and sfs.decode or util.JSONToTable
		local tbl = method(file.Read(filedir2, "DATA"))
 
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
