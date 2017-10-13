class Resolvers::CreateReservation < GraphQL::Function
  argument :spot_id, types.Integer
  argument :start_time, types.????
  argument :end_time, types.????

  type Types::ReservationType

  def call(obj, args, ctx)
    Reservation.create!(
      start_time: args[:start_time]
      end_time: args[:end_time]
      spot_id: args[:spot_id]
      user: ctx[:current_user]
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
      component["short_name"]
    end

end


# address: {
#   +    //       street: '1725 Tehama St',
#   +    //       city: 'San Francisco',
#   +    //       state: 'CA',
#   +    //       zip: '94112'
#   +    //     }
