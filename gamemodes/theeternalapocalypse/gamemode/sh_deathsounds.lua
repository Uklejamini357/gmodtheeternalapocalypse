-- List of sounds that should be played when player dies, depending on their player model
-- if value is nil then use default death sound


GM.PlayerModel_DeathSounds = {
	["FemaleSounds"] = {
		"vo/npc/female01/pain01.wav",
		"vo/npc/female01/pain02.wav",
		"vo/npc/female01/pain03.wav",
		"vo/npc/female01/pain04.wav",
		"vo/npc/female01/pain05.wav",
		"vo/npc/female01/pain06.wav",
		"vo/npc/female01/pain07.wav",
		"vo/npc/female01/pain08.wav",
		"vo/npc/female01/pain09.wav"
	},
	
	["MaleSounds"] = {
		"vo/npc/male01/no02.wav",
		"vo/npc/male01/pain01.wav",
		"vo/npc/male01/pain02.wav",
		"vo/npc/male01/pain03.wav",
		"vo/npc/male01/pain04.wav",
		"vo/npc/male01/pain05.wav",
		"vo/npc/male01/pain06.wav",
		"vo/npc/male01/pain07.wav",
		"vo/npc/male01/pain08.wav",
		"vo/npc/male01/pain09.wav"
	},

	["Stalker_BanditSounds"] = {
		"npc/bandit/death_1.ogg",
		"npc/bandit/death_2.ogg",
		"npc/bandit/death_3.ogg",
		"npc/bandit/death_4.ogg",
		"npc/bandit/death_5.ogg",
		"npc/bandit/death_6.ogg",
		"npc/bandit/death_7.ogg"
	},

	["Stalker_DutySounds"] = {
		"npc/duty/death_1.ogg",
		"npc/duty/death_2.ogg",
		"npc/duty/death_3.ogg"
	},
	
	["Stalker_FreedomSounds"] = {
		"npc/freedom/death_1.ogg",
		"npc/freedom/death_2.ogg",
		"npc/freedom/death_3.ogg",
		"npc/freedom/death_4.ogg",
		"npc/freedom/death_5.ogg",
		"npc/freedom/death_6.ogg",
		"npc/freedom/death_7.ogg",
		"npc/freedom/death_8.ogg"
	},
	
	["Stalker_KillerSounds"] = {
		"npc/killer/death_1.ogg",
		"npc/killer/death_2.ogg",
		"npc/killer/death_3.ogg",
		"npc/killer/death_4.ogg",
		"npc/killer/death_5.ogg",
		"npc/killer/death_6.ogg",
		"npc/killer/death_7.ogg"
	},
	
	["Stalker_LonerSounds"] = {
		"npc/stalker/death_1.ogg",
		"npc/stalker/death_2.ogg",
		"npc/stalker/death_3.ogg",
		"npc/stalker/death_4.ogg",
		"npc/stalker/death_5.ogg",
		"npc/stalker/death_6.ogg",
		"npc/stalker/death_7.ogg"
	},
	
	["Stalker_MilitarySounds"] = {
		"npc/military/death_1.ogg",
		"npc/military/death_2.ogg",
		"npc/military/death_3.ogg",
		"npc/military/death_4.ogg",
		"npc/military/death_5.ogg"
	},
	
	["Stalker_MonolithSounds"] = {
		"npc/monolit4/death_1.ogg",
		"npc/monolit4/death_2.ogg",
		"npc/monolit4/death_3.ogg",
		"npc/monolit4/death_4.ogg",
		"npc/monolit4/death_5.ogg",
		"npc/monolit4/death_6.ogg",
		"npc/monolit4/death_7.ogg",
		"npc/monolit4/death_8.ogg"
	},
	
}



GM.Deathsounds = {

-- default models
	["models/player/kleiner.mdl"] = nil,
	["models/player/group03/male_01.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_02.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_03.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_04.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_05.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_06.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_07.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_08.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/male_09.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group03/female_01.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group03/female_02.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group03/female_03.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group03/female_04.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group03/female_06.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group01/male_01.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_02.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_03.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_04.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_05.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_06.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_07.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_08.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/male_09.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/group01/female_01.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group01/female_02.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group01/female_03.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group01/female_04.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/group01/female_06.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],
	["models/player/breen.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/Eli.mdl"] = nil,
	["models/player/mossman.mdl"] = GM.PlayerModel_DeathSounds["FemaleSounds"],

-- armor models
	["models/player/stalker/bandit_backpack.mdl"] = GM.PlayerModel_DeathSounds["Stalker_BanditSounds"],
	["models/player/stalker/bandit_brown.mdl"] = GM.PlayerModel_DeathSounds["Stalker_BanditSounds"],
	["models/player/stalker/bandit_black.mdl"] = GM.PlayerModel_DeathSounds["Stalker_BanditSounds"],
	["models/player/guerilla.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/arctic.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/leet.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/phoenix.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/gasmask.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/riot.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/swat.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/urban.mdl"] = GM.PlayerModel_DeathSounds["MaleSounds"],
	["models/player/stalker/loner_vet.mdl"] = GM.PlayerModel_DeathSounds["Stalker_LonerSounds"],
	["models/player/stalker/duty_vet.mdl"] = GM.PlayerModel_DeathSounds["Stalker_DutySounds"],
	["models/player/stalker/freedom_vet.mdl"] = GM.PlayerModel_DeathSounds["Stalker_FreedomSounds"],
	["models/player/stalker/monolith_vet.mdl"] = GM.PlayerModel_DeathSounds["Stalker_MonolithSounds"],
	["models/player/stalker/military_spetsnaz_green.mdl"] = GM.PlayerModel_DeathSounds["Stalker_MilitarySounds"],
	["models/player/stalker/military_spetsnaz_black.mdl"] = GM.PlayerModel_DeathSounds["Stalker_MilitarySounds"],
	["models/player/stalker/loner_exo.mdl"] = GM.PlayerModel_DeathSounds["Stalker_LonerSounds"],
	["models/player/stalker/merc_exo.mdl"] = GM.PlayerModel_DeathSounds["Stalker_KillerSounds"],
	["models/player/stalker/duty_exo.mdl"] = GM.PlayerModel_DeathSounds["Stalker_DutySounds"],
	["models/player/stalker/freedom_exo.mdl"] = GM.PlayerModel_DeathSounds["Stalker_FreedomSounds"],
	["models/player/stalker/monolith_exo.mdl"] = GM.PlayerModel_DeathSounds["Stalker_MonolithSounds"],
	["models/stalkertnb/cs2_goggles.mdl"] = nil,

}
