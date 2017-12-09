f = File.readlines('item_links_notdone')
f.each_with_index do |i,index|
    if i != "\n"
        f.delete_at(index)
        break
    end
end
p = File.open('item_links_notdone','w')
f.each do |i|
    p.puts(i)
end