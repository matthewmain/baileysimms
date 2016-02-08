class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :part_number
      t.string :title
      t.text :content

      t.integer :book_id
      
      t.timestamps null: false
    end
  end
end
