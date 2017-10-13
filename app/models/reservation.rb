# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  spot_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start_time :datetime         not null
#  end_time   :datetime         not null
#

class Reservation < ApplicationRecord
  validates :duration, :user_id, :spot_id, presence: true

  belongs_to :user 
  belongs_to :spot
end
