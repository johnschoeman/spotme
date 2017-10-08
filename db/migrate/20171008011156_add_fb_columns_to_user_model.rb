class AddFbColumnsToUserModel < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :fb_id, :integer
    add_column :users, :fb_name, :string
    add_index :users, :fb_id, unique: true
  end
end
