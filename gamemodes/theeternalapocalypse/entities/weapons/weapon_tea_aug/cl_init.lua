include('shared.lua')

SWEP.PrintName			= "Steyr AUG A1"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_aug.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_aug")
end