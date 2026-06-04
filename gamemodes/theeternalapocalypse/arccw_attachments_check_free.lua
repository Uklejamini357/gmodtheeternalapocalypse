--

print("Free attachments:")
for k,v in SortedPairs(ArcCW.AttachmentTable) do
    if v.Free then
        for i,v in pairs(GAMEMODE.ItemsList) do
            if v.ArcCWAtt ~= k then continue end
            print(k, i)
            break
        end
    end
end