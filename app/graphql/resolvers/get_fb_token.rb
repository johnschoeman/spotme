class Resolvers::GetFBToken < GraphQL::Function
  argument :authorization_code, !types.String
  argument :redirect_uri, !types.String

  type types.String

  def call(_obj, args, _ctx)
    request_id_token(args[:authorization_code], args[:redirect_uri])
  end

  def request_id_token(authorization_code, redirect_uri)
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
                      \"redirect_uri\": \"#{redirect_uri}\"}"
    
    response = http.request(request)
    puts response.read_body
    response.read_body.id_token
  end
end