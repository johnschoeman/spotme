# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'http'

Spot.destroy_all
User.destroy_all
user_id = []
5.times do 
  user = User.create(email: Faker::Internet.email, password: 'password')
  user_id.push(user.id)
end 

# 20.times do
#   latitude = "37.#{(774929..800500).to_a.sample}".to_f
#   longitude = "-122.#{(399999..490027).to_a.sample}".to_f
#   Spot.create(latitude: latitude, 
#               longitude: longitude, 
#               user_id: user_id.sample, 
              # price: [1.50, 2.00, 2.50, 3.00].sample, 
              # rating: [3.50, 4.00, 4.50, 5.00].sample)
# end 

addresses = [
  "825 battery st, sf, ca",
  "160 spear st, sf, ca",
  "425 tehama st, sf, ca",
  "600 Montgomery St, sf, ca, 94111",
  "916 kearny st, sf, ca, 94133",
  "1 telegraph hill blvd, sf, ca, 94133",
  "1 Carlton B Goodlett Pl, sf, ca, 94102",
  "3301 Lyon St, sf, ca, 94123",
  "50 Hagiwara Tea Garden Dr, sf, ca, 94118",
  "400 Steiner St, SF, CA, 94117",
  "1 Ferry Building, sf, ca, 94111",
  "235 Montgomery st, sf, ca, 94104",
  "1111 Gough St, sf, ca, 94109",
  "2500 Steiner st, sf, ca, 94115",
  "760 Marker St, sf, ca, 94102",
  "555 California st, sf, ca, 94104",
  "140 new montgomery, sf ca",
  "999 california st, sf, ca, 94108",
  "870 market st, sf, ca, 94102",
  "1100 california st, sf, ca, 94108",
  "582 market st, sf, ca, 94104",
  "3321 16th st, sf, ca, 94114",
  "2 new montgomery st, sf, ca, 94105"
]

image_url = [
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105088/parking_spots/reserved.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105130/parking_spots/images.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105245/parking_spots/Residential-Driveway.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105258/parking_spots/CobblestonePaverDriveway-GettyImages-83116815-58f639a85f9b581d59e6d03b.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105270/parking_spots/Driveways-Concrete.jpg.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105330/parking_spots/6532b4d8e06e9ae0bd5c490b748a1368--driveway-landscaping-driveway-design.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105349/parking_spots/043a654887548a0016ed7d4cc39c2665.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105379/parking_spots/parking-spot-from-above-with-spots.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508105401/parking_spots/2015-03-27-19.39.37.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508118964/parking_spots/tandem.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119040/parking_spots/63_Woodstock_Ave._4.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119074/parking_spots/oddest-parking-spot-in-denver-495x371.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119092/parking_spots/downtown-690827_1920.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119123/parking_spots/Homepage_Find_a_Spot_section2.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119140/parking_spots/article-2184174-005AF28B00000258-584_468x269.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119170/parking_spots/IMG_0404-1024x683.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119194/parking_spots/hell-angels.jpg",
  "https://res.cloudinary.com/dekgrddbo/image/upload/v1508119281/parking_spots/iStock_000012218495_Large-1.jpg"
]

def create_spot(args, user_id, image_url)
  address_response = request_address(args[:address])
  address_hash = parse_address_response(address_response)
  Spot.create!(
    latitude: address_hash[:latitude],
    longitude: address_hash[:longitude],
    title: args[:title],
    image_url: image_url.sample,
    rating: [3.50, 4.00, 4.50, 5.00].sample,
    price: [1.50, 2.00, 2.50, 3.00].sample,
    description: args[:description],
    number: address_hash[:number],
    street: address_hash[:street],
    city: address_hash[:city],
    state: address_hash[:state],
    zip: address_hash[:zip],
    user_id: user_id.sample
    )
  end

  def request_address(address)
    address = address.gsub(/\s+/, '+')
    HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['GOOGLE_MAPS_API_KEY']}")
  end

  def parse_address_response(address_response)
    address_hash = {}
    parsed_response = address_response.parse["results"][0]
    address_hash[:latitude] = parsed_response["geometry"]["location"]["lat"]
    address_hash[:longitude] = parsed_response["geometry"]["location"]["lng"]
    address_hash[:number] = get_address_component(parsed_response["address_components"], "street_number")
    address_hash[:street] = get_address_component(parsed_response["address_components"], "route")
    address_hash[:city] = get_address_component(parsed_response["address_components"], "locality")
    address_hash[:state] = get_address_component(parsed_response["address_components"], "administrative_area_level_1")
    address_hash[:zip] = get_address_component(parsed_response["address_components"], "postal_code")
    address_hash
  end

  def get_address_component(components, type)
    component = components.find do |component|
      component["types"].include?(type)
    end
    type == 'locality' ? component['long_name'] : component["short_name"]
  end

  addresses.each do |address|
    create_spot({address: address}, user_id, image_url)
  end