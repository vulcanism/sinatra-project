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
            redirect "/books/#{@book.id}"
        else
            redirect "/books/new"
        end    
    end

    get "/books/:id" do
        if logged_in?
            @book = Book.find_by_id(params[:id])
            erb :"/books/show"
        else
            redirect "/login"
        end
    end

    get "/books/:id/edit" do
        if logged_in?
            @book = Book.find_by_id(params[:id])
            if @book && @book.user == current_user
                erb :"/books/edit"
            else
                redirect "/home"
            end
        else
            redirect "/login"
        end
    end

    patch "/books/:id" do
        @book=Book.find_by_id(params[:id])
        if valid_book?
            @book.update(title: params[:title], author: params[:author], genre: params[:genre], summary: params[:summary])
            redirect "/books/#{@book.id}"
        else
            flash[:error] = "Please ensure all parameters are filled in."
            redirect "/books/#{@book.id}/edit"
        end
    end

    delete "/books/:id/delete" do
        if logged_in?
            @book=Book.find_by_id(params[:id])
            if @book && @book.user == current_user
                @book.destroy
            end
            redirect "/home"
        else
            redirect "/login"
        end    
    end

end