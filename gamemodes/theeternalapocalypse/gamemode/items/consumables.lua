-- Consumable items --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, {
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = category,
    UseFunc = function(ply, targetply) return UseFunc_Heal(ply, targetply, usetime, health, infection, playsound) end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,

-- Additional variables if needed
    IsSecret = false,
    CanUseOnOthers = true   -- Highly recommended to use for certain medical items. UseFunc will need a 2nd argument to be providable!
})

]]


local i = GM:CreateItem("item_bandage", {
	Cost = 55,
	Model = "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl",
	Weight = 0.06,
	Supply = 0,
	Rarity = 2,
	Category = ITEMCATEGORY_SUPPLIES,
	UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 11, 0, "theeternalapocalypse/items/inv_bandages.ogg") return healing end,
	DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,
    CanUseOnOthers = true
})

i = GM:CreateItem("item_medkit", {
    Cost = 175,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
    Weight = 0.5,
    Supply = 30,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 45, 5, "theeternalapocalypse/items/inv_aptecka.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_medkit") return drop end,
    CanUseOnOthers = true
})

i = GM:CreateItem("item_armymedkit", {
    Cost = 300,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl",
    Weight = 0.6,
    Supply = 10,
    Rarity = 4,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 70, 20, "theeternalapocalypse/items/inv_aptecka.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armymedkit") return drop end,
    CanUseOnOthers = true
})

i = GM:CreateItem("item_scientificmedkit", {
    Cost = 500,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl",
    Weight = 0.5,
    Supply = 8,
    Rarity = 4,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 3, 100, 60, "theeternalapocalypse/items/inv_aptecka.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_scientificmedkit") return drop end,
    CanUseOnOthers = true
})

i = GM:CreateItem("item_medbag_enhanced", {
    Cost = 6000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_med_bag.mdl",
    Weight = 1.4,
    Supply = 3,
    Rarity = 6,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply)
        local healing = UseFunc_Heal(ply, targetply, 5, 150, 100, "theeternalapocalypse/items/inv_medbag.ogg")
        if healing then
            local entindex = targetply:EntIndex()
            hook.Add("EntityTakeDamage", "TEA.EntityTakeDamage.MedicBagEnhancedEffect_Player"..entindex, function(ent, dmginfo)
                local directdmg = bit.band(DMG_DIRECT, dmginfo:GetDamageType()) ~= 0
    
                if ent == targetply and not directdmg then
                    dmginfo:ScaleDamage(0.7)
                end
            end)
    
            local identifier = "TEA.EntityTakeDamage.MedicBagEnhancedEffect"..entindex
    
            hook.Add("DoPlayerDeath", "TEA.DoPlayerDeath.MedicBagEnhancedEffect_Player"..entindex, function(pl, attacker, dmginfo)
                if pl ~= targetply then return end
                hook.Remove("DoPlayerDeath", "TEA.DoPlayerDeath.MedicBagEnhancedEffect_Player"..entindex)
                hook.Remove("EntityTakeDamage", "TEA.EntityTakeDamage.MedicBagEnhancedEffect_Player"..entindex)
                if timer.Exists(identifier) then
                    timer.Remove(identifier)
                end
    
                if targetply:IsValid() then
                    targetply:PrintMessage(3, "You died, the effect is no longer present!")
                end
            end)
    
            if timer.Exists(identifier) then
                local old = timer.TimeLeft(identifier)
                local new = math.min(150, old + 60)
    
                timer.Adjust(identifier, new, 1)
                if targetply:IsValid() then
                    targetply:PrintMessage(3, "The effect has been prolonged by "..math.Round(new - old , 2).." seconds, remaining: "..math.Round(new, 2).."s")
                end
            else
                timer.Create(identifier, 60, 1, function()
                    hook.Remove("DoPlayerDeath", "TEA.DoPlayerDeath.MedicBagEnhancedEffect_Player"..entindex)
                    hook.Remove("EntityTakeDamage", "TEA.EntityTakeDamage.MedicBagEnhancedEffect_Player"..entindex)
                    if targetply:IsValid() then
                        targetply:PrintMessage(3, "The effect has expired!")
                    end
                end)
                if targetply:IsValid() then
                    targetply:PrintMessage(3, "You now take 30% less damage. Duration: 60s")
                end
            end
        end
        return healing
    end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_medbag_enhanced") return drop end,
    CanUseOnOthers = true
})

GM:CreateItem("item_antidote", {
    Cost = 100,
    Model = "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl",
    Weight = 0.08,
    Supply = 12,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local healing = UseFunc_HealInfection(ply, 3, 40, "items/medshot4.wav") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end,
})

GM:CreateItem("item_egg", {
    Cost = 10,
    Model = "models/props_phx/misc/egg.mdl",
    Weight = 0.08,
    Supply = 0,
    Rarity = 0,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 1, 0, 4, -1, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_egg") return drop end
})

GM:CreateItem("item_milk", {
    Cost = 35,
    Model = "models/props_junk/garbage_milkcarton002a.mdl",
    Weight = 1.05,
    Supply = 20,
    Rarity = 1,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 0, 3, 20, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_milk") return drop end
})

GM:CreateItem("item_soda", {
    Cost = 50,
    Model = "models/props_junk/PopCan01a.mdl",
    Weight = 0.33,
    Supply = 0,
    Rarity = 1,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 3, 1, 3, 35, 5, -0.5, "theeternalapocalypse/items/inv_drink_can2.ogg") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end
})

GM:CreateItem("item_waterbottle", {
    Cost = 80,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_mineral_water.mdl",
    Weight = 0.58,
    Supply = 0,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 5, 1, 4, 80, 5, -1, "theeternalapocalypse/items/inv_water.ogg") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_waterbottle") return drop end
})

GM:CreateItem("item_energydrink", {
    Cost = 100,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl",
    Weight = 0.36,
    Supply = 0,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 1, 2, 30, 55, -6, "theeternalapocalypse/items/inv_drink_can.ogg") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink") return drop end
})

GM:CreateItem("item_energydrink_nonstop", {
    Cost = 145,
    Model = "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl",
    Weight = 0.38,
    Supply = 0,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 4, 2, 3, 32, 85, -8, "theeternalapocalypse/items/inv_drink_can.ogg") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_energydrink_nonstop") return drop end
})

GM:CreateItem("item_beerbottle", {
    Cost = 35,
    Model = "models/props_junk/garbage_glassbottle003a.mdl",
    Weight = 0.8,
    Supply = 10,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Drink(ply, 5, 1, 9, 5, -15, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end
})

GM:CreateItem("item_tinnedfood", {
    Cost = 45,
    Model = "models/props_junk/garbage_metalcan001a.mdl",
    Weight = 0.4,
    Supply = 30,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 2, 3, 20, -10, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end
})

GM:CreateItem("item_potato", {
    Cost = 60,
    Model = "models/props_phx/misc/potato.mdl",
    Weight = 0.2,
    Supply = 20,
    Rarity = 1,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 2, 2, 22, -8, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end
})

GM:CreateItem("item_traderfood", {
    Cost = 75,
    Model = "models/props_junk/garbage_takeoutcarton001a.mdl",
    Weight = 0.6,
    Supply = 5,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 4, 47, -15, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end
})

GM:CreateItem("item_trout", {
    Cost = 95,
    Model = "models/props/CS_militia/fishriver01.mdl",
    Weight = 0.75,
    Supply = 2,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 6, 5, 65, -4, 0, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end
})

GM:CreateItem("item_melon", {
    Cost = 150,
    Model = "models/props_junk/watermelon01.mdl",
    Weight = 2,
    Supply = 3,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 7, 7, 85, 20, 3, 0, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end,
})

GM:CreateItem("item_burger", {
    Cost = 750,
    Model = "models/food/burger.mdl",
    Weight = 0.4,
    Supply = -1,
    Rarity = 7,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 30, 100, 15, 90, -15, "vo/npc/male01/yeah02.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end,
    OnSell = function(ply, amt)
        ply:PrintMessage(3, "bruh did you really SELL THE BURGER WHAT IS WRONG WITH YOU?!?!?")
        timer.Simple(math.Rand(60,180), function()
            if ply:IsValid() and ply:Alive() then ply:Kill() end
        end)
    end
})

GM:CreateItem("item_hotdog", {
    Cost = 400,
    Model = "models/food/hotdog.mdl",
    Weight = 0.35,
    Supply = -1,
    Rarity = 6,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 20, 80, 10, 40, -15, "vo/npc/male01/nice.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_hotdog") return drop end
})

GM:CreateItem("item_donut", {
    Cost = 65,
    Model = "models/noesis/donut.mdl",
    Weight = 0.2,
    Supply = 5,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 3, 2, 25, -7, 5, -1, "npc/barnacle/barnacle_gulp2.wav") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_donut") return drop end,
})

GM:CreateItem("item_bed", {
    Cost = 80,
    Model = "models/props/de_inferno/bed.mdl",
    Weight = 4.5,
    Supply = 0,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
    DropFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
})

GM:CreateItem("item_sleepingbag", {
    Cost = 1130,
    Model = "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl",
    Weight = 2.2,
    Supply = 0,
    Rarity = 5,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) UseFunc_Sleep(ply, false) return false end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end,
})

GM:CreateItem("item_amnesiapills", {
    Cost = 1250,
    Model = "models/props_lab/jar01b.mdl",
    Weight = 0.1,
    Supply = 0,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local bool = UseFunc_Respec(ply) return bool end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end
})

GM:CreateItem("item_armorbattery", {
    Cost = 600,
    Model = "models/Items/battery.mdl",
    Weight = 0.35,
    Supply = 6,
    Rarity = 4,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local armor = UseFunc_Armor(ply, 2, 50, 15, "items/battery_pickup.wav") return armor end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armorbattery") return drop end,
})

GM:CreateItem("item_armorkevlar", {
    Cost = 1500,
    Model = "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl",
    Weight = 1.13,
    Supply = 3,
    Rarity = 5,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local armor = UseFunc_Armor(ply, 4, 0, 35, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_armorkevlar") return drop end,
})

-- S.T.A.L.K.E.R.

GM:CreateItem("item_stalker_beans", {
    Name = "Can of Beans",
    Description = "WIP",
    Cost = 240,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_beans.mdl",
    Weight = 0.62,
    Supply = -1,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 1, 68, -15, 0, -3, "sound") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_beans") return drop end
})

GM:CreateItem("item_stalker_bread", {
    Name = "Bread",
    Description = "WIP",
    Cost = 75,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_bred.mdl",
    Weight = 0.38,
    Supply = -1,
    Rarity = 2,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply) local food = UseFunc_Eat(ply, 3.6, 1, 35, -10, 0, -3, "sound") return food end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_bread") return drop end
})

GM:CreateItem("item_stalker_stimpack", {
    Name = "Improvised Stimpack",
    Description = "Improvised Stimpacks are popular among survivors as they are easy to obtain, and are used for much faster healing.\nThey are usually less effective than a regular medkit, however these are very useful during combats.\nRestores 40 health.",
    Cost = 750,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim1.mdl",
    Weight = 0.22,
    Supply = -1,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 40, 0, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_stimpack") return drop end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_stimpack_army", {
    Name = "Army Stimpack",
    Description = "Military stims constitute a part of standard-issue soldier equipment for field operations in the apocalyptic world.\nEasily available on the market and can be acquired for a moderate price.\nRestores up to 70 health.",
    Cost = 1250,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim2.mdl",
    Weight = 0.26,
    Supply = -1,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 70, 0, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_stimpack_army") return drop end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_stimpack_scientific", {
    Name = "Scientific Stimpack",
    Description = "Created by the same defense research institute in Kiev which developed the well-known SEVA suit, this state-of-the-art solution constitutes the most potent health stabilizer available in the Apocalyptic World.\nBest quality ingredients and perfected formula enable almost instant recuperation and ensure prompt radiation cleansing. Side effects are minimized. High cost practically limits the target group of the drug to most skillful and successful survivors.\nInjected in the thigh it restores up to 105 health and treats 30% infection.",
    Cost = 2000,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim3.mdl",
    Weight = 0.32,
    Supply = -1,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 105, 30, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_stimpack_scientific") return drop end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_beer", {
    Name = "Beer",
    Description = "WIP",
    Cost = 300,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_beer.mdl",
    Weight = 0.66,
    Supply = -1,
    Rarity = 3,
    Category = ITEMCATEGORY_SUPPLIES,
    UseFunc = function(ply, targetply) local drink = UseFunc_Drink(ply, 5, 0, 3, 25, 0, 3, "sound") return drink end,
    DropFunc = function(ply) local drop = UseFunc_DropItem(ply, "item_stalker_beer") return drop end,
    CanUseOnOthers = true
})

