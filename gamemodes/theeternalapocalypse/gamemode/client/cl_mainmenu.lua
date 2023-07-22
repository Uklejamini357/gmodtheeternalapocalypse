net.Receive("tea_player_ready_spawn", function()
	local wasready = net.ReadBool()

	if !wasready then
		
	end

	if GAMEMODE.MainMenuPanel and GAMEMODE.MainMenuPanel:IsValid() then
		GAMEMODE.MainMenuPanel:Remove()
	end
end)


function GM:LoadMainMenu()
	if self.MainMenuPanel and self.MainMenuPanel:IsValid() then return end
	self.MainMenuPanel = vgui.Create("DPanel")
	self.MainMenuPanel:SetSize(ScrW(), ScrH())
	self.MainMenuPanel.Paint = function(self)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end
	self.MainMenuPanel:MakePopup()

	local label = vgui.Create("DLabel", self.MainMenuPanel)
	label:SetPos(0, ScrH()/3)
	label:SetText(translate.Get("the_eternal_apocalypse"))
	label:SetFont("Trebuchet24")
	label:SizeToContents()
	label:CenterHorizontal()

	local labeltips = vgui.Create("DLabel", self.MainMenuPanel)
	labeltips:SetPos(0, ScrH()/2.6)
	labeltips:SetText(translate.Get("the_eternal_apocalypse_desc"))
	labeltips:SetFont("Trebuchet18")
	labeltips:SizeToContents()
	labeltips:CenterHorizontal()

	local button = vgui.Create("DButton", self.MainMenuPanel)
	button:SetPos(ScrW()/2-60, ScrH()/2+110)
	button:SetSize(120, 25)
	button:SetText(translate.Get("play"))
	button:SetTextColor(Color(255,255,255))
	button:SetFont("TargetIDSmall")
	button.DoClick = function(self)
		net.Start("tea_player_ready_spawn")
		net.SendToServer()
--		GAMEMODE.MainMenuPanel:Remove()
	end

	local button = vgui.Create("DButton", self.MainMenuPanel)
	button:SetPos(ScrW()/2-60, ScrH()/2+150)
	button:SetSize(120, 25)
	button:SetText(translate.Get("disconnect"))
	button:SetTextColor(Color(255,205,205))
	button:SetFont("TargetIDSmall")
	button.DoClick = function(self)
		RunConsoleCommand("disconnect")
	end


	return self.MainMenuPanel
end

local randomtips = {
	"Getting to prestige 1 shouldn't take a long time... And it took me 14 days to do that.",
	"Next update in 5 hours. - Antimatter Dimensions",
	"If you're reading this, you can read. - Antimatter Dimensions",
	"9th dimension when?? - Antimatter Dimensions",
	"DELETE LEVEL 15!! - Clash royale community",
	"This remort requirememnt to skills encourages players to remort. - Zombie Survival gmod servers with skill requiring certain amount of remorts",
	"This is fine. - (Insert meme here)",
}

local randomtips2 = {
	"Keep on trying... you'll get it!",
	"There are seasonal events... they occur when Halloween or Christmas event is ongoing!",
}

local randomtip = table.Random(randomtips)
local randomtip2 = table.Random(randomtips2)

hook.Add("DrawOverlay", "TEA_DrawOverlay", function()
	if GAMEMODE.HasInitialized then return end
	cam.Start2D()
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, ScrW(), ScrH())
	draw.DrawText(translate.Get("loading"), "TargetID", ScrW()/2, ScrH()/3, Color(255,255,255), TEXT_ALIGN_CENTER)
--	draw.DrawText(randomtip, "TargetIDSmall", ScrW()/2, ScrH()/1.5, Color(255,255,255), TEXT_ALIGN_CENTER)
--	draw.DrawText(randomtip2, "TargetIDSmall", ScrW()/2, ScrH()/1.5 + 60, Color(255,255,255), TEXT_ALIGN_CENTER)
	cam.End2D()
end)
