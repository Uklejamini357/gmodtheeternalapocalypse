ENT.Spawnable			= true
ENT.AdminSpawnable		= false

include("shared.lua")

language.Add("ent_mad_rocket", "Rocket")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
	-- TO DO: Disable Gravgun interaction
	self.TimeLeft = CurTime() + 3

	local vOffset 	= self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))
	local vNormal 	= (vOffset - self.Entity:GetPos()):GetNormalized()
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.TimeLeft > CurTime() then
		local effectdata = EffectData() 
 			effectdata:SetOrigin(self.Entity:LocalToWorld(Vector(0, 0, self.Entity:OBBMins().z))) 
 			//effectdata:GetAngle(self.Entity:GetAngles() + Vector(180, 0, 0))
			effectdata:SetScale(1.5)
 		util.Effect("MuzzleEffect", effectdata)
	end
end
