require 'sinatra'
require 'json'
require 'net/http'
require 'open-uri'

require_relative 'plugin'
require_relative 'beer'
require_relative 'high_five'
require_relative 'markov'
require_relative 'weather'

set :server, "thin"

get '/' do
  "A GroupMe bot!"
end

post '/' do
  json = JSON.parse(request.body.read)
  puts json
  msg = json["text"]
  command(msg) unless json["name"] == "McChunkie"
end

def command(msg)
  case msg
  when /\\o|o\//
    puts msg
    Hi5Plugin.high_five(msg)
  when /^!weather/
    WeatherPlugin.weather_report("Auburn, IN")
  when /^\!beer/
    beer = msg.split[1..-1].join(" ")
    BeerPlugin.brewdb(beer)
  when /^!sherlock/
    word = msg.split[1] || nil
    MarkovGen::MarkovPlugin.sherlock(word)
  end
end



