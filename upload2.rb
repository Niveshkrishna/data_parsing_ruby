require 'rubygems'
require 'mechanize'
require 'nokogiri'       
require 'json'  
agent = Mechanize.new
pages = []
url = "http://food-app-thenightsaredarkandfullofterrors.c9users.io:8080/items/"
items_url = "http://food-app-thenightsaredarkandfullofterrors.c9users.io:8080/items?page="

a = Mechanize.new
page = 232
items = {}
while page >100
    b = a.get(items_url+page.to_s)
    b = JSON.parse(b.body)
    b.each do |c|   
        if c["id"] >= 1
        items[c["id"]] = c["recipe_id"]
        end
    end
    page -= 1
end


items.each do |item,recipe|
   ingredients = []
   i = agent.get(url+item.to_s+'/recipes/'+recipe.to_s+'/ingredients/')
   i = JSON.parse(i.body)
   i.each do|x|
    if x["image_url"] == nil 
    ingredients << x["id"]
    end
   end
   ingredients.each do|ingredient|
        page = agent.get(url+item.to_s+'/recipes/'+recipe.to_s+'/ingredients/'+ingredient.to_s)
        ing = JSON.parse(page.body)
        if ing["not_found"] 
            p 'Not Found for id '+ingredient.to_s
            
        else
            p 'Found for item ' + item.to_s + ' recipe ' + recipe.to_s + ' id ' + ingredient.to_s
            goo = 'https://www.google.co.in/search?q=' + ing["content"] + '&source=lnms&tbm=isch'
            img = agent.get(goo)
            images = img.search("img")
            
            p 'saving image to '+ ing["content"]+'.jpg'
            agent.get(images.first.attributes["src"]).save "images2/#{ing["content"]}.jpg"
            a = Mechanize.new
            name = ing["content"]
            a.post(url+item.to_s+'/recipes/'+recipe.to_s+'/ingredients/'+ingredient.to_s, {
                "image" => File.new("images2/#{name}.jpg")
            })
            p 'Uploaded item to '+ item.to_s + ' recipe ' + recipe.to_s + ' id ' + ing["id"].to_s
            File.delete("images2/#{name}.jpg")
            p 'Deleting Image ' + name
        end
    end
   
end
=begin
           
=end
