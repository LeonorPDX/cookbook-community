class UsersController < ApplicationController

    before do
        require_login
    end
    
    get '/:slug' do
        @user = User.find_by_slug(params[:slug])
        @recipes = []
        Recipe.all.each do |r|
            if r.user_id == @user.id
                @recipes << r 
            end
        end
        erb :"users/show"
    end

    get '/:slug/cookbook' do
        @user = User.find_by_slug(params[:slug])
        @recipes = @user.recipes
        erb :"users/cookbook"
    end

    post '/add/:id' do
        @recipe = Recipe.find(params[:id])
        current_user.recipes << @recipe
        redirect "/#{current_user.slug}/cookbook"
    end

    post '/remove/:id' do
        @recipe = current_user.recipes.find(params[:id])
        @recipe.delete
        redirect "/#{current_user.slug}/cookbook"
    end
end