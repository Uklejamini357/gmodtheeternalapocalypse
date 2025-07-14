include('shared.lua')

SWEP.PrintName			= "HK MP7-S WHISPER"	
SWEP.Slot				= 2
SWEP.SlotPos			= 2

if (file.Exists("materials/weapons/weapon_mad_mp7.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_mp7")
end