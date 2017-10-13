## GraphQL Server Notes

### Questions

what does 
```ruby
has_secure_password
```
in the user model do and where does it come from?

----

```ruby
result = SpotmeSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
```
What is this doing? is this meta-progamming? can i find a way to get keys expressed in camelCase and not snake_case?

----

What is the best whay to implement dateTime with graphql server?

----

is there not a better way to input type arguments?  currently you need to write them in three different places.

---

How do you allow nested types in queries?

___ 
### Bugs

Do not forget to set the context of the gql server in the graphql controller.

----

using an update mutation: args is a weird object
[source code](https://github.com/rmosolgo/graphql-ruby/blob/master/lib/graphql/query/arguments.rb)
____ 

NoMethodError (undefined method `id' for true:TrueClass):

app/controllers/graphql_controller.rb:10:in `execute'

---

Defining Types is hard.
in your resolvers you must return a ruby object whose attributes match the return type of the resolver instance as dictated by 'type'
you may need to make your own class to accomplish this.

```ruby

class FBResponse 
  attr_accessor :id_token
end

class Resolvers::GetFBToken < GraphQL::Function
  argument :authorization_code, !types.String
  argument :redirect_uri, !types.String

  type Types::FBTokenType

  def call(_obj, args, _ctx)
    response = request_id_token(args[:authorization_code], args[:redirect_uri])
    id_token = JSON.parse(response.body)["id_token"]
    fb_response = FBResponse.new
    fb_response.id_token = id_token
    fb_response
  end

  def request_id_token(authorization_code, redirect_uri)
    url = URI("https://spotme.auth0.com/oauth/token")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"grant_type\":\"authorization_code\",\"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",\"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",\"code\": \"#{authorization_code}\",\"redirect_uri\": \"#{redirect_uri}\"}"
    
    response = http.request(request)
    response
  end
end
```

----
