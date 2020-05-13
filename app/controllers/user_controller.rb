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
        binding.pry
        
        if user.save
            session[:user_id] = user.id
            redirect "/recipes"
        else
            flash[:message] = "We were not able to create an account. The username may be in use, or you may already have an account with this email."
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
        session.destroy
        redirect "/"
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
end
