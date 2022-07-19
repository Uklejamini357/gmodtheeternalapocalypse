--util.AddNetworkString("MakeProp")
util.AddNetworkString("ChangeModel")
util.AddNetworkString("ChangeProp")
util.AddNetworkString("CashBounty")
util.AddNetworkString("AddVault")
util.AddNetworkString("WithdrawVault")

util.AddNetworkString("UpdateStats") -- no functions for this in this file, see player_data.lua and cl_hud.lua
util.AddNetworkString("UpdatePeriodicStats") -- ditto above
util.AddNetworkString("UpdatePerks")
util.AddNetworkString("UpdateInventory")
util.AddNetworkString("UpgradePerk")
util.AddNetworkString("UpdateVault")

util.AddNetworkString("UseItem") -- see player_inventory.lua
util.AddNetworkString("UseGun") -- see player_inventory.lua
util.AddNetworkString("BuyItem") -- see player_inventory.lua
util.AddNetworkString("SellItem") -- see player_inventory.lua
util.AddNetworkString("OpenTraderMenu") -- see cl_tradermenu.lua
util.AddNetworkString("SystemMessage")
util.AddNetworkString("RadioMessage")
util.AddNetworkString("UseDelay") -- delays on using items

util.AddNetworkString("RecvFactions") -- see factions.lua and cl_scoreboard.lua
util.AddNetworkString("CreateFaction") -- see factions.lua
util.AddNetworkString("JoinFaction") -- see factions.lua
util.AddNetworkString("InviteFaction") -- gee i wonder what this could be for
util.AddNetworkString("KickFromFaction")
util.AddNetworkString("DisbandFaction")
util.AddNetworkString("WraithBlind") -- rape your vision when you get hit by a wraith
util.AddNetworkString("Payout") -- sell cl_hud and server/npcspawns


function SystemBroadcast(msg, color, sys) -- same as system message, just broadcasts it to everybody instead of accepting a ply argument
for k, v in pairs(player.GetAll()) do
net.Start("SystemMessage")
net.WriteString( msg )
net.WriteColor( color )
net.WriteBool( sys or false )
net.Send(v)
end
end

function RadioBroadcast(time, msg, sender)
timer.Simple(time, function()
	for k, v in pairs(player.GetAll()) do
	net.Start("RadioMessage")
	net.WriteString( sender )
	net.WriteString( msg )
	net.Send(v)
	end
end)
end

function SystemMessage(ply, msg, color, sys)
net.Start("SystemMessage")
net.WriteString( msg )
net.WriteColor( color )
net.WriteBool( sys or false )
net.Send(ply)
end

function SendUseDelay( ply, delay )
if !ply:IsValid() or !ply:Alive() then return end
net.Start( "UseDelay" )
net.WriteUInt( delay, 8 )
net.Send(ply)
end

net.Receive( "ChangeProp", function( length, client )
if !client:IsValid() or !client:Alive() then return false end
local model = net.ReadString()
client.SelectedProp = model
end)


net.Receive( "ChangeModel", function( length, client )
if !client:IsValid() or !client:Alive() then return false end
local model = net.ReadString()
local col = net.ReadVector()
client.ChosenModel = model
client.ChosenModelColor = col

SendUseDelay( client, 3 )

timer.Simple(2, function() RecalcPlayerModel( client ) end)

end)


net.Receive( "UpgradePerk", function( length, client )
local ply = client
local perk = net.ReadString()
local perk2 = "Stat"..perk
print(tonumber(ply.StatPoints))
	if( tonumber(ply.StatPoints) < 1 ) then
		SendChat( ply, "You need more stat points to upgrade a skill!" )
		return false
	end
	if ( tonumber(ply[perk2]) >= 10 ) then
		SendChat( ply, "You have reached the maximum number of points for this skill" )
		return false
	end

		ply[perk2] = ply[perk2] + 1
		ply.StatPoints = ply.StatPoints - 1
		ply:SetMaxHealth( 100 + ( ply.StatHealth * 5 ) )
		ply:SetMaxArmor( 100 + ( ply.StatEngineer * 2 ) )
		SendChat( ply, "You increased your " .. perk .. " skill by 1 point!" )
 		RecalcPlayerSpeed(ply)
		FullyUpdatePlayer( ply )
end)


net.Receive( "CashBounty", function( length, client )
if !client:IsValid() or !client:Alive() then return false end

local trader = false
local plycheck = ents.FindInSphere(client:GetPos(), 200)
for k, v in pairs(plycheck) do
if v:GetClass() == "trader" then trader = true end
end
if trader == false then SystemMessage(client, "nice try faggot", Color(255,205,205,255), true) return false end

if client.Bounty < 0 then SystemMessage(client, "You don't have any bounty to cash in!", Color(255,205,205,255), true) return false end

client.Money = math.floor(tonumber(client.Money)) + tonumber(client.Bounty)
SystemMessage(client, "You cashed in your bounty and received "..tonumber(client.Bounty).." "..Config[ "Currency" ].."s!", Color(205,255,205,255), true)
client.Bounty = 0
ply:SetNWInt( "PlyBounty", ply.Bounty )

FullyUpdatePlayer( client )
end)
