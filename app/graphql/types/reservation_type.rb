Types::ReservationType = GraphQL::ObjectType.define do
  name 'Reservation'

  field :id, !types.ID
  field :start_time, !Types::DateTimeType
  field :end_time, !Types::DateTimeType
  field :user, -> { !Types::UserType }
  field :spot, -> { !Types::SpotType }
  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
end