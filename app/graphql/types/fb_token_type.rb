Types::FBTokenType = GraphQL::ObjectType.define do
  name 'FBTokenType'
  
  field :id_token, !types.String
end