class Resolvers::GetUser < GraphQL::Function
  argument :user_id, !types.Int
  
    type Types::UserType
  
    def call(obj, args, ctx) 
      user = User.find(args[:user_id])
  
      if user
        return user
      else
        return GraphQL::ExecutionError.new("Unable to find user.")
      end
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
    end
end