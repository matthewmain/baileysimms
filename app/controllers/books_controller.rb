class BooksController < ApplicationController

  def index
    @books = Book.all
    @omit_footer = true
  end
  
end

