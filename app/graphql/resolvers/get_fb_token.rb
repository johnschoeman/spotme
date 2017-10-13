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
    console.log("############# start call")
    console.log('args[:authorization_code], args[:redirect_uri]: ',args[:authorization_code], args[:redirect_uri])
    response = request_id_token(args[:authorization_code], args[:redirect_uri])
    
    console.log('response in call: ', response)
    id_token = JSON.parse(response.body)["id_token"]
    console.log('id token in call: ', id_token)
    fb_response = FBResponse.new
    fb_response.id_token = id_token
    debugger
    # OpenStruct.new({
    #   id_token: id_token,
    # })
    console.log("############# end call")
    fb_response

  end

  def request_id_token(authorization_code, redirect_uri)
    console.log("############# start request_id_token")
    url = URI("https://spotme.auth0.com/oauth/token")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"grant_type\":\"authorization_code\",\"client_id\": \"#{ENV["AUTH0_CLIENT_ID"]}\",\"client_secret\": \"#{ENV["AUTH0_CLIENT_SECRET"]}\",\"code\": \"#{authorization_code}\",\"redirect_uri\": \"#{redirect_uri}\"}"
    conosle.log('request: ', request)
    console.log('request.body: ', request.body)
    response = http.request(request)
    console.log('response: ', response)
    debugger
    console.log("############# end request_id_token")
    response
  end
end
