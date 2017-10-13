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

look into OpenStruct:
```ruby
OpenStruct.new({
      user: user,
      token: token
    })
```

----

```ruby
  Parameters: {"query"=>"mutation GetFBTokenMutation($authorization_code: String!, $redirect_uri: String!) {\n  getFBToken(authorization_code: $authorization_code, redirect_uri: $redirect_uri) {\n    id_token\n    __typename\n  }\n}\n", "variables"=>{"authorizationCode"=>"oybRiV2t6DiCYx76", "redirectUri"=>"https://auth.expo.io/@john_schoeman/expo-auth0"}, "operationName"=>"GetFBTokenMutation", "graphql"=>{"query"=>"mutation GetFBTokenMutation($authorization_code: String!, $redirect_uri: String!) {\n  getFBToken(authorization_code: $authorization_code, redirect_uri: $redirect_uri) {\n    id_token\n    __typename\n  }\n}\n", "variables"=>{"authorizationCode"=>"oybRiV2t6DiCYx76", "redirectUri"=>"https://auth.expo.io/@john_schoeman/expo-auth0"}, "operationName"=>"GetFBTokenMutation"}}

[6, 15] in /Users/johnschoeman/workspace/appacademy/aa_flex/spotme/app/controllers/graphql_controller.rb
    6:     context = {
    7:       session: session,
    8:       current_user: current_user
    9:     }
   10:     debugger
=> 11:     result = SpotmeSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
   12:     render json: result
   13:   end
   14:
   15:   private
(byebug) query
"mutation GetFBTokenMutation($authorization_code: String!, $redirect_uri: String!) {\n  getFBToken(authorization_code: $authorization_code, redirect_uri: $redirect_uri){\n    id_token\n    __typename\n  }\n}\n"
(byebug) variables
<ActionController::Parameters {"authorizationCode"=>"oybRiV2t6DiCYx76", "redirectUri"=>"https://auth.expo.io/@john_schoeman/expo-auth0"} permitted: false>
(byebug) operation_name
"GetFBTokenMutation"
(byebug) context
{:session=>#<ActionDispatch::Request::Session:0x7ff636114d18 not yet loaded>, :current_user=>nil}
(byebug)

```

```ruby
<ActionController::Parameters {"authorization_code"=>"oybRiV2t6DiCYx76", "redirect_uri"=>"https://auth.expo.io/@john_schoeman/expo-auth0"} 
```

parameters passed into mutations from the front end in the variables hash must me in the same case as the arguments of the resolvers!


----

gql not being able to find a resolver you defined

this will not work:
```
graphql/resovers/sign_in_social.rb
NameError (uninitialized constant Resolvers::SocialSignin):
```
the name of the resolver must match the name of the file
```
graphql/resovers/sign_in_social.rb
NameError (uninitialized constant Resolvers::SignInSocial):
```
----

#<ActionDispatch::Request::Session:0x7fb3be4d4f30 not yet loaded>
(byebug) session[:token]
nil

----