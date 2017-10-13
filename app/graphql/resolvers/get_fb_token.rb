class Resolvers::GetFBToken < GraphQL::Function
  argument :authorization_code, !types.String

  type types.String

  
  def call(_obj, args, _ctx)
    id_token = request_id_token(args[:authorization_code])
  end

  def request_id_token(authorization_code)
    url = URI("https://YOUR_AUTH0_DOMAIN/oauth/token")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"grant_type\":\"authorization_code\",
                      \"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",
                      \"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",
                      \"code\": \"#{authorization_code}\",
                      \"redirect_uri\": \"https://YOUR_APP/callback\"}"
    
    response = http.request(request)
    console.log(response.read_body)
  end
end