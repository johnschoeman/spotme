Types::SpotType = GraphQL::ObjectType.define do
  name 'Spot'

  field :id, !types.ID
  field :latitude, !types.Float
  field :longitude, !types.Float
  field :title, types.String
  field :image_url, types.String
  field :rating, types.Float
  field :price, types.Float
  field :description, types.String

  field :hostedBy, -> { Types::UserType }, property: :user
end