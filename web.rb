require 'sinatra'
require 'json'
require 'net/http'
require 'open-uri'

require_relative 'markov.rb'

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
  elsif msg["text"].match(/^\!beer/) && msg["name"] != "McChunkie"
    puts "looking for beer..."
    # this could be better
    beer = msg["text"].split[1..-1].join(" ")
    brewdb(beer)
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
  response = gm_http.request(req)
  puts response.message
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
    url = forecast['forecast_url']

    send_message("""
The current conditions in #{location} are #{conditions} with a temperature of #{temp}. For more information, visit #{url}
""")
  end
end

def brewdb(beer)
  parsed_beer = beer.gsub(' ', '%20')
  uri_string = "http://api.brewerydb.com/v2/search?q=#{parsed_beer}&type=beer&withBreweries=Y&key=38f1f0ddcac71318d250f675ca2166fd"
  
  open(uri_string) do |f|
    json_string = f.read
    parsed_json = JSON.parse(json_string)
    if parsed_json["status"] == "success"
      beer_res = parsed_json["data"][0]
      if beer_res["breweries"]
        brewery = beer_res["breweries"][0]
        bname = brewery["name"]
        byear = brewery["established"]
        bsite = brewery["website"]
      end
      name = beer_res["name"]
      abv = beer_res["abv"]
      desc = beer_res["description"][0...447]
      send_message("""
#{bname} - (#{byear} - #{bsite}) : #{name} (ABV: #{abv})
""")
      send_message("#{desc}...")
      puts "#{name} - #{abv}"
    else
      send_message("No beers found")
    end
  end
end
