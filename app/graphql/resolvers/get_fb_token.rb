require 'uri'
require 'net/http'

class FBResponse 
  attr_accessor :id_token
end

class Resolvers::GetFBToken < GraphQL::Function
  argument :authorization_code, !types.String
  argument :redirect_uri, !types.String

  type Types::FBTokenType

  # type do
  #   name 'FBTokenType'
  #   field :id_token, types.String
  # end

  def call(_obj, args, _ctx)
    puts "############# start call"
    puts 'args[:authorization_code], args[:redirect_uri]: '
    puts args[:authorization_code]
    puts args[:redirect_uri]
    puts "---"
    response = request_id_token(args[:authorization_code], args[:redirect_uri])
    
    puts 'response in call: '
    puts response
    puts "---"
    id_token = JSON.parse(response.body)["id_token"]
    puts 'id token in call: '
    puts id_token
    puts "---"
    fb_response = FBResponse.new
    fb_response.id_token = id_token
    debugger
    # OpenStruct.new({
    #   id_token: id_token,
    # })
    puts "############# end call"
    fb_response

  end

  def request_id_token(authorization_code, redirect_uri)
    puts "############# start request_id_token"
    url = URI("https://spotme.auth0.com/oauth/token")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"grant_type\":\"authorization_code\",\"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",\"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",\"code\": \"#{authorization_code}\",\"redirect_uri\": \"#{redirect_uri}\"}"
    conosle.log('request: ', request)
    puts 'request.body: '
    puts request.body
    puts "---"
    response = http.request(request)
    puts 'response: '
    puts response
    puts "---"
    debugger
    puts "############# end request_id_token"
    response
  end
end
