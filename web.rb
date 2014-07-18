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
  if msg["text"].include?("o/")
    salute()
  end
end

def send_message(msg)
  uri = URI('https://api.groupme.com/v3/bots/post')
  response_msg = {
    "text" => msg,
    "bot_id" => "e8298ce556883d910629969317"
  }.to_json
  
  gm_http = Net::HTTP.new(uri.host, uri.port)
  gm_http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
  req.body = response_msg
  gm_http.request(req)
end

def salute
  send_message("\o")
end

