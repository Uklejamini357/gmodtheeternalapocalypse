--
timer.Create("Timed_Blowouts", 10000, 0, function()
    local ent = math.random(3) == 1 and ents.FindByName("psi_button")[1] or ents.FindByName("blowout_button")[1]

    if ent and IsValid(ent) then
        ent:Fire("Press")
    end
end)


return true -- return true whether to make it serverside only
