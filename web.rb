require 'sinatra'
require 'json'
require 'net/http'
require 'open-uri'

require_relative 'plugin'
require_relative 'beer'
require_relative 'csi'
require_relative 'high_five'
require_relative 'markov'
require_relative 'pew'
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
  case 
  when msg =~ /\\o|o\//
    puts msg
    Hi5Plugin.high_five(msg)
  when msg =~ /^!weather/
    loc = msg.downcase.gsub(/[^a-z0-9\s]/, '').split[1..-1]
    WeatherPlugin.weather_report(loc)
  when msg =~ /^\!beer/
    beer = msg.split[1..-1].join(" ")
    BeerPlugin.brewdb(beer)
  when msg =~ /^!sherlock/
    word = msg.split[1] || nil
    MarkovGen::MarkovPlugin.sherlock(word)
  when msg =~ /^!wiki/
    search = msg.split[1..-1].join(" ")
    WikiPlugin.wiki(search)
  when msg =~ /csi/i
    CSIPlugin.yeah
  when msg =~ /pew/i
    PewPlugin.pew
  when msg =~ /mcchunkie/i && msg =~ /\b(hey|hi|yo|sup)\b/i
    PleasentryPlugin.greetings(name)
  when msg =~ /mcchunkie/i && msg =~ /\b(bye|cya|bai)\b/i
    PleasentryPlugin.goodbye(name)
  when msg =~ /mcchunkie/i && msg =~ /\b(thanks|thnx|thank you|thanx)\b/i
    PleasentryPlugin.thanks(name)
  end
end



