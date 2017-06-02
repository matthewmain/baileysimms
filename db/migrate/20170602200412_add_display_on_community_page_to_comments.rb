class AddDisplayOnCommunityPageToComments < ActiveRecord::Migration
  def change
    add_column :comments, :display_on_community_page, :boolean, :default => true
  end
end
