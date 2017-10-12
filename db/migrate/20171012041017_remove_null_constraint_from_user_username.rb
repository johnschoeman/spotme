class RemoveNullConstraintFromUserUsername < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :username, :string, :null => true
  end
end
