include('shared.lua')

SWEP.PrintName			= "M3 Enforcer"	
SWEP.Slot				= 2
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_m3.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_m3")
end