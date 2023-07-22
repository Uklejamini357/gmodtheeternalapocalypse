include('shared.lua')

SWEP.PrintName			= "The Shredder"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_p90.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_p90")
end