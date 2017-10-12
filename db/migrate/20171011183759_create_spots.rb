class CreateSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :spots do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :title
      t.string :image_url
      t.float :rating
      t.float :price
      t.string :description

      t.timestamps
    end

    add_index :spots, [:latitude, :longitude]
  end
end
