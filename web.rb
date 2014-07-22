require 'sinatra'
require 'json'
require 'net/http'
require 'open-uri'

require_relative 'plugin'
require_relative 'beer'
require_relative 'high_five'
require_relative 'markov'
require_relative 'pleasent'
require_relative 'weather'
require_relative 'wiki'

set :server, "thin"

get '/' do
  "A GroupMe bot!"
end

post '/' do
  json = JSON.parse(request.body.read)
  puts json
  name = json["name"] # because sometimes we want this
  msg = json["text"]
  command(msg, name) unless name == "McChunkie"
end

def command(msg, name)
  case msg
  when /\\o|o\//
    puts msg
    Hi5Plugin.high_five(msg)
  when /^!weather/
    loc = msg.downcase.gsub(/[^a-z0-9\s]/, '').split[1..-1]
    WeatherPlugin.weather_report(loc)
  when /^\!beer/
    beer = msg.split[1..-1].join(" ")
    BeerPlugin.brewdb(beer)
  when /^!sherlock/
    word = msg.split[1] || nil
    MarkovGen::MarkovPlugin.sherlock(word)
  when /^!wiki/
    search = msg.split[1..-1].join(" ")
    WikiPlugin.wiki(search)
  when /mcchunkie/i && /hey|hi/i
    PleasentryPlugin.greetings(name)
  end
end



