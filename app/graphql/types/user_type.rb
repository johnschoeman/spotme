# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  avatar_url      :string
#  fb_name         :string
#  fb_id           :string
#  email           :string           not null
#

Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, !types.ID
  field :username, !types.String
  field :session_token, !types.String
  field :avatar_url, types.String
  field :fb_name, types.String
  field :fb_id, types.String
  field :email, !types.String
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  field :spots, -> { types[Types::SpotType] }
end