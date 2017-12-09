require 'json'
recipes = Dir.entries('recipes')
recipes.each do |r|
    rec = File.read('recipes/' + r) 
    reci = JSON.parse(rec)
    reci.each do |r|
        @item = Item.create(name: r["name"], cuisine: r["category"])
        if @item.save
            @recipe = Recipe.create(name: r["name"], cook_time: r["cook_time"], item_id: @item.id, chef_id: 1, chef_name: 'Erwin Track')
            if @recipe.save
                @item.recipe_id = @recipe.id 
                @item.save
                r["ingredients"].each do |i|
                    @ing = Ingredient.create(content: i["content"].capitalize, recipe_id: @recipe.id, quantity: i['quantity'], quantity_type: i['quantity_type'])

                end
                r["instructions"].each do |i|
                        @ins = Instruction.create(content: i, recipe_id: @recipe.id)
                end
            end
        end
    end
end

