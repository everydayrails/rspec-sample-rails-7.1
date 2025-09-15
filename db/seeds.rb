# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

["Entree", "Dessert", "Side dish", "Breakfast"].each do |name|
  Category.find_or_create_by!(name: name)
end

aaron = User.find_or_create_by!(email: "aaron@example.com") do |user|
  user.nickname = "aaron"
  user.password = "password"
end

turkey_tenderloin = aaron.recipes.find_or_create_by!(name: "Grilled turkey tenderloin") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = "Who says turkey is just for Thanksgiving? This recipe is perfect year-round."
  recipe.ingredients = <<~INGREDIENTS
    - Pack of two turkey tenderloins (serves four)
    - wood chunks or chips (I like mixing cherry and hickory or oak)
    - 1/4 cup olive oil
    - salt, pepper, and garlic powder to taste
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    #### Prep

    * soak wood chunks or chips for about an hour
    * light coat of oil (I use olive)
    * Rub
    * Refrigerate while starting the grill
    * Light 3/4 chimney
    * When just the top layer of coal is unlit, pour coal into one half of grill
    * Heat grill for about five minutes, then clean and coat with oil
    * Put wood chunks or foil packet of chips directly on coals

    #### Cook

    * Put meat on cool side of the grill, larger ends closest to the fire
    * Cover with vent over cool side of grill and cook for 15 minutes
    * Flip and cook for 15 additional minutes
    * take meat off, cover with foil, allow to rest
    * While the meat rests you can cook vegetables or other sides

    To serve, slice each tenderloin crossways.
  INSTRUCTIONS
end

turkey_tenderloin.photo.attach(io: File.open(Rails.root.join("sample-data/turkey-tenderloin.jpg")), filename: "turkey-tenderloin.jpg")

instant_pot_fritata = aaron.recipes.find_or_create_by!(name: "Instant Pot fritata") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = "A great, make-ahead breakfast or brunch option for busy people! Easy to modify for your dietary tastes."
  recipe.ingredients = <<~INGREDIENTS
    - 8 eggs
    - 1/2 cup milk
    - Salt and pepper just a sprinkle
    - 1/2 diced onion
    - 1/2 diced bell pepper
    - 1/3 cup shredded sharp cheddar cheese
    - 1 cup diced ham
    - (Any other toppings you like)
    - 1 cup water for your instant pot
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. Whisk the eggs in a large bowl then add the milk, salt pepper, onion, bell pepper, cheese, and ham.
    1. Spray your 7 inch instant pot pan with nonstick spray, then pour the egg mixture into it cover tightly with aluminum foil.
    1. Add the trivet and the water to your instant pot then the pan with the egg mixture on top of the trivet.
    1. Place the lid on, set your valve to sealing pressure cook on high pressure for 35 minutes with a 10 minute natural release.
  INSTRUCTIONS
end

instant_pot_fritata.photo.attach(io: File.open(Rails.root.join("sample-data/fritata.jpg")), filename: "fritata.jpg")

gabi = User.find_or_create_by!(email: "gabi@example.com") do |user|
  user.nickname = "gabi"
  user.password = "password"
end

gabi.recipes.find_or_create_by!(name: "Summer crab salad") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = ""
  recipe.ingredients = <<~INGREDIENTS
    - 1.5 - 2 lbs Roma tomatoes diced
    - 1/2 white onion diced in small pieces
    - 2 cloves of garlic minced or 2 teaspoons of minced garlic in oil
    - The juice of 2 large limes
    - 1 lb of flaky imitation crab cut in small pieces
    - 1 small Serrano pepper cut in small pieces (optional
    - Salt and olive oil to taste
    - A bunch of fresh cilantro chopped
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. In a large bowl, marinate the crab with olive oil, garlic, lime juice, salt and the Serrano pepper.
    2. Add the tomatoes and onion and mix together until well blended. Eat immediately or refrigerate. Serve garnished with the cilantro leaves.
  INSTRUCTIONS
end

austin = User.find_or_create_by!(email: "austin@example.com") do |user|
  user.nickname = "austin"
  user.password = "password"
end

austin.recipes.find_or_create_by!(name: "Sinigang") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = "It is a sour soup that is native in the Philippines. This recipe commonly uses pork as the main ingredient. But other proteins can be substituted like beef, fish and shrimp. It is paired with steamed rice when served."
  recipe.ingredients = <<~INGREDIENTS
    Main:
    - 1 kg (2.2 lbs) pork belly or pork ribs, cut into serving pieces
    - 1 large onion, quartered
    - 2 medium tomatoes, quartered
    - 1 eggplant, sliced diagonally
    - 1 radish (daikon), peeled and sliced diagonally
    - 3-4 pieces of okra, cut in half (Optional)
    - 2-3 pieces of gabi (taro root), peeled and quartered (Optional)
    - 1 bundle of sitaw (long beans), cut into 3-inch pieces
    - 1 bunch of kangkong (water spinach) or spinach
    - 2-3 pieces of siling haba (green finger chilies)

    Sour Agent:
    - 1 pack sinigang mix (tamarind powder) or
    - 1 cup fresh tamarind juice (from boiled tamarind pods) or
    - 1/2 cup tamarind paste

    Seasoning:
    - Fish sauce (patis) to taste
    - Salt to taste
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. Prepare the Meat:
      - In a large pot, add the pork and enough water to cover it.
      - Bring to a boil, then lower the heat and simmer for 45 minutes to 1 hour, until the meat is tender. Skim off any scum that rises to the top.

    2. Add Vegetables:
      - Add the onions and tomatoes to the pot, and cook until the tomatoes are soft.
      - Add the gabi, and simmer until its almost tender, about 10 minutes.

    3. Add the Sour Agent:
      - If using fresh tamarind, add the juice to the pot. If using sinigang mix, dissolve it in some of the hot broth before adding to the pot.
      - Adjust the sourness by adding more tamarind juice or mix to your liking.

    4. Final Ingredients:
      - Add the radish, eggplant, okra, and green chilies. Simmer until these vegetables are tender, about 5 minutes.
      - Add the spinach, long beans, and simmer for another 2 minutes.

    5. Seasoning:
      - Season with fish sauce, salt to taste. Adjust sourness if needed.

    6. Serve:
      - Serve hot with steamed rice.

    Share and enjoy!
  INSTRUCTIONS
end

ryan = User.find_or_create_by!(email: "ryan@example.com") do |user|
  user.nickname = "ryan"
  user.password = "password"
end

ryan.recipes.find_or_create_by!(name: "Stuffing") do |recipe|
  recipe.category = Category.find_by(name: "Side dish")
  recipe.description = ""
  recipe.ingredients = <<~INGREDIENTS
    - 8 Tbsp butter
    - 1 large onion diced (about one cup)
    - 2 stalks celery diced (about on cup)
    - 1 lb sweet Italian sausage
    - 1.5 to 2 cups chicken broth
    - 1 (12oz bag) Pepperidge Farm Herb Seasoned Cube Stuffing mix
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    Place stuffing mix in greased 2 qt casserole/baking dish
    Melt 3tbsp of bitter in pan and sauté diced onions and celery until tender and crisp, when
    done stir into stuffing mix. Remove sausage from casing and cook until done and stir into
    stuffing mix. Add remaining ingredients (melted butter and chicken broth) mix lightly.
    Bake @ 350 for 30 minutes uncovered for a nice crispy top.
    To make ahead cover pan and refrigerate for 1 day then bake for 40 minutes or until warmed
    through; leave uncovered for a crispy top.
  INSTRUCTIONS
end

evan = User.find_or_create_by!(email: "evan@example.com") do |user|
  user.nickname = "evan"
  user.password = "password"
end

evan.recipes.find_or_create_by!(name: "Evan's Foolproof Deep Dish Pizza") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = "Prep Time: 30 mins. to 50 mins.  | Cook Time: Ummm... a lot because deep dish | Difficulty: Medium  | Servings: 8"
  recipe.ingredients = <<~INGREDIENTS
    CRUST
    - 4 cups King Arthur Unbleached All-Purpose Flour
    - 3 tablespoons yellow cornmeal
    - 1 3/4 teaspoons salt
    - 2 3/4 teaspoons instant yeast
    - 2 tablespoons olive oil
    - 4 tablespoons butter, melted
    - 2 tablespoons vegetable oil or salad oil
    - 1 1/4 to 1 2/3 cup water

    FILLING
    - 1 pound Italian sweet or hot sausage, cooked and sliced; or about 3 cups of the sautéed vegetables of your choice
    - 8 oz pepperoni
    - 1 large onion
    - 1 yellow pepper
    - 1 lb. mozzarella cheese, shredded
    - 2-3 cups Evan's Pomodoro
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    This is an application of [Serious Eats Foolproof Pan Pizza](https://www.seriouseats.com/foolproof-pan-pizza-recipe) to [King Arthur Flour's Deep Dish](https://www.kingarthurbaking.com/recipes/chicago-style-deep-dish-pizza-recipe) with my own ingredients to better resemble how I remember the original Pizzaria Uno's deep dish in Chicago (as opposed to the "pan pizza" they serve everywhere else.

    CRUST:
    - Mix the dough ingredients (but only add 1 cup of water!), and knead — by hand, mixer, or bread machine — to make a smooth crust. After the first few minutes, dough will resemble pie dough. Slowly add water until doigh softens to resemble bread dough and becomes sticky; dough needs to be just loose enough to rise. This will take about 7 minutes at medium-low speed in a stand mixer.
    - Place the dough in a lightly oiled bowl and let rise for 24 hours.
    - Grease it with EVOO, 3 to 4 tablespoons olive oil, tilting it to cover the bottom of the pan, and partway up the sides.
    - Lay the dough in a 14" cast iron pan and stretch it towards the edges until it starts to shrink back. Cover, and let it rest for 15 minutes. Start preheating the oven to 425°F while the dough rests.
    - Stretch the dough to cover the bottom of the pan, then gently push it up the sides of the pan. Remember, we're making a pizza PIE. The olive oil may ooze over the edge of the crust; that's OK. Let the crust rest for 15 minutes or so, as your oven comes up to 425°F.
    - Bake the crust for 10 minutes, until it's set and barely beginning to brown. While it's baking, prepare the filling.

    FILLING:
    - Cover the bottom of the crust with the sliced mozzarella, fanning it into the crust. Add the sausage (or sautéed vegetables), then the pomodoro.
    - Bake the pizza for about 30 minutes, or until the filling is bubbly and the topping is golden brown (which, really, is probably more like 45+ minutes...). Remove it from the oven, and carefully lift it out of the pan onto a rack. A giant spatula is a help here. Allow the pizza to cool for about 15 minutes (or longer, for less oozing) before cutting and serving.
  INSTRUCTIONS
end

evan.recipes.find_or_create_by!(name: "Evan's Pomodoro") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = "The Pom is pretty simple but always better than canned or jarred."
  recipe.ingredients = <<~INGREDIENTS
    - 2 14oz cans crushed tomatoes
    - 1 can tomato paste
    - 1/2 chopped onion
    - LOTS of granulated garlic or many many cloves of finely diced fresh
    - crushed oregano
    - crushed basil
    - 3 tbsp olive oil
    - 1 cup red wine (and, darn it, choose one that you enjoy drinking because it matters!)
    - salt
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. Oil goes in first.
    2. Sweat the onions at medium-low with some salt to draw out moisture.
    3. Add garlic and turn the heat to max, stirring. Brown but don't burn!
    4. 2-3 minutes later, add everything else.
    5. Lid until bubbling then dial back to med-low heat.
    6. Cook until desired texture.
    7. Remove from stove, store air tight.

    IMPORTANT: USE NO SOONER THAN THE NEXT DAY for maximum awesomeness.
  INSTRUCTIONS
end

noah = User.find_or_create_by!(email: "noah@example.com") do |user|
  user.nickname = "noah"
  user.password = "password"
end

noah.recipes.find_or_create_by!(name: "Care Bear Throw Up") do |recipe|
  recipe.category = Category.find_by(name: "Dessert")
  recipe.description = ""
  recipe.ingredients = <<~INGREDIENTS
    - 2 paper plates
    - 1/2 cup Froot Loops cereal
    - 2 cups whipped cream (freshly whipped or store-bought)
    - 1 can (8 oz) crushed pineapple
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. Place 1/2 cup Froot Loops between two paper plates. Gently crush the cereal using a rolling pin or the bottom of a heavy glass. The most effective approach is to place on floor and smash with foot. Aim for a mix of finely crushed and slightly larger pieces for texture variety. Too finely crushed and it turns the mixture into a purple-brown color that does not appeal to the human senses.
    2. Drain the crushed pineapple thoroughly, reserving the juice for another use if desired.
    3. In a large mixing bowl, gently fold together the whipped cream, crushed Froot Loops, and drained pineapple until well combined.
    4. Chill the mixture in the refrigerator for at least 30 minutes before serving.
    5. Serve cold in small bowls or dessert glasses. Optionally, garnish with a few whole Froot Loops on top for decoration.
  INSTRUCTIONS
end

john = User.find_or_create_by!(email: "john@example.com") do |user|
  user.nickname = "john"
  user.password = "password"
end

john.recipes.find_or_create_by!(name: "Homemade bacon") do |recipe|
  recipe.category = Category.find_by(name: "Entree")
  recipe.description = ""
  recipe.ingredients = <<~INGREDIENTS
    - 5 pounds of fresh pork belly
    - 2 ounces (1/4 cup Morton or Diamond Crystal coarse kosher) salt
    - 2 teaspoons pink curing salt #1
    - 4 tablespoons coarsely ground black pepper
    - 4 bay leaves, crumbled
    - 1 teaspoon freshly grated nutmeg
    - 1/4 cup brown sugar or honey or maple syrup (JP: 50/50 honey & molasses)
    - 5 cloves of garlic, smashed with the flat side of a chef's knife
    - 2 tablespoons juniper berries, lightly crushed
    - 5 to 10 sprigs fresh thyme (optional)
  INGREDIENTS
  recipe.instructions = <<~INSTRUCTIONS
    1. Mix the dry ingredients together in a small bowl.
    2. Spread the honey and/or molasses over the pork belly first. This is the glue for the dry rub.
    3. Put your belly in the zip-top bag or on a sheet tray or in a plastic container.  Rub the salt and spice mixture all over the belly.  Close the bag or cover it with plastic wrap, and stick it in the refrigerator for seven days (get your hands in there and give the spices another good rubbing around midway through).
    4. After seven days, take it out of the fridge, rinse off all the seasonings under cold water and pat it dry.
    5. Smoke at 225 degrees for 3-4 hours, watch internal temp and keep it between 150-160 degrees F range. Or Put it on a sheet tray and put it in the oven (put it on a rack on a sheet tray if you have one) and turn the oven on to 200 degrees F. Leave it in the oven for 90 minutes (or, if you want to measure the internal temperature, until it reaches 150 degrees F.).

    You can also, instead of roasting it or smoking, hang it to dry, in the manner of pancetta.

    JP Notes: I liked making it with skin on pork belly if you can find it. Don't cut the pork belly into too small of pieces, it tends to get too salty if you do. Go for like 2" thick strips or I like to do like 4"x4" pieces.
    INSTRUCTIONS
end

# Comments

User.all.each do |user|
  recipes = Recipe.order("RANDOM()").limit(rand(1..Recipe.count))

  recipes.each do |recipe|
    user.comments.create!(recipe: recipe, comment: "This looks delicious!")
  end
end
