include('shared.lua')

SWEP.PrintName			= "9MM HK USP MATCH"	
SWEP.Slot				= 1
SWEP.SlotPos			= 1

if (file.Exists("materials/weapons/weapon_mad_usp_match.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_usp_match")
end