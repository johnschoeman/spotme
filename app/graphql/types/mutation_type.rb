class Resolvers::SocialSignin < GraphQL::Function # Why does this have to be defined here?
  argument :email, !types.String
  
  type do
    name 'SocialSigninPayload'
    
    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    email = args[:email]
    returns unless email

    user = User.find_by email: email

    return unless user

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    ctx[:session][:token] = token

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end

Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  
  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new
  
  field :createSpot, function: Resolvers::CreateSpot.new
  field :updateSpot, function: Resolvers::UpdateSpot.new
  field :deleteSpot, function: Resolvers::DeleteSpot.new
  
  field :getFBToken, function: Resolvers::GetFBToken.new
  field :createUserSocial, function: Resolvers::CreateUserSocial.new
  field :signinUserSocial, function: Resolvers::SocialSignin.new
end
