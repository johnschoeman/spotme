class Resolvers::CreateSpot < GraphQL::Function
  argument :latitude, !types.Float
  argument :longitude, !types.Float
  argument :title, types.String
  argument :image_url, types.String
  argument :rating, types.Float
  argument :price, types.Float
  argument :description, types.String

  type Types::SpotType

  def call(obj, args, ctx)
    Spot.create!(
      latitude: args[:latitude],
      longitude: args[:longitude],
      title: args[:title],
      image_url: args[:image_url],
      rating: args[:rating],
      price: args[:price],
      description: args[:description],
      user: ctx[:current_user]
    )
  end

end