class CreateCrons < ActiveRecord::Migration
  def change
    create_table :crons do |t|
      t.string :name
      t.text :data_hash

      t.timestamps null: false
    end
  end
end
