class Resolvers::CreateSpot < GraphQL::Function
  argument :title, types.String
  argument :image_url, types.String
  argument :rating, types.Float
  argument :price, types.Float
  argument :description, types.String

  argument :address, !types.String

  type Types::SpotType

  def call(obj, args, ctx)
    user = User.first
    # address = args[:address] ? args[:address] : {}
    address_response = request_address(args[:address])
    address_hash = parse_address_response(address_response)
    Spot.create!(
      latitude: address_hash[:latitude],
      longitude: address_hash[:longitude],
      title: args[:title],
      image_url: args[:image_url],
      rating: args[:rating],
      price: args[:price],
      description: args[:description],
      number: address_hash[:number],
      street: address_hash[:street],
      city: address_hash[:city],
      state: address_hash[:state],
      zip: address_hash[:zip],
      user: user
      )
    end

    def request_address(address)
<<<<<<< HEAD
      address = address.gsub(' ', '+')
      HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV["GOOGLE_MAPS_API_KEY"]}")
=======
      address = address.gsub(/\s+/, '+')
      HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['GOOGLE_MAPS_API_KEY']}")
>>>>>>> 52fd953a7b3b8e0793e82e4b63194a1a6cc63d6a
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
      component["short_name"]
    end

end

  # user: ctx[:current_user]
# address: {
#   +    //       street: '1725 Tehama St',
#   +    //       city: 'San Francisco',
#   +    //       state: 'CA',
#   +    //       zip: '94112'
#   +    //     }
