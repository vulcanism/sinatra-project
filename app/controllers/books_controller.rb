class BooksController < ApplicationController

    get "/home" do
        if logged_in?
            @books = Book.all
            erb :"books/index"
        else
            redirect "/login"
        end
    end

end