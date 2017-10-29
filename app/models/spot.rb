# == Schema Information
#
# Table name: spots
#
#  id                 :integer          not null, primary key
#  latitude           :float            not null
#  longitude          :float            not null
#  title              :string
#  image_url          :string
#  rating             :float
#  price              :float
#  description        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  street             :string
#  city               :string
#  state              :string
#  zip                :string
#  number             :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Spot < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_attached_file :image,
                    default_url: "http://res.cloudinary.com/dfafbqoxx/image/upload/v1506546644/blank_user_oltxpb.png"
                    # url: ":s3_us_west_url"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.all_available
    availableSpots = Spot.all.select { |spot| !spot.currently_reserved }
    Spot.where(id: availableSpots.map(&:id))
  end

  def currently_reserved
    reservations = self.reservations
    reservations.any? { |reservation| Time.now().between?(reservation.start_time, reservation.end_time)}
  end
end
