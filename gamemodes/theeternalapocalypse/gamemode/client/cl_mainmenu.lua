local Close
local ambsound
local playmmsound = false
local sound_choice = 1
local sound_choices = {
	{"main_menu_sound/menu.ogg", 158},
	{"main_menu_sound/menu_alt.ogg", 184},
}

net.Receive("tea_player_ready_spawn", function()
	local wasready = net.ReadBool()

	if GAMEMODE.MainMenuPanel and GAMEMODE.MainMenuPanel:IsValid() then
		GAMEMODE.MainMenuPanel:Remove()
	end

	Close()
end)


function GM:LoadMainMenu()
	if self.MainMenuPanel and self.MainMenuPanel:IsValid() then return end
	self.MainMenuPanel = vgui.Create("DPanel")
	self.MainMenuPanel:SetSize(ScrW(), ScrH())
	self.MainMenuPanel:MakePopup()

	function Close()
		local snd = ambsound
		-- snd:ChangeVolume(0.01, 3)
		if playmmsound then
			snd:FadeOut(3)
			timer.Create("TheEternalApocalypse.StartMenu.StopSound", 3, 1, function()
				if snd then
					snd:Stop()
				end
			end)
		end

		gui.EnableScreenClicker(false)
	end

	local _timer = 10
	local soundvol = 1
	local sound = sound_choices[sound_choice][1]
	local function SoundDur()
		return sound_choices[sound_choice][2]
	end


	self.MainMenuPanel.Think = function(self)
		local time = RealTime()

		if playmmsound and ambsound and time >= self.CreationTime + 5 then
			if self.LastPlayedSound + self.SoundDur < RealTime() or !ambsound:IsPlaying() then
				self.LastPlayedSound = RealTime()
				self.SoundDur = SoundDur(sound)
				ambsound:Stop()
			end
			ambsound:PlayEx(soundvol, 100)
		end

	end
	self.MainMenuPanel.Paint = function(self)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, ScrW(), ScrH())

/*
		local time = RealTime()
		draw.DrawText(
			time >= self.CreationTime + 600 and "guess i'll stay silent then" or
			time >= self.CreationTime + 500 and "so, what else to say here?" or
			time >= self.CreationTime + 450 and "It was a joke... unlesss you missed it" or
			time >= self.CreationTime + 300 and "\"You will be kicked soon due to inactivity.\"" or
			time >= self.CreationTime + 270 and "..." or
			time >= self.CreationTime + 240 and "\"Inactivity warning! Please move!\"" or
			time >= self.CreationTime + 150 and "..." or
			time >= self.CreationTime + 100 and "you there?" or
			time >= self.CreationTime + 60 and "uh" or "", "TargetIDSmall", ScrW() / 2, ScrH()-60, Color(255,255,255,255), TEXT_ALIGN_CENTER
		)
*/		
	end
	self.MainMenuPanel.CreationTime = RealTime()
	self.MainMenuPanel.LastPlayedSound = RealTime()
	self.MainMenuPanel.OnRemove = Close
	self.MainMenuPanel.OnClose = Close

	
	
	if timer.Exists("TheEternalApocalypse.StartMenu.StopSound") then
		timer.Destroy("TheEternalApocalypse.StartMenu.StopSound")
		if playmmsound and ambsound then
			-- ambsound:ChangeVolume(0.01, 0)
			ambsound:Stop()
		end
	end

	-- LocalPlayer():EmitSound("buttons/button14.wav", 0, 200)


	if playmmsound then
		ambsound = CreateSound(LocalPlayer(), sound)
		ambsound:SetSoundLevel(0)
		timer.Simple(_timer, function()
			if !self.MainMenuPanel or !self.MainMenuPanel:IsValid() then return end
			ambsound:PlayEx(0, 100)
			ambsound:ChangeVolume(0.01, 0)
			ambsound:ChangeVolume(soundvol, 5)
			self.MainMenuPanel.LastPlayedSound = RealTime()
		end)
	end
	self.MainMenuPanel.SoundDur = SoundDur(sound)


	local title = vgui.Create("DLabel", self.MainMenuPanel)
	title:SetPos(0, 130)
	title:MoveTo(50, 130, 3)
	title:SetText(translate.Get("the_eternal_apocalypse"))
	title:SetFont("Trebuchet24")
	title:SizeToContents()

	local desc = vgui.Create("DLabel", self.MainMenuPanel)
	desc:SetPos(0, 170)
	desc:MoveTo(50, 170, 3.5)
	desc:SetText(translate.Get("the_eternal_apocalypse_desc"))
	desc:SetFont("Trebuchet18")
	desc:SizeToContents()

	local note = vgui.Create("DLabel", self.MainMenuPanel)
	note:SetPos(0, 200)
	note:MoveTo(50, 200, 3.5)
	note:SetTextColor(Color(127,255,255))
	note:SetText("Please note, this is a beta version. Some things may not work as expected.\nAdding new options to main menu soon!")
	note:SetFont("Trebuchet18")
	note:SizeToContents()

	local button = vgui.Create("DButton", self.MainMenuPanel)
	button:SetPos(0, 260)
	button:MoveTo(50, 260, 3.5)
	button:SetSize(120, 25)
	button:SetText(translate.Get("play"))
	button:SetTextColor(Color(255,255,255))
	button:SetFont("TargetIDSmall")
	button.DoClick = function(self)
		net.Start("tea_player_ready_spawn")
		net.SendToServer()
	end

	local button = vgui.Create("DButton", self.MainMenuPanel)
	button:SetPos(0, 290)
	button:MoveTo(50, 290, 3.5)
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
	"This remort requirememnt to skills encourages players to remort. - Zombie Survival gmod servers with skill requiring certain amount of remorts",
}

local randomtips2 = {
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
