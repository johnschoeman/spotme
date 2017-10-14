class Resolvers::DeleteReservation < GraphQL::Function
  argument :reservationId, !types.Int

  type Types::ReservationType

  def call(obj, args, ctx)
    reservation = Reservation.find(args[:reservationId])
    reservation.destroy!
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid operation: #{e.record.full_messages.join(', ')}")
  end
end