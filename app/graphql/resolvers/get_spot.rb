class Resolvers::GetSpot < GraphQL::Function
  argument :spot_id, !types.ID

  type Types::SpotType

  def call(obj, args, ctx) 
    spot = Spot.find(args[:spot_id])

    if spot
      return spot
    else
      return GraphQL::ExecutionError.new("Unable to find spot.")
    end
  end
end
