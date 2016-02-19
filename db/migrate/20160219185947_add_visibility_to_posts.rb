class AddVisibilityToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible_to_public, :boolean, :default => false
    add_column :posts, :visible_to_users, :boolean, :default => false
  end
end
