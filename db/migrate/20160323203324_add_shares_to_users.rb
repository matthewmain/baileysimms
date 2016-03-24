class AddSharesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_shared_website, :boolean, :default => false
    add_column :users, :has_shared_part_1, :boolean, :default => false
    add_column :users, :has_shared_part_2, :boolean, :default => false
    add_column :users, :has_shared_part_3, :boolean, :default => false
    add_column :users, :has_shared_part_4, :boolean, :default => false
    add_column :users, :has_shared_part_5, :boolean, :default => false
    add_column :users, :has_shared_part_6, :boolean, :default => false
    add_column :users, :has_shared_part_7, :boolean, :default => false
    add_column :users, :has_shared_part_8, :boolean, :default => false
    add_column :users, :has_shared_part_9, :boolean, :default => false
    add_column :users, :has_shared_part_10, :boolean, :default => false
    add_column :users, :has_shared_part_11, :boolean, :default => false
    add_column :users, :has_shared_part_12, :boolean, :default => false
    add_column :users, :has_shared_part_13, :boolean, :default => false
    add_column :users, :has_shared_part_14, :boolean, :default => false
    add_column :users, :has_shared_book_1, :boolean, :default => false
    add_column :users, :has_shared_book_2, :boolean, :default => false
  end
end
