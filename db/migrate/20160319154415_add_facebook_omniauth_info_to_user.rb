class AddFacebookOmniauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :oauth_provider, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :facebook_id, :string
    add_column :users, :facebook_name, :string
    add_column :users, :facebook_image, :string
  end
end
