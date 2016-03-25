class AddShareRecordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :share_record, :text
  end
end
