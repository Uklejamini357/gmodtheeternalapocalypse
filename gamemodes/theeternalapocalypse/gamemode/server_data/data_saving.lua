function GM:LoadServerData()
    local filedir = self.DataFolder.."/server"
    local filedir2 = self.DataFolder.."/server/globaldata.txt"

    if not file.IsDir(filedir, "DATA") then file.CreateDir(filedir) end

    if file.Exists(filedir2, "DATA") then
        local TheFile = file.Read(filedir2, "DATA")
        local DataPieces = string.Explode("\n", TheFile)
 
        local Output = {}
 
        for k, v in pairs(DataPieces) do
            local TheLine = string.Explode(";", v)
            local data = TheLine[1]
            local value = TheLine[2]

            if data == "InfectionLevel" then
                self:SetInfectionLevel(value, true)
            end
        end

    else
        self:SetInfectionLevel(0, true)
    end
end

function GM:SaveServerData()
    local Data = {}
	Data["InfectionLevel"] = self:GetInfectionLevel()

    local StringToWrite = ""
	for k, v in pairs(Data) do
		if StringToWrite == "" then
			StringToWrite = k ..";".. v
		else
			StringToWrite = StringToWrite .."\n".. k ..";".. v
		end
	end

    local filedir = self.DataFolder.."/server/globaldata.txt"
	file.Write(filedir, StringToWrite)
	self:DebugLog("Saved global server data to file: "..filedir)
end
