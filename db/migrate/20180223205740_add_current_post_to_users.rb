class AddCurrentPostToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_post, :integer, :default => 1


  end
end
