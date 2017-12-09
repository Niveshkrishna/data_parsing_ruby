require 'aylien_text_api'
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'json'
page_num = 11
url = 'https://en.wikibooks.org/w/index.php?title=Category:Recipes&pagefrom=Southwestern+Dip%0ASouthwestern+Dip#mw-pages'
agent = Mechanize.new
loop do
page = agent.get(url)
recipe_links = page.links.select{|link| link.href.to_s.include?('/wiki/Cookbook:')}
recipes = []
r = 1
recipe_links.each do |link|
   new_page = agent.get(link.href)
    if new_page.css('#Ingredients').to_s != '' and new_page.css('#Procedure').to_s != ''
        ingred = new_page.css('.mw-parser-output').css('ul li').map{|ing| ing.text.strip}
        ingredients = []
        ingred.each do |ing|
            ing = ing.split(" ")
            if ing[0].to_i != 0
                quantity = ing.shift
                if i[0] != nil
                    if ing[0][0] == '('
                        quantity += ing.shift
                    end
                end
            end
            if ing[0].downcase == "gm" || ing[0].downcase == "cup" || ing[0].downcase == "ml" || ing[0].downcase == "tbsp" || ing[0].downcase == "tsp" || ing[0].downcase == "kg" || ing[0].downcase == "tbsp," || ing[0].downcase == "tbs" || ing[0].downcase == "ltr" || ing[0].downcase == "scoops" || ing[0].downcase == "tbsp." || ing[0].downcase == "tbsp "|| ing[0].downcase == "cups" || ing[0].downcase == "teaspoon" || ing[0].downcase == "tablespoons" || ing[0].downcase == "tablespoon" || ing[0].downcase == "teaspoons" || ing[0].downcase == "gms" || ing[0].downcase == "grams" || ing[0].downcase == "bowl"  || ing[0].downcase == "tsp." || ing[0].downcase == "gram" || ing[0].downcase == "pieces" || ing[0].downcase == "g"  || ing[0].downcase == "litre"   
                quantity_type = ing.shift
            end                
            ing = ing.join(" ")
            ingredients.push('content'=> ing,'quantity'=>quantity,'quantity_type'=>quantity_type)
        end
       instructions  = new_page.css('ol li').map{|ins| ins.text.strip}
       recipe_name = new_page.css('.mw-body .firstHeading').text.split(':')[1]
       category,serves,cook_time = page.css('.infobox td').children.map{|inf| inf.text}
       recipes << {'name': recipe_name,'category': category,'ingredients': ingredients,'instructions': instructions,'cook_time': cook_time,'serves': serves}
        p 'Recipe from page '+page_num.to_s+' recipe '+r.to_s
    end
end
a = File.open('recipes-#{page_num}.json','w+')
page_num += 1
a.write(recipes.to_json)
a.close()
url = page.link_with(:text => 'next page')
if url == nil 
    break
end
end
=begin 
 ul.each do |ing|
            quantity = ''
            ing = ing.split(" ")
            if ing[0].to_i != 0
                quantity = ing[0].to_s
                ing.shift
            end
            p ing.join(" "), quantity;
            #p quantity#, ' ', quantity_type, ' ', ing
            #p ''

         end   
              ing = []
        ul.each do |ing|
          if ing != "Recipes"
            ing = ing.split(" ")
            if ing[0].to_i != 0 or ing[0].to_r != 0
              q = ing[0]
              ing.shift
            end
            if ing[0].include?('tsp') || ing[0].include?('cup') || ing[0].include?('TBS') || ing[0].include?('spoon') || ing[0].include?('pound') || ing[0].include?('TBS') || ing[0] == 'ml' || ing[0] == 'g'  || ing[0] == 'l' || ing[0].include?('Ounces')
                qt = ing[0]
                ing.shift
                if ing[0][0]=='('
                  q += ing.shift
                end
              end 
            
            ing.push("content": ing.join(" ").capitalize, "quantity": q, "qunatity_type": qt)
        
          else
            break
            end
        end
        ing.each do |c|
          p c
        end
        
    end
end
=end
