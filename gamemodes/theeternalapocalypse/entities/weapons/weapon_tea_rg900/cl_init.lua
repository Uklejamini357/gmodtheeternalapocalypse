include('shared.lua')

SWEP.PrintName			= "RG-900"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_tmp.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_tmp")
end