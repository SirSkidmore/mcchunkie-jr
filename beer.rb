class BeerPlugin < Plugin
    
  def self.brewdb(beer)
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
        self.send_message("""
#{bname} - (#{byear} - #{bsite}) : #{name} (ABV: #{abv})
          """)
        self.send_message("#{desc}...")
        puts "#{name} - #{abv}"
      else
        self.send_message("No beers found")
      end
    end
  end
end
