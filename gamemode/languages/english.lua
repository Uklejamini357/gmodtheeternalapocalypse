--[[
English is the standard language that you should base your ID's off of.
If something isn't found in your language file then it will fall back to English.
Valid languages (from gmod's menu): bg cs da de el en en-PT es-ES et fi fr ga-IE he hr hu it ja ko lt nl no pl pt-BR pt-PT ru sk sv-SE th tr uk vi zh-CN zh-TW
You MUST use one of the above when using translate.AddLanguage
]]

--[[Examples"
LANGUAGE.gamemodename = "The Eternal Apocalypse"
translate.Get("gamemodename")
]]

translate.AddLanguage("en", "English")

--HUD translations

LANGUAGE.Health = "Health"
LANGUAGE.Armor = "Armor"
LANGUAGE.Money = "Money"
LANGUAGE.Level = "Level"
LANGUAGE.Prestige = "Prestige"
LANGUAGE.Timesurvived = "Time Survived"
LANGUAGE.Stamina = "Stamina"
LANGUAGE.Hunger = "Hunger"
LANGUAGE.Thirst = "Thirst"
LANGUAGE.Fatigue = "Fatigue"
LANGUAGE.Infection = "Infection"
LANGUAGE.Bounty = "Bounty"
LANGUAGE.Pts = "Pts"
LANGUAGE.XPGained = "XP Gained"
LANGUAGE.MoneyGained = "Cash Gained"
LANGUAGE.CanRespawnIn = "You can respawn in"
LANGUAGE.CanNowRespawn = "You are now able to respawn!"
LANGUAGE.Seconds = "seconds"
LANGUAGE.Second = "second"
LANGUAGE.NeedToEatHunger = "WARNING! You are starving, you need to eat something!"
LANGUAGE.NeedToDrinkThirst = "WARNING! You are dying from dehydration, drink something!"
LANGUAGE.NeedToSleepFatigue = "WARNING! You are about to die from fatigue, find somewhere to sleep!"
LANGUAGE.NeedToCureInfection = "WARNING! You are about to die from infection, find a cure!"

--Inventory

LANGUAGE.CurrentlyCarrying = "Currently Carrying"
LANGUAGE.MaxWeight = "Max Carry Weight"
LANGUAGE.ItemID = "Item ID"

--Factions

LANGUAGE.Faction = "Faction"
LANGUAGE.CreateFaction = "Create a new faction"
LANGUAGE.ManageFaction = "Manage your faction"
LANGUAGE.LeaveFaction = "Leave your faction"
