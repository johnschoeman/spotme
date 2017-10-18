class Resolvers::GetReservation < GraphQL::Function
  argument :reservation_id, !types.Int

  type Types::ReservationType

  def call(obj, args, ctx) 
    reservation = Reservation.find(args[:reservation_id])

    if reservation
      return reservation
    else
      return GraphQL::ExecutionError.new("Unable to find reservation.")
    end
  end
end
