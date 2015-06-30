class WeatherPlugin < Plugin
  def self.weather_report(location)
    if location.empty?
      loc_slug = "in/bloomington"
    elsif location[1]
      loc_slug = "#{location[1]}/#{location[0]}"
    else
      loc_slug = "#{location[0]}"
    end

    open("http://api.wunderground.com/api/#{ENV['WEATHER_KEY']}/conditions/q/#{loc_slug}.json") do |f|
      json_string = f.read
      parsed_json = JSON.parse(json_string)
      if parsed_json["response"]["results"]
        send_message("""
I found multiple results for '#{location.join(" ")}'. Please refine the search and try again
          """)
      else
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
  end
end
