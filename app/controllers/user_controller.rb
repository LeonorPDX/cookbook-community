class UsersController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :"users/signup"
        else
          redirect "/recipes"
        end
    end
    
    post '/signup' do
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        
        if user.save
            session[:user_id] = user.id
            redirect "/recipes"
        else
            redirect "/signup"
        end
    end

    get '/login' do
        if !logged_in?
            erb :"users/login"
        else
          redirect "/recipes"
        end
    end

    post '/login' do
		user = User.find_by(:username => params[:username])
	   
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect "/recipes"
		else
		  redirect "/"
		end
    end
    
    get '/logout' do
        if logged_in?
            session.destroy
            redirect "/login"
        else
            redirect "/"
        end
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

    get '/:slug/cookbook' do
        @user = User.find_by_slug(params[:slug])
        @recipes = @user.recipes
        erb :"users/cookbook"
    end
end
