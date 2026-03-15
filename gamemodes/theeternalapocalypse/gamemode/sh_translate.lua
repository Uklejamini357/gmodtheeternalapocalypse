-- Translation library by William Moodhe
-- Feel free to use this in your own addons.
-- See the languages folder to add your own languages.

--[[Copied from ZS because was too lazy to add one by myself]]

translate = {}
local translate = translate

local Languages = {}
local Translations = {}
local AddingLanguage
local DefaultLanguage = "en"
local CurrentLanguage = DefaultLanguage

translate.Languages = Languages
-- DEBUG.
local tea_debug_translate = CreateConVar("tea_debug_translate", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Debug the translated text")
translate.DebugTranslate = tea_debug_translate:GetBool()
cvars.AddChangeCallback("tea_debug_translate", function(cvar, old, new)
	translate.DebugTranslate = tobool(new)
	BroadcastLua(string.format([[translate.DebugTranslate = %s]], tobool(new)))
end, "tea_debug_translate")

local tea_debug_notranslate = CreateConVar("tea_debug_notranslate", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Don't actually translate")
translate.DebugNoTranslate = tea_debug_notranslate:GetBool()
cvars.AddChangeCallback("tea_debug_notranslate", function(cvar, old, new)
	translate.DebugNoTranslate = tobool(new)
	BroadcastLua(string.format([[translate.DebugNoTranslate = %s]], tobool(new)))
end, "tea_debug_notranslate")

if CLIENT then
	-- Need to make a new convar since gmod_language isn't sent to server.
	
	local gmod_language = GetConVar("gmod_language")
	local gmod_language_rep = CreateClientConVar("gmod_language_rep", DefaultLanguage, false, true)
	local changeLanguage
	local tea_cl_languageoverride = CreateClientConVar("tea_cl_languageoverride", "default", true, true, "Overrides gmod_language_rep. Use \"override\" to use gmod_language's current language, \"default\" for server's default")
	cvars.AddChangeCallback("tea_cl_languageoverride", function(cvar, old, new)
		CurrentLanguage = new
		changeLanguage()
	end, "tea_cl_languageoverride")

	function changeLanguage()
		local l = tea_cl_languageoverride:GetString()
		CurrentLanguage = l == "override" and gmod_language:GetString() or l == "default" and DefaultLanguage or l
		if CurrentLanguage ~= gmod_language_rep:GetString() then
			-- Let server know our language changed.
			RunConsoleCommand("gmod_language_rep", CurrentLanguage)
		end
	end


	timer.Create("checklanguagechange", 1, 0, changeLanguage)
end

local translate_GetLanguages
local translate_GetLanguageName
local translate_GetTranslations
local translate_AddLanguage
local translate_AddTranslation
local translate_Get
local translate_Format
local translate_ClientGet
local translate_ClientFormat
local plPrintMessage


function translate.GetLanguages()
	return Languages
end

function translate.GetLanguageName(short)
	return Languages[short]
end

function translate.GetTranslations(short)
	return Translations[short] or Translations[DefaultLanguage]
end

function translate.AddLanguage(short, long)
	Languages[short] = long
	Translations[short] = Translations[short] or {}
	AddingLanguage = short
end

function translate.AddTranslation(id, text)
	if not AddingLanguage or not Translations[AddingLanguage] then return end

	Translations[AddingLanguage][id] = text
end

local function returnDefault(id)
	return translate.DebugTranslate and "@"..id.."@" or id
end

function translate.Get(id)
	if translate.DebugNoTranslate then
		return returnDefault(id)
	end

	return translate_GetTranslations(CurrentLanguage)[id] or translate_GetTranslations(DefaultLanguage)[id] or returnDefault(id)
end

function translate.Format(id, ...)
	return string.format(translate_Get(id), ...)
end

if SERVER then
	function translate.ClientGet(pl, ...)
		CurrentLanguage = pl:GetInfo("gmod_language_rep")
		return translate_Get(...)
	end

	function translate.ClientFormat(pl, ...)
		CurrentLanguage = pl:GetInfo("gmod_language_rep")
		return translate_Format(...)
	end

	function PrintTranslatedMessage(printtype, str, ...)
		for _, pl in ipairs(player.GetAll()) do
			pl:PrintMessage(printtype, translate_ClientFormat(pl, str, ...))
		end
	end
end

if CLIENT then
	function translate.ClientGet(_, ...)
		return translate_Get(...)
	end
	function translate.ClientFormat(_, ...)
		return translate_Format(...)
	end
end

translate_GetLanguages = translate.GetLanguages
translate_GetLanguageName = translate.GetLanguageName
translate_GetTranslations = translate.GetTranslations
translate_AddLanguage = translate.AddLanguage
translate_AddTranslation = translate.AddTranslation
translate_Get = translate.Get
translate_Format = translate.Format
translate_ClientGet = translate.ClientGet
translate_ClientFormat = translate.ClientFormat


local function AddLanguages(late)
	local GM = GM or translate
	for i, filename in pairs(file.Find(GM.FolderName.."/gamemode/"..(late and "late_languages" or "languages").."/*.lua", "LUA")) do
		local _LANG = LANG
		LANG = {}
		AddCSLuaFile((late and "late_languages" or "languages").."/"..filename)
		include((late and "late_languages" or "languages").."/"..filename)
		for k, v in pairs(LANG) do
			translate_AddTranslation(k, v)
		end
		LANG = _LANG
	end
end

AddLanguages()

/* -- Not working due to ERROR
timer.Simple(0, function()
	AddLanguages(true)
end)
*/

local meta = FindMetaTable("Player")
if not meta then return end

plPrintMessage = meta.PrintMessage
function meta:PrintTranslatedMessage(hudprinttype, translateid, ...)
	if ... ~= nil then
		plPrintMessage(self, hudprinttype, translate.ClientFormat(self, translateid, ...))
	else
		plPrintMessage(self, hudprinttype, translate.ClientGet(self, translateid))
	end
end
