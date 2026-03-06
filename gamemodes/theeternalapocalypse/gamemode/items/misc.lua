-- Miscellaneous Items --

--[[ -- Use this function template for adding new items!
GM:CreateItem(itemid, {
    Cost = cost,
    Model = model,
    Weight = weight,
    Supply = supply,
    Rarity = rarity,
    Category = category,
    UseFunc = function(ply) return false end,
    DropFunc = function(ply, item) return true end

-- Additional variables if needed
    IsSecret = false,
})

]]

-- Sellables


local i = GM:CreateItem("item_radio", {
    Cost = 300,
    Model = "models/wick/wrbstalker/anomaly/items/dez_radio.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_scrap", {
    Cost = 350,
    Model = "models/Gibs/helicopter_brokenpiece_02.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) local armor = UseFunc_Armor(ply, 3, 0, 10, "npc/combine_soldier/zipline_hitground2.wav") return armor end,
})

i = GM:CreateItem("item_chems", {
    Cost = 600,
    Model = "models/props_junk/plasticbucket001a.mdl",
    Weight = 1.5,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_tv", {
    Cost = 800,
    Model = "models/props_c17/tv_monitor01.mdl",
    Weight = 2,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_beer", {
    Cost = 1200,
    Model = "models/props/CS_militia/caseofbeer01.mdl",
    Weight = 5,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_hamradio", {
    Cost = 1500,
    Model = "models/props_lab/citizenradio.mdl",
    Weight = 2.5,
    Supply = -1,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_computer", {
    Cost = 2000,
    Model = "models/props_lab/harddrive02.mdl",
    Weight = 4,
    Supply = -1,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_blueprint_sawbow", {
    Cost = 5000,
    Model = "models/props_lab/clipboard.mdl",
    Weight = 0.25,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouseweapon")) return false end,
})

i = GM:CreateItem("item_blueprint_railgun", {
    Cost = 5000,
    Model = "models/props_lab/clipboard.mdl",
    Weight = 0.25,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnouseweapon")) return false end,
})


-- crafting related


i = GM:CreateItem("item_craft_fueltank", {
    Cost = 500,
    Model = "models/props_junk/metalgascan.mdl",
    Weight = 0.25,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
})

i = GM:CreateItem("item_craft_wheel", {
    Cost = 300,
    Model = "models/props_vehicles/carparts_wheel01a.mdl",
    Weight = 1.5,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
})

i = GM:CreateItem("item_craft_oil", {
    Cost = 500,
    Model = "models/props_junk/garbage_plasticbottle001a.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
})

i = GM:CreateItem("item_craft_battery", {
    Cost = 500,
    Model = "models/Items/car_battery01.mdl",
    Weight = 0.6,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousecraftable")) return false end,
})

i = GM:CreateItem("item_craft_ecb", {
    Cost = 250,
    Model = "models/props_lab/reciever01b.mdl",
    Weight = 0.35,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousecraftable")) return false end,
})

i = GM:CreateItem("item_craft_engine_small", {
    Cost = 1000,
    Model = "models/gibs/airboat_broken_engine.mdl",
    Weight = 3,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
})

i = GM:CreateItem("item_craft_engine_large", {
    Cost = 3000,
    Model = "models/props_c17/TrapPropeller_Engine.mdl",
    Weight = 5,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousevehicle")) return false end,
})


-- Explosives


i = GM:CreateItem("item_propane", {
    Name = "Propane",
    Description = "An explosive propane. Handle with caution! Explodes violently upon being shot at or if it hits the ground too hard.",
    Cost = 5000,
    Model = "models/props_junk/PropaneCanister001a.mdl",
    Weight = 5.6,
    Supply = -1,
    Rarity = RARITY_UNOBTAINABLE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) local drop = UseFunc_DropEntity(ply, "prop_tea_propane") return drop end,
    DropFunc = function(ply, item) local drop = UseFunc_DropEntity(ply, "prop_tea_propane") return drop end
})

-- Other Sellables

i = GM:CreateItem("item_toolkit_1", {
    Cost = 6000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_1.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_toolkit_2", {
    Cost = 8000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_2.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})

i = GM:CreateItem("item_toolkit_3", {
    Cost = 10000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_3.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet(ply, "itemnousesellable")) return false end,
})



-- Misc


i = GM:CreateItem("item_boss_shard", {
    Cost = 45000,
    Model = "models/props_junk/rock001a.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_EVENT,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        local random = table.Random({
            "This is going to be a terrible time...",
            "Calm before the storm...",
            "A boss is being created by the unknown powers...",
            "There is no going back now...",
        })
        GAMEMODE:SystemBroadcast(random, Color(115,205,205), false)
        GAMEMODE:SpawnBoss(#player.GetAll() + 8, true)
    return true end,
})

i = GM:CreateItem("item_difficulty_shard", {
    Cost = 35000,
    Model = "models/props_junk/rock001a.mdl",
    Weight = 1,
    Supply = -1,
    Rarity = RARITY_EVENT,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        if GAMEMODE.InfectionLevelIncreaseType ~= 1 then
            ply:PrintTranslatedMessage(3, "difficulty_shard_not_usable")
            return false
        end
        local random = table.Random({
            "You feel like zombies suddenly become stronger...",
            "Zombies become stronger. This isn't good...",
            "You are not going to survive this...",
        })

        local set = math.max(0, GAMEMODE:GetInfectionLevel() + 50)
        GAMEMODE:SystemBroadcast(random.." ("..GAMEMODE:GetInfectionLevel().."% -> "..set.."%)", Color(115,205,205), false)
        GAMEMODE:SetInfectionLevel(set)
    return true end,
})

i = GM:CreateItem("item_oxygentank", {
    Name = "Oxygen Tank",
    Description = "An air tank filled with Oxygen. For use in underwater explorations, in case of running out of oxygen to quickly refill oxygen.\nBest use with Closed-Cycle Respiration suits.",
    Cost = 1500,
    Model = "models/props_c17/canister01a.mdl",
    Weight = 1.8,
    Supply = 5,
    Rarity = RARITY_UNCOMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        ply.Oxygen = 100
        ply:SendChat(translate.ClientGet(ply, "oxygen_refilled"))
        return true
    end,
})

i = GM:CreateItem("item_airdropradio", {
    Name = "Airdrop Radio",
    Description = "Calls an airdrop.",
    Cost = 30000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_detector_09.mdl",
    Weight = 0.7,
    Supply = -1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        GAMEMODE.NextAirdropSpawn = math.max(GAMEMODE.NextAirdropSpawn, CurTime() + math.random(600, 1200))

        local delay = math.Rand(60, 90)
        timer.Simple(delay, function()
            gamemode.Call("SpawnAirdrop")
        end)
        ply:PrintMessage(3, "Airdrop called, the package will arrive shortly within "..math.Round(delay).." seconds.")

        return true
    end,

    IgnoreCostModifiers = true,
})

i = GM:CreateItem("item_bossdetector", {
    Name = "Boss Detector",
    Description = "Can detect any nearby boss zombies. On use drains 50% of your battery.\nEffective range: ~350m",
    Cost = 30000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_detector_8.mdl",
    Weight = 0.55,
    Supply = -1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        local timerhandler = "ItemDetectorTimer"..ply:EntIndex()
        if timer.Exists(timerhandler) then return false end
        if ply.Battery <= 50 then ply:PrintMessage(3, "Not enough battery!") return false end

        ply.Battery = ply.Battery - 50
        ply:PrintMessage(3, "Detecting any nearby boss zombies...")

        local boss

        local beep = 0
        local beepedonce
        local distance
        timer.Create(timerhandler, 0.1, 0, function() -- could use hook instead, but eh
            boss = nil
            for _,ent in pairs(ents.FindInSphere(ply:GetPos(), 14000)) do
                if (ent:IsNextBot() or ent:IsNPC()) and ent.BossMonster then
                    boss = ent
                    break
                end
            end


            if !boss or !boss:IsValid() then return end
            distance = math.max(250, ply:GetPos():Distance(boss:GetPos()))
            beep = beep + math.min(10, (1e3 * 1/distance)^0.75)*0.5
            if beep >= 1 then
                beep = beep - 1
                beepedonce = true
                ply:EmitSound("theeternalapocalypse/items/boss_detector_beep.ogg", 50, 100, 0.6, CHAN_AUTO)
            end
        end)

        timer.Simple(math.Rand(4,5), function()
            timer.Remove(timerhandler)

            if distance and beepedonce then
                ply:PrintMessage(3, "Nearest boss: "..(distance < 1000 and "Very near!" or math.Round(distance, -3)/40 .."m"))
            else
                ply:PrintMessage(3, "No bosses found!")
            end
        end)

        return false
    end,

    IgnoreCostModifiers = true,
})

i = GM:CreateItem("item_airdropdetector", {
    Name = "Airdrop Detector",
    Description = "This IFF Jammer detector can detect any dropped airdrop that is left untouched. On use drains 40% of your battery.\nEffective range: ~300m",
    Cost = 35000,
    Model = "models/wick/wrbstalker/anomaly/items/wick_dev_detector_8.mdl",
    Weight = 0.55,
    Supply = -1,
    Rarity = RARITY_MYTHIC,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply)
        local timerhandler = "ItemDetectorTimer"..ply:EntIndex()
        if timer.Exists(timerhandler) then return false end
        if ply.Battery <= 40 then ply:PrintMessage(3, "Not enough battery!") return false end

        ply.Battery = ply.Battery - 40
        ply:PrintMessage(3, "Detecting any nearby airdrops...")

        ply:EmitSound("theeternalapocalypse/items/airdrop_detector_noise.ogg", 60, 100, 0.6)

        local airdrop
        local distance
        timer.Simple(math.Rand(6,7), function()
            for _,ent in pairs(ents.FindByClass("airdrop_cache")) do
                distance = ent:GetPos():Distance(ply:GetPos())
                if distance < 12000 then
                    airdrop = ent
                    break
                end
            end

            ply:StopSound("theeternalapocalypse/items/airdrop_detector_noise.ogg")
            ply:EmitSound("theeternalapocalypse/items/airdrop_detector_off.ogg", 60, 100, 0.7)

            if airdrop and airdrop:IsValid() then
                ply:PrintMessage(3, "Airdrop is "..(distance < 6000 and "quite near!" or "somewhere near!"))
            else
                ply:PrintMessage(3, "Couldn't find any nearby airdrops!")
            end
        end)

        return false
    end,

    IgnoreCostModifiers = true,
})

i = GM:CreateItem("item_money", {
    Cost = 0,
    Model = "models/props/cs_assault/Money.mdl",
    Weight = 0,
    Supply = -1,
    Rarity = RARITY_COMMON,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientFormat(ply, "added_x_moneys_to_account", ply.Inventory["item_money"])) ply.Money = ply.Money + ply.Inventory["item_money"] ply.Inventory["item_money"] = nil return false end,
    CantDropItem = function(ply, item) ply:SendChat(translate.ClientGet(ply, "you_may_not_drop_this_item")) return true end,
})

i = GM:CreateItem("item_moneyprinter", {
    Name = "Money Printer",
    Description = "A money printer from DarkRP?!",
    Cost = 0,
    Model = "models/props_c17/consolebox01a.mdl",
    Weight = 5,
    Supply = -1,
    Rarity = RARITY_EPIC,
    Category = ITEMCATEGORY_MISCELLANEOUS,
	ItemType = ITEMTYPE_OTHER,
    UseFunc = function(ply) ply:SendChat(translate.ClientGet("you_cant_use_this_yet")) return false end,
})
