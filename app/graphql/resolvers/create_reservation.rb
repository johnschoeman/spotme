class Resolvers::CreateReservation < GraphQL::Function
  argument :spot_id, !types.Int
  argument :start_time, !Types::DateTimeType
  argument :end_time, !Types::DateTimeType

  type Types::ReservationType

  def call(obj, args, ctx)
    Reservation.create!(
      start_time: args[:start_time],
      end_time: args[:end_time],
      spot_id: args[:spot_id],
      user: ctx[:current_user]
      )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end
