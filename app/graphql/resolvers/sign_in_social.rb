class Resolvers::SignInSocial < GraphQL::Function
  argument :email, !types.String
  
  type do
    name 'SigninSocialPayload'
    
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