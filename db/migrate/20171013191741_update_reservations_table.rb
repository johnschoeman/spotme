class UpdateReservationsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :duration
    add_column :reservations, :start_time, :datetime, null: false
    add_column :reservations, :end_time, :datetime, null: false
  end
end
