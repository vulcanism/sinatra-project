require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'dragons'
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
    
    def valid_username? # Check to ensure username isn't already taken

    end

  end

end
