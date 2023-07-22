include('shared.lua')

SWEP.PrintName			= "U-45 Whisper"	
SWEP.Slot				= 1
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_usp.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_usp")
end