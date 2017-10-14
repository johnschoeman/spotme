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
  validates :start_time, :end_time, :user_id, :spot_id, presence: true
  validate :start_time_must_come_before_end_time
  # validate :does_not_overlap_existing_reservation

  belongs_to :user 
  belongs_to :spot

  def start_time_must_come_before_end_time
    errors[:start_time] << 'must specify a start time' unless start_time
    errors[:end_time] << 'must specify an end time' unless end_time
    errors[:start_time] << 'must come before end time' if start_time > end_time
  end


end
