require 'sinatra'

get '/' do
  "A group me bot!"
end

post '/' do
  puts params
end
