class BooksController < ApplicationController

    get "/home" do
        if logged_in?
            @books = Book.all
            erb :"books/index"
        else
            redirect "/login"
        end
    end

    get "/books/new" do
        if logged_in?
            erb :"/books/new"
        else
            redirect "/login"
        end

    end

end