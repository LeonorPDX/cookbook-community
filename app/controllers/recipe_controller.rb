  
class RecipesController < ApplicationController
    
    get '/recipes' do
        require_login
        @recipes = Recipe.all
        erb :"recipes/index"
    end
            
    get '/recipes/new' do
        require_login
        erb :"recipes/new"
    end

    post '/recipes' do
        @recipe = Recipe.new(:name => params["name"], :ingredients => params["ingredients"], :directions => params["directions"], :type_tag => params["type_tag"])
        @recipe.user_id = current_user.id
        
        if @recipe.save
            current_user.recipes << @recipe
            redirect "/recipes/#{@recipe.id}"
        else
            flash[:message] = "All fields are required. Please input name, ingredients, directions and select a type."
            redirect "/recipes/new"
        end
    end

    get '/recipes/:id' do
        require_login
        @recipe = Recipe.find_by(id: params[:id])
        if @recipe
            @user = User.find(@recipe.user_id)
            erb :"recipes/show"
        else
            redirect "/recipes"
        end
    end

    delete '/recipes/:id' do
        @recipe = Recipe.find(params[:id])

        if @recipe.user_id == current_user.id
            @recipe.delete
            redirect "/recipes"
        end
    end

    get '/recipes/:id/edit' do
        require_login
        @recipe = Recipe.find(params[:id])
        @user = User.find(@recipe.user_id)
        if @recipe.user_id == current_user.id
            erb :"recipes/edit"
        else
            redirect "/recipes/#{@recipe.id}"
        end
    end

    patch '/recipes/:id' do
        @recipe = Recipe.find(params[:id])

        if @recipe.user_id == current_user.id
            @recipe.name = params[:name]
            @recipe.ingredients = params[:ingredients]
            @recipe.directions = params[:directions]
            @recipe.type_tag = params[:type_tag]

            if @recipe.save
                redirect "/recipes/#{@recipe.id}"
            else
                flash[:message] = "All fields are required. Please input name, ingredients and directions."
                redirect "/recipes/#{@recipe.id}/edit"
            end
        end
    end
end