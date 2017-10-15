# == Schema Information
#
# Table name: spots
#
#  id          :integer          not null, primary key
#  latitude    :float            not null
#  longitude   :float            not null
#  title       :string
#  image_url   :string
#  rating      :float
#  price       :float
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  street      :string
#  city        :string
#  state       :string
#  zip         :string
#  number      :string
#

class Spot < ApplicationRecord
  belongs_to :user
  has_many :reservations

  def self.all_available
    availableSpots = Spot.all.select { |spot| !spot.currently_reserved }
    Spot.where(id: availableSpots.map(&:id))
  end

  def currently_reserved
    reservations = self.reservations
    reservations.any? { |reservation| Time.now().between?(reservation.start_time, reservation.end_time)}
  end
end
