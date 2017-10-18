Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allUsers, !types[Types::UserType] do
    resolve -> (obj, args, ctx) { User.all }
  end

  # field :allSpots, !types[Types::SpotType] do
  #   resolve -> (obj, args, ctx) { Spot.all }
  # end

  # field :getStop, !types[Types::SpotType] do
  #   argument :spotId, !types.Int
  #   resolve -> (obj, args, ctx) { 
  #     Spot.find(args[:spotId])
  #   }
  # end

  field :allSpots, function: Resolvers::SpotsSearch

  field :getSpot, function: Resolvers::GetSpot.new
  field :getUser, function: Resolvers::GetUser.new

  field :allReservations, function: Resolvers::ReservationsSearch
  field :getReservation, function: Resolvers::GetReservation.new
  
end
