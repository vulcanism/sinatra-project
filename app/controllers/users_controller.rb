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
        
    end

    

end