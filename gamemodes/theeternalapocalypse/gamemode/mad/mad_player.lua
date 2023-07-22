
if SERVER then

util.AddNetworkString( "NOBACKSLOW" )

local PSPEEDS = CreateConVar("PlayerSpeed_CustomSpeeds", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PWALK = CreateConVar("PlayerSpeed_WalkSpeed", 220, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PRUN = CreateConVar("PlayerSpeed_RunSpeed", 330, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PCROUCH = CreateConVar("PlayerSpeed_CrouchSpeed", 0.4, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PCROUCHIN = CreateConVar("PlayerSpeed_CrouchSpeed_In", 0.225, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PCROUCHOUT = CreateConVar("PlayerSpeed_CrouchSpeed_Out", 0.4, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PSPRINTLIMIT = CreateConVar("PlayerSpeed_MoveLimit", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
local PSPRINTLIMITMUL = CreateConVar("PlayerSpeed_MoveLimit_Mul", 0.5, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})

function AllPlayersCrouchIn(speed)

	for _,v in pairs (player.GetAll()) do
	
	v:SetDuckSpeed(speed)
	
	end
	
end

function AllPlayersCrouchOut(speed)

	for _,v in pairs (player.GetAll()) do
	
	v:SetUnDuckSpeed(speed)
	
	end
	
end

function AllPlayersWalkSpeed(speed)

	for _,v in pairs (player.GetAll()) do
	
	v:SetWalkSpeed(speed)
	
	end
	
end

function AllPlayersRunSpeed(speed)

	for _,v in pairs (player.GetAll()) do
	
	v:SetRunSpeed(speed)
	
	end
	
end

function AllPlayersCrouchSpeed(speed)

	for _,v in pairs (player.GetAll()) do
	
		v:SetCrouchedWalkSpeed(speed)
	
	end
	
end

function PlayerRunSpawn(ply)

	timer.Simple(0.2,function()
	if IsValid(ply) then
	ply:SetWalkSpeed(PWALK:GetFloat())
	ply:SetRunSpeed(PRUN:GetFloat())
	ply:SetDuckSpeed(PCROUCHIN:GetFloat())
	ply:SetUnDuckSpeed(PCROUCHOUT:GetFloat())
	ply:SetCrouchedWalkSpeed(PCROUCH:GetFloat())
	end
	end)
	
end
hook.Add("PlayerSpawn","PlayerRunSpawnHook",PlayerRunSpawn)

timer.Create("Player_RunWalkChecker",1,0,function()
	
	NOBACKSLOW = PSPRINTLIMIT:GetBool()
	NOBACKSLOWMUL = PSPRINTLIMITMUL:GetFloat()
	
	if not LastBackSlow then LastBackSlow = !NOBACKSLOW end
	if not LastBackSlowMul then LastBackSlowMul = 500 end
	
	-- if LastBackSlow and LastBackSlowMul and (NOBACKSLOW != LastBackSlow or NOBACKSLOWMUL != LastBackSlowMul) then
	net.Start("NOBACKSLOW")
	net.WriteBit(PSPRINTLIMIT:GetBool())
	net.WriteFloat(PSPRINTLIMITMUL:GetFloat())
	net.Broadcast()
	-- end
	
	LastBackSlow = PSPRINTLIMIT:GetBool()
	LastBackSlowMul = PSPRINTLIMITMUL:GetFloat()

	if not PSPEEDS:GetBool() then return end

	if not PWALK2 then
	PWALK2 = PWALK:GetFloat()
	end
	if not PRUN2 then
	PRUN2 = PRUN:GetFloat()
	end
	if not PCROUCH2 then
	PCROUCH2 = PCROUCH:GetFloat()
	end
	if not PCROUCHIN2 then
	PCROUCHIN2 = PCROUCHIN:GetFloat()
	end
	if not PCROUCHOUT2 then
	PCROUCHOUT2 = PCROUCHOUT:GetFloat()
	end
	
	if PWALK2 != PWALK:GetFloat() then
	PWALK2 = PWALK:GetFloat()
	AllPlayersWalkSpeed(PWALK:GetFloat())
	end
	
	if PRUN2 != PRUN:GetFloat() then
	PRUN2 = PRUN:GetFloat()
	AllPlayersRunSpeed(PRUN:GetFloat())
	end
	
	if PCROUCH2 != PCROUCH:GetFloat() then
	PCROUCH2 = PCROUCH:GetFloat()
	AllPlayersCrouchSpeed(PCROUCH:GetFloat())
	end
	
	if PCROUCHIN2 != PCROUCHIN:GetFloat() then
	PCROUCHIN2 = PCROUCHIN:GetFloat()
	AllPlayersCrouchIn(PCROUCH:GetFloat())
	end
	
	if PCROUCHOUT2 != PCROUCHOUT:GetFloat() then
	PCROUCHOUT2 = PCROUCHOUT:GetFloat()
	AllPlayersCrouchOut(PCROUCHOUT:GetFloat())
	end
	
end)

end

if CLIENT then

	function NOBACKSLOW(um)
		local BS = net.ReadBit() == 1
		local MUL = net.ReadFloat()
		NOBACKSLOW = BS
		NOBACKSLOWMUL = MUL
	end
	net.Receive("NOBACKSLOW",NOBACKSLOW)

end

hook.Add("Move", "MoveBackwardsSlowdown", function(pl, move)
	if not NOBACKSLOW then return end
	if NOBACKSLOWMUL and not pl:KeyDown(IN_WALK) then
			local mul = NOBACKSLOWMUL
		local fwd = move:GetForwardSpeed()
		local sid = move:GetSideSpeed()
		local max = move:GetMaxSpeed()
		if fwd > max then
			move:SetForwardSpeed(max)
		end
		if fwd < max * -mul then
			move:SetForwardSpeed(max*-mul)
		end
		if sid > max * mul then
			move:SetSideSpeed(max*mul)
		end
		if sid < max * -mul then
			move:SetSideSpeed(max*-mul)
		end
	end
end)

print("you are jooking")
