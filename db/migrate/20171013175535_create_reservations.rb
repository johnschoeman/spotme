class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.float :duration, null: false, default: (1000 * 60 * 60)
      t.integer :user_id, null: false 
      t.integer :spot_id, null: false
      t.timestamps
    end

    add_index :reservations, :user_id 
    add_index :reservations, :spot_id
  end
end
