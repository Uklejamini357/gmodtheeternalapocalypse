include("shared.lua")
include("sh_translate.lua")
include("sh_items.lua")
include("sh_loot.lua")
include("sh_spawnables.lua")
include("sh_config.lua")
include("sh_crafting.lua")
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


SelectedProp = "models/props_debris/wood_board04a.mdl" -- need to set this to something here to avoid a massive error spew

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

function GM:Initialize()
	self.BaseClass:Initialize()
surface.CreateFont("AmmoText", {
	font	= "arial",
	size	= 30,
	weight	= 700,
	blursize	= 0,
	scanlines	= 0,
	antialias	= true,
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

function GM:PostProcessPermitted( name )
	return false
end

ChosenModel = ""

function DeathView( player, origin, angles, fov )
if( !player:Alive() ) then
	local Ragdoll = player:GetRagdollEntity()
	if ( Ragdoll ) then
		local IsValid = Ragdoll:IsValid()
		if ( IsValid ) then
			local Eyes = Ragdoll:GetAttachment( Ragdoll:LookupAttachment( "Eyes" ) )
			if ( Eyes ) then		
				local View = { origin = Eyes.Pos, angles = Eyes.Ang, fov = 90 }
				return View
			end
		end
	end
end 
end
hook.Add( "CalcView", "DeathView", DeathView )

function GM:OnReloaded()
	timer.Simple(1, function()
		RunConsoleCommand("refresh_inventory")
	end)
	print(GM.Name.." files reloaded")
end

function GM:OnUndo( name, strCustomString )
	
-- this is still needed by the test zombies function
	notification.AddLegacy( "Undo: "..name, 2, 3 )
	surface.PlaySound( "buttons/button15.wav" )

end


net.Receive( "SystemMessage", function( length, client )
	local msg = net.ReadString()
	local col = net.ReadColor()
	local sys = net.ReadBool()

	if sys then
		chat.AddText( Color(255,255,255,255), "[System] ", col, msg )
	else
		chat.AddText( col, msg )
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

CreateClientConVar("tea_cl_hud", 1, true, false, "Enable The Eternal Apocalypse HUD", 0, 1)
CreateClientConVar("tea_cl_hudstyle", 0, true, false, "Switch between HUD styles", 0, 1)
CreateClientConVar("tea_cl_soundboss", 1, true, true, "Should play HL2 Stinger sound when boss appears?", 0, 1)
CreateClientConVar("tea_cl_deathsfx", 1, true, true, "Play Sound Effect on dying?", 0, 1)
CreateClientConVar("tea_cl_deathsound", "theeternalapocalypse/gameover_music.wav", true, false, "Play sound effect on death. Use the valid sound or the sound effect will not play! Tip: Use string '*#' at start of convar string to play the sound as music")
CreateClientConVar("tea_cl_hitsounds", 1, true, true, "Play sound on dealing damage to zombies and players", 0, 1)
CreateClientConVar("tea_cl_hitsounds_vol", 0.3, true, true, "Volume ratio of playing hitsound when dealing damage to players", 0, 1)
CreateClientConVar("tea_cl_hitsounds_volnpc", 0.225, true, true, "Volume ratio of playing hitsound when dealing damage to NPC's and nextbots", 0, 1)


function ATEHelp()
print("Help:\n")
print("Welcome to The Eternal Apocalypse. This is known as a remake of After The End. But better, harder and improved...")
print("A help panel may be added in future. For the sake of some inconvenience, some of commands were removed.")
print("For more help, enter one of those command below:\n")
print("ate_help_general - Prints General Help into console")
print("ate_help_stats - Prints Stats Help into console")
print("ate_help_zombies - Prints Zombies Help into console")
print("ate_help_trader - Prints Trader Help into console")
print("ate_help_loot - Prints Loot Help into console")
print("ate_help_skills - Prints Skills Help into console\n")
print("ate_admin_help_debugging - Some debug stuff for superadmins")
end
concommand.Add("tea_help", ATEHelp)

function ATEHelpGeneral()
print("General Help:\n")
print("When you spawn in, you get fists and build tool. You can never lose those items. However, you can lose weapons if you hold them in your hands and die.")
print("This is survival gamemode. The goal is to survive, not getting killed by zombies, find loot and level up in order to gain more rewards.")
print("By killing zombies, you gain xp and bounty, then cash in your bounty at trader. Then use your skill points to gain more advantage in survivalism.")
end
concommand.Add("tea_help_general", ATEHelpGeneral)

function ATEHelpStats()
print("Stats Help:\n")
print("Statistics are the core of this gamemode. For Example, Health is very important. If you reach it to 0%, you die.")
print("Armor Battery is half important as health. It protects 80% from some of the damage you take")
print("Stamina is important when running. Running and swimming underwater will cause it to go down, depending on your Endurance level.")
print("However, moving around will reduce stamina regeneration, even when not moving, but crouching.")
print("Landing onto ground with velocity between 150 and 499 (in hammer units) will drain 10% of your stamina and above 500 will drain 20% of your stamina.")
print("This will also depend on Endurance level.")
print("Hunger is also important. If you do not eat, you will succumb to starvation and die. This can be countered by eating food.\n\n")
print("Additional info:")
print("If your stamina is depleted, you won't be able to sprint until you get your stamina to at least 30%.")
end
concommand.Add("tea_help_stats", ATEHelpStats)

function ATEHelpZombies()
print("Zombies Help:\n")
print("There are 7 zombie types. Killing each of them gives different cash and XP.")
print("Each zombie has unique abilities and stats. From leaping to calling zombies.")
print("There is currently one boss, The Tyrant. It can throw rocks, that causes tremendous damage")
print("and can cause a shockwave. It is also extremely tough, so having plenty of ammo is a must.")
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

function ATEHelpLoot()
print("Loot Help:\n")
print("In some positions and once every while, a loot cache may occasionally spawn.")
print("However, it has a low chance of spawning as a loot cache that contains a weapon.")
print("Bosses can also drop their loot cache, containing special and unique items.")
print("Airdrop caches can also have same loot as boss caches, as well as additional items found.")
print("This includes junk items that are completely useless.\n")
print("Once you pick up ANY of the loot mentioned above, including the airdrop caches being opened, a message will be broadcasted in chat.")
end
concommand.Add("tea_help_loot", ATEHelpLoot)

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

function ATEHelpAdminDebugging()
print("Admin Debugging Help:\n")
print("You cannot.")

end
concommand.Add("tea_admin_help_debugging", ATEHelpAdminDebugging)