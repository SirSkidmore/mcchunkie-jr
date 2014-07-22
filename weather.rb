class WeatherPlugin < Plugin
  def self.weather_report(location)
    open("http://api.wunderground.com/api/#{ENV['WEATHER_KEY']}/conditions/q/IN/Auburn.json") do |f|
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
end
