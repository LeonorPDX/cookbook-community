class UsersController < ApplicationController

    before do
        require_login
    end
    
    get '/:slug' do
        @user = User.find_by_slug(params[:slug])
        @recipes = Recipe.all.select { |r| r.user_id == @user.id }
        @recipes = @recipes.sort_by{|r| r.name}
        erb :"users/show"
    end

    get '/:slug/cookbook' do
        @user = User.find_by_slug(params[:slug])
        @recipes = @user.recipes
        @recipes = @recipes.sort_by{|r| r.name}
        erb :"users/cookbook"
    end

    post '/cookbook/:id' do
        if params[:do_this] == "Add to my Cookbook"
            @recipe = Recipe.find(params[:id])
            current_user.recipes << @recipe
        elsif params[:do_this] == "Remove from my Cookbook"
            @saved_recipe = SavedRecipe.find_by(recipe_id: params[:id], user_id: current_user.id)
            @saved_recipe.delete
        end
        redirect "/#{current_user.slug}/cookbook"
    end

end