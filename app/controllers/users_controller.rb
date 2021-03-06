class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"/users/signup"
        else
            redirect "/home"
        end
    end

    post "/signup" do
        if valid_username?(params[:username]) && !params[:email].empty? && !params[:password].empty?
            @user = User.new(params)
            @user.save
            session[:user_id] = @user.id
            redirect "/home"
        else
            redirect "/signup"
        end
    end

    get "/login" do
        if logged_in?
            redirect "/home"
        else
            erb :"/users/login"
        end
    end

    post "/login" do
        @user = User.find_by(:username => params[:username])        

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/home"            
        else
            flash[:error] = "Username or password is invalid, please try again."
            redirect "/login"
        end    
    end
    
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/collection"
    end
    
    get "/logout" do
        session.clear
        redirect "/"
    end
    
end