-- Generate template for all ArcCW's attachments

local wholestring = ""
local save = true
local all_attachments = save and util.JSONToTable(file.Read("uc_attachments_tblload.txt") or "{}") or {}
for k,v in SortedPairs(ArcCW.AttachmentTable) do
    if all_attachments[k] then continue end
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


local s = string.format([[GM:CreateItem("arccw_acwatt_%s", {
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

    all_attachments[k] = true

    wholestring = wholestring..s
end

file.Write("uc_attachments_table.txt", wholestring)
if save then
    file.Write("uc_attachments_tblload.txt", util.TableToJSON(all_attachments, true))
end
