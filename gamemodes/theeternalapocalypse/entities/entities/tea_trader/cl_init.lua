include( 'shared.lua' )
 
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw( )
    self.Entity:DrawModel( )
end

hook.Add("PostDrawOpaqueRenderables", "tea_trader", function()
	local me = LocalPlayer()
for _, ent in pairs (ents.FindByClass("tea_trader")) do

	if ent:GetPos():Distance(me:GetPos()) < 2560000 then -- 1600^2
	local Pos = ent:GetPos()
	local Ang = ent:GetAngles()
	cam.Start3D2D(Pos + ent:GetUp() * 5, Ang, 0.6)
local TexturedQuadStructure =
{
	texture = surface.GetTextureID( 'particle/particle_ring_sharp' ),
	color   = Color( 55, 255, 55, 155 ),
	x 	= -200,
	y 	= -200,
	w 	= 400,
	h 	= 400
}

draw.TexturedQuad( TexturedQuadStructure )
	cam.End3D2D()
end

--particle/Particle_Ring_Wave


	if ent:GetPos():DistToSqr(me:GetPos()) < 14400 then -- 120^2
		
		cam.IgnoreZ( true )
		cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Angle(0, me:EyeAngles().yaw - 90, 90), 0.18)
		draw.SimpleTextOutlined( "Trader", "DermaLarge", 0, 0, Color( 155, 205, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined( "Press E to trade!", "TargetIDSmall", 0, 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		cam.End3D2D()

	end
end
cam.IgnoreZ( false )
end)