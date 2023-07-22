include('shared.lua')

SWEP.PrintName			= ".45 INGRAM MAC M10"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_mac10.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_mac10")
end