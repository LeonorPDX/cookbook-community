require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash, :sweep => true
    set :session_secret, "cookbook_community_security"
  end

  get '/' do
    erb :homepage
  end


helpers do
  def logged_in?
		!!session[:user_id]
	end

	def current_user
		User.find(session[:user_id])
  end
  
  def require_login
    unless logged_in?
      redirect "/login"
    end
  end
end

end
