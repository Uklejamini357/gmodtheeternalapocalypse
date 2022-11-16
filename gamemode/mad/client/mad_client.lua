

/*---------------------------------------------------------
   Name: GnomeView()
---------------------------------------------------------*/
local function CalcView(ply, origin, angles, fov)
   
	if ply:Alive() and ply:GetNWBool("Gnome") then
		local view = {
			origin = origin + Vector(0, 0, -40),
		}

		return view
	end
end
hook.Add("CalcView", "GnomeView", CalcView)

