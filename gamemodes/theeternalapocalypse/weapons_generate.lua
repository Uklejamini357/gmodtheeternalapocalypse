-- Generate template for all ArcCW's attachments

local wholestring = ""
local save = false
local all_attachments = save and util.JSONToTable(file.Read("arccw_genweps_tblload.txt") or "{}") or {}
local weps = {}
for k,v in pairs(LocalPlayer():GetWeapons()) do
    weps[v:GetClass()] = v:GetTable()
end

for k,v in pairs(weps) do
    local icon = v.Icon

    if icon then
        local s,e = string.find(tostring(icon), "entities/*")

        local a
        if s and e then
            a = string.sub(tostring(icon), s)
        end
        icon = ""

        if a then
            if a[#a] == "]" then
                a = string.sub(a, 1, #a-1)
                a = a..".png"
            end
            
            icon = string.format("\
    Material = \"%s\",", a)
        end
    else
        icon = ""
    end


local s = string.format([[GM:CreateItem("%s", {
    Name = "%s",
    Description = %s,
    Cost = 1000,
    Model = "models/Items/BoxSRounds.mdl",%s
    Weight = 0.3,
    Supply = 0,
    Rarity = RARITY_RARE,
    Category = ITEMCATEGORY_MISCELLANEOUS,
    ItemType = ITEMTYPE_ARCCW_WEAPONATT,

    ArcCWAtt = "%s"
})]], k, string.Replace(v.PrintName, "\"", "\\\""), #string.Explode("\n", v.Description) == 1 and "\""..string.Replace(v.Description, "\"", "\\\"").."\"" or "[["..v.Description.."]]", icon, k)

    s = s.."\n\n"

    wholestring = wholestring..s
end

file.Write("arccw_genweps_tbl.txt", wholestring)
if save then
    file.Write("arccw_genweps_tblload.txt", util.TableToJSON(all_attachments, true))
end
