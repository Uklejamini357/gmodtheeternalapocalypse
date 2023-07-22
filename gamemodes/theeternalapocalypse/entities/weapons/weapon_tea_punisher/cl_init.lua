include('shared.lua')

SWEP.PrintName			= "The Punisher"	
SWEP.Slot				= 3
SWEP.SlotPos			= 1

SWEP.SwayScale			= 1.0
SWEP.BobScale			= 1.0

if (file.Exists("materials/weapons/weapon_mad_awp.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_awp")
end