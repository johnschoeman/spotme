Types::AddressType = GraphQL::InputObjectType.define do
  name 'ADDRESS_TYPE'

  argument :number, types.String
  argument :street, types.String
  argument :city, types.String
  argument :state, types.String
  argument :zip, types.String
end