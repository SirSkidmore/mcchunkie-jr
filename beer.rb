class BeerPlugin < Plugin

  def self.brewdb(beer)
    beer_result = query_beer(beer)

    if beer_result[0].is_a?(Array)
      brew_info = beer_result[0]
      beer_info = beer_result[1]
      self.send_message("""
#{brew_info[0]} (#{brew_info[1]} - #{brew_info[2]}) : #{beer_info[0]} (ABV: #{beer_info[1]})
""")
      self.send_message("#{beer_info[2]}...")
    else
      self.send_message("#{beer_info[0]} (ABV: #{beer_info[1]})")
      self.send_message("#{beer_info[2]}...")
    end
  end

  def self.query_beer(beer)
    parsed_beer = beer.gsub(' ', '%20')
    uri_string = "http://api.brewerydb.com/v2/search?q=#{parsed_beer}&type=beer&withBreweries=Y&key=#{ENV['BREWERY_DB']}"

    open(uri_string) do |f|
      res = JSON.parse(f.read)
      if res["status"] == "success"
        beer_res = res["data"][0]
        if beer_res["breweries"]
          brewer = beer_res["breweries"][0]
          bname = brewer["name"]
          byear = brewer["established"]
          bsite = brewer["website"]
        end

        name = beer_res["name"]
        abv = beer_res["abv"]
        desc = beer_res["description"][0...444]
      else
        "No beers found"
      end

      if brewer
        [[bname, byear, bsite], [name, abv, desc]]
      else
        [name, abv, desc]
      end
    end
  end
end
