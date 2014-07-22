class Plugin
  def self.send_message(msg)
    uri = URI('https://api.groupme.com/v3/bots/post')
    response_msg = {
      "text" => msg,
      "bot_id" => "b9b75ee8449c637a0097b652f0"
    }.to_json
    
    gm_http = Net::HTTP.new(uri.host, uri.port)
    gm_http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    req.body = response_msg
    response = gm_http.request(req)
    puts response.message
  end
end
