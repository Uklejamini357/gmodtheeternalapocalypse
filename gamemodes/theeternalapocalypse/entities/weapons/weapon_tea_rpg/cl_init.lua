include('shared.lua')

SWEP.PrintName			= "Rocket Launcher"	
SWEP.Slot				= 4
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_rpg.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_rpg")
end