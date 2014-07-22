class WikiPlugin < Plugin
  def self.wiki(search)
    search_slug = search.gsub(" ", "%20")
    
    # 450 - '...' - wiki url
    resp_length = 447 - "http://en.wikipedia.org/wiki/#{search_slug} :: ".length
      
    wiki_url = ["http://en.wikipedia.org/w/api.php?action=query",
                "&prop=extracts",
                "&exchars=#{resp_length}",
                "&format=json",
                "&exsectionformat=plain",
                "&redirects=",
                "&titles=#{search_slug}"].join("")
    user_agent = ['McChunkie-Jr-GroupMe/1.0 ',
                  '(github.com/SirSkidmore/mcchunkie-jr); ',
                  'taylor@taylorskidmore.com'].join("")
    open(wiki_url, "User-Agent" => user_agent) do |f|
      json_string = f.read
      parsed_json = JSON.parse(json_string)
      query = parsed_json["query"]["pages"]
      if query["-1"]
        send_message("Wikipeda entry not found")
      else
        page_id = query.keys.first
        desc = query[page_id]["extract"].gsub(/<\/?[^>.]*>/i, '')
       send_message ("""
http://en.wikipedia.org/wiki/#{search_slug} :: #{desc}...
""")
      end
    end
  end
end
