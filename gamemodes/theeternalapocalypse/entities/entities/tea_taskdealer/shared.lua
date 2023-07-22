ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName		= "Task Dealer"
ENT.Author			= "Uklejamini"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end