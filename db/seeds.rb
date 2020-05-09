sophie = User.create(username: "Sophie", email: "st@test.ts", password: "Password")
john = User.create(username: "John", email: "jd@test.ts", password: "Password")
pie = Recipe.create(name: "Pumpkin Pie", user: sophie, ingredients: "Pumpkin, sugar and spice", directions: "Mix and bake", type_tag: "Dessert")
mac = Recipe.create(name: "Mac and Cheese", user: john, ingredients: "Noodles, milk and cheese", directions: "Make sauce and bake", type_tag: "Entree")

SavedRecipe.create(user: john, recipe: pie)
SavedRecipe.create(user: sophie, recipe: mac)