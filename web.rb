require 'sinatra'
require 'json'
require 'net/http'
require 'open-uri'

set :server, "thin"

get '/' do
  "A group me bot!"
end

post '/' do
  msg = JSON.parse(request.body.read || '{"text": "something is super broke}')
  puts msg["text"]
  if msg["text"].include?("o/") && msg["name"] != "McChunkie"
    salute(:left)
  elsif msg["text"].include?("\\o") && msg["name"] != "McChunkie"
    salute(:right)
  elsif msg["text"].start_with?("!weather") && msg["name"] != "McChunkie"
    weather_report("Auburn, IN")
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

def salute(direction)
  if direction == :left
    send_message("\\o")
  else
    send_message("o/")
  end
end

def weather_report(location)
  open('http://api.wunderground.com/api/3364b700f9c31c96/conditions/q/IN/Auburn.json') do |f|
    json_string = f.read
    parsed_json = JSON.parse(json_string)
    forecast = parsed_json['current_observation']
    location = forecast['display_location']['full']
    conditions = forecast['weather']
    temp = forecast['temperature_string']

    send_message("The current conditions in #{location} are #{conditions} with a temperature of #{temp}.")
  end
end
