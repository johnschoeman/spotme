class AddUserIdSpot < ActiveRecord::Migration[5.1]
  def change
    change_table :spots do |t|
      t.references :user, foreign_key: true
    end
  end
end