class Resolvers::CreateUser < GraphQL::Function
  argument :username, !types.String
  argument :email, !types.String
  argument :password, !types.String

  type Types::UserType

  def call(_obj, args, _ctx)
    User.create!(
      username: args[:username],
      email: args[:email],
      password: args[:password]
    )
  end
end