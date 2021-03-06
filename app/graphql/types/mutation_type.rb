Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  
  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new
  
  field :createSpot, function: Resolvers::CreateSpot.new
  field :updateSpot, function: Resolvers::UpdateSpot.new
  field :deleteSpot, function: Resolvers::DeleteSpot.new
  
  field :getFBToken, function: Resolvers::GetFBToken.new
  field :createUserSocial, function: Resolvers::CreateUserSocial.new
  field :signInSocial, function: Resolvers::SignInSocial.new
  
  field :createReservation, function: Resolvers::CreateReservation.new
  field :updateReservation, function: Resolvers::UpdateReservation.new
  field :deleteReservation, function: Resolvers::DeleteReservation.new
end
