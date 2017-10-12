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
  field :address_number, types.String, property: :number
  field :address_street, types.String, property: :street
  field :address_city, types.String, property: :city
  field :address_state, types.String, property: :state
  field :address_zip, types.String, property: :zip

  field :hostedBy, -> { Types::UserType }, property: :user
end