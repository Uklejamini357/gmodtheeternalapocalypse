include('shared.lua')

SWEP.PrintName			= "Magnus KA-357"
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_ak47.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_ak47")
end