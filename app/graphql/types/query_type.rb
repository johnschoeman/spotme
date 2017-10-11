Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allUsers, !types[Types::UserType] do
    resolve -> (obj, args, ctx) { User.all }
  end

  field :allSpots, !types[Types::SpotType] do
    resolve -> (obj, args, ctx) { Spot.all }
  end
end
