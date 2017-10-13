class AddUniqueToUserEmail < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, :unique => true
  end
end
