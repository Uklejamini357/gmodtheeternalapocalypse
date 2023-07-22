include('shared.lua')

SWEP.PrintName			= "Scrap Crossbow"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_crossbow.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_crossbow")
end