
AddCSLuaFile()

include('taunt_camera.lua')


local PLAYER = {}

PLAYER.DisplayName			= "Survivor"

PLAYER.SlowWalkSpeed		= 100		-- There was a gmod update that breaks the gamemode again (everything's fine now)
PLAYER.WalkSpeed			= 150		-- How fast to move when not running
PLAYER.RunSpeed				= 300		-- How fast to move when running
PLAYER.CrouchedWalkSpeed	= 0.3		-- Multiply move speed by this when crouching
PLAYER.DuckSpeed			= 0.5		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.5		-- How fast to go from ducking, to not ducking
PLAYER.JumpPower			= 200		-- How powerful our jump should be
PLAYER.CanUseFlashlight		= true		-- Can we use the flashlight
PLAYER.MaxHealth			= 100		-- Max health we can have
PLAYER.MaxArmor 			= 100		-- Max armor we can have
PLAYER.StartHealth			= 100		-- How much health we start with
PLAYER.StartArmor			= 0			-- How much armour we start with
PLAYER.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide	= true		-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers			= true		-- Automatically swerves around other players
PLAYER.UseVMHands			= true		-- Uses viewmodel hands


PLAYER.TauntCam = TauntCamera()

--
-- Name: PLAYER:SetupDataTables
-- Desc: Set up the network table accessors
-- Arg1:
-- Ret1:
--
function PLAYER:SetupDataTables()
end

--
-- Name: PLAYER:Init
-- Desc: Called when the class object is created (shared)
-- Arg1:
-- Ret1:
--
function PLAYER:Init()
end

function PLAYER:Spawn()
end

function PLAYER:Loadout()
end

function PLAYER:SetModel()

	local cl_playermodel = self.Player:GetInfo("cl_playermodel")
	local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)

end

function PLAYER:ShouldDrawLocal() 

	if (self.TauntCam:ShouldDrawLocalPlayer(self.Player, self.Player:IsPlayingTaunt())) then return true end

end

--
-- Allow player class to create move
--
function PLAYER:CreateMove(cmd)

	if (self.TauntCam:CreateMove(cmd, self.Player, self.Player:IsPlayingTaunt())) then return true end

end

--
-- Allow changing the player's view
--
function PLAYER:CalcView(view)

	if (self.TauntCam:CalcView(view, self.Player, self.Player:IsPlayingTaunt())) then return true end

	-- Your stuff here

end

function PLAYER:Death(inflictor, attacker) end

-- Shared
function PLAYER:StartMove(cmd, mv) end	-- Copies from the user command to the move
function PLAYER:Move(mv) end				-- Runs the move (can run multiple times for the same client)
function PLAYER:FinishMove(mv) end		-- Copy the results of the move back to the Player

function PLAYER:ViewModelChanged(vm, old, new)
end

function PLAYER:PreDrawViewModel(vm, weapon)
end

function PLAYER:PostDrawViewModel(vm, weapon)
end

function PLAYER:GetHandsModel()

	-- return { model = "models/weapons/c_arms_cstrike.mdl", skin = 1, body = "0100000" }

	local playermodel = player_manager.TranslateToPlayerModelName(self.Player:GetModel())
	return player_manager.TranslatePlayerHands(playermodel)

end

player_manager.RegisterClass("player_ate", PLAYER, nil)
