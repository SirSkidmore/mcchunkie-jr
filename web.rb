require 'sinatra'
require 'json'
require 'net/http'

set :server, "thin"

get '/' do
  "A group me bot!"
end

post '/' do
  msg = JSON.parse(request.body.read || '{"text": "something is super broke}')
  puts msg["text"]
  # repeat(msg["text"])
end

def repeat(msg)
  uri = URI('https://api.groupme.com/v3/bots/post')
  res_msg = {
    "text"   => msg,
    "bot_id" => "e8298ce556883d910629969317"
  }.to_json

  gm_http = Net::HTTP.new(uri.host, uri.port)
  gm_http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
  req.body = res_msg

  response = gm_http.request(req)
  puts response.body
end
