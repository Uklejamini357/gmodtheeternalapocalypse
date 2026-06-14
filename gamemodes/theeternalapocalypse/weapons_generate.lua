-- Generate template for all ArcCW's attachments

local wholestring = ""
local save = false
local all_attachments = save and util.JSONToTable(file.Read("arccw_genweps_tblload.txt") or "{}") or {}
local weps = {}
local weps_models = {}
for k,v in pairs(LocalPlayer():GetWeapons()) do
    weps[v:GetClass()] = v:GetTable()
    weps_models[v:GetClass()] = v:GetModel()
end

for k,v in SortedPairs(weps) do
    if !v.Trivia_Desc then continue end
    local icon = string.format("\
    Material = \"%s\",", "entities/"..k..".png")


local s = string.format([[GM:CreateItem("%s", {
    Name = "%s",
    Description = %s,
    Cost = 1000,
    Model = "%s",%s
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_WEAPONS,
    ItemType = ITEMTYPE_WEAPON,

    WeaponType = "%s",
    ArcCWCompatible = true,
    ModOrigin = modOrigin
})]], k, string.Replace(v.PrintName, "\"", "\\\""), #string.Explode("\n", v.Trivia_Desc) == 1 and "\""..string.Replace(v.Trivia_Desc, "\"", "\\\"").."\"" or "[["..v.Trivia_Desc.."]]", weps_models[k], icon, k)

    s = s.."\n\n"

    wholestring = wholestring..s
end

file.Write("arccw_genweps_tbl.txt", wholestring)
if save then
    file.Write("arccw_genweps_tblload.txt", util.TableToJSON(all_attachments, true))
end
