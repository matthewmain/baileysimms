class ChangeSharesDefault < ActiveRecord::Migration
  def change
  	change_column :users, :share_count, :integer, :default => 0
  end
end
