class Reservation < ApplicationRecord
  validates :duration, :user_id, :spot_id, presence: true

  belongs_to :user 
  belongs_to :spot
end
