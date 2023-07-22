include( 'shared.lua' )
 
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw( )
    self.Entity:DrawModel( )
end

hook.Add("PostDrawOpaqueRenderables", "tea_taskdealers", function()
	local me = LocalPlayer()
	for _, ent in pairs (ents.FindByClass("tea_taskdealer")) do


--particle/Particle_Ring_Wave


		if ent:GetPos():Distance(me:GetPos()) < 144 then -- 16800
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Angle(0, me:EyeAngles().yaw - 90, 90), 0.18)
			draw.SimpleTextOutlined("Task dealer", "DermaLarge", 0, 0, Color( 155, 205, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			draw.SimpleTextOutlined("See your progress on tasks", "TargetIDSmall", 0, 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			cam.End3D2D()
		end
	end
end)