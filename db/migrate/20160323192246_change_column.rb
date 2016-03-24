class ChangeColumn < ActiveRecord::Migration
  def change
  	rename_column :users, :part_access_level, :share_count
  end
end
