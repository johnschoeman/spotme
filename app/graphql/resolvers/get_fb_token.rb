<<<<<<< HEAD
=======
class FBResponse 
  attr_accessor :id_token
end

>>>>>>> 23db76df49c7deb20555fa2df622a20b90ef9b98
class Resolvers::GetFBToken < GraphQL::Function
  argument :authorization_code, !types.String
  argument :redirect_uri, !types.String

<<<<<<< HEAD
  type types.String

  def call(_obj, args, _ctx)
    request_id_token(args[:authorization_code], args[:redirect_uri])
  end

  def request_id_token(authorization_code, redirect_uri)
    url = URI("https://YOUR_AUTH0_DOMAIN/oauth/token")
=======
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
>>>>>>> 23db76df49c7deb20555fa2df622a20b90ef9b98
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
<<<<<<< HEAD
    request.body = "{\"grant_type\":\"authorization_code\",
                      \"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",
                      \"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",
                      \"code\": \"#{authorization_code}\",
                      \"redirect_uri\": \"#{redirect_uri}\"}"
    
    response = http.request(request)
    puts response.read_body
    response.read_body.id_token
  end
end
=======
    request.body = "{\"grant_type\":\"authorization_code\",\"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",\"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",\"code\": \"#{authorization_code}\",\"redirect_uri\": \"#{redirect_uri}\"}"
    
    response = http.request(request)
    response
  end
end
>>>>>>> 23db76df49c7deb20555fa2df622a20b90ef9b98
