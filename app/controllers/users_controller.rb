class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"/users/signup"
        else
            redirect "/home"
        end
    end

    post "/signup" do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            @user = User.create(params)
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
        @user = User.find_by(:username == params[:username])
        if @user && user.authenticate(params[:password])
            session[:user_id] = @user_id
            redirect "/home"
        else
            redirect "/login"
        end    
    end   
    
    get "/logout" do
        session.clear
        redirect "/"
    end
    
end