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

  def address
    address_hash = {}
    address_hash["street"] = self.street
    address_hash["city"] = self.city
    address_hash["state"] = self.state
    address_hash["zip"] = self.zip
    # debugger
    return address_hash
  end

end
