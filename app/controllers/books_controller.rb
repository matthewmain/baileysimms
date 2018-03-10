# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BooksController < ApplicationController

  def index
    @books = Book.all
    store_location
  end
  
end

