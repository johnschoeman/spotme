Types::ReservationType = GraphQL::ObjectType.define do
  name 'Reservation'

  field :id, !types.ID
  field :start_time, !types.????
  field :end_time, !types.????
  field :reserver, -> { Types::UserType }, property: :user
  field :spot, -> { Types::SpotType }, property: :spot
end