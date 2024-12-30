if CLIENT then
    language.Add("ammo_ar2_pulseammo_ammo", "AR2 Pulse Ammo")
    language.Add("ammo_sniper_ammo", "Sniper Ammo")
    language.Add("ammo_rifle_ammo", "Rifle Ammo")
    language.Add("ammo_deadlybolt_ammo", "Deadly Bolts")
    language.Add("ammo_minigun_ammo", "Minigun Rounds")
    language.Add("nade_molotov_ammo", "Molotov Cocktails")
    language.Add("nade_pipebombs_ammo", "Pipe Bombs")
    language.Add("nade_flares_ammo", "Distress Flares")
end


game.AddAmmoType({
    name = "ammo_rifle",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
})

game.AddAmmoType({
    name = "ammo_minigun",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
})

game.AddAmmoType({
    name = "ammo_deadlybolt",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
})

game.AddAmmoType( {
    name = "ammo_ar2_pulseammo",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
   } )

game.AddAmmoType( {
    name = "ammo_sniper",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
} )

game.AddAmmoType( {
    name = "nade_pipebombs",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
} )

game.AddAmmoType( {
    name = "nade_flares",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
} )

game.AddAmmoType({
    name = "nade_molotov",
    dmgtype = DMG_BULLET,
    tracer = TRACER_NONE,
    plydmg = 0,
    npcdmg = 0,
    force = 2000,
    minsplash = 10,
    maxsplash = 5
})
