include('shared.lua')

SWEP.PrintName			= "AR-2 PULSE-RIFLE"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_ar2.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_ar2")
end