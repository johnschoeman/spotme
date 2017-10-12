class Resolvers::UpdateSpot < GraphQL::Function
  argument :spotId, !types.Int

  argument :latitude, types.Float
  argument :longitude, types.Float
  argument :title, types.String
  argument :image_url, types.String
  argument :rating, types.Float
  argument :price, types.Float
  argument :description, types.String

  type Types::SpotType

  def call(obj, args, ctx)
    spot = Spot.find(args[:spotId])
    if ctx[:current_user] == spot.user
      params = args.to_h
      params.delete("spotId")
      spot.update(
        params
      )
      return spot
    else
      GraphQL::ExecutionError.new("You are not authorized to update this spot")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end