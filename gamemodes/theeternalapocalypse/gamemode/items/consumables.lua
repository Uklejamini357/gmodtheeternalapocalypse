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
    DropFunc = function(ply, _, item) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,

    CanUseOnOthers = true   -- Highly recommended to use for certain medical items. UseFunc will need a 2nd argument to be providable!
})

]]


local i = GM:CreateItem("item_bandage", {
	Cost = 35,
	Model = "models/wick/wrbstalker/anomaly/items/wick_dev_bandage.mdl",
	Weight = 0.06,
	Supply = 0,
	Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 3,
        Health = 11,
        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_bandages.ogg",

    CanUseOnOthers = true
})

i = GM:CreateItem("item_medkit", {
    Cost = 150,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_low.mdl",
    Weight = 0.5,
    Supply = 30,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 3,
        Health = 45,
        Infection = -5,
    },
    UseSound = "theeternalapocalypse/items/inv_aptecka.ogg",

    CanUseOnOthers = true
})

i = GM:CreateItem("item_armymedkit", {
    Cost = 220,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl",
    Weight = 0.6,
    Supply = 10,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 3,
        Health = 70,
        Infection = -20,
    },
    UseSound = "theeternalapocalypse/items/inv_aptecka.ogg",

    CanUseOnOthers = true
})

i = GM:CreateItem("item_scientificmedkit", {
    Cost = 350,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl",
    Weight = 0.5,
    Supply = 8,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 3,
        Health = 100,
        Infection = -60,
    },
    UseSound = "theeternalapocalypse/items/inv_aptecka.ogg",

    CanUseOnOthers = true
})

i = GM:CreateItem("item_medbag_enhanced", {
    Cost = 3000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_med_bag.mdl",
    Weight = 1.4,
    Supply = 3,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 5,
        Health = 150,
        Infection = -100,
        AdditionalFunc = function(ply, targetply)
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
    },
    UseSound = "theeternalapocalypse/items/inv_medbag.ogg",

    CanUseOnOthers = true,
    AddDesc = "+30% damage resistance for 60 seconds (Effect can be prolonged, max 150 seconds)",
})

GM:CreateItem("item_antidote", {
    Cost = 100,
    Model = "models/wick/wrbstalker/cop/newmodels/items/wick_antidot.mdl",
    Weight = 0.08,
    Supply = 12,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 3,
        Infection = -40,
    },
    UseSound = "items/medshot4.wav",
})

GM:CreateItem("item_egg", {
    Cost = 10,
    Model = "models/props_phx/misc/egg.mdl",
    Weight = 0.08,
    Supply = -1,
    Rarity = RARITY_GARBAGE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 1,
        Hunger = 4,
        Thirst = -1,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_milk", {
    Cost = 35,
    Model = "models/props_junk/garbage_milkcarton002a.mdl",
    Weight = 1.05,
    Supply = 20,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 4,
        Hunger = 3,
        Thirst = 20,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_soda", {
    Cost = 50,
    Model = "models/props_junk/PopCan01a.mdl",
    Weight = 0.33,
    Supply = 0,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 3,
        Health = 1,
        Hunger = 3,
        Thirst = 35,
        Stamina = 5,
        Fatigue = -0.5,
    },
    UseSound = "theeternalapocalypse/items/inv_drink_can2.ogg",
})

GM:CreateItem("item_waterbottle", {
    Cost = 80,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_mineral_water.mdl",
    Weight = 0.58,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 5,
        Health = 1,
        Hunger = 4,
        Thirst = 80,
        Stamina = 5,
        Fatigue = -1,
    },
    UseSound = "theeternalapocalypse/items/inv_water.ogg",
})

GM:CreateItem("item_energydrink", {
    Cost = 100,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_drink_stalker.mdl",
    Weight = 0.36,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 4,
        Health = 1,
        Hunger = 2,
        Thirst = 30,
        Stamina = 55,
        Fatigue = -6,

        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_drink_can.ogg",
})

GM:CreateItem("item_energydrink_nonstop", {
    Cost = 145,
    Model = "models/wick/wrbstalker/cop/newmodels/items/wick_nonstop.mdl",
    Weight = 0.38,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 4,
        Health = 2,
        Hunger = 3,
        Thirst = 32,
        Stamina = 85,
        Fatigue = -8,

        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_drink_can.ogg",
})

GM:CreateItem("item_beerbottle", {
    Cost = 35,
    Model = "models/props_junk/garbage_glassbottle003a.mdl",
    Weight = 0.8,
    Supply = 10,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 5,
        Health = 1,
        Hunger = 9,
        Thirst = 5,
        Stamina = -15,
        Fatigue = 10,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_tinnedfood", {
    Cost = 45,
    Model = "models/props_junk/garbage_metalcan001a.mdl",
    Weight = 0.4,
    Supply = 30,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 2,
        Health = 3,
        Hunger = 20,
        Thirst = -10,
        Stamina = 0,
        Fatigue = 0,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_potato", {
    Cost = 60,
    Model = "models/props_phx/misc/potato.mdl",
    Weight = 0.2,
    Supply = 20,
    Rarity = RARITY_JUNK,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 2,
        Health = 2,
        Hunger = 22,
        Thirst = -8,
        Stamina = 0,
        Fatigue = 0,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_traderfood", {
    Cost = 75,
    Model = "models/props_junk/garbage_takeoutcarton001a.mdl",
    Weight = 0.6,
    Supply = 5,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 5,
        Health = 4,
        Hunger = 47,
        Thirst = -15,
        Stamina = 0,
        Fatigue = 0,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_trout", {
    Cost = 95,
    Model = "models/props/CS_militia/fishriver01.mdl",
    Weight = 0.75,
    Supply = 2,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 6,
        Health = 5,
        Hunger = 65,
        Thirst = -4,
        Stamina = 0,
        Fatigue = 0,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_melon", {
    Cost = 150,
    Model = "models/props_junk/watermelon01.mdl",
    Weight = 2,
    Supply = 3,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 7,
        Health = 7,
        Hunger = 85,
        Thirst = 20,
        Stamina = 3,
        Fatigue = 0,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_burger", {
    Cost = 750,
    Model = "models/food/burger.mdl",
    Weight = 0.4,
    Supply = -1,
    Rarity = RARITY_LEGENDARY,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 5,
        Health = 30,
        Hunger = 100,
        Thirst = 15,
        Stamina = 90,
        Fatigue = -15,
    },
    UseSound = "vo/npc/male01/yeah02.wav",

    OnSell = function(ply, amt)
        ply:PrintMessage(3, "bruh did you really SELL THE BURGER WHAT IS WRONG WITH YOU?!?!?")
        timer.Simple(math.Rand(60,180), function()
            if ply:IsValid() and ply:Alive() then
                ply.CauseOfDeath = "Death Unknown"
                ply.DeathMessage = "has died mysteriously"
                ply:Kill()
                local rag = ply:GetRagdollEntity()
                if rag and rag:IsValid() then
                    rag:Dissolve()
                end
            end
        end)
    end
})

GM:CreateItem("item_hotdog", {
    Cost = 400,
    Model = "models/food/hotdog.mdl",
    Weight = 0.35,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 5,
        Health = 20,
        Hunger = 80,
        Thirst = 10,
        Stamina = 40,
        Fatigue = -15,
    },
    UseSound = "vo/npc/male01/nice.wav",
})

GM:CreateItem("item_donut", {
    Cost = 65,
    Model = "models/noesis/donut.mdl",
    Weight = 0.2,
    Supply = 5,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 3,
        Health = 2,
        Hunger = 25,
        Thirst = -7,
        Stamina = 5,
        Fatigue = -1,
    },
    UseSound = "npc/barnacle/barnacle_gulp2.wav",
})

GM:CreateItem("item_bed", {
    Cost = 80,
    Model = "models/props/de_inferno/bed.mdl",
    Weight = 4.5,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
    DropFunc = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
})

GM:CreateItem("item_sleepingbag", {
    Cost = 1130,
    Model = "models/wick/wrbstalker/anomaly/items/dez_item_sleepbag.mdl",
    Weight = 2.2,
    Supply = 0,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) UseFunc_Sleep(ply, false) return false end,
})

GM:CreateItem("item_amnesiapills", {
    Cost = 1250,
    Model = "models/props_lab/jar01b.mdl",
    Weight = 0.1,
    Supply = 0,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) local bool = UseFunc_Respec(ply) return bool end,
})

GM:CreateItem("item_armorbattery", {
    Cost = 420,
    Model = "models/Items/battery.mdl",
    Weight = 0.35,
    Supply = 6,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_OTHER,

    ConsumableStats = {
        UseTime = 2,
        Battery = 50,
        Armor = 25,
    },
    UseSound = "items/battery_pickup.wav",
})

GM:CreateItem("item_armorkevlar", {
    Cost = 800,
    Model = "models/wick/wrbstalker/anomaly/items/dez_kevlar.mdl",
    Weight = 1.13,
    Supply = 3,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_OTHER,

    ConsumableStats = {
        UseTime = 4,
        Battery = 0,
        Armor = 55,
    },
    UseSound = "npc/combine_soldier/zipline_hitground2.wav",
})

-- S.T.A.L.K.E.R.

GM:CreateItem("item_stalker_beans", {
    Name = "Can of Beans",
    Description = "WIP",
    Cost = 240,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_beans.mdl",
    Weight = 0.62,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 5,
        Health = 1,
        Hunger = 68,
        Thirst = -15,
        Stamina = 0,
        Fatigue = -3,
    },
    UseSound = "sound",

    UseFunc = function(ply) local food = UseFunc_Eat(ply, 5, 1, 68, -15, 0, -3, "sound") return food end,
})

GM:CreateItem("item_stalker_bread", {
    Name = "Bread",
    Description = "WIP",
    Cost = 75,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_bred.mdl",
    Weight = 0.38,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 3.6,
        Health = 1,
        Hunger = 35,
        Thirst = -10,
        Stamina = 0,
        Fatigue = -3,
    },
    UseSound = "sound",

    UseFunc = function(ply) local food = UseFunc_Eat(ply, 3.6, 1, 35, -10, 0, -3, "sound") return food end,
})

GM:CreateItem("item_stalker_stimpack", {
    Name = "Improvised Stimpack",
    Description = "Improvised Stimpacks are popular among survivors as they are easy to obtain, and are used for much faster healing.\nThey are usually less effective than a regular medkit, however these are very useful during combats.\nRestores 40 health.",
    Cost = 750,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim1.mdl",
    Weight = 0.22,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 1.6,
        Health = 40,
        Infection = 0,
        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_stimpack.ogg",

    -- UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 40, 0, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_stimpack_army", {
    Name = "Army Stimpack",
    Description = "Military stims constitute a part of standard-issue soldier equipment for field operations in the apocalyptic world.\nEasily available on the market and can be acquired for a moderate price.\nRestores up to 70 health.",
    Cost = 1250,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim2.mdl",
    Weight = 0.26,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 1.6,
        Health = 70,
        Infection = 0,
        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_stimpack.ogg",

    -- UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 70, 0, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_stimpack_scientific", {
    Name = "Scientific Stimpack",
    Description = "Created by the same defense research institute in Kiev which developed the well-known SEVA suit, this state-of-the-art solution constitutes the most potent health stabilizer available in the Apocalyptic World.\nBest quality ingredients and perfected formula enable almost instant recuperation and ensure prompt radiation cleansing. Side effects are minimized. High cost practically limits the target group of the drug to most skillful and successful survivors.\nInjected in the thigh it restores up to 105 health and treats 30% infection.",
    Cost = 2000,
    Model = "models/wick/wrbstalker/anomaly/items/dez_stim3.mdl",
    Weight = 0.32,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_MED,

    ConsumableStats = {
        UseTime = 1.6,
        Health = 105,
        Infection = -30,
        FastUsable = true,
    },
    UseSound = "theeternalapocalypse/items/inv_stimpack.ogg",

    -- UseFunc = function(ply, targetply) local healing = UseFunc_Heal(ply, targetply, 1.6, 105, 30, "theeternalapocalypse/items/inv_stimpack.ogg") return healing end,
    CanUseOnOthers = true
})

GM:CreateItem("item_stalker_beer", {
    Name = "Beer",
    Description = "WIP",
    Cost = 300,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_beer.mdl",
    Weight = 0.66,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_DRINK,

    ConsumableStats = {
        UseTime = 5,
        Health = 0,
        Hunger = 3,
        Thirst = 25,
        Stamina = 0,
        Fatigue = 3,
    },
    UseSound = "sound",

    UseFunc = function(ply, targetply) local drink = UseFunc_Drink(ply, 5, 0, 3, 25, 0, 3, "theeternalapocalypse/items/inv_drink_flask_beer.ogg") return drink end,
})


GM:CreateItem("item_stalker_kolbasa", {
    Name = "Kolbasa",
    Description = "WIP",
    Cost = 180,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_kolbasa.mdl",
    Weight = 0.34,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 5,
        Health = 0,
        Hunger = 3,
        Thirst = 25,
        Stamina = 0,
        Fatigue = 3,
    },
    UseSound = "sound",

    UseFunc = function(ply, targetply) local drink = UseFunc_Eat(ply, 5, 0, 3, 25, 0, 3, "sound") return drink end,
})


--[[
GM:CreateItem("item_stalker_hercules", {
    Name = "Hercules",
    Description = "Temporarily boosts your carrying weight by +12kg for 300 seconds. Effect can be prolonged up to 600 seconds.",
    Cost = 4000,
    Model = "models/wick/wrbstalker/anomaly/items/dez_drug_booster.mdl",
    Weight = 0.17,
    Supply = -1,
    Rarity = RARITY_SUPERRARE,
    Category = ITEMCATEGORY_SUPPLIES,
	ItemType = ITEMTYPE_FOOD,

    ConsumableStats = {
        UseTime = 3
    },
    UseSound = "sound",
})

--  Maybe in future

# antirad
models/wick/wrbstalker/anomaly/items/wick_dev_antirad.mdl

# radioprotectant
models/wick/wrbstalker/anomaly/items/dez_drug_radioprotector.mdl

# sleeping pills


# canned tomatoes
models/wick/wrbstalker/anomaly/items/wick_dev_tomato.mdl

# condensed milk
models/wick/wrbstalker/cop/newmodels/items/wick_condensed_milk.mdl

# MRE
models/wick/wrbstalker/cop/newmodels/items/wick_mre.mdl

# Snickers
models/wick/wrbstalker/cop/newmodels/items/wick_snickers.mdl

# tea
models/wick/wrbstalker/anomaly/items/dez_drink_tea.mdl


# rebirth?
models/wick/wrbstalker/anomaly/items/dez_rebirth.mdl
]]
