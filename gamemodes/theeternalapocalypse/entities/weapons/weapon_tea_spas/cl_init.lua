include('shared.lua')

SWEP.PrintName			= "SPAS12 Shorty"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_spas.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_spas")
end