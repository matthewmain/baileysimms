class AddGoodreadsIdToParts < ActiveRecord::Migration
  def change
    add_column :parts, :goodreads_id, :string
  end
end
