require 'rubygems'
require 'mechanize'
require 'nokogiri'       
require 'json'  
agent = Mechanize.new
pages = []
url = "http://food-app-thenightsaredarkandfullofterrors.c9users.io:8080/items/"
items_url = "http://food-app-thenightsaredarkandfullofterrors.c9users.io:8080/items?page="

a = Mechanize.new
page = 1
items = {}
links = File.readlines('item_links_notdone')
#d = a.get(url+.to_s+'/item_images')

links.each_with_index do |link,index|
  if link.include?'http'
    id, link = link.split(', ')
    agen = Mechanize.new
    page = agen.get(link)
    p 'Saving image for id '+ id.to_s   + ' index ' + index.to_s
    agen.page.save "item_images/#{id}-#{index}.jpg"
    a = Mechanize.new
    a.post(url+id.to_s+'/item_images/', {
            "image" => File.new("item_images/#{id}-#{index}.jpg")
    })
    p 'Uploaded image to item id '+ id.to_s  + ' index ' + index.to_s
    File.delete("item_images/#{id}-#{index}.jpg")
    p 'Deleting Image  id ' + id.to_s + ' index ' + index.to_s
    links[index]=nil
    a = File.open('item_links_notdone', 'w')
    a.puts(links)
    a.close()
  end
end

=begin
  # p images.first.values[1].save
   break

   #5.times do |index| 
        p 'saving image to ' + name +  '.jpg'
        agent.get(images.first.attributes["src"]).save "item_images/#{name}.jpg"
        a = Mechanize.new
        a.post(url+id.to_s+'/item_images/', {
                "image" => File.new("item_images/#{name}.jpg")
        })
        p 'Uploaded image to item id '+ id.to_s 
        File.delete("item_images/#{name}.jpg")
        p 'Deleting Image ' + name
        images.shift
   #end

   break
=end

