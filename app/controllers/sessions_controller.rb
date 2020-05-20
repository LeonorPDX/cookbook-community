class SessionsController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :"sessions/signup"
        else
          redirect "/recipes"
        end
    end
    
    post '/signup' do
        user = User.new(params)
        
        if user.save
            session[:user_id] = user.id
            redirect "/recipes"
        else
            user.errors.full_messages.each {|m| flash[:message] = m}
            redirect "/signup"
        end
    end

    get '/login' do
        if !logged_in?
            erb :"sessions/login"
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
            flash[:message] = "Unable to log in, please try again or click \"Sign Up\" below if you need to create an account."
	        redirect "/login"
		end
    end
    
    get '/logout' do
        session.destroy
        redirect "/"
    end

end
