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

require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
