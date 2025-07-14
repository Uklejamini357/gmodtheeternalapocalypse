include('shared.lua')

SWEP.PrintName			= "9MM SIG-SAUER P228"	
SWEP.Slot				= 1
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_p228.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_p228")
end