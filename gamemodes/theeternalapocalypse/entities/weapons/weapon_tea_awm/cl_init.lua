include('shared.lua')

SWEP.PrintName			= "AWM Sniper Rifle"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_awm.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_awm.vmt")
end