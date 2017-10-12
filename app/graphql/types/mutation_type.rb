Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new

  field :createSpot, function: Resolvers::CreateSpot.new
  field :updateSpot, function: Resolvers::UpdateSpot.new
  field :deleteSpot, function: Resolvers::DeleteSpot.new
end
