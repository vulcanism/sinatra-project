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

    post "/books/new" do
        if valid_book?
            @book=Book.new(params)
            @book.user = current_user
            @book.save
            redirect "/books/#{book.id}"
        else
            redirect "/books/new"
        end    
    end

end