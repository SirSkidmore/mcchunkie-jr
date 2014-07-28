class Plugin
  def self.send_message(msg)
    uri = URI('https://api.groupme.com/v3/bots/post')
    response_msg = {
      "text" => msg,
      "bot_id" => ENV['BOT_ID']
    }.to_json
    
    gm_http = Net::HTTP.new(uri.host, uri.port)
    gm_http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    req.body = response_msg
    
    # Make McChunkie wait to avoid clients mixing up
    # order of messages.
    sleep(1)
    response = gm_http.request(req)
    puts response.message
  end
end
