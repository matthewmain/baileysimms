class AddPartInfoToPost < ActiveRecord::Migration
  def change
    add_column :posts, :book_part, :integer
  end
end
