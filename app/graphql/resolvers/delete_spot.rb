class Resolvers::DeleteSpot < GraphQL::Function
  argument :spotId, !types.Int

  type Types::SpotType

  def call(obj, args, ctx)
    spot = Spot.find(args[:spotId])
    spot.destroy!
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end