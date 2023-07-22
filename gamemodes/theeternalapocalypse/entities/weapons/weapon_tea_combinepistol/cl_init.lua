include('shared.lua')

SWEP.PrintName			= "Ar2 Combine Pistol"	
SWEP.Slot				= 1
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_combinepistol.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_combinepistol")
end