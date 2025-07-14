include('shared.lua')

SWEP.PrintName			= "5.56X45 SIG SG-550 SNIPER"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_sg550.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_sg550")
end