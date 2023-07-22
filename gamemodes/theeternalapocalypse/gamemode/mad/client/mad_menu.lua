

/*---------------------------------------------------------
   Name: CrosshairOptions()
---------------------------------------------------------*/
local function MadCrosshairOptions(panel)

	local MadCrosshairOptions = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "mad_cows_crosshair"}

	MadCrosshairOptions.Options["#Default"] = {
		mad_crosshair_r =	"255",
		mad_crosshair_g =	"255",
		mad_crosshair_b =	"255",
		mad_crosshair_a =	"200",
		mad_crosshair_l =	"30",
		mad_crosshair_t =	"1"
   }
									
	MadCrosshairOptions.CVars = {
		"mad_crosshair_r",
		"mad_crosshair_g",
		"mad_crosshair_b",
		"mad_crosshair_a",
		"mad_crosshair_l",
		"mad_crosshair_t"
	}
						
	panel:AddControl("ComboBox", MadCrosshairOptions)

	panel:AddControl("CheckBox", {
		Label = "Enable Crosshair",
		Command = "mad_crosshair_t",
	})

	panel:AddControl("Color", {
		Label 	= "Crosshair Color",
		Red 		= "mad_crosshair_r",
		Green 	= "mad_crosshair_g",
		Blue 		= "mad_crosshair_b",
		Alpha 	= "mad_crosshair_a",
	})

	panel:AddControl("Slider", {
		Label 	= "Crosshair Length",
		Command 	= "mad_crosshair_l",
		Type 		= "Integer",
		Min 		= "5",
		Max 		= "100",
	})
    
	panel:AddControl("CheckBox", {
		Label = "Enable Viewbob",
		Command = "cl_viewbob",
	})
    
	panel:AddControl("CheckBox", {
		Label = "Enable weapon Info",
		Command = "cl_weaponinfo",
	})
end


/*---------------------------------------------------------
   Name: AdminOptions()
---------------------------------------------------------*/
local function AdminOptions(panel)
	if not LocalPlayer():IsAdmin() then return end

	panel:AddControl("Label", {Text = ""})
	
	panel:AddControl("Label", {
		Text = "Normal Weapon Settings:"
	})

	local AdminOptions = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "mad_cows_weapon"}

	AdminOptions.Options["#Default"] = {mad_recoilmul 	=	"1", mad_damagemul 	=	"1", sim_accuracymul 	=	"1", sim_walk_speed 	=	"250", sim_run_speed 	=	"500"}
									
	AdminOptions.CVars = {"mad_recoilmul", "mad_damagemul", "sim_accuracymul", "sim_walk_speed", "sim_run_speed","sim_weightmod_t","sim_manualholster_t","sim_flash_t","sim_shell_t"}
						
	panel:AddControl("ComboBox", AdminOptions)

	panel:AddControl("Slider", {
		Label 	= "Damage Multiplier",
		Command 	= "mad_damagemul",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "10",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Recoil Multiplier",
		Command 	= "mad_recoilmul",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "10",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Move Limit",
		Command 	= "PlayerSpeed_MoveLimit_Mul",
		Type 		= "Float",
		Min 		= "0.2",
		Max 		= "0.7",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Walk Speed",
		Command 	= "Playerspeed_walkspeed",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "250",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Run Speed",
		Command 	= "Playerspeed_runspeed",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "300",
	})
	panel:AddControl("CheckBox", {
		Label = "Custom Speeds",
		Command = "PlayerSpeed_CustomSpeeds",
	})
	panel:AddControl("CheckBox", {
		Label = "Move Limit",
		Command = "PlayerSpeed_MoveLimit",
	})
		panel:AddControl("CheckBox", {
		Label = "Falldamage",
		Command = "mp_falldamage",
	})
		panel:AddControl("CheckBox", {
		Label = "FLIR Toggle",
		Command = "toggle_FLIR",
	})
end	
/*---------------------------------------------------------
   Name: MadCowsToolMenu()
---------------------------------------------------------*/
function MadCowsToolMenu()

	spawnmenu.AddToolMenuOption("Options", "Mad Cows Weapons", "Crosshair Options", "Clientstuff", "", "", MadCrosshairOptions, {SwitchConVar = 'mad_crosshair_t'})
	spawnmenu.AddToolMenuOption("Options", "Mad Cows Weapons", "Admin Options", "Admin Options", "", "", AdminOptions)
end
hook.Add("PopulateToolMenu", "MadCowsToolMenu", MadCowsToolMenu)