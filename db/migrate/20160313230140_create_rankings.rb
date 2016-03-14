class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :name
      t.text :data_hash

      t.timestamps null: false
    end
  end
end
