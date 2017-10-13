class Resolvers::CreateReservation < GraphQL::Function
  argument :spot_id, !types.Int
  argument :start_time, !Types::DateTimeType
  argument :end_time, !Types::DateTimeType

  type Types::ReservationType

  def call(obj, args, ctx)
    user = User.first
    Reservation.create!(
      start_time: args[:start_time],
      end_time: args[:end_time],
      spot_id: args[:spot_id],
      user: user
      )
    end
  end
  
  # user: ctx[:current_user],

# address: {
#   +    //       street: '1725 Tehama St',
#   +    //       city: 'San Francisco',
#   +    //       state: 'CA',
#   +    //       zip: '94112'
#   +    //     }
