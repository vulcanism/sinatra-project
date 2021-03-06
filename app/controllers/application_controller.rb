require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'dragons'

    register Sinatra::Flash
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
    
    def valid_username?(username) # Checks if username is taken
      !User.find_by(:username => username) && !params[:username].empty?
    end

    def valid_book? # Checks if any book params are empty
      !params[:title].empty? && !params[:author].empty? && !params[:genre].empty? && !params[:summary].empty?
    end

  end

end
