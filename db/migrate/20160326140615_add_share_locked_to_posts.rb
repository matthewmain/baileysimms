class AddShareLockedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :share_locked, :boolean, :default => true
  end
end
