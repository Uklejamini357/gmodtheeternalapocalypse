include( 'shared.lua' )
 
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw( )
    self.Entity:DrawModel( )
end

hook.Add("PostDrawOpaqueRenderables", "name", function()
for _, ent in pairs (ents.FindByClass("trader")) do

	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1600 then
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


	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 120 then
		
		local direction = ent:GetPos() - LocalPlayer():GetPos()
		x_d = direction.x
		y_d = direction.y
		
		Ang = Angle(0, math.deg(math.atan(y_d/x_d))+90/(x_d/-math.abs(x_d)), 90)
		cam.IgnoreZ( true )
		cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.18)
		draw.SimpleTextOutlined( "Trader", "DermaLarge", 0, 0, Color( 155, 205, 155, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		draw.SimpleTextOutlined( "Press E to trade!", "TargetIDSmall", 0, 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		cam.End3D2D()

	end
end
cam.IgnoreZ( false )
end)