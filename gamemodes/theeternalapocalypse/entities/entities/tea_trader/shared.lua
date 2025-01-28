ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName		= "Trader"
ENT.Author			= "LegendofRobbo"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end
