require 'mechanize'
require 'json'

f = File.readlines('item_links')
f.each_with_index do |i, index| 
    p f
    f[index]=nil
    a = File.open('item_links_notdone', 'w')
    a.puts(f)
    a.close()
    break
end
