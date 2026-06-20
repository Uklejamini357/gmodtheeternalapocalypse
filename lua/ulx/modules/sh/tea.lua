local CATEGORY_NAME = "The Eternal Apocalypse"

function ulx.givemoney(caller, plys, money)
	for i=1, #plys do
        local pl = plys[i]
		pl.Money = pl.Money + money

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A gave #T #i money", plys, money)
end

local givemoney = ulx.command(CATEGORY_NAME, "ulx givemoney", ulx.givemoney, "!givemoney")
givemoney:addParam{type=ULib.cmds.PlayersArg}
givemoney:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="money", ULib.cmds.round}
givemoney:defaultAccess(ULib.ACCESS_SUPERADMIN)
givemoney:help("Gives the target specified amount of money")

function ulx.takemoney(caller, plys, money)
	for i=1, #plys do
        local pl = plys[i]
		pl.Money = math.max(0, pl.Money - money)

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A took #i money from #T", money, plys)
end

local takemoney = ulx.command(CATEGORY_NAME, "ulx takemoney", ulx.takemoney, "!takemoney")
takemoney:addParam{type=ULib.cmds.PlayersArg}
takemoney:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="money", ULib.cmds.round}
takemoney:defaultAccess(ULib.ACCESS_SUPERADMIN)
takemoney:help("Takes away the target specified amount of money, until goes down to 0")

function ulx.setmoney(caller, plys, money)
	for i=1, #plys do
        local pl = plys[i]
		pl.Money = money

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A set #i money for #T", money, plys)
end

local setmoney = ulx.command(CATEGORY_NAME, "ulx setmoney", ulx.setmoney, "!setmoney")
setmoney:addParam{type=ULib.cmds.PlayersArg}
setmoney:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="money", ULib.cmds.round}
setmoney:defaultAccess(ULib.ACCESS_SUPERADMIN)
setmoney:help("Set the target(s) specified amount of money")

function ulx.addxp(caller, plys, xp)
	for i=1, #plys do
        local pl = plys[i]
		pl.XP = pl.XP + xp

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A gave #i XP for #T", xp, plys)
end

local addxp = ulx.command(CATEGORY_NAME, "ulx addxp", ulx.addxp, "!addxp")
addxp:addParam{type=ULib.cmds.PlayersArg}
addxp:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="xp", ULib.cmds.round}
addxp:defaultAccess(ULib.ACCESS_SUPERADMIN)
addxp:help("Gives target(s) xp (doesn't auto level up)")

function ulx.takexp(caller, plys, xp)
	for i=1, #plys do
        local pl = plys[i]
		pl.XP = pl.XP - xp

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A took #i XP from #T", xp, plys)
end

local takexp = ulx.command(CATEGORY_NAME, "ulx takexp", ulx.takexp, "!takexp")
takexp:addParam{type=ULib.cmds.PlayersArg}
takexp:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="xp", ULib.cmds.round}
takexp:defaultAccess(ULib.ACCESS_SUPERADMIN)
takexp:help("Takes away xp from target(s)")

function ulx.setxp(caller, plys, xp)
	for i=1, #plys do
        local pl = plys[i]
		pl.XP = xp

        gamemode.Call("NetUpdatePeriodicStats", pl)
    end

	ulx.fancyLogAdmin(caller, "#A set #i XP for #T", xp, plys)
end

local setxp = ulx.command(CATEGORY_NAME, "ulx setxp", ulx.setxp, "!setxp")
setxp:addParam{type=ULib.cmds.PlayersArg}
setxp:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="xp", ULib.cmds.round}
setxp:defaultAccess(ULib.ACCESS_SUPERADMIN)
setxp:help("Set the target(s) specified amount of xp (without auto level up)")

function ulx.setlevel(caller, pl, lvl)
    pl.Level = lvl
    pl:SetNWInt("PlyLevel", lvl)
    gamemode.Call("NetUpdatePeriodicStats", pl)

	ulx.fancyLogAdmin(caller, "#A set #T's level to #i", pl, lvl)
end

local setlevel = ulx.command(CATEGORY_NAME, "ulx setlevel", ulx.setlevel, "!setlevel")
setlevel:addParam{type=ULib.cmds.PlayerArg}
setlevel:addParam{type=ULib.cmds.NumArg, min=0, default=1, hint="levels", ULib.cmds.round}
setlevel:defaultAccess(ULib.ACCESS_SUPERADMIN)
setlevel:help("Set the target(s) specified amount of levels")

function ulx.setilvl(caller, ilvl)
    GAMEMODE:SetInfectionLevel(ilvl)

	ulx.fancyLogAdmin(caller, "#A set infection level to #i%", ilvl)
end

local setilvl = ulx.command(CATEGORY_NAME, "ulx setilvl", ulx.setilvl, "!setilvl")
setilvl:addParam{type=ULib.cmds.NumArg, min=0, default=0, hint="infection level", ULib.cmds.round}
setilvl:defaultAccess(ULib.ACCESS_SUPERADMIN)
setilvl:help("Set infection level")
