class AddAttachmentImageToSpots < ActiveRecord::Migration[5.1]
  def self.up
    change_table :spots do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :spots, :image
  end
end
