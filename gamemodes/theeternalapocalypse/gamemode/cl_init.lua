include("shared.lua")
include("sh_translate.lua") -- translation file
include("sh_items.lua") -- items for inventory
include("sh_loot.lua") -- for loots
include("sh_spawnables.lua") -- spawnable props with build tool
include("sh_config.lua") -- gamemode config
include("sh_crafting.lua") -- list for craftable items
include("sh_achievements.lua") -- achievements
include("sh_deathsounds.lua")

include("client/cl_scoreboard.lua")
include("client/cl_hud.lua")
include("client/cl_modelsmenu.lua")
include("client/cl_createfaction.lua")
include("client/cl_contextmenu.lua")
include("client/cl_customdeathnotice.lua")
include("client/cl_spawnmenu.lua")
include("client/cl_tradermenu.lua")
include("client/cl_dermahooks.lua")
include("client/cl_lootmenu.lua")
include("client/cl_adminmenu.lua")
--include("client/cl_deathscreen.lua")
include("client/cl_statsmenu.lua")
include("client/cl_helpmenu.lua")
include("client/cl_bosspanel.lua")
include("client/cl_options.lua")
include("client/cl_changelogs.lua")


CreateClientConVar("tea_cl_hud", 1, true, false, "Enable The Eternal Apocalypse HUD", 0, 1)
CreateClientConVar("tea_cl_hudstyle", 0, true, false, "Switch between HUD styles", 0, 1)
CreateClientConVar("tea_cl_soundboss", 1, true, true, "Should play HL2 Stinger sound when boss appears?", 0, 1)
CreateClientConVar("tea_cl_deathsfx", 1, true, true, "Play Sound Effect on dying?", 0, 1)
CreateClientConVar("tea_cl_deathsfx_vol", 1, true, true, "How loud should be death sound effect?", 0, 1)
CreateClientConVar("tea_cl_deathsound", "theeternalapocalypse/gameover_music.wav", true, false, "Play sound effect on death. Use the valid sound or the sound effect will not play! Tip: Use string '*#' at start of convar string to play the sound as music")
CreateClientConVar("tea_cl_hitsounds", 1, true, true, "Play sound on dealing damage to zombies and players", 0, 1)
CreateClientConVar("tea_cl_hitsounds_vol", 0.3, true, true, "Volume ratio of playing hitsound when dealing damage to players", 0, 1)
CreateClientConVar("tea_cl_hitsounds_volnpc", 0.225, true, true, "Volume ratio of playing hitsound when dealing damage to NPC's and nextbots", 0, 1)
CreateClientConVar("tea_cl_huddec", 0, true, false, "Enables decimal values on HUD elements, mostly Stamina, Hunger, Thirst, etc.", 0, 1)
CreateClientConVar("tea_cl_usereloadtopickup", 0, true, true, "Enables whether reload key needs to be held while picking up an item", 0, 1)
CreateClientConVar("tea_cl_noearrings", 0, true, true, "Disables annoying sound when taking damage from explosions", 0, 1)

CreateClientConVar("tea_cl_admin_fpdeath", 1, true, false, "Enables first person death. Will not be disabled if not admin!", 0, 1)
CreateClientConVar("tea_cl_admin_noviseffects", 0, true, false, "Disables vision effects on low health, or when dead. Requires admin perms to be enabled!!", 0, 1)



local death_sound_volume = 0
local death_sound_volume_s = 0
local death_sound_current = GetConVar("tea_cl_deathsound"):GetString()
SelectedProp = SelectedProp or "models/props_debris/wood_board04a.mdl" -- need to set this to something here to avoid a massive error spew

function ChooseProp( mdl )
	SelectedProp = mdl
	net.Start("ChangeProp")
	net.WriteString(mdl)
	net.SendToServer()
end

function ChooseStructure( struc )
	SelectedProp = SpecialSpawns[struc]["Model"]
	net.Start("ChangeProp")
	net.WriteString(struc)
	net.SendToServer()
end

function BetterScreenScale()
	return math.max(ScrH() / 1080, 0.851)
end

function GM:LocalPlayerDeath(attacker)
	death_sound_volume = GetConVar("tea_cl_deathsfx_vol"):GetFloat()
	death_sound_volume_s = 0.015 * death_sound_volume
	death_sound_current = GetConVar("tea_cl_deathsound"):GetString()
	if GetConVar("tea_cl_deathsfx"):GetInt() >= 1 then
		EmitSound(GetConVar("tea_cl_deathsound"):GetString(), LocalPlayer():GetPos(), -1, CHAN_AUTO, death_sound_volume, 0)
	end
	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0
	self.MyLastSurvivalStats.SurvivalTime = CurTime() - MySurvivaltime
	self.MyLastSurvivalStats.BestSurvivalTime = MyBestsurvtime

end

function GM:Think()
end

function GM:Tick()
	if !LocalPlayer():IsValid() then return end
	local function FrameCalc(number) -- there's a function because possibly when having low framerate, these value updates are less frequent...
		local n = number * (math.max(1 / 66.6, FrameTime()) * 66.6)
		return n
	end

	if GetConVar("tea_cl_deathsfx"):GetInt() >= 1 then
		if LocalPlayer():Alive() then
			if death_sound_volume > 0 then
				EmitSound(death_sound_current, LocalPlayer():GetPos(), -1, CHAN_AUTO, death_sound_volume, 0, SND_CHANGE_VOL)
			else
				EmitSound(death_sound_current, LocalPlayer():GetPos(), -1, CHAN_AUTO, death_sound_volume, 0, SND_STOP)
			end
		end
	else
		death_sound_volume = 0
		EmitSound(death_sound_current, LocalPlayer():GetPos(), -1, CHAN_AUTO, death_sound_volume, 0, SND_STOP)
	end

	if LocalPlayer():Alive() then
		death_sound_volume = death_sound_volume - FrameCalc(death_sound_volume_s)
		self.tea_screenfadeout = math.Clamp(self.tea_screenfadeout - FrameCalc(3 * 1.175), 0, 255)
		self.tea_deathtext_a = math.Clamp(self.tea_deathtext_a - FrameCalc(5 * 1.175), 0, 255)
		self.tea_survivalstats_a = math.Clamp(self.tea_survivalstats_a - FrameCalc(5 * 1.175), 0, 255)
	else
		self.tea_screenfadeout = self.tea_screenfadeout + FrameCalc(2.5 * 1.175)
		if 0 < tonumber(self.tea_screenfadeout) - 270 then
			self.tea_deathtext_a = self.tea_deathtext_a + FrameCalc(2 * 1.175)
		end
		if 0 < tonumber(self.tea_screenfadeout) - 600 then
			self.tea_survivalstats_a = self.tea_survivalstats_a + FrameCalc(2 * 1.175)
		end
	end

	if RealTime() > (self.NextTip or 0) then
		local tea_Tips = {
			{Color(255, 127, 143), translate.Get("Tip1")},
			{Color(127, 127, 255), translate.Get("Tip2")},
			{Color(159, 127, 223), translate.Get("Tip3")},
			{Color(95, 223, 95), translate.Get("Tip4")},
			{Color(159, 159, 159), translate.Get("Tip5")},
			{Color(191, 95, 191), translate.Get("Tip6")},
			{Color(127, 159, 127), translate.Get("Tip7")},
			{Color(223, 127, 159), translate.Get("Tip8")},
			{Color(143, 159, 223), translate.Get("Tip9")},
			{Color(191, 127, 159), translate.Get("Tip10")},
			{Color(63, 255, 223), translate.Get("Tip11")},
			{Color(165, 223, 209), translate.Get("Tip12")},
			{Color(239, 223, 223), translate.Get("Tip13")},
			{Color(207, 191, 255), translate.Get("Tip14")},
			{Color(0, 223, 255), translate.Get("Tip15")},
			{Color(31, 223, 223), translate.Get("Tip16")}
		}

		local tip = table.Random(tea_Tips)
		chat.AddText(Color(255,255,255), "[", Color(255,223,223), "The Etenal Apocalypse tip", Color(255,255,255), "]", Color(223,223,223), ": ", tip[1], tip[2])
		self.NextTip = RealTime() + 360
	end
end

function GM:SetupFonts()
	surface.CreateFont("DefaultFontSmall", {
		font = "tahoma",
		size = 11,
		weight = 0,
		antialias = false}
	)

	surface.CreateFont("AmmoText", {
		font	= "arial",
		size	= 30,
		weight	= 700,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DeathScreenText", {
		font	= "arial",
		size	= 42,
		weight	= 650,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DeathScreenText_2", {
		font	= "arial",
		size	= 24,
		weight	= 300,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("DeathScreenText_3", {
		font	= "arial",
		size	= 32,
		weight	= 450,
		blursize	= 0,
		scanlines	= 0,
		antialias	= false,
	})
	
	surface.CreateFont("OtherText", {
		font	= "arial",
		size	= 15,
		weight	= 700,
		blursize	= 0,
		scanlines	= 0,
		antialias	= true,
	})

	surface.CreateFont("CounterShit", {
	    font	= "csd",
	    size	= 38,
	    weight	= 400,
	    antialias	= true,
	    shadow	= false
	})
end

function GM:Initialize()
	self.BaseClass:Initialize()

	self:SetupFonts()

	MyStamina = 0
	MyHunger = 0
	MyThirst = 0
	MyFatigue = 0
	MyInfection = 0
	MySurvivaltime = 0
	MyBattery = 0
	MyLvl = 0
	MyPrestige = 0
	MyMoney = 0
	MyXP = 0
	MySP = 0
	MyBounty = 0

	MyBestsurvtime = 0
	MyZmbskilled = 0
	MyPlyskilled = 0
	MyPlydeaths = 0
	MyMMeleexp = 0
	MyMMeleelvl = 0
	MyMPvpxp = 0
	MyMPvplvl = 0
	
	LocalInventory = {}
	LocalVault = {}
	InventoryItems = {}
	InventoryWeapons = {}
	Perks = {}
	Perksdesc = {}

	self.tea_screenfadeout = 0
	self.tea_deathtext_a = 0
	self.tea_survivalstats_a = 0
	self.NextTip = RealTime() + 360
	self.DeathMessage = ""

	self.MyLastSurvivalStats = {}
	self.MyLastSurvivalStats.SurvivalTime = 0
	self.MyLastSurvivalStats.BestSurvivalTime = 0
	self.MyLastSurvivalStats.PlayersKilled = 0
	self.MyLastSurvivalStats.ZombiesKilled = 0
	
	RunConsoleCommand("refresh_inventory")
end

function GM:InitPostEntity()
	chat.AddText(Color(255,192,255), "[The Eternal Apocalypse]: ", Color(255,255,192), "Please note, this is a beta version. Some things may not work as intended. ", Color(255,255,192), "If you do find those bugs, please report them to the developer.")
	chat.AddText(Color(192,255,255), "- Uklejamini [The Eternal Apocalypse Dev]")
end

function GM:PostProcessPermitted( name )
	return false
end

-- copied from zs yet again, used for most panels, much easier and size saving
function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function EasyButton(parent, text, xpadding, ypadding)
	local dpanel = vgui.Create("DButton", parent)
	if textcolor then
		dpanel:SetFGColor(textcolor or color_white)
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()

	if xpadding then
		dpanel:SetWide(dpanel:GetWide() + xpadding * 2)
	end

	if ypadding then
		dpanel:SetTall(dpanel:GetTall() + ypadding * 2)
	end

	return dpanel
end

ChosenModel = ""

function DeathView(player, origin, angles, fov)
	local View

	if !player:Alive() then
		local Ragdoll = player:GetRagdollEntity()
		if (Ragdoll:IsValid() and AdminCheck(player) and GetConVar("tea_cl_admin_fpdeath"):GetInt() >= 1) or (!AdminCheck(player) and Ragdoll:IsValid()) then
			local Eyes = Ragdoll:GetAttachment(Ragdoll:LookupAttachment("Eyes"))
			if Eyes then
				View = {origin = Eyes.Pos, angles = Eyes.Ang, fov = 90}
				return View
			end
		else
			View = {origin = player:GetPos() + Vector(0, 0, 4)}
			return View
		end
	end
end
hook.Add("CalcView", "DeathView", DeathView, HOOK_LOW) --now more compatible with mappatcher

function GM:OnReloaded()
	timer.Simple(1, function()
		RunConsoleCommand("refresh_inventory")
	end)
	print(self.Name.." gamemode files reloaded")
end

function GM:OnUndo( name, strCustomString )
-- this is still needed by the test zombies function
	notification.AddLegacy("Undo: "..name, 2, 3)
	surface.PlaySound("buttons/button15.wav")
end


net.Receive("SystemMessage", function(length, client)
	local msg = net.ReadString()
	local col = net.ReadColor()
	local sys = net.ReadBool()

	if sys then
		chat.AddText(Color(255,255,255,255), "[System] ", col, msg)
	else
		chat.AddText(col, msg)
	end
end)


local radiosounds = {
	"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
	"npc/metropolice/vo/wearesociostablethislocation.wav",
	"npc/metropolice/vo/readytoprosecutefinalwarning.wav",
	"npc/metropolice/vo/pickingupnoncorplexindy.wav",
	"npc/metropolice/vo/malcompliant10107my1020.wav",
	"npc/metropolice/vo/ivegot408hereatlocation.wav",
	"npc/metropolice/vo/investigating10-103.wav",
	"npc/metropolice/vo/ihave10-30my10-20responding.wav",
	"npc/metropolice/vo/holdingon10-14duty.wav",
	"npc/metropolice/vo/gota10-107sendairwatch.wav",
	"npc/metropolice/vo/get11-44inboundcleaningup.wav",
	"npc/metropolice/vo/hidinglastseenatrange.wav"
}

net.Receive("RadioMessage", function(length, client)
	local sender = net.ReadString()
	local msg = net.ReadString()
	local rad = net.ReadBool()

	chat.AddText( Color(155,255,155,255), "[Radio] "..sender..": ", Color(205,205,205,255), msg )
	if rad then
		surface.PlaySound(table.Random(radiosounds))
	end
end)


function GM:OnPlayerChat(ply, text, team, dead)
	local tab = {}
	if dead || (IsValid(ply) && ply:Team() == TEAM_DEAD) then
		table.insert(tab, Color(191, 30, 40))
		table.insert(tab, "*Dead* ")
	end

	if team then
		table.insert(tab, Color(30, 160, 40))
		table.insert(tab, "(Team) ")
	end

	if IsValid(ply) then
		if ply:SteamID64() == "76561198274314803" then
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "[")
			table.insert(tab, Color(224,224,160))
			table.insert(tab, "Gamemode Author")
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "] ")
		elseif TEASVOwnerCheck(ply) then
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "[")
			table.insert(tab, Color(160,0,0))
			table.insert(tab, "Server Owner")
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "] ")	
		elseif TEADevCheck(ply) then
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "[")
			table.insert(tab, Color(160,160,192))
			table.insert(tab, "Dev")
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "] ")
		elseif SuperAdminCheck(ply) then
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "[")
			table.insert(tab, Color(96,96,160))
			table.insert(tab, "Superadmin")
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "] ")
		elseif AdminCheck(ply) then
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "[")
			table.insert(tab, Color(160,128,160))
			table.insert(tab, "Admin")
			table.insert(tab, Color(160,160,160))
			table.insert(tab, "] ")
		end

		table.insert(tab, ply)
	else
		table.insert(tab, "Console")
	end

	table.insert(tab, Color(255,255,255))
	table.insert(tab, ": "..text)

	chat.AddText(unpack(tab))
	return true
end


function ATEHelpZombies()
print("Zombies Help:\n")
print("There are currently 8 zombie types. Killing each of them gives different cash and XP.")
print("Each zombie has unique abilities and stats. From leaping to calling zombies.")
print("There is currently one boss, The Tyrant. It can throw rocks, that causes tremendous damage")
print("and can cause a shockwave. It is also extremely tough, so having plenty of ammo to kill it is a must.")
end
concommand.Add("tea_help_zombies", ATEHelpZombies)

function ATEHelpTrader()
print("Trader Help:\n")
print("Trader has various items that can sell to you, such as food, weapons, armor and more.")
print("Some items are not sold by trader and must be found as a loot. Such items apply")
print("to rare weapons, some weapons that can be found from bosses and airdrops.")
print("Traders can also buy items from you, but they pay you for less price.")
end
concommand.Add("tea_help_trader", ATEHelpTrader)

function ATEHelpSkills()
print("Skills Help:\n")
print("Barter Skill: Decreases items cost by 1.5% per level and Increases gaining money from selling items by 5%.")
print("Damage Skill: Increases damage dealt against players and zombies by 2.5% per level.")
print("Defense Skill: Increases protection from zombies by 2.5% per level.")
print("Endurance Skill: Decreases stamina loss by 3.33% while sprinting and underwater per level and decreases stamina loss while landing by 4%.")
print("Engineer Skill: Increases Max Armor by 2 units per level, and increases effectiveness of armor items by 2% per level.")
print("Health Skill: Increases Max Health by 5 units per level.")
print("Immunity Skill: Decreases infection progressing by 5% per level, infection chance from zombies by 4% per level and .")
print("Knowledge Skill: Increases XP Gaining by 2% per level.")
print("MedSkill Skill: Increases Medical Effectiveness by 2% per level, and +1HP/10s regenerated on per every 10 levels.")
print("Salvage Skill: Increases Money gain by 2% per level.")
print("Speed Skill: Increases Walking Speed by 3.5 units and 7 units per level.")
print("Strength Skill: Increases max carry weight by 1.53kg per level.")
print("Survivor Skill: Decreases hunger decreasing by 4% per level and decreases fatigue progressing by 3.5% per level.")
end
concommand.Add("tea_help_skills", ATEHelpSkills)
