class UpdateFbIDtype < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :fb_id
    add_column :users, :fb_id, :string
    add_index :users, :fb_id, unique: true
  end
end
