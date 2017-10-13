class AddAddressColumnsToSpots < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :street, :string
    add_column :spots, :city, :string
    add_column :spots, :state, :string
    add_column :spots, :zip, :string
  end
end
