util.AddNetworkString( "SendCrateItems" )
util.AddNetworkString( "UseCrate" )

LootData = ""

function LootCount()
	local LootBoxes = 0
	for k, v in pairs( ents.FindByClass( "loot_cache" ) ) do
		LootBoxes = LootBoxes + 1
	end
	for k, v in pairs( ents.FindByClass( "loot_cache_weapon" ) ) do
		LootBoxes = LootBoxes + 1
	end
	return LootBoxes
end

function LoadLoot()
if not file.IsDir("theeternalapocalypse/spawns/loot", "DATA") then
   file.CreateDir("theeternalapocalypse/spawns/loot")
end
	if file.Exists( "theeternalapocalypse/spawns/loot/" .. string.lower(game.GetMap()) .. ".txt", "DATA" ) then
		LootData = "" --reset it
		LootData = file.Read( "theeternalapocalypse/spawns/loot/" .. string.lower(game.GetMap()) .. ".txt", "DATA" )
		print( "Loot spawnpoints loaded" )
	else
		LootData = "" --just in case
		print( "No loot spawnpoints found for this map" )
	end
end
LoadLoot()

function AddLoot( ply, cmd, args )
	if !SuperAdminCheck( ply ) then
		SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
		ply:ConCommand( "playgamesound buttons/button8.wav" )
		return
	end

	if( LootData == "" ) then
		NewData = tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	else
		NewData = LootData .. "\n" .. tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	end
	
	file.Write( "theeternalapocalypse/spawns/loot/" .. string.lower(game.GetMap()) .. ".txt", NewData )
	
	LoadLoot() --reload them
	
	SendChat( ply, "Added a loot spawnpoint at position "..tostring(ply:GetPos()).."!" )
	print("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	ate_DebugLog("[SPAWNPOINTS MODIFIED] "..ply:Nick().." has added a loot spawnpoint at position "..tostring(ply:GetPos()).."!")
	ply:ConCommand( "playgamesound buttons/button3.wav" )
end
concommand.Add( "ate_addlootspawn", AddLoot )


function ClearLoot( ply, cmd, args )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "You are not superadmin!", Color(255,205,205,255), true)
	ply:ConCommand( "playgamesound buttons/button8.wav" )
	return
end

if file.Exists(	"theeternalapocalypse/spawns/loot/" .. string.lower(game.GetMap()) .. ".txt", "DATA") then
	file.Delete("theeternalapocalypse/spawns/loot/" .. string.lower(game.GetMap()) .. ".txt")
end
SendChat( ply, "Deleted all loot spawnpoints" )
print("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all loot spawnpoints!")
ate_DebugLog("[SPAWNPOINTS REMOVED] "..ply:Nick().." has deleted all loot spawnpoints!")
ply:ConCommand( "playgamesound buttons/button15.wav" )
end
concommand.Add( "ate_clearlootspawns", ClearLoot )





function SpawnLoot()
local tea_config_maxcaches = GetConVar("tea_config_maxcaches")
if ( LootCount() >= tea_config_maxcaches:GetInt() ) then return false end -- dont even bother running any checks if theres already too much loot
		if ( LootData != "" ) then

			local LootList = string.Explode( "\n", LootData )
			for k, v in RandomPairs( LootList ) do
			if ( LootCount() >= tea_config_maxcaches:GetInt() ) then break end
				local Booty = string.Explode( ";", v )
				local pos = util.StringToType( Booty[1], "Vector" )
				local ang = util.StringToType( Booty[2], "Angle" )
				if math.random(1,20) > 3 then
					local EntDrop = ents.Create( "loot_cache" )
					EntDrop:SetPos( pos )
					EntDrop:SetAngles( ang )
					EntDrop.LootType = table.Random(LootTable1)["Class"]
					EntDrop:Spawn()
					EntDrop:Activate()
				else
					local EntDrop = ents.Create( "loot_cache_weapon" )
					EntDrop:SetPos( pos )
					EntDrop:SetAngles( ang )
					EntDrop.LootType = table.Random(LootTable2)["Class"]
					EntDrop:Spawn()
					EntDrop:Activate()
				end

			end
		end
end
timer.Create( "LootSpawnTimer", 60, 0, SpawnLoot )



function MakeLootContainer( ent, items, size, env ) -- env is a bool for environment caches such as airdrops and random loot
if !ent:IsValid() or !istable(items) then return end
local size = size or 1000 -- doesnt matter what size is if env is true
local env = env or true

ent.ContainerItems = items
ent.ContainerSize = size
ent.ContainerRemoveEmpty = env

end


function CalculateContainerWeight( ent )
if !ent:IsValid() or !ent.ContainerItems then return end
local totalweight = 0
	for k, v in pairs(ent.ContainerItems) do
	local ref = ItemsList[k]
	totalweight = totalweight + (ref.Weight * v)
	end
return totalweight
end

function PlaceInContainer( ply, str, ent )
if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
if ply:GetPos():Distance( ent:GetPos() ) > 120 then return end
if !ItemsList[str] then return end

if ent.ContainerRemoveEmpty then SystemMessage(ply, "You cannot place items into this container! Buy a faction stash if you need item storage!", Color(255,205,205,255), true) return end

local item = ItemsList[str]
if (CalculateContainerWeight(ent) + item["Weight"]) > ent.ContainerSize then SystemMessage(ply, "There isn't enough room for that!", Color(255,205,205,255), true) return end

	if ent.ContainerItems[str] then
		ent.ContainerItems[str] = ent.ContainerItems[str] + 1
	else 
		ent.ContainerItems[str] = 1
	end

	SystemRemoveItem( ply, str, true )
	SendInventory( ply )
end


function WithdrawFromContainer( ply, str, ent )
if !ply:IsValid() or !ent:IsValid() or !ent.ContainerItems then return end
if ply:GetPos():Distance( ent:GetPos() ) > 120 then return end
if !ItemsList[str] or !ent.ContainerItems[str] then return end

local item = ItemsList[str]

if ((CalculateWeight(ply) + item["Weight"]) > CalculateMaxWeight(ply)) then SystemMessage(client, "You don't have enough space for that!", Color(255,205,205,255), true) return end


ent.ContainerItems[str] = ent.ContainerItems[str] - 1
if ent.ContainerItems[str] < 1 then ent.ContainerItems[str] = nil end

SystemGiveItem( ply, str )
SendInventory( ply )

-- airdrops and random loot caches need to be deleted when there's no items left in them
if ent.ContainerRemoveEmpty and table.Count( ent.ContainerItems ) < 1 then ent.ContainerItems = nil timer.Simple(15, function() if ent:IsValid() then ent:Remove() end end) end

end

function OpenContainer( ent, ply )
if !ent:IsValid() then return end
if !ent.ContainerItems then SystemMessage(ply, "It's empty!", Color(255,205,205,255), false) return end
net.Start( "SendCrateItems" )
net.WriteEntity( ent )
net.WriteTable( ent.ContainerItems )
net.WriteBool( !ent.ContainerRemoveEmpty )
net.Send( ply )

end

net.Receive( "UseCrate", function( len, ply )
local ent = net.ReadEntity()
local item = net.ReadString()
local stash = net.ReadBool() or false

if !ent:IsValid() or !ent.ContainerItems or !ply:IsValid() or !ply:Alive() then return end
if stash then
	PlaceInContainer( ply, item, ent )
else
	WithdrawFromContainer( ply, item, ent )
end

end )







-- EXAMPLE OF PARAMS
--[[
{

syntax is as follows:
"Table to roll from" = { number of times to roll this table, qty low, qty high }

this rolls twice from the junk table, selecting a 2 random item classes from it and spawning 1-3 each of them.
"Junk" = {2, 1, 3}

}
]]

function RollLootTable( params, maxrolls )
if not istable(params) then return end
local maxrolls = maxrolls or -1
local rolls = 0

local rolled = {}

for k, v in pairs(params) do
	if !LootTable[k] then ErrorNoHalt("RollLootTable() error: "..k.." is not a valid loot table! see gamemode/sh_loot.lua for more info" ) continue end
	if rolls >= maxrolls and maxrolls >= 0 then continue end
	for i = 1, v[1] do
	local item = table.Random( LootTable[k] )
	local qty = math.random( v[2], v[3] )

	if rolls >= maxrolls and maxrolls >= 0 then continue end
	if maxrolls >= 0 then rolls = rolls + 1 end
	if rolled[item] then rolled[item] = rolled[item] + qty else rolled[item] = qty end
end
end

return rolled
end
