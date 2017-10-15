class Resolvers::CreateUserSocial < GraphQL::Function
  argument :email, !types.String
  argument :avatar_url, types.String
  argument :username, types.String

  type Types::UserType

  def call(_obj, args, _ctx)
    user = User.find_by(email: args[:email])
    if !user
      password = SecureRandom.urlsafe_base64
      User.create!(
        username: args[:username],
        email: args[:email],
        avatar_url: args[:avatar_url],
        password: password
      )
    else
      user
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end