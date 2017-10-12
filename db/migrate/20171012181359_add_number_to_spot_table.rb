class AddNumberToSpotTable < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :number, :string
  end
end
