require 'rubygems'
require 'mechanize'
require 'nokogiri'       
require 'json'  
agent = Mechanize.new
pages = []
url = 'https://www.google.co.in/search?q='
ext = '&source=lnms&tbm=isch'
a = File.readlines('ing').each do|line|
  que = line.chomp.strip
  page = agent.get(url+que+ext)
  images = page.search("img")
  p 'saving image to '+ que+'.jpg'
  agent.get(images.first.attributes["src"]).save "images/#{que}.jpg"
  
  
end

=begin



page.links.each do |link|
   if link.to_s == "Image result for " + que
    p link.src
   end
end



while page_number <= 2
  page = agent.get(url+page_number.to_s)
   page.links.each do |link|
    pages << link
  end
  page_number += 1
end

items = []
pages.each do |x|
  items << x.inspect.to_s.split("\"")[3]
end
ing = []
items.each do |i|
 if i.match(/http:\/\/food.ndtv.com\/recipe-\S+/)
  agen = Mechanize.new
  recipe = agen.get(i)
  ing.push("name" =>  agen.page.css(".recp-det-cont h1").text, "ingredients" =>  agen.page.css(".ingredients ul li").map{|ing|  ing.text}, "instructions" =>  agen.page.css(".method ol li").map{|ins|  ins.text}, "info" => agen.page.css(".recipe-details ul li").map{|inf|  inf.text} )
 end

end
#ing.each do |key,value|
 # p key, ing[key]
#end
JSON.generate(ing).to_json
File.open('recipes', 'w') { |file| file.write(ing) }
=end
