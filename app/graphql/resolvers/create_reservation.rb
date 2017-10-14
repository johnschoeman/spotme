class Resolvers::CreateReservation < GraphQL::Function
  argument :spot_id, !types.Int
  argument :start_time, !Types::DateTimeType
  argument :end_time, !Types::DateTimeType

  type Types::ReservationType

  def call(obj, args, ctx)
    user = User.first
    reservation = Reservation.new(
      start_time: args[:start_time],
      end_time: args[:end_time],
      spot_id: args[:spot_id],
      user: user
      )
    if reservation.save
      return reservation
    else
      return GraphQL::ExecutionError.new("Invalid input: #{reservation.errors.full_messages.join(', ')}")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end

# user: ctx[:current_user]