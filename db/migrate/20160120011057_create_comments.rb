class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.datetime :date

      t.integer :post_id
      t.integer :user_id
      
      t.timestamps null: false
    end
    add_index :comments, [:user_id, :created_at]
  end
end
