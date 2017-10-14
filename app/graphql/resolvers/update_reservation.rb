class Resolvers::UpdateReservation < GraphQL::Function
  argument :reservationId, !types.Int

  argument :spot_id, !types.Int
  argument :start_time, !Types::DateTimeType
  argument :end_time, !Types::DateTimeType

  type Types::ReservationType

  def call(obj, args, ctx)
    reservation = Reservation.find(args[:reservationId])
    # if ctx[:current_user] == reservation.user
    if User.first == reservation.user
      params = args.to_h
      params.delete("reservationId")
      reservation.update(
        params
      )
      return reservation
    else
      GraphQL::ExecutionError.new("You are not authorized to update this reservation")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end