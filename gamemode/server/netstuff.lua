--util.AddNetworkString("MakeProp")
util.AddNetworkString("ChangeModel")
util.AddNetworkString("ChangeProp")
util.AddNetworkString("CashBounty")
util.AddNetworkString("AddVault")
util.AddNetworkString("WithdrawVault")

util.AddNetworkString("UpdateStats") -- no functions for this in this file, see player_data.lua and cl_hud.lua
util.AddNetworkString("UpdatePeriodicStats")
util.AddNetworkString("UpdateStatistics")
util.AddNetworkString("UpdatePerks")
util.AddNetworkString("UpdateInventory")
util.AddNetworkString("UpdateTargetStats")
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
util.AddNetworkString("GiveLeader")
util.AddNetworkString("InviteFaction") -- invite faction
util.AddNetworkString("KickFromFaction")
util.AddNetworkString("DisbandFaction")
util.AddNetworkString("WraithBlind") -- rape your vision when you get hit by a wraith
util.AddNetworkString("Payout") -- sell cl_hud and server/npcspawns
util.AddNetworkString("Prestige") -- see player_data.lua
--util.AddNetworkString("Respawn")

function TEANetUpdateStats(ply)
	net.Start("UpdateStats")
	net.WriteFloat(math.Round(ply.Stamina))
	net.WriteFloat(math.Round(ply.Hunger))
	net.WriteFloat(math.Round(ply.Thirst))
	net.WriteFloat(math.Round(ply.Fatigue))
	net.WriteFloat(math.Round(ply.Infection))
	net.WriteFloat(math.Round(ply.SurvivalTime))
	net.WriteFloat(math.Round(ply.Battery))
	net.Send(ply)
end

function TEANetUpdatePeriodicStats(ply)
	net.Start("UpdatePeriodicStats")
	net.WriteFloat(ply.Level)
	net.WriteFloat(ply.Prestige)
	net.WriteFloat(ply.Money)
	net.WriteFloat(ply.XP)
	net.WriteFloat(ply.StatPoints)
	net.WriteFloat(ply.Bounty)
	net.Send(ply)
end

function TEANetUpdatePerks(ply)
	net.Start("UpdatePerks")
	net.WriteFloat(ply.StatDefense)
	net.WriteFloat(ply.StatDamage)
	net.WriteFloat(ply.StatSpeed)
	net.WriteFloat(ply.StatHealth)
	net.WriteFloat(ply.StatKnowledge)
	net.WriteFloat(ply.StatMedSkill)
	net.WriteFloat(ply.StatStrength)
	net.WriteFloat(ply.StatEndurance)
	net.WriteFloat(ply.StatSalvage)
	net.WriteFloat(ply.StatBarter)
	net.WriteFloat(ply.StatEngineer)
	net.WriteFloat(ply.StatImmunity)
	net.WriteFloat(ply.StatSurvivor)
	net.WriteFloat(ply.StatAgility)
	net.Send(ply)
end

function TEANetUpdateStatistics(ply)
	net.Start("UpdateStatistics")
	net.WriteFloat(ply.BestSurvivalTime)
	net.WriteFloat(ply.ZKills)
	net.WriteFloat(ply.playerskilled)
	net.WriteFloat(ply.playerdeaths)
	net.Send(ply)
end

function TEANetUpdatePlayerStatistics(ply, target)
	net.Start("UpdateTargetStats")
	net.WriteFloat(target.BestSurvivalTime)
	net.WriteFloat(target.ZKills)
	net.WriteFloat(target.playerskilled)
	net.WriteFloat(target.playerdeaths)
	net.Send(ply)
end


function SystemBroadcast(msg, color, sys) -- same as system message, just broadcasts it to everybody instead of accepting a ply argument
	for k, v in pairs(player.GetAll()) do
		net.Start("SystemMessage")
		net.WriteString(msg)
		net.WriteColor(color)
		net.WriteBool(sys or false)
		net.Send(v)
	end
end

function RadioBroadcast(time, msg, sender)
	timer.Simple(time, function()
		for k, v in pairs(player.GetAll()) do
			net.Start("RadioMessage")
			net.WriteString(sender)
			net.WriteString(msg)
			net.Send(v)
		end
	end)
end

function SystemMessage(ply, msg, color, sys)
	net.Start("SystemMessage")
	net.WriteString(msg)
	net.WriteColor(color)
	net.WriteBool(sys or false)
	net.Send(ply)
end

function SendUseDelay(ply, delay)
	if !ply:IsValid() or !ply:Alive() then return end
	net.Start("UseDelay")
	net.WriteUInt(delay, 8)
	net.Send(ply)
end

net.Receive("ChangeProp", function(length, client)
	if !client:IsValid() or !client:Alive() then return false end
	local model = net.ReadString()
	client.SelectedProp = model
end)


net.Receive("ChangeModel", function(length, client)
	if !client:IsValid() or !client:Alive() then return false end
	if timer.Exists("changemodelcooldown_"..client:UniqueID()) then SystemMessage(client, "You can't change your model since you already have changed your model in the last 120 seconds!", Color(255,155,155,255), true) return false end
	local model = net.ReadString()
	local col = net.ReadVector()
	client.ChosenModel = model
	client.ChosenModelColor = col

	SendUseDelay(client, 1)
	timer.Create("changemodelcooldown_"..client:UniqueID(), 120, 0, function()
		if !client:IsValid() then return false end
		timer.Destroy("changemodelcooldown_"..client:UniqueID())
	end) 
timer.Simple(0.75, function() RecalcPlayerModel(client) end)

end)


net.Receive("UpgradePerk", function(length, client)
	local ply = client
	local perk = net.ReadString()
	local perk2 = "Stat"..perk
	if(tonumber(ply.StatPoints) < 1) then
		SendChat(ply, "You need more stat points to upgrade a skill!")
		return false
	end
	if (tonumber(ply[perk2]) >= 10) then
		SendChat(ply, "You have reached the maximum number of points for this skill")
		return false
	end

		ply[perk2] = ply[perk2] + 1
		ply.StatPoints = ply.StatPoints - 1
		CalculateMaxHealth(ply)
		CalculateMaxArmor(ply)
		CalculateJumpPower(ply)
		print(ply:Nick().." used 1 skill point on "..perk.." skill ("..tonumber(ply.StatPoints).." skill points remaining)")
		SendChat(ply, translate.ClientFormat(ply, "PerkIncreased", perk))
 		RecalcPlayerSpeed(ply)
		FullyUpdatePlayer(ply)
end)


net.Receive("CashBounty", function(length, client)
if !client:IsValid() or !client:Alive() then return false end

local trader = false
local plycheck = ents.FindInSphere(client:GetPos(), 200)
for k, v in pairs(plycheck) do
if v:GetClass() == "trader" then trader = true end
end
if trader == false then SystemMessage(client, "Bruh, did you try to cash in your bounty when you're not in trader area?", Color(255,205,205,255), true) return false end

if client.Bounty <= 0 then SystemMessage(client, "You don't have any bounty to cash in!", Color(255,205,205,255), true) return false end

client.Money = math.floor(tonumber(client.Money)) + tonumber(client.Bounty)
print(client:Nick().." has cashed in their bounty and received "..tonumber(client.Bounty).." "..Config["Currency"].."s!")
SystemMessage(client, "You cashed in your bounty and received "..tonumber(client.Bounty).." "..Config["Currency"].."s!", Color(205,255,205,255), true)
client.Bounty = 0
client:SetNWInt("PlyBounty", client.Bounty)

FullyUpdatePlayer(client)
end)

net.Receive("UpdateTargetStats", function(length, client)
	local ply = client
	local target = net.ReadEntity()
	if !ply:IsValid() or !target:IsValid() then return false end
	local nick = target:Nick()
	
	net.Start("UpdateTargetStats")
	net.WriteString(nick)
	net.WriteFloat(target.BestSurvivalTime)
	net.WriteFloat(target.ZKills)
	net.WriteFloat(target.playerskilled)
	net.WriteFloat(target.playerdeaths)
	net.Send(ply)
end)