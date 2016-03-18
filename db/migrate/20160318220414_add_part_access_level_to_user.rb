class AddPartAccessLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :part_access_level, :integer, :default => 1
  end
end
