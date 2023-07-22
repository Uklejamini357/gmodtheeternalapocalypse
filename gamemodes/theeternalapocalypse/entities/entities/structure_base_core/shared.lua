ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Faction Base"
ENT.Author			= "LegendofRobbo"
/*
 function ENT:SetupDataTables()
 	self:NetworkVar( "Float", 0, "Integrity" )
 end
*/

ENT.Spawnable			= false
ENT.AdminOnly			= false


function ENT:SpawnFunction( ply, tr ) -- spawnfunction isnt actually used within zombified world but i left it here for debug purposes
return false
end