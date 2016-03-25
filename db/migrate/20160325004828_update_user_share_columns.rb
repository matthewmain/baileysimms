class UpdateUserShareColumns < ActiveRecord::Migration
  def change
  	remove_column :users, :has_shared_book_1, :boolean
  	remove_column :users, :has_shared_book_2, :boolean
  	rename_column :users, :has_shared_part_1, :can_access_AU_1
  	rename_column :users, :has_shared_part_2, :can_access_part_2
  	rename_column :users, :has_shared_part_3, :can_access_part_3
  	rename_column :users, :has_shared_part_4, :can_access_part_4
  	rename_column :users, :has_shared_part_5, :can_access_part_5
  	rename_column :users, :has_shared_part_6, :can_access_part_6
  	rename_column :users, :has_shared_part_7, :can_access_part_7
  	rename_column :users, :has_shared_part_8, :can_access_part_8
  	rename_column :users, :has_shared_part_9, :can_access_part_9
  	rename_column :users, :has_shared_part_10, :can_access_part_10
  	rename_column :users, :has_shared_part_11, :can_access_part_11
  	rename_column :users, :has_shared_part_12, :can_access_part_12
  	rename_column :users, :has_shared_part_13, :can_access_part_13
  	rename_column :users, :has_shared_part_14, :can_access_part_14
  end
end
