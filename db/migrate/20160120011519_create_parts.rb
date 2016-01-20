class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :book_id
      t.integer :part_number
      t.string :title

      t.timestamps null: false
    end
  end
end
