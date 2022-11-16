/*---------------------------------------------------------
------mmmm---mmmm-aaaaaaaa----ddddddddd---------------------------------------->
     mmmmmmmmmmmm aaaaaaaaa   dddddddddd	  Name: Mad Cows Weapons
     mmm mmmm mmm aaa    aaa  ddd     ddd	  Authors: Worshipper, Nyan Cat, Ash (Sub-Authors: ENDER JRV, (Nyancat +mact)?)
    mmm  mmm  mmm aaaaaaaaaaa ddd     ddd	  Project Start: October 23th, 2009 (wow this is really old)
    mmm       mmm aaa     aaa dddddddddd	  File: mad_shared.lua
---mmm--------mmm-aaa-----aaa-ddddddddd---------------------------------------->
---------------------------------------------------------*/
-- This was (optionally) used in after the end and i thought of adding the same here

MAD = {}

include("mad_ammo.lua")
include("mad_falldamage.lua")
include("mad_npcs.lua")
include("mad_player.lua")
	
if SERVER then
	include("server/mad_admin.lua")
	include("server/mad_files.lua")
	include("server/mad_getpos.lua")
	include("server/mad_server.lua")
	include("server/mad_spawnpoint.lua")
	include("server/mad_time.lua")
	include("mad_svinit.lua")

else
	include("client/mad_client.lua")
	include("client/mad_menu.lua")
	include("client/mad_killicon.lua")
end

CreateClientConVar("zw_muzzleflash", 1, true, false)

sound.Add({
	name = 			"Double_Barrel.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/spas/spas-1.wav"
})

sound.Add({
	name = 			"Double_Barrel.InsertShell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/xm1014_insertshell.mp3"
})

sound.Add({
	name = 			"Double_Barrel.barreldown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/barreldown.mp3"
})

sound.Add({
	name = 			"Double_Barrel.barrelup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/barrelup.mp3"
})


-- sten

sound.Add({
	name = 			"Weaponsten.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5-1.wav"
	
})

sound.Add({
	name = 			"Weaponsten.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipout.wav"
	
})

sound.Add({
	name = 			"Weaponsten.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipin.wav"
	
})

sound.Add({
	name = 			"Weaponsten.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltpull.wav"	
})

sound.Add({
	name = 			"Weaponsten.boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltslap.wav"
	
})

sound.Add({
	name = 			"Weapon_stengun.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_slideback.wav"
	
})


sound.Add({
	name = 			"Weaponsten.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5-1.wav"
	
})

sound.Add({
	name = 			"Weaponsten.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipout.wav"
	
})

sound.Add({
	name = 			"Weaponsten.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipin.wav"
	
})

sound.Add({
	name = 			"Weaponsten.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltpull.wav"	
})

sound.Add({
	name = 			"Weaponsten.boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltslap.wav"
	
})

sound.Add({
	name = 			"Weapon_stengun.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_slideback.wav"
	
})

sound.Add({
	name = 			"Weapon_svd01.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/m14/m14-1.wav"
})

sound.Add({
	name = 			"Weapon_SVD.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/foley.wav"	
})

sound.Add({
	name = 			"Weapon_SVD.Handle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/handle.wav"	
})

sound.Add({
	name = 			"Weapon_SVD.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Clipout.wav"
})

sound.Add({
	name = 			"Weapon_SVD.Cliptap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Cliptap.wav"
	
})

sound.Add({
	name = 			"Weapon_SVD.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/ClipIn.wav"
	
})

sound.Add({
	name = 			"Weapon_SVD.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/SlideBack.wav"
	
})

sound.Add({
	name = 			"Weapon_SVD.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/SlideForward.wav"	
})

sound.Add({
	name = 			"Weapon_SVD.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Draw.wav"
	
})

sound.Add({
	name = 			"Weapon_satan1.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/model500/deagle-1.wav"
})

sound.Add({
	name = 			"Weapon_satan1.blick",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/blick.wav"
})

sound.Add({
	name = 			"Weapon_satan1.unfold",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/unfold.wav"
})

sound.Add({
	name = 			"Weapon_satan1.bulletsin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/bulletsin.wav"
})

sound.Add({
	name = 			"Weapon_satan1.bulletsout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/bulletsout.wav"
})

sound.Add({
	name = 			"Weapon_hkusc.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/hk_ump45/ump45-1.wav"}
})

sound.Add({
	name = 			"Weapon_hkusc.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_clipout.wav"
})

sound.Add({
	name = 			"Weapon_hkusc.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_clipin.wav"
})

sound.Add({
	name = 			"Weapon_hkusc.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_boltslap.wav"
})


sound.Add({
	name =			"Weaponaw50.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1.0,
	sound =			"weapons/aw50/awp_fire.wav"
})

sound.Add({
	name =			"Weaponaw50.clipin",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/awp_magin.mp3"
})

sound.Add({
	name =			"Weaponaw50.clipout",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/awp_magout.mp3"
})
	
sound.Add({
	name =			"Weaponaw50.boltback",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/m24_boltback.mp3"
})

sound.Add({
	name =			"Weaponaw50.boltforward",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/m24_boltforward.mp3"
})


sound.Add({
	name = 			"Wep_fnscarh.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		{"weapons/fnscarh/aug-1.wav",
					"weapons/fnscarh/aug-2.wav",
					"weapons/fnscarh/aug-3.wav"}
})

sound.Add({
	name = 			"Wep_fnscar.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnscarh/aug_boltpull.wav"
})

sound.Add({
	name = 			"Wep_fnscar.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnscarh/aug_boltslap.wav"
})

sound.Add({
	name = 			"Wep_fnscar.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnscarh/aug_clipout.wav"
})

sound.Add({
	name = 			"Wep_fnscar.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fnscarh/aug_clipin.wav"
})

sound.Add({
	name = 			"Weapon_73.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/winchester73/w73-1.wav"	
})

sound.Add({
	name = 			"Weapon_73.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/winchester73/w73pump.wav"
})

sound.Add({
	name = 			"Weapon_73.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/winchester73/w73insertshell.wav"
})

sound.Add({
	name = 			"Weapon_P19.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/p19/p90-1.wav"
})

sound.Add({
	name = 			"Weapon_P19.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_clipout.wav"
})

sound.Add({
	name = 			"Weapon_P19.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_clipin.wav"
})

sound.Add({
	name = 			"Weapon_P19.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_boltpull.wav"
})

sound.Add({
	name = 			"Weapon_usas.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/usas12/xm1014-1.wav"
})

sound.Add({
	name = 			"Weapon_usas.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/magin.wav"
})

sound.Add({
	name = 			"Weapon_usas.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/magout.wav"
})

sound.Add({
	name = 			"Weapon_usas.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/draw.wav"
})

  sound.Add({
	name = 			"Weapon_Win94.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_fire-1.wav"
})

sound.Add({
	name = 			"Weapon_Win94.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_bolt.wav"
})

sound.Add({
	name = 			"weapons/hamburgpling.wav",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/hamburgpling.wav"
})

sound.Add({
	name = 			"Weapon_Win94.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_clipout.wav"
})
