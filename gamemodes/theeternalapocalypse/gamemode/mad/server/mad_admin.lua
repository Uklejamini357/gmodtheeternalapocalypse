
// Useful script for the admin commands!

/*---------------------------------------------------------
   Name: MAD.AddValueCommand()
---------------------------------------------------------*/
ValueCmds = {}

function MAD.AddValueCommand(cmd, cfgvar, global)

	ValueCmds[cmd] = {var = cfgvar, global = global}
	concommand.Add(cmd, MAD.ValueCommand)
end

/*---------------------------------------------------------
   Name: MAD.ValueCommand()
---------------------------------------------------------*/
function MAD.ValueCommand(ply, cmd, args)

	local valuecmd = ValueCmds[cmd]

	if (not valuecmd) then return end

	if (#args < 1) then
		if (valuecmd.global) then
			Msg(cmd .. " = " .. GetGlobalInt(valuecmd.var) .. "\n")
		else
			Msg(cmd .. " = " .. CfgVars[valuecmd.var] .. "\n")
		end
		return
	end

	if (ply:EntIndex() ~= 0 and not ply:IsAdmin()) then
		Msg("You're not an admin!\n")
		return
	end

	local amount = math.floor(tonumber(args[1]))

	if (valuecmd.global) then
		SetGlobalInt(valuecmd.var, amount)
	else
		CfgVars[valuecmd.var] = amount
	end

	local nick = ""

	if (ply:EntIndex() == 0) then
		nick = "Console"
	else
		nick = ply:Nick()
	end

	SendMessageAll(nick .. " set " .. cmd .. " to " .. amount)
end

/*---------------------------------------------------------
   Name: MAD.AddToggleCommand()
---------------------------------------------------------*/
ToggleCmds = {}

function MAD.AddToggleCommand(cmd, cfgvar, global)

	ToggleCmds[cmd] = {var = cfgvar, global = global}
	concommand.Add(cmd, MAD.ToggleCommand)
end

/*---------------------------------------------------------
   Name: MAD.ToggleCommand()
---------------------------------------------------------*/
function MAD.ToggleCommand(ply, cmd, args)

	local togglecmd = ToggleCmds[cmd]

	if (not togglecmd) then return end

	if (#args < 1) then
		if (togglecmd.global) then
			Msg(cmd .. " = " .. GetGlobalInt(togglecmd.var) .. "\n")
		else
			Msg(cmd .. " = " .. CfgVars[togglecmd.var] .. "\n")
		end
		return
	end

	if (ply:EntIndex() ~= 0 and not ply:IsAdmin()) then
		Msg("You're not an admin!\n")
		return
	end

	local toggle = tonumber(args[1])

	if (not toggle or (toggle ~= 1 and toggle ~= 0)) then
		Msg("Invalid number! Must be 1 or 0.\n")
		return
	end

	if (togglecmd.global) then
		SetGlobalInt(togglecmd.var, toggle)
	else
		CfgVars[togglecmd.var] = toggle
	end

	local nick = ""

	if (ply:EntIndex() == 0) then
		nick = "Console"
	else
		nick = ply:Nick()
	end

	SendMessageAll(nick .. " set " .. cmd .. " to " .. toggle)
end
